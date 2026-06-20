// Conversion-tracking math taught in the curriculum (core-08, adops-13, adops-14).
// Transparent arithmetic — the formulas are shown in the UI — so unlike the
// auction/stats modules these are not Swift golden-mastered (no Swift function
// exists); they mirror the worked numbers in those lessons.

/** Share of true conversions the client pixel captured: client / backend. */
export function captureRate(client: number, backend: number): number {
  return backend > 0 ? client / backend : 0
}

/** Leakage the client pixel missed: 1 - captureRate (clamped to 0..1). */
export function leakage(client: number, backend: number): number {
  return Math.min(Math.max(1 - captureRate(client, backend), 0), 1)
}

/**
 * Deduplicated total when the browser pixel and the server feed each report the
 * same `trueCount` conversions but a fraction of event ids fail to match. The
 * matched ones collapse to one; the unmatched ones count twice.
 */
export function dedupedTotal(trueCount: number, unmatchedShare: number): number {
  const u = Math.min(Math.max(unmatchedShare, 0), 1)
  return trueCount * (1 + u)
}

/** Inflation over the true count caused by unmatched ids, as a fraction. */
export function dedupInflation(unmatchedShare: number): number {
  return Math.min(Math.max(unmatchedShare, 0), 1)
}

/** Counting-point discrepancy: (higher - lower) / higher. */
export function discrepancy(higher: number, lower: number): number {
  return higher > 0 ? (higher - lower) / higher : 0
}

/** Whether a discrepancy sits inside the ~10% band treated as normal drift. */
export function withinNormalBand(discrepancyFraction: number, band = 0.1): boolean {
  return Math.abs(discrepancyFraction) <= band
}
