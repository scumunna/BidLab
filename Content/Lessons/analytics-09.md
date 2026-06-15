---
id: analytics-09
track: analytics
module: 9
title: Incrementality and lift
summary: How holdouts, ghost ads, geo experiments, and difference-in-differences measure the conversions a campaign actually caused.
---
# What would have happened anyway

Incremental lift is the share of conversions that happened because of the ad and would not have happened without it. A campaign can report thousands of conversions while causing almost none, because many of those users would have bought regardless. Lift strips out that baseline.

The measurement is a comparison between treatment and a control that never saw the ad. Incremental conversions are the treatment rate minus the control rate, scaled by the treated population. Lift is usually expressed as a percentage over baseline.

$$ Lift = (CVR_{test} - CVR_{control}) / CVR_{control} $$

:::predict
prompt: A holdout test measures a treatment conversion rate of 3.0% and a control conversion rate of 2.4%. What is the incremental lift over baseline, as a percent?
answer: 25
unit: %
tolerance: 0.1
hint: Lift = (CVR_test - CVR_control) / CVR_control, then multiply by 100.
explain: Lift = (3.0% - 2.4%) / 2.4% x 100 = 0.6 / 2.4 x 100 = 25%. The campaign lifted conversions 25% above the baseline that would have converted anyway, which is the true incremental signal.
:::

# Holdouts and ghost ads

A holdout randomly withholds the ad from a slice of your eligible audience, say 10%, and uses their conversion rate as the counterfactual baseline. It is clean but costly, because you give up reach on the holdout group.

Ghost ads solve the unfairness in a naive holdout. In a plain holdout the control group never entered the auction, so you cannot tell which control users would have actually been served the ad. Ghost ads log, for control users, exactly when they would have won the impression, so you compare only users who would have been exposed in both arms. That removes the auction-selection bias that wrecks naive PSA tests.

:::callout insight
The control group must be the users who would have seen the ad, not just anyone unexposed. Ghost ads enforce that match by recording the would-have-won moment for the holdout.
:::

:::quiz
question: Why do ghost ads compare only the control users for whom a "would-have-won" moment was logged, rather than all unexposed users?
- Otherwise the control mixes in users who never would have been served, biasing the baseline
- To make the holdout larger and cheaper
- Because logging every unexposed user is technically impossible
- To increase the conversion rate of the control group on purpose
hint: A fair counterfactual is the exposed users in a parallel world, not just anyone who happened not to see the ad.
answer: 0
explain: A naive holdout's control includes users who never would have entered or won the auction, so they are not comparable to the exposed group. Ghost ads log the would-have-won moment so the control is restricted to genuinely comparable users, removing auction-selection bias.
:::

# Geo experiments and difference-in-differences

When user-level randomization is impossible, split geography instead. Assign some metro areas to receive the campaign and comparable areas to receive nothing, then compare outcomes. This suits channels like CTV and linear TV where you cannot randomize individuals.

Difference-in-differences reads the lift as a double subtraction. Take the test region's change from before to after, subtract the control region's change over the same window, and the remainder is the causal effect. Subtracting the control change cancels out shared trends like seasonality, which is the whole point.

:::widget didExplorer
:::

:::callout key
Difference-in-differences rests on the parallel trends assumption: absent the campaign, test and control regions would have moved together. Check that their pre-period trends actually track before you trust the estimate.
:::

:::quiz
question: Test region sales rise 12% while control region sales rise 5% over the same period. What is the difference-in-differences estimate of campaign lift?
- 7 percentage points
- 12 percentage points
- 17 percentage points
- 2.4 times
answer: 0
explain: Difference-in-differences subtracts the control change from the test change, 12% minus 5%, leaving 7 points attributable to the campaign once shared trends are removed.
:::

:::sources
- Johnson, Lewis, Nubbemeyer, Ghost Ads: Improving the Economics of Measuring Online Ad Effectiveness (Journal of Marketing Research) | https://doi.org/10.1509/jmr.15.0297
- Meta, GeoLift open-source geo experimentation | https://facebookincubator.github.io/GeoLift/
:::
