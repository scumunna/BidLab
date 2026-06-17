---
track: vertical-cpg
title: CPG Programmatic Certification
pass: 0.7
draw: 12
---
:::q Mandate Translation
question: An Amazon DSP line reports a 4.2x platform ROAS, but the brand's MMM puts the true incremental ROAS at 1.6x against a 1.0 hurdle. Leadership wants you to scale the line. What is the correct execution move?
- Raise the bid and scale the line, since 4.2x is well above the 1.0 hurdle
- Cap the bid on the line and shift the freed budget to under-saturated prospecting lines
- Hold the bid flat and wait for the next quarterly MMM refresh to confirm
- Raise the frequency cap so the line spends faster while ROAS is still high
answer: 1
explain: A 4.2x platform number that an incremental read cuts to 1.6x is over-crediting demand the brand already had and is likely saturated, so you cap the bid and reallocate to lines whose marginal return still clears the hurdle.
:::

:::q Mandate Translation
question: A line shows a $4.20 platform ROAS, but the lift test says the next $100,000 of spend on it produced only $90,000 of incremental revenue. What marginal ROI should drive your decision, and what do you do?
- mROI is 4.2, so scale the line
- mROI is 0.9, so cap or pause the line
- mROI is 1.9, so hold the line flat
- mROI is 0.9, so raise the bid to capture more volume
answer: 1
explain: mROI is $90,000 / $100,000 = 0.9, below the 1.0 hurdle, so the next dollar destroys incremental value and the line should be capped or paused. The $4.20 platform ROAS is the average over past spend and is irrelevant to the next dollar.
:::

:::q Mandate Translation
question: Line A has a marginal ROI of 0.80 and Line B has a marginal ROI of 1.40, both against a 1.0 hurdle. You move $50,000 of budget from A to B. What is the net change in incremental revenue?
- A gain of $70,000
- A gain of $40,000
- A gain of $30,000
- No change, because the move is budget-neutral
answer: 2
explain: Revenue lost on A is 0.80 x $50,000 = $40,000 and revenue gained on B is 1.40 x $50,000 = $70,000, a net gain of $30,000. You keep shifting toward the higher-mROI line until the two marginal returns converge.
:::

:::q Mandate Translation
question: A brand does $40,000,000 in annual gross sales, trade spend runs 20 percent of gross sales, and working media is $2,000,000. Why does this ratio matter for how you defend a media line?
- Trade spend is $8,000,000, four times working media, so you must frame each line as defensible incremental contribution or finance reclaims the dollars for promotion
- Working media is larger than trade spend, so media lines are safe from budget cuts
- Trade and media draw from separate budgets, so the comparison is irrelevant
- Trade spend is $800,000, smaller than working media, so media wins by default
answer: 0
explain: Trade spend is 0.20 x $40,000,000 = $8,000,000, four times the $2,000,000 working media, so a media line that cannot prove incremental contribution is an easy dollar for finance to pull back into price promotion. You defend it in incremental terms.
:::

:::q Conversion Signals and Reconciliation
question: One real box of crackers is bought once at Walmart. Under last-touch-inside-its-own-walls logic, an Amazon offsite line, a Walmart line, and the brand's MMM each credit it. If you naively sum the three platform credits, how many more baskets do you report than were actually sold?
- 0
- 1
- 3
- 2
answer: 3
explain: Each system credits the same single basket once, so the naive sum is 1 plus 1 plus 1 equals 3 credited baskets against 1 real basket, an overcount of 2. This triple-count is the core reconciliation problem of cross-walled-garden attribution.
:::

:::q Conversion Signals and Reconciliation
question: An offsite line exposes 2,000,000 matched-addressable users at a 45 percent clean-room match rate, and 3 percent of matched users purchase in-window. How many matched conversions are credited?
- 60,000
- 27,000
- 900,000
- 13,500
answer: 1
explain: Matched conversions equal exposed audience times match rate times in-window purchase rate: 2,000,000 x 0.45 x 0.03 = 27,000. The match rate is doing as much work in that count as the media is, which is why you read it first.
:::

