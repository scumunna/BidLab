import Foundation

/// Conversion-tracking math taught in adops-13 and adops-14 (and mirrored in the
/// web demo's tracking.ts). Every function is a single transparent formula with
/// no hidden state, so the "open the hood" panel and the native pixel widget can
/// show the exact arithmetic behind each number.
public enum Tracking {
    /// Share of true conversions the client pixel captured: `client / backend`.
    public static func captureRate(client: Double, backend: Double) -> Double {
        backend > 0 ? client / backend : 0
    }

    /// Leakage the client pixel missed (to blockers, cookie caps, bounce):
    /// `1 - captureRate`, clamped to `0...1`.
    public static func leakage(client: Double, backend: Double) -> Double {
        min(max(1 - captureRate(client: client, backend: backend), 0), 1)
    }

    /// Deduplicated total when the browser pixel and the server feed each report
    /// the same `trueCount` conversions but a fraction of event ids fail to match.
    /// The matched pairs collapse to one; the unmatched ones count twice. This is
    /// the upper bound on dedup damage.
    public static func dedupedTotal(trueCount: Double, unmatchedShare: Double) -> Double {
        let u = min(max(unmatchedShare, 0), 1)
        return trueCount * (1 + u)
    }

    /// Inflation over the true count caused by unmatched ids, as a fraction.
    public static func dedupInflation(unmatchedShare: Double) -> Double {
        min(max(unmatchedShare, 0), 1)
    }

    /// Counting-point discrepancy measured against a reference:
    /// `(reference - observed) / reference`. The reference is the source of truth
    /// or the upstream counting point. An under-counting observation is positive,
    /// an over-counting one is negative; compare its magnitude to the normal band.
    public static func discrepancy(reference: Double, observed: Double) -> Double {
        reference > 0 ? (reference - observed) / reference : 0
    }

    /// Whether a discrepancy sits inside the ~10% band treated as normal drift.
    public static func withinNormalBand(_ discrepancy: Double, band: Double = 0.1) -> Bool {
        abs(discrepancy) <= band
    }
}
