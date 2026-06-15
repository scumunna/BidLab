import Foundation

/// A reproducible RTB market simulation. This is the engine behind the hero
/// Trading Floor and the DSP capstone.
///
/// The competing top bid (the clearing price) is drawn from one of two models:
///
/// - `.exponential`: a memoryless market with mean `marketMean`, giving the
///   closed-form win rate `1 - e^(-bid / marketMean)`. Simple and the historical
///   default, kept so existing scenarios and tests are unchanged.
/// - `.logNormal(sigma:)`: clearing prices are log-normal with mean `marketMean`
///   and log-space spread `sigma`, so the win curve is the log-normal CDF, the
///   S-shaped bid landscape real desks actually face (and the one `dsp-03`
///   teaches). This is what the Trading Floor uses.
///
/// The auction can clear first-price (winner pays its own bid) or second-price
/// (winner pays the clearing price). Everything is deterministic for a seed, so
/// the transparency panel can show the formula and a test can verify it.
public enum MarketSimulation {
    public enum MarketModel: Equatable {
        case exponential
        case logNormal(sigma: Double)
    }

    public enum AuctionType: Equatable {
        case firstPrice
        case secondPrice
    }

    public struct Config: Equatable {
        public var opportunities: Int
        public var bid: Double            // your bid (price per impression)
        public var budget: Double
        public var marketMean: Double     // mean of the competing clearing price
        public var floor: Double          // publisher reserve: your bid must clear it
        public var ctr: Double
        public var cvr: Double
        public var revenuePerConversion: Double
        public var model: MarketModel
        public var auction: AuctionType

        public init(
            opportunities: Int,
            bid: Double,
            budget: Double,
            marketMean: Double,
            floor: Double = 0,
            ctr: Double,
            cvr: Double,
            revenuePerConversion: Double,
            model: MarketModel = .exponential,
            auction: AuctionType = .firstPrice
        ) {
            self.opportunities = opportunities
            self.bid = bid
            self.budget = budget
            self.marketMean = marketMean
            self.floor = floor
            self.ctr = ctr
            self.cvr = cvr
            self.revenuePerConversion = revenuePerConversion
            self.model = model
            self.auction = auction
        }

        /// Expected revenue per won impression: `CTR * CVR * revenuePerConversion`.
        public var valuePerImpression: Double {
            ctr * cvr * revenuePerConversion
        }

        /// Closed-form win probability for the current bid.
        public var analyticWinRate: Double { winProbability(at: bid) }

        /// Closed-form win probability at an arbitrary bid, given the market model.
        /// A bid below the publisher floor never clears the reserve, so its win
        /// probability is zero regardless of the competition.
        public func winProbability(at b: Double) -> Double {
            guard b > 0, b >= floor else { return 0 }
            switch model {
            case .exponential:
                return 1 - exp(-b / max(marketMean, 1e-9))
            case .logNormal(let sigma):
                let s = max(sigma, 1e-6)
                let mu = log(max(marketMean, 1e-9)) - s * s / 2
                return Self.normalCDF((log(b) - mu) / s)
            }
        }

        /// Expected profit per opportunity at a bid, for the chosen auction type.
        /// First-price: `P_win(b) * (value - b)`. Second-price: you win when the
        /// clearing price is below your bid and pay that price, so it is the
        /// integral of `(value - c)` over the clearing prices you beat.
        public func expectedProfitPerOpportunity(at b: Double) -> Double {
            guard b > 0, b >= floor else { return 0 } // below the reserve you never win
            switch auction {
            case .firstPrice:
                return winProbability(at: b) * (valuePerImpression - b)
            case .secondPrice:
                // You win when the clearing price is below your bid and pay
                // max(clearing, floor): the reserve raises the price when the
                // competition clears below it.
                let n = 400
                let h = b / Double(n)
                var sum = 0.0
                for i in 0...n {
                    let c = Double(i) * h
                    let w = (i == 0 || i == n) ? 0.5 : 1.0
                    sum += w * (valuePerImpression - max(c, floor)) * competingPDF(c)
                }
                return sum * h
            }
        }

        /// The profit-maximizing bid, found by scanning the expected-profit curve.
        public func optimal(steps: Int = 2000) -> (bid: Double, expectedProfit: Double) {
            let cap = max(valuePerImpression, 1e-9)
            var best = (bid: 0.0, expectedProfit: 0.0)
            for i in 1...steps {
                let b = cap * Double(i) / Double(steps)
                let p = expectedProfitPerOpportunity(at: b)
                if p > best.expectedProfit { best = (b, p) }
            }
            return best
        }

