// Port of BidLabCore/MarketSimulation.swift — the reproducible RTB market behind
// the hero Trading Floor. The competing top bid (clearing price) is drawn from a
// log-normal market, so the win curve is the log-normal CDF (the S-shaped bid
// landscape real desks face). The auction clears first- or second-price.

import { SeededRandom } from './rng'
import { normalCDF } from './mathx'

export type MarketModel =
  | { kind: 'exponential' }
  | { kind: 'logNormal'; sigma: number }

export type AuctionType = 'firstPrice' | 'secondPrice'

const SQRT_2PI = 2.5066282746310002 // sqrt(2 * pi)

export interface MarketConfigParams {
  opportunities: number
  bid: number
  budget: number
  marketMean: number
  floor?: number
  ctr: number
  cvr: number
  revenuePerConversion: number
  model?: MarketModel
  auction?: AuctionType
}

export class MarketConfig {
  opportunities: number
  bid: number
  budget: number
  marketMean: number
  floor: number
  ctr: number
  cvr: number
  revenuePerConversion: number
  model: MarketModel
  auction: AuctionType

  constructor(p: MarketConfigParams) {
    this.opportunities = p.opportunities
    this.bid = p.bid
    this.budget = p.budget
    this.marketMean = p.marketMean
    this.floor = p.floor ?? 0
    this.ctr = p.ctr
    this.cvr = p.cvr
    this.revenuePerConversion = p.revenuePerConversion
    this.model = p.model ?? { kind: 'exponential' }
    this.auction = p.auction ?? 'firstPrice'
  }

  /** Expected revenue per won impression: `CTR * CVR * revenuePerConversion`. */
  get valuePerImpression(): number {
    return this.ctr * this.cvr * this.revenuePerConversion
  }

  /** Closed-form win probability at a bid. Below the floor it is zero. */
  winProbability(b: number): number {
    if (!(b > 0) || b < this.floor) return 0
    if (this.model.kind === 'exponential') {
      return 1 - Math.exp(-b / Math.max(this.marketMean, 1e-9))
    }
    const s = Math.max(this.model.sigma, 1e-6)
    const mu = Math.log(Math.max(this.marketMean, 1e-9)) - (s * s) / 2
    return normalCDF((Math.log(b) - mu) / s)
  }

  /** Expected profit per opportunity at a bid, for the chosen auction type. */
  expectedProfitPerOpportunity(b: number): number {
    if (!(b > 0) || b < this.floor) return 0
    if (this.auction === 'firstPrice') {
      return this.winProbability(b) * (this.valuePerImpression - b)
    }
    // Second-price: integrate (value - max(c, floor)) over the clearing prices you
    // beat, via the composite trapezoidal rule (matches Swift's n = 400).
    const n = 400
    const h = b / n
    let sum = 0
    for (let i = 0; i <= n; i++) {
      const c = i * h
      const w = i === 0 || i === n ? 0.5 : 1.0
      sum += w * (this.valuePerImpression - Math.max(c, this.floor)) * this.competingPDF(c)
    }
    return sum * h
  }

  /** The profit-maximizing bid, found by scanning the expected-profit curve. */
  optimal(steps = 2000): { bid: number; expectedProfit: number } {
    const cap = Math.max(this.valuePerImpression, 1e-9)
    let best = { bid: 0, expectedProfit: 0 }
    for (let i = 1; i <= steps; i++) {
      const b = (cap * i) / steps
      const p = this.expectedProfitPerOpportunity(b)
      if (p > best.expectedProfit) best = { bid: b, expectedProfit: p }
    }
    return best
  }

  /** Density of the competing clearing price (used by the second-price integral). */
  competingPDF(c: number): number {
    if (!(c > 0)) return 0
    if (this.model.kind === 'exponential') {
      const m = Math.max(this.marketMean, 1e-9)
      return Math.exp(-c / m) / m
    }
    const s = Math.max(this.model.sigma, 1e-6)
    const mu = Math.log(Math.max(this.marketMean, 1e-9)) - (s * s) / 2
    const z = (Math.log(c) - mu) / s
    return Math.exp((-z * z) / 2) / (c * s * SQRT_2PI)
  }

  /** One competing-bid draw for the configured market model. */
  sampleCompeting(rng: SeededRandom): number {
    const u = rng.unitDouble()
    if (this.model.kind === 'exponential') {
      return -this.marketMean * Math.log(1 - u)
    }
    const s = Math.max(this.model.sigma, 1e-6)
    const mu = Math.log(Math.max(this.marketMean, 1e-9)) - (s * s) / 2
    const u1 = 1 - u // in (0, 1], avoids log(0)
    const u2 = rng.unitDouble()
    const z = Math.sqrt(-2 * Math.log(u1)) * Math.cos(2 * Math.PI * u2) // Box-Muller
    return Math.exp(mu + s * z)
  }
}

export class MarketResult {
  constructor(
    readonly opportunities: number,
    readonly impressionsWon: number,
    readonly spend: number,
    readonly clicks: number,
    readonly conversions: number,
    readonly revenue: number,
    readonly lostToFloor: number,
    readonly lostToCompetition: number,
  ) {}

  get profit(): number {
    return this.revenue - this.spend
  }
  get winRate(): number {
    return this.opportunities > 0 ? this.impressionsWon / this.opportunities : 0
  }
  get effectiveCPA(): number {
    return this.conversions > 0 ? this.spend / this.conversions : Infinity
  }
  get roas(): number {
    return this.spend > 0 ? this.revenue / this.spend : Infinity
  }
  get lostToFloorRate(): number {
    return this.opportunities > 0 ? this.lostToFloor / this.opportunities : 0
  }
  get lostToCompetitionRate(): number {
    return this.opportunities > 0 ? this.lostToCompetition / this.opportunities : 0
  }
}

/** Run the campaign deterministically for the given seed. */
export function runMarket(config: MarketConfig, seed: bigint): MarketResult {
  const rng = new SeededRandom(seed)
  let won = 0
  let clicks = 0
  let conversions = 0
  let spend = 0
  let revenue = 0
  let lostToFloor = 0
  let lostToCompetition = 0

  for (let i = 0; i < config.opportunities; i++) {
    const competingBid = config.sampleCompeting(rng)
    // Clear the publisher reserve first, then the competition.
    if (config.bid < config.floor) {
      lostToFloor++
      continue
    }
    if (!(config.bid > competingBid)) {
      lostToCompetition++
      continue
    }
    // Second-price pays max(clearing, floor); first-price pays your bid.
    const pay =
      config.auction === 'secondPrice' ? Math.max(competingBid, config.floor) : config.bid
    if (spend + pay > config.budget) continue // budget binds on actual payment

    won++
    spend += pay
    if (rng.unitDouble() < config.ctr) {
      clicks++
      if (rng.unitDouble() < config.cvr) {
        conversions++
        revenue += config.revenuePerConversion
      }
    }
  }

  return new MarketResult(
    config.opportunities,
    won,
    spend,
    clicks,
    conversions,
    revenue,
    lostToFloor,
    lostToCompetition,
  )
}
