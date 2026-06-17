import { describe, expect, it } from 'vitest'
import { Attribution, Analytics, Yield } from './index'

// Ground truth from the real Swift Attribution and Analytics engines.
describe('Attribution — parity with Swift (4 touchpoints)', () => {
  it('last-touch gives all credit to the final touch', () => {
    expect(Attribution.lastTouch(4)).toEqual([0, 0, 0, 1])
  })
  it('linear splits credit evenly', () => {
    const v = Attribution.linear(4)
    v.forEach((c) => expect(c).toBeCloseTo(0.25, 12))
    expect(v.reduce((a, b) => a + b, 0)).toBeCloseTo(1, 12)
  })
  it('position-based is U-shaped (0.4 / 0.1 / 0.1 / 0.4)', () => {
    const v = Attribution.positionBased(4)
    expect(v[0]).toBeCloseTo(0.4, 12)
    expect(v[3]).toBeCloseTo(0.4, 12)
    expect(v[1]).toBeCloseTo(0.1, 9)
    expect(v[2]).toBeCloseTo(0.1, 9)
    expect(v.reduce((a, b) => a + b, 0)).toBeCloseTo(1, 9)
  })
})

describe('Analytics.linearFit — forecast parity with Swift', () => {
  const history = [10, 12, 11, 14, 16, 15, 18, 20]
  const xs = history.map((_, i) => i)
  const fit = Analytics.linearFit(xs, history)

  it('matches the Swift OLS fit', () => {
    expect(fit.slope).toBeCloseTo(1.3571428571428572, 9)
    expect(fit.intercept).toBeCloseTo(9.75, 9)
    expect(fit.r2).toBeCloseTo(0.9209183673469388, 9)
  })
  it('projects forward to match Swift', () => {
    const projected = fit.intercept + fit.slope * (history.length - 1 + 4)
    expect(projected).toBeCloseTo(24.67857142857143, 9)
  })
})

describe('Yield — floor/fill tradeoff (closed form)', () => {
  it('fill is the exponential of the floor over mean demand', () => {
    expect(Yield.fillRate(4, 2)).toBeCloseTo(Math.exp(-0.5), 12)
    expect(Yield.fillRate(4, 0)).toBeCloseTo(1, 12)
  })
  it('revenue is maximized at floor = mean demand', () => {
    const avails = 20_000_000
    const atOptimal = Yield.revenue(avails, 4, Yield.optimalFloor(4))
    expect(atOptimal).toBeGreaterThan(Yield.revenue(avails, 4, 3))
    expect(atOptimal).toBeGreaterThan(Yield.revenue(avails, 4, 5))
  })
})
