---
id: vertical-qsr-01
track: vertical-qsr
module: 1
title: The Money Map, QSR Programmatic Landscape, Channels, and the Local-at-Scale Problem
summary: Map where QSR ad money flows, why the win condition is an incremental store visit measured by CPIV, and how a national DSP buy fans out to thousands of local doors.
---
# Why QSR money is different

A national QSR brand does not spend to drive a click or a landing-page sign-up. It spends to push one more person through a physical door, at one of thousands of individual store addresses, during a meal-decision window. That single fact reshapes the whole job: you are buying local-at-scale through national DSPs (DV360, The Trade Desk, Yahoo, StackAdapt, Viant), and the win condition is an incremental store visit, not a CTR. The signature KPI is CPIV, cost per incremental visit, the budget needed to drive one extra visit above a control group.

Because the purchase usually completes off-platform (roughly 65% of US fast-food sales still close at the drive-thru in 2025, down from an 83% pandemic peak in 2020), there is no clean closed-loop sales signal the way a retail media network has. Measurement leans on third-party location and footfall vendors instead of a retailer's first-party sales data. That gap is the thread running through this entire path.

:::callout key
QSR is local-at-scale: one national strategy executed across thousands of separately-located, often franchise-funded doors. Optimize to incremental visits and CPIV, not clicks, impressions, or CTR.
:::

:::quiz
question: Why does a QSR programmatic buy optimize to CPIV (cost per incremental visit) rather than to CTR or a digital purchase event?
- Because clicks are cheaper to report than visits
- Because the win condition is a physical store visit and most sales close offline at the drive-thru, so there is no clean digital purchase signal
- Because DSPs cannot measure clicks on CTV
- Because CPIV is the same metric as CPA
answer: 1
hint: Think about where the actual fast-food transaction happens.
explain: The business goal is incremental footfall into physical stores, and with roughly 65% of sales completing at the drive-thru there is no reliable digital purchase event to optimize toward. So the trader optimizes to incremental visits and reports CPIV. Clicks are irrelevant to a drive-thru visit, and CPIV is not the same as CPA.
:::

# The channel mix is shifting hard to CTV

The center of gravity in QSR media is moving to connected TV. AdImpact reports chicken-chain CTV impressions rose from 1.1 billion in Q1 2024 to 4.1 billion in Q1 2026. In Q1 2026 the all-QSR CTV impression leaders were McDonald's at 3.1B, Chick-fil-A at 2.7B, Arby's at 2.4B, Little Caesars at 1.3B, and Domino's at 1.1B (a broader set than the chicken-chain aggregate above). Digital audio, mobile in-app, display, and programmatic OOH/DOOH fill in the rest of the local meal-decision moment around that CTV core.

Here is a practitioner habit worth building on day one: sanity-check vendor-published percentages before you repeat them to a client. AdImpact's own blog headlines that chicken-chain CTV growth as "310%," but the arithmetic on its own inputs does not support that. The correct percent increase is $(4.1 - 1.1) / 1.1 = 272.7\%$, roughly 273%, not 310%. A trader who cannot spot a wrong number in a vendor deck will eventually quote one in a QBR.

:::figure retailMediaFlow
caption: QSR supply spans CTV, digital audio, mobile in-app, display, and programmatic DOOH bought through national DSPs, with retail and delivery media networks (Instacart, DoorDash, Uber Eats) as an emerging conquesting adjacency.
:::

:::widget barChart
title: Q1 2026 QSR CTV impression leaders
labels: McDonald's, Chick-fil-A, Arby's, Little Caesars, Domino's
data: 3.1, 2.7, 2.4, 1.3, 1.1
unit: B impressions
:::

