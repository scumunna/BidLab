---
id: vertical-qsr-08
track: vertical-qsr
module: 8
title: Fraud and Quality Control, Location Spoofing and IVT in a Geo-Driven, CTV-Heavy Buy
summary: Spot and price location spoofing and invalid traffic in a footfall buy, run the pre-bid and supply-path defenses, and protect CPIV from phantom visits.
---
# Why a footfall buy is a fraud magnet

A QSR campaign pays a premium for one thing above all: location. The bid stream says a device is near a specific store, and the trader pays more to reach it and later counts a visit from it. That premium is exactly what location spoofing harvests. A fraudster fabricates GPS or lat/long in the bid request to collect the geo uplift on inventory that is not where it claims, or that does not exist at all, and the same fake coordinates then inject phantom visits into your footfall report. Because QSR also leans hard on CTV, the buy carries a second exposure on top of geo spoofing: device spoofing and server-side opacity in the living room.

The scale is not theoretical. A 2025 CleanTap test reported that 100% of the invalid traffic it spoofed was accepted into live programmatic auctions and successfully bid on, global CTV invalid traffic sits near 18%, and roughly 30% of spoofed Roku traffic actually originated on mobile devices. Lunio's 2026 Global Invalid Traffic Report puts global ad spend wasted on invalid traffic at about $63 billion in 2025, on an 8.51% IVT rate across paid clicks. For the trader, fraud is not a compliance footnote, it is a direct tax on both budget and measurement.

:::figure discrepancyWaterfall
caption: A clean CTV buy starts at gross impressions and steps down as invalid traffic, spoofed geo, and opaque SSAI supply are stripped out. What survives at the bottom is the valid inventory you should actually be paying for, and the gap is your effective-cost penalty.
:::

# Location spoofing, the geo-specific threat

Most fraud discussions are about bots and domain spoofing. In QSR the signature attack is geographic: the bid request carries coordinates that resolve inside your store radius, so your DSP bids up, but the device was never there. The damage is double. You waste spend on a worthless impression, and you corrupt the downstream footfall attribution because the same fabricated location can register as a "visit" to a polygon the user never entered. A campaign can show real-looking lift built entirely on traffic that never existed.

The first-line defense is cheap and specific to geo buys: cross-check that the bid-stream location is plausible. An impression tagged for a Dallas store should resolve in-country, in-DMA, and consistent with the device's other signals. Coordinates that land out of state, out of country, or that contradict the device profile get flagged and excluded before you pay the premium.

:::predict
prompt: A geo-targeted QSR flight serves 4,000,000 impressions. Your verification vendor flags 60,000 whose bid-stream location is out-of-DMA or device-inconsistent. What is the geo-plausibility flag rate, as a percentage of total impressions?
answer: 1.5
tolerance: 0.05
unit: %
hint: Divide the flagged impressions by total impressions.
explain: 60,000 / 4,000,000 = 0.015, a 1.5 percent flag rate. Even a small percentage matters in a footfall buy because each flagged impression both wasted geo-premium spend and risked injecting a phantom visit into attribution.
:::

:::quiz
question: Why is spoofed geolocation considered doubly damaging on a QSR footfall campaign, compared with ordinary bot traffic on a CTR campaign?
- It only inflates the click-through rate, nothing else
- It both wastes the geo-premium spend AND injects phantom visits that inflate reported footfall lift
- It lowers the CPM, so the campaign looks cheaper than it is
- It has no effect on measurement because footfall uses a separate data source
answer: 1
hint: Think about what the fabricated coordinates feed besides the auction.
explain: Spoofed geo wastes the premium you paid to reach a store radius and then poisons attribution, because the same fake coordinates can count as a visit to a store polygon the user never entered. On a CTR campaign a bot mainly wastes spend, but on a footfall buy the fake location also corrupts the lift number the brand judges you on.
:::

# CTV, SSAI, and device spoofing

QSR's shift to CTV (chicken-chain CTV impressions alone grew from 1.1B in Q1 2024 to 4.1B in Q1 2026) hands the trader premium meal-moment reach and a new attack surface. CTV is opaque: a mobile bot can present itself as a living-room Roku, and without device-level detection the trader cannot tell premium CTV from spoofed inventory. Server-side ad insertion (SSAI) stitches ads into the stream on a server, which is legitimate and common, but it hides the true client, so a genuine CTV request and a fraudulent one can look identical unless the supply path is transparent and authorized.

