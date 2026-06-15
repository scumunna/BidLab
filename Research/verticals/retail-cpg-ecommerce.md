# Vertical Research: Retail, CPG, Ecommerce

Research date: June 2026. Currency USD. Numbers that could not be verified against a credible source are flagged `[UNVERIFIED]` / `[FLAG]` / `[directional]`. eMarketer dollar figures verified via public article text + corroborating trade press (WARC, Skai, Census). These three verticals overlap but are distinct lenses: Retail = retail media networks (closed-loop iROAS, on/off-site), CPG = penetration + MMM + trade-vs-media, Ecommerce = unit-economics (CAC/LTV/contribution margin/break-even ROAS).

## 1. RETAIL (Retail Media Networks)

### Market
- US retail media ad spend 2025: **$60.32B**; 2026: **$71.09B** (~+18%). Source: eMarketer Dec 2025 forecast — https://www.emarketer.com/content/faq-on-retail-media-networks-how-marketers-should-allocate-budgets-2026
- Global retail media 2025: **$174.9B** (+13.7%); 2026: **$196.7B** (+12.4%, ~16% of all ad spend). Source: WARC via MediaBrief — https://mediabrief.com/warc-global-retail-media-ad-market-2025/
- Concentration: Amazon ~**79.7%** of US retail media; Amazon+Walmart capture **89%** of net-new 2026 spend. Source: eMarketer via Osmos — https://www.osmos.ai/blog/roas-benchmarks-platform-ad-format-2026
- Scope note: ~$13.5B (2025) figure some cite is OFF-SITE only; $60.32B is total (on-site + off-site). Label scope in the widget.

### What's distinctive
- Closed-loop deterministic attribution via retailer first-party transaction data (vs modeled open-web). https://www.osmos.ai/blog/closed-loop-attribution-the-key-to-unlocking-higher-roas
- On-site (sponsored products, highest ROAS, bottom funnel) vs off-site (first-party data on open web/social/CTV, demand gen). https://www.thecurrent.com/what-is-onsite-vs-offsite-advertising
- iROAS over ROAS: high-intent shoppers mean attributed ROAS overstates value. 71% of advertisers rank incrementality top KPI (ANA 2024); 94% don't fully trust retailer-reported metrics (Coresight).
- Auction ~ search: Sponsored Products keyword/CPC auction; ACoS / TACoS are operative metrics.
- Extreme seasonality: retail media +33% YoY in Q4 2025 (Skai, largest single-quarter jump in 6 years). https://skai.io/press-releases/quarterly-trends-report-q4-2025/

### Formulas
```
ROAS  = Attributed Revenue / Ad Spend
iROAS = Incremental Revenue / Ad Spend ; Incremental = Test sales - Control(baseline) sales
ACoS  = Ad Spend / Attributed Sales x 100   (target < margin %)
TACoS = Ad Spend / TOTAL Sales x 100        (brand-health)
New-to-Brand % = NTB Orders / Total Attributed Orders
Key identity: ROAS = iROAS only when baseline organic sales = 0; otherwise ROAS > iROAS.
```
Incrementality test design: geo holdout or ghost-bids/PSA control.

### Benchmarks (Skai Q4 2025 / Osmos 2026 unless noted)
- Cross-platform retail media ROAS **6.1x** (held 5 quarters). 
- Amazon avg ROAS ~**3.4x** (declined ~3.9% in 2025); baseline ACoS ~**29%**, top performers 22-25%.
- Amazon Sponsored Products CTR ~**0.47%**, CVR ~**10.3%** `[corroborate - single source]`.
- Q4 2025: CPC **-1%** YoY, CTR **+9%** YoY. SP = 60% of Amazon Ads revenue, 76% of clicks. Amazon DSP share 17.7%->23.4%.
- Walmart Connect CVR ~**17%**, CPC +11% YoY.
- Sponsored Products incremental ROI **+428%** (Criteo, 44k+ campaigns). Offline-sales attribution uplift **+42%** avg ROAS.
- "Good" TACoS (established product) **5-10%** (Perpetua).
- `[UNVERIFIED]` "154% return per $1" and "44% purchase because of RMN ads" (Fugo/Vistar/MFour) - vendor studies, do not present as benchmark.

