import Foundation

/// Programmatic pricing conversions.
///
/// Every function here is a single, transparent formula with no hidden state, so
/// the "open the hood" panel can show the exact math to the user. All rates are
/// expressed as fractions in `0...1` (a 2% CTR is `0.02`), and all money values
/// are in the same currency unit (dollars).
///
/// The relationships, for reference:
/// - eCPM = effective cost per 1,000 impressions
/// - CTR  = clicks / impressions
/// - CVR  = conversions / clicks
/// - CPC  = cost / click
/// - CPA  = cost / conversion
public enum Pricing {
    /// Effective CPM implied by a cost-per-click and a click-through rate.
    ///
    /// `eCPM = CPC × CTR × 1000`
    public static func eCPM(cpc: Double, ctr: Double) -> Double {
        cpc * ctr * 1000
    }

    /// Effective CPM implied by a cost-per-acquisition and a per-impression conversion rate.
    ///
    /// `eCPM = CPA × conversionsPerImpression × 1000`, where
    /// `conversionsPerImpression = CTR × CVR`.
    public static func eCPM(cpa: Double, conversionsPerImpression: Double) -> Double {
        cpa * conversionsPerImpression * 1000
    }

    /// Cost-per-click implied by a CPM and a click-through rate.
    ///
    /// `CPC = CPM / (CTR × 1000)`. Returns `.infinity` when `ctr <= 0`.
    public static func cpc(cpm: Double, ctr: Double) -> Double {
        ctr > 0 ? cpm / (ctr * 1000) : .infinity
    }

    /// Cost-per-acquisition implied by a cost-per-click and a conversion rate.
    ///
    /// `CPA = CPC / CVR`. Returns `.infinity` when `cvr <= 0`.
    public static func cpa(cpc: Double, cvr: Double) -> Double {
        cvr > 0 ? cpc / cvr : .infinity
    }

    /// Impressions bought for a given spend at a given CPM.
    ///
    /// `impressions = spend / CPM × 1000`. Returns `0` when `cpm <= 0`.
    public static func impressions(spend: Double, cpm: Double) -> Double {
        cpm > 0 ? spend / cpm * 1000 : 0
    }

    /// Spend required to serve a given number of impressions at a given CPM.
    ///
    /// `spend = impressions / 1000 × CPM`.
    public static func spend(impressions: Double, cpm: Double) -> Double {
        impressions / 1000 * cpm
    }

    /// Expected clicks from impressions at a given click-through rate.
    public static func clicks(impressions: Double, ctr: Double) -> Double {
        impressions * ctr
    }

    /// Expected conversions from clicks at a given conversion rate.
    public static func conversions(clicks: Double, cvr: Double) -> Double {
        clicks * cvr
    }

    /// Return on ad spend: revenue generated per dollar spent.
    ///
    /// `ROAS = revenue / spend`. Returns `.infinity` when `spend <= 0`.
    public static func roas(revenue: Double, spend: Double) -> Double {
        spend > 0 ? revenue / spend : .infinity
    }

    /// Media efficiency ratio: total revenue over total spend across all media.
    /// The blended, business-level cousin of ROAS.
    public static func mer(totalRevenue: Double, totalSpend: Double) -> Double {
        totalSpend > 0 ? totalRevenue / totalSpend : .infinity
    }

    /// Payback period in months: how long the per-customer margin takes to repay
    /// the acquisition cost. `CAC / monthlyMargin`.
    public static func paybackMonths(cac: Double, monthlyMargin: Double) -> Double {
        monthlyMargin > 0 ? cac / monthlyMargin : .infinity
    }

    /// Lifetime value to acquisition cost ratio. A common health benchmark is 3:1.
    public static func ltvToCac(ltv: Double, cac: Double) -> Double {
        cac > 0 ? ltv / cac : .infinity
    }
}
