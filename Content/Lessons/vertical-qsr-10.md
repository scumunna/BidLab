---
id: vertical-qsr-10
track: vertical-qsr
module: 10
title: CPIV Reconciliation, the Offline Drive-Thru Gap, and Sensitive-Location Privacy Limits
summary: Reconcile conflicting footfall vendor visit counts into one defensible CPIV, report visits as a proxy when most QSR sales close offline at the drive-thru, and run location targeting inside 2025-2026 state privacy limits.
---
# Closing the loop: which denominator owns your CPIV

This is the last mile of the QSR job. You proved lift in Lesson 9, and now you have to report a number the brand will defend in a QBR. The problem is that CPIV is a ratio, $\text{CPIV} = \text{media spend} / \text{incremental visits}$, and the spend is the only term everyone agrees on. The incremental-visits denominator depends entirely on which measurement vendor you trust, because Foursquare, your DSP's in-platform tool, and an SSP-supplied measurement product each use different panels, polygons, dwell thresholds, and dedup logic.

The discipline is to pre-agree a primary measurement source before the flight launches, document it, and report CPIV against that source even when a second vendor reports a friendlier number. Cherry-picking the vendor that happens to report the most visits produces the cheapest CPIV and the least defensible one. You triangulate across vendors to understand the spread, then you stand behind the source you committed to.

:::callout key
The CPIV you report is a governance decision, not just a math problem. Lock the primary footfall vendor in the measurement plan before launch, write down its visit definition (dwell threshold, polygon source, dedup rule), and report against it consistently. The cheapest CPIV is worthless if you cannot say which denominator produced it.
:::

:::predict
prompt: You spent $90,000. Your agreed primary vendor reports 9,000 incremental visits, while a second vendor claims 12,000. What CPIV do you report to the brand?
answer: 10
tolerance: 0.1
unit: USD
hint: Use the agreed primary vendor's denominator, not the friendlier one.
explain: Report against the source you committed to. $90,000 / 9,000 = $10.00 CPIV. The second vendor's 12,000 would give $90,000 / 12,000 = $7.50, a cheaper but indefensible number you did not pre-agree.
:::

# Sizing the vendor disagreement before you defend it

When two footfall vendors return different visit counts for the same flight, the first thing to quantify is the size of the gap, because a 5 percent spread is panel noise and a 30 percent spread is a methodology fight you have to explain. Vendor variance is $(\text{vendor A visits} - \text{vendor B visits}) / \text{vendor B visits}$, measured against whichever you treat as the baseline. The Cuebiq fast-food Average CPIV benchmark is $8.84 (Cuebiq 2023 Footfall Attribution Benchmark Data), so a vendor disagreement that moves your reported CPIV across that benchmark band changes the story you tell.

Knowing the variance lets you walk into the room ready. You explain that Vendor A uses a tighter dwell threshold or a looser polygon, that the difference is methodological rather than a sign the campaign failed, and that you are reporting against the documented primary source. The variance number turns an awkward "why don't these match" into a controlled answer.

:::predict
prompt: Vendor A reports 12,000 incremental visits and Vendor B reports 10,000 for the same flight. What is the vendor variance of A relative to B?
answer: 20
tolerance: 0.5
unit: %
hint: Subtract B from A, then divide by B.
explain: (12,000 - 10,000) / 10,000 = 0.20, a 20 percent variance. A is reporting 20 percent more visits than B, large enough that it would shift the reported CPIV and must be reconciled to one primary source.
:::

:::widget barChart
title: Conflicting incremental-visit counts, same flight
labels: Vendor A, Vendor B, In-platform
data: 12000, 10000, 11000
unit: visits
:::

# The offline drive-thru gap: visits as a proxy for sales

Even a perfect footfall count cannot be tied to revenue in QSR, because roughly 65 percent of US fast-food sales still complete at the drive-thru with no digital purchase event (down from an 83 percent pandemic peak, while digital orders reached about 42 percent of QSR sales in 2025, up from 38 percent in 2024). A visit you measured may convert to a $12 combo or to nothing, and the cash drawer never tells your DSP. This is the structural reason QSR optimizes to CPIV and not to a closed-loop ROAS the way a retail-media campaign with first-party sales data can.

So you report incremental visits as the measurable proxy and flag the visit-to-sale linkage as a separate, data-dependent step that only opens once the brand shares POS or loyalty data. Measured-sales coverage is $\text{digitally-attributable orders} / \text{total orders}$, and in QSR that ratio is low by structure, not by failure. Saying so up front is the honest framing; pretending visits equal sales is the trap.

:::predict
prompt: In a sample of 200 QSR orders, 42 percent arrived through digital channels and the rest closed offline at the counter or drive-thru. How many orders have no digital purchase event to tie a visit to revenue?
answer: 116
tolerance: 1
unit: orders
hint: Find the offline share first, then apply it to 200.
explain: Offline share is 100% - 42% = 58%. 0.58 x 200 = 116 orders close offline with no digital event, which is why footfall stays a proxy and sales linkage needs the brand's POS or loyalty data.
:::

:::quiz
question: Why does QSR programmatic report incremental visits rather than a closed-loop sales ROAS by default?
- Footfall vendors are cheaper than sales-attribution vendors
- Roughly 65 percent of fast-food sales close offline at the drive-thru with no digital purchase event
- DSPs are not allowed to ingest revenue data
- Visits are always a more accurate signal than sales
answer: 1
hint: Think about where the transaction actually completes for most fast-food orders.
explain: With about 65 percent of sales completing at the drive-thru and no digital purchase event, there is no native revenue signal to close the loop. Visits are the measurable proxy, and sales linkage only opens once the brand shares POS or loyalty data.
:::

