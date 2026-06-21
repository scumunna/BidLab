import { describe, it, expect } from 'vitest'
import {
  SeededRandom,
  normalCDF,
  Auction,
  Scoring,
  Pricing,
  Probability,
  ReachFrequency,
  Analytics,
  Systems,
  BudgetAllocation,
  ResponseCurve,
  Attribution,
  Yield,
  Tracking,
  Pacing,
  MarketConfig,
  runMarket,
  runPacedFlight,
  SCENARIOS,
  OPPORTUNITIES,
  BUDGET_CAP,
  SEED,
  scenarioValue,
} from '../engine'

// 100-scenario acceptance suite for the BidLab web engine — the math-true core
// behind every explorable. Each `it` is one realistic scenario checked by a
// golden value (pinned to the native Swift engine), a mathematical invariant, or
// an edge case. Deterministic and reproducible: `npm test`.

const RETAIL = SCENARIOS[0]
const VALUE = scenarioValue(RETAIL) // 1.00
const cfg = (bid: number, auction: 'firstPrice' | 'secondPrice' = 'firstPrice', budget = BUDGET_CAP) =>
  new MarketConfig({
    opportunities: OPPORTUNITIES,
    bid,
    budget,
    marketMean: RETAIL.marketMean,
    floor: RETAIL.floor,
    ctr: RETAIL.ctr,
    cvr: RETAIL.cvr,
    revenuePerConversion: RETAIL.revenuePerConversion,
    model: { kind: 'logNormal', sigma: RETAIL.marketSigma },
    auction,
  })

describe('A · Seeded RNG & determinism', () => {
  it('S001 SplitMix64 reproduces the native RNG stream for the shared seed', () => {
    expect(new SeededRandom(SEED).unitDouble()).toBeCloseTo(0.91975247300727148, 12)
  })
  it('S002 the same seed yields identical sequences (reproducible runs)', () => {
    const a = new SeededRandom(SEED), b = new SeededRandom(SEED)
    expect(Array.from({ length: 5 }, () => a.unitDouble())).toEqual(Array.from({ length: 5 }, () => b.unitDouble()))
  })
  it('S003 every draw lands in [0, 1)', () => {
    const r = new SeededRandom(7n)
    for (let i = 0; i < 2000; i++) { const u = r.unitDouble(); expect(u).toBeGreaterThanOrEqual(0); expect(u).toBeLessThan(1) }
  })
})

describe('B · Auction mechanics', () => {
  it('S004 first-price winner pays its own bid', () => {
    const o = Auction.firstPrice(0.8, 1, [0.5]); expect(o.won).toBe(true); expect(o.pricePaid).toBe(0.8); expect(o.profit).toBeCloseTo(0.2, 12)
  })
  it('S005 a bid at or below the market loses', () => {
    expect(Auction.firstPrice(0.4, 1, [0.5]).won).toBe(false)
  })
  it('S006 second-price winner pays the clearing price, not its bid', () => {
    const o = Auction.secondPrice(0.9, 1, [0.5]); expect(o.won).toBe(true); expect(o.pricePaid).toBe(0.5); expect(o.profit).toBeCloseTo(0.5, 12)
  })
  it('S007 clearing price is the highest competing bid', () => {
    expect(Auction.clearingPrice([0.2, 0.7, 0.4])).toBe(0.7)
  })
  it('S008 expected profit equals win-probability times surplus', () => {
    expect(Auction.expectedProfit(0.4, 1, () => 0.5)).toBeCloseTo(0.3, 12)
  })
  it('S009 the optimal first-price bid maximizes the expected-profit curve', () => {
    const wp = (b: number) => 1 - Math.exp(-b / 0.45)
    const opt = Auction.optimalFirstPriceBid(VALUE, wp, 4000)
    for (const b of [0.1, 0.3, 0.5, 0.7, 0.9]) expect(opt.expectedProfit + 1e-9).toBeGreaterThanOrEqual(Auction.expectedProfit(b, VALUE, wp))
  })
  it('S010 bid shading is a fraction in [0,1] of the value', () => {
    expect(Auction.shadeFactor(0.8, 1)).toBeCloseTo(0.2, 12); expect(Auction.shadeFactor(1, 1)).toBe(0)
  })
})

