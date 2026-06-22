import Foundation

/// A paced flight: instead of one static bid over the whole campaign, split the
/// opportunities into intervals and adjust the bid each interval with the
/// proportional pacing throttle, so spend tracks the on-pace target and respects
/// the flight budget. This is the difference between the one-shot Trading Floor
/// and how a real desk actually runs a flight.
public enum PacedFlight {
    public struct IntervalPoint: Equatable {
        public let index: Int
        public let fractionElapsed: Double          // (index + 1) / intervals
        public let bid: Double                      // throttled bid used this interval
        public let throttle: Double                 // pacing multiplier applied
        public let impressionsWon: Int
        public let opportunities: Int               // bid requests this interval (varies intraday)
        public let conversions: Int
        public let spend: Double
        public let cumulativeSpend: Double
        public let targetCumulativeSpend: Double    // on-pace target at this point
        public let winRate: Double                  // impressionsWon / opportunities this interval

        public init(index: Int, fractionElapsed: Double, bid: Double, throttle: Double,
                    impressionsWon: Int, opportunities: Int, conversions: Int, spend: Double,
                    cumulativeSpend: Double, targetCumulativeSpend: Double, winRate: Double) {
            self.index = index
            self.fractionElapsed = fractionElapsed
            self.bid = bid
            self.throttle = throttle
            self.impressionsWon = impressionsWon
            self.opportunities = opportunities
            self.conversions = conversions
            self.spend = spend
            self.cumulativeSpend = cumulativeSpend
            self.targetCumulativeSpend = targetCumulativeSpend
            self.winRate = winRate
        }
    }

    public struct Result: Equatable {
        public let points: [IntervalPoint]
        public let totalSpend: Double
        public let impressionsWon: Int
        public let conversions: Int
        public let revenue: Double
        public let flightBudget: Double

        public init(points: [IntervalPoint], totalSpend: Double, impressionsWon: Int,
                    conversions: Int, revenue: Double, flightBudget: Double) {
            self.points = points
            self.totalSpend = totalSpend
            self.impressionsWon = impressionsWon
            self.conversions = conversions
            self.revenue = revenue
            self.flightBudget = flightBudget
        }

        public var profit: Double { revenue - totalSpend }
        public var budgetUtilization: Double { flightBudget > 0 ? totalSpend / flightBudget : 0 }
        /// How far final spend landed from spending the whole budget, in `0...1`.
        public var pacingError: Double { flightBudget > 0 ? abs(totalSpend - flightBudget) / flightBudget : 0 }
    }

    /// Run the paced flight. `baseConfig.bid` is the trader's chosen base bid;
    /// each interval it is scaled by the pacing throttle and capped at value.
    /// The per-interval budget is the remaining flight budget, so total spend can
    /// never exceed `flightBudget`.
    /// `volatility` (0...) sets how much the market swings intraday: each interval
    /// scales opportunity volume and the competing-price mean by a diurnal curve,
    /// so the pacing throttle has to fight real under- and over-delivery instead
    /// of a flat stationary market. `volatility: 0` reproduces the stationary run.
    public static func run(
        baseConfig: MarketSimulation.Config,
        flightBudget: Double,
        intervals: Int,
        gain: Double = 1.0,
        volatility: Double = 0.35,
        seed: UInt64
    ) -> Result {
        guard intervals > 0 else {
            return Result(points: [], totalSpend: 0, impressionsWon: 0, conversions: 0, revenue: 0, flightBudget: flightBudget)
        }
        let perInterval = max(1, baseConfig.opportunities / intervals)
        let baseBid = baseConfig.bid
        let valueCap = max(baseConfig.valuePerImpression, 1e-6)

        var points: [IntervalPoint] = []
        var cumulativeSpend = 0.0
        var totalWon = 0
        var totalConversions = 0
        var totalRevenue = 0.0

        for i in 0..<intervals {
            // Throttle against where cumulative spend should be at the start of
            // this interval. At i = 0 the target is 0 and spend is 0, so the
            // throttle is exactly the base (no first-interval overshoot).
            let startFraction = Double(i) / Double(intervals)
            let target = Pacing.targetSpend(totalBudget: flightBudget, fractionElapsed: startFraction)
            let throttle = Pacing.throttle(targetSpend: target, actualSpend: cumulativeSpend, gain: gain)
            let bid = min(max(baseBid * throttle, 1e-6), valueCap)

            // Intraday market: volume and competition swing on offset sinusoids.
            let mid = (Double(i) + 0.5) / Double(intervals)
            let volumeMultiplier = max(0.2, 1 + volatility * sin(2 * .pi * mid))
            let competitionMultiplier = max(0.2, 1 + volatility * cos(2 * .pi * mid))
            let intervalOpportunities = max(1, Int(Double(perInterval) * volumeMultiplier))

            var cfg = baseConfig
            cfg.bid = bid
            cfg.opportunities = intervalOpportunities
            cfg.marketMean = baseConfig.marketMean * competitionMultiplier
            cfg.budget = max(0, flightBudget - cumulativeSpend) // cannot exceed the flight budget
            let r = MarketSimulation.run(cfg, seed: seed &+ UInt64(i))

            cumulativeSpend += r.spend
            totalWon += r.impressionsWon
            totalConversions += r.conversions
            totalRevenue += r.revenue

            let endFraction = Double(i + 1) / Double(intervals)
            points.append(IntervalPoint(
                index: i,
                fractionElapsed: endFraction,
                bid: bid,
                throttle: throttle,
                impressionsWon: r.impressionsWon,
                opportunities: intervalOpportunities,
                conversions: r.conversions,
                spend: r.spend,
                cumulativeSpend: cumulativeSpend,
                targetCumulativeSpend: Pacing.targetSpend(totalBudget: flightBudget, fractionElapsed: endFraction),
                winRate: Double(r.impressionsWon) / Double(intervalOpportunities) // intervalOpportunities is max(1, ...), always >= 1
            ))
        }

        return Result(points: points, totalSpend: cumulativeSpend, impressionsWon: totalWon,
                      conversions: totalConversions, revenue: totalRevenue, flightBudget: flightBudget)
    }
}
