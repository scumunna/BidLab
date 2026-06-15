---
id: planning-09
track: planning
module: 9
title: Measurement planning
summary: How to choose a measurement method and size a test so you can actually read the result.
---
# Measure causes, not correlations

A media plan promises lift, and lift is a causal claim: outcomes that happened because of the ads, not alongside them. Most reporting answers the wrong question. It tells you what converters were exposed to, which is correlation. Measurement planning is deciding, before you spend, how you will isolate the part of the outcome the ads actually caused.

The clean way to isolate cause is a control group that does not see the ads. The difference between the exposed group and the control is incremental lift. Everything else (last-touch reports, platform-reported conversions) is an estimate that needs validating against a real holdout.

:::predict
prompt: An exposed group converts at 6.0 percent and a randomized control that saw no ads converts at 4.5 percent. What is the incremental lift in percentage points?
answer: 1.5
unit: percentage points
tolerance: 0.01
hint: Incremental lift is the exposed conversion rate minus the control conversion rate.
explain: Lift = 6.0 - 4.5 = 1.5 percentage points. The control's 4.5 percent would have converted anyway, so only the 1.5-point gap was caused by the ads.
:::

# Three tools, three questions

The three common methods answer different questions, and a serious plan uses more than one.

MMM (marketing mix modeling) is a top-down regression on aggregate spend and outcomes. It covers every channel and needs no user tracking, but it is correlational and coarse, good for strategic budget splits. MTA (multi-touch attribution) is bottom-up and granular, crediting touchpoints along a path, but it can over-credit channels that simply appear near conversions. Lift tests (geo-experiments and audience holdouts) are randomized, so they read true causal lift, but they cost reach and run on one question at a time.

:::callout key
MMM, MTA, and lift tests are not competitors. Lift tests give ground truth on one channel, and you use that truth to calibrate MMM and MTA so their broad coverage stays honest.
:::

:::widget attributionComparison
:::

# Design and power

A geo-experiment splits markets into treatment and control, runs for several weeks, and reads the gap. The risk is calling a result real when it is noise, or missing a real effect because the test was too small. Power is the probability the test detects a true effect of a given size, and it grows with sample size and effect size and shrinks with outcome variance.

$$ n \approx 16\,\sigma^{2} / \delta^{2} $$

This rough rule sizes each arm to detect a difference $\delta$ in means at the usual 80 percent power and 5 percent significance, where $\sigma$ is the outcome standard deviation. Smaller effects and noisier outcomes both demand sharply more sample, which is why underpowered tests return a frustrating "no significant difference."

:::callout warning
Run the power calculation before the test, not after. If the plan cannot reach enough sample for the lift you expect, the honest move is to widen the window, pick a bigger geo, or not run it. A test you cannot read is wasted budget.
:::

:::widget experimentPower
:::

:::quiz
question: You want a clean causal read on whether one channel drives sales. Which method fits best?
- A geo holdout experiment
- Multi-touch attribution
- Marketing mix modeling
- Last-touch platform reporting
answer: 0
explain: A geo holdout randomizes exposure, so the treatment-minus-control gap is causal lift. MMM and MTA are correlational and need a holdout to calibrate against.
:::

:::sources
- Triple Whale, geo-based incrementality testing | https://www.triplewhale.com/blog/geolift-geo-based-incrementality-testing
- Rockerbox, diversified marketing measurement (MMM, MTA, experiments) | https://www.rockerbox.com/diversified-marketing-measurement
:::