describe('C · Market simulation', () => {
  it('S011 win probability is a probability (0..1)', () => {
    for (const b of [0.01, 0.2, 0.5, 1, 5]) { const p = cfg(b).winProbability(b); expect(p).toBeGreaterThanOrEqual(0); expect(p).toBeLessThanOrEqual(1) }
  })
  it('S012 win probability rises monotonically with the bid', () => {
    const c = cfg(0.5); let prev = -1
    for (const b of [0.21, 0.3, 0.45, 0.6, 0.9]) { const p = c.winProbability(b); expect(p).toBeGreaterThan(prev); prev = p }
  })
  it('S013 a bid below the publisher floor never clears the reserve', () => {
    expect(cfg(0.1).winProbability(0.1)).toBe(0)
  })
  it('S014 expected profit is zero below the floor', () => {
    expect(cfg(0.1).expectedProfitPerOpportunity(0.1)).toBe(0)
  })
  it('S015 the analytic optimum bids inside (0, value]', () => {
    const opt = cfg(0.3).optimal(); expect(opt.bid).toBeGreaterThan(0); expect(opt.bid).toBeLessThanOrEqual(VALUE + 1e-9)
  })
  it('S016 a seeded 50k run is fully deterministic', () => {
    const a = runMarket(cfg(0.3), SEED), b = runMarket(cfg(0.3), SEED)
    expect(a.impressionsWon).toBe(b.impressionsWon); expect(a.spend).toBe(b.spend)
  })
  it('S017 retail first-price at $0.30 matches the native engine exactly', () => {
    const r = runMarket(cfg(0.3), SEED); expect(r.impressionsWon).toBe(14448); expect(r.conversions).toBe(19)
  })
  it('S018 accounting identity: won + lostToFloor + lostToCompetition = opportunities', () => {
    const r = runMarket(cfg(0.3), SEED); expect(r.impressionsWon + r.lostToFloor + r.lostToCompetition).toBe(OPPORTUNITIES)
  })
  it('S019 second-price never pays more than first-price for the same bid', () => {
    expect(runMarket(cfg(0.3, 'secondPrice'), SEED).spend).toBeLessThanOrEqual(runMarket(cfg(0.3, 'firstPrice'), SEED).spend + 1e-9)
  })
  it('S020 a higher bid realizes a higher win rate', () => {
    expect(runMarket(cfg(0.6), SEED).winRate).toBeGreaterThan(runMarket(cfg(0.3), SEED).winRate)
  })
  it('S021 a binding budget caps total spend', () => {
    const r = runMarket(cfg(0.5, 'firstPrice', 1000), SEED); expect(r.spend).toBeLessThanOrEqual(1000)
  })
  it('S022 value per impression = CTR x CVR x revenue per conversion', () => {
    expect(cfg(0.3).valuePerImpression).toBeCloseTo(RETAIL.ctr * RETAIL.cvr * RETAIL.revenuePerConversion, 12)
  })
})

describe('D · Scoring', () => {
  it('S023 optimal play scores 100', () => { expect(Scoring.score(0.5, 0.5)).toBe(100) })
  it('S024 breaking even against a positive optimum scores 0', () => { expect(Scoring.score(0, 0.5)).toBe(0) })
  it('S025 a loss scores 0', () => { expect(Scoring.score(-1, 0.5)).toBe(0) })
  it('S026 non-negative profit against a zero optimum scores 100', () => { expect(Scoring.score(0, 0)).toBe(100) })
  it('S027 percentile rank is the share of the field below the value', () => {
    expect(Scoring.percentile(50, [10, 20, 60, 80])).toBeCloseTo(50, 9)
  })
})

