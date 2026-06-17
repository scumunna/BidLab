---
id: vertical-dtc-07
track: vertical-dtc
module: 7
title: "Incrementality: Geo and Conversion-Lift Holdouts vs Demand-Harvesting"
summary: Measure whether your ads actually caused sales by running geo and conversion-lift holdouts, compute incremental ROAS, and reallocate budget away from demand-harvesting line items that flatter last-click but add little.
---
# Platform ROAS answers the wrong question

Platform-attributed ROAS tells you that Meta (or TikTok, or Amazon) touched a converter at some point before the purchase. It does not tell you whether that person would have bought anyway. Those are two different questions, and the gap between them is where DTC budgets quietly leak: a retargeting line item can post a glorious 8x in Ads Manager while adding almost nothing to total Shopify revenue, because it is collecting credit for buyers who were already on their way to checkout.

Incrementality is the discipline that answers the second question. The trader withholds ads from a control group, watches what that group does anyway, and treats the difference as the only revenue the ads truly caused. Everything in this lesson sits on one number, incremental ROAS, and one decision, where to move the next dollar.

:::callout key
The whole job here is separating demand CREATION from demand HARVESTING. Prospecting and upper-funnel social create intent that did not exist. Retargeting and branded search harvest intent that already existed. Both look great on last-click; only one of them is actually growing the business.
:::

:::quiz
question: Which line correctly sorts demand CREATION from demand HARVESTING for a DTC account?
- Branded search and retargeting create demand; prospecting social harvests it
- Prospecting and upper-funnel social create demand; retargeting and branded search harvest it
- All paid channels create demand equally; only organic harvests it
- Whichever channel posts the highest last-click ROAS is the one creating demand
answer: 1
hint: Which channels reach people who did not already know or want the brand?
explain: Prospecting and upper-funnel social reach people who had no existing intent, so they create demand. Retargeting and branded search intercept people who were already shopping or already typing the brand name, so they harvest demand that existed. Last-click flatters the harvesters because they sit closest to the checkout, which is exactly the trap incrementality exists to catch.
:::

# Incremental ROAS is the scoreboard

The core metric is incremental ROAS (iROAS), the revenue the ads caused divided by the spend that caused it. You get the numerator from a holdout: run the campaign for an exposed group, withhold it from a matched control group, and the lift between them is the incremental revenue. A shortcut version, used when you already trust platform ROAS but want to discount it, is to multiply platform ROAS by the share of conversions a holdout proved incremental.

$$ \text{iROAS} = \frac{\text{incremental revenue}}{\text{incremental spend}} $$

So a channel posting platform ROAS of 4.0x where only 30 percent of its conversions survive a holdout is really running $4.0 \times 0.30 = 1.2$x. That is barely above the 1.0x breakeven line, and once you subtract contribution margin it may be losing money on every incremental dollar. The number that looked like a winner in the dashboard is a rounding error in the bank account.

:::predict
prompt: A channel reports platform ROAS of 4.0x, but a conversion-lift holdout shows only 30% of those conversions are incremental. What is the approximate iROAS?
answer: 1.2
tolerance: 0.05
unit: x
hint: Discount the platform ROAS by the incremental share.
explain: iROAS = platform ROAS x incremental share = 4.0 x 0.30 = 1.2x. The ads truly caused only 1.2 dollars of revenue per dollar spent, not 4.0, so most of that headline ROAS was demand the brand would have captured anyway.
:::

:::predict
prompt: A prospecting campaign spends $20,000 and platform-reports $80,000 in revenue (4.0x). A geo holdout shows 35% of that revenue is incremental. What is the iROAS?
answer: 1.4
tolerance: 0.05
unit: x
hint: First compute incremental revenue, then divide by spend.
explain: Incremental revenue = 80,000 x 0.35 = 28,000. iROAS = 28,000 / 20,000 = 1.4x. Even at a healthy 35% incremental share, a 4.0x platform line lands at 1.4x once you measure what it actually caused.
:::

# Conversion-lift and audience holdouts

The first method is a conversion-lift or audience holdout: randomly withhold ads from a slice of the addressable audience, then compare conversion rates between the exposed group and the held-out control. Because assignment is random, the only systematic difference between the two groups is the ads, so the difference in their conversion rates is the lift. Holdouts commonly run from 5 to 20 percent of the audience, and a 10 to 20 percent holdout gives a stronger, less noisy signal than a thin 5 percent slice.

The cleanest expression of the result is the incrementality percentage, the share of exposed conversions that would not have happened without the ads.

