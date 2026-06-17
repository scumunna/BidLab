---
id: vertical-b2b-01
track: vertical-b2b
module: 1
title: "The Money Map: B2B/SaaS Programmatic Landscape"
summary: Orient yourself in the B2B/SaaS programmatic ecosystem so you know which platform does targeting versus reach versus measurement, why CPMs run high, and why the account, not the cookie, is the unit you buy.
---
# The shape of the B2B money map

B2B programmatic is a small slice of a giant market. US B2B digital ad spend is about $23.05B in 2026, up 10.4% year over year, against roughly $178B in US programmatic display overall and about $834B in the global programmatic market (Custom Market Insights). Digital now makes up 48% of total B2B ad spend, up from 43.5% in 2022, so the budget is shifting your way even though B2B is a minority of all programmatic dollars. The signature shape you must internalize: tiny click-through rates, huge deal value, and the account (not the individual cookie or user) as the thing you are buying.

That inversion is the whole vertical. In consumer programmatic you optimize toward a cheap conversion at scale. In B2B you optimize toward a handful of high-value accounts, where one closed-won deal can be worth $15K to $250K or more, so a $50 to $100 CPM can still pay back. Everything in this path, from bid ceilings to pacing to measurement, follows from that single fact.

:::widget barChart
title: Where B2B sits in the programmatic market (2026)
labels: US B2B Digital, US Programmatic Display, Global Programmatic
data: 23.05, 178.25, 834
unit: USD billions
:::

:::callout key
The B2B trader's job is to spend a small, premium budget against a named list of accounts and prove it generated pipeline. You are not chasing cheap clicks at scale. You are putting expensive, account-targeted impressions in front of a buying committee and connecting that exposure to deals in the CRM.
:::

# Three kinds of platform: targeting, reach, and measurement

Your tools split into three jobs, and a new hire who confuses them will mis-buy. General DSPs (The Trade Desk, DV360, StackAdapt) give you reach across display, native, and CTV but have weak native account targeting on their own. ABM-native platforms (Demandbase, 6sense, RollWorks, Madison Logic, Terminus) excel at CRM-data and account targeting but lack DSP-scale reach and often lack cost transparency. Firmographic and intent data vendors (Bombora, 6sense) are the signal layer you plug into either one. StackAdapt is the fastest-growing DSP among B2B advertisers, and more than 80% of B2B programmatic campaigns use firmographic targeting.

The practical map is: an ABM platform or a data vendor decides which accounts to target, a DSP decides where and at what price to reach them, and a separate measurement stack (the CRM plus incrementality testing, covered later in this path) decides whether it worked. Knowing which box owns which job tells you where a problem lives when reach collapses or pipeline goes flat.

:::quiz
question: A new trader wants maximum open-web display reach but is frustrated that account-level targeting is weak out of the box. Which kind of platform are they most likely using?
- An ABM-native platform like Demandbase or 6sense
- A general DSP like The Trade Desk or DV360
- A firmographic data vendor like Bombora
- A CRM like Salesforce
answer: 1
hint: Reach across the open web is the strength, native account targeting is the gap.
explain: General DSPs (The Trade Desk, DV360, StackAdapt) provide broad open-web reach but have weak native account targeting on their own, which is why traders layer an ABM platform or firmographic and intent data on top. ABM-native platforms have the opposite profile, strong account targeting but limited DSP reach.
:::

:::figure supplyChain
caption: The B2B buy-side stack. A data or ABM layer decides which accounts to target, a DSP decides where and at what price to reach them across display, native, and CTV, and the LinkedIn walled garden sits off to the side as a separate buying motion.
:::

# Why the CPMs run ten times higher or more

Sticker shock is the first thing every B2B hire feels. Open-market display CPMs sit around $4 to $7, but B2B account-targeted inventory and especially LinkedIn run far higher: LinkedIn CPMs average about $34 across industries and commonly land in the $30 to $60 band, and tightly targeted US inventory can reach $100 or more. So you routinely pay ten times an open-web CPM, sometimes much more. The reason is not that the pixels are fancier. It is that you are filtering a thin pool down to specific companies and roles, paying a premium for clean, targetable, brand-safe inventory, and competing with other well-funded B2B advertisers for the same scarce eyeballs.