The defenses stack. Use MRC-accredited sophisticated-invalid-traffic (SIVT) detection for CTV and mobile environments, apply supply-path optimization to favor authorized direct sellers via ads.txt, app-ads.txt, and sellers.json, and cap or exclude opaque SSAI supply you cannot verify. None of these is free of tradeoffs, which is the next problem.

:::quiz
question: What does server-side ad insertion (SSAI) make harder for a fraud-conscious CTV buyer?
- It blocks all bot traffic automatically
- It guarantees every impression is from a real Roku device
- It hides the true client, so legitimate and fraudulent CTV requests can look identical without a transparent, authorized supply path
- It lowers latency so fraud detection runs faster
answer: 2
hint: SSAI stitches the ad on a server, between you and the actual device.
explain: SSAI is legitimate and widespread, but because the ad is inserted server-side the true client is masked. That opacity means a spoofed request and a real one are hard to tell apart unless the supply path is transparent and authorized, which is why SPO and SIVT matter most in CTV.
:::

# Pricing the damage, IVT as a tax on CPM

Invalid traffic is not just a quality problem, it is a math problem the trader must quantify. The headline CPM you negotiated is a fiction once a slice of impressions is invalid, because you are really paying that price for fewer clean impressions. The effective, or clean, CPM divides the same media spend across only the valid impressions, and it is always higher than the rate card.

$$ \text{effective CPM} = \frac{\text{media spend}}{\text{valid impressions} / 1000} = \frac{\text{nominal CPM}}{1 - \text{IVT rate}} $$

Knowing this lets the trader argue for make-goods. Post-bid, you reconcile the impressions a verification vendor flagged as invalid against billing, and the seller owes back the value of those impressions at the deal CPM. Documenting the flagged count and the rate turns a vague "the traffic looked bad" into a specific dollar recovery.

:::predict
prompt: A CTV flight serves 5,000,000 impressions at a measured 18% invalid-traffic rate. How many impressions are invalid?
answer: 900000
tolerance: 1000
unit: impressions
hint: Multiply total impressions by the IVT rate.
explain: 5,000,000 x 0.18 = 900,000 invalid impressions. That is the count you would flag for a make-good and exclude from any clean-CPM or CPIV calculation.
:::

:::predict
prompt: You negotiated a $30 CPM, but 18% of the impressions delivered were invalid traffic. What is the effective (clean) CPM you actually paid on valid impressions, rounded to the nearest cent?
answer: 36.59
tolerance: 0.05
unit: USD
hint: Divide the nominal CPM by the share of impressions that were valid (1 minus the IVT rate).
explain: Valid share is 1 - 0.18 = 0.82, so effective CPM = 30 / 0.82 = 36.585, which rounds to $36.59. The 18 percent invalid traffic quietly raised your true cost per clean impression by about 22 percent over the rate card.
:::

:::predict
prompt: After the flight, your vendor flags 900,000 impressions as invalid on a deal that ran at a $30 CPM. What make-good value is owed back in post-bid reconciliation?
answer: 27000
tolerance: 50
unit: USD
hint: Make-good owed = flagged impressions divided by 1,000, times the deal CPM.
explain: 900,000 / 1,000 = 900 thousands of impressions, times $30 = $27,000 owed. Quantifying the flagged volume at the deal rate is how you turn an IVT report into a concrete recovery rather than an argument.
:::

# Protecting CPIV, the metric that actually pays you

Everything above rolls up to the one number the QSR brand judges, CPIV (cost per incremental visit). Spoofed geo does not just waste CPM, it inflates the visit count in your denominator with phantom visits, which makes CPIV look artificially cheap. A cheap CPIV built on fake visits is the most dangerous outcome in this lesson, because it survives the QBR until a sharper analyst asks where the visits came from. The discipline is to strip flagged, spoofed, and implausible-geo traffic out of the visit count before you compute and report CPIV.

:::callout key
A suspiciously low CPIV is a fraud signal, not a win. If spoofed geo is padding your visit count, the denominator is inflated and CPIV drops, so the cheapest-looking campaign can be the most contaminated one. Always reconcile reported visits against IVT and geo-plausibility flags before you celebrate a low cost per incremental visit.
:::

