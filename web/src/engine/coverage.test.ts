import { describe, expect, it } from 'vitest'
import {
  Pricing,
  Scoring,
  Auction,
  Probability,
  Systems,
  ReachFrequency,
  Attribution,
  Analytics,
  Tracking,
  MarketConfig,
  MarketResult,
  runMarket,
  runPacedFlight,
} from './index'

// Boundary and guard-path coverage for the pure engine: the divide-by-zero
// guards (which return Infinity or 0), empty-input returns, and the distribution
// special cases (p==0/1, sd==0, the normal-quantile tails) that the parity suites
// do not reach. Mirrors the Swift EdgeCoverageTests, completing branch coverage.

describe('Pricing guards', () => {
  it('derives eCPM from a CPA and a per-impression conversion rate', () => {
    expect(Pricing.eCPMFromCPA(25, 0.0004)).toBeCloseTo(10, 12)
  })
  it('guards divide-by-zero with Infinity or zero', () => {
    expect(Pricing.cpc(10, 0)).toBe(Infinity)
    expect(Pricing.cpa(1, 0)).toBe(Infinity)
    expect(Pricing.impressions(100, 0)).toBe(0)
    expect(Pricing.roas(1, 0)).toBe(Infinity)
    expect(Pricing.ltvToCac(900, 0)).toBe(Infinity)
  })
})

describe('Scoring guards', () => {
  it('computes expected profit and the optimal bid for an exponential market', () => {
    expect(Scoring.expectedProfitPerOpportunity(0.2, 1, 0.5)).toBeGreaterThan(0)
    const opt = Scoring.optimalBid(1, 0.5)
    expect(opt.bid).toBeGreaterThan(0)
    expect(opt.bid).toBeLessThan(1)
    expect(opt.expectedProfit).toBeGreaterThan(0)
  })
  it('scores against the optimum and handles a non-positive optimum', () => {
    expect(Scoring.score(50, 100)).toBeCloseTo(50, 12)
    expect(Scoring.score(5, 0)).toBe(100)
    expect(Scoring.score(-5, 0)).toBe(0)
  })
  it('percentile of an empty field is 0', () => {
    expect(Scoring.percentile(50, [])).toBe(0)
    expect(Scoring.percentile(50, [10, 90])).toBe(50)
  })
})

describe('Auction guards', () => {
  it('clearing price of no competition is 0', () => {
    expect(Auction.clearingPrice([])).toBe(0)
    expect(Auction.clearingPrice([1, 3, 2])).toBe(3)
  })
  it('a bid that does not beat the market loses', () => {
    expect(Auction.secondPrice(1, 5, [2])).toEqual(Auction.LOST)
    expect(Auction.firstPrice(1, 5, [2])).toEqual(Auction.LOST)
    expect(Auction.secondPrice(3, 5, [2]).won).toBe(true)
  })
  it('optimal first-price bid guards zero value and zero steps', () => {
    expect(Auction.optimalFirstPriceBid(0, () => 1)).toEqual({ bid: 0, expectedProfit: 0 })
    expect(Auction.optimalFirstPriceBid(1, () => 1, 0)).toEqual({ bid: 0, expectedProfit: 0 })
  })
  it('shade factor guards zero value', () => {
    expect(Auction.shadeFactor(1, 0)).toBe(0)
    expect(Auction.shadeFactor(0.8, 1)).toBeCloseTo(0.2, 12)
  })
})

describe('Probability special cases', () => {
  it('lgamma uses the reflection formula for x < 0.5', () => {
    // Gamma(0.25) = 3.625609..., so lgamma(0.25) = 1.2880225...
    expect(Probability.lgamma(0.25)).toBeCloseTo(1.2880225, 6)
  })
  it('poisson handles out-of-range and the lambda = 0 special case', () => {
    expect(Probability.poissonPMF(-1, 2)).toBe(0)
    expect(Probability.poissonPMF(1, -1)).toBe(0)
    expect(Probability.poissonPMF(0, 0)).toBe(1)
    expect(Probability.poissonPMF(3, 0)).toBe(0)
  })
  it('normal pdf guards a non-positive sd', () => {
    expect(Probability.normalPDF(0, 0, 0)).toBe(0)
  })
  it('normal quantile guards the bounds and uses both tails', () => {
    expect(Probability.normalQuantile(0)).toBe(-Infinity)
    expect(Probability.normalQuantile(1)).toBe(Infinity)
    expect(Probability.normalQuantile(0.001)).toBeCloseTo(-3.090232, 4)
    expect(Probability.normalQuantile(0.999)).toBeCloseTo(3.090232, 4)
    expect(Probability.normalQuantile(0.5)).toBeCloseTo(0, 9)
  })
})

