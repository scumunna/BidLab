---
id: vertical-b2b-05
track: vertical-b2b
module: 5
title: Pacing the 84-Day Cycle and the Buying Committee
summary: Pace a B2B budget against a long, multi-touch, committee-driven sales cycle by setting flight length to the cycle, computing reach on stakeholders-per-account, and judging spend on a cycle-length window instead of a calendar month.
---
# Why monthly pacing breaks in B2B

In most verticals the trader paces to the calendar: spend the month's budget across the month, read ROAS at month end, adjust. In B2B that logic quietly fails, because the thing you are buying toward (a closed-won deal) does not arrive inside the spend window. The median B2B sale now takes about 84 days, up from roughly 73 five years ago, and enterprise deals above $100K ACV routinely run 90 to 180 days or stretch 12 to 18 months. Spend in month one shows pipeline impact a full cycle later, so a 30-day read on an 84-day motion is structurally guaranteed to look like a loss.

The second break is the buyer. You are not pacing toward one person; Gartner puts a typical B2B buying committee for a complex solution at 6 to 10 decision-makers, with larger and more complex deals running up to 16 stakeholders across as many as four functions (procurement, legal, finance, IT, ops) and 20+ involved in the broader journey at large enterprise. Pacing that buys one impression per company under-reaches the committee, and the deal stalls with approvers who never saw a single ad. Everything in this lesson follows from those two facts: time and reach-per-account.

:::figure pacingCurve
caption: A B2B flight paces to sustained always-on delivery across the full sales cycle, not a front-loaded calendar-month burst. The committee forms and the deal closes well after the spend window, so a 30-day read lands before the pipeline arrives.
:::

:::callout key
The two pacing levers in B2B are TIME (set flight length to the sales cycle, not the calendar) and REACH-PER-ACCOUNT (buy frequency across many stakeholders per account, not one impression per company). Naive monthly-ROAS pacing breaks both at once.
:::

# Pacing to the cycle, not the calendar

The first discipline is to set flight length off the sales cycle and let the daily budget fall out of it, rather than slicing an arbitrary monthly number. The mechanic is simple: daily pacing budget equals total flight budget divided by flight length in days, where the flight length is anchored to the median cycle. A flight that runs the full cycle delivers sustained reach while the committee forms, deliberates, and approves, instead of burning out before anyone has seen the second ad.

$$ \text{Daily pacing budget} = \frac{\text{total flight budget}}{\text{flight length (days)}} $$

This is also why front-loading is a trap. Spending fast feels like progress and hits an early impression goal, but it exhausts reach before the buying group has even formed, leaving the back half of the cycle dark exactly when legal and procurement (the number-one delay cause, about 35 to 40 percent of enterprise cycle time) are deciding. Always-on, evenly paced delivery keeps the account warm across the whole 84 days.

:::predict
prompt: A $126,000 flight runs across the full 84-day median B2B cycle, paced evenly. What is the daily pacing budget (to the nearest dollar)?
answer: 1500
tolerance: 1
unit: USD per day
hint: Divide the total flight budget by the flight length in days.
explain: $126,000 / 84 days = $1,500 per day. Pacing to the 84-day cycle (not a 30-day month) keeps delivery alive while the committee forms and the deal works through legal and procurement.
:::

:::quiz
question: An enterprise deal is structurally an 84-day-plus motion. Why does front-loading the flight budget hurt pacing?
- It violates the DSP's even-delivery setting and triggers a billing error
- It exhausts reach before the buying committee has formed, leaving the back half of the cycle dark
- It always raises the CPM because spending faster bids higher
- It has no effect, since total spend is the same either way
answer: 1
hint: Think about WHEN the committee is actually deliberating versus when the budget is gone.
explain: Front-loading burns reach early and goes dark in the back half of the cycle, exactly when legal and procurement are deciding. Long cycles need sustained always-on delivery so the account stays warm across the full 84 days, not a fast early burst.
:::

# Reach is computed on stakeholders, not accounts

The second discipline is to size reach on people-per-account, not accounts. With a buying committee of 6 to 10 decision-makers, the budget must buy enough frequency across multiple roles per account (multi-threading), so the unit of reach is stakeholders, not companies. The formula is required monthly reach equals target accounts times stakeholders per account times target frequency. Pace to accounts alone and you single-thread the deal: one champion sees the ads, the economic buyer and the veto-holders never do, and the opportunity stalls.

