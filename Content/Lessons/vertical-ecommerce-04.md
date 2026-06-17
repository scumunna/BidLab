---
id: vertical-ecommerce-04
track: vertical-ecommerce
module: 4
title: Targeting and Audiences, Keywords, ASINs, Clean Rooms, and First-Party Lists
summary: Define who an ecommerce ad reaches across Amazon keyword/ASIN targeting, clean-room audiences, and open-web first-party lists, then translate match rate, overlap, and suppression into CAC and MER.
---
# The two targeting layers on Amazon

On the ~75 to 80% of an ecommerce stack that is Amazon, targeting starts with two onsite mechanics. Keyword targeting runs broad, phrase, and exact match (plus auto campaigns whose only job is to discover terms you have not thought of yet), while product targeting points at a category or a specific competitor ASIN for conquesting. The trader's first instinct is funnel position: auto and broad sit at the top to harvest queries, exact and competitor-ASIN sit at the bottom to capture intent you have already proven converts.

The reason this matters for the P&L is that each match type carries a different conversion rate and therefore a different efficient bid. Sponsored Products conversion rates run roughly 10 to 18% with click-through around 0.3 to 0.7%, so a high-intent exact-match term justifies a far higher max CPC than a speculative broad term at the same margin ceiling.

:::quiz
question: A trader wants to discover new converting search queries to later promote into exact match. Which Amazon targeting setup is built for that discovery job?
- Exact-match keywords only
- Competitor-ASIN (product) targeting
- Auto and broad-match campaigns
- A static negative-keyword list
answer: 2
hint: One of these is designed to surface terms you did not pre-select.
explain: Auto and broad-match campaigns cast wide to surface queries you did not anticipate, which the trader then harvests into exact match. Exact and competitor-ASIN targeting capture known intent, and negatives only subtract traffic.
:::

# The audience layer, clean rooms above the keyword

Above keyword and ASIN targeting sits the audience layer, where the real first-party power lives. Amazon Marketing Cloud (AMC) is a privacy-safe clean room: the trader writes SQL-style queries to build custom audiences (viewed-but-did-not-buy, cross-category buyers, lapsed purchasers) and activates them inside Amazon DSP without ever touching user-level PII. Walmart's Scintilla (formerly Luminate) and clean-room plus its DSP integrations play the analogous role for Walmart Connect, the distant number two retail-media network.

The hard constraint, and the reason walled gardens stay walled, is that a clean-room audience only activates inside that ecosystem's DSP. A brilliant AMC audience cannot be ported to Meta, so the trader rebuilds equivalent intent in each walled garden rather than maintaining one master segment.

:::figure cleanRoomMatch
caption: A clean room like AMC matches the brand's first-party records against the retailer's logged-in graph and returns only aggregate, privacy-safe audiences that activate inside that ecosystem's DSP, never raw user-level PII.
:::

:::callout key
A clean-room audience is locked to its own DSP. AMC segments activate in Amazon DSP, and Walmart Scintilla segments live in Walmart's stack (though Walmart Connect is now extending its first-party audiences to third-party DSPs like Yahoo DSP, DV360, and Magnite). Plan to rebuild intent per ecosystem rather than assuming one audience travels everywhere.
:::

# Open-web first-party data and identity

On the open web (Meta, Google Shopping and PMax, The Trade Desk, DV360) targeting increasingly runs on first-party data as signal loss erodes third-party tracking, driven by iOS ATT, privacy regulation, and browser restrictions in Safari and Firefox. Note that Google ultimately kept third-party cookies in Chrome and wound down its Privacy Sandbox APIs in 2025, so the shift to first-party data is about general signal loss rather than an in-progress Chrome cookie deprecation. The trader uploads hashed CRM lists to build Google Customer Match and Meta Custom Audiences, expands them with lookalikes and Advantage+ audiences, and resolves users across sites through identity frameworks like UID2 and RampID. Social alone now accounts for roughly half of offsite retail-media spend, with about 72% of retail-media advertisers prioritizing offsite video, so this is where 1P audiences actually get activated at scale.

The first QA gate is match rate, the share of uploaded CRM records that resolve to reachable users on the platform. Match rate is not a vanity stat: it directly caps reach and quietly degrades the lookalike seed when it runs low, so a poorly matched list underdelivers for reasons that never surface in the campaign UI.

:::predict
prompt: A CRM list of 100,000 records matches 62,000 reachable users on a platform. What is the match rate?
answer: 62
tolerance: 0.5
unit: %
hint: Match rate is matched records divided by uploaded records.
explain: 62,000 / 100,000 = 0.62, a 62% match rate. The remaining 38% are unreachable through that platform and contribute nothing to the lookalike seed.
:::

# Segmenting by funnel stage and intent

The trader's craft is splitting audiences by where the shopper sits and how hot the intent is: prospecting (lookalikes, in-market, category browsers), retargeting (cart abandoners, product viewers), and retention or winback (lapsed buyers). These layers convert at very different rates, which is why they deserve different bids and different budgets rather than one blended pool. Warm retargeting audiences post the highest conversion rates, but they are also the smallest, so reach falls off sharply as you move down the funnel.

A 1P-matched audience that converts at, say, 2.5% against cold prospecting at 1.0% does more than lift CVR; at a roughly fixed CPM it cuts the effective CAC to about 40% of the cold figure ($0.40$ of every cold-CAC dollar). That uplift is the entire economic argument for investing in clean rooms and CRM matching instead of buying cold impressions.

