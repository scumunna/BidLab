---
id: vertical-qsr-05
track: vertical-qsr
module: 5
title: Deal Plumbing: PMP/PG and Curated CTV, Audio and DOOH Inventory, and Why Deals Do Not Bid
summary: You will stand up PMP and PG deals for curated QSR CTV, audio and DOOH, diagnose why a deal is not bidding, and tie clean curated supply back to CPIV.
---
# Why QSR cannot run on open exchange alone

Local-at-scale QSR needs premium meal-moment reach, and the inventory that delivers it (connected TV, premium digital audio, programmatic DOOH on the street and in transit) mostly does not sit on the open exchange at usable scale or quality. So the trader lives in deal plumbing: PMP deals (private marketplace, an auction that runs against a deal ID at or above a floor) and PG deals (programmatic guaranteed, a fixed price and a committed volume), plus curated packages an SSP or curator pre-assembles for the vertical. The job is two-sided: stand the deal up correctly in the DSP, then debug why it is not bidding when it goes quiet.

The mental model is that a deal ID is a permission slip plus a price, not inventory you own. The seller has to activate it, your DSP has to be pointed at the right ID and SSP, your creative has to be eligible, and your bid has to clear the floor. Break any one link and the deal serves zero, usually with no loud error.

:::figure supplyChain
caption: A QSR deal threads buyer to DSP to SSP to publisher. The deal ID rides the whole path, and a break at any hop (wrong ID, unactivated seller, below floor, ineligible creative) shows up as a dead deal downstream.
:::

:::quiz
question: What does a PMP deal ID actually represent to the buying DSP?
- Inventory the buyer now owns outright at a fixed price
- A permission plus a floor price for an auction the buyer still has to win
- A guaranteed volume the seller must deliver regardless of bid
- A creative-approval token with no pricing attached
answer: 1
hint: PMP is still an auction; PG is the one with a fixed price and committed volume.
explain: A PMP deal ID grants access to a private auction at or above a floor, so the buyer still has to bid and win each impression. The fixed price and guaranteed volume description fits PG, not PMP, and the deal ID is not a creative token.
:::

# PMP versus PG, and what each one promises

PMP and PG are different contracts and they fail differently. PMP is an invitation-only auction: you get a deal ID, you bid against a floor, and you win some and lose some, so PMP delivery is elastic and a low bid simply wins less. PG is a reservation: a fixed CPM and a committed impression volume, so the seller owes you delivery and you owe them spend, which means a starved PG deal is a breached commitment, not just soft pacing.

That contract difference drives the QSR setup. Premium curated CTV and DOOH for a tentpole LTO often go PG to lock prime meal-window inventory at a known cost, while broader always-on conquesting and audio frequently run PMP for flexibility. The trader sizes the PG commitment against the flight so the guaranteed volume actually fits the days and the budget.

:::predict
prompt: A PG CTV deal commits 2,000,000 impressions at a $34 fixed CPM. What is the total committed spend on that deal?
answer: 68000
tolerance: 1
unit: USD
hint: PG cost is fixed CPM times impressions in thousands.
explain: 2,000,000 impressions is 2,000 thousands, and 2,000 times $34 equals $68,000 of committed spend. Because PG is guaranteed, that commitment holds whether or not pacing is smooth, so it has to fit inside the flight.
:::

:::quiz
question: Which statement correctly contrasts PMP and PG for a QSR buy?
- PMP guarantees volume at a fixed price; PG is an elastic auction
- PG guarantees volume at a fixed price; PMP is an auction against a floor
- Both guarantee volume, so neither can under-deliver
- Neither involves a floor or a fixed price
answer: 1
hint: One word: which one is a reservation, and which one is still a competitive auction?
explain: PG is the reservation (fixed CPM, committed volume), and PMP is the auction at or above a floor where a low bid simply wins less. The first option reverses them, and the last two are wrong because PMP is an auction and PG is fixed-price.
:::

# Zero bid requests versus bid requests but zero wins