describe('E · Pricing conversions', () => {
  it('S028 CPC derives from CPM and CTR', () => { expect(Pricing.cpc(8, 0.008)).toBeCloseTo(1, 12) })
  it('S029 CPA derives from CPC and CVR', () => { expect(Pricing.cpa(1, 0.05)).toBeCloseTo(20, 12) })
  it('S030 eCPM and CPC are inverse round-trips', () => { expect(Pricing.eCPMFromCPC(Pricing.cpc(8, 0.008), 0.008)).toBeCloseTo(8, 9) })
  it('S031 ROAS is revenue over spend', () => { expect(Pricing.roas(3000, 1000)).toBeCloseTo(3, 12) })
  it('S032 ROAS is infinite at zero spend (no divide-by-zero)', () => { expect(Pricing.roas(100, 0)).toBe(Infinity) })
  it('S033 CPC is infinite at zero CTR', () => { expect(Pricing.cpc(8, 0)).toBe(Infinity) })
  it('S034 CPA is infinite at zero CVR', () => { expect(Pricing.cpa(1, 0)).toBe(Infinity) })
  it('S035 impressions bought = spend / CPM x 1000', () => { expect(Pricing.impressions(1000, 8)).toBeCloseTo(125000, 6) })
  it('S036 spend and impressions are inverse round-trips', () => { expect(Pricing.spend(Pricing.impressions(1000, 8), 8)).toBeCloseTo(1000, 6) })
  it('S037 a healthy LTV:CAC of 3:1 computes', () => { expect(Pricing.ltvToCac(300, 100)).toBeCloseTo(3, 12) })
})

describe('F · Reach & frequency', () => {
  const P = 1_000_000
  it('S038 unique reach never exceeds the population', () => { expect(ReachFrequency.reach(P, 5_000_000)).toBeLessThanOrEqual(P) })
  it('S039 reach rises monotonically with impressions', () => {
    let prev = -1; for (const i of [0, 5e5, 1e6, 2e6, 3e6]) { const r = ReachFrequency.reach(P, i); expect(r).toBeGreaterThanOrEqual(prev); prev = r }
  })
  it('S040 reach fraction is in [0,1]', () => { const f = ReachFrequency.reachFraction(P, 2e6); expect(f).toBeGreaterThanOrEqual(0); expect(f).toBeLessThanOrEqual(1) })
  it('S041 reach at impressions=population matches the native engine (63.2%)', () => { expect(ReachFrequency.reachFraction(P, P)).toBeCloseTo(0.6321205588285576, 9) })
  it('S042 average frequency among reached people is at least 1', () => { expect(ReachFrequency.averageFrequency(P, 2e6)).toBeGreaterThanOrEqual(1) })
  it('S043 effective reach (2+) is a subset of unique reach', () => { expect(ReachFrequency.effectiveReach(P, 2e6, 2)).toBeLessThanOrEqual(ReachFrequency.reach(P, 2e6) + 1) })
  it('S044 effective reach (3+) is a subset of (2+)', () => { expect(ReachFrequency.effectiveReach(P, 2e6, 3)).toBeLessThanOrEqual(ReachFrequency.effectiveReach(P, 2e6, 2) + 1) })
  it('S045 reach is zero with no audience', () => { expect(ReachFrequency.reach(0, 1e6)).toBe(0) })
})

