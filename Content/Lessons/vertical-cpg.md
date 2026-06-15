---
id: vertical-cpg
track: cpg
module: 1
title: CPG: growth is a penetration problem
summary: How penetration times buying rate, adstock, and trade-versus-media tradeoffs drive consumer packaged goods, not clicks.
---
# CPG math is not click math

Consumer packaged goods are sub-$5 impulse units bought offline, often without a click anywhere in the path. That breaks the ecommerce reflex of optimizing to last-click ROAS. US CPG total ad spend was roughly $66B in 2025 (eMarketer via MediaPost), of which about $55B was digital, around 16.5% of the $302.77B US digital market, with growth moderating. The 2026 digital figure is forecast near $56.07B, up about 5.8% (eMarketer). The channel mix skews to display, around 57.9%, and to mobile, around 69.3%.

What makes CPG distinctive is where the money goes and how growth happens. Trade promotion spend, the discounts and allowances paid to retailers, typically runs 15 to 25% of gross sales and can reach 30% in grocery. That is often larger than the media budget, and a frequently cited Vividly figure puts the share of US trade promotions that fail to turn a profit near 72%. Treat that as a directional warning, not a precise law.

:::predict
prompt: Trade promotion runs at 20% of gross sales on a brand with $400,000,000 in gross sales, while its digital media budget is $55,000,000. How many times larger is the trade budget than the media budget?
answer: 1.45
unit: x
tolerance: 0.05
hint: Compute trade dollars as 20% of gross sales, then divide by the media budget.
explain: Trade spend = 0.20 x $400,000,000 = $80,000,000. Ratio = $80,000,000 / $55,000,000 = about 1.45x, which is why in CPG the trade ledger, not the media plan, often holds the larger lever.
:::

# Penetration times buying rate

The Ehrenberg-Bass tradition shows that brand growth comes mostly from acquiring more households, not from squeezing more loyalty out of existing ones. That inverts the ecommerce LTV mindset. Sales decompose cleanly:

$$ Sales = (Households \times Penetration\%) \times Buying\ Rate $$

Buying rate is purchase frequency times size per buyer. Market share splits the same way, into a penetration-share component and a buying-rate-share component:

$$ Share = Penetration\_share \times BuyingRate\_share $$

The lever that usually moves the needle is penetration, which is why CPG buys broad reach on CTV and linear rather than narrow retargeting.

:::callout insight
For most CPG brands, growth is a penetration problem. Reaching more households beats deepening loyalty among the few you already have. Buy reach, then convert intent, then promote, in that order.
:::

:::predict
prompt: A snack brand reaches a market of 120 million households, has 8% household penetration, and each buyer spends $24 per year. What is the annual sales figure?
answer: 230400000
unit: $
tolerance: 1000
hint: Multiply households by penetration to get buyers, then multiply by the buying rate per buyer.
explain: Buyers = 120,000,000 x 0.08 = 9,600,000. Sales = 9,600,000 x $24 = $230,400,000.
:::

:::predict
prompt: A brand holds a 20% share of category penetration and a 25% share of category buying rate. What is its market share?
answer: 5
unit: %
hint: Market share is the penetration-share component times the buying-rate-share component.
explain: Share = 0.20 x 0.25 = 0.05, or 5%. Note that exact penetration and buying-rate values are brand and category specific, so treat these as tunable inputs.
:::

# Adstock and saturation

Advertising does not spend its effect in a single week. Adstock models the carryover: this week's effective exposure is this week's spend plus a decayed fraction of last week's adstock.

$$ AdStock_t = Spend_t + \lambda \times AdStock_{t-1} $$

The carryover rate lambda sits between 0 and 1. A higher lambda means the effect lingers longer. On top of carryover, each channel saturates: doubling spend never doubles incremental sales, so response curves bend over via a Hill or log shape. Marketing mix modeling, the gold standard for offline-heavy CPG, fits these curves econometrically to separate base sales from incremental sales channel by channel.

:::widget adstockExplorer
:::

:::predict
prompt: A channel has an adstock carryover rate lambda of 0.5. Last week's adstock was 80 units and this week's media spend delivers 100 units of fresh exposure. What is this week's adstock?
answer: 140
tolerance: 0.5
hint: Add this week's fresh exposure to lambda times last week's adstock.
explain: AdStock = 100 + 0.5 x 80 = 100 + 40 = 140 units of effective exposure.
:::

# Trade versus media

The hardest CPG decision is splitting budget between trade promotion and media. Trade promotion ROI compares the incremental gross profit a promotion generated against the trade dollars it cost.

$$ Trade\ Promo\ ROI = \frac{Incremental\ Gross\ Profit}{Trade\ Spend} $$

A ratio below 1.0x means the promotion destroyed value, which is exactly why so many promotions fail to pay back. Media, meanwhile, is judged on marginal ROI, the incremental gross profit per extra dollar of spend along the saturation curve. The discipline is to fund penetration-building reach until saturation caps it, then let trade and conversion media carry the rest.

:::predict
prompt: A promotion costs $1,500,000 in trade spend and generates $1,200,000 in incremental gross profit. What is the trade promotion ROI?
answer: 0.8
unit: x
tolerance: 0.02
hint: Divide incremental gross profit by trade spend.
explain: Trade Promo ROI = $1,200,000 / $1,500,000 = 0.8x. Below 1.0x means the promotion lost money, a common outcome in CPG.
:::

:::quiz
question: A CPG brand wants to grow share and is deciding where to put incremental budget. Which approach best matches how CPG growth actually works?
- Buy broad reach to lift household penetration, the dominant growth lever for most brands
- Pour the budget into loyalty retargeting of existing buyers
- Maximize last-click ROAS on branded search
- Shift all spend into deep trade promotions regardless of profitability
hint: Recall the Ehrenberg-Bass finding about where brand growth comes from.
answer: 0
explain: Growth in CPG comes mostly from acquiring more households, so lifting penetration through broad reach usually beats loyalty tactics. Saturation eventually caps reach spend, and unprofitable trade promotions destroy value.
:::

:::sources
- CPG Digital Ad Spend to Slow After Two Boom Years, eMarketer | https://www.emarketer.com/content/cpg-digital-ad-spend-slow-after-two-boom-years
- CPG Ad Spending to Moderate in 2025, MediaPost | https://www.mediapost.com/publications/article/400196/cpg-ad-spending-to-moderate-in-2025.html
- Trade Spend: How Retailers and Suppliers Share Promotional Costs, SupplierWiki | https://supplierwiki.supplypike.com/articles/trade-spend-how-retailers-and-suppliers-share-promotional-costs
:::
