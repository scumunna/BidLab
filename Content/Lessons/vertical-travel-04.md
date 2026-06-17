---
id: vertical-travel-04
track: vertical-travel
module: 4
title: The Inventory and the Deal: PMPs, Programmatic Guaranteed, and Travel-Intent SSPs
summary: Source travel-intent supply across the four deal types, price a PMP and a programmatic-guaranteed commitment, and judge each deal by the cost per booking it actually delivers.
---
# The four ways you transact travel supply

Every impression you buy for a hotel group, airline, OTA, or cruise line arrives through one of four deal types, and the choice is the core desk skill of this lesson. Open auction is the cheap, blind floor where anyone can bid and you have no idea whether the impression sits in front of a traveler or a booking outcome. A private marketplace (PMP) is an invite-only deal ID at a negotiated floor, a preferred deal is a fixed CPM that is non-guaranteed (first look, no volume promise), and programmatic guaranteed (PG) reserves a set volume at a fixed price, which is how most Travel Media Network and premium travel-intent inventory is actually bought. The trade you keep making is closed-loop and booking-measurable versus cheap and blind.

:::callout key
The deal-type decision in Travel is not about CPM, it is about whether you can see the booking. Open auction is cheap but invisible to your Cost per booking. Travel-intent PMP and PG cost more per thousand impressions but let you measure the one number you are judged on.
:::

:::quiz
question: A hotel-group desk needs to prove confirmed bookings on every dollar it spends. Which of the four travel deal types leaves it blind to the booking outcome it is judged on?
- Open auction
- A travel-intent PMP
- A preferred deal on travel-intent supply
- Programmatic guaranteed on a Travel Media Network
answer: 0
hint: Which one is the cheap, anonymous floor where anyone can bid?
explain: Open auction is the blind floor: anyone can bid and you cannot tell whether the impression sits in front of a traveler or a booking, so it is invisible to cost per booking. A PMP, a preferred deal, and PG all transact on negotiated, curated, travel-intent supply where the closed-loop booking signal can be measured.
:::

# The deal-type ladder and why CPMs climb

As you move from open auction up to PG, the CPM rises because you are buying scarcity, curation, and a volume guarantee. Open-exchange travel display commonly runs about $1 to $4, preferred and PMP deals on travel-intent audiences run roughly $5 to $15 or higher, and PG and Travel Media Network inventory sits at the top of that band. You pay the premium to reach a verified searcher or past booker and, on a TMN or closed-loop deal, to measure the booking deterministically rather than guess.

:::widget barChart
title: Typical travel deal-type CPM ladder
labels: Open auction, Preferred deal, PMP, PG / TMN
data: 3, 7, 11, 14
unit: USD CPM
:::

:::quiz
question: A travel advertiser wants reserved volume at a fixed price on a Travel Media Network so it can measure confirmed bookings deterministically. Which deal type fits?
- Open auction
- Preferred deal
- Programmatic guaranteed
- A private marketplace floor only
answer: 2
hint: Reserved volume plus a fixed price is the defining pair.
explain: Programmatic guaranteed reserves a fixed volume at a fixed CPM, which is how most TMN and premium travel-intent inventory transacts. Open auction is non-reserved and blind, a preferred deal is fixed-price but non-guaranteed (no volume promise), and a PMP is a negotiated floor, not a committed volume.
:::

# Pricing a programmatic-guaranteed commitment

PG is a contract: you commit to a number of impressions at a fixed CPM, so the spend is locked before a single ad serves. The commitment cost is the volume times the price per thousand. That is comforting on premium travel-intent supply you cannot otherwise win, but it is also the pacing trap of Travel covered in the next lesson, because if demand softens in the off-season you still owe the impressions.

$$ \text{PG commitment cost} = \text{Guaranteed impressions} \times \frac{\text{Fixed CPM}}{1000} $$

:::predict
prompt: A programmatic-guaranteed deal on a Travel Media Network commits 4,000,000 impressions at a $12 fixed CPM, and that inventory drives 300 net confirmed bookings. What is the cost per booking?
answer: 160
tolerance: 1
unit: USD per booking
hint: First find the locked commitment cost, then divide by bookings.
explain: Commitment cost is 4,000,000 times 12 divided by 1,000, which is $48,000. Cost per booking is 48,000 divided by 300, which is $160. The fixed CPM only matters once you convert it into the booking number you are judged on.
:::

# Reading what a deal actually delivered

After a deal runs you grade it on three numbers. The effective CPM (eCPM) is what you truly paid per thousand on the deal, which can differ from the negotiated floor once delivery and clearing prices settle. Win rate tells you how often your bids cleared, which on a PMP signals whether your floor and bid were competitive. Deal fill rate tells you how much of the available deal inventory you actually captured.

$$ \text{eCPM} = \frac{\text{Deal spend}}{\text{Deal impressions}} \times 1000 \qquad \text{Win rate} = \frac{\text{Impressions won}}{\text{Bids submitted}} $$

:::predict
prompt: A travel-intent PMP delivers 2,000,000 impressions for $24,000 of spend. What is the effective CPM?
answer: 12
tolerance: 0.2
unit: USD CPM
hint: Divide spend by impressions, then multiply by 1,000.
explain: 24,000 divided by 2,000,000 is 0.012, and times 1,000 that is a $12 effective CPM. This is the real per-thousand cost you reconcile against the floor you negotiated.
:::

:::predict
prompt: On a travel-intent PMP your DSP submits 600,000 bids and wins 150,000 impressions. What is the win rate?
answer: 25
tolerance: 0.5
unit: percent
hint: Impressions won divided by bids submitted.
explain: 150,000 divided by 600,000 is 0.25, a 25 percent win rate. A low win rate on a PMP usually means your bid sits under the deal floor or competing buyers on the same deal ID are clearing higher.
:::

