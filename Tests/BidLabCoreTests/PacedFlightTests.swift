import BidLabCore

/// Tests for the paced flight: determinism, budget respect, and pacing shape.
func pacedFlightTests(_ h: Harness) {
    let cfg = MarketSimulation.Config(
        opportunities: 50_000, bid: 0.5, budget: 0, marketMean: 0.45,
        ctr: 0.02, cvr: 0.10, revenuePerConversion: 500,
        model: .logNormal(sigma: 0.5), auction: .firstPrice
    )
    let flightBudget = 5_000.0
    let r = PacedFlight.run(baseConfig: cfg, flightBudget: flightBudget, intervals: 10, seed: 42)

    h.check("one point per interval", r.points.count == 10)
    h.check("paced flight is deterministic", r == PacedFlight.run(baseConfig: cfg, flightBudget: flightBudget, intervals: 10, seed: 42))
    h.check("total spend never exceeds the flight budget", r.totalSpend <= flightBudget + 1e-6)
    h.check("the flight delivers impressions", r.impressionsWon > 0)
    h.close("final on-pace target equals the full budget", r.points.last?.targetCumulativeSpend ?? -1, flightBudget, tol: 1e-6)
    h.close("final fraction elapsed is one", r.points.last?.fractionElapsed ?? -1, 1.0, tol: 1e-9)

    // Cumulative spend is non-decreasing across intervals.
    let nonDecreasing = zip(r.points, r.points.dropFirst()).allSatisfy { $0.cumulativeSpend <= $1.cumulativeSpend + 1e-9 }
    h.check("cumulative spend is non-decreasing", nonDecreasing)

    // The first interval applies no throttle overshoot (target and spend both start at zero).
    h.close("first interval throttle is the base", r.points.first?.throttle ?? -1, 1.0, tol: 1e-9)

    // A generous budget that cannot bind leaves utilization at or below one.
    h.check("budget utilization never exceeds one", r.budgetUtilization <= 1.0 + 1e-9)

    // Zero intervals is an empty flight, not a crash.
    let empty = PacedFlight.run(baseConfig: cfg, flightBudget: flightBudget, intervals: 0, seed: 1)
    h.check("zero intervals yields an empty flight", empty.points.isEmpty)
    h.close("empty flight spends nothing", empty.totalSpend, 0, tol: 1e-9)

    // Non-stationary market: intraday volatility varies per-interval volume, so
    // the throttle fights a moving target, and win rates stay valid.
    let varied = PacedFlight.run(baseConfig: cfg, flightBudget: flightBudget, intervals: 12, volatility: 0.35, seed: 7)
    h.check("intraday volatility varies per-interval volume", Set(varied.points.map { $0.opportunities }).count > 1)
    h.check("all interval win rates are within [0,1]", varied.points.allSatisfy { $0.winRate >= 0 && $0.winRate <= 1 })
    h.check("a non-stationary flight is deterministic",
            varied == PacedFlight.run(baseConfig: cfg, flightBudget: flightBudget, intervals: 12, volatility: 0.35, seed: 7))

    // Zero volatility reproduces a stationary market (constant per-interval volume).
    let flat = PacedFlight.run(baseConfig: cfg, flightBudget: flightBudget, intervals: 12, volatility: 0, seed: 7)
    h.check("zero volatility holds per-interval volume constant", Set(flat.points.map { $0.opportunities }).count == 1)
}
