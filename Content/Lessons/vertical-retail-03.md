---
id: vertical-retail-03
track: vertical-retail
module: 3
title: The Conversion and the Funnel: Closed-Loop Sales, Attribution Windows, and Brand Halo
summary: Read each RMN's closed-loop attribution rules, convert raw ROAS into window-normalized and incremental numbers, and spot the cross-network double-counting that inflates retail media reporting.
---
# The conversion is a purchase, but the retailer decides what counts

In retail media the conversion is not a pixel fire on a landing page, it is a PURCHASE of the advertised SKU (and often a sibling SKU) captured by the retailer's own closed loop. Because the retailer owns both the ad event and the sale, it can tie a click to a checkout without a third-party cookie, which is exactly why on-site sponsored search posts the 5x to 8x closed-loop ROAS that open-web display cannot. The catch is that "what counts" is defined entirely by each network's attribution rules, and those rules differ by ad type, by retailer, and (as of 2026) by whether the touch was a click or a view. A trader who reads one console's number as if it were a universal truth will misallocate budget on day one.

The funnel here is short and bottom-heavy: impression to click to add-to-cart to purchase, frequently inside the same shopping session. That compression is the source of the high ROAS prints, and also the source of the trap this lesson exists to defuse: a number that looks elite on the dashboard can be mostly demand the brand already owned.

:::figure attributionPaths
caption: The retail media path is short, but the same purchase can be claimed by multiple networks and multiple windows. Closed-loop credit answers "what got credited," not "what the ad caused."
:::

# The two ratios you read off every console

Every closed-loop console hands the trader the same bottom-of-funnel ratios, and the job is to read them in the right order. Click-through rate measures whether the placement earns attention, conversion rate measures whether the listing closes the sale, and ROAS rolls both into a revenue-on-spend headline. The two efficiency rates are defined as clicks over impressions and attributed orders over clicks.

$$ \text{CTR} = \frac{\text{clicks}}{\text{impressions}} \qquad \text{CVR} = \frac{\text{attributed orders}}{\text{clicks}} $$

A weak CTR on a strong term usually means a creative or placement problem (lost top-of-search, poor main image), while a strong CTR with a weak CVR points downstream to the product detail page, price, or the buy box. Reading them together tells the trader where to intervene before touching a bid.

:::predict
prompt: An ad serves 250,000 impressions and earns 5,000 clicks. What is the CTR?
answer: 2
tolerance: 0.1
unit: %
hint: CTR is clicks divided by impressions.
explain: 5,000 / 250,000 = 0.02, a 2 percent CTR. On sponsored search a 2 percent CTR is healthy for a relevant non-brand term, while branded terms often run far higher because intent is already present.
:::

:::predict
prompt: A keyword earns 2,000 clicks and drives 100 attributed orders inside the window. What is the conversion rate?
answer: 5
tolerance: 0.1
unit: %
hint: CVR is attributed orders divided by clicks.
explain: 100 / 2,000 = 0.05, a 5 percent CVR. If the CTR were healthy but CVR fell to 1 to 2 percent, the listing or price, not the bid, is the bottleneck, because the auction was already won.
:::

# The attribution window decides how big the number looks

The single most important thing a retail media trader internalizes is that the SAME campaign reports a bigger or smaller sales number purely as a function of the window, with no change in real performance. Amazon Sponsored Products defaults to a 7-day click window for sellers and a 14-day click window for vendors. Walmart Connect Sponsored Search defaults to a 3-day click window with a 14-day option, and supports 30-day configurations, tuned for CPG consideration cycles. Instacart does not default to last touch at all: since 2022 it applies linear multi-touch attribution, spreading credit across touches, with format-level windows exposed through its Ads API.

Because a wider window sweeps in more late conversions, comparing two networks on raw ROAS without normalizing the window is meaningless. The trader's defensive habit is the window-sensitivity check: the difference between a wide-window report and a narrow-window report is the late and view-driven tail, and that tail is exactly where cross-network double counting hides.

$$ \text{window tail} = \text{sales}_{\text{wide window}} - \text{sales}_{\text{narrow window}} $$

