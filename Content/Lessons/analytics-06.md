---
id: analytics-06
track: analytics
module: 6
title: Hypothesis testing
summary: Run an A/B test you can defend: state a null, read a p-value honestly, and pay the price for testing many things at once.
---
# The null hypothesis frames the bet

An A/B test compares a control and a treatment to ask whether a change made a difference. You start by assuming it did not: the null hypothesis says the two groups share the same true rate, and any observed gap is sampling noise. The test asks how surprising your data would be if that null were true.

Framing the question as "could noise alone produce a gap this big" keeps you honest. You are not proving the treatment works, you are checking whether the no-effect explanation has become too strained to keep. Randomized assignment is what lets you read the gap as causal rather than as a difference between two unlike groups.

:::quiz
question: What exactly does the null hypothesis claim in an A/B test?
- That control and treatment share the same true rate, so any observed gap is sampling noise
- That the treatment definitely has no effect and never will
- That the treatment improved the metric
- That the two groups were assigned non-randomly
hint: The null is the no-effect baseline you assume true until the data makes it too strained to keep.
answer: 0
explain: The null says the two groups have the same underlying rate, so any difference you see is attributable to sampling noise. The test measures how strained that assumption becomes given your data; it does not assert the effect is permanently zero.
:::

# The p-value, read correctly

The p-value is the probability of seeing a difference at least as large as yours if the null were true. A small p-value (below your threshold, often 0.05) means noise alone rarely produces such a gap, so you reject the null. It is not the probability that the null is true, and it is not the probability your result was a fluke.

$$ p = \Pr(\text{difference} \ge \text{observed} \mid H_0) $$

Two failure modes recur. A significant result on a tiny effect can be practically meaningless, so always read the effect size next to the p-value. And a non-significant result is not proof of no effect, it often just means the test was too small to see one, which is the power problem from the design stage.

:::callout key
A p-value answers one narrow question: how often would noise alone fake a gap this big. It says nothing about how large or how valuable the real effect is. Effect size and significance are separate readings.
:::

:::predict
prompt: You run 40 independent hypothesis tests at the 0.05 significance level on metrics that all have no real effect. How many false positives should you expect on average?
answer: 2
hint: Each test at alpha 0.05 has a 5% chance of a false positive. Expected false positives equals the number of tests times alpha.
explain: Expected false positives = tests x alpha = 40 x 0.05 = 2. Even with nothing real to find, scanning 40 metrics at the 5% level produces about two "significant" results by chance, which is why you pre-register a primary metric.
:::

# Many tests, many false alarms

Test one metric at the 5% level and you accept a 5% false-positive risk. Test twenty independent metrics and the chance that at least one fires by pure chance is not 5%, it is much higher. This is the multiple comparisons problem, and it quietly inflates the win column of every team that scans dozens of segments looking for something significant.

$$ \Pr(\text{any false positive}) = 1 - (1 - \alpha)^m $$

With m equal to 20 and alpha 0.05, that probability is 1 minus 0.95 to the twentieth, about 0.64. So a team running twenty comparisons has roughly a 64% chance of crowning at least one pure-noise result a winner. The fixes are to decide your primary metric before the test, and to correct the threshold: Bonferroni divides alpha by m (conservative), while Benjamini-Hochberg controls the false discovery rate with less power loss.

:::callout warning
Slicing a flat A/B test into twenty segments until one turns significant is not analysis, it is fishing. Pre-register the metric and the segments, or correct for the number of tests you ran.
:::

:::widget experimentPower
:::

:::quiz
question: You run 20 independent A/B comparisons at the 0.05 level on a treatment with no real effect. Roughly what is the chance at least one comes back significant?
- About 64%
- About 5%
- About 100%
- About 20%
answer: 0
explain: With independent tests the family-wise error is 1 - (1 - 0.05)^20, which is about 0.64. Testing many things at once makes a false positive likely without correction.
:::

:::sources
- Kohavi, Tang, Xu, Trustworthy Online Controlled Experiments | https://experimentguide.com
- Benjamini and Hochberg 1995, Controlling the False Discovery Rate | https://www.jstor.org/stable/2346101
:::
