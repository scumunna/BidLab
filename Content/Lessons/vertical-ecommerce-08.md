---
id: vertical-ecommerce-08
track: vertical-ecommerce
module: 8
title: Catalog Gates and Search-Term Hygiene, Buy-Box, Out-of-Stock Suppression, and Negatives
summary: You will learn to gate ads on buy-box and inventory status, quantify the budget a stockout silently burns, and run the search-term harvest and negative-keyword loop that keeps spend on converting queries.
---
# The two gates that decide whether a click can convert

Before any bid math matters, two catalog gates decide whether an ad can even work, and both live outside the campaign console where most traders look. The first is buy-box (Featured Offer) ownership: the Featured Offer drives roughly 83% of Amazon sales, so if you advertise an ASIN you do not own the buy box on, the click lands on a page with no easy Add to Cart and the spend is gone. The second is inventory: Amazon does not auto-pause Sponsored Products during a stockout, so ads keep serving, budget keeps spending, almost nothing converts, and the lost velocity quietly drops organic rank too. These two gates are the single most-cited operator pain point in the vertical because every dashboard upstream can look fine while budget bleeds.

:::callout key
A click can only convert if three things are true at once: the ASIN is in stock, you own the buy box, and the listing is not suppressed. Auction wins and a low ACoS mean nothing if any of the three is false. Gate the ads on catalog state first, then optimize bids.
:::

:::quiz
question: Which of these problems will the campaign console most likely fail to surface on its own, letting budget burn while the dashboard looks fine?
- A bid set above the margin-derived ceiling
- A best-seller going out of stock while ads keep serving
- A daily budget that is too low to spend in full
- A keyword with a very low click-through rate
answer: 1
hint: Think about which failure lives in the catalog, not in the campaign settings.
explain: A stockout (and a lost buy box) lives in the catalog, so the campaign UI keeps reporting normal spend and impressions while clicks stop converting. The other three are visible directly in the console as bid, budget, and CTR figures the trader can read off the screen.
:::

# The buy-box gate: paying for clicks to a dead page

If a competing third-party seller takes the Featured Offer, or a price-parity flag or availability issue suppresses it, your ad still wins the auction and still charges you per click, but the destination page no longer has the one-tap purchase path that converts. Because the Featured Offer drives about 83% of sales, losing it while you keep advertising puts roughly that share of conversion at risk on every click you pay for. The trap is that this is often a merchandising or pricing problem wearing an advertising costume: the trader sees ACoS spike and reaches for bids when the real fix is reclaiming the buy box.

We can size the bleed directly. If a campaign sends $C$ clicks per day to an ASIN, the buy-box conversion gap is $g$ (the drop in conversion rate when you lose the Featured Offer), and AOV is $A$, then daily value lost is:

$$ \text{buy-box loss} = C \times g \times A $$

:::predict
prompt: A campaign sends 500 clicks/day to an ASIN at $40 AOV. Losing the buy box drops conversion by 8 percentage points (the buy-box conversion gap). What daily sales value is lost?
answer: 1600
tolerance: 1
unit: USD
hint: Multiply clicks by the conversion gap (as a decimal) by AOV.
explain: 500 clicks x 0.08 gap x $40 AOV = $1,600 of sales value lost every day the buy box is gone, while you still pay for all 500 clicks. That is the cost of treating a merchandising problem as a bidding problem.
:::

# The out-of-stock gate: the most expensive repeated mistake

Amazon will not pause your Sponsored Products when an ASIN goes out of stock, so the ads run, the clicks come, and they convert at near zero because shoppers cannot buy. Worse, an out-of-stock product is ineligible to win the Buy Box, so the two gates compound, and the missing sales velocity feeds Amazon's A9 ranking a weak signal that drops the listing's organic position even after restock. Operators consistently rank "ads kept spending while we were out of stock" as their most expensive, most repeated error, and the only durable fix is inventory-aware automation that pauses or throttles ads as days-of-cover run low.

The wasted spend is easy to estimate. With daily ad spend $S$, days out of stock $d$, and a residual (near-zero) conversion rate, the budget burned is approximately:

$$ \text{wasted stockout spend} = S \times d \times (1 - r) $$

where $r$ is the residual conversion fraction (close to 0 during a true stockout, so the waste is close to the full $S \times d$).

:::predict
prompt: A Sponsored Products campaign spends $400/day and a best-seller is out of stock for 5 days with near-zero conversion. Roughly how much spend is wasted?
answer: 2000
tolerance: 1
unit: USD
hint: Daily spend times days out of stock, with residual conversion near zero.
explain: $400/day x 5 days x (1 - 0) = $2,000 burned with almost nothing to show for it, before you even count the organic-rank damage from the lost velocity. This is why a stock-check cadence or inventory-aware tool is non-negotiable hygiene.
:::

:::figure discrepancyWaterfall
caption: A catalog-gate waterfall. Start from the sales a fully-stocked, buy-box-owning ASIN would convert, then subtract what is lost when the buy box flips to a competitor and again when the item goes out of stock while ads keep spending. Each step is silent in the campaign UI.
:::

# A stockout drags the P&L number that actually matters

The catalog gates are not just a campaign-efficiency story, they hit MER (Marketing Efficiency Ratio = total revenue / total ad spend), the blended, platform-agnostic number the buy-side defends to the CFO. When a best-seller stocks out, ad spend continues but the revenue it would have driven (ad-attributed and the organic sales the listing was carrying) disappears, so the numerator falls while the denominator holds, and MER sags through no fault of the bidding. The trader who only watches ACoS misses this entirely, because ACoS is computed on ad-attributed sales alone.

