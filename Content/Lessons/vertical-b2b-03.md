---
id: vertical-b2b-03
track: vertical-b2b
module: 3
title: The Conversion and the Funnel, Connecting Ad Exposure to Closed-Won
summary: Map each programmatic line to a CRM pipeline stage, read the stage-to-stage decay to find the leak, and size the impressions you need to hit a closed-won target.
---
# The funnel is a decay chain, not a single conversion

In consumer programmatic a conversion is usually one event: a purchase, an install, a sign-up that fires a pixel and closes the loop. In B2B the conversion is a chain that decays across many stages and many weeks: impression to engaged account to MQL (marketing-qualified lead) to SQL (sales-qualified lead) to opportunity to closed-won. Your job on the buy side is not to write the whitepaper or define the MQL, it is to know which stage each campaign line is buying toward and what conversion rate to expect between stages, so the spend can be defended in pipeline terms instead of clicks. The number that matters at the end is a closed-won deal worth $15K to $250K+ ACV, and every stage above it is a multiplier you have to respect.

The reason this is a buy-side skill and not a content-marketing one: the audience and offer you put against a stage change the rate that comes out of it. A demo request converts to pipeline at roughly 3 to 5 times the rate of a whitepaper download, so two campaigns that report the same "conversion" count can deliver wildly different pipeline. Reading the chain, not the headline number, is the whole game.

:::figure funnel
caption: The B2B funnel is a multi-stage decay from impression down to closed-won. Each stage applies its own conversion rate, and the product of those rates is what turns a media buy into a defensible pipeline number.
:::

# The stage rates a trader is expected to know cold

Memorize the typical stage rates the way a B2C trader memorizes CTR and CVR, because every pipeline forecast and every "is this campaign working" argument runs on them. Current 2025 to 2026 B2B SaaS benchmarks: Visitor to Lead roughly 1.5 to 2.5 percent, Lead to MQL roughly 37 to 41 percent, MQL to SQL roughly 18 to 22 percent (top quartile 25 to 35 percent), SQL to Opportunity roughly 40 to 48 percent, and Opportunity to Closed-Won roughly 31 to 39 percent. The single biggest bottleneck in the chain is MQL to SQL: it is the lowest-yield handoff and the one where leadership most often blames "low-quality leads" when the real issue is the sales handoff, not your media buy.

The stage conversion rate is just the next-stage count over the current-stage count, $\text{rate} = \text{stage}_{N+1} / \text{stage}_N$, and the blended funnel conversion is the product of every stage rate from top to bottom. Because pipeline revenue is linear in any single stage rate, a 5-point improvement is worth more the lower the base it starts from. Lifting MQL to SQL from a 20 percent base to 25 percent is a relative gain of $(0.25 - 0.20) / 0.20 = 0.25$, so downstream revenue rises by exactly 25 percent on the same top-of-funnel volume (the worked example below proves it). Watch the base: a vendor rule of thumb that pegs a 5-point lift at roughly 18 percent assumes a higher starting rate near 28 percent, so it does not apply to the 20 percent base this lesson uses. Because MQL to SQL is both the lowest rate and the most-leveraged stage, this is why you fight for the right offer feeding it.

:::widget barChart
title: Typical B2B SaaS stage conversion rates (2025 to 2026)
labels: Visitor to Lead, Lead to MQL, MQL to SQL, SQL to Opp, Opp to Won
data: 2.0, 39, 20, 44, 35
unit: %
:::

:::quiz
question: In the standard B2B SaaS funnel, which stage is the single biggest bottleneck and the one most often misattributed to "low-quality leads"?
- Visitor to Lead
- Lead to MQL
- MQL to SQL
- Opportunity to Closed-Won
answer: 2
hint: It is the lowest-yield stage in the chain, sitting at roughly 18 to 22 percent, and it is a sales handoff.
explain: MQL to SQL runs only about 18 to 22 percent (top quartile 25 to 35 percent), the lowest rate in the chain, so it is the biggest leak. It is a sales-handoff stage, so a collapse there usually reflects the handoff or the offer feeding it, not the media buy, even though the trader gets blamed for "bad leads."
:::

# Multiplying the chain to a closed-won count