### Regulatory/privacy
- Closed-loop depends on first-party data -> relatively cookie-deprecation-proof (selling point).
- Clean rooms (Amazon Marketing Cloud, Walmart Luminate) for compliant off-site analysis.
- IAB/MRC retail media measurement guidelines exist due to the 94% trust gap.

### Capstone: "The Incrementality Audit"
Brand spends $500K/quarter on Sponsored Products at reported 5.0x ROAS. Geo-holdout reveals true iROAS 2.3x. Reallocate across on-site SP, off-site DSP (36.5% NTB), upper-funnel CTV to maximize incremental revenue at 3.0x iROAS floor, TACoS < 12%. Lesson: best-ROAS channel was cannibalizing organic.

## 2. CPG / Consumer Packaged Goods

### Market
- US CPG total ad spend 2025: ~**$66B** (eMarketer via MediaPost — https://www.mediapost.com/publications/article/400196/cpg-ad-spending-to-moderate-in-2025.html).
- US CPG digital ad spend 2025: ~**$55B** (16.5% of $302.77B US digital; growth moderating 6.1%); 2026: **$56.07B** (+5.8%). Source: eMarketer — https://www.emarketer.com/content/cpg-digital-ad-spend-slow-after-two-boom-years
- Channel mix: **57.9%** display, **69.3%** mobile.
- Trade promotion spend: **15-25% of gross sales** (grocery to 30%), often larger than media. https://supplierwiki.supplypike.com/articles/trade-spend-how-retailers-and-suppliers-share-promotional-costs

### What's distinctive
- Trade vs media tension; ~72% of US trade promotions don't turn a profit (Vividly).
- Penetration-driven growth (Ehrenberg-Bass): growth from acquiring households, not loyalty. Inverts ecommerce LTV mindset.
- Reach & frequency at scale, not clicks (sub-$5 impulse units).
- MMM is the gold standard (offline purchases); separate base vs incremental sales econometrically.

### Formulas
```
Sales = (#Households x Penetration%) x Buying Rate ; Buying Rate = Frequency x Size per buyer
Share = Penetration_share x Buying-Rate_share
GRPs = Reach% x Avg Frequency ; Effective Reach = % reached at >= N exposures (often 3+)
MMM: Sales_t = b0 + Sum bi*f(AdStock(Spend_i,t)) + g*Promo + d*Price + seasonality + e
AdStock_t = Spend_t + lambda*AdStock_(t-1)  (0<lambda<1 carryover)
Saturation: diminishing-returns (Hill/log) per channel
Total Sales = Base + Sum Incremental(channel) ; mROI = d(Incremental Sales x margin)/d Spend
Trade Promo ROI = Incremental Gross Profit / Trade Spend
```
Highest-value widgets: penetration x buying-rate decomposition; adstock + saturation curve.

### Benchmarks
- Grocery/CPG retail media ROAS (Amazon) **3-5x** `[directional]`.
- Trade spend 15-25% gross sales; unprofitable promotions ~72%.
- CPG display share 57.9%; retail media ~20% of consumer-brand programmatic budgets `[secondary - flag]`.
- `[UNVERIFIED]` CPG household penetration % and buying-rate $ are brand/category-specific (Nielsen/Circana/Kantar, paywalled). Base-vs-incremental MMM splits commonly ~60-80% base / 20-40% incremental but brand-specific - present as tunable inputs, not facts.

### Regulatory/privacy
- Category ad restrictions: alcohol (age-gate), tobacco/vape (largely banned), infant formula (WHO Code), children's food (COPPA, HFSS in UK/EU).
- Health/nutrition claims FTC/FDA-regulated (substantiation).

### Capstone: "Penetration vs Loyalty Budget Allocation"
Snack brand at 8% household penetration, $24/buyer/year. Split $40M across broad-reach CTV/linear (grow penetration), retail media (convert intent), trade promo. Using MMM with adstock (lambda) + saturation, maximize incremental gross profit, trade-spend cap 18% of gross sales. Grow penetration >=1.5pts, blended mROI > 1.2x. Lesson: penetration lever usually wins but saturation caps reach spend.

## 3. ECOMMERCE (DTC / Performance)

### Market
- US ecommerce sales 2025: ~**$1.19T** record (Census). https://www.sellerscommerce.com/blog/ecommerce-statistics/
- US ecommerce share of retail: **16.8-16.9%** Q1 2026. https://fred.stlouisfed.org/series/ECOMPCTSA
- US programmatic digital ad spend 2025 ~**$270B+** (>85% of digital) `[corroborate scope]`.

### What's distinctive
- Unit economics; platform-reported ROAS increasingly distrusted post iOS-14/cookie loss -> blended CAC vs contribution margin is the serious metric.
- AOV a primary lever (bundles, free-ship thresholds, upsells).
- New vs returning split drives strategy.
- Margin-adjusted: **Break-even ROAS = 1 / gross margin %** (the key formula).
- CPM volatility/seasonality: Meta CPM $25.22 Nov 2025 -> $15.74 Jan 2026; holiday CPCs +30-35%.

### Formulas
```
ROAS = Revenue / Ad Spend ; Break-even ROAS = 1 / Gross Margin %
AOV = Revenue / Orders ; CVR = Orders / Sessions
CAC = Acq Spend / New Customers ; Blended CAC = ALL spend / ALL new customers
Contribution Margin/order = AOV x GM% - variable costs - CAC
LTV = AOV x Frequency x Lifespan (x GM% for margin-LTV) ; LTV(sub) = (MonthlyRev x GM%)/Churn
LTV:CAC (target >=3:1; best 4-5:1) ; CAC Payback(mo) = CAC / (Monthly Gross Profit per Customer)
MER = Total Revenue / Total Marketing Spend
```
Flagship widgets: contribution-margin waterfall; LTV:CAC + payback pair.

### Benchmarks
- Avg ecommerce ROAS 2025 **2.87x** (-4% YoY). Google 4.0-8.0x; Meta 2.5-4.0x (median 1.86x, 35k-brand study).
- Meta CPM 2026 ~**$14.19** (+20% YoY; "good" $8-12). Meta CPC ~$0.78-1.72. Meta median CPA $38.19 (ecom ~$29.99).
- Avg ecommerce CVR 2025-26 **2.5-3.2%** (global ~1.9%); Food & Bev top 4.5-6.0%.
- Global AOV ~**$150-154** (+3.08% YoY) `[corroborate]`. Cart abandonment ~70%. Mobile CVR 1.8-2.5% vs desktop 3.5-4.0%.
- Target LTV:CAC >=3:1 (best 4-5:1); CAC payback <=12 mo.
- `[FLAG]` Most ecommerce benchmarks from tool blogs (Triple Whale, Foundry CRO, Osmos, Redstag, SQ Magazine); directionally consistent but present CVR/AOV/CAC as tunable bands.

### Regulatory/privacy
- Signal loss (iOS ATT + cookie deprecation) is why blended CAC/MER and modeled measurement rose.
- State privacy laws (CCPA/CPRA); Consent Mode / server-side (GA4, Meta CAPI). FTC click-to-cancel for subscription DTC.

### Capstone: "The Profitable-Growth Tightrope"
AOV $80, GM 60%, blended ROAS 2.9x, blended CAC $42, returning rate 35%. Break-even ROAS = 1/0.60 = 1.67x. New-customer CAC $68 rising. Hit +40% revenue while keeping contribution margin positive after CAC and LTV:CAC >=3:1. Levers: raise AOV (bundle/free-ship), shift Google (8x capped) vs Meta (declining ROAS on saturation curve), improve returning LTV. Lesson: growth must come from AOV + retention, not just impressions.

## Build notes
- Three distinct math lenses, do not collapse to "ROAS with different numbers."
- Cite-freely anchors: US retail media $60.32B->$71.09B (eMarketer), global $174.9B->$196.7B (WARC), US CPG ad $66B / digital $55B->$56.07B (eMarketer), US ecommerce ~$1.19T at 16.8% (Census), Skai Q4 2025 retail media +33%/CPC -1%/CTR +9%.
- Tunable bands (tool/agency blogs): ecommerce CVR 2.5-3.2%, AOV ~$150, Meta CPM ~$14, ROAS ranges, Amazon ACoS 29%, retail media 6.1x.
- Do-not-hardcode: CPG penetration averages, base-vs-incremental splits, "154% RMN return", ~$150 global AOV.