$$ \text{Incrementality \%} = \frac{\text{exposed conv. rate} - \text{control conv. rate}}{\text{exposed conv. rate}} $$

If the exposed group converts at 1.5 percent and the holdout converts at 0.5 percent on its own, then $(1.5 - 0.5) / 1.5 = 0.667$, so two-thirds of the exposed conversions were genuinely caused by the ads and one-third would have happened anyway. You then multiply your attributed conversions by that percentage to get the honest incremental count.

:::predict
prompt: A conversion-lift test: the exposed group converts at 1.5%, the holdout at 0.5%. What is the incrementality % of the exposed conversions?
answer: 67
tolerance: 1
unit: %
hint: The baseline conversion rate is what the control group did with no ads.
explain: (1.5% - 0.5%) / 1.5% = 1.0 / 1.5 = 0.667, about 67%. The 0.5% baseline is demand that would have converted regardless, so only 67% of exposed conversions are incremental.
:::

:::predict
prompt: Meta attributes 1,000 Purchases to a campaign, but the holdout above proves only 67% are incremental. How many of the attributed Purchases are TRUE incremental conversions?
answer: 670
tolerance: 5
unit: conversions
hint: Multiply attributed conversions by the incrementality percentage.
explain: True incremental conversions = attributed conversions x incrementality % = 1,000 x 0.67 = 670. The other 330 were demand the brand would have captured without spending on this campaign.
:::

:::quiz
question: In a conversion-lift holdout, what does the control group's own conversion rate represent?
- The fraction of ads that were wasted on bots
- The baseline demand that would have converted with no ads at all
- The platform's over-reporting error from broken dedup
- The creative fatigue rate of the exposed group
answer: 1
hint: The control group never saw the ads, yet some of them still buy.
explain: The control group is withheld from the ads entirely, so whatever it converts at is the baseline demand that exists without spend. Subtracting that baseline from the exposed rate is exactly what isolates the lift the ads actually caused.
:::

# Geo holdouts catch the demand the user-level test misses

The second method is a geo holdout: match 10 to 20 market pairs that behave alike, keep ads ON in the test markets, turn them OFF in the control markets, and compare total sales across a clean baseline window of several weeks. Geo tests measure at the market level rather than the user level, which is the whole point, because they capture upstream demand creation that a user-level conversion-lift test cannot see. When an upper-funnel ad makes someone aware of the brand and they later convert through organic search or direct, a user-level test may never connect that path, but the geo test sees the whole market lift.

This is exactly why CTV and broad prospecting need geo holdouts rather than last-click reads. They create demand that surfaces through other channels, so user-level attribution systematically undercounts them while last-click systematically overcounts the retargeting and branded search that harvested the resulting intent.

:::figure geoHoldout
caption: A geo holdout keeps ads on in test markets and off in matched control markets, then reads the sales gap as incremental. Because it measures at the market level, it captures brand and halo demand that surfaces through organic and direct, which a user-level conversion-lift test would miss.
:::

:::quiz
question: Why does a geo holdout often reveal MORE incrementality for CTV and broad prospecting than a user-level conversion-lift test does?
- Geo tests have larger budgets so they detect smaller effects
- Geo tests exclude returning customers from the count
- Geo tests measure market-level sales and capture demand that converts later through organic or direct
- Geo tests run longer so creative fatigue is averaged out
answer: 2
hint: Think about where demand-creation channels show up after they create the demand.
explain: Demand-creation channels make people aware and they convert later through organic, direct, or branded search, which a user-level test cannot stitch together. A geo holdout reads total market sales, so it captures that downstream halo and credits the channel that actually moved the baseline.
:::

# The 225-test reality: harvesting hides in plain sight

Stella's 2025 DTC Digital Advertising Incrementality Benchmarks make the harvesting problem concrete. Across 225 geo-based tests run from August 2024 to December 2025, the full-portfolio median iROAS landed at 2.31x, a respectable number across all channels (interquartile range 1.36x to 3.24x, with 88.4 percent of tests reaching statistical significance). The two ends of that distribution are the whole lesson. CTV bought through Tatari posted the HIGHEST median iROAS of any channel at 3.30x, leading the portfolio, exactly the demand-creation behavior a geo holdout is built to reward. Branded search posted the LOWEST at just 0.70x, below the 1.0x breakeven line, despite branded search routinely showing some of the prettiest last-click ROAS in the account. People searching your brand name were already going to buy; the ad just intercepted the click and took the credit.