The reason you cannot judge a campaign on lead volume is that the chain compounds. Take 1,000 leads and run them down realistic stage rates: Lead to MQL 40 percent, MQL to SQL 20 percent, SQL to Opp 45 percent, Opp to Won 35 percent. The product is $1000 \times 0.40 \times 0.20 \times 0.45 \times 0.35$, which collapses an impressive-looking 1,000 leads into about 12.6 closed-won deals. Flood the top with more low-intent leads and you can grow the headline number while the closed-won count barely moves, because the decay is multiplicative.

This is exactly why the offer choice (built fully in Lesson 8) lives inside this math. Swap a gated ebook for a demo offer and you do not just change the lead count, you change the MQL-to-SQL rate, which sits in the middle of the product where it does the most damage or the most good.

:::predict
prompt: 1,000 leads convert at 40% to MQL, then 20% MQL-to-SQL, 45% SQL-to-opp, and 35% opp-to-won. How many closed-won deals result (to one decimal)?
answer: 12.6
tolerance: 0.2
unit: deals
hint: Multiply the starting leads by all four stage rates in sequence.
explain: 1,000 x 0.40 = 400 MQLs, x 0.20 = 80 SQLs, x 0.45 = 36 opps, x 0.35 = 12.6 closed-won. The blended conversion from lead to won is 0.40 x 0.20 x 0.45 x 0.35 = 1.26 percent, so 1,000 leads yields about 12.6 deals.
:::

:::predict
prompt: You improve only the MQL-to-SQL stage from 20% to 25% (a 5-point lift), holding Lead-to-MQL at 40%, SQL-to-opp at 45%, and opp-to-won at 35%. By what percent does the closed-won count rise off the same 1,000 leads?
answer: 25
tolerance: 0.5
unit: percent
hint: Recompute the deal count at 25%, then compare to the 12.6 baseline.
explain: At 25%: 1,000 x 0.40 x 0.25 x 0.45 x 0.35 = 15.75 deals. The lift is (15.75 - 12.6) / 12.6 = 0.25, a 25 percent increase in closed-won from a single 5-point move on the bottleneck stage, which is why the offer feeding MQL-to-SQL is the lever to pull.
:::

# Sizing the buy: working backward from a closed-won target

Once you trust the chain you can run it in reverse to size the media. If leadership hands you a closed-won target, the required impressions are the target divided by the full impression-to-won probability, $\text{required impressions} = \text{target closed-won} / (\text{impression-to-account} \times \dots \times \text{opp-to-won})$. That single impression-to-won rate is the product of every stage from the impression all the way down, and in B2B it is a tiny number, often a handful of closed-won per hundred thousand impressions, which is precisely why a high CPM can still pay back (the bid ceiling math is Lesson 7).

This reverse calculation is also your sanity check against an impossible brief. If the math says you need ten million impressions on an account list that can only deliver two million after match and suppression (Lesson 4), you flag it now, not after the quarter underpaces.

:::predict
prompt: You need 14 closed-won deals this quarter and your full impression-to-closed-won rate is 0.00002 (2 in 100,000). How many impressions must the campaign deliver?
answer: 700000
tolerance: 5000
unit: impressions
hint: Divide the target deals by the impression-to-won probability.
explain: 14 / 0.00002 = 700,000 impressions. The impression-to-won rate is the product of every stage in the chain, so a tiny end-to-end rate means even a modest closed-won goal demands a large, sustained impression volume, which feeds directly into pacing in Lesson 5.
:::

:::callout key
Always carry two numbers per campaign line: the stage it is buying toward and the conversion rate you expect at that stage. A line with no target stage is unmeasurable, and a target stage with no expected rate cannot be sized, paced, or defended.
:::

# Velocity: the speed of the chain, not just its yield

Yield tells you how many deals fall out of the chain; velocity tells you how fast and how much revenue per day the pipeline is generating, which is what finance actually pressures you on. Pipeline velocity is $\text{velocity} = (\text{number of opps} \times \text{avg deal value} \times \text{win rate}) / \text{sales cycle length in days}$. Two campaigns can produce identical closed-won counts, but the one feeding a shorter-cycle segment generates revenue faster, so velocity is how you compare an SMB line against an enterprise line on the same dashboard.