describe('G · Probability', () => {
  it('S046 the standard normal CDF is 0.5 at the mean', () => { expect(normalCDF(0)).toBeCloseTo(0.5, 6) })
  it('S047 the normal CDF is symmetric: F(z) + F(-z) = 1', () => { expect(normalCDF(1.3) + normalCDF(-1.3)).toBeCloseTo(1, 6) })
  it('S048 the inverse normal CDF gives the 97.5th percentile z (1.95996)', () => { expect(Probability.normalQuantile(0.975)).toBeCloseTo(1.959963986120195, 9) })
  it('S049 quantile is the inverse of the CDF (round-trip)', () => { expect(normalCDF(Probability.normalQuantile(0.8))).toBeCloseTo(0.8, 4) })
  it('S050 Poisson P(X=0) equals e^(-lambda)', () => { expect(Probability.poissonPMF(0, 1.5)).toBeCloseTo(Math.exp(-1.5), 10) })
  it('S051 the Poisson pmf sums to ~1 over its support', () => {
    let s = 0; for (let k = 0; k < 60; k++) s += Probability.poissonPMF(k, 3.2); expect(s).toBeCloseTo(1, 6)
  })
  it('S052 log-gamma satisfies lgamma(5) = ln(4!)', () => { expect(Probability.lgamma(5)).toBeCloseTo(Math.log(24), 9) })
  it('S053 the normal density peaks at 1/sqrt(2*pi)', () => { expect(Probability.normalPDF(0)).toBeCloseTo(1 / Math.sqrt(2 * Math.PI), 12) })
})

describe('H · Analytics & experiment design', () => {
  it('S054 detecting a smaller lift requires a larger sample', () => {
    expect(Analytics.sampleSizePerArm(0.1, 0.02)).toBeGreaterThan(Analytics.sampleSizePerArm(0.1, 0.04))
  })
  it('S055 the computed sample size reaches the target power', () => {
    const n = Analytics.sampleSizePerArm(0.05, 0.01); expect(Analytics.power(0.05, 0.01, n)).toBeGreaterThanOrEqual(0.79)
  })
  it('S056 power increases with sample size', () => {
    expect(Analytics.power(0.05, 0.01, 20000)).toBeGreaterThan(Analytics.power(0.05, 0.01, 5000))
  })
  it('S057 required sample size matches the native engine exactly (8,158/arm)', () => {
    expect(Analytics.sampleSizePerArm(0.05, 0.01)).toBe(8158)
  })
  it('S058 OLS recovers a known line y = 2x + 1 exactly', () => {
    const fit = Analytics.linearFit([0, 1, 2, 3], [1, 3, 5, 7]); expect(fit.slope).toBeCloseTo(2, 9); expect(fit.intercept).toBeCloseTo(1, 9); expect(fit.r2).toBeCloseTo(1, 9)
  })
  it('S059 adstock decays a pulse geometrically', () => {
    expect(Analytics.adstock([100, 0, 0, 0], 0.5)).toEqual([100, 50, 25, 12.5])
  })
  it('S060 Hill saturation is 0.5 at the half-saturation point', () => { expect(Analytics.hillSaturation(50, 50, 1)).toBeCloseTo(0.5, 9) })
  it('S061 statistical power is a probability (0..1)', () => { const p = Analytics.power(0.05, 0.01, 10000); expect(p).toBeGreaterThan(0); expect(p).toBeLessThanOrEqual(1) })
})

describe('I · DSP systems & latency', () => {
  it('S062 the p99 latency tail is longer than the median', () => { expect(Systems.latencyQuantile(40, 0.99)).toBeGreaterThan(Systems.latencyQuantile(40, 0.5)) })
  it('S063 timeout loss equals e^(-timeout/mean)', () => { expect(Systems.timeoutLossRate(40, 100)).toBeCloseTo(Math.exp(-100 / 40), 12) })
  it('S064 a longer timeout drops fewer bids', () => { expect(Systems.timeoutLossRate(40, 150)).toBeLessThan(Systems.timeoutLossRate(40, 100)) })
  it('S065 latency quantiles match the native engine (p50 27.7ms, p99 184.2ms)', () => {
    expect(Systems.latencyQuantile(40, 0.5)).toBeCloseTo(27.725887, 4); expect(Systems.latencyQuantile(40, 0.99)).toBeCloseTo(184.206807, 4)
  })
  it('S066 throughput capacity = workers x 1000 / service time', () => { expect(Systems.capacityQPS(20, 5)).toBe(4000) })
  it('S067 utilization is offered load over capacity', () => { expect(Systems.utilization(2000, 4000)).toBeCloseTo(0.5, 12) })
  it('S068 an M/M/1 queue is saturated (infinite wait) when arrivals meet service rate', () => {
    expect(Systems.mm1ResponseTimeMs(200, 5)).toBe(Infinity) // service rate = 200/s
  })
  it('S069 an underloaded queue has a finite, positive response time', () => {
    const t = Systems.mm1ResponseTimeMs(100, 5); expect(t).toBeGreaterThan(0); expect(Number.isFinite(t)).toBe(true)
  })
})

