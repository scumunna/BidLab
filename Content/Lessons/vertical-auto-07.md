---
id: vertical-auto-07
track: vertical-auto
module: 7
title: Campaign Build and Pacing, Line Items, Co-op Windows, Frequency, and Fixing Drift
summary: Build DSP line items and Vehicle campaigns against your audiences and deals, pace deliberately to the co-op window and end-of-month push, cap frequency for the 90-day consideration window, and diagnose cost-per-VDP drift by lever instead of just raising the bid.
---
# From audience and supply to a line item that runs

This is the hands-on execution layer where the audience you built (Lesson 4) and the supply and deals you wired (Lesson 5) become an actual campaign that spends money. In a DSP you build line items, each one a unit that pairs an audience, a set of deal-IDs or open-auction supply, a creative, a bid, a budget, and a flight. In Google you build Performance Max or Vehicle campaigns fed by the Merchant Center inventory feed. Every downstream pacing and frequency decision rides on getting this mapping right: one line item per audience archetype keeps your reporting and your optimization clean, because a blended line item hides which lever is actually working.

The structure mirrors the audience to KPI matching you already know. A conquest line item is upper-funnel and gets judged on VDP views and consideration, a lease-end line item is bottom-funnel and gets judged on leads and VIN-matched sales, and an owner or loyalty line item runs alongside the service-retention work with suppression in place. The trader who builds these as separate, well-labeled line items can later move budget between them with surgical precision instead of fighting one tangled campaign.

:::figure lineItemTree
caption: A DSP line item is the unit that binds one audience to its supply, creative, bid, budget, and flight. Building one line item per audience archetype (conquest, lease-end, owner) keeps optimization and reporting clean instead of blending levers into one campaign.
:::

:::quiz
question: Why build a separate line item for the conquest audience instead of folding it into one campaign with lease-end and owner audiences?
- Conquest CPMs are always cheaper, so it deserves its own budget
- Conquest is upper-funnel and judged on VDP views, so a separate line item lets you optimize and defend it on the right KPI
- DSPs cap the number of audiences per line item at one
- It makes the monthly report shorter
answer: 1
hint: Think about which KPI each archetype is graded on and what blending does to that.
explain: Conquest is inherently upper-funnel and converts slowly, so it should be optimized and defended on VDP views and consideration, not last-click sales. A separate, labeled line item keeps that KPI visible and lets you move budget without disturbing the bottom-funnel lines. DSPs allow multiple audiences per line item, and the reason is not CPM or report length.
:::

# Pacing is calendar-driven, not even

Pacing in most verticals means spending evenly so you do not blow the budget early. Auto is different because the calendar imposes two hard forces. First, OEM co-op funds expire if they are not spent in-period and in-compliance, so under-pacing literally forfeits free OEM money that would have halved your net cost per sale. Second, dealers chase end-of-month volume bonuses, so the last week of the month carries disproportionate sales weight and you often want delivery to climb into the end-of-month push rather than taper.

The two formulas you live by are the required daily pace and the pacing index. Required daily pace tells you the run-rate that fully consumes the co-op window before it expires:

$$ \text{required daily pace} = \frac{\text{remaining co-op budget}}{\text{days left in window}} $$

The pacing index tells you, at a glance, whether you are ahead or behind plan, where $1.0$ means exactly on pace:

$$ \text{pacing index} = \frac{\text{actual spend to date}}{\text{expected spend to date}} $$

:::predict
prompt: You have $9,000 of co-op budget left and 6 days remaining in the co-op window. What daily pace fully spends it before it expires?
answer: 1500
tolerance: 1
unit: USD per day
hint: Divide the remaining co-op budget by the days left in the window.
explain: $9,000 / 6 days = $1,500 per day. Hit that run-rate and the co-op money is fully claimed before it expires; under-pace and you forfeit the unspent portion, which silently raises your net cost per sale.
:::

