---
id: adops-08
track: adops
module: 8
title: Discrepancies, Reconciliation, and Make-Goods
summary: Why two ad servers never agree, which count actually bills, and how to turn an under-delivery into a make-good or a credit without losing the argument.
---
# Two systems, two numbers, one invoice

Core 08 ended on the counting-point discrepancy: a publisher counts at ad request, an advertiser counts at render, and the gap under about ten percent is treated as normal. This lesson is the operational job that grows out of that one fact. Every campaign you run is measured twice, by a seller system and a buyer system, and the two numbers are never identical. Your job is to know why they disagree, decide whether the gap is normal or a problem, agree which number bills, and when delivery falls short, settle it as a make-good or a credit.

Start with the reason the numbers split. The same impression passes through several counting points on its way to a screen, and each system can log it at a different one.

- Ad request: the page or app asks for an ad. Earliest point, highest count.
- Ad response or downloaded: the creative file reaches the device.
- Begin to render: the creative starts painting into the page. This is the MRC and IAB count-on-begin-to-render standard, and it sits later than the old served count, so it is always lower than the request count.
- Viewable: at least 50 percent of pixels in view for at least one second for display, two seconds for video, by the MRC viewability standard. Lowest count of all.

A seller ad server that counts at ad request and a buyer ad server that counts at begin to render are measuring two different events on the same impression, so a gap is structural, not a bug.

:::figure discrepancyWaterfall
caption: The same impression is counted at successively later points, so each downstream system reports a smaller number than the one before it.
:::

:::quiz
question: A publisher counts at ad request and the buyer's third-party ad server counts at begin to render. Before any losses at all, why is the buyer's number lower?
- The buyer is undercounting on purpose to lower the bill
- Begin to render is a later counting point than ad request, so some requests never reach it
- The publisher is double counting every impression
- Viewability filtering removed the difference
answer: 1
hint: Think about where each system sits in the delivery chain.
explain: Ad request fires first and begin to render fires later, after the creative loads and starts painting. Every drop between those two points (timeouts, abandons, blocked tags) lowers the later count, so the buyer's begin-to-render number is structurally below the publisher's request number even before fraud or filtering.
:::

# Why the gap opens, and how wide is normal

The counting point sets the floor. Real-world losses widen it. The usual suspects:

- Latency and timeouts: a slow creative or a slow page means the user scrolls away or navigates before the ad renders. The request counted, the render never happened.
- Geo and IP filtering: a buyer or verification vendor drops impressions from outside the targeted country or from datacenter IPs. The seller already counted them.
- Lazy loading: the ad slot requests late, as the user scrolls toward it. If the user never scrolls that far, the request can count on one side and the render never fires on the other.
- Time-zone cutoffs: one system closes its day at midnight Eastern, the other at midnight UTC. The same hour of traffic lands in different daily buckets, so any single day looks off even when the totals match.
- Blocked tags and missing macros: an ad blocker, a stripped cachebuster, or a broken third-party tag means the buyer pixel never fires on an impression the seller served.

Add it up and a healthy campaign still shows a gap. The working rule, anchored in the IAB and 4As Standard Terms and Conditions, is that a discrepancy up to about ten percent over the invoice period is normal and absorbed without argument. Past that, you reconcile. The formula, with the seller as the system of record, is the same shape as the core-08 version but written from the seller's denominator.

$$ \text{discrepancy} = \frac{\text{seller count} - \text{buyer count}}{\text{seller count}} $$

:::predict
prompt: The seller (publisher) ad server reports 1,200,000 impressions at ad request. The buyer's DSP reports 1,020,000 rendered impressions for the same line. What is the discrepancy?
answer: 15
tolerance: 0.3
unit: %
hint: Subtract the buyer count from the seller count, then divide by the seller count.
explain: (1,200,000 - 1,020,000) / 1,200,000 = 180,000 / 1,200,000 = 0.15, a 15 percent discrepancy. That is well above the roughly ten percent normal band, so this one gets investigated rather than absorbed.
:::

