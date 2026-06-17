---
id: vertical-cpg-05
track: vertical-cpg
module: 5
title: Bid Strategy and Pacing Against Flat and Seasonal Budgets
summary: Set per-line bids from the incremental hurdle, land a committed budget on plan without front-loading, and diagnose under-pacing as a creative-coverage problem rather than a bid problem.
---
# The job is to land the budget, not to spend it fast

In most other channels the trader fights for more budget. In CPG the budget is usually already committed: a flat monthly or quarterly number, often locked into a joint business plan (JBP) with the retailer. So the job inverts. You are not trying to win as many impressions as the auction will sell you, you are trying to land the full committed dollars on plan while keeping the next dollar incremental. Spend velocity is not the KPI here, smooth delivery against the flight is.

That reframing matters because the most damaging pacing failure in CPG is spending too fast, not too slow. An uncapped line on a flat budget exhausts early, wins the cheapest and most habitual impressions first, and then goes dark during the back half of the flight when the brand still needs to be in front of shoppers.

:::callout key
On a committed CPG budget the trader is graded on whether the money lands on plan with the next dollar above the incremental hurdle, not on how quickly the line spends. A line that finishes its budget in week two has failed even if its reported ROAS looks great.
:::

:::predict
prompt: A line carries a flat $90,000 budget over a 30-day flight, but an uncapped bid burns the whole budget by the end of day 18. For how many days of the flight is the line dark with no budget left to serve?
answer: 12
tolerance: 1
unit: days
hint: The flight is 30 days; subtract the day the budget runs out.
explain: The budget exhausts at the end of day 18, so the line serves nothing from day 19 through day 30, which is 30 - 18 = 12 dark days, 40 percent of the flight. Those late days are exactly when the brand still needs to be in front of shoppers, so even a great-looking ROAS on the early spend is a pacing failure. The fix is to cap the daily budget or lower the bid up front so the committed dollars land smoothly across all 30 days.
:::

# The bid ceiling comes from the incremental hurdle, not platform ROAS

Bidding in this vertical is downstream of the mandate. The brand sets an incremental return hurdle (commonly an incremental ROAS, or iROAS, around 2.0 on a prospecting line), and that hurdle, not the platform-reported ROAS, sets the bid ceiling for each line. You raise bids and budget on a line while its marginal return clears the hurdle, and you cap or pause when the next dollar falls below it.

The signature KPI is mROI, the marginal ROI, the return on the very next dollar of a specific line. Platform ROAS is a blended average over every dollar already spent, so it stays high even after the next dollar has gone non-incremental. Bidding off the blended number is how traders pour budget into a saturated line and destroy incremental value.

$$ \text{mROI} = \frac{\Delta \, \text{incremental revenue}}{\Delta \, \text{spend}} \qquad \text{raise while } \text{mROI} > \text{hurdle}, \ \text{cap when } \text{mROI} < \text{hurdle} $$

:::predict
prompt: The brand's incremental hurdle is an iROAS of 2.0. A line has $40,000 of freed budget available, and the lift read says the next $40,000 on it would generate $76,000 of incremental revenue. Compute the line's mROI on that next $40,000.
answer: 1.9
tolerance: 0.05
unit: ratio
hint: mROI is the incremental revenue from the next dollars divided by those dollars.
explain: mROI = 76,000 / 40,000 = 1.9. That is below the 2.0 hurdle, so the next dollar does not clear the bar and the line should not be funded. The trader caps this line and routes the freed budget to a line whose marginal return is still above 2.0, even though this line's blended ROAS may still read well above 2.0.
:::

:::quiz
question: A line reports a 4.2x platform ROAS but its mROI on the next dollar is 0.9 against a 1.0 incremental hurdle. What is the correct bid action?
- Raise the bid and scale the line, since 4.2x is well above hurdle
- Hold the bid flat and wait another week for more data
- Cap or lower the bid and move the freed budget to an under-saturated line
- Raise the frequency cap to spend the remaining budget on this line
answer: 2
hint: The bid input is the marginal return, not the blended average.
explain: The blended 4.2x averages every dollar already spent and hides that the next dollar returns only 0.9, below the 1.0 hurdle. Scaling pours budget into a saturated line. The trader caps or lowers the bid and reallocates to a line where the marginal return still clears the hurdle. Raising the frequency cap would make it worse by deepening hits on already-reached buyers.
:::

# Choosing the bid strategy: manual control versus automated optimization

Each line gets a bid strategy, and the choice turns on how much conversion signal the line has. Early, when a line has thin signal, a manual or fixed bid gives the trader direct control and predictable pacing. Once a line has accumulated enough conversion events, automated or optimized bidding can squeeze more efficiency, but only if you feed it a target that reflects the incremental goal rather than the platform's blended ROAS.

The catch with automation on a committed budget is that it optimizes for the auction, not for your flight, and it needs a stable base of conversion data to do that. Per Google Ads, an automated bid strategy performs better with a solid foundation of conversion data, and changing a setting on the strategy puts it back into a learning state with performance fluctuations until it recalibrates. So thrashing a flat-budget line with frequent bid or budget changes keeps resetting that learning rather than letting it stabilize, which is why erratic intervention works against the automation you turned on.

