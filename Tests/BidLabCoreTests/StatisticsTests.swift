import BidLabCore

/// Known-answer tests for descriptive statistics.
func statisticsTests(_ h: Harness) {
    h.close("mean", Statistics.mean([1, 2, 3, 4]), 2.5)

    // Dataset [2,4,4,4,5,5,7,9]: mean 5, sum of squared deviations 32.
    let data = [2.0, 4, 4, 4, 5, 5, 7, 9]
    h.close("population variance", Statistics.variance(data, sample: false), 4.0)
    h.close("population sd", Statistics.standardDeviation(data, sample: false), 2.0)
    h.close("sample variance", Statistics.variance(data, sample: true), 32.0 / 7.0, tol: 1e-9)

    h.close("standard error of proportion", Statistics.standardErrorOfProportion(p: 0.5, n: 100), 0.05, tol: 1e-9)

    let ci = Statistics.confidenceInterval(estimate: 10, standardError: 2, z: 1.96)
    h.close("CI low", ci.low, 6.08, tol: 1e-9)
    h.close("CI high", ci.high, 13.92, tol: 1e-9)

    h.close("z-score", Statistics.zScore(value: 1.96, mean: 0, sd: 1), 1.96)

    // Median and percentiles.
    h.close("median even", Statistics.median([1, 2, 3, 4]), 2.5)
    h.close("median odd", Statistics.median([1, 2, 3]), 2)
    h.close("percentile 50", Statistics.percentile([1, 2, 3, 4], 0.5), 2.5)
    h.close("percentile 0", Statistics.percentile([1, 2, 3, 4], 0), 1)
    h.close("percentile 100", Statistics.percentile([1, 2, 3, 4], 1), 4)
}
