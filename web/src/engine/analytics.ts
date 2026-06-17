// Port of the experiment-design parts of BidLabCore/Analytics.swift: required
// sample size and statistical power for a two-proportion A/B test.

import { normalQuantile } from './probability'
import { normalCDF } from './mathx'

/**
 * Required sample size per arm for a two-proportion A/B test to detect an
 * absolute lift `mde` over `baselineRate`, at significance `alpha` (two-sided)
 * and target `power`.
 */
export function sampleSizePerArm(
  baselineRate: number,
  mde: number,
  alpha = 0.05,
  power = 0.8,
): number {
  if (mde === 0 || !(baselineRate > 0) || !(baselineRate < 1)) return 0
  const p1 = baselineRate
  const p2 = Math.min(Math.max(baselineRate + mde, 0), 1)
  const pBar = (p1 + p2) / 2
  const zAlpha = normalQuantile(1 - alpha / 2)
  const zBeta = normalQuantile(power)
  const term = zAlpha * Math.sqrt(2 * pBar * (1 - pBar)) + zBeta * Math.sqrt(p1 * (1 - p1) + p2 * (1 - p2))
  return Math.ceil((term * term) / (mde * mde))
}

/** Statistical power of a two-proportion test given `nPerArm`. */
export function power(baselineRate: number, mde: number, nPerArm: number, alpha = 0.05): number {
  if (!(nPerArm > 0) || !(baselineRate > 0) || !(baselineRate < 1)) return 0
  const p1 = baselineRate
  const p2 = Math.min(Math.max(baselineRate + mde, 0), 1)
  const se = Math.sqrt((p1 * (1 - p1)) / nPerArm + (p2 * (1 - p2)) / nPerArm)
  if (!(se > 0)) return 0
  const zAlpha = normalQuantile(1 - alpha / 2)
  const z = Math.abs(mde) / se - zAlpha
  return normalCDF(z)
}
