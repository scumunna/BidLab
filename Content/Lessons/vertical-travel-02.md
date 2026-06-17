---
id: vertical-travel-02
track: vertical-travel
module: 2
title: The buyer and the mandate, who buys travel media and the cost-per-booking KPI
summary: Identify which travel client you serve, translate a vague brand mandate into a concrete cost-per-booking target and bid ceiling, and judge what good looks like by channel.
---
# Who actually signs the insertion order

Travel buyers split into two camps, and the camp decides the KPI. Demand-generators own the booking and have a confirmation event to optimize toward: hotels and chains, airlines, online travel agencies (OTAs), and cruise or tour operators. Demand-shapers do not own a booking at all: destination marketing organizations (DMOs) and tourism boards drive arrivals and visitation for a whole region, so their conversion is a measured lift in visits, not a transaction you can see in a pixel.

The reason this matters on day one is that the same media buy is judged by completely different math depending on who hired you. A Marriott line item is judged on confirmed bookings; a Visit-California line item is judged on incremental arrivals studied after the fact. Mislabel the client and every downstream target is wrong.

:::quiz
question: A state tourism board hires you to "get more people to visit the state." What is the correct primary success metric for this client?
- Incremental arrivals or visitation lift, measured by a location or holdout study
- Cost per confirmed booking, pulled from the booking engine
- Cost per click on the campaign's display creative
- Add-to-cart rate on the booking funnel
answer: 0
hint: A tourism board does not own any single hotel's or airline's booking confirmation.
explain: A DMO is a demand-shaper with no booking pixel of its own, so success is arrivals or visitation lift measured by a location or incrementality study. Cost per booking, clicks, and add-to-cart all assume a transaction the DMO never sees.
:::

# The number you live or die by, cost per booking

For every demand-generator client, the signature KPI is cost per booking (CPB), the media spend divided by the count of confirmed bookings. Its mirror image is booking-value ROAS, the booking revenue returned per dollar of media spent. These two numbers are the entire scoreboard, and a trader who optimizes to clicks or impressions instead will be fired for hitting great proxies while the booking line stays flat.

$$ \text{CPB} = \frac{\text{Total media spend}}{\text{Number of confirmed bookings}} \qquad \text{ROAS} = \frac{\text{Total booking revenue}}{\text{Total media spend}} $$

The two are linked by the average booking value: if you know any two of CPB, ROAS, and average order value (AOV), you can recover the third, since $\text{ROAS} = \text{AOV} / \text{CPB}$. That identity is how you sanity-check a target before you ever set a bid.

:::figure lookToBookFunnel
caption: Travel's funnel is brutally leaky, so the only honest denominator at the bottom is a confirmed, paid booking. CPB divides spend by that final count, not by any mid-funnel proxy above it.
:::

:::predict
prompt: A hotel program spends $40,000 in media and drives 250 confirmed bookings. What is the cost per booking?
answer: 160
tolerance: 0.5
unit: USD
hint: Divide spend by confirmed bookings.
explain: $40,000 / 250 = $160 per booking. That single number, not the click or impression count, is what the hotel judges the program on.
:::

:::predict
prompt: The same program's same 250 bookings carry an average value of $1,400 each. On the same $40,000 of media, what is the booking-value ROAS?
answer: 8.75
tolerance: 0.05
unit: x
hint: First find total booking revenue, then divide by the same $40,000 spend.
explain: Revenue is 250 x $1,400 = $350,000. ROAS = $350,000 / $40,000 = 8.75x. The inverse check ties back to the CPB you just found: AOV / CPB = $1,400 / $160 = 8.75x, the same $160 per booking from the previous step.
:::

# What good looks like is channel-specific

A CPB or ROAS target is meaningless without a channel benchmark, because the same dollar performs very differently by surface. On a last-click basis in 2025 to 2026, blended travel ROAS runs about 4.0x, Google Search about 5.0x, and Meta about 3.6x, so a "good" Meta number and a "good" Search number are not the same number. The trader's job is to set a per-channel target, not one blanket goal, and to remember these are last-click figures that overstate true incremental lift (the holdout proof comes in a later lesson).

US travel also carries the most expensive search clicks of any country, around $1.34 per click on Google Ads, which feeds straight into a higher CPB on that channel before a single booking lands. A cheap CPC elsewhere does not mean a cheap CPB here.

:::widget barChart
title: Last-click ROAS benchmarks by channel, travel 2025 to 2026
labels: Meta, Blended, Google Search
data: 3.6, 4.0, 5.0
unit: x
:::

:::predict
prompt: A Google Search travel campaign returns the benchmark 5.0x booking-value ROAS. If it generated $250,000 in booking revenue, how much media did it spend?
answer: 50000
tolerance: 100
unit: USD
hint: ROAS is revenue divided by spend, so spend is revenue divided by ROAS.
explain: Spend = $250,000 / 5.0 = $50,000. Hitting the channel benchmark tells you the spend that revenue implies, which is how you back into a budget from a revenue goal.
:::

# Translating the mandate into a direct-booking win condition

A CMO almost never hands you a CPB. They say "drive direct bookings," and your job is to convert that into a target and a bid ceiling. The anchor is the cost the brand pays today: OTAs charge 15 to 30 percent headline commission, which loads to roughly 28 to 42 percent of booking value once you add billbacks and rate erosion, while a well-run direct or metasearch program runs about 5 to 15 percent of revenue (metasearch roughly 8 to 14 percent). A direct campaign wins when its loaded CPB as a percent of average daily rate (ADR) comes in below the OTA's effective commission it displaces.

$$ \text{Direct wins when} \quad \frac{\text{Loaded CPB}}{\text{ADR}} < \text{OTA effective commission \%} $$

