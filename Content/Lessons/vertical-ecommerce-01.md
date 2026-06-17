---
id: vertical-ecommerce-01
track: vertical-ecommerce
module: 1
title: The Money Map: Retail Media, Open Web, and the Ecommerce Programmatic Landscape
summary: Map where Ecommerce ad dollars actually flow, name the three buying layers you will sit in, and tell share-of-total apart from share-of-growth so you can read a forecast without being fooled.
---
# Where the money actually flows

Before you touch a bid, you need a map of the rooms you buy in, because in Ecommerce the spend is wildly concentrated. US retail media reaches about $69.32B in 2026, up from $58.79B in 2025, which makes it the fastest-growing major channel, and inside that pool one seller dwarfs the rest. The job is not to memorize a pie chart, it is to know which auction, which identity graph, and which closed-loop report each dollar lands in, because every one of them means something different.

The first reflex of a good trader is to ask what a number is a share *of*. A market-share stat, a growth stat, and an offsite-mix stat can all use the same brand name and tell three different stories, and conflating them is how junior buyers get a strategy deck wrong.

:::widget donutChart
title: 2025 US retail media share by network (% of total)
labels: Amazon Ads, Walmart Connect, Target Roundel, All other RMNs
data: 79.7, 8.0, 1.5, 10.8
unit: %
:::

# The three layers you buy across

The stack splits into three layers, and you will have a seat in all of them. Layer one is onsite retail media, bought inside the retailer's own console: Amazon Sponsored Products, Brands, and Display, plus Walmart Connect and Target Roundel (Roundel runs through Criteo and CitrusAd). Layer two is retail-media offsite, where a retailer's first-party audience is activated across the open web and CTV through a DSP, Amazon DSP for Amazon, Walmart's Trade Desk and expanded-DSP integration, and Roundel's links to The Trade Desk and DV360. Layer three is open-web direct response (Meta, Google Shopping and Performance Max, The Trade Desk, DV360) for prospecting and retargeting.

Offsite is its own growth story. US offsite retail media reached $13.52B in 2025, up 27.1% year over year, with social taking roughly half of offsite spend, and retail-media CTV is the fastest-growing slice at about 45.5% in 2025, roughly three times the pace of retail-media search.

:::figure retailMediaFlow
caption: The three layers a trader stitches together. Onsite RMN inventory is bought in the retailer console, offsite activates that same first-party audience across the open web and CTV through a DSP, and open-web DR runs prospecting and retargeting on Meta, Google, and independent DSPs.
:::

:::quiz
question: A planner says "buy the Walmart audience in the console." Which layer is that, and what is the giveaway?
- Open-web DR, because Walmart sells through The Trade Desk
- Retail-media offsite, because any DSP activation is offsite
- Onsite retail media, because "in the console" means the retailer's own surface
- It cannot be determined from the description
answer: 2
hint: The distinguishing word is where the buy is placed, not whose audience it is.
explain: Buying "in the console" on the retailer's own surface is onsite retail media. The same Walmart first-party audience activated through a DSP across the open web or CTV would be offsite, which is a different auction and a different CPM, so the location of the buy, not the owner of the audience, sets the layer.
:::

# Share-of-total versus share-of-growth

This is the distinction that separates a trader who can read a forecast from one who cannot. Amazon's roughly 79.7% is a share-of-total figure: of every retail-media dollar spent in 2025, about 80 cents went to Amazon. The "Amazon plus Walmart take about 89%" figure is a different animal entirely, it is share of net-new, or incremental, dollars only. In 2026 the two of them capture $9.42B of the $10.53B in incremental spend, which is the growth, not the base.

Presenting that 89% as if it were a market-share number is a common and misleading error, and you will see it in vendor decks. The math itself is simple, but the *labeling* is the skill: a share-of-growth number describes where the next dollar goes, a share-of-total number describes where the whole pool already sits.

:::predict
prompt: US retail media grows from $58.79B in 2025 to $69.32B in 2026. What is the year-over-year growth rate, to the nearest whole percent?
answer: 18
tolerance: 0.5
unit: %
hint: Subtract last year from this year, then divide by last year.
explain: 69.32 - 58.79 = 10.53, the net-new pool for 2026. Then 10.53 / 58.79 = 0.1791, about 18 percent. EMARKETER rounds the 2026 headline to roughly $69.3B, so the incremental pool is the same $10.53B the share-of-growth split below divides into. This is a growth rate on the total pool, distinct from any single network's share of that growth.
:::

:::predict
prompt: Amazon and Walmart capture $9.42B of the $10.53B in net-new US retail-media dollars in 2026. What share of incremental spend is that, to the nearest whole percent?
answer: 89
tolerance: 0.5
unit: %
hint: Divide the two players' incremental dollars by total incremental dollars.
explain: 9.42 / 10.53 = 0.8946, about 89 percent. This $10.53B is the same net-new pool you got by subtracting 2025 from 2026 above, so the two predicts use one consistent increment. It is share of net-new dollars, not market share, so do not report it as "Amazon and Walmart are 89 percent of retail media." The share-of-total picture is roughly 79.7 percent Amazon plus 8.0 percent Walmart, about 88 percent combined, a near coincidence that makes the mislabel even easier to make.
:::

# The walled-garden tax: every RMN is its own universe

Each retail media network is a closed loop. Spend, targeting, and reporting all live inside the retailer's walled garden, which means you cannot compare them straight across without normalizing. Amazon RoAS and Walmart ROAS use different attribution windows and different onsite-versus-offsite scopes, so the same campaign "performance" can read higher or lower purely from definitions. Operators describe this as every network living in its own universe, and they burn real hours figuring out which platform to blame for a weak result.