describe('Systems guards', () => {
  it('latency quantile guards the bounds', () => {
    expect(Systems.latencyQuantile(10, 0)).toBe(0)
    expect(Systems.latencyQuantile(10, 1)).toBe(Infinity)
    expect(Systems.latencyQuantile(0, 0.5)).toBe(Infinity)
    expect(Systems.latencyQuantile(10, 0.99)).toBeGreaterThan(0)
  })
  it('timeout, capacity, utilization, and M/M/1 guard their divisors', () => {
    expect(Systems.timeoutLossRate(0, 100)).toBe(0)
    expect(Systems.capacityQPS(4, 0)).toBe(0)
    expect(Systems.utilization(100, 0)).toBe(Infinity)
    expect(Systems.utilization(50, 100)).toBeCloseTo(0.5, 12)
    expect(Systems.mm1ResponseTimeMs(10, 0)).toBe(Infinity)
    expect(Systems.mm1ResponseTimeMs(2000, 1)).toBe(Infinity) // arrival >= service rate
    expect(Systems.mm1ResponseTimeMs(500, 1)).toBeGreaterThan(0)
  })
})

describe('ReachFrequency guards', () => {
  it('reach and reach fraction guard zero population', () => {
    expect(ReachFrequency.reach(0, 100)).toBe(0)
    expect(ReachFrequency.reachFraction(0, 100)).toBe(0)
    expect(ReachFrequency.reach(1000, 500)).toBeGreaterThan(0)
  })
  it('average frequency guards zero reach', () => {
    expect(ReachFrequency.averageFrequency(0, 100)).toBe(0)
    expect(ReachFrequency.averageFrequency(1000, 500)).toBeGreaterThan(1)
  })
  it('effective reach guards population and a sub-1 minimum frequency', () => {
    expect(ReachFrequency.effectiveReach(0, 100, 1)).toBe(0)
    expect(ReachFrequency.effectiveReach(1000, 500, 0)).toBeCloseTo(ReachFrequency.reach(1000, 500), 9)
    expect(ReachFrequency.effectiveReach(1000, 2000, 2)).toBeGreaterThan(0)
  })
})

describe('Attribution guards', () => {
  it('returns an empty vector for n <= 0', () => {
    expect(Attribution.lastTouch(0)).toEqual([])
    expect(Attribution.firstTouch(0)).toEqual([])
    expect(Attribution.linear(0)).toEqual([])
    expect(Attribution.positionBased(0)).toEqual([])
  })
  it('credit vectors are correct for the normal cases', () => {
    expect(Attribution.lastTouch(3)).toEqual([0, 0, 1])
    expect(Attribution.firstTouch(3)).toEqual([1, 0, 0])
    expect(Attribution.linear(4)).toEqual([0.25, 0.25, 0.25, 0.25])
    expect(Attribution.positionBased(1)).toEqual([1])
    expect(Attribution.positionBased(2)).toEqual([0.5, 0.5])
    const u = Attribution.positionBased(4)
    expect(u[0]).toBeCloseTo(0.4, 12)
    expect(u.reduce((a, b) => a + b, 0)).toBeCloseTo(1, 12)
  })
})

describe('Analytics guards and degenerate fits', () => {
  it('sample size and power guard their inputs', () => {
    expect(Analytics.sampleSizePerArm(0.1, 0)).toBe(0)
    expect(Analytics.sampleSizePerArm(0.1, 0.02)).toBeGreaterThan(0)
    expect(Analytics.power(0.1, 0.02, 0)).toBe(0)
    expect(Analytics.power(0.1, 0.02, 5000)).toBeGreaterThan(0)
  })
  it('hill saturation guards non-positive inputs', () => {
    expect(Analytics.hillSaturation(0, 5)).toBe(0)
    expect(Analytics.hillSaturation(5, 0)).toBe(0)
    expect(Analytics.hillSaturation(5, 5)).toBeCloseTo(0.5, 12)
  })
  it('linear fit handles too-few points and degenerate scatter', () => {
    expect(Analytics.linearFit([1], [2])).toEqual({ slope: 0, intercept: 0, r2: 0 })
    const vertical = Analytics.linearFit([3, 3, 3], [1, 2, 3])
    expect(vertical.slope).toBe(0)
    expect(vertical.intercept).toBeCloseTo(2, 12)
    const flat = Analytics.linearFit([1, 2, 3], [5, 5, 5])
    expect(flat.r2).toBe(1)
    const good = Analytics.linearFit([1, 2, 3], [2, 4, 6])
    expect(good.slope).toBeCloseTo(2, 12)
    expect(good.r2).toBeCloseTo(1, 12)
  })
})