# Travel-intent curation: where the high-value supply comes from

The supply worth paying a premium for is travel-intent curation, where a data provider packages verified searchers and past bookers into deal IDs you activate in your DSP. Sojern, relied on by more than 10,000 travel marketers annually, powers travel-intent curation and PMPs through its July 2025 PubMatic curation partnership, which activates Sojern travel-audience segments inside PubMatic Connect, and after RateGain's $250M acquisition of Sojern closed in November 2025 the company unified Adara and Sojern under one brand in March 2026, billed as the world's largest source of travel-intent data. The trader's job is to know that this curated deal ID is the bridge between cheap blind reach and booking-measurable demand.

:::figure supplyChain
caption: Travel-intent supply flows from a curation provider (Sojern, now folding in Adara) through an SSP curation partnership (PubMatic) into a deal ID, which the buyer activates in the DSP. The same plumbing carries open auction, PMP, preferred, and PG, but only the curated and closed-loop paths return a booking signal.
:::

:::quiz
question: Why does travel-intent curation justify a CPM several times higher than open exchange?
- The creative renders at a larger size
- It packages verified searcher and past-booker audiences into a measurable deal ID
- It guarantees the lowest possible win rate
- It removes the need for any attribution wiring
answer: 1
hint: Think about what you can see at the end of the deal, not the ad unit.
explain: Curation packages first-party travel-intent audiences (searchers, past bookers) into a deal ID, so you reach high-AOV near-buyers and can measure the booking. Ad size is irrelevant, a low win rate is bad not good, and you still need the booking-pixel and MMP wiring taught later in the path.
:::

# Choosing PMP versus PG by the booking, not the CPM

The decision rule is simple: pick the deal type by how scarce and how outcome-measurable the audience is. When supply is abundant and you mainly need cheap reach, open auction is fine even though it is blind. When the audience is scarce, high-intent, and you must prove bookings, the higher CPM of a PMP or PG pays for itself because fewer, better-qualified impressions convert at a lower Cost per booking. The CPM going up can still mean the CPB going down.

:::predict
prompt: A travel-intent PMP spends $24,000 and drives 200 net confirmed bookings, while an open-auction line spends the same $24,000 but drives only 150 net bookings. What is the PMP's cost per booking?
answer: 120
tolerance: 1
unit: USD per booking
hint: Cost per booking is spend divided by net bookings, for the PMP line.
explain: The PMP CPB is 24,000 divided by 200, which is $120. The open-auction line at the same spend is 24,000 divided by 150, which is $160, so the higher-CPM PMP is $40 per booking cheaper on the number that matters even though its per-thousand price is higher.
:::

:::callout warning
A travel-intent deal ID can be curated on stale intent, a user who already booked elsewhere, and operators on Reddit routinely complain these curated PMPs are opaque about how recent or real the intent signal is while the floors feel arbitrary. Desk ops also vent that PG commitments made in peak-season optimism become dead weight when bookings stall, forcing make-goods or wasted spend. Demand recency and suppression, not the deal label, decide whether the premium was worth paying.
:::

# The app-supply catch and deal fill

You will also buy in-app travel inventory and rewarded or interstitial app placements through these exact same deal mechanics, but their conversions route through a Mobile Measurement Partner, not the web booking pixel, so a deal that looks identical in the DSP must be reconciled differently before you judge its CPB. Deal fill rate, the share of available deal inventory you actually delivered, tells you whether a deal can even carry your budget, and a thin fill rate on a scarce travel-intent PMP is a common reason a plan underspends in a peak booking week.

$$ \text{Deal fill rate} = \frac{\text{Impressions delivered on deal}}{\text{Impressions available on deal}} $$

:::predict
prompt: A travel-intent PMP makes 2,500,000 impressions available and your line delivers 2,000,000 of them. What is the deal fill rate?
answer: 80
tolerance: 0.5
unit: percent
hint: Delivered impressions divided by available impressions.
explain: 2,000,000 divided by 2,500,000 is 0.80, an 80 percent fill rate. The 20 percent you did not capture is supply you planned on but could not deliver, which is how a scarce PMP quietly starves a peak-week budget.
:::

:::sources
- Sojern, Sojern Joins Forces with PubMatic to Expand Travel Audience Data Curation (more than 10,000 travel marketers rely on Sojern annually; Sojern segments activated in PubMatic Connect) | https://www.sojern.com/press-release/sojern-joins-forces-with-pubmatic-to-expand-travel-audience-data-curation
- ExchangeWire, Sojern Joins Forces with PubMatic to Expand Travel Audience Data Curation (multi-ID SSP curation combining first-party data, Sojern travel segments, and premium inventory) | https://www.exchangewire.com/blog/2025/07/09/sojern-joins-forces-with-pubmatic-to-expand-travel-audience-data-curation/
- Skift, RateGain to Buy Sojern in $250 Million Deal, Expanding Its Marketing Reach | https://skift.com/2025/10/02/rategain-to-buy-sojern-in-250-million-deal-expanding-its-marketing-reach/
- Hospitality Net, RateGain Consolidates MarTech Capabilities Under Sojern, Creating the World's Largest Source of Travel Intent Data | https://www.hospitalitynet.org/news/4131164/rategain-consolidates-martech-capabilities-under-sojern-creating-the-worlds-largest-source-of-travel-intent-data
- AppsFlyer, Travel and Local App Attribution and Marketing Analytics | https://www.appsflyer.com/solutions/travel-local/
:::
