---
id: adops-06
track: adops
module: 6
title: Brand Safety, Suitability, and Verification
summary: The floor every advertiser shares versus the tolerances each brand sets, pre-bid avoidance versus post-bid blocking, the DV and IAS controls an ops person actually operates, and the authorization signals that prove a seller is real.
---
# Safety is the floor, suitability is your line

Brand safety and brand suitability are not the same job, and confusing them gets you either a brand crisis or a starved campaign. Brand safety is the universal floor: content that is unsafe for every advertiser regardless of who they are, such as content promoting terrorism, child exploitation, hate, or graphic violence. No reputable brand wants to fund that, so the floor is shared across the whole market.

Brand suitability is your own line, drawn above the floor. It is advertiser-specific. News coverage of a war is brand safe (it is legitimate journalism, not the harmful content itself), but a children's snack brand may still find it unsuitable, while a newspaper subscription service is perfectly happy to run there. Suitability is where you trade reach against risk, and reasonable advertisers draw the line in different places.

This vocabulary comes from the GARM (Global Alliance for Responsible Media) Brand Safety Floor and Suitability Framework, built by the WFA with the 4As Advertiser Protection Bureau. GARM itself was disbanded in August 2024 after litigation, but the framework outlived the body. Its eleven sensitive-content categories now live inside the IAB Tech Lab Content Taxonomy, and platforms and verification vendors kept the floor-versus-suitability model wired into their tools. So in 2025 to 2026 you still operate the GARM categories every day, you just no longer have a central club maintaining them.

:::quiz
question: A breaking-news article covers a violent attack accurately and professionally. A toy brand does not want its ad next to it. What is this?
- A brand safety violation, because the content is unsafe for everyone
- A brand suitability decision, specific to that advertiser
- An invalid traffic (IVT) problem
- A viewability failure
answer: 1
hint: Ask whether every advertiser would refuse this placement, or just this one.
explain: Legitimate news about a violent event is brand safe, it is journalism, not harmful content. A toy brand still finding it unsuitable is a suitability decision, drawn above the shared floor and specific to that advertiser. A different advertiser, like a news subscription, would happily run there.
:::

# Tiers: floor, standard, high

Suitability is not a single switch, it is a dial. Vendors and the GARM-derived framework express it as risk levels (commonly Floor, High, Medium, Low risk), and on the buy side you translate those into advertiser tiers. A practical way to think about it:

A floor tier blocks only the universal-harm floor and accepts almost everything else, maximizing reach. This suits performance and direct-response buys where scale matters more than adjacency polish.

A standard tier blocks the floor plus high-risk categories, the default most brands land on. It removes the obviously risky adjacencies while keeping the long tail of ordinary content.

A high tier (sometimes called conservative) blocks the floor plus high and medium risk, leaving only clearly benign content. This suits regulated or reputation-sensitive brands (pharma, kids, finance) and costs you the most reach.

The tradeoff is mechanical: every category you add to the avoidance list removes inventory, so a high tier reaches a smaller pool at a higher effective price. The skill is matching the tier to the brand, not cranking it to maximum by reflex.

:::predict
prompt: A campaign can reach 100,000,000 monthly impressions at the floor tier. Moving to standard removes the 18% that falls in high-risk categories. Moving to high removes a further 12% of the original pool for medium-risk. How many impressions remain reachable at the high tier?
answer: 70000000
tolerance: 500000
unit:
hint: Both percentages are of the original 100M pool, so subtract them from 100%.
explain: High strips 18% plus 12% = 30% of the original pool. 100,000,000 times (1 - 0.30) = 70,000,000 impressions remain reachable. The two cuts are each measured against the original pool, so you subtract 30 percentage points rather than compounding.
:::

# Pre-bid avoidance versus post-bid blocking

There are two moments to act, and they do different things. Pre-bid avoidance happens before you spend: the verification vendor scores the opportunity (URL, app, content category, historical risk) and your DSP simply does not bid on what fails. Nothing is purchased, so nothing is wasted, and this is how you buy suitable content at scale. Its limit is information: the bid request may carry a stale or generic URL, page content can change after the page was last crawled, and a brand-new page has no history yet.