describe('Tracking guards', () => {
  it('capture rate and discrepancy guard zero denominators', () => {
    expect(Tracking.captureRate(80, 0)).toBe(0)
    expect(Tracking.captureRate(80, 100)).toBeCloseTo(0.8, 12)
    expect(Tracking.discrepancy(0, 5)).toBe(0)
    expect(Tracking.discrepancy(100, 90)).toBeCloseTo(0.1, 12)
    expect(Tracking.discrepancy(100, 140)).toBeCloseTo(-0.4, 12)
  })
  it('leakage and dedup clamp to their ranges', () => {
    expect(Tracking.leakage(80, 100)).toBeCloseTo(0.2, 12)
    expect(Tracking.leakage(150, 100)).toBe(0) // capture > 1 clamps to 0 leakage
    expect(Tracking.dedupedTotal(100, 0.3)).toBeCloseTo(130, 12)
    expect(Tracking.dedupInflation(1.5)).toBe(1)
    expect(Tracking.dedupInflation(-0.5)).toBe(0)
    expect(Tracking.withinNormalBand(0.05)).toBe(true)
    expect(Tracking.withinNormalBand(0.4)).toBe(false)
  })
})

describe('Market config and result branches', () => {
  it('win probability is zero below the floor and uses both market models', () => {
    const expo = new MarketConfig({ opportunities: 1, bid: 0.5, budget: 1e9, marketMean: 0.5, ctr: 0.02, cvr: 0.1, revenuePerConversion: 500 })
    expect(expo.winProbability(0)).toBe(0)
    expect(expo.winProbability(0.5)).toBeGreaterThan(0)
    const ln = new MarketConfig({ opportunities: 1, bid: 0.5, budget: 1e9, marketMean: 0.5, floor: 0.6, ctr: 0.02, cvr: 0.1, revenuePerConversion: 500, model: { kind: 'logNormal', sigma: 0.5 }, auction: 'secondPrice' })
    expect(ln.winProbability(0.5)).toBe(0) // below the floor
    expect(ln.winProbability(0.8)).toBeGreaterThan(0)
  })
  it('expected profit covers first/second price, the floor guard, and both densities', () => {
    const fp = new MarketConfig({ opportunities: 1, bid: 0.5, budget: 1e9, marketMean: 0.5, ctr: 0.02, cvr: 0.1, revenuePerConversion: 500 })
    expect(fp.expectedProfitPerOpportunity(0)).toBe(0)
    expect(fp.expectedProfitPerOpportunity(0.2)).toBeGreaterThan(0)
    expect(fp.optimal().expectedProfit).toBeGreaterThan(0)
    const floored = new MarketConfig({ opportunities: 1, bid: 0.5, budget: 1e9, marketMean: 0.5, floor: 0.5, ctr: 0.02, cvr: 0.1, revenuePerConversion: 500 })
    expect(floored.expectedProfitPerOpportunity(0.4)).toBe(0) // below the floor
    const spExpo = new MarketConfig({ opportunities: 1, bid: 0.5, budget: 1e9, marketMean: 0.5, ctr: 0.02, cvr: 0.1, revenuePerConversion: 500, auction: 'secondPrice' })
    expect(spExpo.expectedProfitPerOpportunity(0.5)).toBeGreaterThan(0) // exponential density
    const spLN = new MarketConfig({ opportunities: 1, bid: 0.5, budget: 1e9, marketMean: 0.5, ctr: 0.02, cvr: 0.1, revenuePerConversion: 500, model: { kind: 'logNormal', sigma: 0.5 }, auction: 'secondPrice' })
    expect(spLN.expectedProfitPerOpportunity(0.5)).toBeGreaterThan(0) // log-normal density
  })
  it('result getters cover the divide-by-zero branches', () => {
    const r = new MarketResult(1000, 400, 250, 8, 2, 1000, 100, 500)
    expect(r.profit).toBe(750)
    expect(r.winRate).toBeCloseTo(0.4, 12)
    expect(r.effectiveCPA).toBe(125)
    expect(r.roas).toBe(4)
    expect(r.lostToFloorRate).toBeCloseTo(0.1, 12)
    expect(r.lostToCompetitionRate).toBeCloseTo(0.5, 12)
    const z = new MarketResult(0, 0, 0, 0, 0, 0, 0, 0)
    expect(z.effectiveCPA).toBe(Infinity)
    expect(z.roas).toBe(Infinity)
    expect(z.winRate).toBe(0)
    expect(z.lostToFloorRate).toBe(0)
    expect(z.lostToCompetitionRate).toBe(0)
  })
  it('runMarket covers floor loss, competition loss, second-price pay, and the budget bind', () => {
    const belowFloor = new MarketConfig({ opportunities: 200, bid: 0.3, budget: 1e9, marketMean: 0.5, floor: 0.6, ctr: 0.02, cvr: 0.1, revenuePerConversion: 500, model: { kind: 'logNormal', sigma: 0.5 } })
    const bf = runMarket(belowFloor, 11n)
    expect(bf.impressionsWon).toBe(0)
    expect(bf.lostToFloor).toBe(200)
    const tight = new MarketConfig({ opportunities: 2000, bid: 0.8, budget: 5, marketMean: 0.3, ctr: 0.5, cvr: 0.5, revenuePerConversion: 10, auction: 'secondPrice' })
    const tg = runMarket(tight, 5n)
    expect(tg.spend).toBeLessThanOrEqual(5 + 1e-9)
    expect(tg.impressionsWon).toBeGreaterThan(0)
    const big = new MarketConfig({ opportunities: 5000, bid: 0.9, budget: 1e9, marketMean: 0.3, ctr: 0.5, cvr: 0.5, revenuePerConversion: 100 })
    const bg = runMarket(big, 7n)
    expect(bg.conversions).toBeGreaterThan(0)
    expect(bg.revenue).toBeGreaterThan(0)
  })
  it('the config constructor applies defaults for omitted optional params', () => {
    const minimal = new MarketConfig({ opportunities: 1, bid: 0.5, budget: 1, marketMean: 0.5, ctr: 0.02, cvr: 0.1, revenuePerConversion: 500 })
    expect(minimal.floor).toBe(0)
    expect(minimal.model).toEqual({ kind: 'exponential' })
    expect(minimal.auction).toBe('firstPrice')
  })
})