The structural recent change to know: Walmart ended its Trade Desk exclusivity, so the same Walmart audience can now be bought through multiple DSPs. That creates overlap and cross-DSP deduplication problems you will manage with frequency caps and suppression, the same user bought twice is wasted spend and inflated frequency.

:::quiz
question: A brand manager lines up Amazon's reported 6.0 RoAS against Walmart's reported 4.0 ROAS and concludes Amazon is the stronger channel. What is the core flaw in that straight comparison?
- Nothing is wrong, a higher RoAS always means a more efficient channel
- The two numbers use different attribution windows and onsite-versus-offsite scopes, so they are not measuring the same thing
- ROAS is only valid for Walmart, Amazon should be judged on ACoS only
- Walmart numbers are estimates while Amazon numbers are exact, so only Amazon counts
answer: 1
hint: Each network is a closed loop, so ask what definition sits behind each reported number before you rank them.
explain: Every RMN is its own walled garden with its own attribution window and its own onsite-versus-offsite scope, so a 6.0 on Amazon and a 4.0 on Walmart are not the same metric measured two ways. Before ranking channels you normalize the definitions (match the window, separate onsite from offsite), otherwise you are comparing two different rulers and the "winner" is an artifact of measurement, not media.
:::

:::callout warning
The single most-cited operator complaint in this vertical is trust: the ANA's Q2 2025 Programmatic Transparency Benchmark found about $26.8B of programmatic media value still wasted annually, up roughly 34% in two years from about $20.0B in June 2023. Brands call retail media "a puzzle where someone keeps changing the rules" as consoles and reporting shift, so when you scrutinize an offsite buy, assume waste until the supply path proves clean.
:::

# Reading the offsite growth curve

Onsite and offsite are not the same buy, and you must split your reporting between them rather than blend. Onsite placements are premium and expensive (top-of-search on Amazon competes for the most valuable real estate). Offsite extends the retailer's first-party audience to the open web and CTV at far lower CPMs, so a blended number hides which engine is actually driving efficiency. The growth is lopsided toward offsite and especially toward CTV, which is where you should expect your offsite budget mix to shift over the next two years.

The headline rates are worth holding in your head as a planning anchor: offsite as a whole grew 27.1% in 2025, while retail-media CTV grew about 45.5%, roughly three times the pace of retail-media search, and projections put about one in five CTV dollars going to retail media by 2027.

:::widget barChart
title: 2025 US retail-media offsite growth by slice (YoY %)
labels: Offsite overall, Retail-media search, Retail-media CTV
data: 27.1, 15.2, 45.5
unit: %
:::

:::quiz
question: Why must a trader report onsite and offsite retail media separately instead of blending them into one ROAS?
- Because onsite is always more incremental than offsite
- Because they are different auctions at very different CPMs, so a blend hides which engine drives efficiency
- Because offsite is not measurable
- Because Amazon forbids blending in its terms
answer: 1
hint: Think about what a single averaged number conceals when the two inputs have very different prices.
explain: Onsite and offsite are different auctions with very different CPMs (premium onsite placements versus cheaper open-web and CTV reach). Blending them into one ROAS averages away the signal you need to allocate budget, so you split the reporting to see which layer is actually carrying the result.
:::

# Where you sit and what you are really stitching

Pulling the map together: your daily job is to stitch walled-garden RMNs to open-web DSPs, each with its own auction, its own identity graph, and its own closed-loop report. On a typical Ecommerce stack roughly 75 to 80% of the spend is Amazon, so most of your hours go to onsite Amazon plus Amazon DSP, but the fastest growth and the trickiest measurement live offsite. The map matters because it tells you which lever exists where: a console bid on Amazon, a DSP bid strategy offsite, a Performance Max target on the open web.

To make the concentration concrete, size the leader. If Amazon holds about 79.7% of a $69.32B market, you can estimate its retail-media revenue and see why "the stack is mostly Amazon" is not an exaggeration.

:::predict
prompt: If Amazon Ads holds about 79.7% of a $69.32B US retail media market in 2026, what is Amazon's approximate retail-media revenue, in USD billions?
answer: 55
tolerance: 1.5
unit: USD billions
hint: Multiply the share by the total market.
explain: 0.797 * 69.32 = 55.25, about $55B. That single number is larger than the entire rest of US retail media combined, which is why a trader's craft is weighted heavily toward Amazon mechanics even though the open web is where the measurement fights happen.
:::

:::sources
- EMARKETER, FAQ on Retail Media Networks: How Marketers Should Allocate Budgets in 2026 | https://www.emarketer.com/content/faq-on-retail-media-networks-how-marketers-should-allocate-budgets-2026
- EMARKETER, Retail Media Ad Spending Forecast and Trends H2 2025 | https://www.emarketer.com/content/retail-media-ad-spending-forecast-trends-h2-2025
- EMARKETER, Off-Site Retail Media Ad Spend Growing Much Faster Than On-Site | https://www.emarketer.com/content/off-site-retail-media-ad-spend-growing-much-faster-than-on-site
- ANA, Q2 2025 Programmatic Transparency Benchmark Report | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
- SalesDuo, Amazon Advertising Benchmarks 2026 | https://salesduo.com/blog/amazon-advertising-benchmarks/
- Perpetua, Amazon Total ACoS (TACoS): Introduction to a Key Ad Metric | https://perpetua.io/blog-amazon-tacos/
- EMARKETER, FAQ on Commerce Media: How to Capitalize on Growth Beyond Retail | https://www.emarketer.com/content/faq-on-commerce-media-how-capitalize-on-growth-beyond-retail
:::
