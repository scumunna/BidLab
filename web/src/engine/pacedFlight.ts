// Port of BidLabCore/PacedFlight.swift. Instead of one static bid over the whole
// campaign, split opportunities into intervals and adjust the bid each interval
// with the proportional pacing throttle, so spend tracks the on-pace target and
// respects the flight budget — how a real desk runs a flight. The market also
// swings intraday, so the throttle has to fight real under-/over-delivery.

import { MarketConfig, runMarket } from './market'
import { targetSpend, throttle } from './pacing'

export interface IntervalPoint {
  index: number
  fractionElapsed: number
  bid: number
  throttle: number
  impressionsWon: number
  opportunities: number
  conversions: number
  spend: number
  cumulativeSpend: number
  targetCumulativeSpend: number
  winRate: number
}

export class PacedFlightResult {
  constructor(
    readonly points: IntervalPoint[],
    readonly totalSpend: number,
    readonly impressionsWon: number,
    readonly conversions: number,
    readonly revenue: number,
    readonly flightBudget: number,
  ) {}

  get profit(): number {
    return this.revenue - this.totalSpend
  }
  get budgetUtilization(): number {
    return this.flightBudget > 0 ? this.totalSpend / this.flightBudget : 0
  }
  /** How far final spend landed from spending the whole budget, in 0...1. */
  get pacingError(): number {
    return this.flightBudget > 0 ? Math.abs(this.totalSpend - this.flightBudget) / this.flightBudget : 0
  }
}

export function runPacedFlight(
  baseConfig: MarketConfig,
  flightBudget: number,
  intervals: number,
  seed: bigint,
  gain = 1.0,
  volatility = 0.35,
): PacedFlightResult {
  if (intervals <= 0) {
    return new PacedFlightResult([], 0, 0, 0, 0, flightBudget)
  }
  const perInterval = Math.max(1, Math.floor(baseConfig.opportunities / intervals))
  const baseBid = baseConfig.bid
  const valueCap = Math.max(baseConfig.valuePerImpression, 1e-6)

  const points: IntervalPoint[] = []
  let cumulativeSpend = 0
  let totalWon = 0
  let totalConversions = 0
  let totalRevenue = 0

  for (let i = 0; i < intervals; i++) {
    // Throttle against where cumulative spend should be at the START of this
    // interval. At i = 0 target and spend are both 0, so the throttle is the base.
    const startFraction = i / intervals
    const target = targetSpend(flightBudget, startFraction)
    const thr = throttle(target, cumulativeSpend, 1.0, gain)
    const bid = Math.min(Math.max(baseBid * thr, 1e-6), valueCap)

    // Intraday market: volume and competition swing on offset sinusoids.
    const mid = (i + 0.5) / intervals
    const volumeMultiplier = Math.max(0.2, 1 + volatility * Math.sin(2 * Math.PI * mid))
    const competitionMultiplier = Math.max(0.2, 1 + volatility * Math.cos(2 * Math.PI * mid))
    const intervalOpportunities = Math.max(1, Math.trunc(perInterval * volumeMultiplier))

    const cfg = new MarketConfig({
      opportunities: intervalOpportunities,
      bid,
      budget: Math.max(0, flightBudget - cumulativeSpend), // cannot exceed the flight budget
      marketMean: baseConfig.marketMean * competitionMultiplier,
      floor: baseConfig.floor,
      ctr: baseConfig.ctr,
      cvr: baseConfig.cvr,
      revenuePerConversion: baseConfig.revenuePerConversion,
      model: baseConfig.model,
      auction: baseConfig.auction,
    })
    const r = runMarket(cfg, seed + BigInt(i))

    cumulativeSpend += r.spend
    totalWon += r.impressionsWon
    totalConversions += r.conversions
    totalRevenue += r.revenue

    const endFraction = (i + 1) / intervals
    points.push({
      index: i,
      fractionElapsed: endFraction,
      bid,
      throttle: thr,
      impressionsWon: r.impressionsWon,
      opportunities: intervalOpportunities,
      conversions: r.conversions,
      spend: r.spend,
      cumulativeSpend,
      targetCumulativeSpend: targetSpend(flightBudget, endFraction),
      winRate: intervalOpportunities > 0 ? r.impressionsWon / intervalOpportunities : 0,
    })
  }

  return new PacedFlightResult(points, cumulativeSpend, totalWon, totalConversions, totalRevenue, flightBudget)
}