The math that makes it sane is value-based, not cost-based. You judge a CPM against the deal it can produce, not against a consumer benchmark. Effective CPM is the simplest unit you will compute daily.

$$ \text{eCPM} = \frac{\text{total cost}}{\text{impressions}} \times 1000 $$

:::predict
prompt: A campaign spends $9,000 and delivers 3,000,000 impressions. What is the effective CPM?
answer: 3
tolerance: 0.05
unit: USD
hint: Divide total cost by impressions, then multiply by 1,000.
explain: 9,000 / 3,000,000 = 0.003, and 0.003 times 1,000 is a $3.00 eCPM. That is a cheap open-web number. The same dollars filtered down to named accounts on LinkedIn could easily cost ten to twenty times more per thousand, which only pays back because the deal at the end is worth tens of thousands.
:::

:::predict
prompt: US B2B digital ad spend is $23.05B in 2026 after growing 10.4% year over year. What was the 2025 figure, rounded to the nearest $0.1B?
answer: 20.9
tolerance: 0.1
unit: USD billions
hint: This year equals last year times 1.104, so divide this year by 1.104.
explain: 23.05 / 1.104 = 20.88, which rounds to $20.9B. Growth of 10.4% means you divide by 1.104, not subtract 10.4%. Subtracting would wrongly give about $20.6B.
:::

# Working media: what actually reaches inventory

Your boss funds a budget, but only part of it buys impressions. The rest goes to data fees (firmographic and intent layers), DSP and platform fees, and agency fees. Working media percentage is the share of spend that actually reaches inventory, and in B2B it can be lower than consumers expect because the data layer is expensive. Tracking it stops you from quietly losing a third of the budget to fees and waste.

$$ \text{working media \%} = \frac{\text{media spend}}{\text{media spend} + \text{data fees} + \text{DSP fees} + \text{agency fees}} $$

:::predict
prompt: A trader spends $50,000 on media, $8,000 on data fees, $5,000 on the DSP fee, and $7,000 on the agency fee. What is the working media percentage?
answer: 71.4
tolerance: 0.2
unit: percent
hint: Divide media spend by the total of all four line items.
explain: Total spend is 50,000 + 8,000 + 5,000 + 7,000 = 70,000. Working media is 50,000 / 70,000 = 0.714, or 71.4%. Nearly 29 cents of every dollar went to data, platform, and agency fees before a single impression rendered, which is why B2B traders watch this number closely.
:::

:::widget marginModeler
title: Working media versus fee load across a B2B budget
:::

# The account is the unit, not the cookie

This is the mental shift that separates B2B from every consumer vertical. The buyer is not a person, it is a buying committee. Gartner puts a typical B2B buying group at 6 to 10 decision-makers spread across functions like procurement, legal, finance, and IT, and that number can climb past 15 in large enterprise deals. So when you buy, you are buying reach across many roles inside one company, not a single impression against one persona. The signature metric you will be judged on is LTV:CAC, the ratio of customer lifetime value to acquisition cost, not CTR or CPM.

A quick orientation calculation shows why account value dominates the math. If a customer is worth far more in lifetime value than they cost to acquire, an expensive media buy can still clear the bar, and the standard minimum bar in B2B SaaS is a 3:1 LTV:CAC.

$$ \text{LTV:CAC} = \frac{\text{customer lifetime value}}{\text{customer acquisition cost}} $$

:::predict
prompt: A new customer has a lifetime value of $96,000 and cost $24,000 to acquire. What is the LTV:CAC ratio?
answer: 4
tolerance: 0.05
unit: ratio to 1
hint: Divide lifetime value by acquisition cost.
explain: 96,000 / 24,000 = 4.0, a 4:1 LTV:CAC. That clears the 3:1 minimum and sits in top-quartile territory (4:1 to 6:1). This is the metric that justifies a $24,000 acquisition cost that a consumer marketer would never tolerate, because the lifetime value behind it is four times larger.
:::