:::predict
prompt: QSR chicken-chain CTV impressions grew from 1.1B in Q1 2024 to 4.1B in Q1 2026. What is the correct percent increase (not the source's stated figure)?
answer: 272.7
tolerance: 0.5
unit: %
hint: Percent change is (new minus old) divided by old.
explain: (4.1 - 1.1) / 1.1 = 3.0 / 1.1 = 2.727, so 272.7%. The source's headline "310%" does not match its own 1.1B to 4.1B inputs, which is exactly the kind of vendor number you sanity-check before repeating it.
:::

# Reading the budget split

A QSR media plan is a mix of channels, and your first orientation task is reading what share each one carries. The arithmetic is simple, channel mix percent equals channel spend divided by total campaign spend, but it tells you where the risk and the measurement complexity sit. A CTV-heavy plan buys broad reach into the living room but has no deterministic device-to-doorstep link, so it complicates footfall attribution relative to a mobile-heavy plan that carries a device location.

That trade is the channel-planning tension in one line: CTV maximizes reach at the meal moment, mobile maximizes measurable footfall. Most QSR plans run both, and you will spend real time reconciling reach against attribution clarity across that split.

:::predict
prompt: A QSR campaign spends $400,000 in total, with $260,000 of it on CTV. What share of the budget is CTV?
answer: 65
tolerance: 0.5
unit: %
hint: Channel mix percent is channel spend divided by total spend.
explain: 260,000 / 400,000 = 0.65, so CTV is 65% of the budget. A split this CTV-heavy buys strong meal-moment reach but means most of the spend carries no device-level location signal, pushing more weight onto geo and panel-based footfall measurement.
:::

:::quiz
question: A QSR plan shifts heavily toward CTV. What is the main measurement trade-off the trader inherits?
- CTV is cheaper per impression, so CPIV automatically falls
- CTV has no deterministic device-to-doorstep link, so it improves reach but complicates footfall attribution versus mobile
- CTV cannot be bought programmatically, so it must be reported separately
- CTV always over-counts visits
answer: 1
hint: Which device carries a precise location that a footfall vendor can match to a store polygon?
explain: A phone carries a device location that footfall vendors can match to a store polygon; a TV generally does not. So a heavier CTV mix lifts reach at the meal moment but weakens the device-to-visit link, forcing measurement onto geo-holdout and panel methods. CTV is fully programmatic, and cheaper impressions do not by themselves lower cost per incremental visit.
:::

# CPIV: the number the brand actually cares about

Every channel decision eventually rolls up to one figure the brand judges you on: CPIV. The definition is media spend divided by incremental visits, where "incremental" means visits above what a matched control group did on its own. You will go deep on the control-group machinery later in this path; for now, internalize that the denominator is incremental visits, not raw attributed visits, because some of those people would have walked in anyway.

Build the muscle of computing it cleanly from a media spend and an incremental-visit count, because this is the headline you will defend in every reporting cycle. Get comfortable moving between the three quantities (spend, incremental visits, CPIV) in any direction.

:::predict
prompt: A QSR LTO campaign spends $480,000 and a matched-control test attributes 60,000 incremental store visits. What is the CPIV?
answer: 8
tolerance: 0.1
unit: USD
hint: CPIV is media spend divided by incremental visits.
explain: 480,000 / 60,000 = 8.00, so CPIV is $8.00 per incremental visit. That sits right around the typical QSR benchmark band, which is cheap relative to most verticals because fast food is a high-frequency, low-consideration purchase, not because the trading is necessarily superior.
:::

:::predict
prompt: A brand wants CPIV at $6.00 or better on a campaign expected to drive 75,000 incremental visits. What is the maximum media spend that still hits that CPIV?
answer: 450000
tolerance: 1000
unit: USD
hint: Rearrange CPIV equals spend divided by incremental visits to solve for spend.
explain: Max spend = target CPIV times incremental visits = 6.00 x 75,000 = $450,000. If you spend more than that without lifting incremental visits, CPIV breaches the $6.00 goal. This is the back-of-envelope check you run before committing a budget to a flight.
:::

# Local execution: one IO, thousands of doors

The defining operational pain of QSR is that a single insertion order fans out to hundreds or thousands of store-level line items, each needing its own geo-targeting and budget. The fan-out math is mechanical, store-count load equals the number of geo-targeted store line items, often one per address or per DMA cluster, but at national scale it becomes a trafficking and QA problem you cannot do by hand. Bulk-sheet uploads (DV360 SDF, TTD bulk) are the only sane path, and they silently mis-map store coordinates when a row is malformed.

Two structural wrinkles make it worse. First, the budget is fragmented: spend is split across a national ad fund and many franchise co-ops funded by individual owner-operators, so one "campaign" is really dozens of separately-funded sub-campaigns with different flight dates and creatives. Second, open-exchange local inventory is thin in rural DMAs, so franchise stores outside major metros get under-served unless you reach for PMP or direct deals. Both themes get their own lesson; the point here is that local-at-scale is the source of most QSR execution effort and most silent errors.

:::callout warning
A recurring r/adops and r/programmatic complaint: QSR "local at scale" campaigns with hundreds of store geos are brutal to traffic and QA by hand, and bulk-sheet uploads silently mis-map store coordinates. Traders also gripe that national DSPs price local CTV and inventory poorly, with fill rates collapsing outside major metros, so rural franchise stores get starved. Treat every bulk geo upload as guilty until QA proves the coordinates resolve to your stores.
:::

:::predict
prompt: A national QSR brand traffics one store-level line item per location across 1,200 stores. If the brand later adds a separate breakfast-daypart line item for each store, how many store line items are live in total?
answer: 2400
tolerance: 0
unit: line items
hint: Each store now carries two line items, the base plus the breakfast daypart.
explain: 1,200 stores x 2 line items per store = 2,400 line items. Store-count load scales with stores times dayparts times creatives, which is why a single IO can explode into thousands of rows and why bulk SDF or templated line-item trees are mandatory rather than optional.
:::

# The offline gap and why this path exists

The reason QSR gets its own ten-lesson path is the measurement gap created by offline sales. With roughly 65% of fast-food orders still completing at the drive-thru and no digital purchase event attached, even a perfect footfall count cannot be tied directly to revenue unless the brand shares POS or loyalty data. Two different lenses describe this gap, and a trader has to keep them straight. Drive-thru share, about 65% of orders in 2025, is a transaction-completion channel: where the order is fulfilled. Digital-order share, about 42% of QSR sales in 2025 (up from 38% in 2024), is an order-placement signal: whether an app, web, or kiosk event exists for the order. These are not complementary metrics and they do not sum to 100, because a drive-thru order can also be placed in the app and some non-drive-thru orders still complete offline at the counter. The digital figure is the one that matters for measurement, because it is the share of orders that leave any pixel-visible trace, and it is climbing, which slowly improves the signal. Even so, most orders still place where no pixel can see them.

So the trader reports visits as the measurable proxy for sales and flags the revenue linkage as a separate, data-dependent step. Everything downstream in this path, geo QA, deal plumbing, pacing, identity, fraud control, incrementality, and reconciliation, exists to make that visit number trustworthy enough to stand in for a sale.

:::widget donutChart
title: Digitally-visible order placement (2025, US QSR sales)
labels: Digital order (app/web/kiosk), Non-digital order
data: 42, 58
unit: %
:::

:::predict
prompt: A QSR brand records 200,000 orders in a market in 2025. If about 42% of those orders carry a digital event (the 2025 QSR digital-order share), how many orders are digitally visible?
answer: 84000
tolerance: 0
unit: orders
hint: Multiply total orders by the digital-order share, 42%.
explain: 200,000 x 0.42 = 84,000 digitally-visible orders. The other ~116,000 place with no digital event, which is exactly why footfall is the measurable proxy and why CPIV, not a sales-based ROAS, is the north-star KPI for this vertical. Note this 42% order-placement share is a different metric from the ~65% drive-thru completion share, so the two are not complements and you cannot derive one by subtracting the other from 100.
:::

:::sources
- AdImpact, Q1 2026 Fast Food Advertising Trends | https://adimpact.com/blogs/q1-2026-fast-food-advertising-trends
- Cuebiq, Footfall Attribution Benchmarks (CPIV by vertical) | https://cuebiq.com/benchmarks/
- QSR Pro, State of QSR 2026 (digital orders 42% of sales in 2025, up from 38% in 2024) | https://qsr.pro/reports/state-of-qsr-2026
- Revenue Manage, QSR Drive-Thru Trends (drive-thru 65% of orders in 2025, down from 83% in 2020) | https://www.revenuemanage.com/blog/drive-thru-trends-2025-qsr/
- Goodway Group, How Does Franchise Co-Op Advertising Work | https://goodwaygroup.com/blogs/franchise-co-op-advertising
- KORTX, Restaurant Marketing Strategy: The 2026 QSR Playbook | https://kortx.io/news/restaurant-marketing-strategy-qsr/
- aidigital, Foot Traffic Attribution: polygon mapping, dwell, neighbor exclusion | https://www.aidigital.com/blog/footfall-attribution
:::
