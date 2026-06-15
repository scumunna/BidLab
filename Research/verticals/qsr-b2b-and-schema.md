# Vertical Research: QSR/Restaurants, B2B/SaaS + Cross-Vertical Schema

Research June 2026. QSR-specific local ad-spend figure is dated (2019, flagged). B2B/SaaS numbers are current (2025-26) from named benchmark publishers.

## 1. QSR / RESTAURANTS (Quick-Service & Casual Dining)

### Market
- QSR local advertising ~**$4.0B** -> **`[FLAG: BIA 2019 report, NOT 2025-26]`**. https://www.bia.com/press-releases/local-advertising-quick-serve-restaurants-expected-hit-4-billion-year-high-...
- QSR brand ad spend (tracked, all media) **$3.3B** (May 2024-May 2025, Sensor Tower) - use as current anchor.
- Total US local advertising: $169B (2025) -> $184.5B (2026, +8.1%) (BIA).
- US digital coupon market $10.6B (2025) -> $12.55B (2026) (DemandSage).
- Do NOT present $4B as 2025/26; use $3.3B tracked-spend or total-local anchors.

### What's distinctive
- Conversion is a physical store visit, not click/online sale -> foot-traffic/footfall attribution (mobile device-graph vs ad exposure).
- Hyper-locality: per-store geo-radius (1-5 mi / 10-min drive); a national QSR is N hundred micro-campaigns.
- Dayparting load-bearing (breakfast/lunch/dinner/late-night CPMs + intent swing).
- Incrementality is the honest currency: cost per INCREMENTAL visit (CPIV) vs holdout.
- Offer/redemption closes the loop: redemption rate x average ticket.
- Thin margins, low ticket (~$8-15) -> tolerable cost-per-visit is single-to-low-double-digit dollars.

### Formulas
```
CPV = Spend / Attributed Visits ; CPIV = Spend / Incremental Visits
Incremental Visits = Exposed Visits - (Exposed Audience x Control Visit Rate)
Visit Lift % = (Exposed Visit Rate - Control Visit Rate) / Control Visit Rate
Daypart CPV = Spend_daypart / Visits_daypart  (shift to lowest-CPV dayparts)
Redemption Rate = Offers Redeemed / Offers Distributed ; Revenue = Redemptions x Avg Ticket
Incremental ROAS = (Incremental Visits x Avg Ticket x Gross Margin) / Spend
Addressable Devices = device density x pi x radius^2 (per store, deduped over overlap)
```
CPIV (AdTheorent/GroundTruth): pay only for visits that wouldn't have occurred.

### Benchmarks
- CPV fast-food: low single-digit to ~$10 (examples: Volvo $21/visit, clinic $24/visit; QSR cheaper). `[FLAG: no published QSR-specific CPV; model it from inputs]`
- Footfall lift: programmatic DOOH +46% gross / +8pp incremental (Decathlon, retail - directional). Geofencing ~+30% over organic.
- Mobile/digital coupon redemption ~7% (digital), up to 15% SMS; print <1%. 77% of US use restaurant coupons.
- Display CPM $1.50-4.00; CTV $25-45. US OOH $9.1B (2024), DOOH 34% of OOH.

### Regulatory/privacy
- Location data is sensitive (precise geolocation under CPRA/CCPA + state laws). Aggregation + clean rooms. MAID deprecation + ATT erodes device-graph match rates. COPPA caution near schools/minors.

### Capstone: "Launch Week for a 40-store burger chain"
$250k two-week budget, daypart demand curve, $11.50 avg ticket at 22% contribution margin, 3-mi geo-radius per store with known device density. Allocate across dayparts + display/DOOH/CTV to minimize CPIV. Target >=40,000 incremental visits at CPIV <=$5.50; layer app coupon (7% redemption) and prove incremental ROAS >=2.0x vs 10% holdout. Twist: ATT/MAID match-rate drop shrinks measurable audience 15% mid-campaign.