describe('J · Budget allocation', () => {
  const channels = [new ResponseCurve(1000, 30_000), new ResponseCurve(700, 20_000), new ResponseCurve(1400, 60_000)]
  it('S070 the allocation sums to the full budget', () => {
    expect(BudgetAllocation.allocate(100_000, channels).reduce((a, b) => a + b, 0)).toBeCloseTo(100_000, 6)
  })
  it('S071 equimarginal allocation beats an even split', () => {
    const opt = BudgetAllocation.totalResponse(BudgetAllocation.allocate(100_000, channels), channels)
    const even = BudgetAllocation.totalResponse(channels.map(() => 100_000 / 3), channels)
    expect(opt).toBeGreaterThan(even)
  })
  it('S072 a response curve never exceeds its saturation ceiling', () => { const c = new ResponseCurve(1000, 30_000); expect(c.response(1e9)).toBeLessThanOrEqual(1000); expect(c.response(50_000)).toBeGreaterThan(0) })
  it('S073 response rises monotonically with spend', () => {
    const c = new ResponseCurve(1000, 30_000); expect(c.response(40_000)).toBeGreaterThan(c.response(20_000))
  })
  it('S074 marginal return strictly diminishes', () => {
    const c = new ResponseCurve(1000, 30_000); expect(c.marginal(40_000)).toBeLessThan(c.marginal(20_000))
  })
  it('S075 the allocation matches the native engine ($32,850 / $22,900 / $44,250)', () => {
    const a = BudgetAllocation.allocate(100_000, channels); expect(a[0]).toBeCloseTo(32850, 6); expect(a[1]).toBeCloseTo(22900, 6); expect(a[2]).toBeCloseTo(44250, 6)
  })
  it('S076 zero budget allocates nothing', () => { expect(BudgetAllocation.allocate(0, channels)).toEqual([0, 0, 0]) })
})

describe('K · Attribution', () => {
  it('S077 last-touch gives all credit to the final touch', () => { expect(Attribution.lastTouch(4)).toEqual([0, 0, 0, 1]) })
  it('S078 first-touch gives all credit to the first touch', () => { expect(Attribution.firstTouch(4)).toEqual([1, 0, 0, 0]) })
  it('S079 linear splits credit evenly and sums to 1', () => {
    const v = Attribution.linear(4); v.forEach((c) => expect(c).toBeCloseTo(0.25, 12)); expect(v.reduce((a, b) => a + b, 0)).toBeCloseTo(1, 12)
  })
  it('S080 position-based is U-shaped (0.4 / 0.1 / 0.1 / 0.4)', () => {
    const v = Attribution.positionBased(4); expect(v[0]).toBeCloseTo(0.4, 12); expect(v[3]).toBeCloseTo(0.4, 12); expect(v[1]).toBeCloseTo(0.1, 9)
  })
  it('S081 position-based with two touches splits 50/50', () => { expect(Attribution.positionBased(2)).toEqual([0.5, 0.5]) })
  it('S082 a single touch gets all the credit', () => { expect(Attribution.positionBased(1)).toEqual([1]) })
  it('S083 every model distributes exactly one conversion (sums to 1)', () => {
    for (const v of [Attribution.lastTouch(4), Attribution.firstTouch(4), Attribution.linear(4), Attribution.positionBased(4)]) expect(v.reduce((a, b) => a + b, 0)).toBeCloseTo(1, 9)
  })
})

