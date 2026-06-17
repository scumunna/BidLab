---
id: vertical-telecom-05
track: vertical-telecom
module: 5
title: Deal Construction: Building PMPs, PG, and Curated Telecom Inventory
summary: Build and traffic open-auction, PMP, and Programmatic Guaranteed structures for a carrier so premium CTV, local OTT, and near-store DOOH deliver on-pace at a price the LTV:SAC gate can clear.
---
# Why telecom delivery lives in deals, not the open exchange

Most premium telecom inventory does not transact on the open auction. The CTV avails, local broadcast and OTT, news and sports environments, and the digital-out-of-home screens near a carrier's retail doors are sold through deals, because publishers reserve their best supply for buyers they can identify and price for. The market has shifted decisively: more than 4 in 5 nonsocial programmatic display dollars now move through programmatic direct and private marketplaces rather than open real-time bidding, so deal fluency is the day-job for a carrier trader, not an edge skill.

That shift is why the rest of this lesson treats deal construction as the spine of a carrier buy. You will attach the serviceability layer from Lesson 3 and the clean-room matched audiences from Lesson 4 onto deal-backed line items, then defend the reserved value against your own open-auction line items.

:::quiz
question: Roughly what share of nonsocial programmatic display dollars transacts via programmatic direct and private marketplaces (PMP) rather than open auction in 2025 to 2026?
- About 20 percent
- About 50 percent
- More than 80 percent
- Essentially none, open RTB still dominates
answer: 2
hint: The "open exchange is everything" mental model is out of date for premium supply.
explain: More than 4 in 5 (over 80 percent) of nonsocial programmatic display dollars now transact through programmatic direct and PMPs. Open RTB is the minority path, which is why deal construction, not open-auction bidding, is the carrier trader's core competency.
:::

:::widget donutChart
title: Where nonsocial programmatic display dollars transact (2025 to 2026)
labels: Programmatic Direct + PMP, Open Auction
data: 80, 20
unit: percent of dollars
:::

# The three structures: open auction, PMP, and Programmatic Guaranteed

A trader wires a carrier brief into three transaction structures, each with a different price and delivery contract. Open-auction line items give price discovery and broad scale but the least control over where the impression renders. A Private Marketplace (PMP) is an invite-only auction transacted through a Deal ID, where the publisher sets a floor price plus rules on buyers, creative, and frequency, and you bid into a curated package. Programmatic Guaranteed (PG) is reserved inventory at a fixed price and a fixed volume, negotiated one-to-one with a publisher, so it removes price risk but adds a delivery obligation.

The mechanical difference that matters most is risk direction. In a PMP you still compete in an auction, so you carry price risk and win-rate risk; in PG you have locked the price and the volume, so you carry delivery risk and the publisher can demand make-goods if you under-deliver. Choosing the structure is choosing which risk you would rather manage on a given line of the plan.

:::figure supplyChain
caption: The same carrier brief fans out into three structures. Open-auction line items chase scale and price discovery, a PMP Deal ID bids into a curated package above a publisher floor, and a PG deal reserves fixed volume at a fixed price with a delivery obligation.
:::

:::quiz
question: Which transaction structure reserves a fixed volume at a fixed price and therefore carries make-good (delivery) risk rather than auction price risk?
- Open auction
- Private Marketplace (PMP)
- Programmatic Guaranteed (PG)
- A standard insertion-order with no Deal ID
answer: 2
hint: One of these is negotiated one-to-one and removes price competition entirely.
explain: Programmatic Guaranteed reserves fixed volume at a fixed price via one-to-one negotiation, so there is no auction and no price risk, but you must deliver the contracted impressions or face make-goods. PMP keeps an invite-only auction (price and win-rate risk); open auction has neither a guarantee nor a reservation.
:::

# The Deal ID: mapping a deal to a line item and setting the bid

A PMP or PG deal reaches your DSP as a Deal ID, a unique string the publisher or SSP issues that the DSP uses to recognize and bid the curated package. The trafficking sequence is concrete: accept or negotiate the Deal ID, map it to a line item in the DSP, set the bid relative to the deal floor, then attach the serviceability inclusion layer and the matched-audience layer from Lessons 3 and 4 so the deal only spends against in-footprint, addressable households. On a PMP the lever you control is bid headroom, the distance between your bid and the publisher's floor, which buys you win rate without overpaying.

Headroom is simple arithmetic but it governs whether a deal wins at all. Too little headroom above a floor and a heavily targeted deal never clears the auction; too much and you erode the unit economics the LTV:SAC gate depends on.

