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

    // Publisher reserve (floor). A bid below the floor never clears the reserve,
    // so it cannot win and every loss is attributed to the floor.
    var belowFloorCfg = lnConfig
    belowFloorCfg.floor = 0.6
    belowFloorCfg.bid = 0.5
    let belowFloor = MarketSimulation.run(belowFloorCfg, seed: 11)
    h.check("a bid below the floor never wins", belowFloor.impressionsWon == 0)
    h.check("a bid below the floor is all lost to floor", belowFloor.lostToFloor == belowFloorCfg.opportunities)
    h.close("win probability is zero below the floor", belowFloorCfg.winProbability(at: 0.5), 0, tol: 1e-9)

    // Above the floor, the win curve is unchanged from the no-floor case.
    var aboveFloorCfg = lnConfig
    aboveFloorCfg.floor = 0.3
    h.close("a floor the bid clears does not change the win curve",
            aboveFloorCfg.winProbability(at: 0.5), lnConfig.winProbability(at: 0.5), tol: 1e-12)

    // Second-price reserve: same wins (the bid clears the floor) but the winner
    // pays max(clearing, floor), so spend is strictly higher, and every
    // opportunity is accounted for as a win, a floor loss, or a competition loss.
    let reserveCfg = MarketSimulation.Config(
        opportunities: 200_000, bid: 1.0, budget: 1_000_000_000,
        marketMean: 0.45, floor: 0.4, ctr: 0.02, cvr: 0.10, revenuePerConversion: 500,
        model: .logNormal(sigma: 0.5), auction: .secondPrice
    )
    var noReserveCfg = reserveCfg
    noReserveCfg.floor = 0
    let withReserve = MarketSimulation.run(reserveCfg, seed: 5)
    let noReserve = MarketSimulation.run(noReserveCfg, seed: 5)
    h.check("a reserve the bid clears does not change who wins", withReserve.impressionsWon == noReserve.impressionsWon)
    h.check("a second-price reserve raises the price paid", withReserve.spend > noReserve.spend)
    h.check("every opportunity is a win, a floor loss, or a competition loss",
            withReserve.impressionsWon + withReserve.lostToFloor + withReserve.lostToCompetition == reserveCfg.opportunities)

    // Convenience getters on Result: a fully populated result and an empty one
    // exercise both sides of every divide-by-zero guard.
    let res = MarketSimulation.Result(opportunities: 1000, impressionsWon: 400, spend: 250,
                                      clicks: 8, conversions: 2, revenue: 1000,
                                      lostToFloor: 100, lostToCompetition: 500)
    h.close("result profit = revenue - spend", res.profit, 750)
    h.close("result win rate", res.winRate, 0.4)
    h.close("result effective CPA = spend / conversions", res.effectiveCPA, 125)
    h.close("result ROAS = revenue / spend", res.roas, 4)
    h.close("result floor-loss rate", res.lostToFloorRate, 0.1)
    h.close("result competition-loss rate", res.lostToCompetitionRate, 0.5)
    let blank = MarketSimulation.Result(opportunities: 0, impressionsWon: 0, spend: 0,
                                        clicks: 0, conversions: 0, revenue: 0)
    h.check("zero-conversion CPA is infinite", blank.effectiveCPA.isInfinite)
    h.check("zero-spend ROAS is infinite", blank.roas.isInfinite)
    h.close("zero-opportunity win rate is zero", blank.winRate, 0)
    h.close("zero-opportunity floor-loss rate is zero", blank.lostToFloorRate, 0)
    h.close("zero-opportunity competition-loss rate is zero", blank.lostToCompetitionRate, 0)

    // First-price expected profit per opportunity and the optimal-bid scan.
    // valuePerImpression = 0.02 * 0.10 * 500 = 1.0; bidding full value leaves zero surplus.
    let fpValue = config.valuePerImpression
    h.close("first-price surplus at bid = value is zero", config.expectedProfitPerOpportunity(at: fpValue), 0, tol: 1e-9)
    h.check("first-price optimal bid shades below value", config.optimal().bid < fpValue)
    h.check("first-price optimal profit is positive", config.optimal().expectedProfit > 0)
    var floored = config
    floored.floor = 0.5
    h.close("expected profit below a positive floor is zero", floored.expectedProfitPerOpportunity(at: 0.4), 0, tol: 1e-12)

    // Second-price expected profit under the exponential market exercises the
    // exponential competing-price density (the log-normal path is covered above).
    var spExp = config
    spExp.auction = .secondPrice
    h.check("second-price exponential optimal profit is positive", spExp.optimal().expectedProfit > 0)
}
