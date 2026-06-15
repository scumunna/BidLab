import BidLabCore

/// Known-answer tests for the pricing conversions. Every expected number is
/// hand-computed so a regression in the math is caught immediately.
func pricingTests(_ h: Harness) {
    // $0.50 CPC at 2% CTR -> 0.50 * 0.02 * 1000 = $10 eCPM
    h.close("eCPM from CPC x CTR", Pricing.eCPM(cpc: 0.50, ctr: 0.02), 10.0)
    // $25 CPA at 0.0004 conversions/impression -> 25 * 0.0004 * 1000 = $10 eCPM
    h.close("eCPM from CPA x conv/imp", Pricing.eCPM(cpa: 25.0, conversionsPerImpression: 0.0004), 10.0)
    // $10 CPM at 2% CTR -> 10 / (0.02 * 1000) = $0.50 CPC
    h.close("CPC from CPM, CTR", Pricing.cpc(cpm: 10.0, ctr: 0.02), 0.50)
    h.check("CPC guards zero CTR", Pricing.cpc(cpm: 10.0, ctr: 0).isInfinite)
    // $0.50 CPC at 10% CVR -> 0.50 / 0.10 = $5 CPA
    h.close("CPA from CPC, CVR", Pricing.cpa(cpc: 0.50, cvr: 0.10), 5.0)
    // $1,000 at $10 CPM -> 100,000 impressions
    h.close("impressions from spend, CPM", Pricing.impressions(spend: 1000, cpm: 10), 100_000)
    let imps = Pricing.impressions(spend: 1000, cpm: 10)
    h.close("spend round-trips with impressions", Pricing.spend(impressions: imps, cpm: 10), 1000)
    let clicks = Pricing.clicks(impressions: 100_000, ctr: 0.02) // 2,000
    h.close("clicks", clicks, 2000)
    h.close("conversions", Pricing.conversions(clicks: clicks, cvr: 0.10), 200) // 200
    // $4,000 revenue on $1,000 spend -> 4x
    h.close("roas", Pricing.roas(revenue: 4000, spend: 1000), 4.0)
    h.check("roas guards zero spend", Pricing.roas(revenue: 4000, spend: 0).isInfinite)

    // MER, payback, LTV:CAC.
    h.close("MER", Pricing.mer(totalRevenue: 250_000, totalSpend: 100_000), 2.5)
    // $300 CAC, $50/mo margin -> 6 months payback
    h.close("payback months", Pricing.paybackMonths(cac: 300, monthlyMargin: 50), 6)
    // $900 LTV, $300 CAC -> 3:1
    h.close("LTV:CAC", Pricing.ltvToCac(ltv: 900, cac: 300), 3.0)
}