:::predict
prompt: For one identical campaign, the 7-day click report indexes to 100 and the 14-day click report indexes to 118. How many index points is the late-conversion tail that the wider window adds?
answer: 18
tolerance: 0.5
unit: index points
hint: Subtract the narrow-window index from the wide-window index.
explain: 118 - 100 = 18 index points. Nothing about the campaign changed; the wider window simply captured 18 points of later conversions, and those are the late and view-driven sales most exposed to being claimed by a second network.
:::

:::quiz
question: A trader switches a client's Amazon Sponsored Products reporting from a 14-day click window to a 7-day click window and the dashboard ROAS drops sharply. What actually happened?
- Performance got worse and bids must be raised
- The shorter window simply credits fewer late conversions, so reported sales fell while true performance is unchanged
- The campaign lost the buy box
- Conversion tracking broke and the pixel must be reinstalled
answer: 1
hint: The clicks and the sales did not change, only the counting rule did.
explain: Narrowing the window removes later conversions from the credited total, so reported sales and ROAS fall even though the campaign performed identically. This is why normalizing windows before comparing networks is non-negotiable.
:::

# Brand halo lets a narrow campaign claim the whole catalog

Brand halo is the rule that decides whether a click on SKU A that ends in a purchase of SKU B still counts as ad-attributed. On Amazon, Sponsored Brands and Sponsored Display credit brand-halo sales (the shopper engaged your ad, then bought a different ASIN from your brand or catalog), and the advertised-product report splits directly advertised sales from halo sales. Halo-inclusive attributed sales are therefore the advertised-SKU sales plus the credited halo sales, and any ROAS that includes halo always looks larger than the same-SKU-only ROAS.

$$ \text{attributed sales} = \text{advertised-SKU sales} + \text{brand-halo sales} $$

$$ \text{halo-inclusive ROAS} = \frac{\text{advertised-SKU sales} + \text{halo sales}}{\text{ad spend}} $$

The operational risk is that a narrow branded campaign can post an impressive halo-inclusive ROAS while its same-SKU efficiency is weak, because it is quietly claiming credit for catalog sales the ad barely influenced. The trader's move is to pull the same-SKU number alongside the halo-inclusive number and judge the campaign on both.

:::predict
prompt: A Sponsored Brands campaign drives $40,000 in advertised-SKU sales and $10,000 in credited brand-halo sales on $5,000 of spend. What is the halo-inclusive ROAS?
answer: 10
tolerance: 0.1
unit: x
hint: Add advertised-SKU and halo sales, then divide by spend.
explain: (40,000 + 10,000) / 5,000 = 50,000 / 5,000 = 10x. The same-SKU-only ROAS would be 40,000 / 5,000 = 8x, so halo inflated the headline by a quarter without the trader necessarily knowing which ASINs drove it.
:::

The trader's read on that split is simple: if the halo share climbs while same-SKU sales stay flat, the campaign is leaning on catalog credit rather than real ad-driven conversions of the advertised product. In this example halo is 10,000 of 50,000, or 20 percent of credited sales, which is fine if same-SKU sales are also growing and a warning sign if they are not.

:::quiz
question: Which Amazon ad type does NOT credit brand-halo sales in standard reporting, meaning it counts only the advertised SKU?
- Sponsored Brands
- Sponsored Display
- Standard Sponsored Products (advertised-product view)
- Amazon DSP
answer: 2
hint: Two formats are built around catalog and audience halo, one is the workhorse keyword format historically read same-SKU.
explain: Sponsored Brands, Sponsored Display, and DSP are designed to capture brand-halo and catalog sales, while standard Sponsored Products reporting centers on the advertised SKU. Reading SP as if it carried full halo, or comparing it head-to-head with SB on raw ROAS, double counts and misleads.
:::

# Closed loop credits demand, incrementality measures cause

The deepest trap in this funnel is that closed-loop ROAS answers "what got credited," not "what the ad caused." A branded-defense campaign sits on shoppers who already typed your name, so it can report a gorgeous closed-loop ROAS while contributing almost nothing incremental. The number that survives scrutiny is iROAS, incremental sales over ad spend, where incremental sales are what a holdout or lift test proves the ad actually added. Amazon Marketing Cloud lift studies put branded-search defense at only roughly 22 to 38 percent incremental lift, meaning the majority of those credited clicks would have converted with no ad at all.

$$ \text{iROAS} = \frac{\text{incremental sales}}{\text{ad spend}} = \frac{\text{lift} \times \text{attributed sales}}{\text{ad spend}} $$

