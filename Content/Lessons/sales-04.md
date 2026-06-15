---
id: sales-04
track: sales
module: 4
title: Forecasting avails
summary: Estimate available impressions, adjust for seasonality, and pace a flight so a campaign delivers in full without burning out early.
---
# Avails are the inventory you can promise

Avails, short for available impressions, are the impressions you expect to have for sale over a future window for a given targeting. Before you can sell a guaranteed deal, you have to forecast avails, because promising more than you can deliver means under-delivery, makegoods, and lost trust.

Forecasting starts from log-level data, the per-impression history from your ad server, and projects it forward. The core estimate is simple: take historical impressions for the matching targeting and extend the trend across the flight dates, the start and end of the campaign.

:::predict
prompt: A placement has averaged 150,000 matching impressions per day. A buyer wants a guaranteed flight that runs 28 days. What is the raw forecast of available impressions before any adjustments?
answer: 4200000
unit: impressions
hint: Raw avails is the average daily rate multiplied by the number of flight days.
explain: Avails = 150,000 x 28 = 4,200,000 impressions. This is the ceiling before you subtract inventory already committed and apply your expected fill, so never promise the full raw number.
:::

# Building the forecast

A baseline forecast multiplies an average daily impression rate by the number of days in the flight, narrowed by targeting. If a placement averages 200,000 matching impressions per day and the flight runs 30 days, the raw forecast is 6 million impressions.

$$ Avails = \mu_{daily} \times days \times reserved $$

But raw supply is not all sellable. You must subtract impressions already committed to other guaranteed deals, then apply the share you actually expect to win or fill. The reserved factor accounts for existing commitments so you do not double-sell the same inventory.

:::callout insight
A forecast you cannot deliver is worse than no forecast. Always net out inventory already committed before you promise avails to a new buyer.
:::

:::predict
prompt: Raw supply for a targeting is 6,000,000 impressions over the flight. 1,500,000 are already committed to other guaranteed deals, and you expect to fill 80 percent of what remains. How many impressions can you safely promise this buyer?
answer: 3600000
unit: impressions
hint: Subtract the committed impressions first, then apply the expected fill share to what is left.
explain: Sellable = (6,000,000 - 1,500,000) x 0.80 = 4,500,000 x 0.80 = 3,600,000. Netting out commitments before applying fill is what keeps you from double-selling the same inventory.
:::

# Seasonality bends the curve

Traffic is not flat. It rises and falls with the day of week, holidays, and broad seasonal demand, and ad prices move with it. Retail surges in Q4, B2B sags in summer, weekends differ from weekdays. A forecast that ignores these patterns will be confidently wrong.

Good forecasting models seasonality explicitly, learning weekly and yearly cycles from history and adjusting avails accordingly. The practical rule: never extrapolate a quiet Tuesday across a holiday week, and never price December like July.

:::callout warning
Flat-line forecasts fail at exactly the moments that matter most, peak retail weeks and holiday spikes. Build seasonality into the estimate, do not bolt it on after.
:::

:::predict
prompt: A placement averages 200,000 impressions per day across the year. A holiday week carries a seasonal index of 1.4. What is the seasonally adjusted daily forecast for that week?
answer: 280000
unit: impressions
hint: Multiply the baseline daily rate by the seasonal index for the period.
explain: Adjusted daily = 200,000 x 1.4 = 280,000 impressions. An index of 1.4 means traffic runs 40 percent above baseline, so a flat-line forecast would have understated avails by 80,000 per day during the peak.
:::

# Pacing the flight

Once a campaign is live, pacing controls how fast it spends. Even pacing spreads delivery smoothly across the flight so the budget lasts to the end date. Without it, a campaign can exhaust its budget early and miss high-intent inventory that appears later in the flight.

The pacing target is the budget divided by the days remaining, recalculated as avails shift. If delivery runs ahead, the system throttles back; if behind, it accelerates. The aim is a steady line from launch to completion, full delivery with no front-loading and no scramble at the end.

:::widget pacingController
:::

:::quiz
question: Why is even pacing across a flight preferable to spending as fast as possible?
- It preserves budget for high-intent inventory that appears later in the flight
- It increases the agency commission rate
- It removes the need to forecast avails
- It guarantees every impression is a conversion
answer: 0
explain: Spending too fast exhausts the budget early and misses valuable inventory later in the flight, so even pacing spreads delivery to capture opportunity throughout the run.
:::

:::sources
- Inventory Forecasting, Microsoft Xandr | https://learn.microsoft.com/en-us/xandr/monetize/inventory-forecasting
- How line item delivery is paced, Google Ad Manager Help | https://support.google.com/admanager/answer/2669484
:::
