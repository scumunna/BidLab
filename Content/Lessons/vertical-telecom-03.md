---
id: vertical-telecom-03
track: vertical-telecom
module: 3
title: Serviceability and Footprint, Only Bid Where You Can Actually Sell
summary: Encode a carrier's serviceable footprint into line-item targeting so budget only reaches addressable households, measure in-footprint working media daily, and price the waste that out-of-footprint delivery hides.
---
# The constraint that makes telecom different

A fiber, cable, or FWA carrier can only sell service to addresses inside its build-out footprint, and even wireless promos are usually geo-fenced to store trade areas or coverage zones. If a line item serves an impression to an out-of-footprint household, that impression is 100% waste no matter how cheap the CPM or how well the creative converts a click, because the prospect literally cannot place an order. This is the single most telecom-specific delivery constraint and the number-one waste source on a carrier buy, so it sits ahead of bid strategy and pacing in the trader's priority order.

The fix is not a setting you toggle once. You encode serviceability into targeting at the line-item level, then watch a working-media health metric every day, because footprint leakage is exactly where a "great" CPM hides terrible economics.

:::callout key
In every other vertical a converting click is a win. In footprint-bounded telecom a converting click from an out-of-footprint address is still a zero, because the household fails the serviceability check at the order page. Reach inside the footprint is the only reach that can become a gross add.
:::

:::quiz
question: A fiber line item buys a $9 CPM, beats its CTR target, and the clicks convert at a high rate, but 40% of impressions land outside the build-out footprint. How should the trader read the out-of-footprint half?
- It is fine, because the low CPM and strong CTR prove the supply is high quality
- It is 100% wasted spend, because those households cannot order service regardless of CPM or CTR
- It is partially recoverable, because some out-of-footprint clickers will move into the footprint later
- It is acceptable as long as blended CPGA still looks low
answer: 1
hint: Ask what a click is worth from an address the carrier physically cannot serve.
explain: An out-of-footprint household cannot buy the service, so every impression and click there is absolute waste. A cheap CPM and a strong CTR on unservable addresses just produce efficient-looking spend that can never become a gross add, which is why footprint is a hard inclusion layer, not a CPM question.
:::

# Encoding the footprint into a line item

The mechanic is a pipeline. You onboard the carrier's serviceable-address or coverage-polygon file (the same primitive that ISP-specific DSPs such as Front Porch build their business on), translate it into ZIP+4, geo-polygon, or household-addressable audiences through a clean room or onboarder, and apply it as an inclusion layer on every single line item. You then build separate line items per footprint tier (fiber-passed versus FWA-eligible versus wireless-only) because the offer, the creative, and the allowable SAC differ across tiers and a single line item cannot carry three economics.

Household-addressable inventory is targetable at the individual-household level using durable IDs and clean-room matching, which is what lets a carrier restrict delivery to serviceable addresses rather than blasting a whole metro. The trafficking discipline is that no line item goes live without the footprint layer attached and verified, the same way no campaign goes live without a pixel.

:::figure npiTargeting
caption: The serviceability layer narrows a broad geo down to only addressable, in-footprint households at the line-item level. Each tier (fiber-passed, FWA-eligible, wireless-only) gets its own line item because offer and allowable SAC differ.
:::

:::quiz
question: A client asks you to traffic a single national line item for a fiber product and "just target the right ZIPs." What is the trafficking problem with one line item across the whole footprint?
- Nothing, one line item is the cleanest setup
- Fiber-passed, FWA-eligible, and wireless-only homes carry different offers and allowable SAC, so they need separate line items
- A single line item cannot hold a frequency cap
- National line items are not allowed in any DSP
answer: 1
hint: Think about whether one offer and one bid ceiling can serve three different footprint tiers.
explain: The offer, creative, and allowable SAC differ by footprint tier, so collapsing fiber-passed, FWA-eligible, and wireless-only homes into one line item forces one bid ceiling and one creative onto three different economics. Splitting line items per tier lets each carry its own offer and its own SAC-derived bid.
:::

# Why ZIP is too coarse and the file goes stale

