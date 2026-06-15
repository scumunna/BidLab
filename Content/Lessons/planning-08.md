---
id: planning-08
track: planning
module: 8
title: Forecasting outcomes
summary: How to turn a spend number into a credible estimate of conversions or reach using response curves.
---
# From spend to outcome

A media plan is a bet on outcomes, so you need a function that maps a spend level to an expected result. That function is a response curve. It is almost never a straight line. Early spend works hard, later spend works less, and the shape of the bend is what makes the forecast useful.

Two effects govern the shape. Carryover means today's impressions keep working tomorrow, so spend has a tail. Saturation means each extra unit of spend adds less, because attention and the addressable audience are finite. Forecasting means writing both down and reading the curve at your planned spend.

:::widget responseCurve
:::

# Adstock for carryover

Adstock spreads the effect of spend across later periods with a decay rate $\theta$ between 0 and 1, written $a_t = x_t + \theta\, a_{t-1}$. A burst this week still contributes a fraction next week, a smaller fraction the week after, and so on. Higher $\theta$ means a longer memory.

:::predict
prompt: Adstock is a_t = x_t + theta times a_(t-1) with decay theta = 0.5. Last week's adstock was 80 and this week's raw spend x_t is 100 (same units). What is this week's adstocked value a_t?
answer: 140
unit: units
hint: Add this week's raw spend to theta times last week's adstock.
explain: a_t = 100 + 0.5 x 80 = 100 + 40 = 140. The carried-over 40 is the tail from prior weeks that still works this week.
:::

# The Hill saturation curve

Once you have adstocked spend, saturation maps it to outcome. A common choice is the Hill curve, which rises from zero, bends through a half-saturation point $k$, and levels off near a ceiling. The exponent $n$ controls how sharply it bends.

$$ y = x^{n} / (x^{n} + k^{n}) $$

At $x = k$ the response is exactly half of its maximum, which makes $k$ an intuitive dial: it is the spend that gets you halfway to the ceiling. Above $k$ you are paying for the flat part of the curve.

:::callout insight
Adstock answers when the effect lands. Saturation answers how much lands. A forecast needs both, because the same weekly budget spent in one burst or spread evenly produces different totals.
:::

:::predict
prompt: On the Hill curve y = x^n / (x^n + k^n) with exponent n = 2, you spend at twice the half-saturation point, so x = 2k. What fraction of the maximum response do you get?
answer: 0.8
unit: of max
tolerance: 0.01
hint: Substitute x = 2k and n = 2, then simplify. The k terms cancel.
explain: y = (2k)^2 / ((2k)^2 + k^2) = 4k^2 / (4k^2 + k^2) = 4/5 = 0.8. Doubling spend past the half-saturation point only lifts response from 0.5 to 0.8 of the ceiling, the flattening in action.
:::

# Try it

Slide spend along the response curve. Notice the steep early region where each dollar pulls real outcome, and the flat tail past the half-saturation point where extra spend mostly buys frequency.

:::widget responseCurve
:::

:::callout warning
Do not extrapolate a forecast far past the spend range you have observed. The ceiling and the bend are estimated from history. Reading the curve at 3x your usual spend is a guess dressed up as a number.
:::

:::quiz
question: In the Hill curve, what does the parameter k represent?
- The spend level where response reaches half its maximum
- The maximum possible outcome
- The decay rate of carryover
- The cost per conversion
answer: 0
explain: At x equal to k the term k to the n cancels so y equals one half. So k is the half-saturation spend, the point where you are halfway to the ceiling.
:::

:::sources
- Google Meridian, media saturation and lagging | https://developers.google.com/meridian/docs/advanced-modeling/media-saturation-lagging
- Meta Robyn, features and Hill saturation | https://facebookexperimental.github.io/Robyn/docs/features/
:::
