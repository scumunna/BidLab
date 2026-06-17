---
id: vertical-retail-01
track: vertical-retail
module: 1
title: The Money Map: Retail Media Networks, On-Site vs Off-Site, and the Walled-Garden Landscape
summary: Read the retail media landscape the way a commerce-media trader has to before touching a bid: which networks hold the money, what is on-site versus off-site, and why every RMN is its own walled garden.
---
# The fastest-growing channel in digital advertising

Retail media, also called commerce media, is the business of a retailer monetizing its own first-party shopper data and its owned digital shelf. When a brand pays to appear at the top of Amazon search, or to retarget a grocer's loyalty shoppers across the open web, that is retail media. US retail media ad spend reaches roughly $69B to $71B in 2026, and globally the channel is near $197B, about 16 percent of all worldwide ad spend. It is growing faster than search or social, which is why a programmatic trader has to be fluent in it.

Your first job is not to bid. It is to draw the money map: which retailers, which formats are on-site versus off-site, which DSP fronts the off-site supply, and where the budget mandate actually concentrates. Get the topology wrong and every later decision inherits the error.

:::figure retailMediaFlow
caption: A retail media network sits between the brand budget and two very different kinds of inventory: the retailer's own on-site shelf, and off-site open web and CTV bought through a DSP. The retailer's purchase data closes the loop on both.
:::

:::callout key
On-site share plus off-site share equals 100 percent of a network's media. Knowing the split tells you where the auction logic, the fees, and the measurement actually live.
:::

# On-site versus off-site

On-site is everything served on the retailer's own .com or app: sponsored search (Sponsored Products and Sponsored Brands) and on-site display. The auction looks like paid search, the conversion is a sale on the same property, and attribution is deterministic because the retailer sees the click and the purchase.

Off-site is the network extending its shopper audiences out to the open web and connected TV through a demand-side platform. Amazon runs its own Amazon DSP. Walmart Connect historically fronted off-site through The Trade Desk and is opening to a wider multi-DSP roster in 2025 and 2026. Criteo acts as a syndication backbone for many smaller networks. Off-site is the fastest-growing segment, about 18.7 percent of US retail media in 2026 and growing roughly twice as fast as on-site, but on-site sponsored search is still the majority of the dollars.

:::widget donutChart
title: US retail media share by network, 2025 (illustrative)
labels: Amazon Ads, Walmart Connect, All other RMNs
data: 79.7, 7, 13.3
unit: %
:::

:::quiz
question: A brand asks you to run "off-site retail media" on a grocer's audience. What is the defining feature of that buy?
- The ads serve as sponsored search on the grocer's own website
- The grocer's shopper audience is extended to the open web or CTV through a DSP
- The campaign is billed as a flat sponsorship with no auction
- Attribution is impossible because no purchase data exists
answer: 1
hint: Off-site means the inventory is not the retailer's own shelf.
explain: Off-site retail media uses the retailer's first-party audience to target the open web or CTV, bought through a DSP. The shelf is someone else's, but the shopper data and the closed-loop measurement still come from the retailer.
:::

# The walled gardens and concentration

The market is hyper-concentrated. Amazon Ads alone commands roughly 77 to 80 percent of US retail media spend. That concentration is the single biggest fact on the money map, because it tells you where most mandates, most inventory, and most of your operational learning curve will sit.

A quick way to express concentration is the Herfindahl index, the sum of each network's squared share. Amazon's contribution alone is large enough to signal a near-monopoly.