:::predict
prompt: You are halfway through a $20,000 monthly budget and have spent $8,000 so far. What is the pacing index?
answer: 0.8
tolerance: 0.01
unit: index
hint: Expected spend at the halfway mark is half the budget. Divide actual by expected.
explain: Halfway through $20,000, expected spend is $10,000. Pacing index = $8,000 / $10,000 = 0.8, meaning you are under-pacing at 80 percent of plan and risk leaving co-op money on the table unless you accelerate.
:::

# Why the net-cost-per-sale KPI rewards finishing the window

The reason pacing matters so much is that it feeds straight into the signature KPI, net cost per sale after co-op. Co-op typically reimburses 50 percent of standard digital spend (up to 75 percent for approved-vendor programs), so a fully claimed window can cut your effective cost per sale roughly in half. The formula is the one you carry through the whole vertical:

$$ \text{net cost per sale} = \frac{\text{media spend} - \text{co-op reimbursement}}{\text{VIN-matched units sold}} $$

The trap is that the reimbursement only lands if you both spend the window in-period and clear compliance (Lesson 9). Under-pacing forfeits the dollars; over-pacing past what compliance covers spends unreimbursed money. Either way the net cost per sale moves, which is why pacing is a KPI lever, not just a delivery chore.

:::predict
prompt: You spend $12,000 of media, co-op reimburses 50%, and VIN matchback credits 24 titled sales to the campaign. What is the net cost per sale?
answer: 250
tolerance: 1
unit: USD
hint: Net out the co-op reimbursement first, then divide by VIN-matched units.
explain: Co-op reimburses 50 percent of $12,000, so net media is $6,000. Net cost per sale = $6,000 / 24 = $250 per sale. Had the co-op claim been forfeited by under-pacing or denied on compliance, net media stays at $12,000 and the number doubles to $500.
:::

:::callout key
Pacing in auto is a money lever, not housekeeping. A forfeited co-op window or a missed in-period spend silently doubles your effective net cost per sale, because the reimbursement that would have halved it never arrives. Pace to fully and compliantly spend the window every period.
:::

# Frequency capping for a 90-day consideration window

Auto buyers are slow: over 50 percent take more than 90 days to decide, so frequency capping is tuned to a long horizon, not a one-week burst. You want enough presence to stay top-of-mind across months without hammering the same in-market shopper into annoyance. Effective frequency is the lever:

$$ \text{effective frequency} = \frac{\text{total impressions}}{\text{unique reached users}} $$

The capping has to be set across the consideration window, not per day, or an uncapped retargeting line can serve the same shopper dozens of times in a single week and exhaust the budget on a handful of fatigued users. Multi-channel coordination also compresses the decision: research puts time-to-decide at roughly 23 days with one channel, about 15 with two, and about 7 with three, so spreading capped frequency across display, CTV, and search shortens the funnel rather than over-serving one placement.

:::predict
prompt: A line item delivered 480,000 impressions to 80,000 unique reached users over the flight. What is the effective frequency?
answer: 6
tolerance: 0.1
unit: impressions per user
hint: Divide total impressions by unique reached users.
explain: 480,000 / 80,000 = 6 impressions per user across the flight. For a 90-day-plus consideration window that is reasonable presence; the danger is when the same number lands in one week, which signals an uncapped line burning frequency on a few fatigued shoppers.
:::

:::widget lineChart
title: Deliberate pacing into the end-of-month push (share of monthly spend by week)
labels: Wk1, Wk2, Wk3, Wk4-EOM
data: 20, 22, 25, 33
unit: %
:::

# Diagnosing cost-per-VDP drift by lever

The daily optimization loop is troubleshooting drift. When cost-per-VDP climbs above the ceilings you optimize against (about $2.50 used, about $3.50 new), the weak trader just raises the bid, which treats the symptom and spends more for the same problem. The strong trader diagnoses which specific lever broke. The usual suspects are audience fatigue (frequency too high, creative stale), one aged or mispriced VIN soaking spend, a bad placement or supply path, a disapproved inventory feed cutting eligible VLAs (Lesson 5), or a creative losing click-through rate.

