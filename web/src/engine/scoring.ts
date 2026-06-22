// Port of BidLabCore/Scoring.swift — grade a simulation against the optimal
// strategy and place it within a benchmark field.

import { optimalFirstPriceBid } from './auction'

/** Expected profit per opportunity for a first-price bid into an exponential market. */
export function expectedProfitPerOpportunity(
  bid: number,
  valuePerImpression: number,
  marketMean: number,
): number {
  const winProbability = 1 - Math.exp(-bid / Math.max(marketMean, 1e-9))
  return winProbability * (valuePerImpression - bid)
}

/** The profit-maximizing bid for an exponential market. */
export function optimalBid(
  valuePerImpression: number,
  marketMean: number,
  steps = 4000,
): { bid: number; expectedProfit: number } {
  return optimalFirstPriceBid(
    valuePerImpression,
    (bid) => 1 - Math.exp(-bid / Math.max(marketMean, 1e-9)),
    steps,
  )
}

/**
 * A 0...100 score: how close achieved profit came to the optimal achievable
 * profit. Optimal play scores 100; breaking even against a positive optimum is 0.
 */
export function score(achievedProfit: number, optimalProfit: number): number {
  if (!(optimalProfit > 0)) return achievedProfit >= 0 ? 100 : 0
  return Math.max(0, Math.min(1, achievedProfit / optimalProfit)) * 100
}

/** Percentile rank of a score within a benchmark field, in 0...100. */
export function percentile(value: number, field: number[]): number {
  if (field.length === 0) return 0
  const below = field.reduce((acc, v) => acc + (v < value ? 1 : 0), 0)
  return (below / field.length) * 100
}