        /// Density of the competing clearing price, used to integrate second-price profit.
        func competingPDF(_ c: Double) -> Double {
            guard c > 0 else { return 0 }
            switch model {
            case .exponential:
                let m = max(marketMean, 1e-9)
                return exp(-c / m) / m
            case .logNormal(let sigma):
                let s = max(sigma, 1e-6)
                let mu = log(max(marketMean, 1e-9)) - s * s / 2
                let z = (log(c) - mu) / s
                return exp(-z * z / 2) / (c * s * 2.5066282746310002) // c*s*sqrt(2*pi)
            }
        }

        /// One competing-bid draw for the configured market model.
        func sampleCompeting(using rng: inout SeededRandom) -> Double {
            let u = Double.random(in: 0..<1, using: &rng)
            switch model {
            case .exponential:
                return -marketMean * log(1 - u)
            case .logNormal(let sigma):
                let s = max(sigma, 1e-6)
                let mu = log(max(marketMean, 1e-9)) - s * s / 2
                let u1 = 1 - u                 // in (0, 1], avoids log(0)
                let u2 = Double.random(in: 0..<1, using: &rng)
                let z = (-2 * log(u1)).squareRoot() * cos(2 * .pi * u2) // Box-Muller
                return exp(mu + s * z)
            }
        }

        /// Standard normal CDF via the error function.
        static func normalCDF(_ z: Double) -> Double {
            0.5 * (1 + erf(z / 1.4142135623730951))
        }
    }

    public struct Result: Equatable {
        public let opportunities: Int
        public let impressionsWon: Int
        public let spend: Double
        public let clicks: Int
        public let conversions: Int
        public let revenue: Double
        public let lostToFloor: Int        // your bid was below the publisher reserve
        public let lostToCompetition: Int  // you cleared the reserve but were outbid

        public init(
            opportunities: Int, impressionsWon: Int, spend: Double, clicks: Int,
            conversions: Int, revenue: Double, lostToFloor: Int = 0, lostToCompetition: Int = 0
        ) {
            self.opportunities = opportunities
            self.impressionsWon = impressionsWon
            self.spend = spend
            self.clicks = clicks
            self.conversions = conversions
            self.revenue = revenue
            self.lostToFloor = lostToFloor
            self.lostToCompetition = lostToCompetition
        }

        public var profit: Double { revenue - spend }
        public var winRate: Double { opportunities > 0 ? Double(impressionsWon) / Double(opportunities) : 0 }
        public var effectiveCPA: Double { conversions > 0 ? spend / Double(conversions) : .infinity }
        public var roas: Double { spend > 0 ? revenue / spend : .infinity }
        /// Share of all opportunities lost because the bid was under the reserve.
        public var lostToFloorRate: Double { opportunities > 0 ? Double(lostToFloor) / Double(opportunities) : 0 }
        /// Share of all opportunities lost to a higher competing bid.
        public var lostToCompetitionRate: Double { opportunities > 0 ? Double(lostToCompetition) / Double(opportunities) : 0 }
    }

    /// Run the campaign deterministically for the given seed.
    public static func run(_ config: Config, seed: UInt64) -> Result {
        var rng = SeededRandom(seed: seed)
        var won = 0
        var clicks = 0
        var conversions = 0
        var spend = 0.0
        var revenue = 0.0
        var lostToFloor = 0
        var lostToCompetition = 0

        for _ in 0..<config.opportunities {
            let competingBid = config.sampleCompeting(using: &rng)
            // Clear the publisher reserve first, then the competition.
            if config.bid < config.floor { lostToFloor += 1; continue }
            guard config.bid > competingBid else { lostToCompetition += 1; continue }
            // Second-price pays max(clearing, floor); the reserve is the price when
            // the competition clears below it. First-price pays your bid.
            let pay = config.auction == .secondPrice ? max(competingBid, config.floor) : config.bid
            if spend + pay > config.budget { continue } // budget binds on actual payment

            won += 1
            spend += pay
            if Double.random(in: 0..<1, using: &rng) < config.ctr {
                clicks += 1
                if Double.random(in: 0..<1, using: &rng) < config.cvr {
                    conversions += 1
                    revenue += config.revenuePerConversion
                }
            }
        }

        return Result(
            opportunities: config.opportunities,
            impressionsWon: won,
            spend: spend,
            clicks: clicks,
            conversions: conversions,
            revenue: revenue,
            lostToFloor: lostToFloor,
            lostToCompetition: lostToCompetition
        )
    }
}
