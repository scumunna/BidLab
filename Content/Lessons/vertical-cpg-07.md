---
id: vertical-cpg-07
track: vertical-cpg
module: 7
title: Identity and Audience Match, Clean Rooms, RampID/UID2, and Non-Portable 1P Segments
summary: You will be able to size addressable reach from a match rate, pick the highest-resolving ID the supply supports, work inside retail clean rooms without assuming segments port across retailers, and tell when a low conversion count is a match-rate artifact rather than weak media.
---
# Why identity is the energy sink in CPG

The CPG purchase happens off-platform, in a store, days after the impression, so the only way to target a known shopper or measure a known sale is to stitch a retailer's purchase record to an ad opportunity across fragmented, increasingly cookieless supply. That stitching is one of the two biggest time sinks in this job (reconciliation, Lesson 8, is the other), and it runs through one number you will quote every week: the match rate. The trader's leverage is to maximize that match rate (right ID, clean PII, authenticated supply) and to know that a disappointing conversion count is often a match problem, not a media problem.

The mechanics matter because identity caps both the reach you can buy and the conversions you can measure. A segment that looks like a million shoppers is only ever as large as the fraction that resolves into the platform or the clean room, and the same constraint quietly suppresses the credited sales you report back to the brand.

:::callout key
Match rate is the ceiling on everything downstream. It bounds addressable reach (you can only bid against records that resolve), and it bounds measured conversions (you can only credit purchases you can match back). Quote it before you quote a CPM or a conversion number.
:::

:::quiz
question: An offsite line targeting a retailer 1P segment reports far fewer conversions than expected. The match rate on the audience is 35%. What is the single most important thing the trader should check before changing bids?
- Whether the creative sizes are all trafficked
- Whether the low match rate is suppressing both the reachable pool and the credited conversions
- Whether the frequency cap is set too high
- Whether the brand hurdle should be lowered to 0.5
answer: 1
hint: One number caps both how many shoppers you can reach and how many sales you can credit.
explain: At a 35% match, roughly two-thirds of the audience never resolves, which shrinks the addressable pool and strips the credited conversions before media quality is even in question. The trader confirms the match rate and ID first, because a bid change cannot fix an identity ceiling.
:::

# The ID landscape and the match-rate ladder