$$ \text{HHI}_{\text{Amazon}} = s^2 \quad \text{where } s \text{ is Amazon's share as a decimal} $$

:::predict
prompt: US retail media is $71.09B in 2026 and Amazon holds a 79.7 percent share. What is Amazon's US retail media revenue, rounded to the nearest billion dollars?
answer: 57
tolerance: 1
unit: $B
hint: Multiply the total by the share written as a decimal.
explain: 71.09 times 0.797 equals 56.66, which rounds to about 57 billion dollars. One network is more than half the entire US channel.
:::

:::predict
prompt: Using Amazon's 79.7 percent share, what is its Herfindahl index contribution, its share as a decimal squared, to two decimal places?
answer: 0.64
tolerance: 0.02
unit:
hint: Convert 79.7 percent to 0.797, then square it.
explain: 0.797 squared is 0.635, about 0.64. An index contribution near 0.64 from a single seller is the fingerprint of a near-monopoly, before you even add the other networks.
:::

# Net-new dollars decide where the mandate goes

Total share tells you where the money is today. Net-new share tells you where it is moving, and the answer is even more concentrated. Of the roughly $10.53B of incremental US retail media spend in 2026, Amazon and Walmart together capture about $9.42B. A trader planning next year's budget should expect the mandate to follow that flow.

$$ \text{net-new share} = \frac{\text{leaders' incremental spend}}{\text{total incremental spend}} $$

:::predict
prompt: If net-new 2026 retail media spend is $10.53B and Amazon plus Walmart take $9.42B of it, what share of the new dollars do the two leaders capture, rounded to the nearest percent?
answer: 89
tolerance: 1
unit: %
hint: Divide the leaders' incremental spend by the total incremental spend.
explain: 9.42 divided by 10.53 equals 0.8946, about 89 percent. Nearly nine of every ten new retail media dollars in 2026 go to just two networks.
:::

:::quiz
question: Why does the net-new concentration figure matter more than the total share figure when you are planning next year's staffing and tooling?
- It does not matter; only total share matters
- Because new budget is where growth mandates and new campaigns concentrate, so it predicts where your workload will land
- Because net-new spend is always off-site
- Because it determines the second-price auction clearing price
answer: 1
hint: Think about where next year's new campaigns will actually be created.
explain: Net-new dollars are where growth mandates land, so they predict where new campaigns, new console logins, and new operational load will concentrate. Planning to the leaders' net-new share keeps your team aimed at the work that is actually coming.
:::

# Off-site economics and the hidden tax

Off-site looks attractive because it scales reach beyond the retailer's own shelf, but it carries costs the on-site console hides. Off-site supply routed through a DSP picks up a tech fee or take-rate at each hop, so the blended CPM for the same shopper audience usually looks higher off-site than on-site. That is not waste by itself, but you have to judge it on incremental outcomes, not on a CPM that is not comparable across the two paths.

The harder tax is operational. Every network is a separate walled garden with its own console, auction, attribution logic, creative specs, and reporting schema. Practitioners describe each RMN as "an independent country" with its own language and currency, and gaining a new DSP integration to a network is a multi-quarter, business-development-heavy effort that is not guaranteed.

:::predict
prompt: Off-site is 18.7 percent of $69.3B of US retail media in 2026. Roughly how many dollars is off-site, rounded to the nearest billion?
answer: 13
tolerance: 1
unit: $B
hint: Multiply the total by 0.187.
explain: 69.3 times 0.187 equals 12.96, about 13 billion dollars. Off-site is still the minority of spend, but it is growing about twice as fast as on-site, so its share keeps climbing.
:::

:::callout warning
Do not compare on-site and off-site on CPM alone. Off-site carries DSP and data take-rates the on-site console never shows you, so the same audience looks more expensive off-site for reasons that have nothing to do with its value. Judge each path on incremental sales.
:::

# Why the money map comes first

Before you set a single bid, the money map answers four questions: which retailers hold the mandate, which formats are on-site versus off-site, which DSP fronts each network's off-site supply, and where the budget is concentrating. Those answers decide which consoles you live in, which auctions you have to master, and which measurement you can trust.

One last trap. A non-endemic advertiser, an automaker or a bank buying a grocer's audience, cannot be measured on the grocer's closed-loop sales, so the standard incremental ROAS model breaks for them. Knowing that up front is the difference between a clean measurement plan and a mid-flight scramble.

:::quiz
question: An automaker wants to buy a supermarket RMN's loyalty audience off-site. What should you flag before the campaign launches?
- Nothing; closed-loop sales attribution works the same for any advertiser
- That a non-endemic advertiser cannot be measured on the grocer's closed-loop sales, so you need a different success metric up front
- That off-site is not allowed for non-endemic brands
- That the automaker must sell cars on the grocer's website
answer: 1
hint: The grocer can only see purchases of things it sells.
explain: The supermarket's closed-loop measurement only sees purchases in its own stores, so it cannot credit a car sale. For a non-endemic advertiser you agree on a different outcome, such as reach, brand lift, or site visits, before launch rather than after.
:::

:::sources
- EMARKETER, US Retail Media 2026 Forecast | https://www.emarketer.com/content/us-retail-media-advertising-forecast-2026
- AdExchanger, Retail Media Networks, walled gardens and DSP integration friction | https://www.adexchanger.com/online-advertising/retail-media-networks/
- WARC, The Future of Commerce Media 2026 | https://www.warc.com/
- EMARKETER, FAQ on data clean rooms and retail media | https://www.emarketer.com/content/faq-on-data-clean-rooms-how-retail-media-driving-adoption-marketers-demand-proof
- The Trade Desk, Walmart Connect off-site partnership | https://www.thetradedesk.com/us/news
- IAB, Guidelines for Incremental Measurement in Commerce Media | https://www.iab.com/guidelines/guidelines-for-incremental-measurement-in-commerce-media/
:::
