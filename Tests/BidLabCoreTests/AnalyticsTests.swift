import BidLabCore

/// Tests for the analytics / data-science math.
func analyticsTests(_ h: Harness) {
    // Normal quantile: inverse of the CDF.
    h.close("normal quantile 0.975", Probability.normalQuantile(0.975), 1.959963985, tol: 1e-3)
    h.close("normal quantile 0.5", Probability.normalQuantile(0.5), 0, tol: 1e-9)

    // Sample size: detecting a smaller lift needs a larger sample.
    let nSmall = Analytics.sampleSizePerArm(baselineRate: 0.10, mde: 0.02)
    let nLarge = Analytics.sampleSizePerArm(baselineRate: 0.10, mde: 0.04)
    h.check("smaller MDE needs bigger sample", nSmall > nLarge)
    // Power at the computed sample size meets the target.
    h.check("computed sample size reaches target power", Analytics.power(baselineRate: 0.10, mde: 0.02, nPerArm: nSmall) >= 0.78)

    // Difference-in-differences isolates the incremental change.
    h.close("difference-in-differences",
            Analytics.differenceInDifferences(treatmentPre: 10, treatmentPost: 18, controlPre: 10, controlPost: 12), 6)

    // Adstock carryover.
    let stock = Analytics.adstock([1, 0, 0], decay: 0.5)
    h.close("adstock t0", stock[0], 1)
    h.close("adstock t1", stock[1], 0.5)
    h.close("adstock t2", stock[2], 0.25)

    // Hill saturation is 0.5 at the half-saturation point.
    h.close("hill at half-saturation", Analytics.hillSaturation(50, halfSaturation: 50, shape: 1), 0.5, tol: 1e-9)

    // Linear fit recovers a known line exactly.
    let fit = Analytics.linearFit(xs: [0, 1, 2, 3], ys: [1, 3, 5, 7]) // y = 2x + 1
    h.close("linear fit slope", fit.slope, 2)
    h.close("linear fit intercept", fit.intercept, 1)
    h.close("linear fit r2", fit.r2, 1, tol: 1e-9)
}