The trader uses this to reallocate, not to gut spend at random. Defunding demand-harvesting line items that score below breakeven on iROAS often holds total revenue flat at lower spend, freeing budget for the prospecting and upper-funnel channels that genuinely move the baseline. The chart below is the portfolio picture: notice how the demand-creation channels (CTV, Meta) sit above the 2.31x median while the harvester (branded search) sits at the bottom, even though branded search is the one that looks best on last-click.

:::widget barChart
title: Median iROAS by channel, Stella 225-test DTC benchmark
labels: Branded search, TikTok, Portfolio median, Meta, Tatari CTV
data: 0.70, 0.94, 2.31, 2.92, 3.30
unit: x iROAS
:::

:::predict
prompt: Branded search runs at $5,000/mo with a median iROAS of 0.70x. If you reallocate that budget to CTV at a 3.30x iROAS, what is the gain in incremental revenue per month?
answer: 13000
tolerance: 50
unit: USD/month
hint: Compute incremental revenue at each iROAS on the same $5,000, then take the difference.
explain: CTV incremental revenue = 5,000 x 3.30 = 16,500. Branded-search incremental revenue = 5,000 x 0.70 = 3,500. The gain = 16,500 - 3,500 = 13,000 dollars of incremental revenue per month from the same spend. Both iROAS figures are Stella's measured channel medians, so this is a real reallocation, not a last-click mirage.
:::

# Run it without faking the lift

Holdouts are only as honest as their design, and the edge cases are where most DTC tests go wrong. The signal layer from Lesson 6 still applies here: if CAPI dedup is broken and platform conversions are double-counted, your incrementality math inherits that error. Three discipline checks matter most. Keep the exposed group large enough to be significant (under roughly 1,000 exposed conversions, lift reads get noisy and over-interpreted). Match your geo markets and hold the baseline window clean (a promo or seasonality spike in only the test markets manufactures fake lift). And remember that user-level conversion-lift can under-count upstream demand creation, so reach for a geo holdout when you are measuring a demand-creation channel.

The organizational trap is the loudest one operators report: a holdout that says cut a high-ROAS retargeting campaign is exactly the finding leadership does not want to believe, so incrementality results get ignored in favor of the dashboard number that looks better. Meta's own Conversion Lift is also gated and budget-hungry, pushing smaller brands toward improvised geo tests that then get challenged as unscientific.

:::predict
prompt: You need at least 1,000 exposed conversions for a non-noisy lift read. If the exposed group converts at 2.0%, how many exposed users does the test need before you should trust the result?
answer: 50000
tolerance: 500
unit: users
hint: Conversions = users x conversion rate, so solve for users.
explain: Users = required conversions / conversion rate = 1,000 / 0.02 = 50,000 exposed users. Below that, the lift estimate swings on a handful of purchases and gets over-interpreted, which is the single most common way a DTC holdout produces a number leadership can rightly dispute.
:::

:::callout warning
Operators on r/PPC report that leadership "doesn't believe" a holdout when it tells them to cut a high-ROAS retargeting line, so the incrementality finding gets shelved and the harvesting spend continues. The companion complaint: Meta's Conversion Lift is gated and expensive on smaller budgets, so teams run DIY geo tests that get dismissed as unscientific. The fix is to run the holdout BIG enough to be significant and frame it in dollars of incremental revenue moved, not in disputing the platform's last-click number directly.
:::

:::sources
- Stella, 2025 DTC Digital Advertising Incrementality Benchmarks | https://www.stellaheystella.com/blog/2025-dtc-digital-advertising-incrementality-benchmarks
- Digital Applied, Incrementality Testing: Proving Ads Actually Caused Sales | https://www.digitalapplied.com/blog/incrementality-testing-paid-media-causal-lift-2026
- ATTN Agency, The DTC Brand's Guide to Incrementality Testing | https://www.attnagency.com/blog/incrementality-testing-dtc-brands-guide
- Triple Whale, GeoLift 101: Your Guide to Geo-Based Incrementality Testing | https://www.triplewhale.com/blog/geolift-geo-based-incrementality-testing
- Triple Whale, Meta Conversion Lift Tests: How to Measure Incrementality on Meta | https://www.triplewhale.com/blog/meta-conversion-lift-test
- AdExchanger, Why Amazon Is Gaining Ground In CTV And The Trade Desk Is Losing Its Lead | https://www.adexchanger.com/on-tv-and-video/why-amazon-is-gaining-ground-in-ctv-and-the-trade-desk-is-losing-its-lead/
:::
