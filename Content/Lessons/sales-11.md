---
id: sales-11
track: sales
module: 11
title: Revenue forecasting
summary: Build a defensible forecast from run-rate, seasonal indexing, and probability-weighted pipeline instead of gut feel.
---
# A forecast is a claim you can defend

Every quarter you are asked for a number. The weak version is a guess dressed up as confidence. The strong version is a forecast you can decompose, where each piece traces back to data. Three methods cover most of what a seller needs: run-rate, seasonal adjustment, and probability-weighted pipeline.

The discipline matters because intuition is biased. Across the industry average quota attainment sits near half of target, so a forecast built on hope runs systematically high. Math built on history runs closer to truth.

:::predict
prompt: A territory has closed $90,000 in the current month at a steady pace. Using a simple run-rate, what is the annualized projection?
answer: 1080000
unit: $
hint: Annualize a monthly figure by multiplying it by 12.
explain: Run-rate annual = $90,000 x 12 = $1,080,000. Run-rate is fast and fine for a steady business, but it is blind to the calendar, so a peak or trough month must be deseasonalized before you extend it.
:::

# Run-rate and seasonality

Run-rate is the simplest projection: take recent performance and extend it. Annualize a month by multiplying by 12, or a quarter by 4. It is fast and works when the business is steady, but it is blind to the calendar.

Seasonality fixes that. Compute a seasonal index for each period by dividing that period's historical average by the overall average. A Q4 index of 1.3 means Q4 typically runs 30 percent above the baseline. Multiply the run-rate by the index to get a seasonally adjusted forecast.

$$ forecast = runrate \times index_{season} \qquad index = avg_{period} / avg_{all} $$

:::callout warning
Do not annualize a peak month. A seller who hits a strong December and multiplies by 12 forecasts a year that the calendar will never deliver. Always strip out seasonality before you extrapolate.
:::

:::predict
prompt: A territory averages $150,000 per quarter across the year. Q4 carries a seasonal index of 1.4 and the current run-rate points to $150,000. What is the seasonally adjusted Q4 forecast?
answer: 210000
unit: $
hint: Multiply the run-rate by the seasonal index for the period.
explain: Adjusted forecast = $150,000 x 1.4 = $210,000. The index of 1.4 says Q4 historically runs 40 percent above the yearly baseline, so a flat run-rate would have under-forecast the quarter by $60,000.
:::

# Weighted pipeline and attainment probability

The most defensible forecast weights each open deal by its stage probability. A $100,000 deal at a 60 percent proposal stage contributes $60,000 of expected value. Sum the weighted deals and you have a pipeline forecast grounded in conversion history, not optimism.

Pair this with an attainment probability: given your committed plus best-case pipeline, how likely are you to clear quota? Reporting a forecast as a range with a confidence level (commit, best case, and a probability of hitting target) is far more useful to leadership than a single brittle number.

:::callout key
Triangulate. When run-rate, seasonal, and weighted-pipeline forecasts agree, you have a strong number. When they diverge, the gap tells you exactly which assumption to interrogate before you commit.
:::

:::widget forecastExplorer
:::

:::quiz
question: A territory averages $200,000 per quarter across the year. Q4 has a seasonal index of 1.25 and current run-rate points to $200,000. What is the seasonally adjusted Q4 forecast?
- $250,000
- $200,000
- $160,000
- $225,000
answer: 0
explain: Multiply the run-rate by the seasonal index: $200,000 times 1.25 = $250,000. The index of 1.25 reflects that Q4 historically runs 25 percent above the yearly baseline.
:::

:::sources
- 8 Tested Sales Forecasting Methods for Predicting Revenue, Salesforce | https://www.salesforce.com/sales/analytics/sales-forecasting-guide/methods/
- Revenue Forecasting: A Guide to Models and Best Practices, RevenueGrid | https://revenuegrid.com/blog/revenue-forecasting/
:::