The single most useful diagnostic split in deal troubleshooting is whether the deal is receiving bid requests at all. Zero bid requests means the auction is not even reaching your DSP on that deal, which points at setup or activation: the deal ID or SSP is entered wrong, or the seller never turned the deal on. The PubMatic PMP troubleshooting playbook names those two causes (incorrect deal ID or SSP, or an unactivated seller) as the likely culprits when a PMP shows zero requests across time windows.

Bid requests arriving but zero wins is a different failure entirely: the plumbing works, the auction reaches you, but you are losing or being excluded. That points at the bid being below the deal floor, a creative-size mismatch leaving nothing eligible to submit, a paused ad group, or a daily spend cap choking delivery. Diagnosing the wrong half of this split wastes a day, so the trader reads the request count first.

:::predict
prompt: A PG deal shows 0 bid requests for 48 hours despite an active, uncapped line item with approved creative. What percentage of bid requests came from a correctly activated deal?
answer: 0
tolerance: 0
unit: %
hint: If the count of bid requests is zero, what share of them can be attributed to anything?
explain: Zero bid requests means zero of anything, so 0 percent came from a correctly activated deal. The zero-request signal itself points away from your line item (which is active and uncapped) and toward a setup or seller-activation problem on the deal.
:::

:::predict
prompt: A PMP deal received 200,000 bid requests and your DSP submitted bids on 50,000 of them. What is the bid responsiveness?
answer: 25
tolerance: 0.5
unit: %
hint: Bid responsiveness is bids submitted divided by bid requests received.
explain: 50,000 / 200,000 = 0.25, a 25 percent bid responsiveness. Requests are clearly arriving, so this is not a setup problem; the gap points at targeting, eligibility, or floor reasons your DSP declined to bid on the other 75 percent.
:::

# Reading the no-bid: floor gap and exclusions

When requests arrive but wins do not, the next number is the floor gap. If the deal floor is above your submitted bid, you literally cannot clear, and raising the bid (or fixing a misread currency or CPM-versus-CPI input) is the fix. The Trade Desk surfaces this in its Private Contract Troubleshoot view, and DV360 exposes parallel deal diagnostics, so the trader reads the platform's stated no-bid reason rather than guessing.

The other common no-win cause is eligibility: the trafficked creative does not match the deal's required format, so the DSP has nothing valid to bid with and silently no-bids. A deal for 1920x1080 CTV with only a 300x250 trafficked produces exactly this. The Trade Desk PG checklist (no daily spend caps at ad-group or campaign level, ad groups active, agreed ad sizes trafficked, creative meeting publisher specs uploaded 24 to 48 hours before launch) is the pre-launch pass that prevents most of these.

:::predict
prompt: A deal floor is $32.00 and your DSP is submitting a $27.50 bid. What is the floor gap (floor minus bid), and can you win?
answer: 4.50
tolerance: 0.01
unit: USD
hint: Floor gap is deal floor minus your submitted bid; a positive gap means you are under the floor.
explain: $32.00 minus $27.50 equals a $4.50 floor gap. The gap is positive, so the bid is under the floor and cannot win; you raise the bid above $32.00 (or correct whatever capped it there) to start clearing.
:::

:::callout key
The diagnostic order is fixed: first ask are there bid requests at all (zero means setup or seller activation), then if requests exist ask are you bidding (responsiveness), then ask are you clearing the floor and is the creative eligible. Skipping to the bid before confirming requests is how a day disappears chasing the wrong failure.
:::

# One deal per line item, and never mix in open exchange

Clean troubleshooting depends on clean structure. DV360 best practice is to target one deal per line item and to never put deals and open exchange in the same line item, because mixing them makes it impossible to tell whether spend came from the premium curated deal or cheap open inventory, which defeats the entire point of curation. One deal per line item also means a no-bid diagnosis maps to exactly one contract instead of a tangle.

This structure has a cost in the QSR fan-out: one deal per line item multiplied across dayparts and store clusters inflates the line-item count, so the trader leans on templated trees and bulk sheets (the same fan-out discipline from the trafficking lesson) to keep it manageable. The discipline pays off the first time a deal goes quiet and you can isolate it in one row.

