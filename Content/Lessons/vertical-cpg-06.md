---
id: vertical-cpg-06
track: vertical-cpg
module: 6
title: "Deal Execution: PMP and Programmatic Guaranteed Against Retailer 1P Audiences"
summary: Wire, bid, and pace PMP and programmatic-guaranteed deals that put a retailer's first-party shopper audience against premium offsite supply, and diagnose the deal that will not deliver.
---
# The deal taxonomy, from least to most control

A deal is a contract between buyer and supply that sits on top of the auction, identified by a deal ID the trader ingests into the DSP. Four rungs run from least to most control: open auction (no deal), Private Marketplace (PMP, an invite-only auction with a deal ID, a floor price, and usually a curated audience), Preferred Deal (a fixed price, first look, but non-guaranteed, so the buyer is not obligated to take the impression), and Programmatic Guaranteed (PG, fixed price AND fixed volume, reserved like a direct insertion order but executed programmatically). In CPG the trader lives mostly in the middle two rungs, because the strategic move is putting a retailer's first-party shopper data against premium supply, and that is what a curated PMP does best.

The distinction that matters operationally is auction versus reservation. PMP and Preferred Deals still clear in a real-time auction, so winning is conditional on your bid clearing the floor and beating other demand, while PG reserves the inventory at a set price and obligates you to deliver the committed volume.

:::figure retailMediaFlow
caption: A CPG deal wires a retailer's first-party shopper audience (built in a clean room such as AMC or Walmart Luminate) into a deal ID, then activates it against premium offsite supply (CTV, premium open web) inside the DSP. The deal is the pipe that carries purchase data to inventory the open auction cannot guarantee.
:::

:::quiz
question: Which deal type reserves a fixed volume of impressions at a fixed price, obligating the buyer to deliver it rather than clearing in an auction?
- Open auction
- Private Marketplace (PMP)
- Preferred Deal
- Programmatic Guaranteed (PG)
answer: 3
hint: One rung commits both price and volume, the others still bid into an auction.
explain: Programmatic Guaranteed fixes both price and volume and reserves the inventory, so the buyer is on the hook to deliver. Open auction, PMP, and Preferred Deals all still clear conditionally in an auction, so delivery is never guaranteed.
:::

# Why CPG traders favor curated deals over the open auction