So the bid ceiling is not a guess. It is whatever CPB keeps that ratio under the OTA's loaded take, because every booking shifted from OTA to direct saves the brand the difference.

:::predict
prompt: On a $1,000 booking, an OTA charges 22% commission while a direct campaign's loaded cost per booking is 12% of ADR. How many dollars per booking does going direct save?
answer: 100
tolerance: 0.5
unit: USD
hint: Compute each cost in dollars on the $1,000 booking, then subtract.
explain: OTA cost = 22% x $1,000 = $220. Direct cost = 12% x $1,000 = $120. Savings = $220 - $120 = $100 per booking, which is exactly the case for shifting volume to direct.
:::

:::quiz
question: A brand says "drive direct bookings" with no target. The displaced OTA charges 25% loaded. Which direct CPB target is defensible as a starting bid ceiling on a $1,000 ADR property?
- $300 per booking, because higher bids win more auctions
- $250 per booking, the break-even against the OTA's loaded take
- Any CPB, since direct is always cheaper than an OTA
- $0, because direct bookings should be free
answer: 1
hint: Break-even is where the direct cost equals the OTA cost it replaces.
explain: 25% of $1,000 is $250, so $250 is break-even and anything below it is genuine savings. A defensible ceiling sits at or under $250; $300 loses money versus the OTA, and "any CPB" or "$0" ignore the displaced-commission math entirely.
:::

# App CPB and web CPB are not the same number

A booking confirmed in a mobile app is a different economic event from a booking confirmed on the website, and the two CPBs must never be blended blindly. With about 63 percent of online travel bookings happening on mobile in 2025, the app surface is primary, not a footnote, but it is measured by a mobile measurement partner (an MMP such as AppsFlyer, Adjust, or Branch), not by the web booking engine. An app-install line in particular reports a cost per install that is only a mid-funnel proxy; the real event is the later in-app booking, so you judge it on cost per in-app booking, never cost per install.

The trap is averaging a low app-install proxy cost against a true web CPB and reporting one rosy blended number. Report the surfaces separately, then blend only with the split visible underneath.

:::predict
prompt: An app-install campaign spends $30,000 and yields 200 confirmed in-app bookings. What is the cost per in-app booking?
answer: 150
tolerance: 0.5
unit: USD
hint: Divide app media spend by in-app bookings, not by installs.
explain: $30,000 / 200 = $150 per in-app booking. If this campaign also generated 6,000 installs, the $5 cost per install would look great while the real $150 booking cost is the number that matters.
:::

:::callout key
Cost per install measures a proxy; cost per in-app booking measures the business. Optimizing an app-install line to cheap installs reliably buys junk volume that never books. Always tie the app line to the in-app booking event.
:::

# Defining a booking, cancellations, and where the number lies

Before any CPB is real, you must define a booking as net of cancellations and refunds, or the number is fiction. Travel cancellations are routine, so a CPB computed on gross confirmations looks great right up until the cancellations land weeks later and the true net CPB jumps. The trader specifies net (post-cancellation) bookings as the denominator from the start, in writing, so the scoreboard does not silently inflate.

This is also where the DMO exception bites again: a tourism board has no booking pixel, so CPB simply does not apply and you must reach for arrivals or visitation lift instead. Forcing a CPB onto a demand-shaper is a category error, not a target.

:::callout warning
A recurring operator complaint from the field: clients fixate on a glossy last-click ROAS and ignore the cancellation rate, so the reported CPB looks excellent until net-of-cancellations settles and the real cost is far higher. The fix is to define the conversion as net bookings up front, not to re-explain the gap after the client has already celebrated the gross number.
:::

:::quiz
question: A campaign reports 300 gross bookings on $43,200 of spend, but 10% later cancel. What is the honest net cost per booking the client should be judged on?
- $130, after a volume discount on cancellations
- $144, using all 300 gross bookings
- $160, using the 270 net bookings after cancellations
- $432, because cancellations double the cost
answer: 2
hint: Subtract cancellations first, then divide spend by the surviving bookings.
explain: Net bookings = 300 x (1 - 0.10) = 270. Net CPB = $43,200 / 270 = $160, versus the flattering $43,200 / 300 = $144 gross. The net figure is the only one that survives once cancellations post.
:::

:::sources
- Calc4Marketers, Average ROAS for Travel Advertising 2026 (blended ~4.0x; Search ~5.0x; Meta ~3.6x; last-click basis) | https://www.calc4marketers.com/average-roas-travel
- Promodo, Tourism Marketing Benchmarks 2026 (US travel Google Ads CPC ~$1.34, the highest of any country) | https://www.promodo.com/blog/tourism-marketing-benchmarks
- CUFinder, Tourism Industry Marketing Benchmarks 2026 (corroborating travel Google Ads CPC benchmark) | https://cufinder.io/blog/benchmarks/tourism/
- Condor Ferries, Over 70+ Online Travel Booking Statistics 2025 (mobile ~63% of online bookings) | https://www.condorferries.co.uk/online-travel-booking-statistics
- AppsFlyer, Travel and Local App Attribution and Marketing Analytics (OTA, airline, and hotel MMP measurement) | https://www.appsflyer.com/solutions/travel-local/
- AppsFlyer, Travel app marketing trends in 2025: Retargeting leads the way | https://www.appsflyer.com/blog/mobile-marketing/travel-app-marketing-trends/
- Expedia Group, Reports Second Quarter 2025 Results (advertising and media revenue $182M, +19% YoY) | https://www.businesswire.com/news/home/20250807749756/en/Expedia-Group-Reports-Second-Quarter-2025-Results
- Skift, RateGain to Buy Sojern in $250 Million Deal, Expanding Its Marketing Reach | https://skift.com/2025/10/02/rategain-to-buy-sojern-in-250-million-deal-expanding-its-marketing-reach/
:::
