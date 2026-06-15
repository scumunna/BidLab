---
id: analytics-08
track: analytics
module: 8
title: Causal inference
summary: Why correlation is not causation, how confounders and selection bias mislead you, and what it takes to claim a campaign caused a lift.
---
# Two variables moving together

Correlation means two quantities rise and fall together. Causation means changing one actually moves the other. In advertising the gap between them is where budgets go to die, because spend correlates with almost every good outcome whether or not it caused them.

The classic trap: people who saw your ad convert at a higher rate than people who did not. That comparison is contaminated. You targeted the people most likely to convert in the first place, so the gap reflects who you picked, not what the ad did.

:::quiz
question: Exposed users convert at 6% and unexposed users at 3%. Why is "the ad doubled conversions" an unsafe conclusion?
- Exposure was not randomized, so the exposed group was likely higher-intent before any ad ran
- The two rates are too close to compare
- Doubling is impossible in advertising
- Conversion rates above 5% are always unreliable
hint: Who gets exposed is usually chosen by targeting, not a coin flip. What does that do to the comparison?
answer: 0
explain: Without randomization, exposure correlates with intent: targeting selects the users most likely to convert. The 6% versus 3% gap mixes the ad's effect with that pre-existing difference, so it does not measure causal lift.
:::

# The confounder problem

A confounder is a variable that influences both the treatment and the outcome, manufacturing a correlation that is not causal. Warm weather drives both ice cream sales and drownings, so the two correlate without one causing the other. In marketing the confounder is usually intent: a retargeting pool already wants the product, so exposure and conversion both spike for the same hidden reason.

The causal effect we want is the difference between two worlds for the same person, exposed versus not exposed. We only ever observe one. Formally the average treatment effect compares the expected outcome under treatment against the expected outcome under control.

$$ ATE = E[Y_{1}] - E[Y_{0}] $$

:::callout warning
Selection bias is the quiet killer. If your exposed group differs from your control group before the campaign runs, any post-campaign gap mixes the ad effect with that pre-existing difference, and you cannot untangle them after the fact.
:::

:::predict
prompt: In a randomized test, the treatment group converts at 5.0% and the control group at 3.5%. What is the average treatment effect, in percentage points?
answer: 1.5
unit: pp
tolerance: 0.01
hint: With random assignment the groups match on confounders, so the ATE is simply the treated rate minus the control rate.
explain: ATE = E[Y1] - E[Y0] = 5.0% - 3.5% = 1.5 percentage points. Randomization is what licenses reading this raw difference as causal; the same subtraction on a targeted, non-random split would be confounded.
:::

# How to actually get causation

Randomization is the cleanest fix. Assign each eligible user to test or control by a coin flip, and on average the two groups match on every confounder, observed or not. Now a post-campaign difference is attributable to the ad, because nothing else differs systematically.

When you cannot randomize, you reach for quasi-experimental tools that approximate it: difference-in-differences, instrumental variables, and synthetic controls. Each makes assumptions to stand in for the randomization you could not run, and each is weaker than a clean experiment.

:::widget didExplorer
:::

:::callout key
A randomized control group is not optional overhead. It is the only thing that converts an observed correlation into a defensible causal claim.
:::

:::quiz
question: Exposed users convert at 4% and unexposed users at 2%, but exposure was chosen by a targeting model. What can you conclude about the ad's causal lift?
- Very little, because targeting confounds exposure with conversion intent
- The ad caused a 2 point absolute lift
- The ad doubled the conversion rate
- Nothing, because the sample is too small
answer: 0
explain: The targeting model selected high-intent users into exposure, so the gap reflects selection bias, not a measured causal effect.
:::

:::sources
- Pearl, Causality: Models, Reasoning, and Inference | https://bayes.cs.ucla.edu/BOOK-2K/
- Wikipedia, Rubin causal model (potential outcomes and ATE) | https://en.wikipedia.org/wiki/Rubin_causal_model
:::
