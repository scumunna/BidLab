---
id: vertical-b2b
track: b2b
module: 1
title: B2B and SaaS: the conversion is months upstream of the revenue
summary: How the lead to closed-won funnel cascade, CPL and CPO, LTV:CAC, marketing-sourced pipeline, and ABM reach drive B2B media math.
---
# In B2B the lead is far upstream of the money

A B2B lead is not a sale. It is the top of a long, multi-touch funnel that descends through MQL, SQL, opportunity, and finally closed-won, often months later, decided by a buying committee of around 25 stakeholders over a median cycle near 84 days (90 to 180-plus days at enterprise). Because the conversion you can buy sits so far upstream of revenue, B2B math is about projecting a lead forward through stage rates and judging it against deal value and lifetime, not about an immediate ROAS.

The spend is growing. US B2B digital ad spend ran about $20B in 2025 and is forecast at about $23.05B in 2026, growth in the low double digits, with digital share rising from about 45.6% to 48.0% (EMARKETER via MarketingCharts). The numbers reward patience: tiny click-through rates (LinkedIn around 0.44 to 0.65%) pair with huge per-deal value ($15K to $1M-plus).

:::figure funnel
caption: The B2B funnel descends from lead through MQL, SQL, and opportunity to closed-won, often over months. The conversion you buy sits at the top, far upstream of the revenue at the bottom.
:::

# The funnel cascade

Each stage multiplies the one before it. Leads come from clicks times lead-form conversion, then each downstream count is the prior count times that stage's pass-through rate.

$$ Closed\text{-}Won = Leads \times r_{MQL} \times r_{SQL} \times r_{Opp} \times r_{Close} $$

The full lead-to-close rate is the product of every stage rate. Using First Page Sage benchmark midpoints, Lead to MQL might be 45%, MQL to SQL 40%, SQL to Opp 40%, and Opp to Close 40%. Walk 1,000 leads down: 1,000 -> 450 MQL -> 180 SQL -> 72 opportunities -> about 29 closed-won. A small change in any single stage rate compounds through every stage below it.

:::predict
prompt: Start with 1,000 leads. Lead to MQL is 45%, MQL to SQL is 40%, SQL to Opportunity is 40%, and Opportunity to Close is 40%. How many opportunities do you reach?
answer: 72
hint: Multiply leads by the three stage rates from lead through opportunity.
explain: Opportunities = 1,000 x 0.45 x 0.40 x 0.40 = 72 opportunities (before the final close step).
:::

:::widget funnelExplorer
:::

# CPL and CPO: cost at each stage

Because value is created stage by stage, you track cost per stage. CPL is spend per lead, and CPO is spend per opportunity, which is far higher because so few leads make it that far.

$$ CPL = \frac{Spend}{Leads} \qquad CPO = \frac{Spend}{Opportunities} $$

A blended CPL around $237 is a reasonable benchmark, with LinkedIn near $408 and Google PPC near $463 (First Page Sage). If you spend $300,000 and generate 1,200 leads, CPL = $300,000 / 1,200 = $250. The same spend across the 72 opportunities from the cascade above would imply a CPO in the low thousands, which only makes sense when the deal size is large.

:::predict
prompt: A program spends $300,000 and generates 1,200 leads. What is the cost per lead?
answer: 250
unit: $
hint: CPL is spend divided by leads.
explain: CPL = $300,000 / 1,200 = $250 per lead.
:::

# LTV:CAC, marketing-sourced pipeline, and payback

The unit economics decide whether the funnel pays. CAC is total sales and marketing spend over new customers. LTV is annual revenue per account times gross margin over churn. The ratio should clear 3:1, with top-quartile SaaS at 4:1 to 6:1, and the current SaaS benchmark to acquire $1 of new ARR sits near $2.00 (First Page Sage).

$$ LTV\!:\!CAC = \frac{LTV}{CAC} \qquad Payback\ (months) = \frac{CAC}{Monthly\ ARPA \times GM\%} $$

Marketing-sourced pipeline is the sum of deal value on opportunities where marketing originated the account, the figure that justifies the budget. With 72 opportunities at a $45,000 average contract value, marketing-sourced pipeline = 72 x $45,000 = $3,240,000, clearing a $3M goal.

:::predict
prompt: A program produces 72 marketing-sourced opportunities at a $45,000 average contract value. What is the marketing-sourced pipeline?
answer: 3240000
unit: $
hint: Multiply the number of opportunities by the average contract value.
explain: Pipeline = 72 x $45,000 = $3,240,000, above a $3,000,000 target.
:::

:::callout key
A B2B campaign is judged on pipeline and LTV:CAC, not on immediate ROAS. The conversion you buy (a lead) is months and several stage gates away from revenue, so a strong CPL means nothing if the downstream stage rates or deal economics do not clear a 3:1 lifetime-to-acquisition bar.
:::

# Account-based marketing: reach into the named list

ABM flips the model. Instead of maximizing raw lead volume, you work a finite list of target accounts and measure penetration into it. ABM account reach is engaged target accounts over the total target list.

$$ ABM\ Account\ Reach = \frac{Engaged\ Target\ Accounts}{Total\ Target\ List} $$

If you engage 150 of a 250-account ICP list, reach = 150 / 250 = 60%. Mature ABM programs report 50 to 73% of revenue coming from target accounts and about 60% higher win rates, which is why account reach, not lead count, is the headline metric in an ABM plan.

:::predict
prompt: An ABM program engages 150 accounts out of a 250-account target list. What is the account reach?
answer: 60
unit: %
hint: Account reach is engaged accounts divided by the total target list.
explain: ABM account reach = 150 / 250 = 0.60 = 60% of the target list engaged.
:::

:::quiz
question: A B2B campaign reports an excellent $150 cost per lead, well below benchmark. Why might it still be a poor program?
- If downstream stage rates or deal economics are weak, cheap leads can still fail to clear a 3:1 LTV:CAC, because revenue is many stages and months away
- A low CPL always means the campaign is working
- Cost per lead is the only metric that matters in B2B
- Cheap leads are always high quality
hint: Think about everything that has to happen between a lead and closed-won revenue.
answer: 0
explain: A lead is far upstream of revenue. If lead-to-close rates or LTV:CAC are poor, low CPL does not translate into profitable pipeline, so the unit economics, not CPL alone, decide the verdict.
:::

:::sources
- B2B Digital Ad Spending Forecast 2026, EMARKETER via MarketingCharts | https://www.marketingcharts.com/industries/business-to-business-234263
- B2B SaaS Funnel and CPL Benchmarks 2025, First Page Sage | https://firstpagesage.com/
:::