:::predict
prompt: A brand runs at $480,000 total revenue on $120,000 total ad spend. A multi-day stockout cuts total revenue by 10% while ad spend holds flat. What is the new MER (x), to one decimal?
answer: 3.6
tolerance: 0.05
unit: ratio (x)
hint: Cut revenue by 10%, keep spend the same, then divide revenue by spend.
explain: Revenue falls to $480,000 x 0.90 = $432,000; spend stays $120,000; MER = 432,000 / 120,000 = 3.6x, down from the prior 480,000 / 120,000 = 4.0x. The stockout shaved 0.4x off the blended efficiency number leadership actually tracks.
:::

:::widget barChart
title: Conversion outcome by catalog-gate state (indexed to buy-box owned)
labels: Buy box owned, Buy box lost, Out of stock
data: 100, 18, 5
unit: index
:::

# Search-term hygiene: harvest the winners, negate the leaks

Once the gates are clean, the daily craft is search-term hygiene. Auto and broad campaigns surface raw search terms; the trader harvests the converting ones into exact-match (and discrete keyword or ASIN targets) for tighter bid control, and adds negative keywords and negative ASINs plus placement exclusions to stop irrelevant or unprofitable traffic from draining the budget. The harvest rate is the share of surfaced terms worth promoting:

$$ \text{harvest rate} = \frac{\text{converting terms promoted to exact}}{\text{total terms surfaced}} $$

This loop runs continuously, because a single unmanaged broad-match term can quietly eat a daily budget while every upstream metric still looks acceptable.

:::predict
prompt: A discovery campaign surfaces 300 search terms over a flight; 45 convert well enough to promote to exact-match. What is the harvest rate?
answer: 15
tolerance: 0.5
unit: %
hint: Divide promoted converting terms by total terms surfaced.
explain: 45 / 300 = 0.15, a 15% harvest rate. The other 255 terms are candidates for negatives or for leaving in discovery, the point is that you mine the winners out and fence off the leaks rather than letting broad match spend untracked.
:::

:::quiz
question: A broad-match term has spent $90 across the flight with zero orders and is clearly irrelevant to the product. What is the correct hygiene action?
- Raise its bid to give it more volume to convert
- Add it as a negative keyword to stop the spend
- Promote it to exact-match to control it
- Pause the entire ad group it sits in
answer: 1
hint: The term is irrelevant and converting nothing; you want to stop the leak without touching good traffic.
explain: A negative keyword stops the wasted spend on that specific irrelevant query without disturbing the rest of the ad group. Raising the bid or promoting it funds a term that does not convert, and pausing the whole ad group throws out the converting traffic with the leak.
:::

# Don't over-negate: starving your own discovery

Negatives are a scalpel, not a firehose. Over-aggressive negative keywords suffocate the auto and broad campaigns that surface new converting terms, starving the very harvest that feeds your exact-match structure, so negatives need periodic pruning, not just endless adding. The discipline is to negate terms that are proven irrelevant or unprofitable while leaving enough discovery surface for new winners to appear, and to revisit the negative list as the catalog, seasonality, and competitive set shift.

:::callout warning
The most expensive, most repeated mistake operators report in this vertical: ads kept spending while the ASIN was out of stock, often discovered only from a sudden ACoS spike rather than any alert, because Amazon will not auto-pause Sponsored Products on an out-of-stock or buy-box-lost ASIN. Forums are full of sellers who lost the buy box for hours and found out from a billing surprise, forcing third-party tools or scripts to do the obvious inventory and buy-box gating Amazon should do natively. Build the stock-check and buy-box monitor before you scale spend, not after the first wasted-budget post-mortem.
:::

:::quiz
question: Sales on a previously healthy ASIN suddenly crater and ACoS spikes, but bids, budgets, and targeting are unchanged. What should the trader check first?
- Whether buy-box ownership or in-stock status changed
- Whether to lower the target ACoS
- Whether to add more keywords
- Whether the conversion pixel is double-counting
answer: 0
hint: Bids and targeting are unchanged, so the cause is probably not in the campaign settings at all.
explain: When campaign settings are unchanged but performance collapses, the catalog gates are the first suspects: a lost buy box or a stockout sends paid clicks to a page that cannot convert. Pixel dedup matters elsewhere, but it would not produce a sudden ACoS spike tied to a specific ASIN.
:::

:::sources
- Aura, Suppressed Buy Box: Why It Happens and How to Fix It (Featured Offer drives ~83% of Amazon sales) | https://goaura.com/blog/suppressed-buy-box
- Carbon6, Inventory-Aware Amazon PPC: Stop Wasting Ad Spend on Low-Stock Products (Amazon does not auto-pause SP during stockouts) | https://www.carbon6.io/blog/inventory-aware-amazon-ppc-reduce-wasted-ad-spend/
- Advertising Spire, Advertising During Amazon Inventory and Out-of-Stock Situations | https://advertisingspire.com/amazon-inventory-out-of-stock/
- SalesDuo, Amazon Advertising Benchmarks 2026 (ACoS, CPC, CTR and conversion benchmarks) | https://salesduo.com/blog/amazon-advertising-benchmarks/
- Perpetua, Amazon Total ACoS (TACoS): Introduction to a Key Ad Metric (flywheel logic, bulk ops tooling) | https://perpetua.io/blog-amazon-tacos/
- Stella, How to Conduct an Incrementality Study on Meta ASC Campaigns (buy-side scorecard: contribution margin, blended CAC, MER) | https://www.stellaheystella.com/blog/how-to-conduct-an-incrementality-study-on-metas-asc-campaigns-advantage-shopping-campaigns
:::