:::quiz
question: Why is "the account, not the cookie" the defining idea of B2B programmatic buying?
- Because cookies are illegal in B2B advertising
- Because the buyer is a committee of 6 to 10 stakeholders across multiple functions, so you buy reach across many roles inside one company
- Because B2B campaigns never use display inventory
- Because accounts are cheaper to target than individuals
answer: 1
hint: Think about who actually approves a six-figure software purchase.
explain: A six-figure software deal is approved by a buying committee, typically 6 to 10 stakeholders across functions like procurement, legal, finance, and IT, not one person. So the unit you buy and measure is the account, and your budget must reach many roles inside it. Cookies are still used as an identity signal, but the account is what you optimize toward.
:::

# Where the scale dries up: the structural quirks

Four quirks recur in every later lesson, so meet them now. First, reach collapse: because B2B open-exchange scale is thin, stacking filters (account list, then intent, then seniority) shrinks a deliverable audience fast, and operators routinely complain that once firmographic plus intent plus suppression lists are stacked, the budget underpaces. Second, the walled-garden split: LinkedIn is not classic RTB and cannot be bought through a standard DSP, so you run a forced two-platform media plan (LinkedIn now offers CTV via The Trade Desk with job-title and seniority targeting, but the in-feed walled garden stays separate). Third, account-not-cookie buying, which you just met. Fourth, signal loss: third-party cookies and mobile IDs are decaying, which threatens the match rates that keep account audiences alive.

The one to feel in your gut today is reach collapse, because it is pure multiplication. Each filter is a fraction, and fractions multiply down quickly. A list that looked huge on the slide becomes a thin audience the moment you layer real targeting on it.

:::predict
prompt: You upload 5,000 target accounts. 80% match in the DSP, then only 50% of those are showing buying intent this quarter, and you further restrict to the 70% that include a senior decision-maker. How many accounts remain deliverable?
answer: 1400
tolerance: 10
unit: accounts
hint: Multiply the starting count by each fraction in turn: 0.80, then 0.50, then 0.70.
explain: 5,000 times 0.80 is 4,000, times 0.50 is 2,000, times 0.70 is 1,400. Three reasonable filters cut a 5,000-account list to 1,400, a 72% reduction. This is reach collapse, and it is why a B2B trader trades precision against scale on every campaign. Lesson 4 turns this into a full discipline.
:::

:::callout warning
A recurring operator pain point: ABM platform demos overpromise reach that real campaigns cannot hit. New hires keep asking why B2B cannot just run open-exchange like B2C and why CPMs run ten times higher or more. The honest answer is that the vendor's reach number is before your filters, and once you stack the account list, intent, seniority, and suppression, the deliverable audience shrinks until the budget underpaces. Always pressure-test a quoted reach figure against your own stacked filters before you trust the media plan.
:::

:::sources
- eMarketer, US B2B Digital Ad Spending 2026 | https://www.emarketer.com/content/b2b-digital-ad-spending
- Custom Market Insights, Global Programmatic Advertising Market Size 2025-2034 | https://www.custommarketinsights.com/report/programmatic-advertising-market/
- digitalapplied, LinkedIn Ads Benchmarks 2026: CPC, CTR, CVR by Industry | https://www.digitalapplied.com/blog/linkedin-ads-benchmarks-2026-cpc-ctr-cvr-industry
- Gartner, The B2B Buying Journey | https://www.gartner.com/en/sales/insights/b2b-buying-journey
- Improvado, B2B Marketing Attribution in 2026: Multi-Touch, MMM, Incrementality and Dark Funnel | https://improvado.io/blog/b2b-marketing-attribution
- abmatic, 6sense vs Bombora: Intent Data Comparison 2026 | https://abmatic.ai/blog/6sense-vs-bombora-intent-data-2026
- The Keyword, LinkedIn partners with The Trade Desk for CTV ad buying | https://www.thekeyword.co/news/linkedin-ctv-trade-desk-b2b-advertising
- ANA, Q2 2025 Programmatic Transparency Benchmark | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
:::
