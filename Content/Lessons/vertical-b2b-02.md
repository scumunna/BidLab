---
id: vertical-b2b-02
track: vertical-b2b
module: 2
title: The Buyer and the Mandate, LTV:CAC Is King
summary: Identify who actually signs off on B2B SaaS media, score the buy on LTV:CAC and CAC payback instead of CTR, and read the ACV tier that drives every bid, pacing, and creative decision downstream.
---
# Who actually buys, and what you are scored on

The economic buyer of B2B SaaS programmatic is a VP or Director of Demand Gen, Growth, or a CMO at a software company, and the brief they hand the trader is pipeline and efficient acquisition, not impressions. The mandate is scored in LTV:CAC and CAC payback, so a campaign with a gorgeous click-through rate that produces accounts which never reach payback is a failure by the only metric that matters. The first move of the role is to stop reporting CTR and CPM upward and start reporting the unit economics the buyer is actually graded on by their own leadership.

That reframing is the whole lesson. CTR, CPM, and even cost-per-lead are inputs the trader controls, but the output the business buys is a ratio of lifetime value to the cost of acquiring it, evaluated over a window long enough for the deal to close.

:::quiz
question: A VP of Demand Gen says "our CTR is up 40% but the board is asking why pipeline is flat." What is the trader actually being measured on?
- Click-through rate and cost per click
- Impression volume and viewable CPM
- LTV:CAC and CAC payback (pipeline efficiency)
- Creative engagement rate on LinkedIn
answer: 2
hint: The board does not buy clicks, it buys efficiently acquired revenue.
explain: B2B media is scored on the efficiency of acquired revenue, which is LTV:CAC and CAC payback, not on CTR or CPM. A rising CTR with flat pipeline means the clicks are not converting to qualified accounts, so the trader must optimize to account quality, not click volume.
:::

# The signature KPI: LTV:CAC

LTV:CAC compares the lifetime value of a customer to what it cost to acquire them, and it is the single number that tells you whether the acquisition engine is creating or destroying value. The formula is $\text{LTV:CAC} = \text{LTV} / \text{CAC}$, where $\text{CAC} = \text{total sales and marketing spend} / \text{new customers acquired}$. The 2025 to 2026 benchmark for B2B SaaS sits at a median of about 3.2:1, with a 3:1 minimum treated as the pass bar and a top quartile of 4:1 to 6:1.

A ratio below 3:1 says you are paying too much for what each customer is worth, and a ratio far above 6:1 can actually signal underinvestment, you are leaving growth on the table by not spending into demand. The trader's job is to keep the buy inside the healthy band, not to maximize the ratio at the expense of volume.

:::predict
prompt: Customer LTV is $48,000 and CAC is $12,000. What is the LTV:CAC ratio (to one decimal)?
answer: 4.0
tolerance: 0.05
unit: ratio (:1)
hint: Divide lifetime value by acquisition cost.
explain: 48,000 / 12,000 = 4.0, so LTV:CAC is 4.0:1. That clears the 3:1 minimum and lands in the top-quartile band, meaning each dollar of acquisition cost returns four dollars of lifetime value.
:::

:::callout key
LTV:CAC is the mandate in one number. A 3:1 ratio is the floor, 4:1 to 6:1 is top quartile, and a ratio pushed far above 6:1 usually means you are under-spending, not winning. The trader optimizes to the band, not to the maximum.
:::

# CAC payback: how fast the dollar comes back

LTV:CAC tells you if the economics work eventually, but CAC payback tells you how long your cash is tied up before a customer pays back their own acquisition cost, which is what finance actually feels. The formula is $\text{CAC payback (months)} = \text{CAC} / (\text{ARPA} \times \text{gross margin})$, where ARPA is the average monthly revenue per account. The 2025 to 2026 target is under 12 months, elite is 5 to 7 months, and anything beyond 18 months signals broken unit economics that no amount of media optimization will fix.

Payback matters to the trader because it sets how patient the budget can be. A product with a 6-month payback can fund aggressive always-on spend, while an 18-month payback forces tighter caps and a harder bar on account fit before a single impression is bought.

:::predict
prompt: CAC is $9,600, monthly ARPA is $1,000, and gross margin is 80%. What is CAC payback in months?
answer: 12
tolerance: 0.1
unit: months
hint: Divide CAC by the gross-margin-adjusted monthly revenue per account.
explain: Gross-margin-adjusted monthly revenue is 1,000 x 0.80 = 800. CAC payback is 9,600 / 800 = 12 months, exactly at the under-12-month target bar, so the unit economics just clear the line.
:::