:::predict
prompt: A QSR flight spends $90,000 and a footfall vendor reports 9,000 incremental visits, for a headline CPIV of $10.00. Your IVT review shows 1,500 of those "visits" came from spoofed or implausible geo. What is the true CPIV once the phantom visits are removed, rounded to the nearest cent?
answer: 12
tolerance: 0.05
unit: USD
hint: Subtract the phantom visits from the count, then divide spend by the real visits.
explain: Real incremental visits are 9,000 - 1,500 = 7,500. True CPIV = 90,000 / 7,500 = $12.00, versus the reported $10.00. The spoofed visits made the campaign look 17 percent cheaper than it really was, which is exactly the kind of inflation a low CPIV can hide.
:::

:::widget barChart
title: CTV invalid traffic baseline and the mobile share of spoofed CTV
labels: Clean CTV, CTV IVT, Mobile-as-CTV share of spoof
data: 82, 18, 30
unit: %
:::

# The tradeoffs and the field reality

Fraud filtering is not free, and the trader manages it as a balance, not a switch. Pre-bid IVT segments add latency and cost and can over-block the already-thin rural local supply that QSR depends on, so aggressive filtering in a small DMA can starve a franchise store of delivery. Made-for-advertising sites pass basic brand-safety checks and even count as "valid" by some IVT definitions while delivering near-zero attention, so they are technically clean yet worthless for footfall. And because CTV is a black box, over-relying on a single verification vendor you do not fully trust is a known failure mode.

:::callout warning
A recurring complaint from working traders on r/adops is that CTV is a fraud black box: spoofed device and app data sails through auctions, and most desks lean on one verification vendor they admit they do not fully trust. On r/programmatic the parallel gripe is that location-spoofed bid requests pad impression counts in geo campaigns, and make-good reconciliation for invalid traffic is slow and routinely contested by sellers. Plan for both: insist on a transparent, authorized supply path up front, and document flagged IVT with counts and CPM so the make-good argument is concrete instead of a he-said-she-said.
:::

:::quiz
question: A trader runs aggressive pre-bid IVT filtering on a campaign covering rural franchise stores and delivery collapses. What tradeoff explains this?
- Pre-bid filtering only ever increases available inventory
- Pre-bid IVT segments add latency and cost and can over-block the already-scarce local supply in thin DMAs
- Invalid traffic is higher in cities, so rural buys are immune
- The DSP automatically refunds any under-delivery from filtering
answer: 1
hint: Local QSR inventory outside major metros is already thin before you add filters.
explain: Fraud filtering is a balance, not a free switch. Pre-bid IVT segments cost latency and money and can over-block, and in rural DMAs where authorized local supply is already scarce, that over-blocking can starve a store of delivery. The trader has to weigh fraud protection against keeping thin local inventory alive.
:::

:::sources
- AdExchanger, CleanTap Says It Easily Fooled Programmatic Tech With Spoofed CTV Devices | https://www.adexchanger.com/measurement/cleantap-says-it-easily-fooled-programmatic-tech-with-spoofed-ctv-devices/
- Spider AF, Video Ad Fraud: The 2025 Playbook to Protect CTV, YouTube and Programmatic Video Budgets | https://spideraf.com/articles/video-ad-fraud-the-2025-playbook-to-protect-ctv-youtube-and-programmatic-video-budgets
- MediaPost, Ad Spend Wasted On Invalid Traffic Reaches $63B (Lunio 2026 Global Invalid Traffic Report) | https://www.mediapost.com/publications/article/412156/ad-spend-wasted-on-invalid-traffic-reaches-63b.html
- Pixalate, Mobile-to-CTV Spoofing: 30% of Spoofed Roku CTV Traffic Appears To Come From Mobile | https://www.pixalate.com/blog/mobile-ctv-app-spoofing-august-2022
- AdImpact, Q1 2026 Fast Food Advertising Trends | https://adimpact.com/blogs/q1-2026-fast-food-advertising-trends
- aidigital, Foot Traffic Attribution: What It Measures, Polygon Mapping, Dwell and Neighbor Exclusion | https://www.aidigital.com/blog/footfall-attribution
- Cuebiq, Footfall Attribution Benchmarks (CPIV, Visit Rate, Uplift by Vertical) | https://cuebiq.com/benchmarks/
:::
