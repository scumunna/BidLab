---
id: vertical-telecom-01
track: vertical-telecom
module: 1
title: The Money Map, Telecom's Programmatic Landscape
summary: Orient in where telecom ad dollars flow, who the big-spending carriers are, which DSPs and carrier-owned retail media networks you activate across, and why every dollar must be judged against the LTV to SAC north star.
---
# Why telecom is the biggest room you will ever trade in

Telecom is one of the single largest advertising categories in the US, and in 2024 to 2025 it led every vertical in digital ad spend growth at more than 16%. A handful of carriers (Verizon, AT&T, T-Mobile, Comcast) compete for the same finite pool of switchers, so the budgets you will pace are enormous and the competition for each gross add is direct and adversarial. Verizon alone maintains a roughly $12B annual "customer investment" budget covering marketing and promotion, and has signaled no plans to trim it.

As a buy-side trader your job is not brand storytelling. It is wiring a subscriber-growth goal into campaign architecture: line items, deals, bid ceilings, pacing, footprint and identity targeting, QA, and proof of incremental lift. This lesson is the map of the room before you touch a single line item.

:::callout key
The signature KPI for this entire path is LTV to SAC, the ratio of a subscriber's lifetime value to the loaded cost to acquire them (CLV divided by SAC). You optimize to cost-per-gross-add, not clicks, because in a subscription business the only thing that matters is whether an acquired subscriber's lifetime value clears the cost to win them.
:::

:::predict
prompt: Telecom digital ad spend grew about 16% year over year. On a $500,000,000 carrier digital budget, what is the dollar increase that 16% growth represents?
answer: 80000000
tolerance: 100000
unit: USD
hint: Multiply the budget by the growth rate.
explain: $500,000,000 times 0.16 = $80,000,000. A single carrier adding 16% to a half-billion-dollar digital budget puts another $80M into the same auctions you are bidding in, which is exactly why competition for each switcher is so fierce.
:::

# The open programmatic stack you buy through

Most of your activation runs through the open programmatic stack: demand-side platforms (The Trade Desk, DV360, Amazon DSP, Viant) bidding into exchanges and SSPs that feed CTV, display, online video, audio, and digital out-of-home. US programmatic digital display is expected to approach roughly $180B in 2025, about 92% of all digital display, so "programmatic" is no longer a niche channel, it is how display is bought. Connected TV is the fastest-growing surface inside that, forecast at roughly $33.35B in 2025, about 9.6% of total US digital ad spend.

The trader sits at the DSP and translates a carrier's brief into bids against this supply. The mechanics of the auction, the deal, the pacing, and the targeting are the rest of this path, but the first thing to internalize is the scale: you are deploying eight-figure budgets into a real-time market.

:::figure supplyChain
caption: The buy-side path. A carrier brief becomes line items in a DSP, which bids through exchanges and SSPs into publisher and CTV inventory, while carrier-owned retail media networks offer a parallel, first-party-data path the same carrier may also sell to rivals.
:::

:::predict
prompt: If US programmatic display is about $180,000,000,000 in 2025 and grows 17.4% into 2026, what is the 2026 figure (round to the nearest $1,000,000,000)?
answer: 211000000000
tolerance: 1000000000
unit: USD
hint: Multiply by 1.174, then round.
explain: $180,000,000,000 times 1.174 = $211,320,000,000, which rounds to $211B. The pie you bid into keeps expanding, but as later lessons show, more of it is moving inside walled gardens and private deals rather than the open exchange.
:::

# The carrier is now your client and your competitor

The defining 2025 shift in telecom is that a carrier is simultaneously your client and a media owner selling its own inventory and first-party data. T-Mobile stood up a full retail media network, T-Mobile Advertising Solutions, by acquiring Vistar Media (DOOH and in-store, closed February 2025) and Blis (omnichannel and cookieless, roughly $175M, closed March 2025), monetizing its first-party subscriber data on top of a 35,000-screen in-store network. Verizon and Comcast Advertising run their own, and Comcast's FreeWheel powers the Universal Ads platform launched in Q1 2025.

This means a single carrier can be running a subscriber-acquisition campaign with you while also selling its subscriber data and inventory to advertisers in other categories. As a trader you activate both across the open stack and, increasingly, inside these carrier-owned networks, where the inventory is often DOOH, in-store, and first-party CTV rather than classic web display.

:::quiz
question: Why is it now common for a telecom carrier to be both your client and a competing media owner at the same time?
- Carriers stopped buying media and only sell inventory now
- Carriers have built retail media networks that monetize their first-party subscriber data and inventory, even while running their own acquisition campaigns
- DSPs forbid carriers from buying their own inventory
- Open exchanges only accept carrier inventory
answer: 1
hint: Think about what T-Mobile bought in early 2025 and why.
explain: Carriers like T-Mobile, Verizon, and Comcast have built retail media networks (T-Mobile Advertising Solutions, FreeWheel-powered Universal Ads) that sell their first-party data and inventory to other advertisers, so the same carrier whose acquisition campaign you run is also a media owner, creating real data-leakage and conflict concerns.
:::

# The four spend pools, side by side

It helps to see the magnitudes together. The open programmatic display pool dwarfs even fast-growing CTV, and a single carrier's customer-investment budget is itself a meaningful slice of the market. These are the numbers a new trader should be able to recall when sizing where a brief's dollars realistically go.

The chart below puts the 2025 US programmatic display total, its 2026 estimate, the 2025 US CTV total, and Verizon's annual customer-investment budget on one scale so the relative weight is obvious.

:::widget barChart
title: Where the telecom-relevant dollars sit (USD billions)
labels: US Programmatic Display 2025, US Programmatic Display 2026E, US CTV Ad Spend 2025, Verizon Customer-Investment Budget
data: 180, 211, 33.35, 12
unit: USD billions
:::