## 2. B2B / SaaS

### Market
- US B2B digital ad spend ~$20B (2025) -> **$23.05B (2026)** (+13.9% / +10.4%); digital share 45.6% -> 48.0%. https://www.marketingcharts.com/industries/business-to-business-234263
- Global B2B digital ad spend ~3x pre-pandemic by 2026.

### What's distinctive
- Conversion (lead) far upstream of revenue: lead -> MQL -> SQL -> opportunity -> closed-won, months later.
- Long multi-touch committee cycles: median 84 days; enterprise 90-180+; ~25 stakeholders.
- Account-based (ABM): finite target account list, measure reach/penetration into named accounts.
- Unit economics dominate: CAC, LTV:CAC, payback.
- Tiny CTRs (LinkedIn 0.4-0.65%), huge per-lead value (deal $15K-$1M+).
- Marketing-sourced vs marketing-influenced pipeline (two formulas).

### Formulas
```
Leads = Clicks x Lead-form CVR ; MQLs = Leads x Lead->MQL ; SQLs = MQLs x MQL->SQL
Opportunities = SQLs x SQL->Opp ; Closed-Won = Opps x Opp->Close ; Lead->Close = product of stage rates
CPL = Spend/Leads ; CPMQL = Spend/MQLs ; CPSQL = Spend/SQLs (3-5x CPMQL) ; CPO = Spend/Opps
CAC = (Sales + Marketing Spend)/New Customers
LTV = (ARPA x GM%)/Churn ; LTV:CAC (>=3:1) ; Payback(mo) = CAC/(Monthly ARPA x GM%)
SaaS Magic Number variant: $ to acquire $1 new ARR (median ~$2.00, 2025)
Marketing-Sourced Pipeline = Sum deal value where marketing originated account
Pipeline Coverage = Open Pipeline $ / Revenue Target
ABM Account Reach % = Engaged Target Accounts / Total Target List
Target CPL = LTV x Target GM x Close Rate (First Page Sage)
```

### Benchmarks (First Page Sage, 50+ SaaS clients, Jun 2025)
- Funnel: Visitor->Lead 1.4-2.3%; Lead->MQL 36-47%; MQL->SQL 26-46%; SQL->Opp 31-48%; Opp->Close 35-43%. Best TOF channel: SEO.
- CPL: Blended $237; Paid $310; Organic $164; LinkedIn $408; Google PPC $463; Referrals ~$25.
- LTV:CAC 3:1 min, 4:1-6:1 top quartile. $ to acquire $1 ARR: $2.00 median, bottom quartile $2.82.
- CAC: $200-700 SMB; $1,200-2,000 mid/enterprise. LTV: SMB $15-40K; Mid $80-200K; Ent $300K-$1M+.
- Sales cycle median 84 days (SMB 14-30d, Mid 30-90d, Ent 90-180+d). Buying committee ~25 (enterprise).
- LinkedIn CTR 0.44-0.65%, CPC $5-10. B2B display CTR ~0.46%, conversion 2-4%.
- ABM: +60% higher win rates; mature ABM 50-73% revenue from target accounts; Account->Opp <10% to >25% by tier.

### Regulatory/privacy
- Lighter consumer exposure but GDPR treats business contacts as personal data (lawful basis for cold outreach). CAN-SPAM/CASL/e-privacy. Intent-data provenance/consent. SOC2/GDPR vendor reviews add 2-4 weeks to cycle.

### Capstone: "Hit $3M marketing-sourced pipeline (mid-market SaaS, 2 quarters)"
$400k budget, 250-account ICP list, $45K ACV at 80% GM, ~110-day cycle, First Page Sage funnel defaults (editable). Mix LinkedIn (0.5% CTR, ~$408 CPL), SEO/content ($164 CPL, slow ramp), webinars to engage >=60% of 250 accounts (ABM reach). Drive funnel to >=$3M marketing-sourced pipeline, blended CPL <=$250, payback <=12mo, LTV:CAC >=4:1. Twist: enterprise-tilt extends cycle past the window (segment/cycle/CAC tradeoff).

