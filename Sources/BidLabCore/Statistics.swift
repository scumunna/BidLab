import Foundation

/// Descriptive statistics and sampling helpers used across the Analytics track
/// and any lesson that reports uncertainty (confidence intervals, standard
/// errors, z-scores).
public enum Statistics {
    public static func mean(_ xs: [Double]) -> Double {
        xs.isEmpty ? 0 : xs.reduce(0, +) / Double(xs.count)
    }

    /// Variance. Sample variance (divide by n-1) by default; population variance
    /// (divide by n) when `sample` is false.
    public static func variance(_ xs: [Double], sample: Bool = true) -> Double {
        let n = xs.count
        guard n > (sample ? 1 : 0) else { return 0 }
        let m = mean(xs)
        let ss = xs.reduce(0) { $0 + ($1 - m) * ($1 - m) }
        return ss / Double(sample ? n - 1 : n)
    }

    public static func standardDeviation(_ xs: [Double], sample: Bool = true) -> Double {
        sqrt(variance(xs, sample: sample))
    }

    /// Standard error of the mean: sd / sqrt(n).
    public static func standardError(_ xs: [Double]) -> Double {
        let n = xs.count
        guard n > 0 else { return 0 }
        return standardDeviation(xs) / sqrt(Double(n))
    }

    /// Standard error of a proportion: sqrt(p(1-p)/n).
    public static func standardErrorOfProportion(p: Double, n: Int) -> Double {
        n > 0 ? sqrt(p * (1 - p) / Double(n)) : 0
    }

    /// Normal-approximation confidence interval around a point estimate.
    /// Default z = 1.96 gives a 95% interval.
    public static func confidenceInterval(
        estimate: Double,
        standardError: Double,
        z: Double = 1.96
    ) -> (low: Double, high: Double) {
        (estimate - z * standardError, estimate + z * standardError)
    }

    public static func zScore(value: Double, mean: Double, sd: Double) -> Double {
        sd > 0 ? (value - mean) / sd : 0
    }

    /// The median (50th percentile) of a sample.
    public static func median(_ xs: [Double]) -> Double {
        guard !xs.isEmpty else { return 0 }
        let s = xs.sorted()
        let n = s.count
        return n % 2 == 1 ? s[n / 2] : (s[n / 2 - 1] + s[n / 2]) / 2
    }

    /// The p-th percentile (linear interpolation), p in 0...1. Real distributions
    /// are skewed, so percentiles tell you more than the mean.
    public static func percentile(_ xs: [Double], _ p: Double) -> Double {
        guard !xs.isEmpty else { return 0 }
        let s = xs.sorted()
        let rank = max(0, min(1, p)) * Double(s.count - 1)
        let lo = Int(rank.rounded(.down))
        let hi = Int(rank.rounded(.up))
        if lo == hi { return s[lo] }
        let w = rank - Double(lo)
        return s[lo] * (1 - w) + s[hi] * w
    }
}