:::quiz
question: Why does DV360 advise against putting a curated deal and open exchange in the same line item?
- It doubles the floor price on both supply paths
- You cannot tell whether spend came from the premium deal or cheap open inventory, which breaks curation and troubleshooting
- Open exchange is not allowed to run in a line item that has any deal
- It forces the deal into programmatic guaranteed pricing
answer: 1
hint: Think about what you lose visibility into when two supply sources share one line item.
explain: Mixing them makes spend attribution ambiguous, so you cannot confirm the premium curated deal actually delivered rather than cheap open inventory, which defeats curation and muddies any no-bid diagnosis. The other options misstate floors, pricing, and the rules.
:::

:::widget barChart
title: Illustrative share of "deal not bidding" causes
labels: Wrong deal ID or SSP, Seller not activated, Spend cap, Size mismatch, Below floor
data: 35, 25, 15, 15, 10
unit: %
:::

# Curated CTV, audio and DOOH, and what a dead deal costs

Curated CTV and DOOH are where the premium QSR meal-moment reach actually lives, so a dead deal is not a minor pacing miss, it is lost prime inventory you cannot buy back after the lunch rush. DOOH and audio deals also tend to need specific creative formats and longer approval lead times, which is exactly why the 24-to-48-hour creative upload window is non-negotiable: a late upload means the premium flight launches empty into its highest-value window. PG makes this sharper, because a starved PG deal also risks breaching the guaranteed volume.

This connects directly to the KPI the brand cares about. Curated supply is bought to drive incremental store visits, so a working deal is judged on its cost per incremental visit (CPIV), spend divided by the extra visits it drove over a control. A premium deal that bids cleanly but delivers an indefensible CPIV is a media problem, not a plumbing problem, and the trader has to separate the two.

:::predict
prompt: A curated CTV deal spends $84,000 and drives 8,400 incremental store visits. What is the CPIV on that deal?
answer: 10
tolerance: 0.1
unit: USD
hint: CPIV is media spend divided by incremental visits.
explain: $84,000 / 8,400 = $10.00 cost per incremental visit. That sits between Cuebiq's 2023 QSR Average CPIV of $8.84 and the Below-Average $28.65, so the deal is bidding and delivering acceptably, though there is room to push toward the High-Performing $5.28 end.
:::

:::callout warning
A perennial r/adops thread is "my deal isn't bidding," and the answer is almost always a wrong deal ID, an unactivated deal on the seller side, or a spend cap throttling it. r/programmatic traders add that PMPs often "never scale," spending a few dollars a day, and that curators and SSPs return vague no-bid diagnostics so they end up reverse-engineering the cause from the Troubleshoot tab. Industry data backs the pain: roughly 90 percent of structured-deal-ID PMP campaigns fail to scale, frequently spending under $10 a day, due to manual setup errors, mismatched targeting, and metadata inconsistencies.
:::

:::sources
- PubMatic, PMP Troubleshooting Playbook (zero bid requests: deal ID, SSP, activation causes) | https://help.pubmatic.com/
- AdImpact, Q1 2026 Fast Food Advertising Trends (QSR CTV growth and brand leaders) | https://adimpact.com/blogs/q1-2026-fast-food-advertising-trends
- Cuebiq, Footfall Attribution Benchmarks (CPIV, visit rate, uplift by vertical) | https://cuebiq.com/benchmarks/
- KORTX, Restaurant Marketing Strategy: The 2026 QSR Playbook (curated supply, daypart, store-radius) | https://kortx.io/news/restaurant-marketing-strategy-qsr/
- Eskimi, Dayparting and Dynamic Creative for QSR (meal-window inventory and frequency) | https://www.eskimi.com/blog/daypart-targeting
- Restaurant Dive, Drive-thru share of US fast-food sales and digital order growth | https://www.restaurantdive.com/news/drive-thru-sales-qsr/
:::
