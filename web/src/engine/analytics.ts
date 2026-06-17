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

/** Ordinary least squares fit of y = slope·x + intercept, with R-squared. */
export function linearFit(xs: number[], ys: number[]): { slope: number; intercept: number; r2: number } {
  const n = Math.min(xs.length, ys.length)
  if (n < 2) return { slope: 0, intercept: 0, r2: 0 }
  const meanX = xs.slice(0, n).reduce((a, b) => a + b, 0) / n
  const meanY = ys.slice(0, n).reduce((a, b) => a + b, 0) / n
  let sxy = 0
  let sxx = 0
  let syy = 0
  for (let i = 0; i < n; i++) {
    const dx = xs[i] - meanX
    const dy = ys[i] - meanY
    sxy += dx * dy
    sxx += dx * dx
    syy += dy * dy
  }
  if (!(sxx > 0)) return { slope: 0, intercept: meanY, r2: 0 }
  const slope = sxy / sxx
  const intercept = meanY - slope * meanX
  const r2 = syy > 0 ? (sxy * sxy) / (sxx * syy) : 1
  return { slope, intercept, r2 }
}

/** Geometric adstock: `a_t = x_t + decay · a_{t-1}` (advertising carryover). */
export function adstock(series: number[], decay: number): number[] {
  const out: number[] = []
  let carry = 0
  for (const x of series) {
    carry = x + decay * carry
    out.push(carry)
  }
  return out
}

/** Hill saturation in 0...1: `x^shape / (x^shape + halfSaturation^shape)`. */
export function hillSaturation(x: number, halfSaturation: number, shape = 1): number {
  if (!(x > 0) || !(halfSaturation > 0)) return 0
  const xs = Math.pow(x, shape)
  return xs / (xs + Math.pow(halfSaturation, shape))
}