:::q Conversion Signals and Reconciliation
question: A campaign drove 10,000 onsite-attributed sales on a 14-day click window. Re-pulled on a 7-day window it shows 6,500, and a teammate calls the line a failure. What is the right read?
- The line lost 3,500 real sales and should be paused
- The same impressions drove the same real sales; the shorter lookback simply credits fewer, so you never compare a 14-day pull to a 7-day pull as equal
- The 7-day number is the true count and the 14-day number was inflated by fraud
- The drop proves the creative stopped converting mid-flight
answer: 1
explain: 10,000 minus 6,500 is 3,500 fewer credited sales, but no media changed and no real sales were lost. Only the lookback window changed, which is exactly why window length must be footnoted and never compared across different settings.
:::

:::q Conversion Signals and Reconciliation
question: A DSP reports 1,000,000 impressions; the verification vendor counts 920,000 as measured-and-valid after filtering invalid and non-viewable traffic. How should you treat this gap?
- As an 8 percent gap, a benign sampling-plus-IVT-filtering artifact you explain rather than chase to zero
- As an 8 percent gap proving the DSP is inflating delivery, so pause the line
- As a 92 percent discrepancy you must bill back to the SSP
- As an attribution-window problem to fix in the retailer console
answer: 0
explain: The gap is (1,000,000 minus 920,000) / 1,000,000 = 8 percent. Verification vendors measure a subset and strip invalid traffic (near 0.4 percent) and non-viewable inventory (near 14.8 percent), so the verified count sits below the served count by construction. It is benign filtering, not loss.
:::

:::q Bid Strategy and Pacing
question: A line carries a flat $90,000 budget over a 30-day flight, and an uncapped bid burns the whole budget by the end of day 18. How many days is the line dark, and what is the fix?
- 6 dark days; raise the bid to spend even faster
- 18 dark days; the pacing was correct
- 12 dark days; cap the daily budget or lower the bid up front so the committed dollars land across all 30 days
- 0 dark days; finishing early is the goal on a flat budget
answer: 2
explain: The budget exhausts at the end of day 18, so days 19 through 30 are dark, which is 12 days, 40 percent of the flight. On a committed CPG budget the goal is smooth delivery, so you cap the daily budget or lower the bid to spread spend evenly.
:::

:::q Bid Strategy and Pacing
question: A line front-loaded and has spent $30,000 of its $90,000 budget by the end of day 6 of a 30-day flight. To still land the full budget evenly across the days that remain, what daily spend should you cap to?
- $3,000 per day
- $5,000 per day
- $1,800 per day
- $2,500 per day
answer: 3
explain: Remaining budget is $90,000 minus $30,000 = $60,000, spread across 30 minus 6 = 24 days left, so $60,000 / 24 = $2,500 per day. Capping to $2,500 lands the committed budget on the last day, and it is below the original $3,000 rail precisely because the line front-loaded.
:::

:::q Bid Strategy and Pacing
question: A line reaches 500,000 households at a frequency cap of 4. To spend a flat budget faster, a teammate suggests raising the cap to 6. What happens, and is it the right move for a penetration-led brand?
- It adds 1,000,000 impressions that land on already-reached households, deepening frequency and hurting the penetration mandate, so broaden reach instead
- It adds 1,000,000 new unique households, expanding reach, so it is the right move
- It adds 3,000,000 impressions split evenly between new and existing households
- It has no effect on impressions because reach is fixed
answer: 0
explain: Impressions equal reach times the cap, so cap 6 yields 3,000,000 versus 2,000,000 at cap 4, an extra 1,000,000 impressions, all on households already reached. That deepens frequency and works against the penetration goal, so the trader broadens reach to absorb budget instead.
:::

:::q Bid Strategy and Pacing
question: An offsite line is under-pacing and the DSP surfaces an "Add missing creative sizes" recommendation. The line is trafficked only at 300x250 and 728x90. What is the correct first move?
- Lower the bid, since under-pacing means the bid is too high
- Add the missing standard sizes (160x600, 300x600, 320x50) so the line can fill more inventory
- Pause the line and rebuild it in a different DSP
- Raise the frequency cap to force more impressions
answer: 1
explain: Under-pacing flagged with a missing-sizes recommendation is a creative-coverage problem, not a bid problem. A line short on standard sizes cannot find enough inventory to spend, so you add the missing sizes first, then re-judge the pace. Lowering the bid wastes a cycle.
:::

