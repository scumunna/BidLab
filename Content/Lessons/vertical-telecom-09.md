---
id: vertical-telecom-09
track: vertical-telecom
module: 9
title: Brand Safety, IVT, and Supply-Path Optimization
summary: Protect a carrier's eight-figure budget by measuring how little of each DSP dollar reaches a real consumer, then cutting fees, fraud, and made-for-advertising waste with supply-path optimization, ads.txt enforcement, and layered IVT and brand-safety verification.
---
# Where the dollar actually goes

A carrier hands you an eight-figure budget and assumes the money buys impressions in front of real prospects. The supply chain quietly disagrees. The ANA and TAG TrustNet benchmark traced a typical DSP dollar and found only about 36 cents reaches the consumer as working media, with roughly 29 cents going to DSP and SSP fees and another 35 cents lost to invalid, non-viewable, non-measurable, and made-for-advertising (MFA) impressions. Your job in this lesson is to see that leakage on your own line items and close it, because every cent that never reaches a serviceable prospect is a cent that can never produce a gross add.

This is not an abstraction in telecom. The same ANA work that sized the leak also put roughly $26.8 billion of wasted programmatic spend on the table industry-wide in its Q2 2025 benchmark, and a carrier's footprint constraints (Lesson 3) stack a vertical-specific multiplier on top of the generic waste every advertiser eats.

:::figure supplyChain
caption: The path from a DSP dollar to a consumer impression. Fees skim roughly 29 percent and invalid, non-viewable, non-measurable, and MFA impressions take another 35 percent, leaving about 36 cents of working media before any footprint filter is even applied.
:::

:::predict
prompt: If only 36 cents of every DSP dollar is working media, how many dollars of a $10,000,000 carrier budget reach the consumer as working media?
answer: 3600000
tolerance: 0
unit: USD
hint: Multiply the budget by the working-media share.
explain: Working media equals spend times the working-media fraction. $10,000,000 x 0.36 = $3,600,000 reaching the consumer. The other $6,400,000 is consumed by fees and invalid, non-viewable, or MFA impressions before a single serviceable household is even considered.
:::

# Working media and the unit economics

The leakage matters because it feeds straight into the LTV:SAC gate that governs the whole account. Only working media can produce a gross add, so when fees and fraud halve the share of spend that reaches a real prospect, the effective cost per gross add roughly doubles and the LTV:SAC ratio (net lifetime value divided by subscriber acquisition cost) collapses. A trader who fixes supply quality is, in plain terms, repairing the denominator of the carrier's CAC math.

The clean way to express the leak is TrueAdSpend, the working media reaching the consumer divided by total DSP spend. Watch how a recovered supply path flows back into the gate.

$$ \text{Working media \%} = \frac{\text{Working media reaching consumer}}{\text{Total DSP spend}} $$

$$ \text{LTV:SAC} = \frac{\text{Net LTV per subscriber}}{\text{SAC}} $$

:::predict
prompt: A carrier's net LTV per subscriber is $1,800. After supply-path cleanup cuts fraud and MFA waste, the loaded cost per gross add (SAC) settles at $450. What is the LTV:SAC ratio, and does it clear the 3:1 gate?
answer: 4
tolerance: 0
unit: ratio (x:1)
hint: Divide net LTV by SAC, then compare to 3.
explain: LTV:SAC = $1,800 / $450 = 4, i.e. 4:1, which clears the 3:1 healthy-telecom gate with room to spare. The point is causal: cutting wasted impressions lowers the loaded SAC, and a lower SAC lifts the ratio the carrier's growth team is graded on.
:::

:::callout key
Supply quality is not a brand-safety footnote, it is CAC engineering. Every dollar lost to fees, fraud, non-viewability, or MFA inflates SAC and erodes the LTV:SAC ratio. Treat working-media share as a line-item KPI you watch, not a quarterly transparency slide you read once.
:::

# Effective working CPM: pricing what you really bought

Nominal CPM lies about what a carrier pays for a real, viewable, valid impression. The honest number discounts the bought impressions by the invalid-traffic rate and by viewability, so an IVT-heavy or low-viewability path that looks cheap on paper can be the most expensive supply you own. The formula divides spend by the impressions that actually count.

$$ \text{Effective working CPM} = \frac{\text{Spend}}{\text{Impressions} \times (1 - \text{IVT rate}) \times \text{viewability}} \times 1000 $$

A path can post an attractive $27 nominal CPM and still bill you $50 for every impression a human could have seen. That gap is exactly the waste supply-path optimization exists to expose.