:::callout key
Ten percent is a working norm, not a law. The number that matters is whatever the IO or platform contract names as the reconciliation trigger. Treat ten percent as the default and check the contract for the real one.
:::

# Whose number bills

A discrepancy is only an argument until you settle which count is the system of record. That is a contractual choice made before the campaign runs, not something you negotiate after the invoice.

In a classic insertion order or direct deal where the agency runs a third-party ad server (Google Campaign Manager, Flashtalking, and similar), the convention is that the buyer's third-party ad server is the billing system of record. Most publishers accept billing against the third-party number, and the buyer pays that count, commonly with the publisher allowed to bill up to ten percent above it to cover the discrepancy. The publisher starts on the back foot because the lower, later-counting buyer number governs.

In programmatic, the system of record is whatever the platform contract names. Often it is the seller-side count (the SSP or publisher ad server) for a publisher payout, but for the buyer's spend it is frequently the DSP's own logged count, and for verified campaigns a neutral third party such as a measurement or verification vendor is named as the count that settles. The principle is constant: one agreed number bills, the other is reference.

This is why the discrepancy formula above puts the seller in the denominator when the seller is the system of record. Swap the system of record and you swap the denominator. Always compute the discrepancy against the count that actually bills.

:::quiz
question: An agency buys a direct IO and runs its own third-party ad server. The publisher ad server shows 1,050,000 impressions, the agency's third-party server shows 1,000,000. Which number does the advertiser pay against, by the usual convention?
- The publisher's 1,050,000, because the seller serves the ad
- The agency's third-party 1,000,000, because the third-party ad server is the system of record
- The average of the two counts
- Neither, the campaign is voided over the gap
answer: 1
hint: In IO deals, the buyer's measurement is contractually the one that governs.
explain: In direct IO buys the buyer's third-party ad server is the agreed billing system of record, so the advertiser pays against its own 1,000,000, often with the publisher permitted to bill up to ten percent above that. The publisher's higher served count is reference, not the bill.
:::

# Make-good or credit

When delivery falls short of what the IO guaranteed, you owe the buyer something. There are two ways to settle it, and they are not interchangeable.

A make-good is additional inventory: you run bonus impressions, usually after the original flight, to deliver the units the campaign was short. It keeps the budget working as media and is the default when the advertiser still wants the reach and there is time and inventory to deliver it. The IAB and 4As terms cap bonus delivery at ten percent above the contracted deliverables without the agency's written consent, so a make-good is sized to the shortfall, not padded.

A credit is money: you reduce the invoice or refund the value of the undelivered portion. It is the right tool when the flight is over, the moment has passed (a holiday or launch window), or no suitable inventory remains to make good in kind. Make-goods are also not available on pure performance buys, where the deliverable is an outcome rather than a guaranteed impression count.

Sizing is the same arithmetic either way. The shortfall is guaranteed units minus delivered units. A make-good delivers that many bonus impressions at no charge. A credit is worth the shortfall priced at the contracted CPM.

$$ \text{shortfall} = \text{guaranteed} - \text{delivered} \qquad \text{credit} = \frac{\text{shortfall}}{1000} \times \text{CPM} $$

:::predict
prompt: A guaranteed buy was sold for 2,000,000 impressions at an 8.00 dollar CPM. It delivered 1,700,000. If the advertiser takes a credit instead of a make-good, what is the credit worth?
answer: 2400
tolerance: 10
unit: $
hint: Find the impression shortfall, then price it at the contracted CPM.
explain: Shortfall is 2,000,000 - 1,700,000 = 300,000 impressions. At an 8.00 dollar CPM that is (300,000 / 1000) times 8.00 = 300 times 8.00 = 2,400 dollars. A make-good would instead deliver those 300,000 impressions as bonus inventory at no charge.
:::

