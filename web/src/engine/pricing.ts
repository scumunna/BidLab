// Port of BidLabCore/Pricing.swift — transparent programmatic pricing conversions.
// Rates are fractions in 0...1 (a 2% CTR is 0.02); money is in one currency unit.

/** `eCPM = CPC × CTR × 1000`. */
export function eCPMFromCPC(cpc: number, ctr: number): number {
  return cpc * ctr * 1000
}

/** `eCPM = CPA × conversionsPerImpression × 1000`. */
export function eCPMFromCPA(cpa: number, conversionsPerImpression: number): number {
  return cpa * conversionsPerImpression * 1000
}

/** `CPC = CPM / (CTR × 1000)`. */
export function cpc(cpm: number, ctr: number): number {
  return ctr > 0 ? cpm / (ctr * 1000) : Infinity
}

/** `CPA = CPC / CVR`. */
export function cpa(cpcValue: number, cvr: number): number {
  return cvr > 0 ? cpcValue / cvr : Infinity
}

/** `impressions = spend / CPM × 1000`. */
export function impressions(spend: number, cpm: number): number {
  return cpm > 0 ? (spend / cpm) * 1000 : 0
}

/** `spend = impressions / 1000 × CPM`. */
export function spend(impressionCount: number, cpm: number): number {
  return (impressionCount / 1000) * cpm
}

/** `ROAS = revenue / spend`. */
export function roas(revenue: number, spendValue: number): number {
  return spendValue > 0 ? revenue / spendValue : Infinity
}

/** Lifetime value to acquisition cost ratio. A common health benchmark is 3:1. */
export function ltvToCac(ltv: number, cac: number): number {
  return cac > 0 ? ltv / cac : Infinity
}