ZIP-level targeting is the default lever clients reach for, but a single ZIP can be half fiber-passed and half not, so a ZIP-only buy leaks heavily against a patchwork footprint. ZIP+4 or address-level household-addressable targeting is what actually contains delivery to serviceable homes. The granularity you choose is the difference between a tight in-footprint working-media number and a buy that quietly bleeds a third of its budget into homes the carrier cannot serve.

Footprint files also decay. Build-out advances monthly, so a quarter-old serviceable-address list under-serves newly passed homes and over-serves coverage the carrier no longer sells, and movers plus new construction create addresses that are absent from the file entirely. Pair the footprint layer with mover and new-mover signals so freshly serviceable homes are not invisible, and refresh the file on a cadence that matches the build-out, not the campaign.

:::predict
prompt: A footprint file has 2,000,000 serviceable households. After onboarding it matches at a 60% match rate, and 80% of the matched households are reachable (targetable) in the bidstream. How many households can you actually address?
answer: 960000
unit: households
hint: Multiply serviceable households by the match rate, then by the targetable share.
explain: Start with 2,000,000 serviceable households. Onboarding keeps 2,000,000 x 0.60 = 1,200,000 matched. Of those, only 80% are reachable, so 1,200,000 x 0.80 = 960,000 addressable households. The two haircuts (match rate and targetability) compound, so the addressable pool is roughly half the raw serviceable count before a single dollar is spent.
:::

:::callout warning
Broadband and ISP marketers on Reddit complain that huge shares of programmatic budget hit households the carrier cannot serve, so clicks and even "conversions" arrive from addresses that fail the serviceability check at the order page. The same threads gripe that ZIP-level geo is the lever clients ask for because it is easy, yet it leaks badly against a patchwork fiber footprint, while getting an address-level file approved and onboarded is slow and political. If you accept a ZIP-only brief without pushing for ZIP+4 or address-level data, you have agreed in advance to the leakage.
:::

# Working media as the daily health metric

The number you watch every day is the in-footprint working-media percentage: impressions delivered to serviceable households divided by total impressions. It is the early-warning gauge that tells you whether the footprint layer is actually holding before the economics show up in CPGA. The companion figure is wasted spend, which is the out-of-footprint share multiplied by media spend, and it is the most honest way to show a client what loose geo is costing them.

This sits inside a much leakier supply chain. Industry benchmarks find only about 36 cents of every dollar entering a DSP reaches the consumer as working media before any footprint filter is even applied, and the ANA pegged industry-wide wasted programmatic spend at roughly $26.8B in Q2 2025. Out-of-footprint delivery is a telecom-specific multiplier stacked on top of that baseline waste, so the footprint layer is not optional hygiene, it is the difference between a campaign that can clear its LTV:SAC gate and one that cannot.

:::figure discrepancyWaterfall
caption: Out-of-footprint delivery stacks on top of the supply-chain waste that already strips most of a DSP dollar before any footprint filter. Each layer (fees, invalid or non-viewable, then out-of-footprint) reduces the spend that can actually produce a serviceable gross add.
:::

:::predict
prompt: A $1,000,000 line item delivers 70% of its impressions to in-footprint, serviceable households. How many dollars are wasted on out-of-footprint households that cannot order service?
answer: 300000
unit: USD
hint: Wasted spend is the out-of-footprint share times media spend.
explain: In-footprint is 70%, so out-of-footprint is 1 - 0.70 = 0.30. Wasted spend is 0.30 x $1,000,000 = $300,000. That $300,000 reaches households the carrier physically cannot serve, so it can never become a gross add and should be reported as absolute waste, not soft inefficiency.
:::

:::widget donutChart
title: In-footprint working media vs out-of-footprint waste on a $1M line item
labels: In-Footprint Working Media, Out-of-Footprint Waste
data: 70, 30
unit: percent of impressions
:::

# The cost of leakage shows up in effective CPGA

Footprint leakage does not announce itself in the CPM, it hides in the cost per gross add. Only in-footprint impressions can produce a gross add, so when delivery leaks out of footprint the effective CPGA on the spend that can actually convert climbs even though the nominal media cost looks unchanged. Tightening in-footprint delivery is therefore one of the highest-leverage moves a telecom trader has, because it raises the share of budget that is even eligible to produce a subscriber.

