---
id: vertical-auto-02
track: vertical-auto
module: 2
title: The Buyer and the Mandate: Net Cost Per Sale and What Good Looks Like
summary: Identify who actually buys auto media by tier, compute the signature net cost per sale KPI after co-op, and grade a campaign against the proxy ladder of VDP views, leads, and titled sales.
---
# Who is actually buying

The person who signs off on auto media is not one buyer, it changes by tier. At Tier 3 it is the dealer principal or general manager of a single rooftop, at Tier 2 it is a regional dealer-association marketing committee pooling co-op dollars across many stores, and at Tier 1 it is OEM brand and field teams buying national CTV, video, and display. Their goal is the same in every case and it is not impressions or even clicks: it is units sold and the gross profit on those units. Knowing which buyer you report to tells you which KPI you will be graded on and which co-op rules constrain your creative.

:::quiz
question: A trader is building inventory-level campaigns for a single rooftop and reports cost per sale to the GM. Which tier are they trading for?
- Tier 1 OEM national brand
- Tier 2 regional dealer-association co-op
- Tier 3 individual rooftop
- None, this is agency overhead
answer: 2
hint: One rooftop, inventory-level campaigns, a GM as the buyer.
explain: A single store with inventory-level campaigns and a GM as the decision maker is Tier 3, the individual rooftop. Tier 1 is OEM national and Tier 2 is the regional dealer-association co-op, both of which sit above the single store and answer to different buyers and KPIs.
:::

# The signature KPI: net cost per sale

The number the dealer principal actually cares about is net cost per sale: total media spend after co-op reimbursement, divided by the units a VIN matchback ties to your media. The formula is short and it is the whole job:

$$ \text{Net CPS} = \frac{\text{media spend} - \text{co-op reimbursement}}{\text{VIN-matched units sold}} $$

The "net of co-op" piece is load-bearing. OEM co-op typically reimburses 50% of standard digital, up to 75% for approved-vendor programs, so a compliant claim can roughly halve your effective cost per sale, while a denied claim silently leaves the gross number standing. That is why this KPI ties straight to the co-op compliance QA work later in the path.

:::figure costPerFundedCascade
caption: Net cost per sale is a cascade. Gross media spend is reduced by the co-op reimbursement to a net spend, and that net is divided across only the VIN-matched units, so each step down the cascade is where a denied claim or a missed match quietly inflates the final number.
:::

:::predict
prompt: Media spend is $10,000, co-op reimburses 50%, and VIN matchback shows 20 sales. What is the net cost per sale?
answer: 250
tolerance: 1
unit: USD
hint: Net the spend first, then divide by VIN-matched units.
explain: Co-op reimburses 50% of $10,000, so net spend is $10,000 - $5,000 = $5,000. Divide by 20 VIN-matched units, $5,000 / 20 = $250 net cost per sale.
:::

# Why a ladder of proxy KPIs exists

So few exposures become a titled sale, and a single rooftop sells only tens of units a month, so cost per sale alone is statistically noisy and slow to read. Traders are therefore graded on a ladder of proxies that ARE in their control and arrive in higher volume. The rungs are cost per VDP view (Vehicle Detail Page view), then cost per lead, then cost per sale, each one closer to the money and each one sparser.

The VDP cost ceiling is the daily-driver metric: under about $2.50 for used inventory and under about $3.50 for new. Cost per lead runs from roughly $38.86 on self-generated used search up to about $78 on new. Compute the rung you can actually move, then connect it upward to the sale.

:::predict
prompt: You spend $4,000 and generate 1,600 VDP views. What is the cost per VDP view, and is it inside the used ceiling?
answer: 2.5
tolerance: 0.05
unit: USD
hint: Cost per VDP view is spend divided by VDP views, then compare to about $2.50 used.
explain: $4,000 / 1,600 = $2.50 per VDP view, which sits right at the roughly $2.50 used ceiling, so it is acceptable for used but would be over the $3.50 line only if it climbed further.
:::

:::predict
prompt: A used-vehicle search campaign spends $3,886 and produces 100 self-generated leads. What is the cost per lead?
answer: 38.86
tolerance: 0.1
unit: USD
hint: Cost per lead is media spend divided by the count of form plus phone leads.
explain: $3,886 / 100 = $38.86 per lead, matching the roughly $38.86 self-generated used-search benchmark. New-vehicle leads run higher, up toward $78, because the audience and competition are more expensive.
:::

# What good looks like by channel

"Good" is defined against the channel mix, and the spread is enormous. Efficient owned-channel programmatic runs roughly $150 to $450 net cost per sale on Vehicle Listing Ads and about $380 to $765 on Google search. The expensive lead portals run an order of magnitude higher: AutoTrader near $8,000 and Cars.com near $12,000 per sale. The mandate follows directly from that gap: shift budget from costly portal supply to efficient owned programmatic, then prove the shift with VIN matchback.

:::widget barChart
title: Net cost per sale by channel (lower is better)
labels: VLA, Google Search, Meta, AutoTrader, Cars.com
data: 300, 572, 611, 8000, 12000
unit: USD
:::

:::quiz
question: Two channels deliver the same number of VIN-matched sales this month. Which one improves your blended net cost per sale more?
- AutoTrader at about $8,000 per sale
- Vehicle Listing Ads at about $300 per sale
- Cars.com at about $12,000 per sale
- They are equivalent because sales are equal
answer: 1
hint: Equal sales means the cheaper net cost per sale wins on the blend.
explain: With sales held equal, the channel with the lower net cost per sale pulls the blended average down. VLAs at about $300 are far cheaper per sale than the portals at $8,000 to $12,000, so moving budget toward VLAs is exactly the efficiency mandate.
:::