$$ \text{Required reach} = \text{target accounts} \times \text{stakeholders per account} \times \text{target frequency} $$

This is where the committee size from the buyer-and-mandate lesson turns into a concrete impression number. A larger committee means the same account list demands more impressions to cover, which is why naive account-level reach goals badly understate what delivery actually requires. The trader sizes the budget so that every approver, not just the champion, accumulates enough frequency to recognize the brand by the time the deal reaches their desk.

:::predict
prompt: You target 300 accounts, expect to reach 8 stakeholders in each, at a target frequency of 5 impressions per stakeholder. What is the required monthly impression reach?
answer: 12000
tolerance: 10
unit: impressions
hint: Multiply accounts by stakeholders per account, then by target frequency.
explain: 300 accounts x 8 stakeholders = 2,400 people; 2,400 x 5 frequency = 12,000 impressions. Sizing on stakeholders-per-account (not 300 accounts x 5 = 1,500) is what keeps the whole committee covered instead of single-threading the champion.
:::

:::predict
prompt: A more complex deal pushes the committee from a typical 8 to a larger 11 stakeholders per account, while accounts (300) and target frequency (5) stay fixed. How many MORE impressions per month does the larger committee require?
answer: 4500
tolerance: 10
unit: impressions
hint: Compute required reach at 11 stakeholders, then subtract the 12,000 needed at 8.
explain: At 11 stakeholders: 300 x 11 x 5 = 16,500 impressions. At a typical 8 it was 12,000. The difference is 16,500 - 12,000 = 4,500 more impressions, the cost of covering a bigger committee on the same account list as the deal grows past the typical 6-to-10 range.
:::

# Setting flight length and caps by ACV tier

Pacing is not one setting; it is tier-specific, and the tier comes straight from the deal economics. SMB deals at $5K to $20K ACV close in about 14 to 30 days, mid-market runs longer, and enterprise at $100K-plus runs multiple quarters. So the trader uses short flights and tighter daily caps for SMB and long, sustained, always-on flights for enterprise. Matching flight length to the tier's cycle is the difference between a budget that paces cleanly and one that either underpaces (set too long for a fast SMB motion) or starves the back half (set too short for a slow enterprise one).

The ACV tier also bounds how much you can afford to pace at all, because the allowable CAC sets the spend ceiling per account. At a target LTV:CAC of 3:1, an account whose LTV is three times a $60K ACV ($180K) supports an allowable CAC of $60K, while a $12K-ACV SMB account at the same ratio supports only $12K. The trader divides that allowable CAC across the flight to get a defensible per-account daily envelope, so pacing never quietly outruns the unit economics.

$$ \text{Allowable CAC} = \frac{\text{LTV}}{\text{target LTV:CAC ratio}} \qquad \text{LTV} = \text{ACV} \times \text{LTV multiple} $$

:::widget barChart
title: Median days to close by ACV tier (pacing must match the cycle)
labels: SMB ($5-20K), Mid-Market, Enterprise ($100K+), Major/Complex Enterprise
data: 22, 75, 135, 450
unit: days
:::

:::predict
prompt: A mid-market account has a $60,000 ACV and an LTV equal to 3x ACV. At a target LTV:CAC of 3:1, what is the allowable CAC you can spend to win it?
answer: 60000
tolerance: 100
unit: USD
hint: First compute LTV (ACV x multiple), then divide by the target LTV:CAC ratio.
explain: LTV = $60,000 x 3 = $180,000. Allowable CAC = $180,000 / 3 = $60,000. That ceiling, divided across the flight, sets the per-account daily pacing envelope so spend never outruns the unit economics.
:::

:::quiz
question: Why must flight length and daily caps be set per ACV tier rather than once for all campaigns?
- Because DSPs charge different fees by ACV tier
- Because SMB cycles run ~14-30 days while enterprise runs multiple quarters, so one flight length will either underpace or starve the back half
- Because enterprise accounts are exempt from frequency caps
- Because SMB deals have larger buying committees than enterprise
answer: 1
hint: The cycle length is what drives the flight length, and cycles differ wildly by tier.
explain: SMB closes in weeks and enterprise in quarters, so a single flight length cannot fit both. Set too long it underpaces fast SMB deals; set too short it goes dark in the back half of a slow enterprise cycle. Flight length and caps follow the tier's cycle.
:::

# The fiscal-year boundary and re-budgeting

