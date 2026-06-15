import Foundation

/// A diminishing-returns response curve for a channel or tactic.
///
/// `response(spend) = saturation * (1 - e^(-spend/scale))`
///
/// `saturation` is the most response the channel can ever produce; `scale` is the
/// spend at which it reaches about 63% of that ceiling. The marginal (derivative)
/// strictly decreases, which is what makes the equimarginal allocation work.
public struct ResponseCurve: Equatable {
    public let saturation: Double
    public let scale: Double

    public init(saturation: Double, scale: Double) {
        self.saturation = saturation
        self.scale = max(scale, 1e-9)
    }

    public func response(_ spend: Double) -> Double {
        saturation * (1 - exp(-max(0, spend) / scale))
    }

    /// Marginal response per extra dollar at the current spend.
    public func marginal(_ spend: Double) -> Double {
        (saturation / scale) * exp(-max(0, spend) / scale)
    }
}

/// Budget allocation across channels under diminishing returns.
public enum BudgetAllocation {
    /// Greedy marginal allocation: hand each small increment of budget to whichever
    /// channel currently has the highest marginal response. Because every marginal
    /// curve strictly decreases, this converges to the equimarginal optimum where
    /// all funded channels share the same marginal return.
    public static func allocate(budget: Double, channels: [ResponseCurve], steps: Int = 2000) -> [Double] {
        var allocation = Array(repeating: 0.0, count: channels.count)
        guard budget > 0, !channels.isEmpty, steps > 0 else { return allocation }
        let increment = budget / Double(steps)
        for _ in 0..<steps {
            var bestIndex = 0
            var bestMarginal = -Double.greatestFiniteMagnitude
            for (i, curve) in channels.enumerated() {
                let m = curve.marginal(allocation[i])
                if m > bestMarginal {
                    bestMarginal = m
                    bestIndex = i
                }
            }
            allocation[bestIndex] += increment
        }
        return allocation
    }

    /// Total response produced by an allocation.
    public static func totalResponse(allocation: [Double], channels: [ResponseCurve]) -> Double {
        zip(allocation, channels).reduce(0) { $0 + $1.1.response($1.0) }
    }
}
