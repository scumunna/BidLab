import { describe, expect, it } from 'vitest'
import * as RF from './reachFrequency'
import * as AN from './analytics'
import { poissonPMF, normalQuantile } from './probability'

// Ground truth dumped from the real BidLabCore Swift engine
// (Probability/Statistics/Analytics/ReachFrequency.swift). See /tmp/bidlab_golden/main.swift.

describe('ReachFrequency — parity with Swift (population = 1,000,000)', () => {
  const POP = 1_000_000
  const cases = [
    { impressions: 500_000, reachFraction: 0.3934693402873666, avgFrequency: 1.270747041268399, eff2: 0.09020401043104986, eff3: 0.014387677966970713 },
    { impressions: 1_000_000, reachFraction: 0.6321205588285576, avgFrequency: 1.5819767068693267, eff2: 0.26424111765711533, eff3: 0.08030139707139416 },
    { impressions: 2_000_000, reachFraction: 0.8646647167633873, avgFrequency: 2.3130352854993315, eff2: 0.5939941502901618, eff3: 0.3233235838169366 },
    { impressions: 3_000_000, reachFraction: 0.950212931632136, avgFrequency: 3.157187089473768, eff2: 0.8008517265285442, eff3: 0.5768099188731565 },
  ]

  for (const c of cases) {
    it(`matches at ${c.impressions.toLocaleString()} impressions`, () => {
      expect(RF.reachFraction(POP, c.impressions)).toBeCloseTo(c.reachFraction, 9)
      expect(RF.averageFrequency(POP, c.impressions)).toBeCloseTo(c.avgFrequency, 9)
      expect(RF.effectiveReach(POP, c.impressions, 2) / POP).toBeCloseTo(c.eff2, 9)
      expect(RF.effectiveReach(POP, c.impressions, 3) / POP).toBeCloseTo(c.eff3, 9)
    })
  }
})

describe('Probability — parity with Swift', () => {
  it('normal quantile (Acklam) matches', () => {
    expect(normalQuantile(0.975)).toBeCloseTo(1.959963986120195, 9)
    expect(normalQuantile(0.8)).toBeCloseTo(0.8416212327266186, 9)
  })
  it('Poisson pmf (via Lanczos lgamma) matches', () => {
    expect(poissonPMF(0, 1.5)).toBeCloseTo(0.22313016014842982, 10)
    expect(poissonPMF(2, 1.5)).toBeCloseTo(0.25102143016698353, 10)
  })
})

describe('Analytics — A/B power & sample size parity with Swift', () => {
  it('required sample size per arm matches exactly (integer)', () => {
    expect(AN.sampleSizePerArm(0.05, 0.01)).toBe(8158)
    expect(AN.sampleSizePerArm(0.1, 0.02)).toBe(3841)
    expect(AN.sampleSizePerArm(0.05, 0.005)).toBe(31234)
  })
  it('statistical power matches across sample sizes', () => {
    expect(AN.power(0.05, 0.01, 5000)).toBeCloseTo(0.5924050230407492, 5)
    expect(AN.power(0.05, 0.01, 10000)).toBeCloseTo(0.8733553267274698, 5)
    expect(AN.power(0.05, 0.01, 20000)).toBeCloseTo(0.9923970141088218, 5)
    expect(AN.power(0.05, 0.01, 50000)).toBeCloseTo(0.9999996773207729, 5)
  })
})