:::quiz
question: In 2025, roughly what share of all US digital display ad spend transacts programmatically?
- About 36%
- About 60%
- About 92%
- About 100%
answer: 2
hint: Programmatic is no longer a niche slice of display.
explain: Roughly 92% of all US digital display ad spend is expected to transact programmatically in 2025 (about $180B), which is why fluency in the programmatic stack is the entire job rather than one channel among many.
:::

# The north star that governs every decision

Every line item, bid, and deal on this path is ultimately judged against LTV to SAC, lifetime value over subscriber acquisition cost. A healthy benchmark is at least 3 to 1, with subscription businesses often targeting 4 to 1 or higher, and the trader's optimization target is therefore cost-per-gross-add, not CPC or CTR. The next lesson dissects the KPI in full (including the ARPA versus ARPU trap), but you should leave this lesson already thinking in ratio terms.

The discipline is simple to state and easy to violate: a cheap click that converts a low-value, high-churn prepaid customer can destroy LTV to SAC even as it makes the CPA look great. Working media that lands outside a carrier's serviceable footprint is pure waste no matter how cheap the CPM. The map of the room is only useful if you walk it carrying this one number.

:::predict
prompt: A postpaid subscriber has a net lifetime value of $1,600 and a subscriber acquisition cost of $400. What is the LTV to SAC ratio, and does it clear the 3 to 1 gate?
answer: 4
tolerance: 0.05
unit: ratio (x to 1)
hint: Divide net LTV by SAC.
explain: $1,600 divided by $400 = 4, a 4 to 1 ratio that clears the 3 to 1 gate comfortably. This is the exact calculation you will derive a bid ceiling from in later lessons: the allowable SAC is whatever keeps this ratio at or above target.
:::

:::predict
prompt: A carrier sets a target LTV of $1,200 and requires an LTV to SAC of at least 4 to 1. What is the maximum allowable SAC (the loaded cost-per-gross-add you can pay)?
answer: 300
tolerance: 1
unit: USD
hint: Allowable SAC equals target LTV divided by the required ratio.
explain: $1,200 divided by 4 = $300. That $300 allowable SAC is the ceiling every downstream bid, deal floor, and pacing decision must respect, because paying more per gross add than $300 pushes the ratio below the 4 to 1 mandate.
:::

# Edge cases and the pain points traders actually hit

Two structural realities shape the open market you buy against. First, programmatic growth is concentrating inside walled gardens (Meta, Amazon, YouTube) that hand independent DSPs lower-quality open-web inventory, squeezing the open exchange a telecom trader bids in, and telecom budgets straddle both worlds with non-comparable reporting. Second, the feared in-housing wave reversed: per IAB Europe data covered by Digiday, advertisers using a fully in-house programmatic model fell from roughly 50% in 2021 to about 16% in 2022 as skills shortages and privacy complexity bit, so agency trading seats endured rather than vanished.

The most telecom-specific trap, covered in depth later, is that a carrier's retail media inventory spans screens a new trader may not expect (DOOH, in-store, first-party CTV) and is not classic web display, so "programmatic" here is broader than the open-web mental model.

:::callout warning
A recurring complaint from broadband and ISP marketers on r/programmatic: large shares of programmatic budget hit households the carrier cannot actually serve, so clicks and even "conversions" arrive from addresses that fail the serviceability check at the order page. The cheap, high-converting impression is worthless if the prospect literally cannot buy. Footprint targeting, covered in module 3, is the fix, but recognize the failure mode now: in telecom, "great" CPMs routinely hide terrible economics.
:::

:::quiz
question: A client hands you a falling CPA as proof of success, but the acquired base is skewing toward credit-thin prepaid customers. Why is this a problem on the telecom mandate?
- A lower CPA always means better performance
- Prepaid customers have higher ARPU than postpaid, so this is ideal
- Optimizing to a cheap CPA can adverse-select low-ARPU, high-churn customers, quietly destroying LTV to SAC even as the CPA looks efficient
- CPA and LTV to SAC measure the same thing
answer: 2
hint: The signature KPI is a ratio, not a cost.
explain: A cheap CPA can adverse-select toward low-ARPU, high-churn prepaid customers, so "efficient" media quietly destroys LTV to SAC. The mandate is high-value subscriber growth measured by the ratio, not the lowest possible cost per conversion, which is why you optimize to cost-per-gross-add weighted by lifetime value.
:::

:::sources
- eMarketer, Programmatic ad spending set to reach nearly $180 billion by 2025 | https://www.emarketer.com/content/programmatic-ad-spending-set-reach-nearly-180-billion-by-2025
- eMarketer, US TV and CTV Ad Spending Forecasts H2 2025 | https://www.emarketer.com/content/us-tv-ctv-ad-spending-forecast-2025
- T-Mobile Newsroom, T-Mobile Completes Acquisition of Blis to Build Advertising Solutions | https://www.t-mobile.com/news/business/t-mobile-advertising-solutions-blis
- CNBC, Comcast to launch Universal Ads, FreeWheel-powered platform | https://www.cnbc.com/2025/01/06/comcast-universal-ads-platform.html
- Adweek, Verizon holds its roughly $12 billion customer-investment budget | https://www.adweek.com/brand-marketing/verizon-customer-investment-budget-2025/
- First Page Sage, LTV to CAC ratio benchmarks by industry (2025) | https://firstpagesage.com/seo-blog/ltv-cac-ratio-benchmarks/
- Digiday, In-housing programmatic retreats as advertisers rehire agencies | https://digiday.com/marketing/in-housing-programmatic-retreat/
- ANA, Q2 2025 Programmatic Transparency Benchmark finds $26.8B in wasted spend | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
:::