:::q Deal Execution
question: A PMP deal has a $14.00 CPM floor and you set a $12.50 bid. The deal ID is active, the audience is attached, the creative is approved, and supply is available. Will the line win impressions on this deal as configured?
- Yes, because four of the five bid conditions are met
- Yes, but only at reduced delivery near the floor
- No, the bid is below the floor so the line is ineligible and wins zero until you raise the bid to at least $14.00
- No, but waiting will let the auction clear it at $12.50
answer: 2
explain: A deal bids only if every condition holds, including bid at or above floor. A $12.50 bid against a $14.00 floor delivers zero, not reduced volume, and no amount of waiting fixes it. The fix is to raise the bid to at least the floor.
:::

:::q Deal Execution
question: A Programmatic Guaranteed deal commits 4,000,000 impressions over a 20-day flight, but by the end of day 8 it has delivered only 1,360,000. With 12 days left, what daily delivery must you now hit to finish on commitment?
- 200,000 per day, the original plan
- 220,000 per day
- 170,000 per day
- 330,000 per day
answer: 1
explain: Remaining volume is 4,000,000 minus 1,360,000 = 2,640,000 across 12 days, so 2,640,000 / 12 = 220,000 per day, up from the planned 200,000. PG has no auction headroom to recover a shortfall late, so the gap is flagged immediately.
:::

:::q Deal Execution
question: A curated CTV PMP will not spend. You have confirmed the deal ID is active, the bid is well above the floor, and supply is available, but the line serves nothing. What is the most likely remaining cause?
- The market has no inventory at any price
- The deal should have been Programmatic Guaranteed
- The brand's MMM is reporting a low incremental ROAS
- The first-party audience is not attached or the creative is not approved
answer: 3
explain: With the ID, bid-above-floor, and supply confirmed, the unchecked conditions are the attached audience and the approved creative, and one of those is the usual culprit. Market scarcity is rare on premium deals, the deal type does not block bidding, and an MMM read has nothing to do with bid eligibility.
:::

:::q Deal Execution
question: You can wire the same Walmart 1P audience two ways. Path A: $40,000 media at a 15 percent DSP fee, 45 percent match, producing 90,000 incremental conversions. Path B: $40,000 media at a 20 percent DSP fee, 58 percent match, producing 120,000 incremental conversions, each worth $0.80. Using mROI as incremental revenue over total cost, which path wins?
- Path A, because its 15 percent fee makes total cost lower
- Path B, at an mROI of 2.0 versus Path A at about 1.57
- They tie, because both spend $40,000 of media
- Path A, because a lower fee always beats a higher match
answer: 1
explain: Path A cost is $40,000 x 1.15 = $46,000 with $72,000 revenue, so mROI is about 1.57. Path B cost is $40,000 x 1.20 = $48,000 with $96,000 revenue, so mROI is 2.0. The higher match unlocks more addressable conversions and wins despite the higher fee, which is why deal-path choice is a real cost lever.
:::

:::q Identity and Clean Rooms
question: A retailer 1P segment has 1,500,000 records and matches into the DSP at a 40 percent match rate. How many addressable users can you actually target, and why does the rest not matter to your bid?
- 600,000 addressable; the other 900,000 records do not resolve into the buy and are unreachable at any bid
- 1,500,000 addressable; match rate only affects measurement, not reach
- 900,000 addressable; the matched share is the unreachable portion
- 600,000 addressable; raising the bid would unlock the unmatched 900,000
answer: 0
explain: Addressable reach equals source audience times match rate: 1,500,000 x 0.40 = 600,000. The unmatched 900,000 never resolve into the platform, so no bid level can reach them. Pacing math should sit on the reachable pool, not the headline segment size.
:::