:::widget barChart
title: LTV:CAC benchmark by ACV segment (2025-26)
labels: SMB ($5-20K ACV), Median SaaS, Enterprise ($100K+), Top-quartile target
data: 2.5, 3.2, 4.5, 6.0
unit: ratio (:1)
:::

# Segment is everything: the ACV tier sets the math

The same mandate produces wildly different campaigns depending on the account's annual contract value, so the trader must know the ACV tier before anything else. Enterprise SaaS at $100K-plus ACV runs about a 4.5:1 LTV:CAC with sales cycles of 120 to 210 days, while SMB at $5K to $20K ACV runs about 2.5:1 with 14 to 30 day cycles. That tier is the master input: it sets the bid ceiling math you will derive later, the pacing math against the cycle length, and which offer and creative you put in front of the account.

Get the tier wrong and every downstream decision is wrong with it. Bidding a $10K-ACV SMB account at an enterprise CPM burns premium inventory on a deal that cannot pay it back, and starving a $100K enterprise account on an SMB-sized budget under-reaches the very accounts that justify the whole program.

:::figure churnLtvCurve
caption: Lifetime value accrues over months of retained revenue, so a higher-ACV, lower-churn enterprise account justifies a far higher acquisition cost than a fast-churning SMB account even though both must clear the same 3:1 LTV:CAC bar.
:::

:::predict
prompt: An enterprise deal has an LTV of $90,000 and a CAC of $30,000. Does it clear the 3:1 minimum, and what is the exact ratio (to one decimal)?
answer: 3.0
tolerance: 0.05
unit: ratio (:1)
hint: Divide LTV by CAC and compare to the 3:1 floor.
explain: 90,000 / 30,000 = 3.0, so the deal lands exactly on the 3:1 minimum. It passes the floor but has no cushion, so any rise in CAC or churn would push it underwater, which is why enterprise programs aim for the ~4.5:1 segment benchmark, not the bare minimum.
:::

# The customer is a committee, not a person

The most expensive misconception a new hire brings is that the "customer" is one buyer. Gartner puts a typical B2B buying group at 6 to 10 decision makers, with the full range running from 5 up to 16 people across as many as four functions including procurement, legal, finance, IT, and operations, and 20-plus in large enterprise. The bigger the committee, the more the trader is buying reach across many roles per account rather than frequency against a single persona, which is why account-level reach, not contact-level clicks, is the planning unit.

This is not a soft people-problem footnote, it is media math. Gartner also finds that 74% of B2B buyer teams show unhealthy conflict during the decision, and that consensus groups are 2.5 times more likely to call the deal high quality, so the trader's reach plan has to put the message in front of enough of the committee to build that consensus rather than leaving approvers and vetoers un-touched.

:::quiz
question: Why does optimizing a B2B campaign to a single target persona (say, the VP of Engineering) usually under-perform?
- Single-persona targeting is cheaper, so budgets run out
- The buying decision is made by a committee of ~6-10+ across up to four functions, so one persona under-reaches the approvers
- LinkedIn does not allow single-persona targeting
- Single personas have lower match rates than broad audiences
answer: 1
hint: Think about how many people actually sign off on a six-figure software purchase.
explain: A modern B2B purchase is decided by a buying group of roughly 6 to 10 stakeholders, and as many as 16, across procurement, legal, finance, IT, and ops. Optimizing to one persona leaves the other approvers and potential vetoers un-engaged, so the deal stalls even when that one persona is fully reached.
:::

:::predict
prompt: You target 300 enterprise accounts and plan for 11 stakeholders per account (the high end of the typical 6-to-10 group, sized for these larger committees) at a target frequency of 4 impressions each. How many impressions of reach must the budget buy?
answer: 13200
tolerance: 10
unit: impressions
hint: Multiply accounts by stakeholders per account, then by frequency.
explain: 300 accounts x 11 stakeholders = 3,300 people to reach, and 3,300 x 4 impressions of frequency = 13,200 impressions. The 11 sits inside Gartner's 5-to-16 range, above the typical band because these are larger enterprise committees. Planning to accounts alone (300 x 4 = 1,200) would under-buy reach by more than tenfold and leave most of the committee un-touched.
:::

# Reading the engine: Magic Number and channel-true CAC

