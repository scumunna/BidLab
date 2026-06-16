import Foundation

/// Measurement and data-science math for the Analytics track: experiment design
/// (power and sample size), causal lift (difference-in-differences), and the
/// media-mix building blocks (adstock, saturation, linear fit).
public enum Analytics {
    /// Required sample size per arm for a two-proportion A/B test to detect an
    /// absolute lift `mde` over `baselineRate`, at significance `alpha`
    /// (two-sided) and the target `power`.
    public static func sampleSizePerArm(
        baselineRate: Double,
        mde: Double,
        alpha: Double = 0.05,
        power: Double = 0.80
    ) -> Int {
        guard mde != 0, baselineRate > 0, baselineRate < 1 else { return 0 }
        let p1 = baselineRate
        let p2 = min(max(baselineRate + mde, 0), 1)
        let pBar = (p1 + p2) / 2
        let zAlpha = Probability.normalQuantile(1 - alpha / 2)
        let zBeta = Probability.normalQuantile(power)
        let term = zAlpha * sqrt(2 * pBar * (1 - pBar)) + zBeta * sqrt(p1 * (1 - p1) + p2 * (1 - p2))
        let n = (term * term) / (mde * mde)
        return Int(ceil(n))
    }

    /// Statistical power of a two-proportion test given `nPerArm`.
    public static func power(
        baselineRate: Double,
        mde: Double,
        nPerArm: Int,
        alpha: Double = 0.05
    ) -> Double {
        guard nPerArm > 0, baselineRate > 0, baselineRate < 1 else { return 0 }
        let p1 = baselineRate
        let p2 = min(max(baselineRate + mde, 0), 1)
        let se = sqrt(p1 * (1 - p1) / Double(nPerArm) + p2 * (1 - p2) / Double(nPerArm))
        guard se > 0 else { return 0 }
        let zAlpha = Probability.normalQuantile(1 - alpha / 2)
        let z = abs(mde) / se - zAlpha
        return Probability.normalCDF(z)
    }

    /// Difference-in-differences lift: the treatment group's change minus the
    /// control group's change. Isolates the incremental effect from a shared trend.
    public static func differenceInDifferences(
        treatmentPre: Double,
        treatmentPost: Double,
        controlPre: Double,
        controlPost: Double
    ) -> Double {
        (treatmentPost - treatmentPre) - (controlPost - controlPre)
    }

    /// Difference-in-differences with uncertainty. Given each cell's standard
    /// error (the four group means are independent), the DiD standard error is
    /// the root-sum-of-squares, and the estimate comes with a confidence
    /// interval, so a reported lift is never just a point number.
    public static func differenceInDifferences(
        treatmentPre: Double, treatmentPost: Double, controlPre: Double, controlPost: Double,
        standardErrors se: (tPre: Double, tPost: Double, cPre: Double, cPost: Double),
        z: Double = 1.96
    ) -> (estimate: Double, standardError: Double, ciLow: Double, ciHigh: Double) {
        let estimate = (treatmentPost - treatmentPre) - (controlPost - controlPre)
        let seD = (se.tPre * se.tPre + se.tPost * se.tPost + se.cPre * se.cPre + se.cPost * se.cPost).squareRoot()
        return (estimate, seD, estimate - z * seD, estimate + z * seD)
    }

    /// Geometric adstock: `a_t = x_t + decay * a_{t-1}`. Models advertising
    /// carryover, where today's impact lingers into future periods.
    public static func adstock(_ series: [Double], decay: Double) -> [Double] {
        var out: [Double] = []
        var carry = 0.0
        for x in series {
            carry = x + decay * carry
            out.append(carry)
        }
        return out
    }

    /// Hill saturation in 0...1: `x^shape / (x^shape + halfSaturation^shape)`.
    /// Captures diminishing returns where each extra unit of spend converts less.
    public static func hillSaturation(_ x: Double, halfSaturation: Double, shape: Double = 1) -> Double {
        guard x > 0, halfSaturation > 0 else { return 0 }
        let xs = pow(x, shape)
        return xs / (xs + pow(halfSaturation, shape))
    }

    /// Ordinary least squares fit of y = slope*x + intercept, with R-squared.
    public static func linearFit(xs: [Double], ys: [Double]) -> (slope: Double, intercept: Double, r2: Double) {
        let n = min(xs.count, ys.count)
        guard n >= 2 else { return (0, 0, 0) }
        let meanX = Statistics.mean(Array(xs.prefix(n)))
        let meanY = Statistics.mean(Array(ys.prefix(n)))
        var sxy = 0.0, sxx = 0.0, syy = 0.0
        for i in 0..<n {
            let dx = xs[i] - meanX
            let dy = ys[i] - meanY
            sxy += dx * dy
            sxx += dx * dx
            syy += dy * dy
        }
        guard sxx > 0 else { return (0, meanY, 0) }
        let slope = sxy / sxx
        let intercept = meanY - slope * meanX
        let r2 = syy > 0 ? (sxy * sxy) / (sxx * syy) : 1
        return (slope, intercept, r2)
    }
}
