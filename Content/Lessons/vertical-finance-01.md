---
id: vertical-finance-01
track: vertical-finance
module: 1
title: The Money Map, Programmatic in Financial Services
summary: Orient to where finance ad dollars flow, separate total ad spend from the programmatic slice you actually buy, and learn why finance is a top-three CPM vertical anchored to cost per funded account.
---
# Get the headline number right before anyone hands you a budget

Two numbers get conflated in every finance kickoff, and mixing them is the single most common rookie error. TOTAL global advertising spend first crossed $1 trillion in 2025 and reaches roughly $1.17T in 2026 (eMarketer), and that figure is ALL advertising across every medium, not the programmatic slice you touch. Global PROGRAMMATIC ad spend is a subset, roughly $716B in 2025 (Statista), with about 90% of open-web digital display now transacted programmatically and about 71.6% of all ad spend algorithm-driven by 2026 (dentsu). As a buy-side trader you bid into the programmatic slice, so quoting the trillion-dollar headline as your addressable market sets scale expectations that compliance-restricted finance supply can never fill.

:::callout key
The trillion-dollar figure is TOTAL global advertising. Programmatic is the roughly $716B subset. If you ever see someone derive a ~63% year-over-year jump by treating $716B as last year and $1.17T as this year, they have stacked two different denominators. Programmatic is a slice of the trillion, not the year-ago value of it.
:::

:::predict
prompt: Total global ad spend is about $1,170B in 2026 and global programmatic ad spend is about $716B in 2025. In dollars, how much of the total is NOT the programmatic slice you bid into (1,170 minus 716, in billions)?
answer: 454
tolerance: 2
unit: $
hint: Subtract the programmatic subset from the total headline figure.
explain: 1,170 minus 716 = $454B. That $454B is TV, out-of-home, print, and direct-sold inventory you cannot bid on, so quoting the $1,170B headline as your addressable market overstates it by roughly $454B and sets scale targets compliance-restricted finance supply can never fill.
:::

# Programmatic is a slice, not the whole pie

The discipline here is denominator hygiene. Programmatic share of digital display is programmatic spend divided by total digital display spend, and when roughly 90% of open-web display clears programmatically that ratio is near saturation on the open web. A cleaner cross-vertical check is what share of the trillion is even programmatic at all, which keeps you from quoting a number you cannot buy against.

$$ \text{programmatic share of total} = \frac{\text{programmatic spend}}{\text{total ad spend}} $$

:::predict
prompt: Global programmatic ad spend is about $716B in 2025 out of about $1,170B total global ad spend in 2026. Using $716B over $1,170B, what share is programmatic of that total, in percent (round to nearest whole percent)?
answer: 61
tolerance: 1
unit: %
hint: Divide the programmatic subset by the total, then multiply by 100.
explain: 716 / 1,170 = 0.6120, which rounds to 61 percent. Roughly six of every ten advertising dollars worldwide now clear programmatically, but the other ~39 percent (much of TV, OOH, print, and direct-sold) is not inventory you bid on, so this 61 percent is the honest ceiling on your addressable surface.
:::

# Why finance is a top-three CPM vertical

Finance, insurance, and tech pay the highest display CPMs in digital, roughly $8 to $20 (CPM benchmark aggregators, 2025), and the reason is pure auction economics rather than vanity. A high customer lifetime value plus a small pool of qualified prospects means many advertisers bid hard for the same scarce, in-market user, and on the open exchange that competition translates straight into a higher clearing price. One mechanical detail a finance trader must get right: open-exchange RTB has been a FIRST-price auction at scale since the industry moved off second-price around 2017 to 2019 (Google switched in 2019), so you pay the price you submit, not one cent over the runner-up. That is why most enterprise DSPs run bid shading, an algorithm that shades your bid down toward the lowest price likely to still win, so you stay competitive on scarce finance inventory without overpaying your full bid on every impression. Because you pay top dollar for every impression, supply-path optimization and deal curation matter far more in finance than in cheap verticals, themes the deal-architecture and brand-safety lessons build on.

