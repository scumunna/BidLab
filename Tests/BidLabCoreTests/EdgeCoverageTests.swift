import BidLabCore

/// Boundary and guard-path coverage for the pure engine. The domain suites prove
/// the math on normal inputs; this suite exercises the defensive branches they do
/// not reach: divide-by-zero guards (which return infinity or zero), empty-input
/// early returns, and the distribution special cases (p == 0, p == 1, sd == 0,
/// and the normal-quantile tails). Every expected value is hand-checked.
func edgeCoverageTests(_ h: Harness) {
    // MARK: Pricing divide-by-zero guards
    h.check("cpa guards zero CVR", Pricing.cpa(cpc: 1, cvr: 0).isInfinite)
    h.close("impressions guard zero CPM is 0", Pricing.impressions(spend: 100, cpm: 0), 0)
    h.check("MER guards zero spend", Pricing.mer(totalRevenue: 1, totalSpend: 0).isInfinite)
    h.check("payback guards zero margin", Pricing.paybackMonths(cac: 300, monthlyMargin: 0).isInfinite)
    h.check("LTV:CAC guards zero CAC", Pricing.ltvToCac(ltv: 900, cac: 0).isInfinite)

    // MARK: Scoring guards
    h.close("no positive optimum with non-negative profit scores 100", Scoring.score(achievedProfit: 5, optimalProfit: 0), 100)
    h.close("no positive optimum with a loss scores 0", Scoring.score(achievedProfit: -5, optimalProfit: 0), 0)
    h.close("percentile of an empty field is 0", Scoring.percentile(of: 50, field: []), 0)

    // MARK: Auction guards
    h.check("first-price below market loses", Auction.firstPrice(bid: 1, value: 5, competingBids: [2]) == .lost)
    let noScan = Auction.optimalFirstPriceBid(value: 0) { _ in 1 }
    h.check("optimal first-price bid with zero value is (0,0)", noScan.bid == 0 && noScan.expectedProfit == 0)
    h.close("shade factor with zero value is 0", Auction.shadeFactor(optimalBid: 1, value: 0), 0)

    // MARK: ReachFrequency guards
    h.close("effective reach with zero population is 0", ReachFrequency.effectiveReach(population: 0, impressions: 100, minFrequency: 1), 0)
    h.close("effective reach with minFrequency < 1 equals total reach",
            ReachFrequency.effectiveReach(population: 1000, impressions: 500, minFrequency: 0),
            ReachFrequency.reach(population: 1000, impressions: 500), tol: 1e-12)
    h.close("reach fraction with zero population is 0", ReachFrequency.reachFraction(population: 0, impressions: 100), 0)

    // MARK: Systems guards and latency tails
    h.close("latency quantile at p <= 0 is 0", Systems.latencyQuantile(meanMs: 10, p: 0), 0)
    h.check("latency quantile at p >= 1 is infinite", Systems.latencyQuantile(meanMs: 10, p: 1).isInfinite)
    h.close("timeout loss guards zero mean", Systems.timeoutLossRate(meanMs: 0, timeoutMs: 100), 0)
    h.close("capacity guards zero service time", Systems.capacityQPS(workers: 4, serviceMeanMs: 0), 0)
    h.check("utilization guards zero capacity", Systems.utilization(offeredQPS: 100, capacityQPS: 0).isInfinite)
    h.check("M/M/1 guards zero service time", Systems.mm1ResponseTimeMs(arrivalQPS: 10, serviceMeanMs: 0).isInfinite)
    h.check("cost per query guards zero volume", Systems.costPerQuery(monthlyCost: 1000, monthlyQueries: 0).isInfinite)

    // MARK: Analytics guards and degenerate fits
    h.check("sample size guards zero MDE", Analytics.sampleSizePerArm(baselineRate: 0.1, mde: 0) == 0)
    h.check("power guards zero n", Analytics.power(baselineRate: 0.1, mde: 0.02, nPerArm: 0) == 0)
    h.close("hill saturation at zero spend is 0", Analytics.hillSaturation(0, halfSaturation: 5), 0)
    let degenFit = Analytics.linearFit(xs: [1], ys: [2])
    h.check("linear fit needs two points", degenFit.slope == 0 && degenFit.intercept == 0 && degenFit.r2 == 0)
    let flatX = Analytics.linearFit(xs: [3, 3, 3], ys: [1, 2, 3])
    h.check("vertical scatter has zero slope", flatX.slope == 0)
    h.close("vertical scatter intercept is mean Y", flatX.intercept, 2, tol: 1e-12)
    let flatY = Analytics.linearFit(xs: [1, 2, 3], ys: [5, 5, 5])
    h.close("flat scatter has R-squared 1", flatY.r2, 1, tol: 1e-12)

    // MARK: Attribution empty guards
    h.check("last touch of zero is empty", Attribution.lastTouch(0).isEmpty)
    h.check("first touch of zero is empty", Attribution.firstTouch(0).isEmpty)
    h.check("linear of zero is empty", Attribution.linear(0).isEmpty)
    h.check("position based of zero is empty", Attribution.positionBased(0).isEmpty)

    // MARK: BudgetAllocation guard
    let zeroAlloc = BudgetAllocation.allocate(budget: 0, channels: [ResponseCurve(saturation: 1, scale: 1)])
    h.check("zero budget allocates nothing", zeroAlloc.count == 1 && zeroAlloc[0] == 0)

    // MARK: Probability special cases
    h.check("logChoose out of range is -infinity", Probability.logChoose(5, 6) == -Double.infinity)
    h.close("binomial out of range is 0", Probability.binomialPMF(k: -1, n: 5, p: 0.5), 0)
    h.close("binomial at p=0, k=0 is 1", Probability.binomialPMF(k: 0, n: 5, p: 0), 1)
    h.close("binomial at p=0, k>0 is 0", Probability.binomialPMF(k: 2, n: 5, p: 0), 0)
    h.close("binomial at p=1, k=n is 1", Probability.binomialPMF(k: 5, n: 5, p: 1), 1)
    h.close("binomial at p=1, k<n is 0", Probability.binomialPMF(k: 2, n: 5, p: 1), 0)
    h.close("poisson out of range is 0", Probability.poissonPMF(k: -1, lambda: 2), 0)
    h.close("poisson at lambda=0, k=0 is 1", Probability.poissonPMF(k: 0, lambda: 0), 1)
    h.close("poisson at lambda=0, k>0 is 0", Probability.poissonPMF(k: 3, lambda: 0), 0)
    h.close("normal pdf guards zero sd", Probability.normalPDF(0, mean: 0, sd: 0), 0)
    h.close("normal cdf with zero sd below mean is 0", Probability.normalCDF(-1, mean: 0, sd: 0), 0)
    h.close("normal cdf with zero sd at/above mean is 1", Probability.normalCDF(1, mean: 0, sd: 0), 1)
    h.check("normal quantile at 0 is -infinity", Probability.normalQuantile(0) == -Double.infinity)
    h.check("normal quantile at 1 is infinity", Probability.normalQuantile(1) == Double.infinity)
    // The lower (p < 0.02425) and upper (p > 0.97575) tails use the outer
    // branches of Acklam's rational approximation; Phi^-1(0.001) = -3.090232.
    h.close("normal quantile lower tail", Probability.normalQuantile(0.001), -3.090232, tol: 1e-4)
    h.close("normal quantile upper tail", Probability.normalQuantile(0.999), 3.090232, tol: 1e-4)
    h.close("normal quantile at the median is 0", Probability.normalQuantile(0.5), 0, tol: 1e-9)

    // MARK: Credential LinkedIn link and issuer JSON (trailing-slash trim)
    let cred = Credential(recipientName: "Ada Lovelace", track: "dsp", role: "DSP Trader", year: 2026, month: 6, day: 21)
    let addURL = cred.linkedInAddURL(certURL: "https://example.com/verify.html")
    h.check("LinkedIn add URL targets the profile-add endpoint", addURL.contains("linkedin.com/profile/add"))
    h.check("LinkedIn add URL carries the certification task", addURL.contains("CERTIFICATION_NAME"))
    h.check("issuer JSON trims a trailing slash in the base URL",
            Credential.issuerJSON(baseURL: "https://example.com/").contains("\"https://example.com/issuer.json\""))
    h.check("issuer JSON without a trailing slash is unchanged",
            Credential.issuerJSON(baseURL: "https://example.com").contains("\"https://example.com/issuer.json\""))

    // MARK: Statistics empty-sample and zero-parameter guards
    h.close("mean of an empty sample is 0", Statistics.mean([]), 0)
    h.close("variance of an empty sample is 0", Statistics.variance([]), 0)
    h.close("standard error of proportion guards zero n", Statistics.standardErrorOfProportion(p: 0.5, n: 0), 0)
    h.close("z-score guards zero sd", Statistics.zScore(value: 5, mean: 0, sd: 0), 0)
    let wilson0 = Statistics.wilsonInterval(successes: 0, n: 0)
    h.check("wilson interval guards zero n", wilson0.low == 0 && wilson0.high == 0)
    let zt0 = Statistics.twoProportionZTest(successesA: 1, nA: 0, successesB: 1, nB: 10)
    h.check("two-proportion test guards zero n", zt0.z == 0 && zt0.pValue == 1)
    let ztFlat = Statistics.twoProportionZTest(successesA: 0, nA: 100, successesB: 0, nB: 100)
    h.check("two-proportion test guards zero pooled variance", ztFlat.z == 0 && ztFlat.pValue == 1)
    h.close("median of an empty sample is 0", Statistics.median([]), 0)
    h.close("percentile of an empty sample is 0", Statistics.percentile([], 0.5), 0)

    // MARK: CampaignData zero-input getters and verdict/parse edge branches
    let zeroLine = CampaignLine(name: "Z", impressions: 0, clicks: 0, conversions: 0, spend: 0, revenue: 0)
    h.close("line CTR guards zero impressions", zeroLine.ctr, 0)
    h.close("line CVR guards zero clicks", zeroLine.cvr, 0)
    h.close("line CPM guards zero impressions", zeroLine.cpm, 0)
    h.close("line CPC guards zero clicks", zeroLine.cpc, 0)
    h.close("line CPA guards zero conversions", zeroLine.cpa, 0)
    h.close("line ROAS guards zero spend", zeroLine.roas, 0)
    let zeroSum = CampaignData.summarize([])
    h.close("summary CPM guards zero impressions", zeroSum.cpm, 0)
    h.close("summary CPA guards zero conversions", zeroSum.cpa, 0)
    h.close("summary ROAS guards zero spend", zeroSum.roas, 0)
    h.check("verdict with no blended CPA is typical",
            CampaignData.verdict(line: CampaignLine(name: "A", impressions: 1000, clicks: 50, conversions: 5, spend: 100), blendedCPA: 0) == .typical)
    // A short row leaves later columns empty; a blank name becomes a "Line N" label.
    let edgeRows = "name,impressions,clicks,conversions,spend,revenue\nX,1000\n,2000,10,1,50,80"
    let edgeLines = CampaignData.parseCSV(edgeRows)
    h.check("a short row parses with later columns empty", edgeLines.first?.clicks == 0 && edgeLines.first?.spend == 0)
    h.check("a blank name becomes a generated label", edgeLines.last?.name == "Line 2")
}
