// The hero Trading Floor scenarios and constants, taken verbatim from
// Sources/BidLab/Surfaces/TradingFloor/TradingFloorView.swift. Mean clearing
// prices sit below value-per-impression so there is a real profitable bidding
// region, the way a desk actually faces it. Each scenario carries a publisher
// floor — the reserve a bid must clear to even compete.

export interface Scenario {
  name: string
  marketMean: number
  marketSigma: number
  floor: number
  ctr: number
  cvr: number
  revenuePerConversion: number
}

export const SCENARIOS: Scenario[] = [
  // value 1.00
  {
    name: 'Retail prospecting',
    marketMean: 0.45,
    marketSigma: 0.5,
    floor: 0.2,
    ctr: 0.02,
    cvr: 0.1,
    revenuePerConversion: 500,
  },
  // value 0.12
  {
    name: 'Brand awareness',
    marketMean: 0.06,
    marketSigma: 0.5,
    floor: 0.03,
    ctr: 0.004,
    cvr: 0.02,
    revenuePerConversion: 1500,
  },
  // value 1.44
  {
    name: 'Competitive retargeting',
    marketMean: 0.7,
    marketSigma: 0.5,
    floor: 0.35,
    ctr: 0.06,
    cvr: 0.2,
    revenuePerConversion: 120,
  },
]

export const OPPORTUNITIES = 50_000
export const BUDGET_CAP = 1_000_000
export const SEED = 20_260_613n

/** Value per impression for a scenario: `CTR × CVR × revenuePerConversion`. */
export function scenarioValue(s: Scenario): number {
  return s.ctr * s.cvr * s.revenuePerConversion
}