Long cycles collide with the customer's fiscal calendar, and that is a pacing event the trader must plan for. When an enterprise deal's close date crosses the buyer's fiscal year-end, procurement and budget approval can restart, resetting the clock on negotiation that already eats 35 to 40 percent of enterprise cycle time. The budget at risk is the spend tied up in deals whose close date straddles that boundary, and the trader re-plans flight length around it rather than assuming linear progress to close.

$$ \text{Budget at risk} = \sum \text{spend in deals whose close date crosses fiscal year-end} $$

In practice this means the trader does not just set a flight and walk away. They watch which in-flight opportunities are pacing toward a fiscal cliff, extend always-on delivery across the reset rather than letting it lapse, and avoid declaring a stalled deal dead when it is actually waiting on a new budget cycle to open. Pacing is a living plan tied to the buyer's procurement reality, not a fixed calendar slice.

:::quiz
question: An enterprise deal's close date is about to cross the buyer's fiscal year-end. What is the correct pacing response?
- Pause the flight, since the deal is clearly stalled and not converting
- Front-load the remaining budget to force a close before year-end
- Re-plan flight length and keep always-on delivery across the procurement reset, treating the spend as budget-at-risk rather than dead
- Cut the account from the target list to protect the monthly ROAS number
answer: 2
hint: A fiscal-year crossing can restart procurement, so progress is not linear to close.
explain: Crossing fiscal year-end can restart procurement and budget approval, so the trader re-plans flight length and sustains always-on delivery across the reset, tracking the spend as budget-at-risk. Pausing or cutting the account abandons a deal that is waiting on a new budget cycle, not a lost one.
:::

:::callout warning
A recurring operator complaint: traders get pushed to "turn it off, it's not converting" at 30 days on deals that structurally take 3 to 6 months, and budgets get cut right before the committee reaches a decision. The fix is to set the evaluation window to at least the median cycle length, pace always-on across it, and re-plan (not kill) flights when an enterprise deal crosses a fiscal-year boundary and procurement restarts.
:::

# The cycle-adjusted evaluation window

Pacing and measurement are joined at the hip: how you pace determines the window on which you are allowed to judge the spend. The rule is that the evaluation window must be greater than or equal to the median sales cycle, so an 84-day motion is read on an 84-day-or-longer window, not at 30 days. Reading early does not just understate performance; it produces a confident wrong answer that gets a working campaign killed before the pipeline it created has had time to land.

$$ \text{Cycle-adjusted ROAS window} \ge \text{median sales cycle (e.g. } \ge 84 \text{ days)} $$

This is the bridge to the measurement discipline covered later, where a 30-day ROAS can read as a loss while the 180-day ROAS on the same spend is 3 to 8x. For now the pacing takeaway is the discipline itself: pace always-on to the cycle, size reach on the committee, set flight length and caps by ACV tier, plan for fiscal-year resets, and refuse to read the result before the cohort has matured.

:::predict
prompt: A flight spends evenly at $1,500 per day across the full 84-day cycle. What is the total flight budget that the cycle-length evaluation window will be judging?
answer: 126000
tolerance: 100
unit: USD
hint: Multiply the daily pace by the number of days in the cycle-length window.
explain: $1,500 per day x 84 days = $126,000. The evaluation window must cover at least the same 84 days the budget was paced across; judging this spend at 30 days reads only about $45,000 of delivery against zero matured pipeline and mislabels the campaign a failure.
:::

:::sources
- Optifai, B2B Sales Cycle Length Benchmarks (939 companies by deal size and segment) | https://optif.ai/learn/questions/sales-cycle-length-benchmark/
- Madison Logic (citing Gartner), The Rise of the B2B Buying Committee: 6 to 10 Decision-Makers per Complex Purchase | https://www.madisonlogic.com/blog/navigating-the-fall-of-the-individual-buyer-and-the-rise-of-the-buying-committee/
- The Digital Bloom, 2025 B2B SaaS Funnel and Pipeline Benchmarks | https://thedigitalbloom.com/learn/pipeline-performance-benchmarks-2025/
- Improvado, B2B Marketing Attribution in 2026 (long-cycle measurement, evaluation windows) | https://improvado.io/blog/b2b-marketing-attribution
- eMarketer, US B2B Digital Ad Spending 2026 | https://www.emarketer.com/content/b2b-digital-ad-spending
- DigitalApplied, LinkedIn Ads Benchmarks 2026 (CPC, CTR, CVR by industry) | https://www.digitalapplied.com/blog/linkedin-ads-benchmarks-2026-cpc-ctr-cvr-industry
:::
