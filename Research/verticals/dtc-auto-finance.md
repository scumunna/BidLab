# Vertical Research: DTC, Auto, Finance

Research June 2026. Aggregator-sourced numbers flagged; eMarketer/Adweek/Marketing Dive, WordStream, Cox Automotive, FCRA statute, Meta policy docs are the load-bearing citations. Tier-B aggregator blogs (PPCChief, Eightx, Sovran, Triple Whale, MHI, Prospeo) ride behind an in-app "benchmarks directional, refreshed periodically" note.

## 1. DTC / Direct-to-Consumer

### Market
- US DTC ecommerce sales **$239.75B in 2025** (~19.2% of US retail ecommerce) `[FLAG: SQ Magazine aggregator over eMarketer]`. https://sqmagazine.co.uk/direct-to-consumer-brand-statistics/
- No clean DTC ad-spend line (spans Retail+CPG). Anchor: total US digital ad spend ~**$338.27B in 2025** (+9.5%, revised down for tariffs). https://www.marketingdive.com/news/digital-ad-spending-outlook-dims-as-tariff-impact-intensifies-emarketer/760858/
- Most Meta-dependent vertical: Meta ~68% of ecommerce ad budgets `[aggregator]`.

### What's distinctive
- Unit economics ARE the campaign (contribution margin + LTV, not reach).
- Blended vs paid: post-iOS14.5 in-platform ROAS unreliable; operators run platform-attributed ROAS (over-claims) + blended CAC/MER (honest). iOS signal loss ~20-30%.
- Short funnel, fast payback pressure. Subscription multiplies LTV 3-5x.

### Formulas
```
CAC(paid) = Paid spend / New customers from paid ; Blended CAC = Total mktg / Total new customers
MER = Total Revenue / Total Ad Spend ; AOV = Revenue / Orders
Gross margin % = (Revenue - COGS)/Revenue ; Contribution margin = AOV - COGS - variable (ship/pay/fulfill/returns)
LTV(one-time) = AOV x Freq x Lifespan x GM% ; LTV(sub) = (ARPU x GM%)/Monthly Churn
LTV:CAC (>=3:1 good, >=5:1 elite) ; CAC Payback(mo) = CAC / Monthly contribution margin per customer
```
Teach: use gross-margin LTV (LTGP:CAC), not revenue LTV, or the ratio lies.

### Benchmarks
- LTV:CAC >=3:1 good, >=5:1 elite (Eightx). CAC payback <12mo good, top quartile 8mo, bottom 18+mo (Saras). MER "good" >=3.0.
- CAC by vertical 2026: Beauty $61-68, Apparel $66-72, Food $45-53, Luxury $150-200+ `[FLAG: aggregator, wide variance]`.
- Meta CPM median ~$13.48 (all-industry $14.19, 2026, +20% from $11.82). Meta ROAS (ecom) median ~1.93 (platform-attributed); 3-4x profitability floor.
- Marketing as % of revenue ~17.2% in 2025 (Eightx 10-K report - relatively strong).

### Regulatory/privacy
- iOS ATT is the defining constraint (drives blended-vs-paid split, Conversions API ~89% adoption). State privacy laws + consent mode. DTC "regulation" is platform policy + attribution loss, not statute.

### Capstone: "The Scaling Trap"
Skincare DTC: AOV $58, GM 70%, blended CAC $42, LTV $145. Meta CPMs +20%, platform ROAS 2.4->1.9. Keep LTV:CAC >=3:1 and payback <6mo while scaling $50k->$150k/mo. Decide prospecting vs retargeting, model rising CAC at scale, push subscription vs cut CAC. Win: blended MER >=3.0, payback <=6mo at higher spend.

## 2. AUTO / Automotive