---

## CROSS-VERTICAL BENCHMARK SCHEMA (Swift)

```swift
struct BenchmarkRange: Codable, Hashable { var low: Double; var typical: Double; var high: Double; var unit: String }

struct Citation: Codable, Hashable {
    var sourceName: String; var url: String; var year: Int
    var verified: Bool          // false => surface an "unverified" badge
    var note: String?           // e.g. "QSR figure is 2019; freshest published"
}

enum GoodDirection: String, Codable { case lowerIsBetter, higherIsBetter }

struct SignatureKPI: Codable, Hashable {
    var name: String; var abbreviation: String; var formula: String
    var formulaVariables: [String]; var goodDirection: GoodDirection
    var target: Double?; var targetUnit: String?; var citation: Citation
}

enum ConversionEvent: String, Codable {
    case storeVisit, onlinePurchase, lead, qualifiedLead, opportunity,
         closedDeal, appInstall, subscription, testDrive, quoteRequest, bookingReservation, prescription
}

struct VerticalBenchmark: Codable, Identifiable, Hashable {
    var id: String; var displayName: String
    var cpm: BenchmarkRange; var ctr: BenchmarkRange; var cvr: BenchmarkRange
    var efficiencyMetric: BenchmarkRange; var efficiencyMetricName: String  // "ROAS","LTV:CAC","CPIV","Cost per Visit"
    var primaryConversionEvent: ConversionEvent; var signatureKPI: SignatureKPI
    var averageOrderValue: BenchmarkRange?   // QSR ticket, ecommerce AOV
    var averageDealSize: BenchmarkRange?     // B2B ACV
    var customerLTV: BenchmarkRange?
    var salesCycleDays: BenchmarkRange?
    var funnelStageRates: [String: BenchmarkRange]?
    var whatsDifferent: String
    var citations: [Citation]
}
```

Worked signature KPIs per vertical (for the lens):
| Vertical | efficiencyMetricName | Signature KPI (formula) | whatsDifferent |
|---|---|---|---|
| Retail | iROAS | Incremental Revenue / Ad Spend | Closed-loop deterministic attribution on retailer first-party purchase data |
| CPG | mROI | d(Incremental Sales x margin)/d Spend | Penetration growth + MMM; trade vs media is the budget tension |
| Ecommerce | LTV:CAC | LTV / CAC | Break-even ROAS = 1/GM%; blended CAC is the honest number |
| DTC | MER | Total Revenue / Total Ad Spend | Unit economics ARE the campaign; blended vs platform-attributed |
| Auto | Net cost/sale | Gross spend - OEM co-op | Three-tier (OEM/assoc/dealer); co-op compliance unlocks reimbursement |
| Finance | Cost per funded | CPL / (Lead->App x App->Fund) | Highest CPMs; Special Ad Category + FCRA constrain targeting/creative |
| Travel | Cost per booking | Spend / Bookings | High AOV, booking-window sensitivity, abandonment retargeting, commission savings |
| Telecom | LTV:CAC | CLV / CPGA | Subscription/churn economics; subsidies in acquisition cost |
| Healthcare | CPRx | Spend / Incremental scripts | Prescription measured INDIRECTLY by lift; no health PII; HIPAA/FDA |
| QSR | CPIV | Spend / Incremental Visits | Conversion is a physical incremental store visit via location data |
| B2B/SaaS | LTV:CAC | LTV / CAC (>=3:1) | Revenue months + ~25 stakeholders downstream; multi-stage funnel + ABM |

Schema notes: `verified:Bool` + `note` serves "flag anything unverified" (QSR $4B ships verified:false). `efficiencyMetric` is polymorphic so ROAS- and ratio-driven verticals share a field. AOV/dealSize/LTV optional; validator asserts >=1 present.