:::callout insight
Notify early. The IAB and 4As terms expect the media company to flag likely under-delivery in time to act, no later than about two weeks before the IO end date, so a make-good can run before the flight closes. Catch it late and your only option left is a credit.
:::

# The under-delivery decision tree

When a line is pacing behind and the discrepancy is over threshold, do not guess. Work the causes in the order most likely to be the bottleneck, fix the first one that bites, then re-check pacing before moving on.

1. Audience too small. The targeting stack (geo, demo, segments, frequency cap, viewability floor) leaves too little eligible inventory to hit the goal. Fix: widen geo, add audience lists, loosen the frequency cap, lower the viewability requirement, add creative sizes.
2. Floor too high or bid too low. Your bid is not clearing the auction, either because the deal or inventory floor sits above it or because the bid itself is set too low. Fix: raise the bid or lower the floor on the deal, and remember DSP fees come out before the bid reaches the exchange, so the cleared bid is lower than the number you typed.
3. Budget and pacing. Budget is missing at the line level, or the pacing setting has already spent the day's hourly allotment. Fix: confirm budget exists on the line and not only the IO, and check the pacing view for remaining capacity.
4. Creative disapproved or unassigned. A line with no eligible creative cannot serve. A creative can be policy-disapproved and silently filtered from every auction. Fix: confirm a creative is assigned and approved, and clear any policy flags.
5. Supply blocked. Inventory is excluded by a block list, a brand-safety filter, an ads.txt or sellers.json mismatch, or a private deal that is paused or mis-IDed. Fix: review block lists and brand-safety settings, verify the deal ID is live, confirm the seller is authorized.
6. Tag or cachebuster issue. The trafficked tag is broken, the cachebuster macro is missing so impressions cache and undercount, or a click macro is malformed. Fix: re-traffic the tag, confirm the cachebuster and tracking macros are present and firing.

:::quiz
question: A line is pacing 20 percent behind and the discrepancy is over threshold. Win rate is healthy and creatives are approved, but eligible-impression volume in the troubleshooter is tiny. Which cause do you work first?
- Tag or cachebuster issue
- Audience too small, the targeting is over-constrained
- Floor too high
- Creative disapproved
answer: 1
hint: Healthy win rate plus approved creatives rules out the auction and the creative. Look at how much inventory is even eligible.
explain: A healthy win rate means you are winning the auctions you enter, and approved creatives rule out the creative gate, so the bottleneck is upstream: too little eligible inventory. That points at over-constrained targeting (geo, segments, frequency, viewability floor). Widen the funnel before touching bids or tags.
:::

:::sources
- IAB, MRC, MMA, Updates to Ad Measurement Guidelines, count-on-begin-to-render | https://www.iab.com/news/iab-mrc-mma-propose-updates-to-ad-measurement-guidelines/
- Pixalate, Begin to Render Ad Impression Measurement Guidelines | https://www.pixalate.com/blog/begin-to-render-ad-impression-measurement-guidelines
- IAB and 4As, Standard Terms and Conditions Version 3.0 finalized | https://www.iab.com/news/iab-4as-release-finalized-standard-terms-conditions-version-3-0-interactive-industry/
- Setupad, What is Ad Discrepancy and How to Reduce It | https://setupad.com/blog/ad-discrepancy/
- Epom, What Is Ad Discrepancy and How to Minimize It | https://epom.com/blog/metrics/how-to-reduce-ad-discrepancy
- Ad Ops Insider, Resolving 3rd Party Discrepancies | https://www.adopsinsider.com/online-ad-measurement-tracking/resolving-3rd-party-discrepancies/
- Adswerve, Why Is My Line Item Not Spending, DV360 Troubleshooting Guide | https://adswerve.com/blog/why-is-my-line-item-not-spending-a-dv360-troubleshooting-guide
- AdExchanger, Widening Discrepancies, The Industry's Dirt Under The Rug | https://www.adexchanger.com/the-sell-sider/widening-discrepancies-the-industrys-dirt-under-the-rug/
:::
