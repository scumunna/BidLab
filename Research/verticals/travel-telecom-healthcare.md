# Vertical Research: Travel/Hospitality, Telecom, Healthcare/Pharma

Research June 2026. eMarketer spend forecasts + SEC/HHS/FCC/FDA primary sources are load-bearing; vendor/agency benchmarks labeled "directional." Flags inline.

## 1. TRAVEL / HOSPITALITY (airlines, hotels, OTAs)

### Market
- US travel media network (TMN) ad spend ~**$2.13B (2025) -> ~$2.96B (2026)** (+29.1% in 2025). First-party retail-media slice (United Kinective, Expedia, Marriott, Uber), NOT total travel. https://www.emarketer.com/content/travel-media-network-ad-spend
- United Kinective Media: **$110M** new ad revenue first year (first airline media network).
- `[FLAG]` Total US travel digital ad spend (~$10B headline) appears from an older eMarketer piece; do not cite a precise total without the paid table. Use TMN figures as headline.
- Travel/retail/auto were slowest-growing verticals in 2025 (tariff/economic headwinds).

### What's distinctive
- High AOV, long/non-linear consideration. ROAS highly sensitive to booking lead time.
- Look-to-book funnel, extreme drop-off: cart abandonment ~81% avg, up to ~94% for OTAs.
- Counterintuitive seasonality: multi-day tours 2.6x ROAS peak vs 6.3x shoulder (Propellic 2026) - peak is least efficient (CPCs spike).
- Commission economics: each direct booking saves 15-25% OTA commission, so direct-booking ROAS is structurally understated vs true margin.
- 83-90% of paid media spend goes to non-brand search.

### Formulas
```
Look-to-Book = Sessions / Bookings ; Booking CVR = Bookings / Sessions (>2% top 20%, 3-4% top 10%)
Cost per Booking = Spend / Bookings ; ROAS = (AOV x bookings) / Spend
Max CPA (dynamic, trip value) = AOV x margin% x target efficiency
  e.g. $1,200 flight x 8% margin x 0.5 = ~$48 max cost per booking
Abandonment retargeting uplift ~3-4x prospecting ROAS [directional]
```

### Benchmarks `[mostly directional/agency]`
- Blended Travel ROAS ~4.0x (Google Search 5.0x, Meta 3.6x). ROAS spread up to "$19:1" by attribution method - teach as an attribution lesson, not truth.
- Google Search CPC ~$1.34-2.12; Meta CPM ~$10.74 (~46% below global avg).
- OTA cart-abandonment ~81% avg, up to ~94%.

### Regulatory/privacy
- Lightest of the three. GDPR/CCPA consent for loyalty first-party data powering TMNs. No sector-specific ad ban.

### Capstone: "The Shoulder-Season Direct-Booking Problem"
Boutique hotel group, $80k/mo, 2.6x peak ROAS. AOV $1,150, OTA commission 18%. Reallocate peak->shoulder, stand up abandonment retargeting vs ~80% abandonment pool, compute true margin-adjusted ROAS of direct bookings (add back 18% saved commission). Target: lift blended margin-adjusted ROAS 2.6x -> >4.5x, cost-per-direct-booking below $48 trip-value ceiling, no spend increase.

## 2. TELECOM

### Market
- Telecom led ALL US industries in digital ad growth 2025 at **+16.3%** (total ad +11.5%); outspent auto in digital for first time since 2016; social ad spend +20.5%. https://www.insideradio.com/free/telecom-financial-services-lead-u-s-ad-spending-growth-in-2025/
- Telecom B2B digital ad spend tops $2B in 2026.
- `[FLAG]` Total US telecom digital ad-spend $ not verified from free source (Statista/eMarketer paywalled). Use growth/ranking facts.

### What's distinctive
- Subscription/retention business: unit economics are SAC/CPGA vs CLV, not CPA vs AOV.
- Handset subsidies + dealer commissions folded into acquisition cost (unique).
- Churn is dominant: 1pt monthly churn change massively shifts CLV and allowable spend.
- Local + national mix; gross adds (marketing) vs net adds (business).

### Formulas
```
CPGA = (Equipment costs + Sales&Marketing - Equipment revenue) / Gross new subscribers  (= SAC/CAC)
ARPU = Service revenue / Avg subscribers (monthly)
Monthly churn = Subs lost / Subs at start ; Avg lifetime(months) = 1/churn
CLV = ARPU x GM% x (1/churn) ; discounted = Sum[(ARPU x margin) x retention^t / (1+r)^t]
LTV:CAC = CLV/CPGA (healthy 3:1) ; Payback(mo) = CPGA / (ARPU x GM%)
```
Widget: set ARPU/churn/margin/subsidy, watch CLV/payback/LTV:CAC; solve max allowable CPGA for LTV:CAC>=3.

### Benchmarks (anchor on T-Mobile SEC - primary source)
- Postpaid phone churn (T-Mobile): **0.90%** (Q2/Q3 2025); 0.86% FY2024. https://www.sec.gov/Archives/edgar/data/0001283699/000128369925000116/
- Postpaid phone ARPU (T-Mobile): **$50.62** (Q2 2025). Postpaid ARPA: $149.87.
- Industry CPGA/SAC ~$350-400/sub `[rule-of-thumb, flag]`. Healthy LTV:CAC 3:1 `[cross-industry]`.
- `[verify]` Verizon/AT&T Q2-Q3 2025 churn/ARPU exist on EDGAR; only T-Mobile confirmed.

