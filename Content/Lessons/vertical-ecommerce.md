---
id: vertical-ecommerce
track: ecommerce
module: 1
title: Ecommerce: the unit economics underneath ROAS
summary: Why break-even ROAS is one over gross margin, and how contribution margin, LTV to CAC, and payback decide whether growth is profitable.
---
# ROAS is the wrong north star

Ecommerce runs on unit economics, not headline ROAS. US ecommerce sales hit roughly $1.19T in 2025, a record, and ecommerce holds about 16.8 to 16.9% of total retail as of early 2026 (US Census). After iOS ATT and cookie loss, platform-reported ROAS became increasingly distrusted, so serious operators watch blended CAC against contribution margin instead. The average ecommerce ROAS in 2025 was around 2.87x and the average conversion rate sat in a 2.5 to 3.2% band, but treat those as tunable ranges from tool and agency data, not fixed constants.

The metric that actually tells you whether an ad is profitable is break-even ROAS, and it depends only on your gross margin.

$$ Break\text{-}even\ ROAS = \frac{1}{Gross\ Margin\%} $$

Below break-even ROAS you lose money on every sale, no matter what the dashboard celebrates.

:::callout key
Break-even ROAS is one divided by gross margin. A 60% margin breaks even at 1.67x, a 40% margin at 2.5x, a 25% margin at 4.0x. The thinner your margin, the higher the ROAS you must clear just to avoid losing money.
:::

:::predict
prompt: A store has a gross margin of 40%. What is its break-even ROAS?
answer: 2.5
unit: x
tolerance: 0.02
hint: Break-even ROAS is one divided by the gross margin expressed as a decimal.
explain: Break-even ROAS = 1 / 0.40 = 2.5x. Any campaign below 2.5x loses money on the margin after product cost.
:::

# Contribution margin per order

Break-even ROAS ignores acquisition cost. Contribution margin per order goes further: it starts from gross profit and subtracts the variable costs and the customer acquisition cost. Customer acquisition cost (CAC) is acquisition spend divided by new customers, and the blended version divides all spend by all new customers.

$$ Contribution = AOV \times GM\% - Variable\ Costs - CAC $$

If average order value is $80 at a 60% margin, gross profit is $48. Subtract a $42 blended CAC and the contribution is $6 per order. Thin, but positive. Raise CAC past $48 and every order loses money even though the ROAS dashboard may still look healthy.

:::predict
prompt: Average order value is $80, gross margin is 60%, there are no other variable costs, and blended CAC is $42. What is the contribution margin per order?
answer: 6
unit: $
tolerance: 0.05
hint: Take gross profit, which is AOV times gross margin, then subtract CAC.
explain: Gross profit = $80 x 0.60 = $48. Contribution = $48 - $42 = $6 per order. Positive but slim, so any rise in CAC quickly erases it.
:::

:::widget marginModeler
:::

# LTV to CAC and payback

A single order can lose money if the customer comes back. That is why retention turns the equation. Lifetime value multiplies order value by purchase frequency and lifespan, adjusted for margin.

$$ LTV = AOV \times Frequency \times Lifespan \times GM\% $$

$$ LTV{:}CAC = \frac{LTV}{CAC} $$

A healthy LTV to CAC ratio is at least 3:1, with the best operators around 4 to 5:1. Below 3:1 you are likely overpaying for growth, above 5:1 you may be underinvesting and leaving share on the table.

:::predict
prompt: A customer has an average order value of $80, buys 3 times per year, stays for 2 years, and the gross margin is 60%. The customer cost $68 to acquire. What is the LTV to CAC ratio?
answer: 4.24
unit: x
tolerance: 0.05
hint: Compute LTV as AOV times frequency times lifespan times gross margin, then divide by CAC.
explain: LTV = $80 x 3 x 2 x 0.60 = $288. LTV:CAC = $288 / $68 = 4.24x, inside the healthy 4 to 5:1 band.
:::

The companion metric is CAC payback, the number of months to recover acquisition cost from gross profit per customer. The target is usually 12 months or less.

$$ CAC\ Payback = \frac{CAC}{Monthly\ Gross\ Profit\ per\ Customer} $$

:::predict
prompt: A customer costs $120 to acquire and contributes $40 in gross profit per month. What is the CAC payback period in months?
answer: 3
tolerance: 0.05
hint: Divide the acquisition cost by the monthly gross profit per customer.
explain: CAC Payback = $120 / $40 = 3 months, well inside the 12-month target.
:::

# Growing without going broke

Signal loss is why blended measurement rose. Marketing Efficiency Ratio (MER) divides total revenue by total marketing spend, sidestepping per-channel attribution entirely. The strategic point is that profitable growth comes from levers that move unit economics, not just impressions: raising AOV through bundles and free-shipping thresholds, shifting budget toward channels with headroom on their response curve, and lifting returning-customer LTV. CPMs swing hard with seasonality too, with Meta CPM around $14 in 2026 and holiday CPCs running noticeably higher, so the same ROAS target costs more to hit in Q4.

:::quiz
question: A DTC store runs at a 2.0x blended ROAS and a 40% gross margin, and wants to scale spend aggressively. What should it check first?
- Whether 2.0x clears the break-even ROAS of 2.5x, since below it every sale loses margin
- Whether the ad creative has enough variations
- Whether the CPM is below the industry average
- Whether the store ranks on the first page of search
hint: Compute break-even ROAS from the margin and compare it to the current ROAS.
answer: 0
explain: Break-even ROAS at a 40% margin is 1 / 0.40 = 2.5x. A 2.0x blended ROAS is below break-even, so scaling spend would scale losses. Fix margin, AOV, or efficiency before pouring in budget.
:::

:::sources
- US Ecommerce Statistics, SellersCommerce | https://www.sellerscommerce.com/blog/ecommerce-statistics/
- E-Commerce Retail Sales as a Percent of Total Sales, FRED St. Louis Fed | https://fred.stlouisfed.org/series/ECOMPCTSA
- ROAS Benchmarks by Platform and Ad Format 2026, Osmos | https://www.osmos.ai/blog/roas-benchmarks-platform-ad-format-2026
:::
