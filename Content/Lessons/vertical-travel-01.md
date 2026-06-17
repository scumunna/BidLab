---
id: vertical-travel-01
track: vertical-travel
module: 1
title: The Money Map, Travel's Programmatic Landscape and Travel Media Networks
summary: Map where travel ad dollars sit and which buying surfaces a trader uses, so you can tell a cheap blind open-exchange buy from a closed-loop, booking-measurable Travel Media Network deal.
---
# Why travel is small money but heavy programmatic

Travel is a comparatively small ad category. US travel total media ad spend was about $9.86B in 2024, with 78%+ of that flowing to digital, which is tiny next to retail or finance. What makes it punch above its weight is intent density: a traveler researching a $1,400 trip leaves a rich, high-value signal, and the purchase has a high average order value, so the same dollar of media is chasing a far larger conversion than a $40 retail cart.

That combination, small budgets but high-AOV intent, is why travel is bought programmatically with unusual intensity, and why the buying surface is dominated by data-driven deals rather than spray-and-pray open auction.

:::predict
prompt: If US travel total media ad spend is $9.86B and 78% goes to digital, how many dollars (in billions) are travel digital ad spend?
answer: 7.69
tolerance: 0.05
unit: USD billions
hint: Multiply the total by the digital share.
explain: 9.86 x 0.78 = 7.6908, which rounds to about $7.69B. The remaining roughly $2.17B is non-digital (TV, print, OOH), and the digital slice is where the programmatic trader operates.
:::

# The first-day formula, digital share of spend

The first number a new trader should be able to state is how concentrated the category is in digital, because it sets the size of the playing field you actually work in. Digital share is simply the digital spend divided by total media spend, and in travel that ratio is high and still climbing.

$$ \text{Digital share} = \frac{\text{Travel digital ad spend}}{\text{Travel total media ad spend}} $$

The companion ratio is programmatic share of display, programmatic display dollars over total display dollars. Programmatic is on track to reach about 90% of worldwide display, and roughly 96% of new display dollars, in 2026, so in practice almost every display dollar you touch is transacted through an automated auction or deal.

:::predict
prompt: If programmatic display spend is $90 and total display spend is $100, what is the programmatic share of display, in percent?
answer: 90
tolerance: 0.5
unit: percent
hint: Divide programmatic dollars by total display dollars.
explain: 90 / 100 = 0.90, a 90 percent programmatic share, which matches the worldwide 2026 trajectory. The lesson here is that "display" and "programmatic" are nearly synonymous now, so the open question is not whether to buy programmatically but through which deal type.
:::

# Your buying surfaces, four ways to reach a traveler

A travel trader transacts across four broad surfaces, and knowing which is which is the core of this lesson. First, open-exchange and PMP buys through general DSPs such as DV360 and The Trade Desk, the cheapest reach but blind to whether the impression led to a booking. Second, travel-specialist activation platforms, chiefly Sojern, which after RateGain's $250M acquisition (closed November 2025) is consolidating Adara under one brand, billed as the largest single source of travel-intent data.

Third, metasearch auctions, Google Hotel Ads, Trivago, and Kayak (often bid via Koddi), which run on commission or CPC models that do not behave like standard RTB display. Fourth, the fast-rising Travel Media Networks (TMNs) like Expedia Group Advertising, Marriott Media, United Kinective Media, and Booking, which sell first-party, high-intent traveler audiences both onsite and offsite (CTV, social, OOH).

:::figure retailMediaFlow
caption: A Travel Media Network is a retail-media-style closed loop, the network owns both the first-party booker audience and the booking outcome, so it can sell offsite media (CTV, social) and still report deterministic bookings back. An open-exchange buy has no such loop.
:::

# The dividing line, closed-loop TMN versus blind open exchange

The single most important distinction on the money map is closed-loop versus open. A TMN or programmatic-guaranteed deal is a closed-loop, retail-media-style buy: because the network owns the booking engine, it can measure the actual booking deterministically and report it back to you. An open-exchange buy is far cheaper but blind, you win impressions against a travel-intent audience, but the booking happens off-network and the exchange cannot confirm it.

That trade-off shows up directly in price. Travel-intent PMP and TMN inventory typically clears at $5 to $15+ CPMs, while open-exchange travel inventory runs roughly $1 to $4, so you are paying a multiple for booking visibility and audience quality, not for raw reach.

:::quiz
question: What is the defining feature of a Travel Media Network (TMN) buy versus an open-exchange buy?
- It is always cheaper on a CPM basis
- It is a closed loop where the network can measure the actual booking outcome
- It only runs onsite and never on CTV or social
- It uses third-party cookies for attribution
answer: 1
hint: Think about who owns the booking engine and therefore the conversion signal.
explain: A TMN owns the first-party booker data and the booking engine, so it is a closed loop that reports deterministic booking outcomes, and it sells both onsite and offsite (CTV, social, OOH). It is more expensive than open exchange, not cheaper, which is the price you pay for booking visibility.
:::

# Sizing the market and the TMN surge

Put real numbers on each surface so you can speak to a client about where the money is moving. The Travel Media Network slice is the fast-growing one: US TMN ad spend was $2.13B in 2024 (up 29.1% that year) and is projected to reach $2.96B in 2026. Meanwhile Expedia Group's advertising and media revenue alone was $182M in Q2 2025, up 19% year over year, which annualizes to roughly $0.73B and shows how a single network can anchor the category.

The chart below sizes the pieces in billions of dollars: total media, the digital slice you actually buy, the TMN surface at both ends of its growth, and one anchor network's annualized ad revenue.

