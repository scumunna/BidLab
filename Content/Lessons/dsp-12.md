---
id: dsp-12
track: dsp
module: 12
title: Incrementality
summary: Why attributed conversions overstate true impact, and how holdout experiments measure the lift your ads actually caused.
---
# The conversion that would have happened anyway

Attribution counts conversions that touched your ad. Incrementality asks a harder question: how many of those conversions would not have happened without the ad? A retargeting ad shown to someone already heading to checkout gets full attribution credit and produces near-zero incremental value. The gap between attributed and incremental impact is where wasted spend hides.

Incrementality is a causal question, and the only clean way to answer it is an experiment. Split a comparable audience into a treatment group that can see the ads and a control group that cannot, then compare conversion rates. The difference, the treatment conversion rate minus the control conversion rate, is lift: the conversions your advertising actually caused.

:::callout insight
A high attributed conversion rate can sit next to zero incrementality. If the control group converts just as often, your ad changed nothing, it only stamped its name on conversions that were coming regardless.
:::

:::predict
prompt: In a holdout test the treatment group converts at 4.0 percent and the matched control group converts at 2.5 percent. What is the incremental lift in percentage points?
answer: 1.5
unit: pp
tolerance: 0.01
hint: Lift is the treatment conversion rate minus the control conversion rate.
explain: Lift = 4.0 - 2.5 = 1.5 percentage points. Only that 1.5 points was caused by the ad; the 2.5 percent baseline would have converted anyway.
:::

:::callout key
Watch the units on lift. This is absolute lift, 1.5 percentage points (4.0 minus 2.5). Many teams instead quote relative lift, the increase over the baseline, which is 1.5 / 2.5 = 60 percent. Same experiment, two very different numbers, so always state which one you mean.
:::

# PSA, ghost holdouts, and ghost bids

The classic design is a PSA test: the control group sees an unrelated public-service ad instead of yours, so both groups go through the same auctions and the only difference is your creative. It is clean but costly, because you pay to serve ads with no benefit to half the experiment.

Ghost ads fix the cost. Instead of buying a placeholder, the system records the moments the control user would have won your ad and withholds it, logging a ghost impression. Ghost bids go further, logging the auctions you would have won without spending at all. Both let you build a matched control of users who were eligible for treatment, which is what makes the comparison fair.

:::callout warning
Never use an unmatched control, like all non-exposed users. They differ from exposed users in ways the ad did not cause (less active, less in-market), so the comparison overstates lift. The control must be users who could have been treated but, by random assignment, were not.
:::

:::predict
prompt: A ghost-bid experiment measures a 1.5 percentage point lift and treats 200,000 users. How many incremental conversions did the campaign cause?
answer: 3000
unit: conversions
hint: Apply the lift, expressed as a decimal, to the number of treated users.
explain: Incremental conversions = 0.015 x 200,000 = 3,000. These are the conversions above the matched-control baseline, the only ones the ad truly caused.
:::

# Lift as a difference of differences

When a simple split is not available, traders fall back to difference-in-differences (DiD). Measure the outcome in a test region and a control region both before and after the campaign turns on. The control region captures whatever trend would have happened anyway. Subtract that trend from the test region's change, and what remains is the campaign's incremental lift.

$$ DiD = (test_{after} - test_{before}) - (control_{after} - control_{before}) $$

DiD rests on the parallel-trends assumption: absent the ad, the two regions would have moved together. If that holds, DiD strips out seasonality and market-wide shifts and isolates the ad's effect. If the regions were already diverging, the estimate is biased, so traders check that pre-period trends actually run parallel before trusting the number.

:::widget didExplorer
:::

:::quiz
question: A campaign shows strong attributed conversions, but the test and control groups convert at the same rate. What is the incremental lift?
- Near zero, the ad did not change behavior versus a matched control
- High, because attributed conversions are high
- Negative, because attribution double counts
- Cannot be computed without ghost bids
answer: 0
explain: Lift is treatment rate minus control rate. If they are equal, the ad caused no additional conversions, regardless of how many conversions attribution credited to it.
:::

:::sources
- Johnson, Lewis, Nubbemeyer, Ghost Ads | https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2620078
- Measuring advertising incrementality using Ghost Ads, Mobile Dev Memo | https://mobiledevmemo.com/measuring-advertising-incrementality-using-ghost-ads/
:::