:::quiz
question: When is automated or optimized bidding the right call on a CPG line?
- Immediately at launch, before any conversions, to maximize early spend
- Only once the line has enough conversion signal, fed an incremental-goal target
- Never, because automated bidding always front-loads a flat budget
- Only on the last two days of the flight to burn down remaining budget
answer: 1
hint: Automation needs signal to optimize, and it needs the right target to optimize toward.
explain: Automated bidding needs accumulated conversion signal to optimize, and it must be pointed at an incremental-goal target, not blended ROAS. Turning it on at launch with no signal, or letting it chase the blended number, is how a flat budget gets front-loaded. It is a tool for a stabilized line, not a launch default.
:::

# Pacing a flat budget: the even-pacing line and the front-loading trap

For a flat flight the baseline is even pacing: divide the committed budget by the flight days and keep actual daily spend tracking that line. Linear pacing also happens to be what algorithmic bidding wants, since it supplies consistent delivery volume to optimize against. The trader watches a cumulative pacing curve daily and treats any large gap between cumulative-spend percent and elapsed-flight percent as the early-warning signal.

$$ \text{daily target} = \frac{\text{flight budget}}{\text{flight days}} \qquad \text{front-loading when } \frac{\text{cumulative spend}}{\text{budget}} \gg \frac{\text{days elapsed}}{\text{flight days}} $$

The chart below is the cumulative even-pacing line for a $90,000, 30-day flight at $3,000 per day. The trader's job is to keep actual cumulative spend riding this line, neither racing ahead (front-loading, which exhausts the budget and goes dark) nor lagging behind (under-pacing, which strands committed dollars).

:::widget lineChart
title: Cumulative even-pacing target, $90k over a 30-day flight ($3,000/day)
labels: Day 1, Day 6, Day 12, Day 18, Day 24, Day 30
data: 3000, 18000, 36000, 54000, 72000, 90000
unit: USD cumulative
:::

:::figure pacingCurve
caption: The cumulative even-pacing line is the rail the trader keeps actual spend on. Racing above it front-loads the budget and goes dark mid-flight, lagging below it strands committed dollars before the season's purchase window.
:::

:::predict
prompt: A line has a $90,000 budget over a 30-day flight and the trader wants even pacing. What is the target daily spend?
answer: 3000
tolerance: 1
unit: USD/day
hint: Divide the committed budget by the number of flight days.
explain: 90,000 / 30 = 3,000 per day. That is the rail the trader keeps cumulative spend on, so the full budget lands on the last day rather than running out early.
:::

# Correcting a front-loaded line: caps, dayparting, and the catch-up math

Once a line is ahead of pace, the levers are budget caps, lower bids, dayparting, and frequency caps, applied to bend cumulative spend back onto the rail without going dark. Amazon DSP, the primary execution platform for this vertical, supports native dayparting (its targeting controls let the trader schedule ad display times throughout the day), so the lever here is to use DSP's own time-of-day scheduling to pull spend toward lower-cost hours rather than reaching for outside tooling. The no-native-dayparting limitation people repeat is a Sponsored Ads constraint in the Advertising Console, not a DSP one, so do not assume your DSP line lacks the control.

The corrective math is just the even-pacing formula re-run on what remains. Take the unspent budget and divide by the days left in the flight to get the new daily target the trader caps to.

$$ \text{catch-up daily target} = \frac{\text{budget} - \text{spend to date}}{\text{flight days} - \text{days elapsed}} $$

:::predict
prompt: A line front-loaded and has spent $30,000 of its $90,000 budget by the end of day 6 of a 30-day flight (against an even-pacing target of just $18,000). To still land the full budget evenly across the remaining days, what daily spend should the trader cap to?
answer: 2500
tolerance: 1
unit: USD/day
hint: Divide the unspent budget by the number of days left in the flight.
explain: The line is ahead of pace: even pacing by day 6 is 6 x 3,000 = 18,000, but it spent 30,000. Remaining budget is 90,000 - 30,000 = 60,000, spread across 30 - 6 = 24 days left, so 60,000 / 24 = 2,500 per day. Capping to 2,500 lands the committed budget on the last day instead of going dark, and it is below the original 3,000 rail precisely because the line front-loaded.
:::

:::callout warning
A recurring operator complaint: auto-bid strategies on a flat budget front-load spend, win the cheap early auctions, then go dark mid-flight, and the trader gets blamed for spending too fast. The cited fix is exactly the levers above, manual budget caps and dayparting to smooth delivery, plus pointing automation at an incremental target rather than letting it race the blended number. Frequent reactive bid and budget changes also keep resetting the automation into a fresh learning state, so thrashing the line hurts twice.
:::

# Frequency, reach, and why under-pacing is usually a creative problem

Frequency caps are a pacing lever with a penetration consequence. Impressions equal reach times average frequency, so raising the cap to spend faster simply deepens hits on households you have already reached, which lowers incrementality and works against the penetration-led mandate. The right move to absorb budget is to broaden reach into new households, not to pile more impressions on existing ones.