:::figure supplyChain
caption: In finance the same impression is often reachable through several SSPs at different take-rates. Each extra hop between your DSP and the publisher adds fee and markup, so consolidating to the cleanest, most direct path is how a high-CPM buyer protects effective price.
:::

:::predict
prompt: A publisher's net CPM is $15 and you pay a gross CPM of $20 through the intermediary chain to reach it. What is the supply-path take-rate, the share of the gross price kept by intermediaries, in percent?
answer: 25
tolerance: 0.5
unit: %
hint: Take-rate is (gross CPM paid minus net publisher CPM) divided by gross CPM paid.
explain: (20 - 15) / 20 = 5 / 20 = 0.25, a 25 percent take-rate. One in four of your dollars never reaches the publisher, which is exactly why supply-path optimization moves cost per funded account in a vertical where CPMs already start at $8 to $20.
:::

# The buying surfaces you will actually operate

Your day-to-day toolkit is a set of distinct surfaces. DSPs (DV360, The Trade Desk, Amazon DSP) bid into the open exchange plus private deals on premium finance and news SSPs. The walled gardens (Meta, Google, Reddit) run their own auctions and formats. CTV carries the highest indexed prices in the open-web mix, and Financial Media Networks now sit alongside all of these as a closed, data-rich channel. One trap: walled-garden CPMs are not directly comparable to open-web display or CTV CPMs because the auctions, formats, and creative units differ, so a "$14 social CPM" and a "$14 CTV CPM" buy fundamentally different things and you should benchmark like-for-like surfaces only.

:::widget barChart
title: Indexed average open-web finance CPM by buying surface (walled gardens excluded as non-comparable)
labels: Open Exchange, PMP/Curated, Premium Finance/News PMP, CTV, Financial Media Networks
data: 10, 16, 22, 38, 24
unit: $ CPM
:::

:::quiz
question: A colleague benchmarks a $38 CTV buy against a $14 Meta social CPM and concludes CTV is "almost three times too expensive." What is the core flaw in that comparison?
- CTV is always overpriced and should be cut
- The two are different auctions, formats, and creative units, so the CPMs are not like-for-like
- Social CPMs are fake and cannot be trusted
- CTV should be moved into the same walled-garden auction as Meta
answer: 1
hint: One number is open-web video, the other is walled-garden social.
explain: Walled-garden social and open-web CTV are different auctions, formats, and creative units, so their CPMs are not directly comparable. A full-screen, sound-on, non-skippable CTV impression is a different product from a social feed unit, and judging one by the other's price leads to cutting incremental reach for the wrong reason.
:::

# Financial Media Networks, the structural shift to know

The big 2025 to 2026 development is the rise of FINANCIAL MEDIA NETWORKS (FMNs), banks selling their own first-party transaction data as ad inventory, mirroring what retail media did to grocers and big-box stores. Chase Media Solutions launched in April 2024 and reaches roughly 80M Chase customers, and US FMN ad spend nearly doubles from $640M in 2025 to $1.22B in 2026, a 66.8% CAGR (eMarketer). The appeal is obvious, deterministic targeting off real spending behavior, but FMN inventory is a closed loop with no third-party verification, limited scale, and reporting the bank itself controls, so treat its measurement claims with the same skepticism you would any walled garden.

:::predict
prompt: US financial media network ad spend grows from $640M in 2025 to $1.22B in 2026. What is the year-over-year growth, in percent (round to nearest tenth)?
answer: 90.6
tolerance: 0.5
unit: %
hint: Growth is (new minus old) divided by old, times 100.
explain: (1.22 - 0.64) / 0.64 = 0.58 / 0.64 = 0.90625, about 90.6 percent. Note this single-year growth of roughly 91 percent is larger than the 66.8 percent CAGR because CAGR is annualized across a multi-year horizon, while this figure is one year over the prior year, a distinction worth keeping straight in a budget review.
:::