:::predict
prompt: A line item spends $27,000 for 1,000,000 impressions at a 10% IVT rate and 60% viewability. What is the effective working CPM on valid, viewable impressions?
answer: 50
tolerance: 0.5
unit: USD CPM
hint: Shrink the impressions by (1 - IVT) and by viewability, then divide spend by that and multiply by 1000.
explain: Valid, viewable impressions = 1,000,000 x (1 - 0.10) x 0.60 = 540,000. Effective working CPM = $27,000 / 540,000 x 1000 = $50.00. The nominal CPM was only $27,000 / 1,000,000 x 1000 = $27, so the real cost is nearly double once you strip invalid and non-viewable impressions.
:::

:::quiz
question: A "premium curated" CTV path quotes a $24 nominal CPM; a transparent direct path quotes a $30 nominal CPM but has half the IVT and far higher viewability. Why might the $30 path be cheaper for the carrier?
- Nominal CPM is the only cost that matters, so the $24 path always wins
- Effective working CPM can be lower on the $30 path because more impressions are valid and viewable
- Higher nominal CPM always means higher quality, so price equals value
- IVT and viewability do not affect cost per gross add
answer: 1
hint: Translate both into effective working CPM, not the sticker price.
explain: Effective working CPM divides spend by valid, viewable impressions. A higher sticker price with far lower IVT and higher viewability can yield a lower effective working CPM and a lower cost per gross add, which is why traders price supply on quality-adjusted impressions, not nominal CPM.
:::

# Supply-path optimization: fewer paths, authorized sellers

The same impression is frequently offered through several SSPs and a chain of resellers, so without discipline a carrier buys the same household repeatedly at an inflated, fee-stacked price. Supply-path optimization (SPO) is the trader's countermeasure: enforce ads.txt and app-ads.txt so you bid only from sellers a publisher has authorized, read sellers.json to see who is actually selling each impression, prune duplicate reseller hops, and consolidate spend onto direct, transparent paths (often the curated PMPs from Lesson 5). Concentration is the health metric, the share of spend flowing through your top few direct paths rather than scattered across resellers.

$$ \text{Supply-path concentration} = \frac{\text{Spend through top-N direct paths}}{\text{Total spend}} $$

:::predict
prompt: After SPO consolidation, $7,200,000 of a $9,000,000 budget flows through the top three direct, authorized paths. What is the supply-path concentration on those paths?
answer: 80
tolerance: 0.5
unit: percent
hint: Divide spend through the top paths by total spend.
explain: Concentration = $7,200,000 / $9,000,000 = 0.80, i.e. 80 percent of spend now flows through three direct, authorized paths. The remaining 20 percent scattered across resellers is where duplicate-path buying and spoofing risk concentrate, so it is the next pruning target.
:::

:::widget barChart
title: SPO concentration before and after pruning duplicate reseller paths
labels: Top-3 Direct Paths, Other Authorized Paths, Reseller / Unverified Paths
data: 80, 12, 8
unit: percent of spend
:::

# IVT and fraud: an adversarial, always-on fight

Invalid traffic is not a setting you toggle once; it is an opponent that adapts. Domain spoofing dresses junk inventory as a premium publisher, bot and incentivized traffic manufacture impressions no human sees, and the IVT rate (invalid impressions over total measured impressions) is the number you drive down and keep down. Pre-bid blocking stops known-bad inventory before you pay, but sophisticated fraud slips through, so you pair it with post-bid measurement and ongoing path auditing. ads.txt, app-ads.txt, and sellers.json are the baseline controls against spoofing and unauthorized resale.

CTV is the hard case. Spoofed device IDs and gaps in server-side ad insertion make app and CTV fraud harder to detect than classic web IVT, which means verification coverage gaps tend to hide on the single highest-budget channel a carrier runs.

:::predict
prompt: A line item measures a 6% IVT rate across 2,000,000 impressions. How many impressions are invalid?
answer: 120000
tolerance: 0
unit: impressions
hint: Multiply total impressions by the IVT rate.
explain: Invalid impressions = 2,000,000 x 0.06 = 120,000. At even a modest $20 CPM that is $2,400 of pure waste on one line item, and the fraud rate climbs the moment verification lapses, which is why IVT control is a daily discipline rather than a launch checkbox.
:::

:::quiz
question: Which combination best reflects current supply-quality discipline for a carrier buy?
- Pre-bid blocking only, set once at launch
- Post-bid measurement only, reviewed at flight end
- Pre-bid blocking plus post-bid measurement plus ongoing ads.txt and sellers.json path auditing
- A brand-safety keyword blocklist alone
answer: 2
hint: Fraud adapts, so one-time or single-layer controls fall behind.
explain: IVT is adversarial, so the durable approach layers pre-bid blocking (stop known-bad before you pay), post-bid measurement (catch what slipped through), and continuous ads.txt and sellers.json auditing (cut spoofing and duplicate resale). Any single layer or one-time setting leaves gaps that fraud exploits, especially on CTV.
:::

