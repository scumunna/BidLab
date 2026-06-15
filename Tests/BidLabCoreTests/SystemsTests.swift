import BidLabCore

/// Tests for the DSP systems math.
func systemsTests(_ h: Harness) {
    // Exponential timeout loss: P(latency > 100ms) at mean 50ms = e^-2.
    h.close("timeout loss rate", Systems.timeoutLossRate(meanMs: 50, timeoutMs: 100), 0.1353352832, tol: 1e-7)

    // Latency median of an exponential = mean * ln(2).
    h.close("latency p50", Systems.latencyQuantile(meanMs: 50, p: 0.5), 50 * 0.6931471806, tol: 1e-6)
    // p99 tail is well past the mean.
    h.check("p99 exceeds the mean", Systems.latencyQuantile(meanMs: 50, p: 0.99) > 50)

    // Capacity: 10 workers at 5ms each = 2000 QPS.
    h.close("capacity QPS", Systems.capacityQPS(workers: 10, serviceMeanMs: 5), 2000)
    h.close("utilization", Systems.utilization(offeredQPS: 1000, capacityQPS: 2000), 0.5)

    // M/M/1: arrivals 100/s, service 200/s -> W = 1/(200-100) = 10ms.
    h.close("M/M/1 response time", Systems.mm1ResponseTimeMs(arrivalQPS: 100, serviceMeanMs: 5), 10, tol: 1e-9)
    h.check("saturated queue is infinite", Systems.mm1ResponseTimeMs(arrivalQPS: 300, serviceMeanMs: 5).isInfinite)

    // Error budget and unit cost.
    h.close("error budget at 99.9%", Systems.errorBudget(slo: 0.999), 0.001, tol: 1e-9)
    h.close("cost per query", Systems.costPerQuery(monthlyCost: 1000, monthlyQueries: 1_000_000), 0.001, tol: 1e-12)
}
