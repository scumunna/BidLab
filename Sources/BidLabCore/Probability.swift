import Foundation

/// Probability and distribution helpers used across the curriculum (expected
/// value, the impression-counting distributions, and the normal curve for
/// confidence intervals and tests). Implemented with log-gamma so large counts
/// stay numerically stable.
public enum Probability {
    /// Expected value of a discrete distribution.
    ///
    /// `E[X] = sum(x_i * p_i)`. `values` and `probabilities` must be the same length.
    public static func expectedValue(values: [Double], probabilities: [Double]) -> Double {
        zip(values, probabilities).reduce(0) { $0 + $1.0 * $1.1 }
    }

    /// Log of the binomial coefficient C(n, k), via log-gamma.
    public static func logChoose(_ n: Int, _ k: Int) -> Double {
        guard k >= 0, k <= n else { return -.infinity }
        return lgamma(Double(n) + 1) - lgamma(Double(k) + 1) - lgamma(Double(n - k) + 1)
    }

    /// Binomial pmf: P(X = k) for n trials at success probability p.
    ///
    /// `C(n,k) * p^k * (1-p)^(n-k)`
    public static func binomialPMF(k: Int, n: Int, p: Double) -> Double {
        guard k >= 0, k <= n, p >= 0, p <= 1 else { return 0 }
        if p == 0 { return k == 0 ? 1 : 0 }
        if p == 1 { return k == n ? 1 : 0 }
        let logP = logChoose(n, k) + Double(k) * log(p) + Double(n - k) * log(1 - p)
        return exp(logP)
    }

    /// Poisson pmf: P(X = k) for rate lambda. Models impression / arrival counts.
    ///
    /// `lambda^k * e^(-lambda) / k!`
    public static func poissonPMF(k: Int, lambda: Double) -> Double {
        guard k >= 0, lambda >= 0 else { return 0 }
        if lambda == 0 { return k == 0 ? 1 : 0 }
        let logP = Double(k) * log(lambda) - lambda - lgamma(Double(k) + 1)
        return exp(logP)
    }

    /// Standard normal probability density at x.
    public static func normalPDF(_ x: Double, mean: Double = 0, sd: Double = 1) -> Double {
        guard sd > 0 else { return 0 }
        let z = (x - mean) / sd
        return exp(-0.5 * z * z) / (sd * sqrt(2 * Double.pi))
    }

    /// Normal cumulative probability P(X <= x), via the error function.
    public static func normalCDF(_ x: Double, mean: Double = 0, sd: Double = 1) -> Double {
        guard sd > 0 else { return x < mean ? 0 : 1 }
        return 0.5 * (1 + erf((x - mean) / (sd * sqrt(2))))
    }

    /// Inverse normal CDF (quantile function) via Acklam's rational approximation.
    /// `normalQuantile(0.975) ~ 1.95996`. Needed for power and sample-size math.
    public static func normalQuantile(_ p: Double, mean: Double = 0, sd: Double = 1) -> Double {
        guard p > 0, p < 1 else { return p <= 0 ? -.infinity : .infinity }
        let a = [-3.969683028665376e+01, 2.209460984245205e+02, -2.759285104469687e+02,
                 1.383577518672690e+02, -3.066479806614716e+01, 2.506628277459239e+00]
        let b = [-5.447609879822406e+01, 1.615858368580409e+02, -1.556989798598866e+02,
                 6.680131188771972e+01, -1.328068155288572e+01]
        let c = [-7.784894002430293e-03, -3.223964580411365e-01, -2.400758277161838e+00,
                 -2.549732539343734e+00, 4.374664141464968e+00, 2.938163982698783e+00]
        let d = [7.784695709041462e-03, 3.224671290700398e-01, 2.445134137142996e+00,
                 3.754408661907416e+00]
        let plow = 0.02425
        let phigh = 1 - plow
        var z: Double
        if p < plow {
            let q = sqrt(-2 * log(p))
            z = (((((c[0] * q + c[1]) * q + c[2]) * q + c[3]) * q + c[4]) * q + c[5]) /
                ((((d[0] * q + d[1]) * q + d[2]) * q + d[3]) * q + 1)
        } else if p <= phigh {
            let q = p - 0.5
            let r = q * q
            z = (((((a[0] * r + a[1]) * r + a[2]) * r + a[3]) * r + a[4]) * r + a[5]) * q /
                (((((b[0] * r + b[1]) * r + b[2]) * r + b[3]) * r + b[4]) * r + 1)
        } else {
            let q = sqrt(-2 * log(1 - p))
            z = -(((((c[0] * q + c[1]) * q + c[2]) * q + c[3]) * q + c[4]) * q + c[5]) /
                ((((d[0] * q + d[1]) * q + d[2]) * q + d[3]) * q + 1)
        }
        return mean + sd * z
    }
}
