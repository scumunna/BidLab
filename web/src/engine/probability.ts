// Port of the parts of BidLabCore/Probability.swift the explorables need:
// Poisson PMF (for effective reach) and the inverse normal CDF (for A/B power
// and sample size). Swift gets log-gamma from Foundation's `lgamma`; JavaScript
// has none, so we port the Lanczos approximation (relative error ~1e-15).

const LANCZOS_G = 7
const LANCZOS_C = [
  0.99999999999980993, 676.5203681218851, -1259.1392167224028, 771.32342877765313,
  -176.61502916214059, 12.507343278686905, -0.13857109526572012, 9.9843695780195716e-6,
  1.5056327351493116e-7,
]

/** Natural log of the gamma function, matching Foundation's `lgamma`. */
export function lgamma(x: number): number {
  if (x < 0.5) {
    // Reflection: Γ(x)Γ(1-x) = π / sin(πx)
    return Math.log(Math.PI / Math.sin(Math.PI * x)) - lgamma(1 - x)
  }
  const z = x - 1
  let a = LANCZOS_C[0]
  const t = z + LANCZOS_G + 0.5
  for (let i = 1; i < LANCZOS_G + 2; i++) {
    a += LANCZOS_C[i] / (z + i)
  }
  return 0.5 * Math.log(2 * Math.PI) + (z + 0.5) * Math.log(t) - t + Math.log(a)
}

/** Poisson pmf P(X = k) for rate `lambda`: `lambda^k * e^(-lambda) / k!`. */
export function poissonPMF(k: number, lambda: number): number {
  if (k < 0 || lambda < 0) return 0
  if (lambda === 0) return k === 0 ? 1 : 0
  const logP = k * Math.log(lambda) - lambda - lgamma(k + 1)
  return Math.exp(logP)
}

/**
 * Inverse normal CDF (quantile) via Acklam's rational approximation — the exact
 * coefficients and branches from Probability.swift. `normalQuantile(0.975) ≈ 1.95996`.
 */
export function normalQuantile(p: number, mean = 0, sd = 1): number {
  if (!(p > 0) || !(p < 1)) return p <= 0 ? -Infinity : Infinity
  const a = [
    -3.969683028665376e1, 2.209460984245205e2, -2.759285104469687e2, 1.38357751867269e2,
    -3.066479806614716e1, 2.506628277459239e0,
  ]
  const b = [
    -5.447609879822406e1, 1.615858368580409e2, -1.556989798598866e2, 6.680131188771972e1,
    -1.328068155288572e1,
  ]
  const c = [
    -7.784894002430293e-3, -3.223964580411365e-1, -2.400758277161838e0, -2.549732539343734e0,
    4.374664141464968e0, 2.938163982698783e0,
  ]
  const d = [
    7.784695709041462e-3, 3.224671290700398e-1, 2.445134137142996e0, 3.754408661907416e0,
  ]
  const plow = 0.02425
  const phigh = 1 - plow
  let z: number
  if (p < plow) {
    const q = Math.sqrt(-2 * Math.log(p))
    z =
      (((((c[0] * q + c[1]) * q + c[2]) * q + c[3]) * q + c[4]) * q + c[5]) /
      ((((d[0] * q + d[1]) * q + d[2]) * q + d[3]) * q + 1)
  } else if (p <= phigh) {
    const q = p - 0.5
    const r = q * q
    z =
      ((((((a[0] * r + a[1]) * r + a[2]) * r + a[3]) * r + a[4]) * r + a[5]) * q) /
      (((((b[0] * r + b[1]) * r + b[2]) * r + b[3]) * r + b[4]) * r + 1)
  } else {
    const q = Math.sqrt(-2 * Math.log(1 - p))
    z =
      -(((((c[0] * q + c[1]) * q + c[2]) * q + c[3]) * q + c[4]) * q + c[5]) /
      ((((d[0] * q + d[1]) * q + d[2]) * q + d[3]) * q + 1)
  }
  return mean + sd * z
}
