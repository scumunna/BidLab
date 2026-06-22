import { describe, expect, it } from 'vitest'
import { ResponseCurve, BudgetAllocation, Systems } from './index'

// Ground truth from the real Swift BudgetAllocation and Systems engines.
describe('BudgetAllocation — greedy equimarginal parity with Swift', () => {
  const channels = [
    new ResponseCurve(1000, 30_000), // Search
    new ResponseCurve(700, 20_000), // Social
    new ResponseCurve(1400, 60_000), // CTV
  ]
  const alloc = BudgetAllocation.allocate(100_000, channels)

  it('allocates the budget across channels to match Swift', () => {
    expect(alloc[0]).toBeCloseTo(32850, 6)
    expect(alloc[1]).toBeCloseTo(22900, 6)
    expect(alloc[2]).toBeCloseTo(44250, 6)
    expect(alloc.reduce((a, b) => a + b, 0)).toBeCloseTo(100_000, 6)
  })

  it('total response beats an even split, matching Swift', () => {
    expect(BudgetAllocation.totalResponse(alloc, channels)).toBeCloseTo(1873.0721810503815, 6)
    const even = BudgetAllocation.totalResponse([100_000 / 3, 100_000 / 3, 100_000 / 3], channels)
    expect(even).toBeCloseTo(1835.3393011733951, 6)
  })
})

describe('Systems — latency / timeout / throughput parity with Swift', () => {
  it('latency quantiles match', () => {
    expect(Systems.latencyQuantile(40, 0.5)).toBeCloseTo(27.725887222397812, 9)
    expect(Systems.latencyQuantile(40, 0.99)).toBeCloseTo(184.20680743952363, 9)
  })
  it('timeout loss rates match', () => {
    expect(Systems.timeoutLossRate(40, 100)).toBeCloseTo(0.0820849986238988, 9)
    expect(Systems.timeoutLossRate(40, 200)).toBeCloseTo(0.006737946999085467, 9)
  })
  it('throughput capacity matches', () => {
    expect(Systems.capacityQPS(20, 5)).toBe(4000)
  })
})
