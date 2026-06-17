// Port of BidLabCore/Pacing.swift. Even pacing spends the budget linearly across
// the flight; a proportional controller nudges delivery up when behind pace and
// down when ahead — the intuition behind real pacing systems.

/** On-pace cumulative spend target at a point in the flight (fractionElapsed 0..1). */
export function targetSpend(totalBudget: number, fractionElapsed: number): number {
  return totalBudget * Math.max(0, Math.min(1, fractionElapsed))
}

/** Proportional delivery throttle: a multiplier around `base`, clamped to [lo, hi]. */
export function throttle(
  targetSpendValue: number,
  actualSpend: number,
  base = 1.0,
  gain = 1.0,
  lo = 0,
  hi = 2,
): number {
  const denominator = Math.max(targetSpendValue, 1e-9)
  const relativeError = (targetSpendValue - actualSpend) / denominator
  const adjusted = base + gain * relativeError
  return Math.min(Math.max(adjusted, lo), hi)
}