### Market
- US automotive digital ad spend ~**$22.25B in 2025**, +2.2% YoY (eMarketer's biggest downward revision, tariffs). Source: eMarketer via Adweek + Marketing Dive. https://www.adweek.com/brand-marketing/retailers-automakers-slash-most-digital-ad-spend-2025-emarketer-tariffs/
- Dealer (Tier 3) ad spend ~**$9.96B in 2025** (+0.4%, record); **74.9%** of dealer ad spend is digital. https://news.dealershipguy.com/p/dealer-ad-spend-nears-10-billion-as-digital-marketing-dominates

### What's distinctive: the three-tier structure
- Tier 1 National OEM: brand/awareness, measured on reach/lift, manufacturer-funded.
- Tier 2 Regional dealer associations: pooled funds, regional offers, hybrid brand+performance.
- Tier 3 Individual dealer: performance layer (specific inventory/store), leads/VDP views/calls/visits. OEM co-op reimbursement flows manufacturer->Tier3, often up to 100% of eligible spend.
- Long consideration window (weeks/months); cost-per-VDP-view + VDP-to-lead funnel > last-click.
- Conquesting (bid competitor models) + in-market audiences inflate CPCs but reach intent.
- Lead quality > volume (dupes/bad-fit are the central problem).

### Formulas
```
Cost per VDP view = Spend / VDP views ; VDP-to-lead = Leads / VDP views
CPL = Spend / Leads ; Cost per qualified = Spend / (de-duped in-market leads)
Effective CPL = CPC / Landing-page CVR
Cost per sale = Spend / Units sold ; Net Tier-3 cost = Gross spend - OEM co-op reimbursement
Co-op reimbursement = Eligible spend x Co-op rate (often up to 100% of eligible)
```
Teach: dealers think ~$175/lead but real cost-per-qualified runs $250-280 (dupes strip 30-60%). Cox/Invoca.

### Benchmarks
- Auto search CPL (Google) **$38.86** (DealerTalk Apr2024-Mar2025).
- Avg dealership lead cost ~$250; real cost 30-60% above quoted (Invoca).
- VDP-view lift: +53% from listing price, +65% from custom photos (Cox/AutoTrader - strong).
- % dealer spend digital: 74.9% (2025).
- `[FLAG]` No current (2025-26) authoritative cost-per-VDP-view figure; only 2016-2018 forum data (~$0.70-0.85). Present VDP cost as a relative/derived metric, not a hard benchmark.

### Regulatory/privacy
- OEM co-op compliance: approved logos/colors/messaging, certified vendors, proof-of-performance; mentioning competitors or unapproved logos voids the claim. DemandLocal/LeadVenture.
- FTC CARS Rule vacated by 5th Circuit Jan 27 2025 (pricing-transparency principles remain best practice). FTC deceptive-ad penalty $53,088/violation (FTC Act Section 5(m); 16 CFR Part 1, inflation adjustment eff. Jan 17 2025, unchanged for 2026).

### Capstone: "Tier-3 with co-op handcuffs"
Honda dealer, $40k/mo, 50% co-op match on COMPLIANT spend only. Sell 30 incremental units/mo under target cost-per-sale. Allocate across in-market search, conquesting, VDP-driving inventory ads; every creative checked vs OEM rules (break rule -> lose match on that line). Twist: dupes/bad-fit leads, optimize cost-per-qualified-lead. Win: >=30 units, net cost-per-sale under budget, co-op compliance on >=90% of spend.

## 3. FINANCE / Financial Services

### Market
- US financial services total media ad spend grew **17.8% in H1 2025 to $5.9B**; sector digital growth forecast to outpace all industries. https://www.emarketer.com/chart/c/353711/
- Financial media network ad spend ~**$640M (2025) -> $1.22B (2026)** (emerging niche). https://www.emarketer.com/content/financial-media-ad-spend-will-top--1-billion-by-2026

### What's distinctive
- Highest CPMs/CPCs of any vertical ($50-100+ CPM normal). Most expensive Google keywords: insurance ~$54.91, mortgage ~$47.12, loans ~$44.28 CPC (WordStream - authoritative for "most expensive keywords").
- Compliance shrinks the auction (disclosures, banned targeting, approval cycles).
- Economics work via LTV: $650 CPL rational when a funded client is worth $50,000+.
- Funnel deeper than a lead: cost per application, cost per funded account / bound policy. Highest CTR (8.33%) but lowest CVR (2.55%) of any vertical (PPCChief 2026).
- Geo premiums: premium metros +20-40% above national.

### Formulas
```
CPM = (Spend/Impr) x 1000 ; CPC = Spend/Clicks ; CPL = Spend/Leads
Cost per application = Spend / Applications ; Cost per funded = Spend / Funded accounts
Lead->App rate = Apps/Leads ; App->Fund rate = Funded/Apps
Cost per funded = CPL / (Lead->App x App->Fund)   <- the cascade widget
Lead quality ROI = (Funded x LTV)/Spend ; Allowable CAC = LTV x Target margin (bid ceiling)
```
Teach cascade: $50 CPL x 30% lead->app x 40% app->fund = $417 cost per funded (before fraud/bad leads).

### Benchmarks
- Finance & Insurance avg CPC (Google) ~$3.46 (range $2.59-4.67, +15% YoY). CTR 8.33% (highest), CVR 2.55% (lowest). CPL ~$83.93 (+10.5% YoY). PPCChief 2026.
- Cross-channel finance CPL ~$653 `[FLAG: vs Google $84 - different scope (high-value advisory); reconcile]`. Financial advising CPL ~$58.70. Meta finance CPL ~$13.33-37.81.
- Finance CPM $50-100+ (vs ~$14 all-industry).
- Teach: "CPL is meaningless without specifying channel and product."

### Regulatory/privacy (richest of the three)
- Meta "Financial Products & Services" Special Ad Category (eff. Jan 14 2025): age locked 18-65+, no gender targeting, ZIP targeting eliminated (15-mile min radius), no Lookalikes, no detailed-targeting expansion. As of Sept 2 2025, no Custom Audiences on income/net-worth/creditworthiness. (Anti-discrimination framework.)
- FCRA: marketing not a permissible purpose EXCEPT prescreening under 604(c), which requires a genuine "firm offer of credit or insurance" (603(l)) + Reg V 1022.54 opt-out disclosure. Targeting a prescreened audience legally requires the creative to contain a firm offer + opt-out.
- Regulated creative: APR/rate disclosures, "subject to credit approval", fair-lending language (depresses CTR).

### Capstone: "Cost-per-funded under compliance"
High-yield savings account. Constraints: Meta Special Ad Category (no ZIP, 15-mile min, no lookalikes, no wealth-based custom audiences) + required APY disclosure on every creative. Funnel $X CPL -> 35% lead->app -> 50% app->fund. Hit cost per funded <=$300 and >=500 funded accounts on fixed budget; portion of leads fraudulent/ineligible. Trade cheap-broad reach (forced by limits) vs quality; non-compliant ad = disapproved (wasted spend). Win: >=500 funded at <=$300 each, zero disapproved creative.

## Cross-vertical
- Signature anchors: DTC -> blended MER / LTV:CAC; Auto -> three-tier + co-op net cost; Finance -> cost-per-funded cascade.
- Cite-freely: eMarketer/Adweek/Marketing Dive, WordStream most-expensive-keywords, Cox Automotive, FCRA statute, Meta policy docs.
- Re-verify before shipping: SQ Magazine DTC $239.75B vs eMarketer; a current cost-per-VDP-view; $653 vs $84 finance CPL scope; FTC $53,088 penalty (verified Jan 2025 adjustment, current for 2026); auto $22.25B vs eMarketer forecast page.