CPG offsite spend chases two things the open exchange cannot reliably provide: verified shopper audiences and premium, fraud-clean supply. A curated PMP solves both at once. It carries a retailer first-party segment (category buyers, lapsed buyers, a competitor's shoppers) onto premium inventory, and premium streaming supply inside a deal runs at near-fully-viewable rates. CTV viewability runs roughly 92% to 98% across tiers and approaches 100% on premium streaming PMPs, with completion rates for 15 to 30 second spots in the 94% to 96% range, which is a concrete quality reason to pay a deal floor rather than scrape the open auction for CTV.

The market has moved decisively this way. EMARKETER's H1 2025 programmatic forecast finds that more than 4 in 5 programmatic display ad dollars (over 80%) now transact through programmatic direct and private marketplaces, even after social networks are excluded, leaving the open exchange a shrinking minority of spend. Inside that closed majority, curated PMPs are the fastest-growing slice: Equativ's 2026 curation guide reports that over 66% of the open exchange programmatic market now flows through curated supply paths, which are the infrastructure retail media and CTV use to reach the open web in a brand-safe way. Walmart Connect's 2025-2026 expansion of its first-party data beyond its own DSP, with Yahoo DSP as a launch partner and Magnite supplying VIZIO CTV inventory, is exactly this pattern: retailer purchase data wired into deals on premium supply, and Walmart reported a median of 52% new-to-brand customers on offsite display in 2025.

:::widget barChart
title: The closed majority (programmatic direct plus PMP) dwarfs the open exchange (US nonsocial programmatic display, 2025, EMARKETER)
labels: Programmatic direct + PMP, Open exchange
data: 80, 20
unit: percent of nonsocial programmatic display spend
:::

:::predict
prompt: A trader runs a $200,000 offsite CTV flight. On the open auction, fraud and non-viewable filtering waste 18% of impressions before they count, so effective viewable delivery is 82%. A curated CTV PMP delivers at 96% viewable. How many more dollars of viewable delivery does the PMP produce on the same $200,000?
answer: 28000
unit: USD
hint: Multiply the budget by each viewable rate, then take the difference.
explain: Open auction viewable value is $200,000 times 0.82 = $164,000. PMP viewable value is $200,000 times 0.96 = $192,000. The difference is $192,000 minus $164,000 = $28,000 of additional viewable delivery, which is why CPG traders pay the deal floor for premium CTV.
:::

# The five conditions a deal must meet to bid

A deal bids only if every one of five conditions holds simultaneously: the deal ID is active in the DSP, the targeted first-party audience is attached to the line, spec-matched creative is approved, the bid is at or above the floor, and supply is actually available. Miss any one and the line silently does not spend, which is why a deal that will not deliver is almost always a wiring problem rather than a market problem. The trader checks all five before ever touching the bid, in that order, because the cheapest fixes (a mistyped ID, an unattached audience, an unapproved creative) are the most common.

The floor check is the one newcomers most often get wrong. Curated and CTV PMP floors sit well above open-auction CPMs, so a bid set at open-auction habit will clear nothing on a premium deal. Setting a $12.50 bid against a $14.00 floor does not under-deliver, it delivers zero, and no amount of waiting fixes it.

:::callout key
The deal-bids check is a logical AND, not a best effort. deal ID active AND audience attached AND creative approved AND bid at or above floor AND supply available. Any single false collapses delivery to zero, so triage the wiring in that order before you raise a bid or escalate to the SSP.
:::

:::predict
prompt: A PMP deal has a $14.00 CPM floor. The trader sets a $12.50 bid. The deal ID is active, the audience is attached, the creative is approved, and supply is available. Will the line win impressions on this deal as configured? Answer 1 for yes, 0 for no.
answer: 0
unit: boolean
hint: Run the AND. Four conditions hold, but check the bid against the floor.
explain: Every condition holds except the bid clearing the floor. A $12.50 bid is below the $14.00 floor, so the line is ineligible and wins zero impressions. The fix is to raise the bid to at least $14.00, not to wait or re-traffic the creative. The answer is 0.
:::

:::quiz
question: A curated CTV PMP "will not spend." The trader has confirmed the deal ID is active, the bid is well above the floor, and supply is available, but the line still serves nothing. What is the most likely remaining cause?
- The market has no inventory at any price
- The first-party audience is not attached or the creative is not approved
- The deal type should have been Programmatic Guaranteed
- The brand's MMM is reporting a low incremental ROAS
answer: 1
hint: Two of the five bid conditions have not been verified yet.
explain: With the ID, bid-above-floor, and supply confirmed, the unchecked conditions are the attached audience and the approved creative, and one of those is the usual culprit. Market scarcity is rare on premium deals, the deal type does not block bidding, and an MMM read is a measurement output that has nothing to do with whether a line is eligible to bid.
:::

# Pacing PG tighter than PMP because volume is committed

Pacing discipline scales with commitment. A PMP carries no delivery obligation, so under-delivery just means unspent budget the trader can reallocate. A PG deal commits a fixed impression volume at a fixed price, so under-delivery can trigger make-goods, penalties, or simply waste a reserved commitment the trader paid to hold. That is why PG lines are paced tighter than PMP lines: the trader computes an even daily delivery target up front and watches it daily, because there is no auction headroom to make up a shortfall at the end.

The even-delivery target is the committed volume divided by the flight days, and any sustained deviation below it is an early warning. On a PG line the trader treats a pacing gap as urgent, whereas on a PMP the same gap is a routine optimization signal handled on the normal 7 to 10 day cadence.

:::widget pacingController
title: PG delivery must track the committed daily line, with no end-of-flight catch-up
:::

:::predict
prompt: A Programmatic Guaranteed deal commits 4,000,000 impressions over a 20-day flight. What even daily delivery must the trader pace to meet the commitment exactly?
answer: 200000
unit: impressions/day
hint: Divide committed volume by flight days.
explain: 4,000,000 impressions divided by 20 days = 200,000 impressions per day. Pace below this and the PG commitment falls short, risking make-goods or wasted reservation, because PG has no auction headroom to recover a shortfall late in the flight.
:::

:::predict
prompt: That same PG line should have delivered 200,000 per day, but by the end of day 8 it has delivered only 1,360,000 of the 4,000,000 committed. The flight has 12 days left. What daily delivery must the trader now hit to still finish on commitment?
answer: 220000
unit: impressions/day
hint: Subtract delivered from committed, then divide the remainder by the days remaining.
explain: Remaining volume is 4,000,000 minus 1,360,000 = 2,640,000 impressions. Days remaining are 12, so 2,640,000 divided by 12 = 220,000 per day, up from the planned 200,000. The trader must lift delivery 10% above plan to recover, which is why PG gaps are flagged immediately rather than on the normal optimization cadence.
:::

# Deal-path choice is a real cost lever

The same retailer first-party audience can often be wired through more than one DSP, and the path is not a coin flip. Walmart's multi-DSP opening means a Walmart shopper audience can be activated through the Walmart DSP, Yahoo DSP, or other roster partners, and each path carries its own fee stack and its own match behavior, so the same segment can resolve to a different addressable size and a different effective CPM depending on the pipe. Choosing the path by habit instead of by fee and match is a cost leak newcomers routinely overlook. The signature CPG KPI here is marginal ROI (mROI), the return on the next dollar, and a higher fee or a lower match on the wrong path quietly drags mROI down before a single creative renders.

The trader's job is to compare paths on landed cost: media plus DSP fee, adjusted for the match rate that determines how much of the audience is even reachable. A path with a slightly higher fee but a materially higher match can deliver more addressable reach per dollar, which is the comparison that actually moves mROI.

:::predict
prompt: A trader can wire the same Walmart 1P audience two ways. Path A: $40,000 media at a 15% DSP fee and a 45% audience match, producing 90,000 incremental conversions. Path B: $40,000 media at a 20% DSP fee and a 58% match, producing 120,000 incremental conversions, each worth $0.80 of incremental revenue. Using mROI as incremental revenue divided by total cost (media plus fee), which path has the higher mROI, and what is it?
answer: 2.0
unit: ratio (Path B)
hint: Total cost is media times (1 plus fee). Compute incremental revenue per path, then divide by total cost for each.
explain: Path A cost is $40,000 times 1.15 = $46,000, revenue is 90,000 times $0.80 = $72,000, so mROI is 72,000 / 46,000 = 1.565. Path B cost is $40,000 times 1.20 = $48,000, revenue is 120,000 times $0.80 = $96,000, so mROI is 96,000 / 48,000 = 2.0. Path B wins despite the higher fee because the higher match unlocks more addressable conversions. The answer is Path B at 2.0.
:::

:::callout warning
A recurring operator complaint, "deal won't deliver," is one of the most common programmatic tickets, and it is almost never market scarcity. Google Ad Manager's own private-auction troubleshooting guide traces non-delivery to the same short list: the bid is below the deal floor, the creative was rejected or is pending review (a distinct creative-status reason), the targeting does not match, or the bid simply lost to competing demand. One more CPG-specific trap to flag: the identical retailer 1P audience activated through two different DSPs prices and matches differently, so a deal that looks "expensive" or "low reach" on one path may just be the wrong path, not a bad deal. Check the wiring and the path before you escalate or raise the bid.
:::

# Where the deal line converges with identity, creative, and pacing

A wired deal line is where three disciplines meet in one place. One you have already built: pacing (Lesson 5) decides whether a PG commitment lands on flight. The other two this lesson only previews, and later modules develop in full: identity (Lesson 7) decides which retailer first-party audience is attached and how well it matches, and creative specs (Lesson 9) decide whether the asset is approved and eligible to serve. A failure in any of the three surfaces as the same symptom, a line that will not spend, which is why deal troubleshooting is really a checklist that walks across all three plus the floor and supply.

The trader's deliverable on a deal is therefore not just a launched line but a documented wiring state: deal ID confirmed, audience attached and match rate noted, creative approved at the right spec, bid set relative to the floor, and a pacing plan sized to the commitment. That documentation is what turns the next "deal won't deliver" ticket from an afternoon of guessing into a two-minute triage.

:::quiz
question: A trader is handed a PG deal that under-delivered and a PMP deal that under-delivered in the same flight. Which one should be treated as the more urgent problem, and why?
- The PMP, because invite-only auctions are harder to win
- The PG, because committed volume can trigger make-goods or waste a paid reservation
- Neither, under-delivery is always acceptable
- The PMP, because it has a floor price and the PG does not
answer: 1
hint: One deal type carries a delivery obligation the trader paid to hold.
explain: PG commits a fixed volume at a fixed price, so falling short can mean make-goods, penalties, or a wasted reservation, making it the urgent one. A PMP carries no delivery obligation, so its shortfall is just reallocatable budget. Both PMP and PG have floors, and under-delivery on a committed PG line is not acceptable.
:::

:::sources
- StackAdapt, Programmatic Guaranteed: How It Works and When to Use It | https://www.stackadapt.com/resources/blog/programmatic-guaranteed
- AdPushup, The Four Types of Programmatic Deals: When and Why to Use Each | https://www.adpushup.com/blog/explainer-the-four-types-of-programmatic-deals/
- Walmart Connect, Expanding access to Walmart first-party data across leading platforms | https://www.walmartconnect.com/resources/articles/2026/expanding-access-to-walmart-first-party-data-across-leading-platforms
- Digiday, As Walmart looks beyond The Trade Desk, brands look for their angle | https://digiday.com/media-buying/media-agencies-hope-to-drive-down-costs-as-walmart-opens-up-dsp-roster/
- EMARKETER, Programmatic Advertising Forecast and Ad Tech Trends H1 2025 | https://www.emarketer.com/content/programmatic-advertising-forecast-and-ad-tech-trends-h1-2025
- Equativ, A 2026 Guide to Programmatic Curation and Curated Marketplaces | https://www.equativ.com/blog/2026-programmatic-curation-guide
- Google, Understand Private Auction troubleshooting (Ad Manager Help) | https://support.google.com/admanager/answer/6083218
- EMARKETER, FAQ on data clean rooms: how retail media is driving adoption | https://www.emarketer.com/insights/definition-data-clean-rooms
:::