Velocity is also why you cannot read a single number in isolation: a campaign that lifts opp count but pushes into a longer-cycle enterprise segment can lower velocity even while raising eventual yield. You report both, and you note which lever moved.

:::predict
prompt: A segment has 40 open opportunities, an average deal value of $60,000, a 35% win rate, and an 84-day sales cycle. What is the pipeline velocity (revenue per day, to the nearest dollar)?
answer: 10000
tolerance: 50
unit: USD per day
hint: Multiply opps, deal value, and win rate, then divide by the cycle length in days.
explain: 40 x $60,000 x 0.35 = $840,000 of expected won revenue, divided by 84 days = $10,000 per day. Shortening the cycle or lifting the win rate raises velocity even if the opp count is unchanged, which is how you justify always-on spend to finance.
:::

# Counting the right "conversion" and reading the leak

The trap that quietly inflates B2B reporting is counting the platform-reported conversion instead of the CRM stage. A LinkedIn or DSP form-fill that the platform calls a "conversion" frequently never enters the CRM as a real MQL, so optimizing to platform conversions makes a campaign look like it is working while the opp count flatlines (the full measurement war is Lesson 9). The fix is to pass UTMs and account IDs into the CRM so a display, native, or LinkedIn impression can be traced to an account that later becomes an opportunity, and then you read the stage-to-stage decay to locate the actual leak rather than trusting the headline.

The other trap is timing. Lead-to-opp lag means this month's spend shows up as pipeline roughly 84 days later (pacing in Lesson 5), so judging a stage rate before the cohort matures mislabels a working campaign as a failure. And mismatching the offer to the stage burns spend in both directions: a demo CTA shown to a cold, never-engaged account wastes premium impressions, while a gated ebook shown to a hand-raiser slows a buyer who was ready to talk.

:::quiz
question: A campaign drives a high volume of platform-reported "conversions," but the CRM shows almost no new opportunities. What is the most likely explanation a trader should investigate first?
- The bid was set too low to win quality impressions
- The platform form-fills are not entering the CRM as real MQLs
- The sales cycle is too short for the deals to close yet
- The creative fatigued and CTR dropped
answer: 1
hint: Think about the difference between what the platform counts and what the CRM counts as a real stage.
explain: Platform-reported form-fills often never become real MQLs in the CRM, so they inflate apparent performance while pipeline stays flat. The trader must reconcile platform conversions against CRM stages (Lesson 9) before trusting the number or blaming bid, cycle length, or creative.
:::

:::callout warning
A recurring operator complaint: traders get blamed for "low-quality leads" when the real leak is the MQL-to-SQL handoff, and the same campaign looks great or terrible depending on whose definition of "MQL" you use. Before you accept the blame or cut the line, pull the stage-to-stage decay from the CRM and check whether the leak is in your media (top-of-funnel volume and fit) or in the sales handoff (MQL-to-SQL). Bring the numbers, not the apology.
:::

:::sources
- TheDigitalBloom, 2025 B2B SaaS Funnel Benchmarks and Pipeline Audit Framework | https://thedigitalbloom.com/learn/pipeline-performance-benchmarks-2025/
- Growthspree, MQL to SQL Conversion Rate Benchmarks for B2B SaaS in 2026 | https://www.growthspreeofficial.com/blogs/mql-to-sql-conversion-rate-benchmarks-b2b-saas-2026
- Optifai, B2B Sales Cycle Length Benchmarks by Deal Size and Segment | https://optif.ai/learn/questions/sales-cycle-length-benchmark/
- Improvado, B2B Marketing Attribution in 2026: Multi-Touch, MMM, Incrementality and Dark Funnel | https://improvado.io/blog/b2b-marketing-attribution
- LinkedIn Ad Format Decision Framework B2B 2026 (offer-to-stage and demo vs gated rates) | https://www.growthspreeofficial.com/blogs/linkedin-sponsored-content-vs-messaging-vs-conversation-ads-b2b-2026
- eMarketer, US B2B Digital Ad Spending 2026 | https://www.emarketer.com/content/b2b-digital-ad-spending
:::
