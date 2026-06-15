import Foundation

/// DSP systems math for the Engineering track: latency tails, timeout loss,
/// throughput, and queueing. The real-time constraint (a bid in under ~100ms)
/// is what shapes bidder design, so these turn that constraint into numbers.
public enum Systems {
    /// Latency quantile for an exponential service time with mean `meanMs`.
    /// `quantile(p) = -mean * ln(1 - p)`. The p99 tail is far past the mean.
    public static func latencyQuantile(meanMs: Double, p: Double) -> Double {
        guard meanMs > 0, p > 0, p < 1 else { return p <= 0 ? 0 : .infinity }
        return -meanMs * log(1 - p)
    }

    /// Share of bid requests lost to a timeout, for exponential latency:
    /// `P(latency > timeout) = e^(-timeout/mean)`.
    public static func timeoutLossRate(meanMs: Double, timeoutMs: Double) -> Double {
        guard meanMs > 0 else { return 0 }
        return exp(-timeoutMs / meanMs)
    }

    /// Throughput capacity in queries per second for `workers` each handling one
    /// request in `serviceMeanMs`.
    public static func capacityQPS(workers: Int, serviceMeanMs: Double) -> Double {
        guard serviceMeanMs > 0 else { return 0 }
        return Double(workers) * 1000.0 / serviceMeanMs
    }

    /// Utilization: offered load divided by capacity (0...1 when healthy).
    public static func utilization(offeredQPS: Double, capacityQPS: Double) -> Double {
        capacityQPS > 0 ? offeredQPS / capacityQPS : .infinity
    }

    /// Mean response time of an M/M/1 queue, in milliseconds. As arrival rate
    /// approaches service rate the wait explodes, which is why headroom matters.
    /// Returns infinity when the system is saturated (`arrivalQPS >= serviceQPS`).
    public static func mm1ResponseTimeMs(arrivalQPS: Double, serviceMeanMs: Double) -> Double {
        guard serviceMeanMs > 0 else { return .infinity }
        let mu = 1000.0 / serviceMeanMs        // service rate per second
        guard arrivalQPS < mu else { return .infinity }
        return 1000.0 / (mu - arrivalQPS)      // 1/(mu - lambda), converted to ms
    }

    /// The error budget implied by a service-level objective: `1 - SLO`. A 99.9%
    /// SLO leaves a 0.1% budget for failures and maintenance.
    public static func errorBudget(slo: Double) -> Double {
        max(0, min(1, 1 - slo))
    }

    /// Cost per query from a monthly spend and query volume. The unit economics
    /// that decide whether a bidder is profitable at scale.
    public static func costPerQuery(monthlyCost: Double, monthlyQueries: Double) -> Double {
        monthlyQueries > 0 ? monthlyCost / monthlyQueries : .infinity
    }
}