The signature lens stays LTV:SAC (CLV divided by SAC). If allowable SAC is set against a healthy 3:1 gate, leakage that inflates effective SAC can quietly push a campaign under the gate while every vanity metric still looks fine. Watch the working-media percentage and the effective CPGA together, because the first is the cause and the second is the P&L consequence.

:::predict
prompt: A carrier's allowable SAC is $400 per gross add. A line item is priced so that, if every impression were in-footprint, it would hit $400 SAC, but only 70% of delivery is in-footprint and only in-footprint impressions can convert. What is the effective SAC per in-footprint gross add (round to the nearest dollar)?
answer: 571
unit: USD
hint: The full media cost is spread over only the 70% of delivery that can actually convert. Divide the target SAC by the in-footprint share.
explain: The whole budget is spent, but only 70% of it has any chance of producing a gross add, so the cost that converting households must carry is $400 / 0.70 = $571.43, about $571. The other 30% of spend is dead weight loaded onto the in-footprint adds, pushing effective SAC well above the $400 the unit economics assumed.
:::

:::predict
prompt: Continuing from above, the postpaid Net LTV is $1,600 and the effective SAC is $571 because of out-of-footprint leakage. What is the resulting LTV:SAC ratio (round to one decimal)?
answer: 2.8
unit: ratio (x:1)
hint: LTV:SAC is Net LTV divided by SAC.
explain: $1,600 / $571 = 2.80, an LTV:SAC of about 2.8:1. At a clean $400 SAC the ratio would be $1,600 / $400 = 4.0:1, comfortably above the 3:1 gate, but 30% footprint leakage drags the same campaign below 3:1. The leakage, not the LTV or the media price, is what breaks the gate.
:::

# Tighten in-footprint delivery and the working spend climbs

When you push in-footprint delivery up, the share of budget doing useful work rises faster than the headline number suggests, because the gain is measured against the smaller in-footprint base you started from. Moving from 70% to 90% in-footprint is a 20-point absolute lift, but the proportional rise in working spend is the 20 points measured over the original 70, which is meaningfully larger. That is why a footprint cleanup often returns more than the same effort spent shaving CPMs.

The operational caution is that "serviceable" is not always "orderable." FWA capacity is sector-constrained, so a household can be in coverage yet not sellable because the cell is full, and a household-addressable audience built only on probabilistic IDs can mis-target homes and silently corrupt the footprint layer. Validate that the in-footprint lift is real serviceable reach, not just a coverage polygon that ignores capacity.

:::predict
prompt: In-footprint delivery improves from 70% to 90% on a fixed line item where only in-footprint impressions do useful work. By what percent does the effective working share of spend rise?
answer: 28.57
unit: percent
hint: Take the change in in-footprint share divided by the original in-footprint share.
explain: The lift is (0.90 - 0.70) / 0.70 = 0.20 / 0.70 = 0.2857, about 28.57%. Even though it is only a 20-percentage-point absolute move, the working share of spend rises nearly 29% relative to where it started, which is why closing footprint leakage is high-leverage compared with marginal CPM tuning.
:::

:::widget barChart
title: Footprint leakage vs supply-chain waste, share of spend reaching its target
labels: Working Media to Consumer (any vertical), In-Footprint Delivery (this line item), After Footprint Cleanup
data: 36, 70, 90
unit: percent
:::

:::sources
- Yahoo Inc / Consult.tv, Household-addressable advertising and durable-ID targeting | https://www.consult.tv/household-addressable-advertising
- Front Porch, Programmatic Advertising for Service Providers | https://www.frontporch.com/advertising/
- ANA, Q2 2025 Programmatic Transparency Benchmark Finds $26.8B in Wasted Programmatic Spend | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
- LiveRamp, What to Look for in a Data Clean Room Provider (match rates) | https://liveramp.com/blog/what-to-look-for-in-a-data-clean-room-provider-a-guide
- Umbrex, LTV to CAC ratio benchmarks for subscription businesses | https://umbrex.com/resources/ultimate-guide-to-unit-economics/what-is-a-good-ltv-to-cac-ratio/
- SuperMoney, Cost per gross add (CPGA) in wireless | https://www.supermoney.com/encyclopedia/cost-per-gross-addition
:::