:::widget barChart
title: Relative audience size by funnel stage (prospecting indexed to 100)
labels: Prospecting LAL, In-market, Cart abandoners, Product viewers, Lapsed buyers
data: 100, 70, 35, 28, 20
unit: index
:::

:::quiz
question: Which audience layer typically posts the highest conversion rate but reaches the fewest users?
- Cold prospecting lookalikes
- In-market category browsers
- Cart-abandoner retargeting
- A fresh competitor-ASIN conquest
answer: 2
hint: Think about who has already shown the strongest purchase intent.
explain: Cart abandoners have demonstrated the hottest intent, so they convert best, but the pool is small. Prospecting and in-market reach far more users at much lower conversion, which is why each layer needs its own bid and budget.
:::

:::predict
prompt: Gross-margin LTV from a matched 1P audience is $210 and the fully-loaded CAC on that audience is $70. What is the LTV:CAC ratio?
answer: 3
tolerance: 0.05
unit: ratio (x:1)
hint: Divide gross-margin LTV by fully-loaded CAC.
explain: $210 / $70 = 3.0, a 3:1 LTV:CAC, right at the healthy DTC target. Better targeting raises LTV per customer and lowers CAC, pushing this ratio up.
:::

# Suppression and dedup, the hygiene that protects CAC

The recurring trap is overlap. The same user sits in your Amazon DSP, Meta, and TTD audiences at once, so without cross-platform suppression and dedup you buy that person three times, inflate frequency, and double-count the conversion. Overlap is measured as users in both audiences divided by the smaller audience, and it is the first thing to check before scaling spend across platforms.

The sharper, ecommerce-specific discipline is suppressing existing customers from prospecting. If you do not, you pay full acquisition prices for people who would have repurchased on their own, and your reported new-customer CAC quietly fills up with retained customers. The savings are concrete: suppression savings equal prospecting CAC times the number of would-repurchase customers you excluded.

:::predict
prompt: Prospecting CAC is $70. You add a suppression list that excludes 200 existing customers who would have repurchased anyway. What is the suppression savings?
answer: 14000
tolerance: 1
unit: USD
hint: Multiply prospecting CAC by the number of would-repurchase customers excluded.
explain: $70 x 200 = $14,000 in acquisition spend you no longer waste paying cold-prospecting prices for customers who were going to come back regardless.
:::

:::callout warning
Operators report lookalikes degrade as signal loss worsens and audiences "just don't perform like they used to" post-ATT, while a low CRM match rate silently shrinks reach with no warning in the UI. Worse, AMC's power often goes unused because it demands SQL fluency that many media buyers lack, so audiences go unbuilt or get outsourced. Treat match rate, SQL capability, and suppression lists as core hygiene, not afterthoughts.
:::

# Closing the loop, audiences to MER

Targeting choices only count if they move the buy-side scoreboard, and that scoreboard is not platform ROAS. The honest top-line check is MER (Marketing Efficiency Ratio), total revenue divided by total ad spend across every channel, because it cannot be gamed by which platform claimed the sale. When you suppress repeat buyers, raise match rate, and bid warm audiences correctly, total revenue should hold or grow while total spend falls, and MER rises.

So the audience work ladders straight up to the mandate from Module 2: tighter targeting lowers blended CAC, lifts gross-margin LTV per customer, and improves MER, the numbers a CFO actually funds. A great audience that does not move MER is a great-looking dashboard, not a result.

:::predict
prompt: After cleaning up audiences and suppression, total revenue across all channels is $600,000 on total ad spend of $150,000. What is MER?
answer: 4
tolerance: 0.05
unit: ratio (x)
hint: MER is total revenue divided by total ad spend across all channels.
explain: $600,000 / $150,000 = 4.0, a 4x MER. Because MER ignores who claimed the conversion, it survives the attribution inflation that platform ROAS does not.
:::

:::predict
prompt: Two audiences of 40,000 and 100,000 users share 12,000 users. What is the overlap as a percent of the smaller audience?
answer: 30
tolerance: 0.5
unit: %
hint: Divide shared users by the smaller audience size.
explain: 12,000 / 40,000 = 0.30, a 30% overlap on the smaller audience. That third is at risk of being bought twice and double-counted unless you suppress and dedup across platforms.
:::

:::sources
- eMarketer, FAQ on commerce media: How to capitalize on growth beyond retail | https://www.emarketer.com/content/faq-on-commerce-media-how-capitalize-on-growth-beyond-retail
- eMarketer, Retail Media Ad Spending Forecast and Trends H2 2025 | https://www.emarketer.com/content/retail-media-ad-spending-forecast-trends-h2-2025
- The Trade Desk, Unified ID 2.0 | https://unifiedid.com/
- SalesDuo, Amazon Advertising Benchmarks 2026 | https://salesduo.com/blog/amazon-advertising-benchmarks/
- Finsi, LTV:CAC Ratio Explained: What 3:1 Means and When It Lies | https://www.finsi.ai/blog/ltv-cac-ratio-explained/
- AdExchanger, For Meta Marketers, Automation Isn't Always The Advantage | https://www.adexchanger.com/measurement/for-meta-marketers-automation-isnt-always-the-advantage-but-its-complicated/
- ANA, Q2 2025 Programmatic Transparency Benchmark | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
:::
