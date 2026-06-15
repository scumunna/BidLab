import Foundation

/// Budget pacing for the DSP track and the Trading Floor.
///
/// Even pacing spends the budget linearly across the flight. A proportional
/// controller nudges delivery up or down based on how far actual spend has
/// drifted from the on-pace target, which is the intuition behind real pacing
/// systems before the full PID treatment.
public enum Pacing {
    /// On-pace cumulative spend target at a point in the flight.
    /// `fractionElapsed` is 0 at the start and 1 at the end.
    public static func targetSpend(totalBudget: Double, fractionElapsed: Double) -> Double {
        totalBudget * max(0, min(1, fractionElapsed))
    }

    /// Proportional delivery throttle. Returns a multiplier around `base`: above
    /// it when behind pace (spend more), below it when ahead (spend less). The
    /// relative error is `(target - actual) / target`. Clamped to `bounds`.
    public static func throttle(
        targetSpend: Double,
        actualSpend: Double,
        base: Double = 1.0,
        gain: Double = 1.0,
        bounds: ClosedRange<Double> = 0...2
    ) -> Double {
        let denominator = max(targetSpend, 1e-9)
        let relativeError = (targetSpend - actualSpend) / denominator
        let adjusted = base + gain * relativeError
        return min(max(adjusted, bounds.lowerBound), bounds.upperBound)
    }

    /// Whether spend is ahead of pace at this point in the flight.
    public static func isAheadOfPace(totalBudget: Double, actualSpend: Double, fractionElapsed: Double) -> Bool {
        actualSpend > targetSpend(totalBudget: totalBudget, fractionElapsed: fractionElapsed)
    }
}
