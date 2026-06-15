---
id: analytics-13
track: analytics
module: 13
title: Forecasting
summary: How to decompose a time series into trend and seasonality, project it forward, and report prediction intervals that admit uncertainty.
---
# Projecting the series forward

Forecasting predicts future values of a quantity that moves over time: daily impressions, weekly spend, monthly conversions. The starting move is decomposition, splitting the series into structured parts you can model and a leftover you cannot. A common additive form is trend plus seasonality plus remainder.

$$ Y_{t} = T_{t} + S_{t} + R_{t} $$

Trend is the slow drift, up or down, over many periods. Seasonality is the repeating pattern at a fixed period: weekday cycles in ad traffic, holiday spikes in retail, quarter-end surges in B2B. The remainder is the noise left after removing both, and a good forecast should leave a remainder with no remaining pattern.

:::predict
prompt: In the additive decomposition Y = T + S + R, one day shows 100,000 impressions. The estimated trend is 85,000 and the seasonal component for that weekday is +9,000. What is the remainder R for that day?
answer: 6000
hint: Rearrange the additive form: R = Y - T - S.
explain: R = Y - T - S = 100,000 - 85,000 - 9,000 = 6,000. The remainder is what trend and seasonality do not explain; a healthy forecast leaves remainders that look like patternless noise.
:::

# Seasonality and trend

Ad data is heavily seasonal at multiple scales at once. Within a week, traffic dips on weekends; within a year, Q4 and holidays dominate retail. Modeling these cycles explicitly, rather than averaging them away, is what separates a usable forecast from a flat line through the middle.

Methods range from simple to rich. Exponential smoothing weights recent observations more heavily. SARIMA adds seasonal autoregressive and moving-average terms. Decomposition models like Prophet fit trend, multiple seasonalities, and holiday effects as separate components, which makes the forecast easy to read and explain.

:::widget forecastExplorer
:::

# Owning the uncertainty

A single forecast line is a lie of precision. The honest output is a prediction interval: a range that should contain the actual future value with a stated probability, often 80% or 95%. A wider interval is not a worse forecast; it is a more truthful one when the data is genuinely volatile.

Prediction intervals widen as you forecast further out, because uncertainty compounds with each step ahead. Use them to plan: size budgets and inventory against the interval, not the point estimate, so a swing within the expected range does not break the plan.

:::callout key
Report the interval, not just the point. A forecast of 1.0M impressions with an 80% interval of 0.85M to 1.15M tells you how much to trust the number. The point alone hides the risk.
:::

:::callout warning
Seasonal drift and concept drift erode forecasts over time. A model fit on last year's holiday pattern can miss this year's shifted peak. Refit on recent data and monitor residuals for structure you failed to capture.
:::

:::quiz
question: Why does a prediction interval get wider the further ahead you forecast?
- Uncertainty compounds with each step, so error accumulates over the horizon
- The model becomes more accurate further out
- Seasonality disappears at long horizons
- Wider intervals always mean the model is broken
answer: 0
explain: Each forecast step adds its own error on top of prior steps, so cumulative uncertainty grows with the horizon and the interval must widen to remain honest.
:::

:::sources
- Hyndman, Athanasopoulos, Forecasting: Principles and Practice | https://otexts.com/fpp3/
- Taylor, Letham, Forecasting at Scale (Prophet) | https://peerj.com/preprints/3190/
:::
