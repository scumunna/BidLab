import { describe, expect, it } from 'vitest'
import { MarketConfig, runPacedFlight, SCENARIOS, OPPORTUNITIES, BUDGET_CAP, SEED, scenarioValue } from './index'

// Ground truth from the real Swift PacedFlight.run (Retail prospecting, first-price,
// bid = value * 0.3, flight budget 7500, 12 intervals, seed 20_260_613).
describe('PacedFlight — parity with the native Swift engine', () => {
  const s = SCENARIOS[0]
  const value = scenarioValue(s)
  const base = new MarketConfig({
    opportunities: OPPORTUNITIES,
    bid: value * 0.3,
    budget: BUDGET_CAP,
    marketMean: s.marketMean,
    floor: s.floor,
    ctr: s.ctr,
    cvr: s.cvr,
    revenuePerConversion: s.revenuePerConversion,
    model: { kind: 'logNormal', sigma: s.marketSigma },
    auction: 'firstPrice',
  })
  const r = runPacedFlight(base, 7500, 12, SEED)

  it('intraday opportunity volumes match exactly (sin/cos parity)', () => {
    expect(r.points.map((p) => p.opportunities)).toEqual([4543, 5197, 5574, 5574, 5197, 4543, 3788, 3134, 2757, 2757, 3134, 3788])
  })

  it('integer outcomes match exactly across the flight', () => {
    expect(r.impressionsWon).toBe(18193)
    expect(r.conversions).toBe(44)
    expect(r.revenue).toBe(22000)
  })

  it('spend and pacing match', () => {
    expect(r.totalSpend).toBeCloseTo(6037.547135491345, 3)
    expect(r.budgetUtilization).toBeCloseTo(0.8050062847321794, 6)
    expect(r.pacingError).toBeCloseTo(0.19499371526782064, 6)
  })
})