You will work with a short menu of identifiers: hashed email and other PII, mobile advertising IDs (MAIDs), and the two interoperable authenticated IDs that matter most, UID2 (The Trade Desk's open framework) and RampID (LiveRamp). Clean rooms accept these schemas and normalize them so a retailer's records and a brand's records can be joined without either side exporting raw data. The practical rule is to choose the highest-resolving ID the supply actually supports, because match rate climbs as you move up the ladder from declining third-party cookies and MAIDs, to hashed email, to authenticated UID2 or RampID.

The numbers are real and current: programmatic match rates commonly land in the 30 to 60 percent band depending on ID type, with retail-media clean rooms reported as high as 70 percent on clean, recent first-party files and authenticated CTV reaching the 60s to low 70s on hashed-email matched UID2/RampID. RampID and UID2 are interoperable, so a buyer with login or CRM coverage can translate across the two for cross-platform dedup and measurement.

:::figure cleanRoomMatch
caption: Two parties load records into a neutral environment. Only the overlap that resolves on a common key (UID2/RampID, hashed email) becomes addressable and measurable. The unmatched remainder is invisible to both targeting and attribution.
:::

:::quiz
question: A brand has authenticated UID2/RampID coverage on its CRM and is buying premium CTV supply that supports those IDs. Which choice maximizes addressable reach?
- Match on declining third-party cookies for the widest historical footprint
- Match on MAIDs only, since CTV is a device environment
- Match on the authenticated UID2/RampID the supply supports
- Match on IP address alone to avoid any ID dependency
answer: 2
hint: Move up the resolution ladder to the highest ID the supply actually accepts.
explain: Authenticated UID2/RampID resolve far higher than declining cookies, MAIDs, or IP-only on supply that supports them, so they unlock the most addressable reach and the cleanest measurement. Choosing a lower-resolving ID silently caps reach and inflates effective CPM.
:::

# Sizing addressable reach from a match rate

The first calculation a trader runs against any audience is how much of it is actually reachable. Addressable matched reach is just the source audience multiplied by the match rate for the chosen ID, so a soft middle-of-the-band match turns a headline segment into a much smaller buyable pool.

$$ \text{addressable reach} = \text{source audience} \times \text{match rate} $$

Getting this right at the start prevents the classic mistake of pacing a budget against the headline segment size and then blaming the bid when delivery stalls. The reachable pool, not the segment label, is what your frequency cap and pacing math should sit on.

:::predict
prompt: A retailer 1P segment has 1,500,000 records and matches into the DSP at a 40% match rate. How many addressable users can the trader actually target?
answer: 600000
tolerance: 0
unit: users
hint: Multiply the source audience by the match rate.
explain: 1,500,000 times 0.40 equals 600,000 addressable users. The other 900,000 records do not resolve into the buy, so they are unreachable no matter how high you set the bid.
:::

:::predict
prompt: The same 1,500,000-record segment is re-matched using an authenticated ID at a 58% match rate. How many MORE addressable users does the higher match rate unlock versus the 40% match?
answer: 270000
tolerance: 0
unit: users
hint: Find each addressable pool, then take the difference.
explain: At 58% the pool is 1,500,000 times 0.58 equals 870,000; at 40% it was 600,000. The difference is 870,000 minus 600,000 equals 270,000 additional addressable users, which is exactly (0.58 minus 0.40) times 1,500,000.
:::

# Match rate moves the marginal return

Identity is not just a reach gate; it changes the economics of the next dollar, which is the number this vertical is judged on. Marginal ROI is the incremental revenue from the next unit of spend divided by that spend, and a low match rate squeezes it from two sides at once. On the cost side, you only get matched, addressable impressions for the dollars you spend, so the effective cost per reachable shopper rises; on the credit side, you can only measure the conversions that match back, so reported incremental revenue is suppressed. The same media, run through a better ID, can flip a line from below hurdle to worth scaling.

$$ \text{mROI} = \frac{\Delta \text{ incremental revenue}}{\Delta \text{ spend}}, \qquad \text{effective CPM}_{\text{matched}} = \frac{\text{paid CPM}}{\text{match rate}} $$

The trader rule is the same one from Lesson 2: raise budget on a line while its mROI is above the brand hurdle (commonly 1.0 incremental), and cap or pause when it falls below. The twist here is that before you cap a line for weak mROI, you check whether a poor match rate, not poor media, is what dragged the measured return under the line.

:::predict
prompt: An offsite prospecting line spends $50,000 and, at a 40% match rate, the clean-room read credits $80,000 of incremental revenue. What is the marginal ROI on that spend?
answer: 1.6
tolerance: 0
unit: ratio
hint: Divide credited incremental revenue by the spend.
explain: 80,000 divided by 50,000 equals 1.6. That sits above a 1.0 incremental hurdle, so the line is worth sustaining or scaling, and a higher match rate would credit more of the same purchases and lift the measured mROI further.
:::

:::predict
prompt: A different line's next $40,000 of spend credits only $36,000 of incremental revenue per the lift read, and the match rate is already high (so it is not a match artifact). The brand hurdle is 1.0. What is the line's mROI, and does the rule say scale or cap?
answer: 0.9
tolerance: 0
unit: ratio
hint: Compute the ratio, then compare to the 1.0 hurdle.
explain: 36,000 divided by 40,000 equals 0.9, which is below the 1.0 incremental hurdle. Because the match rate is healthy, this is a genuine media result, so the rule says cap or pause the line and reallocate the freed budget to an under-saturated line where mROI is above 1.0.
:::

# Working inside the rooms, and the non-portability trap

You will build and measure audiences inside retail clean rooms: Amazon Marketing Cloud (AMC) for Amazon, Walmart's Luminate (now rebranding toward Scintilla, with a newer LiveRamp clean room for closed-loop measurement of off-site spend against on-site Walmart sales), and neutral rooms such as LiveRamp and Snowflake-based environments. Adoption is now mainstream: 66% of organizations use data clean rooms in some capacity as retail media measurement scales. Inside a room you build audiences from purchase signals, activate them into deals and lines, and run match and overlap analysis.

The hard CPG constraint is non-portability. AMC queries run only against Amazon Ads plus the advertiser's own first-party data; Walmart's equivalent runs against Walmart data. A retailer 1P segment is a walled-garden asset, so a Kroger shopper segment cannot be lifted into a Walmart buy, and you cannot join AMC and Luminate directly. The same household is therefore matched, counted, and targeted separately in every retailer's room, and any cross-retailer identity work needs a neutral room or an operator layer.

:::quiz
question: A trader builds a high-performing lapsed-buyer segment inside Amazon Marketing Cloud and wants to run the exact same segment against Walmart Connect offsite supply. What is the correct read?
- Export the AMC segment and upload it straight into the Walmart buy
- The AMC segment is non-portable; rebuild and re-match the equivalent in Walmart's room or use a neutral room
- Join AMC and Luminate directly to merge the two retailers' records
- Assume the household IDs are identical across retailers, so no rework is needed
answer: 1
hint: Retailer 1P segments are walled-garden assets that do not travel.
explain: Retailer first-party segments do not port across retailers, and you cannot join AMC and Luminate directly. The same household must be rebuilt and re-matched inside Walmart's environment, or stitched through a neutral clean room or operator layer. Assuming portability breaks both targeting and measurement.
:::

# When a low number is identity, not media

This is the troubleshooting reflex the brief calls out and that operators flag repeatedly: a disappointing offsite conversion count is frequently a match-rate artifact, not weak media. Closed-loop matched conversions are roughly the exposed audience times the match rate times the in-window purchase rate, so a 35% match silently strips a third of the count before media quality is even in question. Check the match rate (and the ID used) before you touch bids. A second, subtler trap that practitioners now warn about: the matched, measurable shoppers can differ systematically from the audience as a whole, so an uplift read can partly describe who those high-resolving shoppers already were rather than what the media caused. Treat a clean-room lift number as causal only when it sits on a credible matched control, not just on whoever happened to resolve.

Identity work also shows up as an effective-CPM penalty. If you pay a $14 CPM but only 40% of those impressions resolve to addressable, your cost per reachable shopper is $14 / 0.40 = $35.00; lift the match to 58% and it falls to about $24.14 for the same paid CPM. Using a low-resolving ID when an authenticated one is available silently caps reach and inflates that effective cost.

:::widget barChart
title: Typical programmatic match rate by ID type (the ceiling on addressable reach)
labels: 3P cookie/MAID, Hashed email, UID2/RampID authenticated
data: 35, 48, 58
unit: % match rate
:::

:::callout warning
Operator pain point, recurring in 2026 retail-media threads and clean-room writeups: traders describe identity as a constant tax, with match rates of 30 to 60 percent meaning a real chunk of every audience is simply unreachable, and explaining that shortfall to brands as an identity ceiling rather than a media failure is a perpetual battle. Worse, the shoppers who resolve can be the highest-value, most-engaged slice of the audience, so a raw uplift number risks describing who they already were rather than what the media caused, which is why a clean-room lift read should sit on a credible matched control and otherwise be flagged as directional, not gospel. Before you cap a line or apologize for soft conversions, confirm the match rate and the ID, and rebuild any segment you wrongly assumed would port across retailers.
:::

:::sources
- LiveRamp, What is a Data Clean Room (RampID interoperability, deterministic matching) | https://liveramp.com/explainer/data-clean-rooms
- EMARKETER, FAQ on data clean rooms: how retail media is driving adoption (66% use clean rooms) | https://www.emarketer.com/content/faq-on-data-clean-rooms-how-retail-media-driving-adoption-marketers-demand-proof
- Skai, The 2025 State of Data Clean Rooms in Retail Media | https://skai.io/blog/data-clean-rooms-in-retail-media/
- Decentriq, Low match rate in your data clean room? Why it is not a problem (focus on absolute matched reach, not the percentage match rate) | https://www.decentriq.com/article/beyond-match-rate
- Digiday, Lower match rates in data clean rooms are being given a much-needed boost (InfoSum/Acxiom Match Multiplier) | https://digiday.com/marketing/multiplier-effect-lower-match-rates-in-data-clean-rooms-are-being-given-a-much-needed-boost/
- 173tech, 5 tips for setting up a data clean room to measure provider impact (selection vs. impact: matched/engaged customers may already be your highest-value segment, so build for incrementality with a matched control) | https://173tech.com/5-tips-for-setting-up-a-data-clean-room-to-measure-provider-impact/
- Osmos, Closed-Loop Attribution Deep Dive: Walmart vs Amazon vs Instacart (AMC vs Luminate, non-portable rooms) | https://www.osmos.ai/blog/closed-loop-attribution-deep-dive-walmart-amazon-instacart
- LiveRamp, RampID overview (authenticated, interoperable identity; match-rate uplift) | https://liveramp.com/our-platform/rampid
:::
