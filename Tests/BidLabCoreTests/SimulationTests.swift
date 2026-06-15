import BidLabCore

/// Tests for the market simulation: determinism and convergence to the analytic
/// win-rate curve.
func simulationTests(_ h: Harness) {
    let config = MarketSimulation.Config(
        opportunities: 200_000,
        bid: 0.5,
        budget: 1_000_000_000,
        marketMean: 0.5,
        ctr: 0.02,
        cvr: 0.10,
        revenuePerConversion: 500
    )

    let a = MarketSimulation.run(config, seed: 42)
    let b = MarketSimulation.run(config, seed: 42)
    h.check("simulation is deterministic for a seed", a == b)

    // Win rate converges to 1 - e^(-bid/marketMean) = 1 - e^-1 = 0.6321.
    h.close("simulated win rate ~ analytic", a.winRate, config.analyticWinRate, tol: 0.01)

    // Click rate among won impressions converges to CTR.
    let clickRate = a.impressionsWon > 0 ? Double(a.clicks) / Double(a.impressionsWon) : 0
    h.close("simulated click rate ~ CTR", clickRate, config.ctr, tol: 0.006)

    // Win rate is monotonic in the bid.
    var low = config; low.bid = 0.3
    var high = config; high.bid = 0.7
    let lowRate = MarketSimulation.run(low, seed: 7).winRate
    let highRate = MarketSimulation.run(high, seed: 7).winRate
    h.check("higher bid wins more often", highRate > lowRate)

    // Log-normal market: win probability at the mean clearing price equals
    // Phi(sigma/2) = Phi(0.25) = 0.59871, and the simulation converges to it.
    let lnConfig = MarketSimulation.Config(
        opportunities: 200_000, bid: 0.5, budget: 1_000_000_000,
        marketMean: 0.5, ctr: 0.02, cvr: 0.10, revenuePerConversion: 500,
        model: .logNormal(sigma: 0.5)
    )
    h.close("log-normal win prob at mean is Phi(sigma/2)", lnConfig.winProbability(at: 0.5), 0.598706, tol: 1e-4)
    let lnRun = MarketSimulation.run(lnConfig, seed: 11)
    h.close("log-normal sim win rate ~ analytic", lnRun.winRate, lnConfig.analyticWinRate, tol: 0.01)
    h.check("log-normal sim is deterministic", lnRun == MarketSimulation.run(lnConfig, seed: 11))

    // Second-price: the optimal bid is truthful (bid = value), and the winner
    // pays the clearing price, so for the same bid it spends less than first-price.
    let spConfig = MarketSimulation.Config(
        opportunities: 200_000, bid: 1.0, budget: 1_000_000_000,
        marketMean: 0.45, ctr: 0.02, cvr: 0.10, revenuePerConversion: 500,
        model: .logNormal(sigma: 0.5), auction: .secondPrice
    )
    let spValue = spConfig.valuePerImpression
    h.close("second-price optimal bid ~ value", spConfig.optimal().bid, spValue, tol: spValue * 0.06)
    var fpConfig = spConfig
    fpConfig.auction = .firstPrice
    let spRun = MarketSimulation.run(spConfig, seed: 5)
    let fpRun = MarketSimulation.run(fpConfig, seed: 5)
    h.check("second-price wins the same as first-price for the same bid", spRun.impressionsWon == fpRun.impressionsWon)
    h.check("second-price spends less than first-price", spRun.spend < fpRun.spend)
}