:::predict
prompt: A PMP deal floor is a $14 CPM and you set your bid at a $20 CPM. What is your bid headroom above the floor, in CPM dollars?
answer: 6
tolerance: 0.01
unit: USD CPM
hint: Headroom is your bid price minus the deal floor price.
explain: Bid headroom = bid price - floor price = $20 - $14 = $6 CPM. That $6 of room above the floor is what gives the deal a realistic chance to win after the footprint and match layers thin the eligible supply.
:::

:::predict
prompt: On a single Deal ID you respond to 4,000,000 bid requests and win 1,000,000 impressions. What is your win rate on that deal, as a percent?
answer: 25
tolerance: 0.1
unit: percent
hint: Win rate is impressions won divided by bid requests you responded to.
explain: Win rate = impressions won / bid requests responded to = 1,000,000 / 4,000,000 = 0.25, or 25 percent. A low win rate on a deal often means the floor is high relative to your bid or the targeting layers are choking eligible supply, both fixable before flight end.
:::

# Pacing a guaranteed deal: the delivery obligation

Because PG locks volume, pacing is a contractual duty, not just a smoothing preference. You measure PG delivery pacing as delivered impressions divided by the impressions you should have served by now, which is the contracted volume times the elapsed share of the flight. A reading near 1.0 is on-pace; below 1.0 means you are behind and risk an under-delivery that triggers make-goods and sours the publisher relationship the carrier needs for next quarter's reserved supply.

The discipline is to validate this in the first 24 to 48 hours and then daily, not at flight end when nothing can be recovered. A guaranteed deal that quietly runs behind is one of the most common and most expensive trafficking failures on a carrier account.

:::predict
prompt: A PG deal is contracted for 10,000,000 impressions and is exactly 50 percent through its flight. On-pace delivery to date should be how many impressions?
answer: 5000000
tolerance: 1
unit: impressions
hint: On-pace delivery is contracted volume times the elapsed share of the flight.
explain: On-pace impressions = contracted volume x elapsed flight share = 10,000,000 x 0.50 = 5,000,000. Anything materially below this at the halfway mark signals an under-delivery trajectory you must correct now, not at the end.
:::

:::predict
prompt: That same PG deal is 50 percent through its flight (on-pace target 5,000,000) but has delivered only 4,000,000 impressions. What is its delivery pacing ratio?
answer: 0.8
tolerance: 0.01
unit: ratio
hint: Delivery pacing = delivered impressions divided by the on-pace target to date.
explain: Delivery pacing = delivered / on-pace target = 4,000,000 / 5,000,000 = 0.80. At 0.80 the deal is 20 percent behind schedule and on track to under-deliver, so you raise priority, widen eligible supply, or escalate to the publisher before make-goods become unavoidable.
:::

# Connecting the deal to allowable SAC and the LTV:SAC gate

A deal is only worth winning if its price clears the carrier's unit economics. The signature KPI is LTV:SAC, where SAC is the loaded subscriber acquisition cost (subscriber acquisition cost / gross adds) and the healthy benchmark is at least 3:1. You back into an allowable SAC from the target lifetime value and the required ratio, then translate that ceiling into the deal bid so a PMP or PG price never exceeds what a gross add can economically cost.

This is the link between deal construction and the mandate. A curated package can look premium and still be the wrong buy if its CPM implies a cost-per-gross-add above allowable SAC; conversely, a higher deal CPM can be correct when its in-footprint, suppressed, brand-safe supply converts high-ARPU postpaid adds that lift LTV.

:::predict
prompt: A carrier's target lifetime value per postpaid subscriber is $1,200 and the required LTV:SAC ratio is 4:1. What is the allowable SAC per gross add?
answer: 300
tolerance: 0.01
unit: USD
hint: Allowable SAC = target LTV divided by the required LTV:SAC ratio.
explain: Allowable SAC = target LTV / required ratio = $1,200 / 4 = $300. Any deal whose price implies a cost-per-gross-add above $300 fails the 4:1 gate, so this number is the ceiling every PMP floor and PG price gets checked against.
:::

:::callout key
A deal premium is only worth paying when the curated supply produces gross adds inside the allowable-SAC ceiling. Always price a Deal ID against the LTV:SAC gate, not against the open-auction CPM, because the relevant comparison is incremental high-ARPU gross adds, not the raw cost of an impression.
:::

# Blending the structures and reading the result

A real carrier flight runs all three structures at once, so you read the result as a blended CPM across PMP, PG, and open spend. Blended CPM is total spend across the structures divided by total impressions, times 1,000, and it tells you whether the deal mix is pulling the average price toward or away from the allowable ceiling. You also build the plan so each structure carries the audience and serviceability layers, otherwise a cheap open-auction line item can deliver out-of-footprint volume that drags the blend and the economics.

