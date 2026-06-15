---
id: vertical-qsr
track: qsr
module: 1
title: QSR: paying only for the visit that would not have happened
summary: How cost per incremental visit, visit lift, dayparting, and redemption times ticket make foot traffic the currency.
---
# QSR conversion is a physical store visit

In quick-service restaurants the conversion is not a click or an online checkout. It is a person walking through the door. That single fact rewrites the math. You measure foot traffic by matching ad exposure against mobile location signals, you plan per store inside a tight geo-radius, and the honest currency is incrementality: the visit that would not have happened without the ad.

Spending is meaningful but easy to misquote. QSR brand ad spend tracked across media was about $3.3B from May 2024 to May 2025 (Sensor Tower), the current anchor to use. An older $4.0B QSR local-advertising figure comes from a 2019 BIA report and should not be presented as current. For context, total US local advertising ran about $169B in 2025 and is forecast near $184.5B in 2026 (BIA), and the US digital coupon market was about $10.6B in 2025 heading to $12.55B in 2026 (DemandSage).

:::predict
prompt: The US digital coupon market goes from $10.6 billion in 2025 to $12.55 billion in 2026. What is the year-over-year growth rate?
answer: 18.4
unit: %
tolerance: 0.5
hint: Divide the increase by the 2025 figure, then convert to a percentage.
explain: Growth = ($12.55B - $10.6B) / $10.6B = $1.95B / $10.6B = about 18.4%. Digital coupons matter to QSR because redemption is how a foot-traffic visit becomes measurable revenue, which the lesson returns to later.
:::

# Cost per incremental visit

Attributed visits overcount, because some exposed customers were going to visit anyway. The honest metric is cost per incremental visit (CPIV): spend divided by the visits that the ad actually caused over a holdout.

$$ Incremental\ Visits = Exposed\ Visits - (Exposed\ Audience \times Control\ Visit\ Rate) $$

$$ CPIV = \frac{Spend}{Incremental\ Visits} $$

Suppose a two-week burger-chain launch spends $220,000 and drives 40,000 incremental visits over a holdout. CPIV = $220,000 / 40,000 = $5.50 per incremental visit. With a low ticket of roughly $8 to $15, a tolerable cost per visit is single-digit to low-double-digit dollars, which is why CPIV discipline decides whether QSR media pays.

:::predict
prompt: A launch campaign spends $220,000 and produces 40,000 incremental visits over a holdout. What is the cost per incremental visit?
answer: 5.50
unit: $
hint: CPIV is spend divided by incremental visits.
explain: CPIV = $220,000 / 40,000 = $5.50 per incremental visit.
:::

:::predict
prompt: An exposed audience of 200,000 produces 18,000 visits. A control group visits at a 6% rate. How many of the exposed visits are incremental?
answer: 6000
hint: Subtract the baseline visits the exposed audience would have made anyway, which is the audience times the control visit rate.
explain: Baseline = 200,000 x 0.06 = 12,000. Incremental = 18,000 - 12,000 = 6,000 visits.
:::

# Visit lift and the holdout

Visit lift expresses the same idea as a percentage: how much more often the exposed group visits than the control.

$$ Visit\ Lift = \frac{Exposed\ Visit\ Rate - Control\ Visit\ Rate}{Control\ Visit\ Rate} $$

If the exposed group visits at 9% and the control at 6%, visit lift = (9 - 6) / 6 = 3 / 6 = 0.50, a 50% lift. Lift is the cleaner planning number because it is independent of audience size and lets you compare creative, channel, and daypart head to head.

:::predict
prompt: The exposed group visits at a 9% rate and the control group at a 6% rate. What is the visit lift?
answer: 50
unit: %
hint: Subtract the control rate from the exposed rate, then divide by the control rate.
explain: Visit lift = (9% - 6%) / 6% = 3 / 6 = 0.50 = 50%.
:::

# Dayparting moves the cost

QSR demand swings hard by time of day, and so do CPMs and intent. Breakfast, lunch, dinner, and late-night each have a different cost per visit. The lever is to compute CPV per daypart and shift budget toward the lowest-CPV windows.

$$ Daypart\ CPV = \frac{Spend_{daypart}}{Visits_{daypart}} $$

If lunch spends $40,000 for 10,000 visits ($4.00 CPV) and late-night spends $30,000 for 5,000 visits ($6.00 CPV), the same dollar buys more visits at lunch. Reallocating toward lunch lowers blended cost per visit without raising the budget.

:::callout insight
Dayparting is load-bearing in QSR, not a nicety. The same creative can be twice as expensive per visit at the wrong hour. Plan each daypart as its own mini-campaign with its own CPV and shift dollars to where the visit is cheapest.
:::

:::predict
prompt: Lunch spends $40,000 for 10,000 visits and late-night spends $30,000 for 5,000 visits. What is the blended cost per visit across both dayparts?
answer: 4.67
unit: $
tolerance: 0.05
hint: Add the spend across both dayparts, add the visits, then divide total spend by total visits.
explain: Blended CPV = ($40,000 + $30,000) / (10,000 + 5,000) = $70,000 / 15,000 = about $4.67. Shifting dollars from the $6.00 late-night window toward the $4.00 lunch window pulls this blended figure down without raising the budget.
:::

# Redemption times ticket closes the loop

Offers turn a visit into measurable revenue. Redemption rate is offers redeemed over offers distributed, and revenue is redemptions times average ticket. Digital coupon redemption runs about 7%, up to 15% for SMS, against under 1% for print. Then incremental ROAS folds in margin.

$$ Incremental\ ROAS = \frac{Incremental\ Visits \times Avg\ Ticket \times Gross\ Margin}{Spend} $$

Take 40,000 incremental visits, an $11.50 average ticket, and a 22% contribution margin against $220,000 of spend. Incremental ROAS = (40,000 x $11.50 x 0.22) / $220,000 = $101,200 / $220,000 = about 0.46x on margin alone, which is why QSR plans push CPIV down and layer redemption to clear a 2.0x bar.

:::predict
prompt: A coupon drop distributes 250,000 offers and 17,500 are redeemed. What is the redemption rate?
answer: 7
unit: %
hint: Redemption rate is offers redeemed divided by offers distributed.
explain: Redemption rate = 17,500 / 250,000 = 0.07 = 7%, matching the typical digital-coupon benchmark.
:::

:::quiz
question: Why does QSR media planning prefer cost per incremental visit over cost per attributed visit?
- Attributed visits include people who would have come anyway, so only the incremental visit measured against a holdout reflects the value the ad actually created
- Attributed visits cannot be measured with location data
- Incremental visits are always cheaper to buy
- Cost per attributed visit ignores the average ticket
hint: Think about which metric strips out the customers who needed no ad to show up.
answer: 0
explain: A holdout reveals how many visits the ad truly caused. CPIV charges spend only against those incremental visits, while attributed CPV overcounts by including baseline traffic.
:::

:::sources
- QSR Brand Ad Spend Tracking, Sensor Tower | https://sensortower.com/
- US Local Advertising Forecast 2026, BIA Advisory Services | https://www.bia.com/
- US Digital Coupon Market, DemandSage | https://www.demandsage.com/
:::