Two diagnostics keep the trader honest about whether the spend is actually working. The SaaS Magic Number, $\text{net new ARR} / \text{prior-quarter sales and marketing spend}$, measures how much new recurring revenue each dollar of go-to-market spend produced, where above about 0.75 signals efficient growth worth funding harder and below 0.5 signals the engine is stalling. The second is the discipline of reporting channel-level CAC rather than blended CAC, because blended numbers hide the truth of any single channel.

Blended CAC is the trap. Paid social CAC on LinkedIn can run around $982 per customer, roughly 4 times a referral CAC, so folding everything into one blended figure can make an expensive programmatic channel look fine or make a cheap one look bad. The trader who reports channel-true CAC can defend or kill a specific line, while the one who reports only blended numbers is flying blind, and a Magic Number above 0.75 is the signal that the blended engine is efficient enough to fund harder.

:::predict
prompt: One channel spent $491,000 in sales and marketing and acquired 500 new customers. What is that channel's CAC?
answer: 982
tolerance: 1
unit: USD per customer
hint: Divide channel spend by customers that channel acquired.
explain: 491,000 / 500 = $982 per customer. Reporting this channel-true CAC (about 4x a typical referral CAC) exposes that the paid social line is expensive, a fact a blended CAC would have hidden by averaging it against cheaper channels.
:::

# Where the mandate breaks: the operator traps

The mandate fails in predictable, human ways that the trader has to anticipate. The most common self-inflicted wound is inflating an early LTV assumption to justify a higher bid ceiling, because lifetime value is unstable in the first months and an optimistic LTV makes any CAC look affordable right up until the budget is gone. Close behind is the metrics mismatch: a trader pressured to show CTR and CPM wins while leadership only cares about LTV:CAC ends up optimizing the wrong thing and losing the account anyway.

The fix for all of these is to anchor on conservative, realized LTV, report channel-true unit economics on a cycle-length window, and treat the committee as the reach unit. Get those three right and the mandate becomes defensible even when a single month looks soft.

:::callout warning
A recurring operator complaint from the field: new hires do not realize the "customer" is a committee of 6 to 10-plus people and waste budget optimizing to a single persona, while leadership simultaneously demands CTR and CPM wins even though they only actually reward LTV:CAC. The result is a trader stuck reporting vanity metrics on a single-threaded buy that structurally cannot move the committee, a mismatch that gets working campaigns killed and the wrong campaigns praised.
:::

:::quiz
question: A trader uses a hopeful, un-realized LTV to set a high bid ceiling early in a campaign. What is the most likely outcome?
- The campaign safely outperforms because the ceiling is generous
- Match rates improve because bids are higher
- The buying committee shrinks to one persona
- The campaign overspends, because an inflated LTV makes an unaffordable CAC look acceptable
answer: 3
hint: A bid ceiling is only as honest as the LTV it is derived from.
explain: Inflating an unproven LTV inflates the allowable CAC, which inflates the bid ceiling, so the trader overpays for accounts that the realized LTV cannot support. Bid ceilings must be built on conservative, realized LTV, which is exactly why the ACV tier and disciplined unit economics from this lesson drive the downstream bid math.
:::

:::sources
- Optifai, B2B SaaS LTV:CAC and CAC payback benchmarks 2025-26 | https://optif.ai/learn/questions/sales-cycle-length-benchmark/
- eMarketer, US B2B Digital Ad Spending 2026 | https://www.emarketer.com/content/b2b-digital-ad-spending
- Gartner, B2B buying group size and buyer consensus research | https://www.gartner.com/en/sales/insights/b2b-buying-journey
- Gartner, Sales Survey Finds 74% of B2B Buyer Teams Demonstrate Unhealthy Conflict (May 2025) | https://www.gartner.com/en/newsroom/press-releases/2025-05-07-gartner-sales-survey-finds-74-percent-of-b2b-buyer-teams-demonstrate-unhealthy-conflict-during-the-decision-process
- DigitalApplied, LinkedIn Ads Benchmarks 2026: CPC, CTR, CVR by Industry | https://www.digitalapplied.com/blog/linkedin-ads-benchmarks-2026-cpc-ctr-cvr-industry
- TheDigitalBloom, 2025 B2B SaaS Funnel and Pipeline Benchmarks | https://thedigitalbloom.com/learn/pipeline-performance-benchmarks-2025/
- Improvado, B2B Marketing Attribution in 2026: Multi-Touch, MMM, Incrementality and Dark Funnel | https://improvado.io/blog/b2b-marketing-attribution
:::