Reading the blend daily is how you catch a deal mix drifting expensive or a structure under-pulling its share of delivery. The number is only meaningful when every line item shares the same footprint and suppression layers, so apples compare to apples.

:::predict
prompt: Across a flight you spend $300,000 on a PMP, $150,000 on PG, and $90,000 on open auction, and together they deliver 30,000,000 impressions. What is the blended CPM?
answer: 18
tolerance: 0.05
unit: USD CPM
hint: Blended CPM = total spend across all structures divided by total impressions, times 1,000.
explain: Total spend = $300,000 + $150,000 + $90,000 = $540,000 over 30,000,000 impressions. Blended CPM = ($540,000 / 30,000,000) x 1,000 = $18. You then check that $18, given your impression-to-gross-add rate, implies a cost-per-gross-add inside the allowable-SAC ceiling.
:::

:::widget barChart
title: Telecom deal mix on a sample flight, spend by structure
labels: PMP, Programmatic Guaranteed, Open Auction
data: 300000, 150000, 90000
unit: USD spend
:::

# Trafficking failure modes you must check first

Deals fail quietly, and the failures are operational, not strategic. A freshly trafficked Deal ID can return zero bid requests because the publisher mapped it to the wrong seat or the wrong DSP, so you validate live delivery in the first 24 to 48 hours rather than discovering a dead deal at flight end. Targeting can also choke a deal: a PMP floor stacked under footprint, match, and frequency layers may never win, in which case you loosen one layer or renegotiate the floor. And deal prioritization in the DSP matters, because a misconfigured priority lets your own open-auction line items outbid your reserved PMP or PG and cannibalize the value you paid to lock.

These checks are the difference between a plan that delivers and one that looks fine in the UI while spending nothing where it should. The Universal Ads platform that Comcast launched on FreeWheel in Q1 2025, packaging premium video from publishers like NBCUniversal, Fox, Paramount, Roku, and Warner Bros. Discovery, is exactly the kind of deal-based supply where a mis-mapped Deal ID or a starved floor turns premium avails into dead weight.

:::callout warning
A recurring operator complaint: a freshly trafficked Deal ID silently returns zero bid requests, and the trader burns a full day before discovering the publisher mapped it to the wrong seat or the wrong DSP. A second, quieter trap is the "curated" PMP that turns out to be repackaged open-exchange supply at a markup, so the carrier pays a deal premium for inventory it could have bought cheaper in open RTB. Validate delivery in the first 24 to 48 hours and audit what a curated package actually contains before you trust the premium.
:::

:::quiz
question: A PMP deal you trafficked is winning almost nothing despite a reasonable bid. Which of these is the LEAST likely first thing to check?
- Whether the Deal ID is mapped to the correct DSP seat
- Whether the floor plus stacked footprint, match, and frequency layers are choking eligible supply
- Whether your own open-auction line items are outbidding the PMP due to misconfigured priority
- Whether the carrier's national brand-awareness TV budget increased this quarter
answer: 3
hint: Three of these are concrete trafficking causes inside the DSP; one is a brand-marketing fact with no bearing on deal win rate.
explain: Seat mapping, over-stacked targeting against the floor, and deal-vs-open prioritization are the real first-check trafficking causes of a non-winning PMP. The carrier's national brand TV budget is brand-marketing context with no mechanical effect on whether your Deal ID wins impressions.
:::

:::sources
- eMarketer, Programmatic ad spending set to reach nearly $180 billion by 2025 | https://www.emarketer.com/content/programmatic-ad-spending-set-reach-nearly-180-billion-by-2025
- Attekmi, Programmatic Guaranteed vs. PMP: Which Is Right for Your Ad Strategy | https://attekmi.com/blog/programmatic-guaranteed-vs-pmp-deals-which-is-right-for-your-ad-strategy
- Gourmet Ads, Programmatic Guaranteed vs Private Marketplace Deals | https://www.gourmetads.com/marketing/programmatic-guaranteed-vs-pmp/
- BidsCube, What Is a Deal ID in Programmatic Advertising | https://bidscube.com/blog/what-is-a-deal-id
- CNBC, Comcast to launch Universal Ads platform powered by FreeWheel | https://www.cnbc.com/2025/01/06/comcast-universal-ads-platform.html
- Umbrex, LTV to CAC Ratio Benchmarks by Industry | https://umbrex.com/resources/ltv-to-cac-ratio-benchmarks/
- ANA, Q2 2025 Programmatic Transparency Benchmark Finds $26.8B in Wasted Programmatic Spend | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
:::