This is why a 12x closed-loop ROAS and a 3x iROAS can describe the exact same campaign, and why the trader cannot manage to the console number alone. Lesson 9 builds the clean-room and holdout machinery that produces the lift term; here the point is simply that closed-loop credit is the ceiling, and incrementality is the truth underneath it.

:::predict
prompt: A branded-defense campaign reports $48,000 in attributed sales on $4,000 of spend, so its closed-loop ROAS is 12x. An AMC lift test shows only 25 percent of those sales were incremental. What is the iROAS?
answer: 3
tolerance: 0.1
unit: x
hint: Take 25 percent of the attributed sales as incremental, then divide by spend.
explain: Incremental sales are 0.25 x 48,000 = 12,000. iROAS is 12,000 / 4,000 = 3x. The same campaign is a 12x hero on the dashboard and a 3x performer in reality; the gap is the demand you already owned and paid to re-buy.
:::

:::callout key
Closed-loop ROAS is the ceiling on a campaign's value, never the value itself. Always carry two numbers for any branded or retargeting line: the credited ROAS the console shows, and the iROAS a holdout implies. Budget decisions belong to the second number.
:::

# The same purchase, claimed three times

Now stack the pieces. Different windows, different click-versus-view rules, and halo crediting together mean the SAME shopper journey gets claimed by more than one network, and no single console can see the overlap. Incremental's 2026 research found that 36 to 53 percent of total retail media impact is mis-measured by siloed attribution, and that off-site DSP and video credit lands at OTHER retailers more than half the time. The structural result is the one finance distrusts: add up Amazon, Walmart, and Instacart closed-loop sales and you can get a number larger than the brand's actual total sales, because the de-duplication nobody owns has not happened.

:::widget barChart
title: Same campaigns, three different sales numbers as you move from credited to caused to de-duplicated
labels: Reported closed-loop, Incremental (holdout), De-duplicated cross-RMN
data: 100, 30, 78
unit: index
:::

The 2026 platform change makes this sharper, not softer. On January 1, 2026 Amazon retired the blind 14-day view-through window and replaced it with a shopping-signal machine-learning view model for Sponsored Brands, Sponsored Display, and DSP, while click attribution stayed put. Amazon now reports the new model alongside a legacy "Purchases (all views)" metric, so two valid sales numbers can sit side by side for the identical campaign, and a trader who does not know which one the dashboard is showing will misread a year-over-year trend.

:::callout warning
A recurring operator complaint, surfaced repeatedly on practitioner forums and in trade coverage, is that brand teams sum closed-loop sales across Amazon plus Walmart plus Instacart and land above actual total company sales, so finance stops trusting every retail media report. A related 2026 pain point: after the January view-attribution change, traders saw ROAS shift on view-credited campaigns with no spend or bid change, and spent days explaining to clients that the counting rule moved, not the performance. The fix in both cases is the same, normalize windows and de-duplicate before reporting, never sum raw console numbers.
:::

:::sources
- Amazon Ads, View attribution updates for Amazon Store ads (Jan 1 2026 model change) | https://advertising.amazon.com/resources/whats-new/view-attribution-updates-for-amazon-store-ads
- PPC Land, Amazon tightens view attribution as ROAS reporting splits | https://ppc.land/amazon-tightens-view-attribution-as-roas-reporting-splits/
- Osmos, Walmart vs Amazon vs Instacart attribution 2026 deep dive (windows, halo) | https://www.osmos.ai/blog/closed-loop-attribution-deep-dive-walmart-amazon-instacart
- Code3, A deep dive into brand halo attribution | https://code3.com/resources/a-deep-dive-into-brand-halo-attribution/
- PPC Land, Retail media's hidden ROI: how siloed attribution misses half the picture (36 to 53 percent miss) | https://ppc.land/retail-medias-hidden-roi-how-siloed-attribution-misses-half-the-picture/
- IAB, Guidelines for Incremental Measurement in Commerce Media (Nov 2025) | https://www.iab.com/guidelines/guidelines-for-incremental-measurement-in-commerce-media/
- EMARKETER, FAQ on data clean rooms: how retail media is driving adoption (AMC free Sept 2025) | https://www.emarketer.com/content/faq-on-data-clean-rooms-how-retail-media-driving-adoption-marketers-demand-proof
:::
