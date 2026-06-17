import { describe, expect, it } from 'vitest'
import { SeededRandom } from './rng'
import { MarketConfig, runMarket } from './market'
import { score } from './scoring'
import { shadeFactor } from './auction'
import { SCENARIOS, OPPORTUNITIES, BUDGET_CAP, SEED, scenarioValue } from './scenarios'

// Ground-truth values dumped from the real BidLabCore Swift engine
// (Sources/BidLabCore/{SeededRandom,Auction,Scoring,MarketSimulation}.swift),
// compiled and run with seed 20_260_613. This proves the TypeScript port runs the
// same math as the native macOS Trading Floor. See /tmp/bidlab_golden/main.swift.

const GOLDEN_RNG = [
  0.91975247300727148, 0.34795431456627113, 0.80843637274938407, 0.11269906416274089,
  0.22276200211290142, 0.05822006094517862, 0.44895800083856363, 0.14158510608216868,
]

interface GoldenCase {
  name: string
  second: boolean
  winProb: number
  expProfitPerOpp: number
  optimalBid: number
  optimalProfit: number
  impressionsWon: number
  spend: number
  clicks: number
  conversions: number
  revenue: number
  lostToCompetition: number
  score: number
}

// Order: each scenario × [first-price, second-price].
const GOLDEN: GoldenCase[] = [
  { name: 'Retail prospecting', second: false, winProb: 0.28742255518746962, expProfitPerOpp: 0.20119578863122872, optimalBid: 0.507, optimalProfit: 0.33889393899230547, impressionsWon: 14448, spend: 4334.4000000011674, clicks: 291, conversions: 19, revenue: 9500, lostToCompetition: 35552, score: 30.485053910132731 },
  { name: 'Retail prospecting', second: true, winProb: 0.28742255518746962, expProfitPerOpp: 0.21922523293904045, optimalBid: 1.0, optimalProfit: 0.55443785944957558, impressionsWon: 14448, spend: 3428.0660002561854, clicks: 291, conversions: 19, revenue: 9500, lostToCompetition: 35552, score: 21.90302807161039 },
  { name: 'Brand awareness', second: false, winProb: 0.22016050642567897, expProfitPerOpp: 0.018493482539757036, optimalBid: 0.06408, optimalProfit: 0.036270375384096137, impressionsWon: 11072, spend: 398.59200000001437, clicks: 51, conversions: 0, revenue: 0, lostToCompetition: 38928, score: 0 },
  { name: 'Brand awareness', second: true, winProb: 0.22016050642567897, expProfitPerOpp: 0.019530187832719651, optimalBid: 0.12, optimalProfit: 0.060784252500462647, impressionsWon: 11072, spend: 346.33893453868802, clicks: 51, conversions: 0, revenue: 0, lostToCompetition: 38928, score: 0 },
  { name: 'Competitive retargeting', second: false, winProb: 0.23720891180232206, expProfitPerOpp: 0.23910658309674065, optimalBid: 0.75816, optimalProfit: 0.44930573221288372, impressionsWon: 11873, spend: 5129.1359999985598, clicks: 733, conversions: 155, revenue: 18600, lostToCompetition: 38127, score: 59.963018649487708 },
  { name: 'Competitive retargeting', second: true, winProb: 0.23720891180232206, expProfitPerOpp: 0.25394553189194713, optimalBid: 1.44, optimalProfit: 0.74722761006149474, impressionsWon: 11873, spend: 4385.4039773042114, clicks: 733, conversions: 155, revenue: 18600, lostToCompetition: 38127, score: 38.04622803358663 },
]

describe('SeededRandom — bit-identical to Swift SplitMix64', () => {
  it('reproduces the native RNG stream exactly for seed 20_260_613', () => {
    const rng = new SeededRandom(SEED)
    for (const expected of GOLDEN_RNG) {
      // ~15 significant digits: effectively exact (IEEE-754 round-trip).
      expect(rng.unitDouble()).toBeCloseTo(expected, 12)
    }
  })
})

describe('MarketSimulation — parity with the native Trading Floor', () => {
  let g = 0
  for (const s of SCENARIOS) {
    for (const second of [false, true]) {
      const golden = GOLDEN[g++]
      const label = `${s.name} · ${second ? 'second' : 'first'}-price`

      it(`matches Swift: ${label}`, () => {
        const value = scenarioValue(s)
        const bid = value * 0.3
        const cfg = new MarketConfig({
          opportunities: OPPORTUNITIES,
          bid,
          budget: BUDGET_CAP,
          marketMean: s.marketMean,
          floor: s.floor,
          ctr: s.ctr,
          cvr: s.cvr,
          revenuePerConversion: s.revenuePerConversion,
          model: { kind: 'logNormal', sigma: s.marketSigma },
          auction: second ? 'secondPrice' : 'firstPrice',
        })

        // Analytic curves are pure formula → match to ~1e-6 (erf approximation aside).
        expect(cfg.winProbability(bid)).toBeCloseTo(golden.winProb, 6)
        expect(cfg.expectedProfitPerOpportunity(bid)).toBeCloseTo(golden.expProfitPerOpp, 5)

        const opt = cfg.optimal()
        expect(opt.bid).toBeCloseTo(golden.optimalBid, 3)
        expect(opt.expectedProfit).toBeCloseTo(golden.optimalProfit, 4)

        // The seeded Monte-Carlo run: integer outcomes are RNG-driven and match exactly.
        const r = runMarket(cfg, SEED)
        expect(r.impressionsWon).toBe(golden.impressionsWon)
        expect(r.clicks).toBe(golden.clicks)
        expect(r.conversions).toBe(golden.conversions)
        expect(r.lostToCompetition).toBe(golden.lostToCompetition)
        expect(r.revenue).toBe(golden.revenue)

        // Spend: first-price is exact (bid × wins); second-price sums competing
        // draws, so allow a hair for libm last-ULP differences in exp/log/cos.
        expect(r.spend).toBeCloseTo(golden.spend, second ? 0 : 4)

        const sc = score(r.profit / OPPORTUNITIES, opt.expectedProfit)
        expect(sc).toBeCloseTo(golden.score, 1)
      })
    }
  }
})

describe('Scoring.score — boundaries', () => {
  it('optimal play scores 100', () => {
    expect(score(0.5, 0.5)).toBe(100)
  })
  it('breaking even against a positive optimum scores 0', () => {
    expect(score(0, 0.5)).toBe(0)
  })
  it('a loss scores 0', () => {
    expect(score(-1, 0.5)).toBe(0)
  })
  it('a non-negative profit against a zero optimum scores 100', () => {
    expect(score(0, 0)).toBe(100)
  })
})

describe('winProbability — publisher floor', () => {
  it('is zero below the floor', () => {
    const cfg = new MarketConfig({
      opportunities: 1, bid: 0.1, budget: 100, marketMean: 0.5, floor: 0.2,
      ctr: 0.02, cvr: 0.1, revenuePerConversion: 500,
      model: { kind: 'logNormal', sigma: 0.5 }, auction: 'firstPrice',
    })
    expect(cfg.winProbability(0.1)).toBe(0)
    expect(cfg.winProbability(0.3)).toBeGreaterThan(0)
  })
})

describe('shadeFactor', () => {
  it('is the fraction below value', () => {
    expect(shadeFactor(0.8, 1)).toBeCloseTo(0.2, 10)
    expect(shadeFactor(1, 1)).toBe(0)
  })
})