describe('Paced flight', () => {
  it('runs a flight, exposes profit and pacing error, and respects the budget', () => {
    const base = new MarketConfig({ opportunities: 50000, bid: 0.5, budget: 0, marketMean: 0.45, ctr: 0.02, cvr: 0.1, revenuePerConversion: 500, model: { kind: 'logNormal', sigma: 0.5 } })
    const r = runPacedFlight(base, 5000, 10, 42n)
    expect(r.points.length).toBe(10)
    expect(r.totalSpend).toBeLessThanOrEqual(5000 + 1e-6)
    expect(r.profit).toBeCloseTo(r.revenue - r.totalSpend, 9)
    expect(r.budgetUtilization).toBeGreaterThanOrEqual(0)
    expect(r.pacingError).toBeGreaterThanOrEqual(0)
    expect(r.points.every((p) => p.winRate >= 0 && p.winRate <= 1)).toBe(true)
  })
  it('an empty flight (intervals <= 0) spends nothing', () => {
    const base = new MarketConfig({ opportunities: 50000, bid: 0.5, budget: 0, marketMean: 0.45, ctr: 0.02, cvr: 0.1, revenuePerConversion: 500 })
    const empty = runPacedFlight(base, 5000, 0, 1n)
    expect(empty.points).toEqual([])
    expect(empty.totalSpend).toBe(0)
  })
  it('a zero-budget flight has zero utilization and pacing error', () => {
    const base = new MarketConfig({ opportunities: 5000, bid: 0.5, budget: 0, marketMean: 0.45, ctr: 0.02, cvr: 0.1, revenuePerConversion: 500 })
    const z = runPacedFlight(base, 0, 4, 1n)
    expect(z.budgetUtilization).toBe(0)
    expect(z.pacingError).toBe(0)
    expect(z.profit).toBeCloseTo(z.revenue - z.totalSpend, 9)
  })
})
