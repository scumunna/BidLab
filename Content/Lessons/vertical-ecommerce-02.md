---
id: vertical-ecommerce-02
track: vertical-ecommerce
module: 2
title: The Buyer and the Mandate, Who Buys, the Goal, and the LTV:CAC North Star (Net of Returns)
summary: You will learn to identify the ecommerce buyer, compute LTV:CAC and blended CAC on gross-margin and net-of-returns terms, and judge bids against contribution margin instead of platform ROAS.
---
# Who you actually answer to

In ecommerce the person funding your media is a DTC brand, a marketplace seller, or the agency or in-house growth team buying on their behalf, and the mandate handed to you is profitable customer acquisition, not impressions or even a high reported ROAS. The trader sits between the platform auction and the client P&L, translating a contribution-margin ceiling into bids while reporting back in the language the CFO funds. Internalize early that the dashboards (Amazon ACoS, Meta ASC ROAS, PMax tROAS) are inputs you manage and claims you must verify, while the scoreboard is the P&L. Getting this framing wrong is the single most common reason traders and founders end up fighting in reporting reviews.

:::callout key
The buy-side north star in ecommerce is LTV:CAC and contribution margin (CM2/CM3) net of returns, with blended CAC and MER as the post-signal-loss reality check. Platform-reported ROAS is never the mandate, it ignores COGS, shipping, and returns.
:::

:::predict
prompt: A platform reports a 5:1 ROAS on a $200 order, so ad spend is $40 and the dashboard implies $160 of "profit." Strip the real costs: COGS is 50% of revenue ($100), shipping and fulfillment is $15, and a returns allowance is 10% of revenue ($20). After also subtracting the $40 of ad spend, how many dollars of contribution margin does that order actually leave?
answer: 25
tolerance: 0.5
unit: USD
hint: Start at $200 revenue and subtract COGS, shipping, the returns allowance, and the ad spend.
explain: 200 - 100 (COGS) - 15 (shipping) - 20 (returns allowance) - 40 (ad spend) = 25. The dashboard's 5:1 ROAS implied $160, but only $25 of real contribution survives once COGS, shipping, and returns are counted. That gap is the whole lesson: ROAS is an input you manage, the P&L is the scoreboard you answer to.
:::

# The signature KPI: LTV:CAC

LTV:CAC is the ratio of customer lifetime value to the cost of acquiring that customer, and it is the number that defines whether the growth engine is healthy. A widely cited healthy target is about 3:1, with most profitable brands operating in the 3:1 to 5:1 band and a CAC payback under roughly 12 months. The critical nuance is that LTV must be computed on gross-margin dollars, not gross revenue, because a customer who buys $180 of product at a 40% margin is worth $72 of contribution, not $180. Compute it on margin, net of returns, or the ratio lies.

$$ \text{LTV:CAC} = \frac{\text{gross-margin LTV}}{\text{fully-loaded CAC}} $$

:::predict
prompt: A brand's gross-margin LTV is $180 and its fully-loaded CAC is $60. What is the LTV:CAC ratio?
answer: 3
tolerance: 0.05
unit: ratio (x:1)
hint: Divide lifetime value by acquisition cost.
explain: 180 / 60 = 3.0, a 3:1 ratio. That sits right at the healthy DTC benchmark, the brand is acquiring customers worth three times what they cost in margin terms.
:::

# Context decides what "good" means

A single ratio target is a trap, because "good" is context-dependent and must be read against absolute contribution dollars, not just the multiple. DTC commonly runs tighter than SaaS because ecommerce gross margins are roughly 40% to 60% versus SaaS at 70% to 85%, and subscription or replenishment categories (supplements, beauty refills, pet food) stabilize churn and earn higher ratios. A 2.5:1 in fashion at $200 AOV and 55% margin can beat a 4.5:1 in supplements at $35 AOV, because the absolute contribution per customer is far larger. Read the dollars, not only the ratio.

:::quiz
question: Why can a 2.5:1 LTV:CAC in fashion ($200 AOV, 55% margin) be healthier than a 4.5:1 in supplements ($35 AOV)?
- The fashion brand has a higher ratio
- The fashion customer generates more absolute contribution dollars despite the lower ratio
- Supplements always have worse retention
- The ratio is the only thing that matters
answer: 1
hint: A ratio is a multiple, not a dollar amount.
explain: A higher AOV and healthy margin mean each fashion customer throws off more absolute contribution, so a lower multiple can still beat a higher multiple on a tiny-basket product. The ratio alone hides the dollars per customer.
:::

# CAC, blended CAC, and the honest version

CAC is acquisition spend divided by new customers acquired, but the version leadership usually sees is blended CAC, total marketing spend across all channels divided by total new customers. Blended CAC is useful as a top-line check yet it hides channel-level inefficiency, because it folds cheap retargeting and brand-search recapture in with genuine prospecting. The honest version is new-customer or incremental CAC, computed once retargeting and brand search are stripped out, which is exactly what incrementality testing (covered later in this path) exists to recover. CAC has also risen materially: ecommerce CAC is up roughly 60% over five years and about 40% since 2023, with typical blended DTC CAC in the $50 to $100 range.

$$ \text{blended CAC} = \frac{\text{total marketing spend (all channels)}}{\text{total new customers}} $$

