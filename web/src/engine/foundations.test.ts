import { describe, expect, it } from 'vitest'
import { Pricing, Analytics, Probability } from './index'

// Ground truth from the real Swift Pricing, Analytics, and Probability engines.
describe('Pricing — CPM/CPC/CPA parity with Swift', () => {
  it('derives CPC and CPA from a CPM', () => {
    const cpc = Pricing.cpc(8, 0.008)
    expect(cpc).toBeCloseTo(1, 12)
    expect(Pricing.cpa(cpc, 0.05)).toBeCloseTo(20, 12)
  })
})

describe('Analytics.adstock — carryover parity with Swift', () => {
  it('decays a single pulse geometrically', () => {
    const out = Analytics.adstock([0, 0, 100, 0, 0, 0, 0, 0, 0, 0], 0.5)
    expect(out).toEqual([0, 0, 100, 50, 25, 12.5, 6.25, 3.125, 1.5625, 0.78125])
  })
})

describe('Probability.normalPDF — parity with Swift', () => {
  it('matches the standard normal density', () => {
    expect(Probability.normalPDF(0)).toBeCloseTo(0.3989422804014327, 12)
    expect(Probability.normalPDF(1)).toBeCloseTo(0.24197072451914337, 12)
  })
})