:::callout warning
A recurring AdOps complaint maps straight onto this lesson: traders read the "total ad spend hits $1 trillion" headline, then set scale targets their compliance-restricted finance supply cannot fill, and the campaign underdelivers from day one. A second field gripe is that "the same mix of sites sells through programmatic whether you pay a high or low CPM," meaning a premium finance CPM does not buy premium quality on its own without curation. Size your plan to the programmatic slice and to curated, brand-safe supply, not to the trillion-dollar headline.
:::

# What you are ultimately judged on

Every number on this map eventually rolls up to one outcome, and in finance that outcome is not a click or a lead but a FUNDED account, a customer who opened AND deposited or transacted. The signature KPI is cost per funded account (CPFA), total media spend divided by funded accounts, and it sits deliberately deep in the funnel because finance is plagued by tire-kickers, bonus-chasers, and KYC failures that make cheap signups worthless. Holding the line on CPFA against an LTV-derived ceiling, not chasing the cheapest impression on the most expensive surface, is the job, and the rest of this path builds out every lever that moves it.

$$ \text{CPFA} = \frac{\text{total media spend}}{\text{number of funded accounts}} $$

:::predict
prompt: A finance acquisition campaign spends $84,000 and produces 560 funded accounts (opened and deposited). What is the cost per funded account, in dollars?
answer: 150
tolerance: 0.5
unit: $
hint: Divide total media spend by the number of funded accounts.
explain: 84,000 / 560 = $150 per funded account. If this same $84,000 had instead produced 2,800 signups, the cost per signup would read a flattering $30, which is exactly why finance ignores signup CPA and reports the deeper, harder funded number.
:::

:::quiz
question: Which figure should a finance trader treat as the addressable market when forecasting programmatic scale?
- Total global ad spend, about $1.17T in 2026
- Global programmatic ad spend, about $716B in 2025
- US financial media network spend, $1.22B in 2026
- The $8 to $20 CPM range
answer: 1
hint: You can only forecast against inventory you actually bid on.
explain: The roughly $716B programmatic figure is the slice you transact, so it is the correct anchor for scale. The $1.17T total includes TV, print, and direct-sold inventory you do not bid on; FMN spend is one narrow channel; and the CPM range is a price, not a market size.
:::

:::sources
- eMarketer / dentsu, Worldwide Ad Spending 2026 (total ad spend surpasses $1T; ~71.6% algorithm-driven) | https://www.emarketer.com/content/worldwide-ad-spending-2026
- Statista, Programmatic Advertising Worldwide (global programmatic ~$716B, 2025) | https://www.statista.com/outlook/dmo/digital-advertising/programmatic-advertising/worldwide
- eMarketer, Financial Media Networks and Chase Media Solutions (US FMN spend $640M to $1.22B, 66.8% CAGR, ~80M Chase consumers) | https://www.emarketer.com/content/financial-media-networks
- SuperAds, US CPM Benchmarks (finance/insurance/tech among highest display CPMs, ~$8-$20) | https://www.superads.ai/facebook-ads-costs/cpm-cost-per-mille/united-states
- Basis Technologies, Understanding the Basics of Bid Shading (open-exchange RTB moved to first-price 2017-2019, Google 2019; you pay your submitted bid; bid shading built into most DSPs) | https://basis.com/blog/understanding-the-basics-of-bid-shading
- AdExchanger, NewsPassID Is Building PMPs That Bypass Brand Safety Blockers (curation vs paying premium CPM for unsafe supply) | https://www.adexchanger.com/publishers/newspassid-is-building-pmps-that-bypass-brand-safety-blockers/
- data-axle, Meta Introduces Financial Products & Services Special Ad Category (compliance limits that cap finance scale) | https://www.data-axle.com/resources/blog/meta-special-ad-categories-rules/
- Publift, Deal ID Explained: Its Role in Programmatic Direct (PMP vs PG and supply-path mechanics) | https://www.publift.com/blog/deal-id
:::