:::predict
prompt: A brand spends $50,000 across all channels in a month and acquires 800 new customers. What is blended CAC?
answer: 62.5
tolerance: 0.5
unit: USD
hint: Divide total spend by total new customers.
explain: 50,000 / 800 = 62.50, so blended CAC is $62.50, squarely inside the typical $50 to $100 DTC band. Note this number says nothing about which channel was efficient.
:::

:::widget barChart
title: 2026 ecommerce CAC by vertical
labels: Food & Bev, Beauty, Fashion/Apparel, Electronics, Jewelry
data: 53, 61, 66, 76, 91
unit: USD
:::

# The non-negotiable ecommerce twist: model returns

The detail that separates ecommerce from every other vertical is returns, and neither platform ROAS nor gross orders models them. Net revenue (gross revenue minus returns, refunds, and cancellations) drives CM2, and effective CAC rises when returned orders are stripped from the denominator. US shoppers were expected to return about 15.8% of merchandise in 2025 (around $849.9B), and apparel runs the highest at 20% to 40%, roughly 25% on average. A campaign that looks profitable on day one goes underwater two to four weeks later when the return wave lands, so re-gross CAC for the retained-customer count.

$$ \text{effective CAC} = \frac{\text{acquisition spend per gross customer}}{1 - \text{return rate}} $$

:::predict
prompt: Acquisition spend is $60 per gross new customer, but 25% of apparel orders are returned. What is the effective CAC per retained customer, to the nearest dollar?
answer: 80
tolerance: 1
unit: USD
hint: Only 75% of acquired customers are retained, so divide by 0.75.
explain: 60 / (1 - 0.25) = 60 / 0.75 = 80. A "profitable" $60 CAC is really an $80 CAC once a quarter of the orders come back, which can erase the contribution a healthy-looking ROAS implied.
:::

:::callout warning
The most repeated operator complaint in apparel: a campaign that is "profitable" on paper goes underwater two to four weeks later when the return wave lands, because leadership fixated on platform ROAS while the P&L bled. ROAS ignores COGS, shipping, and especially returns, so always compute CM2 on net revenue and re-gross CAC for the return rate before declaring a winner.
:::

# Contribution margin and the bid ceiling

Contribution margin is where the mandate becomes an actual bid. CM2 is net revenue minus COGS, minus shipping and fulfillment (including returns processing), minus variable selling cost including ad spend, and it is the floor your bidding cannot cross. Many brands now lose money on the first order and recoup only through repeat purchases, so the trader must align bid targets to the LTV horizon and payback window the CFO will actually fund: a 3-month payback implies a far lower bid ceiling than a 12-month one. A very high ratio above roughly 5:1 to 6:1 usually signals under-investment, not winning, and the right move is to scale until the ratio compresses toward target. Below, the curve shows how repeat purchases pull cumulative gross-margin value above CAC over the customer lifetime.

:::figure churnLtvCurve
caption: First-order contribution often sits below CAC; cumulative gross-margin LTV crosses the CAC line only as repeat purchases land, which is why the payback window the CFO funds sets the bid ceiling.
:::

:::predict
prompt: Effective CAC is $80 and a retained customer returns about $10 of contribution margin per month. What is the CAC payback period in months?
answer: 8
tolerance: 0.2
unit: months
hint: Divide CAC by the monthly contribution per customer.
explain: 80 / 10 = 8 months, comfortably under the roughly 12-month payback benchmark, so the LTV horizon supports this acquisition cost even though the first order alone does not cover it.
:::

:::quiz
question: A brand's LTV:CAC has climbed to 6.5:1 and held there for two quarters. What does this most likely indicate?
- The brand is winning and should hold spend flat
- The brand is under-investing in growth and leaving scale on the table
- The brand's returns are too high
- The CAC calculation must be wrong
answer: 1
hint: A ratio far above the 3:1 to 5:1 band is rarely a victory.
explain: Consistently above 5:1 to 6:1 usually means the brand is starving growth, not optimizing it. The trader should propose scaling spend until the ratio compresses back toward the 3:1 to 5:1 target, capturing contribution the brand is currently forgoing.
:::

:::sources
- Finsi, LTV:CAC Ratio Explained: What 3:1 Means and When It Lies | https://www.finsi.ai/blog/ltv-cac-ratio-explained/
- First Page Sage, Average CAC for eCommerce Companies: 2026 Edition | https://firstpagesage.com/reports/average-cac-for-ecommerce-companies/
- Mobiloud, Average Customer Acquisition Cost for Ecommerce | https://www.mobiloud.com/blog/average-customer-acquisition-cost-for-ecommerce
- Digital Commerce 360 / NRF, Consumers to return almost $850 billion in merchandise in 2025 | https://www.digitalcommerce360.com/2025/10/24/nrf-consumers-return-850-billion-merchandise-in-2025/
- Shopify, Ecommerce Returns: Average Return Rate and How to Reduce It | https://www.shopify.com/enterprise/blog/ecommerce-returns
- Saras Analytics, ROAS Is Not Profitability and Here Is What Contribution Margin Reveals | https://www.sarasanalytics.com/blog/roas-vs-contribution-margin-profitability-revealed
- AdExchanger, For Meta Marketers, Automation Isn't Always The Advantage | https://www.adexchanger.com/measurement/for-meta-marketers-automation-isnt-always-the-advantage-but-its-complicated/
:::
