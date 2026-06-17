// Port of BidLabCore/Systems.swift. DSP systems math: latency tails, timeout
// loss, throughput, and queueing. The real-time constraint (bid in under ~100ms)
// is what shapes bidder design.

/** Latency quantile for exponential service time: `quantile(p) = -mean·ln(1-p)`. */
export function latencyQuantile(meanMs: number, p: number): number {
  if (!(meanMs > 0) || !(p > 0) || !(p < 1)) return p <= 0 ? 0 : Infinity
  return -meanMs * Math.log(1 - p)
}

/** Share of bid requests lost to a timeout: `P(latency > timeout) = e^(-timeout/mean)`. */
export function timeoutLossRate(meanMs: number, timeoutMs: number): number {
  if (!(meanMs > 0)) return 0
  return Math.exp(-timeoutMs / meanMs)
}

/** Throughput capacity in QPS for `workers` each handling a request in `serviceMeanMs`. */
export function capacityQPS(workers: number, serviceMeanMs: number): number {
  if (!(serviceMeanMs > 0)) return 0
  return (workers * 1000) / serviceMeanMs
}

/** Utilization: offered load over capacity (0...1 when healthy). */
export function utilization(offeredQPS: number, capacity: number): number {
  return capacity > 0 ? offeredQPS / capacity : Infinity
}

/** Mean response time of an M/M/1 queue in ms; Infinity when saturated. */
export function mm1ResponseTimeMs(arrivalQPS: number, serviceMeanMs: number): number {
  if (!(serviceMeanMs > 0)) return Infinity
  const mu = 1000 / serviceMeanMs
  if (!(arrivalQPS < mu)) return Infinity
  return 1000 / (mu - arrivalQPS)
}