### Regulatory/privacy
- TCPA governs telemarketing calls/texts (telecom uses SMS/outbound heavily).
- FCC "one-to-one consent" rule was vacated: adopted Dec 2023, struck down by 11th Circuit Jan 2025, formally eliminated by FCC Sept 2025 - the stricter regime did NOT take effect. Teach as "regulation that almost happened."
- National DNC Registry now explicitly covers texts to wireless.

### Capstone: "The Subsidy Trap"
Regional carrier offers $400 handset subsidy for Q4 gross adds. ARPU $50, GM 55%, monthly churn 1.4% (worse than T-Mobile 0.9%). Dealer commission + media push CPGA to $420. Compute CLV/payback/LTV:CAC, discover LTV:CAC near break-even. Target: LTV:CAC >=3:1 via cut CPGA toward ~$300, reduce churn 1.4%->`<1.0%` (retention budget), or shift local/national to higher-ARPU DMAs. Payback < 18 months.

## 3. HEALTHCARE / PHARMA

### Market
- US healthcare & pharma digital ad spend: **$24.77B (2025, +13.3%) -> $26.15B (2026, +5.6%)**; total (digital+traditional) ~$33.1B 2026; digital ~80% of mix (up from 64% in 2022). https://www.emarketer.com/content/us-healthcare-pharma-ad-spending-2025
- National TV drug advertising **$5.96B in 2025** (+16%): weight-loss/blood-disorder $460M (+67%), depression/bipolar/insomnia $799M (+56%), cancer $363M (+43%).
- 2025 first year social outspent linear TV in healthcare/pharma.

### What's distinctive
- Two buyers: HCP (NPI-level prescriber identity, tiny/high-value) vs DTC (mass reach, no health PII).
- Conversion is a prescription, measured INDIRECTLY via script-lift studies (matched test-vs-control on de-identified claims) - biggest math difference from every vertical.
- Contextual / condition targeting (content), NOT behavioral health targeting (sensitive category).
- FDA fair-balance/ISI forces longer creative -> shift to social/streaming.
- Point-of-care is a distinct high-ROI channel.

### Formulas
```
DTC:
Cost per script (CPRx) = Spend / Incremental scripts
Script lift = (Rx rate exposed - Rx rate control) / control rate
DTC ROI = (Incremental scripts x revenue per script) / Spend  (POC ~28:1 vendor best-case)
Cost per verified patient (CPVP) = Spend / Verified patients
HCP:
NBRx (new-to-brand) and TRx (total) are the script-lift outcomes
Audience Quality (AQ) = % impressions to correct NPI target list (DeepIntent ~95% of HCP universe)
Cost per NPI = Targeting spend / NPIs reached (~$260/NPI/yr illustrative, rare disease)
```
Widget: matched test-vs-control script-lift; set reach, AQ, baseline script rate, observed lift -> incremental scripts, CPRx, ROI. MUST NOT allow individual-level health targeting input (teaches the constraint structurally).

### Benchmarks `[vendor best-cases - frame as such]`
- HCP universe reachable ~95% (DeepIntent/DMD).
- DTC point-of-care ROI ~28:1 (Phreesia/FiercePharma sponsored).
- POC script lift +370% therapy initiation / +22% scripts (heart-failure case). Adaptive-audience lift up to 6x. Avg engagement lift 8.3x.
- Defensible anchors: eMarketer spend figures + 95% HCP reach.

### Regulatory/privacy (heaviest)
- HIPAA + OCR online-tracking guidance (Mar 2024): covered entities can't share PHI (incl. IP + visit to health-condition page) with ad-tech without BAA/authorization. https://www.hhs.gov/hipaa/for-professionals/privacy/guidance/hipaa-online-tracking/
  - Nuance: a federal court (June 2024) VACATED the part covering IP-on-unauthenticated-public-pages. Guidance partially struck down; gray zone. Teach as "rule is contested/evolving."
- No sensitive-category behavioral targeting -> contextual/NPI workaround.
- FDA fair-balance/ISI: DTC must present balanced benefit/risk + Important Safety Information.
- FDA enforcement surge (Sept 2025): ~40 untitled (Sept 9) + ~80 warning letters (Sept 16), 100+ total; oncology + weight-loss (GLP-1) under heightened scrutiny.

### Capstone: "The GLP-1 Launch Under Fair-Balance Pressure"
Weight-loss (GLP-1) brand, $20M split DTC/HCP for launch quarter. Constraints: no individual health targeting (contextual + NPI only); fair-balance/ISI forces longer creative (social/streaming); heightened-FDA-scrutiny category so creative claims must stay within fair-balance or trigger a simulated warning letter (zeroes the flight). Allocate budget, set HCP AQ (on-target %) and DTC reach, run test-vs-control script-lift -> NBRx, TRx, cost per script, ROI. Target: >=90% HCP AQ, positive script lift, cost per incremental script below threshold, zero compliance violations.

## Cross-vertical lens summary
| Dim | Travel | Telecom | Pharma |
|---|---|---|---|
| Core unit | High-AOV one-off booking | Multi-year subscription (CLV) | Prescription (measured by lift) |
| Signature metric | Look-to-book, cost per booking, ROAS | CPGA, ARPU, churn, LTV:CAC | Script lift, CPRx, NPI reach, AQ |
| Conversion visibility | Direct (click->book) | Direct (sub activation) | INDIRECT (lift study, no PHI) |
| Dominant lever | Booking window/seasonality/abandonment | Churn x subsidy | Compliance + targeting method |
| Regulatory weight | Light (CCPA/GDPR) | Medium (TCPA, DNC) | Heavy (HIPAA, FDA, sensitive-cat ban) |
| Anchor numbers | TMN $2.13B->$2.96B | T-Mobile churn 0.9%, ARPU $50 | Digital $24.77B->$26.15B; 95% HCP reach |