Post-bid monitoring and blocking happens after you win: a verification tag fires on the actual rendered page, sees the real content and real adjacencies, and can block the creative from painting (serving a blank or a backup) when the page violates your rules. This catches what pre-bid missed and gives you the measurement of record (where your ads truly ran). Its limit is cost: by the time a post-bid block fires you have usually already paid for the impression, and a blocked render is a wasted buy.

The professional setup runs both, aligned to the same policy. Pre-bid keeps you out of trouble cheaply, post-bid catches the leakage and feeds tomorrow's pre-bid avoidance lists. DoubleVerify and IAS both publish that aligning the two settings cuts block rates and recovers delivered impressions, because you stop pre-bidding on inventory you would only post-bid block anyway.

:::quiz
question: Your ad served on a page whose content turned harmful after the page was last crawled, so pre-bid let the bid through. Which control is positioned to stop the ad from rendering there?
- Pre-bid avoidance, because it scores every opportunity
- Post-bid monitoring and blocking, reading the actual rendered page
- The sellers.json file
- A higher CPM bid
answer: 1
hint: Which control sees the real page at render time, after the bid is already won?
explain: Post-bid runs a tag on the actual rendered page, so it sees content that changed after the last crawl and can block the creative from painting. Pre-bid acted on stale crawl data and let the bid through. The cost is that you have usually already paid for that impression.
:::

# Blocklists, allowlists, keywords, and the MFA problem

The bluntest tools are list-based. A blocklist (exclusion list) names domains, apps, or keywords to avoid, everything else is allowed. An allowlist (inclusion list) flips it: only the named, vetted inventory is eligible, everything else is excluded. Allowlists are the safest and the most reach-limiting, blocklists are the most permissive and the leakiest. Most ops teams run a curated blocklist for scale plus an allowlist for a brand's most sensitive line items.