:::q Identity and Clean Rooms
question: A trader builds a high-performing lapsed-buyer segment inside Amazon Marketing Cloud and wants to run the exact same segment against Walmart Connect offsite supply. What is the correct read?
- Export the AMC segment and upload it straight into the Walmart buy
- Join AMC and Luminate directly to merge the two retailers' records
- The AMC segment is non-portable, so rebuild and re-match the equivalent in Walmart's room or use a neutral room
- Assume household IDs are identical across retailers, so no rework is needed
answer: 2
explain: Retailer first-party segments are walled-garden assets that do not port across retailers, and AMC and Luminate cannot be joined directly. The same household must be rebuilt and re-matched inside Walmart's environment or stitched through a neutral clean room or operator layer.
:::

:::q Identity and Clean Rooms
question: A brand has authenticated UID2 and RampID coverage on its CRM and is buying premium CTV supply that supports those IDs. Which identifier choice maximizes addressable reach?
- Declining third-party cookies, for the widest historical footprint
- The authenticated UID2 or RampID the supply supports
- MAIDs only, since CTV is a device environment
- IP address alone, to avoid any ID dependency
answer: 1
explain: Match rate climbs as you move up the ladder from declining cookies and MAIDs, to hashed email, to authenticated UID2 or RampID. On supply that supports them, the authenticated IDs resolve far higher, so they unlock the most addressable reach and the cleanest measurement.
:::

:::q Identity and Clean Rooms
question: An offsite line targeting a retailer 1P segment reports far fewer conversions than expected, and the match rate on the audience is 35 percent. What is the single most important thing to check before changing bids?
- Whether the frequency cap is set too high
- Whether all creative sizes are trafficked
- Whether the brand hurdle should be lowered to 0.5
- Whether the low match rate is suppressing both the reachable pool and the credited conversions
answer: 3
explain: At a 35 percent match, roughly two-thirds of the audience never resolves, which shrinks the addressable pool and strips credited conversions before media quality is even in question. A bid change cannot fix an identity ceiling, so you confirm the match rate and ID first.
:::

:::q Measurement and Flighting
question: In a geo holdout test, test geos generated $480,000 in sales versus $300,000 in matched holdout geos, on $112,500 of incremental media spend. What is the incremental ROAS?
- 4.27
- 2.67
- 1.6
- 1.07
answer: 2
explain: Incremental sales is $480,000 minus $300,000 = $180,000, and iROAS is $180,000 / $112,500 = 1.6. That sits below the roughly 2.31 geo-test median, so the trader treats the line as modestly incremental and does not scale it aggressively.
:::

:::q Measurement and Flighting
question: A ghost-ads test shows a 5.0 percent conversion rate in the exposed group and 3.5 percent in the PSA control group, applied to 400,000 exposed users. How many incremental conversions did the media drive?
- 20,000
- 6,000
- 14,000
- 2,000
answer: 1
explain: The rate lift is 5.0 percent minus 3.5 percent = 1.5 percent, applied to 400,000 exposed users: 0.015 x 400,000 = 6,000 incremental conversions. The raw exposed count of 20,000 would wrongly credit 14,000 conversions that would have happened anyway.
:::

:::q Measurement and Flighting
question: A ghost-ads test returns a surprisingly low incremental lift. Before reporting it, what is the first thing to check?
- Whether the control group was contaminated by seeing the ad elsewhere
- Whether the exposed group was large enough to spend the budget
- Whether the platform-reported ROAS was above the brand hurdle
- Whether the creative used all required display sizes
answer: 0
explain: If control users were exposed to the ad through another line or platform, the control rate rises toward the exposed rate and measured lift collapses toward zero. A contaminated control is the most common reason a real effect reads as flat, so validate control isolation before reporting.
:::

:::q Measurement and Flighting
question: A brand commits $1,200,000 for the year across 12 months, with the even monthly share set at index 100. The holiday month is indexed at 160. What does the trader plan to spend that month, and where does the extra come from?
- $192,000, funded by adding to the annual budget
- $100,000, because committed budgets are always paced flat
- $160,000, with the extra $60,000 pulled from below-average months so the full $1,200,000 still lands
- $60,000, because the index reduces the baseline share
answer: 2
explain: The even monthly share is $1,200,000 / 12 = $100,000 at index 100, so the holiday month at index 160 is $100,000 x 1.60 = $160,000. The extra $60,000 must be pulled from below-average months so total committed spend still lands on plan.
:::
