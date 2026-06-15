---
id: sales-03
track: sales
module: 3
title: Yield and the value of inventory
summary: Measure fill rate and sell-through, set price floors that lift value without losing fill, and weigh the opportunity cost of every impression you sell cheap.
---
# Yield is revenue per opportunity

A publisher does not get paid for inventory it has, only for inventory it sells. Yield is the revenue you extract per ad opportunity, and yield management is the practice of pricing and allocating inventory to maximize total revenue, not any single metric.

The tension is constant. Sell everything cheaply and you fill the page but leave money on the table. Hold out for high prices and you lift your average but leave impressions empty. The goal is the combination of price and fill that maximizes the total.

:::predict
prompt: A publisher serves 4,000,000 impressions in a day and earns $14,000 in ad revenue. What is the realized yield per thousand opportunities (eCPM)?
answer: 3.5
unit: $
tolerance: 0.05
hint: Yield per thousand is total revenue divided by impressions, times 1000.
explain: eCPM = $14,000 / 4,000,000 x 1000 = $3.50. Yield management works to lift this number by pricing and allocating inventory, not by chasing fill or price alone.
:::

# Fill rate and sell-through

Fill rate is the share of ad requests that return a paid ad. If 1000 requests yield 850 served impressions, fill rate is 85 percent. The 150 unfilled requests earned nothing, a permanent loss because an impression expires the moment the page loads.

Sell-through is the share of available inventory that actually sells, often used for reserved or direct-sold campaigns. Low sell-through means you are creating more inventory than demand wants, which pushes prices down. High sell-through with rising prices is the signal that demand exceeds supply and you can raise floors.

:::callout insight
Every unfilled impression is gone forever. Inventory is perishable, which is why fill rate sits at the center of every yield decision.
:::

:::predict
prompt: A page sends 1,200,000 ad requests and 1,020,000 return a paid ad. What is the fill rate?
answer: 85
unit: %
hint: Fill rate is served impressions divided by ad requests, times 100.
explain: Fill rate = 1,020,000 / 1,200,000 x 100 = 85%. The 180,000 unfilled requests earned nothing and cannot be recovered, since an impression expires the moment the page loads.
:::

# Price floors

A price floor is the minimum CPM you will accept for an impression. Floors raise the value of inventory by forcing buyers to compete above a threshold, and dynamic floors adjust automatically by device, geography, time of day, and historical demand. A well-set floor captures more of what buyers are willing to pay.

But floors cut both ways. Set them too high and bids fall below the floor, the impression goes unfilled, and you lose the revenue entirely. The optimal floor is the one that maximizes price times fill, which is almost never the highest floor you could set.

$$ Yield = Fill_{rate} \times eCPM $$

:::callout warning
A floor that is too high trades real revenue for an empty impression. Optimize floors for total yield, price times fill, not for the highest CPM in isolation.
:::

:::predict
prompt: Floor A clears a $5.00 eCPM at a 90 percent fill rate. Floor B is raised to a $6.00 eCPM but fill drops to 70 percent. Which yield is higher, and by how much, expressed as floor A's total yield per thousand requests?
answer: 4.5
unit: $
tolerance: 0.05
hint: Total yield per thousand requests is eCPM times fill rate. Compute floor A.
explain: Floor A yields $5.00 x 0.90 = $4.50 per thousand requests, while floor B yields $6.00 x 0.70 = $4.20. The higher floor lifts CPM but loses enough fill to lower total yield, so floor A wins.
:::

# Opportunity cost

Selling an impression cheap has a hidden cost: the better-paying buyer who might have wanted it. When you commit inventory to a low guaranteed deal, you give up the chance to sell it into a higher open-market bid or a premium private deal later in the day.

Good yield management prices this opportunity cost in. Reserve premium inventory for buyers who pay for priority, route the rest to the open exchange, and let dynamic floors capture the gap between. The explorer below lets you move fill rate and floor and watch total yield respond.

:::widget yieldExplorer
:::

:::quiz
question: Why can setting a price floor too high reduce total revenue?
- Bids fall below the floor, the impression goes unfilled, and that revenue is lost forever
- High floors increase agency commission
- Floors only apply to direct-sold inventory
- A high floor automatically raises the click-through rate
answer: 0
explain: An impression is perishable. If every bid is below the floor, the impression clears at nothing and the revenue is gone, so floors must be optimized for price times fill.
:::

:::sources
- Publishers Guide to Advertising Yield Management, GeoEdge | https://www.geoedge.com/advertising-yield-management-and-optimization/
- Price Floor Optimization Guide for Publishers, HeaderBidding.co | https://headerbidding.co/price-floor-optimization/
:::