:::widget barChart
title: Travel ad-spend money map, 2024 to 2026 (USD billions)
labels: Travel total media 2024, Travel digital est, US TMN 2024, US TMN 2026, Expedia ad rev Q2-25 annualized
data: 9.86, 7.69, 2.13, 2.96, 0.73
unit: USD billions
:::

:::predict
prompt: US Travel Media Network ad spend grows from $2.13B in 2024 to $2.96B in 2026. What is the total two-year growth, in percent?
answer: 39
tolerance: 1
unit: percent
hint: Take the change in spend divided by the starting spend.
explain: (2.96 - 2.13) / 2.13 = 0.83 / 2.13 = 0.3897, about 39 percent over two years. That is why the desk increasingly carries a TMN line item: it is where incremental, booking-measurable travel budget is flowing.
:::

# Blending CPMs across a mixed buy

Because a real travel plan mixes cheap open-exchange reach with expensive closed-loop deals, you must be able to blend their CPMs to report one effective rate. The channel CPM blend is total spend across channels divided by total impressions across channels, times 1000, and it is what a client sees as your "average CPM" even though it hides a wide spread.

$$ \text{Blended CPM} = \frac{\sum \text{channel spend}}{\sum \text{channel impressions}} \times 1000 $$

Watch what the blend conceals. If you spend $40,000 on open exchange to win 10,000,000 impressions and $60,000 on a travel-intent PMP to win 6,000,000 impressions, the blended CPM is $100,000 / 16,000,000 x 1000 = $6.25, a number that exists nowhere in the actual buy. The open line cleared near $4 and the PMP near $10, and only the blend hides that you paid a premium for the booking-measurable half.

:::predict
prompt: You spend $40,000 on open exchange for 10,000,000 impressions and $60,000 on a travel-intent PMP for 6,000,000 impressions. What is the blended CPM, in dollars?
answer: 6.25
tolerance: 0.05
unit: USD CPM
hint: Add both spends, add both impression counts, divide, then multiply by 1000.
explain: Total spend is $40,000 + $60,000 = $100,000; total impressions are 10,000,000 + 6,000,000 = 16,000,000. So $100,000 / 16,000,000 x 1000 = $6.25. The open line alone was $40,000 / 10,000,000 x 1000 = $4.00 and the PMP was $60,000 / 6,000,000 x 1000 = $10.00, so the $6.25 blend masks the real spread.
:::

# Where the new trader gets burned

Two operator realities sit underneath this map, and both bite newcomers. Travel's small overall budget means a single large OTA or airline can move a published vertical benchmark, so sample sizes are thin and benchmarks are noisy, treat any single "travel CPM" or "travel ROAS" figure as directional, not gospel. And metasearch is a genuinely separate auction with commission and CPC mechanics that will not reconcile cleanly to your DSP display reporting.

The most common rookie failure is assuming all four surfaces report the same way. They do not, and the reconciliation pain is real, as the warning below from working operators shows.

:::callout warning
A recurring operator complaint: TMNs and metasearch are effectively "walled gardens" whose own reporting will not reconcile to the DSP's numbers, and smaller travel advertisers feel priced out of premium travel-intent PMPs and stuck on open exchange where the booking signal is invisible. Expect to maintain two or three sources of truth, not one, and to explain the gap to the client rather than forcing a single number.
:::

:::quiz
question: A small independent hotel can only afford open-exchange display. What is the main measurement consequence the trader must flag?
- CPMs will be much higher than a PMP
- Bookings cannot be measured deterministically on open exchange, so booking signal is effectively invisible
- Open exchange does not support display creative
- Metasearch and open exchange use identical reporting
answer: 1
hint: Recall the closed-loop versus blind distinction and which surface the small advertiser is stuck on.
explain: Open exchange is the cheap, blind surface, the booking happens off-network and cannot be confirmed deterministically, so the booking signal is invisible and you are left optimizing to proxies. Open-exchange CPMs are lower, not higher, and metasearch reporting is its own separate auction, not identical to open exchange.
:::

:::callout key
The one-line money map: travel is small in total dollars but heavily programmatic and intent-rich, and your buying surfaces fall on a spectrum from cheap-but-blind open exchange and PMPs, through metasearch's separate CPC and commission auction, up to closed-loop, booking-measurable TMN and programmatic-guaranteed deals at $5 to $15+ CPMs. Know which surface a given line item sits on before you judge its CPB.
:::

:::sources
- eMarketer, US Travel Industry Ad Spending and Travel Media Networks forecast | https://www.emarketer.com/topics/category/travel/
- BusinessWire, Expedia Group Reports Second Quarter 2025 Results (advertising and media revenue $182M, +19%) | https://www.businesswire.com/news/home/20250807749756/en/Expedia-Group-Reports-Second-Quarter-2025-Results
- GeekWire, Expedia stock soars 15% as B2B momentum fuels revenue growth | https://www.geekwire.com/2025/expedia-stock-soars-15-as-b2b-momentum-fuels-revenue-growth/
- Skift, RateGain to Buy Sojern in $250 Million Deal, Expanding Its Marketing Reach | https://skift.com/2025/10/02/rategain-to-buy-sojern-in-250-million-deal-expanding-its-marketing-reach/
- Hospitality Net, RateGain Consolidates MarTech Capabilities Under Sojern, Creating the World's Largest Source of Travel Intent Data | https://www.hospitalitynet.org/news/4131164/rategain-consolidates-martech-capabilities-under-sojern-creating-the-worlds-largest-source-of-travel-intent-data
- AppsFlyer, Travel and Local App Attribution and Marketing Analytics | https://www.appsflyer.com/solutions/travel-local/
- calc4marketers, Average ROAS for Travel Advertising 2026 | https://www.calc4marketers.com/average-roas-travel
:::