Keyword and category avoidance sit between them. You block on the GARM-derived content categories (the durable, low-overblocking approach) and add keyword rules for fast-moving events. Keyword lists are where teams hurt themselves: an over-broad word like "shooting" blocks basketball, photography, and film content along with the violence you meant to avoid. Every term you add to a blunt blocklist removes safe inventory along with unsafe, so blocklist bloat is a silent reach tax. Modern context tools (IAS Context Control, DV's semantic categories) exist specifically to cut this overblocking by reading meaning instead of matching strings.

The category that matters most operationally is MFA (made-for-advertising): low-value, ad-cluttered sites built to arbitrage cheap traffic into impressions. They pass naive brand-safety checks (no harmful content) yet waste budget on no real audience, which is why MFA avoidance is now a standard suitability setting, not an afterthought. The ANA's programmatic benchmark work shows the cleanup working: MFA's share of measured ad spend fell from about 15% in 2023 to about 6.2% in 2024, though by the same study only around $439 of every $1,000 actually reaches a consumer.

:::widget barChart
title: MFA share of measured programmatic ad spend (ANA benchmark, illustrative)
labels: 2023, 2024
data: 15, 6.2
unit: %
:::

:::predict
prompt: A line item runs 5,000,000 impressions. An audit finds 12% of them landed on MFA sites and another 3% on blocklisted domains that leaked through. How many impressions were wasted on those two problems combined?
answer: 750000
tolerance: 10000
unit:
hint: Add the two percentages, then apply to the total.
explain: 12% plus 3% = 15% of 5,000,000. 0.15 times 5,000,000 = 750,000 impressions wasted across MFA and blocklist leakage. The MFA share alone (600,000) is the larger problem and the one a plain brand-safety check would have missed entirely.
:::

# The vendors you operate: DV and IAS

Verification is the instrumentation layer, and after consolidation it is effectively a two-vendor world. Oracle Advertising wound down Moat and Contextual Intelligence, ending all of its ad products on 30 September 2024, which left DoubleVerify (DV) and Integral Ad Science (IAS) as the verification vendors an ops person actually configures and reads.

Both measure the same core trio. Viewability: was the ad actually viewable (the MRC standard is 50% of pixels for at least one second for display, two continuous seconds for video). Invalid traffic / fraud (IVT): bots, data-center traffic, spoofed domains, and other non-human or fraudulent impressions, split into general and sophisticated IVT. Brand safety and suitability: did the ad run against floor-level harm or against categories above your tier. Both vendors are MRC-accredited across viewability and IVT, and both offer the same two-sided deployment you now expect: pre-bid avoidance segments that plug into your DSP, and post-bid measurement and blocking tags. Operationally you pick one as your system of record so your numbers reconcile, wire its pre-bid segments into the DSP, fire its post-bid tag on the creative, and reconcile its viewability and IVT report against the DSP and the publisher.

:::quiz
question: Which statement about the verification vendors an ops person operates in 2025 to 2026 is correct?
- Oracle Moat is the market leader for brand safety
- DoubleVerify and IAS are the two main vendors, both measuring viewability, IVT, and brand safety/suitability
- Verification vendors only work post-bid, never pre-bid
- Viewability and brand safety are the same metric
answer: 1
hint: One named vendor exited the business entirely in 2024.
explain: Oracle wound down Moat and Contextual Intelligence on 30 September 2024, leaving DV and IAS as the two vendors you operate. Both measure viewability, invalid traffic, and brand safety/suitability, and both run pre-bid and post-bid. Viewability (was it seen) and brand safety (what it ran next to) are distinct metrics.
:::

# Authorization signals: proving the seller is real

Suitability assumes you actually bought what the bid request claimed. Authorization signals are the trust layer that backs that assumption, and an ops person reads and audits them constantly. They are IAB Tech Lab standards.

ads.txt (Authorized Digital Sellers, 2017) is a file at the publisher's root, /ads.txt, listing every account authorized to sell that domain's inventory. app-ads.txt is the same idea for mobile and CTV apps, hosted on the developer's site. sellers.json (2019) is the mirror on the SSP or exchange side: a public file naming every seller and intermediary it represents, so a buyer can resolve a seller id to a real company. The SupplyChain object (schain, 2019) rides inside the OpenRTB bid request as an ordered list of nodes, every entity that touched the impression from publisher to the exchange you are buying from.

Together they let you trace a single transaction end to end and detect domain spoofing, unauthorized resellers, and hops that should not exist. The practical rule: if the seller is not in the publisher's ads.txt, or the schain has an unexpected or missing node, you do not trust the impression, no matter how good its viewability looks. Authorization is necessary but not sufficient: a valid ads.txt entry proves a seller is allowed to sell the domain, not that the page content is suitable, which is exactly why you still need the suitability and verification layers on top.

:::predict
prompt: You audit 2,000,000 won impressions. 1,840,000 carry a complete SupplyChain object whose nodes all resolve against sellers.json. What share fails the schain completeness check?
answer: 8
tolerance: 0.2
unit: %
hint: Find the impressions that fail, then divide by the total.
explain: 2,000,000 minus 1,840,000 = 160,000 fail. 160,000 / 2,000,000 = 0.08, so 8% fail the schain completeness check. Those are the impressions to investigate first for spoofing or unauthorized resale, before you trust their suitability scores.
:::

:::callout key
Safety is the floor everyone shares, suitability is the line you draw above it, pre-bid avoids cheaply while post-bid catches the leak, and authorization signals (ads.txt, app-ads.txt, sellers.json, schain) prove you bought what the bid request claimed. Run all of it together, aligned to one policy.
:::

:::sources
- World Federation of Advertisers, GARM Brand Safety Floor and Suitability Framework | https://wfanet.org/knowledge/item/2022/06/17/GARM-Brand-Safety-Floor--Suitability-Framework-3
- VideoWeek, Retooling Brand Safety in a Post-GARM World | https://videoweek.com/2024/12/02/retooling-brand-safety-in-a-post-garm-world/
- IAB Tech Lab, Content Taxonomy standard | https://iabtechlab.com/standards/content-taxonomy/
- Integral Ad Science, IAS Approach to Brand Safety and Suitability | https://integralads.com/insider/approach-to-brand-safety-suitability/
- DoubleVerify, Brand Safety vs Brand Suitability | https://pub.doubleverify.com/blog/brand-safety-vs-brand-suitability/
- PPC Land, Oracle announces end-of-life for advertising products and services | https://ppc.land/oracle-announces-end-of-life-for-advertising-products-and-services/
- World Federation of Advertisers, ANA 2024 programmatic benchmark study | https://wfanet.org/knowledge/item/2025/01/21/ana-s-2024-programmatic-benchmark-study-progress-but-challenges-remain
- Index Exchange, Understanding Supply Chain Transparency, ads.txt, sellers.json, and SupplyChain | https://www.indexexchange.com/index-explains/understanding-supply-chain-transparency/
:::
