import { describe, expect, it } from 'vitest'
import { Tracking } from './index'

// These mirror the worked numbers taught in core-08 / adops-13 / adops-14.
describe('Tracking — capture rate', () => {
  it('matches the adops-13 worked example (920 of 1,000)', () => {
    expect(Tracking.captureRate(920, 1000)).toBeCloseTo(0.92, 12)
    expect(Tracking.leakage(920, 1000)).toBeCloseTo(0.08, 12)
  })
  it('is zero with no back-end count', () => {
    expect(Tracking.captureRate(100, 0)).toBe(0)
  })
})

describe('Tracking — dedup inflation', () => {
  it('matches adops-14: 1,000 true with 20% unmatched reports 1,200', () => {
    expect(Tracking.dedupedTotal(1000, 0.2)).toBeCloseTo(1200, 9)
    expect(Tracking.dedupInflation(0.2)).toBeCloseTo(0.2, 12)
  })
  it('matches core-08: 30% unmatched inflates by 30%', () => {
    expect(Tracking.dedupedTotal(1000, 0.3)).toBeCloseTo(1300, 9)
  })
  it('perfect matching adds nothing', () => {
    expect(Tracking.dedupedTotal(1000, 0)).toBe(1000)
  })
})

describe('Tracking — discrepancy and the normal band', () => {
  it('matches core-08 (1,050,000 vs 1,000,000 ~= 4.76%)', () => {
    const d = Tracking.discrepancy(1_050_000, 1_000_000)
    expect(d).toBeCloseTo(0.047619, 5)
    expect(Tracking.withinNormalBand(d)).toBe(true)
  })
  it('flags a 16.67% gap as outside the band', () => {
    const d = Tracking.discrepancy(1_200_000, 1_000_000)
    expect(d).toBeCloseTo(0.166667, 5)
    expect(Tracking.withinNormalBand(d)).toBe(false)
  })
})