# Gross versus net, and the proxy ladder in one view

The same campaign tells two very different stories depending on whether you quote gross or net, so always state which one you mean. A compliant 50% co-op claim turns a $600 gross cost per sale into a $300 net, and that single distinction can change whether the dealer thinks the campaign worked. Read the proxy ladder from cheap-and-frequent (VDP cost) up to the money KPI (net cost per sale), and never report only the top rung in a noisy month.

:::widget barChart
title: The proxy ladder, cost per stage
labels: VDP View, Lead, Appointment, Net CPS
data: 3, 60, 200, 300
unit: USD
:::

:::predict
prompt: Gross cost per sale is $600 and a compliant claim earns 50% co-op reimbursement. What is the net cost per sale?
answer: 300
tolerance: 1
unit: USD
hint: A 50% reimbursement nets out half of the gross figure.
explain: Net CPS is gross times one minus the reimbursement rate when the claim is approved, so $600 times (1 - 0.50) = $300. If the claim were denied, the figure stays at the $600 gross, which is why compliance protects the headline number.
:::

:::predict
prompt: VLA delivers 30 sales at $300 net CPS and Google search delivers 20 sales at $600 net CPS. What is the blended net cost per sale across both?
answer: 420
tolerance: 1
unit: USD per sale
hint: Add the net spend on each channel, then divide by total sales.
explain: VLA net spend is 30 times $300 = $9,000 and search net spend is 20 times $600 = $12,000, so total net spend is $21,000 across 30 + 20 = 50 sales. $21,000 / 50 = $420 blended net cost per sale.
:::

# The edge cases that quietly break the number

Net cost per sale is only as honest as the data feeding it, and several traps make a good campaign look bad. The two that bite hardest in practice: a last-click-only mandate strips credit from view-through sales, which dominate auto because nobody clicks a display ad and buys a car the same session, and dirty CRM or DMS source logging credits your programmatic sale to "walk-in" so it vanishes from your report. An AutoTrader analysis of 875,000 sales found that 92% of vehicle sales were untraceable in dealership CRM systems, with only 8% tying back to a traditional lead such as a form or call, so a raw matchback count understates media by an order of magnitude. Defend the noisy monthly sale count with the VDP and lead proxies rather than overreacting to one bad month.

:::callout warning
A recurring complaint from operators on DealerRefresh: a great-looking cost per lead collapses once you net out the leads the BDC never actually worked, so they push to be graded on appointments set, not raw leads. The same hygiene gap shows up at the sale, where reps log a media-driven deal as "walk-in" and the trader's influenced sales disappear. Insist on appointment-level and VIN-matched reporting, because raw leads and rep-entered source fields will understate what your media really did.
:::

:::predict
prompt: Your CRM credits only 4 titled sales to your programmatic media this month, but the dealership data shows just 8% of media-influenced sales are correctly logged while the rest are recorded as "walk-in." Grossed up for that leakage, how many media-influenced sales did you really drive?
answer: 50
tolerance: 1
unit: sales
hint: If the 4 logged sales represent 8% of the true total, divide to recover the whole.
explain: The 4 logged sales are only 8% of the true count, so the real total is 4 / 0.08 = 50 media-influenced sales. The other 46 were stripped by last-click rules or buried under a "walk-in" source field, which is why you grade on VIN matchback and appointments instead of the raw CRM source line.
:::

:::quiz
question: Your BDC reports 120 leads this month, but only 18 became appointments set. An operator on DealerRefresh argues you should be graded on appointments, not raw leads. Why?
- Appointments arrive faster, so the sample is less noisy
- Raw leads include records the BDC never worked, so the count overstates real demand
- Appointments are cheaper to generate than leads
- Raw lead counts are not available in most CRMs
answer: 1
hint: Think about which number can be padded by leads that nobody actually followed up on.
explain: Raw lead totals include duplicates, junk, and records the BDC never worked, so they inflate apparent performance. Appointments set is a worked-down, higher-intent count that is much harder to game, which is why operators push to be graded on it rather than on the raw lead line.
:::

:::callout key
State gross or net explicitly every time you quote cost per sale. A compliant co-op claim can roughly halve the number, so quoting gross when the dealer hears net (or the reverse) materially changes whether the campaign reads as a win, with no change to the actual media.
:::

:::sources
- Foundry CRO, Automotive Marketing Benchmarks 2026: CPC to Cost per Sale | https://foundrycro.com/blog/automotive-marketing-benchmarks-2026/
- Demand Local, How to Ensure OEM Compliance in Your Automotive Marketing Campaigns | https://www.demandlocal.com/blog/oem-compliance-automotive-marketing-campaigns/
- Dealer Spike, Maximizing Your OEM Co-Op Funds: A Comprehensive Guide for Dealerships | https://www.dealerspike.com/blog/maximizing-your-oem-co-op-funds-a-comprehensive-guide-for-dealerships/
- Demand Local, How AI is Revolutionizing Attribution in Automotive Marketing | https://www.demandlocal.com/blog/ai-revolutionizing-attribution-automotive-marketing/
- Digital Dealer, 92% of Vehicle Sales are Untraceable, Smarter Attribution is Needed: Autotrader | https://digitaldealer.com/news/92-of-vehicle-sales-are-untraceable-smarter-attribution-is-needed-autotrader/165868/
- Strolid, Lead Response Time: Speed Matters in Automotive Lead Management | https://strolid.com/learn/lead-response-time-why-speed-matters-data-benchmarks
- DealershipGuy, Dealer ad spend nears $10 billion as digital marketing dominates (NADA 2025 data) | https://news.dealershipguy.com/p/dealer-ad-spend-nears-10-billion-as-digital-marketing-dominates
:::