Performance Max deserves special caution because automation, left unchecked, buys the cheapest and worst inventory: aged units, mispriced vehicles, and competitor-name terms. The fix is fencing it with exclusions and rigorous feed hygiene, not loosening the bid. Each cause has its own remedy, so the diagnostic skill (match the symptom to the lever) is exactly what separates a 0-to-100 hire from someone who only knows how to push the bid up.

:::quiz
question: Cost-per-VDP on a used-vehicle line has drifted from $2.40 to $3.60. Which response is the practitioner move?
- Raise the bid until VDP volume returns
- Diagnose the cause (fatigue, an aged or mispriced VIN soaking spend, a bad placement, or a disapproved feed) and fix that specific lever
- Pause the entire campaign and rebuild from scratch
- Switch all budget to open-auction supply
answer: 1
hint: Raising the bid treats the symptom and spends more for the same underlying problem.
explain: Drift almost always traces to a specific lever, often one aged or mispriced VIN soaking impressions, a fatigued audience, or a feed disapproval cutting eligible inventory. Diagnosing and fixing that lever restores efficiency without overspending. Raising the bid just pays more for the same broken state, and a full rebuild or a blanket supply switch is overkill that loses learning.
:::

:::callout warning
A recurring DealerRefresh complaint: traders watch cost-per-result drift up with no obvious cause while the dealer principal blames them, and a frequent hidden culprit is letting Performance Max run unchecked so automation quietly buys aged, mispriced inventory and competitor-name terms. Fence PMax with exclusions and keep the feed clean before you ever touch the bid, or you will be defending a spend rush you did not cause.
:::

# Re-pacing when the budget gets cut mid-flight

The vertical is in a tariff-driven contraction, and a real operational reality is the dealer principal cutting the budget mid-month. An even pacing plan breaks instantly, but the co-op spend floor does not move: you still have to fully consume the co-op window in-period or forfeit the reimbursement. So the trader re-paces against the new, smaller number while still clearing the co-op floor, and decides deliberately whether to front-load or back-load given how the end-of-month push and the co-op deadline line up.

The end-of-month push and the co-op window can also conflict: one says spend now to capture month-end volume bonuses, the other says save enough to fully claim the window. Resolving that tension with a deliberate front-load or back-load (rather than reverting to even spend) is the judgment the role is graded on.

:::predict
prompt: Your co-op floor for the period is $9,000. You have already spent $3,600 toward it, and 9 days remain in the window. What daily pace clears the rest of the co-op floor in time?
answer: 600
tolerance: 1
unit: USD per day
hint: Find the remaining co-op spend still required, then divide by the days left.
explain: Remaining co-op spend = $9,000 - $3,600 = $5,400. Across 9 days that is $5,400 / 9 = $600 per day. Hit that and the reimbursement is preserved even after a mid-flight cut; miss it and the forfeited co-op silently raises your net cost per sale.
:::

:::sources
- Foundry CRO, Automotive Marketing Benchmarks 2026: CPC to Cost per Sale | https://foundrycro.com/blog/automotive-marketing-benchmarks-2026/
- Dealer Spike, Maximizing Your OEM Co-Op Funds: A Comprehensive Guide for Dealerships | https://www.dealerspike.com/blog/maximizing-your-oem-co-op-funds-a-comprehensive-guide-for-dealerships/
- Demand Local, How to Ensure OEM Compliance in Your Automotive Marketing Campaigns | https://www.demandlocal.com/blog/oem-compliance-automotive-marketing-campaigns/
- Cox Automotive, Cox Automotive 2026 Outlook | https://www.coxautoinc.com/insights/cox-automotive-2026-outlook/
- S&P Global Mobility, Polk Predictive Automotive Audiences | https://www.spglobal.com/mobility/en/products/polk-audiences.html
- DataFeedWatch, 6 Common Vehicle Ads Errors and How to Fix Them in Merchant Center | https://www.datafeedwatch.com/blog/google-vehicle-ads-errors
- DealerRefresh, Why are third parties running Google VLA ads on MY vehicles? Shut it down! | https://forum.dealerrefresh.com/threads/why-are-third-parties-running-google-vla-ads-on-my-vehicles-shut-it-down.9894/
:::
