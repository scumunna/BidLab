// Port of BidLabCore/ReachFrequency.swift. Impressions are modeled as randomly
// distributed across a population, so the times any one person is hit follows a
// Poisson distribution with mean lambda = impressions / population. Unique reach
// is the share of the population hit at least once.

import { poissonPMF } from './probability'

/** Expected unique reach: `population * (1 - e^(-impressions/population))`. */
export function reach(population: number, impressions: number): number {
  if (!(population > 0)) return 0
  return population * (1 - Math.exp(-impressions / population))
}

/** Average frequency among reached people: impressions / reach. */
export function averageFrequency(population: number, impressions: number): number {
  const r = reach(population, impressions)
  return r > 0 ? impressions / r : 0
}

/** Effective reach: people hit at least `minFrequency` times (Poisson tail). */
export function effectiveReach(population: number, impressions: number, minFrequency: number): number {
  if (!(population > 0)) return 0
  if (minFrequency < 1) return reach(population, impressions)
  const lambda = impressions / population
  let belowCutoff = 0
  for (let k = 0; k < minFrequency; k++) {
    belowCutoff += poissonPMF(k, lambda)
  }
  return population * (1 - belowCutoff)
}

/** Reach as a fraction (0...1) of the population. */
export function reachFraction(population: number, impressions: number): number {
  if (!(population > 0)) return 0
  return reach(population, impressions) / population
}
