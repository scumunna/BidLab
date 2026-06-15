import Foundation

/// The outcome of a single auction from the buyer's seat.
public struct AuctionOutcome: Equatable {
    public let won: Bool
    public let pricePaid: Double
    public let profit: Double

    public init(won: Bool, pricePaid: Double, profit: Double) {
        self.won = won
        self.pricePaid = pricePaid
        self.profit = profit
    }

    public static let lost = AuctionOutcome(won: false, pricePaid: 0, profit: 0)
}

/// Auction mechanics and bid optimization. Every formula is explicit so the
/// "open the hood" panel can show the exact math behind a simulated bid.
public enum Auction {
    /// The clearing price you face: the highest competing bid.
    public static func clearingPrice(competingBids: [Double]) -> Double {
        competingBids.max() ?? 0
    }

    /// Second-price (Vickrey) auction. You win when your bid beats every
    /// competing bid, and you pay the highest competing bid (the second price
    /// overall). Truthful bidding (`bid == value`) is optimal here, which is the
    /// key teaching point.
    public static func secondPrice(bid: Double, value: Double, competingBids: [Double]) -> AuctionOutcome {
        let market = clearingPrice(competingBids: competingBids)
        guard bid > market else { return .lost }
        return AuctionOutcome(won: true, pricePaid: market, profit: value - market)
    }

    /// First-price auction. You win when your bid beats every competing bid, and
    /// you pay your own bid. Surplus is `value - bid`, so optimal play shades the
    /// bid below value.
    public static func firstPrice(bid: Double, value: Double, competingBids: [Double]) -> AuctionOutcome {
        let market = clearingPrice(competingBids: competingBids)
        guard bid > market else { return .lost }
        return AuctionOutcome(won: true, pricePaid: bid, profit: value - bid)
    }

    /// Expected profit of a first-price bid given a win-probability curve.
    ///
    /// `E[profit] = P_win(bid) x (value - bid)`
    public static func expectedProfit(bid: Double, value: Double, winProbability: (Double) -> Double) -> Double {
        winProbability(bid) * (value - bid)
    }

    /// The profit-maximizing first-price bid for a given win-probability curve,
    /// found by a dense scan over `0...value`. Returns the bid and its expected
    /// profit. `steps` controls resolution.
    public static func optimalFirstPriceBid(
        value: Double,
        steps: Int = 1000,
        winProbability: (Double) -> Double
    ) -> (bid: Double, expectedProfit: Double) {
        guard value > 0, steps > 0 else { return (0, 0) }
        var bestBid = 0.0
        var bestProfit = -Double.greatestFiniteMagnitude
        for i in 0...steps {
            let bid = value * Double(i) / Double(steps)
            let profit = expectedProfit(bid: bid, value: value, winProbability: winProbability)
            if profit > bestProfit {
                bestProfit = profit
                bestBid = bid
            }
        }
        return (bestBid, bestProfit)
    }

    /// Bid shading factor: how far below value the optimal bid sits, as a
    /// fraction in `0...1`. A shade of 0.2 means bidding 20% below value.
    public static func shadeFactor(optimalBid: Double, value: Double) -> Double {
        value > 0 ? max(0, min(1, (value - optimalBid) / value)) : 0
    }
}
