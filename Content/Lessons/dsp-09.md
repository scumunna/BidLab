---
id: dsp-09
track: dsp
module: 9
title: Audience signals and bid modifiers
summary: How a trader turns audience and context signals into bid multipliers that raise or lower the bid per opportunity.
---
# A base bid times a set of dials

A trader rarely bids one flat price. You set a base bid for the campaign, then attach modifiers, multipliers that scale the bid up or down based on signals about the opportunity. A user in a high-value segment might get a 1.5x modifier. A low-viewability placement might get 0.7x. The final bid is the base times the product of every modifier that applies.

$$ bid = base \times m_{audience} \times m_{context} \times m_{device} $$

Because modifiers multiply, they stack. Two 1.5x dials together make 2.25x, not 3x. That is intentional: each signal adjusts the bid proportionally, so a strong audience signal and a strong context signal compound rather than simply add. The job is to set each dial to reflect how much that signal actually changes expected value.

:::callout insight
A bid modifier should equal the ratio of expected value with the signal to expected value without it. If a segment converts twice as well at the same cost, its modifier is about 2x. Anything more and you overpay for the signal.
:::

:::predict
prompt: The base bid is $2.00. Three modifiers apply: audience 1.5x, context 0.8x, and device 1.25x. What is the final bid?
answer: 3
unit: $
tolerance: 0.01
hint: Multiply the base bid by every modifier in turn. They compound, they do not add.
explain: bid = $2.00 x 1.5 x 0.8 x 1.25 = $3.00. The strong audience and device dials more than offset the weaker context, lifting the bid from $2.00 to $3.00.
:::

# Contextual signals when identity fades

Audience targeting leans on user-level data: behavior, declared interests, CRM matches. As cookies and device ids erode, contextual signals carry more weight. These describe the content and environment, the page topic, keywords, video genre, time of day, rather than the person. Context is privacy-durable because it needs no user identifier.

A trader blends both. Audience signals say who is likely valuable. Context signals say where and when value tends to appear. When identity is missing, a well-tuned set of contextual modifiers can recover much of the performance, because content is a strong proxy for the audience that consumes it.

:::callout key
Treat every modifier as a hypothesis about value, not a setting to maximize. A 3x audience modifier is a claim that those users are worth triple. If the data does not support it, you are just paying more to win the same impressions.
:::

:::predict
prompt: Without a context signal an impression's expected value is $0.008. On pages that match the signal the expected value is $0.012. What context modifier does that justify?
answer: 1.5
unit: x
tolerance: 0.01
hint: A modifier equals expected value with the signal divided by expected value without it.
explain: modifier = $0.012 / $0.008 = 1.5x. The matching context lifts expected value by half, so a 1.5x dial prices the signal correctly without overpaying.
:::

# Lookalikes: expanding from a seed

A lookalike model starts from a seed, your known converters or a CRM list matched into the DSP's identity graph. The model learns what those users have in common, then scores the wider population by similarity and expands toward people who resemble the seed. The trader bids up the close matches and tapers off as similarity drops.

Lookalikes are a bias-variance trade. A tight expansion (only the nearest matches) stays close to the seed's quality but reaches few people. A loose expansion reaches scale but dilutes toward the average user. You tune the similarity threshold, and the bid modifier that rides on it, to hold conversion quality while opening up enough reach to spend the budget.

:::widget responseCurve
:::

:::quiz
question: A user qualifies for two audience modifiers, each set to 1.4x. What multiplier applies to the base bid?
- 1.96x, because multiplicative modifiers compound
- 2.8x, because the modifiers add
- 1.4x, because only the larger one applies
- 0.96x, because they offset
answer: 0
explain: Bid modifiers multiply, so 1.4 times 1.4 is 1.96x. They compound rather than add, which keeps each signal a proportional adjustment to expected value.
:::

:::sources
- Google Ads Help, About bid adjustments | https://support.google.com/google-ads/answer/2732132
- Google Ads Help, About audience segments | https://support.google.com/google-ads/answer/2497941
:::
