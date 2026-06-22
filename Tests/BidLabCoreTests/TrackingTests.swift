import BidLabCore

/// Tests for the conversion-tracking math (adops-13 / adops-14 worked numbers).
func trackingTests(_ h: Harness) {
    // Capture rate: the adops-13 worked example.
    h.close("capture rate 920/1000", Tracking.captureRate(client: 920, backend: 1000), 0.92, tol: 1e-9)
    h.close("leakage 920/1000", Tracking.leakage(client: 920, backend: 1000), 0.08, tol: 1e-9)
    h.close("capture rate with zero back-end is zero", Tracking.captureRate(client: 100, backend: 0), 0)

    // Dedup inflation: matched pairs collapse, unmatched count twice.
    h.close("dedup 1000 @ 20% unmatched", Tracking.dedupedTotal(trueCount: 1000, unmatchedShare: 0.2), 1200, tol: 1e-9)
    h.close("dedup 1000 @ 30% unmatched", Tracking.dedupedTotal(trueCount: 1000, unmatchedShare: 0.3), 1300, tol: 1e-9)
    h.close("dedup with full matching adds nothing", Tracking.dedupedTotal(trueCount: 1000, unmatchedShare: 0), 1000)
    h.close("dedup inflation fraction", Tracking.dedupInflation(unmatchedShare: 0.2), 0.2, tol: 1e-9)
    h.close("dedup inflation clamps above 1", Tracking.dedupInflation(unmatchedShare: 1.5), 1, tol: 1e-9)

    // Discrepancy against a reference, and the normal band.
    h.close("discrepancy 1.05M vs 1M", Tracking.discrepancy(reference: 1_050_000, observed: 1_000_000), 0.047619, tol: 1e-5)
    h.close("over-counting pixel reads negative", Tracking.discrepancy(reference: 1000, observed: 1400), -0.4, tol: 1e-9)
    h.close("discrepancy with zero reference is zero", Tracking.discrepancy(reference: 0, observed: 100), 0)
    h.check("4.76% gap is within the normal band", Tracking.withinNormalBand(0.047619))
    h.check("16.67% gap is outside the band", !Tracking.withinNormalBand(0.1667))
    h.check("a 40% over-count is outside the band", !Tracking.withinNormalBand(-0.4))
}