# MFA collapse and the waterfall today

Made-for-advertising sites, pages engineered to farm ad impressions rather than serve readers, were a major drain on the programmatic waterfall and a real brand-safety problem for a premium advertiser. The industry has actually moved the number: MFA's share of the programmatic waterfall fell from roughly 15 percent in 2023 to about 0.4 percent by Q1 2025 as buyers added MFA detection and tightened inclusion lists. That is genuine progress a trader can point to, but it does not retire the discipline, since fraud and low-quality supply simply migrate to the next exploit.

$$ \text{IVT rate} = \frac{\text{Invalid impressions}}{\text{Total measured impressions}} $$

:::predict
prompt: MFA's share of the programmatic waterfall fell from 15% to 0.4%. What is the reduction in percentage points?
answer: 14.6
tolerance: 0.1
unit: percentage points
hint: Subtract the new share from the old share.
explain: 15 - 0.4 = 14.6 percentage points of the waterfall reclaimed from made-for-advertising inventory. On a $10,000,000 budget, recovering even that share of spend (roughly $1.46M) toward working media is a direct improvement to effective CPGA and the LTV:SAC gate.
:::

:::widget donutChart
title: Where a DSP dollar goes (ANA / TAG TrustNet)
labels: Working Media to Consumer, DSP / SSP Fees, Invalid / Non-Viewable / MFA
data: 36, 29, 35
unit: percent of DSP dollar
:::

# Edge cases and the transparency fight

The controls have failure modes a careful trader anticipates. Over-aggressive brand-safety keyword blocklists are the quiet reach-killer in telecom: a blunt blocklist starves legitimate, in-footprint news and sports inventory, exactly the premium environments where a carrier wants to be, so calibrate to category and context rather than blanket-blocking words. Duplicate reseller paths mean the same impression can be bought several times without SPO, and CTV or app fraud (spoofed device IDs, server-side ad insertion gaps) evades pre-bid checks that catch web IVT, so verification coverage must follow the budget onto CTV, not stop at display.

:::quiz
question: A carrier's blunt keyword blocklist blocks any page containing "shooting" or "crash" and reach against premium local news collapses. What is the correct fix?
- Keep the blocklist as is, since brand safety always outranks reach
- Move to category and context-level brand-safety controls so safe in-footprint news and sports inventory is not starved
- Remove all brand-safety controls to recover reach
- Shift the entire budget to open exchange to dodge the blocklist
answer: 1
hint: The goal is to keep the carrier safe without starving the premium environments it wants.
explain: Blunt keyword blocklists over-block legitimate news and sports, the exact in-footprint premium supply a carrier values, hurting reach with little safety gain. Category and context-level controls keep ads off genuinely unsafe content while preserving safe premium inventory, which is why calibrated contextual controls beat raw keyword blocklists.
:::

:::callout warning
A recurring operator complaint on r/programmatic: a quarter or more of spend evaporates into fees and junk impressions before reaching a real consumer, and proving it to the client requires log-level data the supply chain resists handing over. Worse, "curated" or "premium" packages still surface spoofed domains and reseller duplication, so traders burn ongoing effort pruning sellers.json paths and tightening ads.txt enforcement just to hold IVT in check. Treat a "premium" label as a claim to verify with your own measurement, never as proof of quality.
:::

:::sources
- ANA, Programmatic Media Supply Chain Transparency Benchmark (Q2 2025), $26.8B in wasted spend | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
- MonetizeMore, Supply Path Optimization: Best Practices and Top SPO Partners | https://www.monetizemore.com/blog/supply-path-optimization/
- Fraudlogix, ads.txt, app-ads.txt and sellers.json explained | https://www.fraudlogix.com/
- IAB Tech Lab, ads.txt and sellers.json specifications | https://iabtechlab.com/ads-txt/
- Attekmi, Programmatic Guaranteed vs. PMP: Key Differences | https://attekmi.com/blog/programmatic-guaranteed-vs-pmp-deals-which-is-right-for-your-ad-strategy
- Front Porch, Programmatic Advertising for Service Providers | https://www.frontporch.com/advertising/
- Digital Applied, Incrementality Testing: Proving Ads Actually Caused Sales (2026) | https://www.digitalapplied.com/blog/incrementality-testing-paid-media-causal-lift-2026
:::
