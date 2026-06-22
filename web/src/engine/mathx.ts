// Math helpers not built into JavaScript's `Math`, matching the functions Swift's
// Foundation provides to BidLabCore.

const SQRT2 = 1.4142135623730951

/**
 * Error function via the Abramowitz & Stegun 7.1.26 approximation.
 * Max absolute error ~1.5e-7 — visually and numerically indistinguishable from
 * the platform `erf` Swift uses, at every point on the win-rate curve.
 */
export function erf(x: number): number {
  const sign = x < 0 ? -1 : 1
  const ax = Math.abs(x)
  const t = 1 / (1 + 0.3275911 * ax)
  const y =
    1 -
    ((((1.061405429 * t - 1.453152027) * t + 1.421413741) * t - 0.284496736) * t +
      0.254829592) *
      t *
      Math.exp(-ax * ax)
  return sign * y
}

/** Standard normal CDF, matching `MarketSimulation.Config.normalCDF` in Swift. */
export function normalCDF(z: number): number {
  return 0.5 * (1 + erf(z / SQRT2))
}