describe('L · Yield & floors', () => {
  it('S084 fill rate is a probability that falls as the floor rises', () => {
    expect(Yield.fillRate(4, 5)).toBeLessThan(Yield.fillRate(4, 2)); expect(Yield.fillRate(4, 2)).toBeLessThanOrEqual(1)
  })
  it('S085 a zero floor fills all demand', () => { expect(Yield.fillRate(4, 0)).toBeCloseTo(1, 12) })
  it('S086 publisher revenue peaks when the floor equals mean demand', () => {
    const at = Yield.revenue(20e6, 4, Yield.optimalFloor(4)); expect(at).toBeGreaterThan(Yield.revenue(20e6, 4, 3)); expect(at).toBeGreaterThan(Yield.revenue(20e6, 4, 5))
  })
  it('S087 the yield-maximizing floor equals mean demand CPM', () => { expect(Yield.optimalFloor(4)).toBe(4) })
  it('S088 revenue matches the native engine (~$24,261 at avails 20M, demand 4, floor 2)', () => { expect(Yield.revenue(20e6, 4, 2)).toBeCloseTo(24261, 0) })
  it('S089 filled impressions never exceed avails', () => { expect(Yield.filledImpressions(20e6, 4, 2)).toBeLessThanOrEqual(20e6) })
})

describe('M · Conversion tracking (pixels)', () => {
  it('S090 capture rate is client over back-end (920/1000 = 92%)', () => { expect(Tracking.captureRate(920, 1000)).toBeCloseTo(0.92, 12) })
  it('S091 leakage is the complement of capture', () => { expect(Tracking.leakage(920, 1000)).toBeCloseTo(0.08, 12) })
  it('S092 capture rate is zero with no back-end count (no divide-by-zero)', () => { expect(Tracking.captureRate(100, 0)).toBe(0) })
  it('S093 20% unmatched ids inflate the deduped total to 1,200', () => { expect(Tracking.dedupedTotal(1000, 0.2)).toBeCloseTo(1200, 9) })
  it('S094 dedup inflation is clamped to [0,1]', () => { expect(Tracking.dedupInflation(1.5)).toBe(1); expect(Tracking.dedupInflation(-0.2)).toBe(0) })
  it('S095 discrepancy is measured against the reference (4.76%)', () => { expect(Tracking.discrepancy(1_050_000, 1_000_000)).toBeCloseTo(0.047619, 5) })
  it('S096 an over-counting pixel reads a negative discrepancy', () => { expect(Tracking.discrepancy(1000, 1400)).toBeCloseTo(-0.4, 9) })
  it('S097 the normal-drift band flags only gaps beyond ~10%', () => {
    expect(Tracking.withinNormalBand(0.0476)).toBe(true); expect(Tracking.withinNormalBand(0.1667)).toBe(false)
  })
})

describe('N · Pacing & paced flight', () => {
  it('S098 the on-pace target is linear in elapsed time and clamped to the budget', () => {
    expect(Pacing.targetSpend(1000, 0.5)).toBeCloseTo(500, 12); expect(Pacing.targetSpend(1000, 1.5)).toBe(1000); expect(Pacing.targetSpend(1000, -1)).toBe(0)
  })
  it('S099 the throttle speeds up when behind pace and slows when ahead', () => {
    expect(Pacing.throttle(100, 50)).toBeGreaterThan(1); expect(Pacing.throttle(100, 150)).toBeLessThan(1)
  })
  it('S100 a 12-interval paced flight matches the native engine and respects the budget', () => {
    const r = runPacedFlight(cfg(0.3), 7500, 12, SEED)
    expect(r.points.length).toBe(12)
    expect(r.impressionsWon).toBe(18193)
    expect(r.budgetUtilization).toBeCloseTo(0.8050062847321794, 6)
    expect(r.totalSpend).toBeLessThanOrEqual(7500 + 1e-6)
  })
})
