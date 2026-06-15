---
id: analytics-10
track: analytics
module: 10
title: Attribution modeling
summary: How last-touch, position-based, Shapley, and Markov models split conversion credit across the touchpoints in a journey.
---
# Splitting the credit

Most conversions follow a path: a display impression, a paid search click, an email, then a purchase. Attribution is the rulebook for dividing the credit for that conversion across the touchpoints. The rule you pick reshapes which channels look valuable, so it drives where budget flows.

Attribution is correlational accounting, not causal measurement. It distributes observed credit among observed touches; it does not prove any touch caused the conversion. Treat it as a budgeting heuristic, and use incrementality tests from the previous module when you need the causal answer.

:::quiz
question: A model reassigns conversion credit and a channel's share jumps. What has that actually told you?
- Only how credit is distributed under that rule, not whether the channel caused conversions
- That the channel is now proven incremental
- That the channel should always get more budget
- That the previous model was computed incorrectly
hint: Attribution divides observed credit among observed touches. Which question does that leave unanswered?
answer: 0
explain: Attribution is correlational accounting. Changing the rule changes how credit is split, but no rule establishes causation. To know whether a channel drove incremental conversions you need a holdout or geo test, not a new attribution model.
:::

# Heuristic models

Last-touch gives 100% of the credit to the final touchpoint before conversion. It is simple and still widely used, but it systematically overcredits bottom-of-funnel channels like branded search and ignores everything that built awareness earlier.

Position-based models spread credit by rule. Linear splits it evenly across all touches. Time-decay weights recent touches more. The common U-shaped model gives 40% each to first and last touch and splits the remaining 20% among the middle. These are defensible defaults but the weights are chosen, not learned.

$$ U\text{-shaped: } 0.40 + 0.40 + 0.20 = 1.00 $$

:::predict
prompt: A journey has 4 touches. Under the U-shaped model (40% to the first touch, 40% to the last, and the remaining 20% split evenly among the middle touches), what percent of the credit does each of the 2 middle touches receive?
answer: 10
unit: %
tolerance: 0.1
hint: There are 2 middle touches sharing the 20% middle pool evenly.
explain: The middle pool is 20%, split across 2 middle touches: 20% / 2 = 10% each. So the four touches earn 40%, 10%, 10%, and 40%, summing to 100%.
:::

# Data-driven models

Shapley value attribution borrows from cooperative game theory. It treats each channel as a player and computes its average marginal contribution across every possible ordering of channels, which is the unique fair way to divide total credit. The cost is combinatorial: with many channels the number of coalitions explodes.

Markov attribution models the journey as states with transition probabilities, ending in conversion or null. A channel's credit comes from its removal effect: delete that state, recompute the conversion probability, and the drop measures its importance. Both methods are learned from data rather than assigned by rule, so they adapt to your actual journeys.

:::widget attributionComparison
:::

:::callout insight
Shapley and Markov usually agree directionally and both tend to pull credit away from last-touch toward upper-funnel channels that last-touch ignores.
:::

:::callout warning
No attribution model, however sophisticated, measures incrementality. A channel can earn large attribution credit while driving zero incremental conversions. Validate the winners with a holdout.
:::

:::quiz
question: A branded-search keyword captures almost all credit under last-touch attribution. What is the most likely concern?
- Last-touch overcredits the final click and may hide the upper-funnel channels that created the demand
- Branded search is always the true driver of conversions
- The Shapley model would assign it even more credit
- Attribution proves branded search is incremental
answer: 0
explain: Branded search sits at the end of journeys, so last-touch over-attributes to it while ignoring the awareness channels that drove users to search, and attribution credit does not establish incrementality.
:::

:::sources
- Google Ads, About attribution models | https://support.google.com/google-ads/answer/6259715
- Shao, Li, Data-driven Multi-touch Attribution Models, KDD | https://dl.acm.org/doi/10.1145/2020408.2020453
:::
