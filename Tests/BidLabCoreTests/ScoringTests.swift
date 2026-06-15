import BidLabCore

/// Tests for the scoring and benchmarking engine.
func scoringTests(_ h: Harness) {
    let value = 1.0          // ctr*cvr*rev = 0.02*0.10*500
    let marketMean = 0.5

    // At bid 0 and at bid = value, expected profit per opportunity is 0.
    h.close("no profit at zero bid", Scoring.expectedProfitPerOpportunity(bid: 0, valuePerImpression: value, marketMean: marketMean), 0, tol: 1e-9)
    h.close("no profit when bidding full value", Scoring.expectedProfitPerOpportunity(bid: value, valuePerImpression: value, marketMean: marketMean), 0, tol: 1e-9)

    let optimal = Scoring.optimalBid(valuePerImpression: value, marketMean: marketMean)
    h.check("optimal bid is interior", optimal.bid > 0 && optimal.bid < value)
    h.check("optimal expected profit is positive", optimal.expectedProfit > 0)
    // Optimal beats nearby bids.
    for probe in [0.1, 0.25, 0.4, 0.6, 0.8] {
        let p = Scoring.expectedProfitPerOpportunity(bid: probe, valuePerImpression: value, marketMean: marketMean)
        h.check("optimal >= profit at bid \(probe)", optimal.expectedProfit + 1e-9 >= p)
    }

    // Score mapping.
    h.close("optimal play scores 100", Scoring.score(achievedProfit: 10, optimalProfit: 10), 100)
    h.close("break-even scores 0", Scoring.score(achievedProfit: 0, optimalProfit: 10), 0)
    h.close("half-optimal scores 50", Scoring.score(achievedProfit: 5, optimalProfit: 10), 50)
    h.close("above optimal caps at 100", Scoring.score(achievedProfit: 15, optimalProfit: 10), 100)
    h.close("negative profit floors at 0", Scoring.score(achievedProfit: -5, optimalProfit: 10), 0)

    // Percentile within a field.
    let field = [10.0, 20, 30, 40]
    h.close("percentile mid-field", Scoring.percentile(of: 25, field: field), 50)
    h.close("percentile bottom", Scoring.percentile(of: 5, field: field), 0)
    h.close("percentile top", Scoring.percentile(of: 100, field: field), 100)
}
