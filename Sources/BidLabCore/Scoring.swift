import Foundation

/// Scoring and benchmarking. Every simulation can be graded against the
/// mathematically optimal strategy and placed within a field of other results,
/// which powers both the learning feedback loop and the assessment.
public enum Scoring {
    /// Expected profit per opportunity for a first-price bid into an exponential
    /// market: `(1 - e^(-bid/marketMean)) * (value - bid)`.
    public static func expectedProfitPerOpportunity(bid: Double, valuePerImpression: Double, marketMean: Double) -> Double {
        let winProbability = 1 - exp(-bid / max(marketMean, 1e-9))
        return winProbability * (valuePerImpression - bid)
    }

    /// The profit-maximizing bid for a given value and market, found by scanning
    /// the same win-probability curve the simulation uses.
    public static func optimalBid(valuePerImpression: Double, marketMean: Double, steps: Int = 4000) -> (bid: Double, expectedProfit: Double) {
        Auction.optimalFirstPriceBid(value: valuePerImpression, steps: steps) { bid in
            1 - exp(-bid / max(marketMean, 1e-9))
        }
    }

    /// A 0...100 score: how close achieved profit came to the optimal achievable
    /// profit. Optimal play scores 100; breaking even against a positive optimum
    /// scores 0.
    public static func score(achievedProfit: Double, optimalProfit: Double) -> Double {
        guard optimalProfit > 0 else { return achievedProfit >= 0 ? 100 : 0 }
        return max(0, min(1, achievedProfit / optimalProfit)) * 100
    }

    /// Percentile rank of a score within a benchmark field (share of the field
    /// strictly below it), in 0...100.
    public static func percentile(of score: Double, field: [Double]) -> Double {
        guard !field.isEmpty else { return 0 }
        let below = field.reduce(0) { $0 + ($1 < score ? 1 : 0) }
        return Double(below) / Double(field.count) * 100
    }
}
