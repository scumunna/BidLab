import BidLabCore

/// Known-answer tests for the probability and distribution helpers.
func probabilityTests(_ h: Harness) {
    // E[X] for values [1,2,3] with probs [0.2,0.3,0.5] = 0.2 + 0.6 + 1.5 = 2.3
    h.close("expected value", Probability.expectedValue(values: [1, 2, 3], probabilities: [0.2, 0.3, 0.5]), 2.3)

    // Binomial: P(X=2; n=5, p=0.5) = C(5,2) * 0.5^5 = 10 * 0.03125 = 0.3125
    h.close("binomial pmf", Probability.binomialPMF(k: 2, n: 5, p: 0.5), 0.3125, tol: 1e-9)
    // Binomial pmf over all k sums to 1.
    let binomialSum = (0...5).reduce(0.0) { $0 + Probability.binomialPMF(k: $1, n: 5, p: 0.3) }
    h.close("binomial pmf sums to 1", binomialSum, 1.0, tol: 1e-9)

    // Poisson: P(X=0; lambda=2) = e^-2 ~ 0.135335
    h.close("poisson pmf at 0", Probability.poissonPMF(k: 0, lambda: 2), 0.1353352832, tol: 1e-7)
    // Poisson mean check via pmf: sum k*P(k) ~ lambda for a truncated range.
    let poissonMean = (0...40).reduce(0.0) { $0 + Double($1) * Probability.poissonPMF(k: $1, lambda: 3) }
    h.close("poisson mean ~ lambda", poissonMean, 3.0, tol: 1e-6)

    // Normal: CDF(0)=0.5, CDF(1.96)~0.975, symmetric pdf.
    h.close("normal cdf at mean", Probability.normalCDF(0), 0.5, tol: 1e-9)
    h.close("normal cdf at 1.96", Probability.normalCDF(1.96), 0.975, tol: 1e-3)
    h.close("normal pdf peak", Probability.normalPDF(0), 1.0 / (2.50662827463), tol: 1e-6)
}
