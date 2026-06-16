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

    // Standard normal CDF.
    h.close("normal CDF at 0 is 0.5", Statistics.standardNormalCDF(0), 0.5, tol: 1e-9)
    h.close("normal CDF at 1.96 is ~0.975", Statistics.standardNormalCDF(1.96), 0.975, tol: 1e-3)

    // Wilson interval stays within [0,1] and brackets the estimate.
    let w = Statistics.wilsonInterval(successes: 5, n: 10)
    h.check("wilson low >= 0", w.low >= 0)
    h.check("wilson high <= 1", w.high <= 1)
    h.check("wilson brackets the point estimate", w.low < 0.5 && w.high > 0.5)
    // For zero successes the lower bound is 0 but the upper bound is positive,
    // where the Wald interval would collapse to [0, 0].
    let w0 = Statistics.wilsonInterval(successes: 0, n: 20)
    h.close("wilson lower bound at 0 successes is 0", w0.low, 0, tol: 1e-12)
    h.check("wilson upper bound at 0 successes is positive", w0.high > 0)

    // Two-proportion z-test.
    let equal = Statistics.twoProportionZTest(successesA: 50, nA: 100, successesB: 50, nB: 100)
    h.close("equal proportions give z = 0", equal.z, 0, tol: 1e-9)
    h.close("equal proportions give p = 1", equal.pValue, 1, tol: 1e-9)
    let diff = Statistics.twoProportionZTest(successesA: 60, nA: 100, successesB: 40, nB: 100)
    h.close("z statistic for 0.60 vs 0.40", diff.z, 2.8284271247, tol: 1e-4)
    h.close("two-sided p-value for that z", diff.pValue, 0.004677, tol: 1e-4)
    h.check("a larger gap is more significant",
            Statistics.twoProportionZTest(successesA: 70, nA: 100, successesB: 30, nB: 100).pValue < diff.pValue)
}
