---
id: sales-08
track: sales
module: 8
title: Quota and pipeline math
summary: Work backward from a quota to the pipeline you need, using win rates, funnel conversion, and expected value to size coverage.
---
# Quota is a math problem

A quota is not a motivational target. It is the output of a funnel, and the funnel has known conversion rates. If you treat quota as math, you can tell on the first day of the quarter whether you are going to make it.

Start at the bottom. To book a given amount of closed revenue, you need a multiple of that amount in open pipeline, because most deals do not close. The size of that multiple is set entirely by your win rate.

:::predict
prompt: A rep carries a $400,000 quota and closes deals at a 25 percent win rate. How much open pipeline do they need for 1x expected coverage?
answer: 1600000
unit: $
hint: Required pipeline is quota divided by the win rate.
explain: Pipeline = $400,000 / 0.25 = $1,600,000, which is 4x coverage. A 25 percent win rate always implies 4x coverage, so you can read the multiple straight off the win rate.
:::

# Coverage: how much pipeline you actually need

Win rate is deals won divided by deals worked, in dollars. Pipeline coverage is the ratio of open pipeline value to quota. The two are linked: the lower your win rate, the more coverage you need to hit the same number.

$$ coverage = quota / (pipeline \times winrate) = 1 \qquad pipeline = quota / winrate $$

A 25 percent win rate against a $300,000 quota requires $1,200,000 in pipeline, which is 4x coverage. A 50 percent win rate needs only 2x. The common 3x to 4x rule of thumb is just the inverse of a 25 to 33 percent win rate.

:::callout warning
Raw coverage lies if the pipeline is stale. A 4x ratio where 30 percent of deals are dead is really 2.8x. Always discount coverage by the fraction of pipeline that is past its expected close date or out of ICP.
:::

:::predict
prompt: A rep shows $2,000,000 of open pipeline against a $500,000 quota, but 35 percent of the pipeline is past its expected close date and should be discounted. What is the real coverage ratio?
answer: 2.6
unit: x
tolerance: 0.05
hint: Discount the pipeline by the stale fraction first, then divide the live pipeline by quota.
explain: Live pipeline = $2,000,000 x (1 - 0.35) = $1,300,000. Coverage = $1,300,000 / $500,000 = 2.6x, down from the headline 4.0x. The stale deals make the raw ratio overstate how covered the rep really is.
:::

# Expected value and the funnel

Each stage of the funnel has its own conversion rate. Walk a lead through them and the probability of closing is the product of the stage rates. Expected pipeline value is each deal's size times its stage probability, summed across the pipeline.

This is the same logic that drives commission. A typical comp plan pairs a base salary with a variable component tied to attainment, often with accelerators above 100 percent of quota. Knowing your expected value tells you where your variable pay will land before the quarter ends.

:::widget funnelExplorer
:::

:::callout insight
Two reps can show the same total pipeline and forecast very differently. The one with deals concentrated in late stages has higher expected value, because stage probability compounds. Where the dollars sit matters more than how many there are.
:::

:::quiz
question: A rep has a 20 percent win rate and a $500,000 quota. How much open pipeline do they need for 1x expected coverage?
- $2,500,000
- $100,000
- $1,000,000
- $625,000
answer: 0
explain: Required pipeline equals quota divided by win rate: $500,000 / 0.20 = $2,500,000, which is 5x coverage. A 20 percent win rate always implies 5x coverage to expect quota.
:::

:::sources
- Sales Pipeline Coverage: Formula, Ratios and Forecast Impact, Forecastio | https://forecastio.ai/blog/pipeline-coverage
- Pipeline coverage: Complete guide to calculation and benchmarks, Outreach | https://www.outreach.ai/resources/blog/sales-pipeline-coverage-ratio
:::