$$ \text{impressions} \approx \text{reach} \times \text{frequency cap} $$

The other lesson newcomers learn the expensive way is that under-pacing is frequently not a bid problem at all. Amazon DSP explicitly flags under-pacing orders that are missing common creative sizes and recommends adding them, because a line that cannot serve the standard slots simply cannot find enough inventory to spend. The standard display sizes the trader must supply are 300x250, 728x90, 160x600, 300x600, and 320x50, plus video in 16:9 or 1:1 at 15 to 30 seconds. These are the workhorse IAB sizes that the bulk of display inventory is sold in, and 300x250 alone carries a large share of impressions, so a line missing two of them simply has fewer slots it can bid into, which is exactly why Amazon DSP surfaces an add-missing-sizes recommendation on under-pacing orders.

:::widget barChart
title: Impressions by frequency cap at a fixed 500,000-household reach
labels: Cap 2, Cap 4, Cap 6, Cap 8
data: 1000000, 2000000, 3000000, 4000000
unit: impressions
:::

:::predict
prompt: A line reaches 500,000 households at a frequency cap of 4. The trader raises the cap to 6 to spend faster. How many additional impressions does that create, and where do they land?
answer: 1000000
tolerance: 1
unit: impressions
hint: Impressions are reach times the cap; subtract the cap-4 impressions from the cap-6 impressions at the same reach.
explain: At cap 6, impressions are 500,000 x 6 = 3,000,000; at cap 4 they were 500,000 x 4 = 2,000,000. The difference is 1,000,000 additional impressions, and all of them land on households the line has already reached, deepening frequency rather than recruiting new buyers. That spends the budget but hurts the penetration mandate, so the trader broadens reach instead.
:::

The corollary is that when a line under-paces, the trader checks creative-size coverage before touching the bid. A line trafficked only at 300x250 and 728x90 simply cannot find enough inventory to spend, so lowering the bid or pausing wastes a cycle, and raising the frequency cap only deepens hits on the few slots it already serves. Add the missing standard sizes first, then re-judge the pace.

# Reading pacing reports without overreacting to noise

The discipline that separates a calm desk from a thrashing one is waiting for signal. New lines look erratic in the first day or two simply because delivery has not stabilized, and operator guidance is to let a line run roughly 7 to 10 days before judging it and re-bidding. Reacting to day-one pacing noise leads to overcorrection, where the trader yanks bids on what was never a real trend and destabilizes the line.

So the daily read is diagnostic, not always actionable. Persistent over-pacing past the stabilization window means cap the budget or lower the bid; persistent under-pacing usually means add creative sizes or, only after ruling that out, loosen a too-tight bid. The numbers feed forward into seasonal flighting (a later lesson), where the trader deliberately shapes the pacing curve to the JBP calendar instead of holding it flat.

:::quiz
question: On day 1 of a 30-day flight a new line is pacing at 140 percent of its daily target. What is the disciplined response?
- Immediately cut the bid hard to stop the overspend
- Pause the line until it self-corrects
- Note it, but wait for the 7 to 10 day stabilization window before re-bidding unless it threatens to exhaust the budget
- Raise the budget cap so it can keep spending at 140 percent
answer: 2
hint: One day of delivery is mostly noise, not a trend, unless the budget is genuinely at risk.
explain: New lines are erratic before they stabilize, and operator guidance is to wait roughly 7 to 10 days before re-bidding. Cutting hard on day-one noise overcorrects and destabilizes the line. The trader notes the reading and watches, intervening early only if the pace genuinely threatens to exhaust the committed budget before the flight ends.
:::

:::sources
- Amazon Ads, Optimize Amazon DSP campaign pacing with additional creative sizes | https://advertising.amazon.com/resources/whats-new/optimize-amazon-dsp-campaign-pacing-with-additional-creative-sizes
- PPC Land, Amazon DSP unveils recommendations to optimize campaign pacing with creative sizes | https://ppc.land/amazon-dsp-unveils-recommendations-to-optimize-campaign-pacing-with-creative-sizes/
- Improvado, Marketing Budget Pacing: A Complete Guide for 2026 | https://improvado.io/blog/budget-pacing
- The Trade Desk, Creative Specifications | https://www.thetradedesk.com/assets/global/documents/Creative_Specifications-en.pdf
- Amazon Ads, Amazon DSP Performance+: AI-driven advertising (targeting controls list Dayparting: schedule ad display times throughout the day) | https://advertising.amazon.com/en-gb/library/guides/dsp-performance-plus
- SellerMate, Amazon PPC Dayparting: A Complete Guide to Scheduling Your Ads (the no-native-dayparting constraint is scoped to Sponsored Ads in the Advertising Console, not Amazon DSP) | https://www.sellermate.ai/post/amazon-ppc-dayparting
- Google Ads Help, About bid strategy statuses (a changed bid-strategy setting returns it to Learning, with performance fluctuations until it recalibrates) | https://support.google.com/google-ads/answer/6263057
- EMARKETER, FAQ on incrementality: how to prove your ads actually work in 2026 | https://www.emarketer.com/content/faq-on-incrementality-how-prove-your-ads-actually-work-2026
:::