# State privacy law constrains the location data the model runs on

The governance layer is no longer optional. Maryland's MODPA took effect October 1, 2025 and applies to processing from April 1, 2026; it defines precise geolocation as locating a consumer within a 1,750-foot radius, classes it as sensitive data with an absolute sale ban and strict data minimization, and bars geofences within 1,750 feet of mental-health or reproductive/sexual-health facilities. Maryland and Oregon now prohibit selling precise geolocation data generally, regardless of proximity to a sensitive site, and Virginia's equivalent ban takes effect July 1, 2026. For a footfall model that rides on selling and matching location data, this can render some traditional geofencing inoperable.

The practical move is a compliant-geo screen run across your store list before launch, $\text{compliant geos} / \text{total store geos}$, that flags any geo whose targeting radius or data-sale dependency violates state law and any store whose radius overlaps a protected facility within 1,750 feet. Geos that fail get a suppression polygon, coarser POI-list targeting, or a consented-data path instead of precise-geo sale. Competitor-conquest geo around rival stores (the Whopper Detour geo-fenced within 600 feet of about 14,000 McDonald's locations) is operationally proven but now sits in the most legally scrutinized zone and needs brand-safety and legal sign-off before it runs.

:::callout warning
A recurring operator complaint on r/adops and r/programmatic for 2025-2026 flights is that MODPA and the Maryland and Oregon precise-geolocation sale bans (with Virginia's effective July 1, 2026) "kill geofencing," leaving QSR location targeting and footfall measurement in legal limbo. The real failure mode is quieter: a national store-radius buy silently overlaps a health facility inside 1,750 feet, or your footfall partner's product depends on selling location data that is now banned in Maryland, and nobody screened for it until legal flagged it post-launch. Run the compliant-geo screen and re-clear competitor-conquest tactics before the flight, not after.
:::

:::predict
prompt: A national buy covers 600 store geos. After the compliance screen, 480 pass and the remainder either overlap a protected facility within 1,750 feet or rely on a banned precise-geo data sale. What share of store geos are compliant?
answer: 80
tolerance: 0.5
unit: %
hint: Divide compliant geos by total geos.
explain: 480 / 600 = 0.80, an 80 percent compliant rate. The failing 20 percent (120 geos) need suppression polygons, coarser POI-list targeting, or a consented-data path before they can run.
:::

:::figure cleanRoomMatch
caption: When precise-geo sale is restricted, measurement and audience matching shift to consented, aggregated linkage in a clean room rather than 1:1 location-data sale, which is how a footfall model stays alive under MODPA and the VA/MD/OR sale bans.
:::

# Putting reconciliation, the gap, and governance into one report

The closeout deliverable folds all three problems into one defensible narrative. You state the reconciled CPIV against the documented primary vendor, you show the vendor variance so the spread is transparent rather than hidden, you report incremental visits as the proxy and name the POS/loyalty linkage as the separate step it is, and you confirm the location data met state law. That is the difference between selling measurement and selling marketing: a vendor that cannot clearly state its visit definition, or a trader who cannot say which denominator and which compliance screen produced the number, is doing the latter.

The reconciliation also feeds the next flight. If the primary vendor's CPIV landed above the Cuebiq fast-food $8.84 Average benchmark, the spread against other vendors tells you whether the issue is real performance or a denominator artifact, and the compliant-geo screen tells you which stores you can keep targeting at precise-geo level next time. Closing the loop honestly is what earns the trader the next budget.

:::quiz
question: Two footfall vendors report materially different incremental-visit counts for the same QSR flight. What is the defensible reconciliation move?
- Report whichever vendor gives the lowest CPIV
- Average the two vendor counts and report the midpoint with no source named
- Report against the pre-agreed primary vendor, quantify the variance, and document the visit definition
- Drop footfall entirely and report click-through rate instead
answer: 2
hint: One option ties the number to a committed, documented source rather than to convenience.
explain: You report against the source you committed to before launch, quantify the variance so the disagreement is transparent, and document the visit definition behind it. Cherry-picking the cheapest CPIV, silently averaging, or retreating to CTR are all indefensible in a QBR.
:::

:::sources
- AdImpact, Q1 2026 Fast Food Advertising Trends (broadcast, CTV, ad spend) | https://adimpact.com/blogs/q1-2026-fast-food-advertising-trends
- Cuebiq, 2023 Footfall Attribution Benchmark Data Report (CPIV, visit rate, uplift by vertical) | https://cuebiq.com/2023-footfall-attribution-benchmark-data-report/
- Cuebiq, Footfall Attribution Benchmarks (current benchmark hub, incl. 2025 Benchmark Report) | https://cuebiq.com/benchmarks/
- Revenue Management Solutions, Drive-thru is 65% of US fast-food sales (down from 83% pandemic peak), 2025 channel shifts | https://www.revenuemanage.com/blog/drive-thru-trends-2025-qsr/
- Cooley, Maryland's Online Data Privacy Act (MODPA): 1,750-ft precise geolocation, sensitive data, sale ban | https://www.cooley.com/news/insight/2025/2025-09-09-marylands-unique-state-privacy-law-takes-effect-october-1--what-you-should-know
- Troutman Pepper Locke (via JD Supra), Virginia Becomes Third State to Ban Sale of Precise Geolocation Data (1,750-ft definition) | https://www.jdsupra.com/legalnews/virginia-becomes-third-state-to-ban-7586857/
- aidigital, Foot Traffic Attribution: polygon mapping, dwell, neighbor exclusion | https://www.aidigital.com/blog/footfall-attribution
:::
