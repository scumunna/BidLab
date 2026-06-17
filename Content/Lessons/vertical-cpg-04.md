---
id: vertical-cpg-04
track: vertical-cpg
module: 4
title: Building the Campaign: Trafficking Across Onsite Consoles and Offsite DSPs
summary: You will be able to traffic one CPG brand plan across retailer consoles and offsite DSPs, enforce a launch-readiness gate, and tie each build to its marginal-ROI hurdle before it goes live.
---
# One plan, two to five separate builds

A CPG brand hands you one "retail media plan," but that plan is not one thing you traffic in one place. Onsite sponsored products and brand ads are built in retailer consoles (Amazon Ads, Walmart Connect), while offsite display, CTV, and audio are built in a DSP (Amazon DSP, the Walmart DSP roster, Criteo Commerce Max, DV360, The Trade Desk). Each console and each DSP is a distinct user interface with its own line-item nesting, audience attachment, fee stack, and QA surface, so the single plan fractures into two to five separate builds the trader stands up one at a time.

That fragmentation is the root cause of nearly every downstream problem, because every audience, spec, and tracking decision has to be re-made in each system, and any one of them can block launch or corrupt the reporting you reconcile later.

:::predict
prompt: A brand's retail media plan spans Amazon (onsite plus DSP), Walmart (onsite plus DSP), and Criteo offsite. Counting each onsite console and each offsite DSP as one build, how many separate campaign builds must the trader traffic?
answer: 5
tolerance: 0
unit: builds
hint: Count each distinct console and each distinct DSP as one build.
explain: Amazon onsite is 1, Amazon DSP is 2, Walmart onsite is 3, Walmart DSP is 4, and Criteo offsite is 5. One plan becomes 5 builds across 5 user interfaces, each a separate QA surface where a spec, audience, or tracking mismatch can break launch.
:::

# The offsite line-item hierarchy

Every offsite DSP build follows the same three-level shape even though each platform names and nests it differently. The campaign holds the budget, flight, and KPI. Inside it, the line item (called an ad group in some platforms) carries the audience, the supply or deal selection, the bid strategy, and the frequency cap. Inside the line item, each creative is a spec-matched asset with its tracker attached. The structure below is what you are actually clicking through in Amazon DSP, The Trade Desk, Criteo, and DV360.

$$ \text{Campaign (budget, flight, KPI)} \rightarrow \text{Line item (audience, supply, bid, frequency)} \rightarrow \text{Creative (spec-matched asset, tracker)} $$

Getting the hierarchy right at build time is what makes later cross-DSP reconciliation possible, because a naming convention enforced here is the only way the same plan in three different DSPs rolls up cleanly afterward.

:::figure lineItemTree
caption: The offsite DSP build hierarchy. The campaign carries budget, flight, and KPI; each line item carries the audience, supply or deal, bid, and frequency cap; each creative is a spec-matched asset with its tracker. Every DSP nests this same shape under different names.
:::

# Foundation first: stabilize onsite before you turn on the DSP

The operator rule that separates a working CPG build from a wasted one is sequencing: stand up and stabilize onsite Sponsored Products before you add any offsite DSP spend. Onsite Sponsored Products is keyword and item targeted, sits closest to the purchase, and is the converting foundation. DSP amplifies a working funnel, it does not repair a broken one, so offsite dollars spent against a product whose onsite conversion is weak have nothing to amplify.

This is the single most cited reason Walmart Connect ROAS "never improves past mediocre": brands jump to the DSP too early, before the Sponsored Products layer is performing. The foundation rule is therefore a build-order rule, not a budgeting opinion, and it directly protects the marginal ROI of every offsite line you later add.

:::quiz
question: A brand wants to launch offsite DSP display this week, but its onsite Sponsored Products campaigns are brand new and not yet converting. What does the foundation rule say you should do?
- Launch the DSP now, since offsite reach will lift the weak onsite conversion
- Stabilize Sponsored Products first, then add the DSP once the onsite funnel converts
- Skip Sponsored Products entirely and run only the DSP for cleaner attribution
- Launch both at maximum budget so the auction can find efficiency faster
answer: 1
hint: The DSP amplifies a working funnel rather than fixing a broken one.
explain: The foundation rule sequences onsite before offsite. DSP spend against a product with weak onsite conversion has no converting funnel to amplify, which is the most cited cause of mediocre Walmart Connect ROAS. Stabilize Sponsored Products first, then layer the DSP.
:::

# The launch-readiness gate

Before any offsite line goes live, every item on the launch gate must be true, and the trafficker treats this as a hard checklist rather than a memory exercise. The gate is the difference between a clean launch and a line that either fails to serve or pollutes reporting from day one.

$$ \text{Gate} = \text{objective set} + \text{audience attached} + \text{supply/deal selected} + \text{bid+budget set} + \text{frequency capped} + \text{spec-matched creative} + \text{naming/tracking QA} $$

Two gate items cause most launch failures. Creative trafficked at the wrong spec, or missing common sizes, is the most frequent launch blocker and a leading cause of under-pacing, so spec QA belongs at the gate, not after delivery stalls. Naming and tracking that are not standardized at the gate make the cross-DSP reconciliation in a later lesson far harder, because there is no clean way to join three differently-named builds after the fact.

:::callout key
The launch gate is binary. A line is not "almost ready" with the audience unattached or one creative size missing. It either passes every item or it does not launch, because each missing item maps to a known failure mode: no audience means no eligible bid, wrong spec means the DSP will not serve, and unstandardized naming means broken reconciliation downstream.
:::

:::quiz
question: An offsite DSP line is fully built and QA'd on every gate item except one: its creative set is missing the 300x600 size. A teammate calls it "ready enough" and wants to launch today. Under the binary launch gate, what is the correct trafficker action?
- Launch now, since one missing size out of the standard set is close enough to ready
- Launch now but flag the gap, since the DSP will backfill the missing size from the other creatives
- Hold the line off launch until the 300x600 is trafficked and spec-QA'd, because the gate passes only when every item is true
- Launch and raise the bid to compensate for the inventory the missing size cannot fill
answer: 2
hint: The gate is pass or fail on every item, and a missing size maps to a known failure mode.
explain: The launch gate is binary, so "ready enough" is not a state. A missing 300x600 leaves the inventory that size fills unwinnable, which shows up as under-pacing, and no bid increase backfills a size the line cannot serve. Hold the line, traffic and spec-QA the missing 300x600, then launch once every gate item is true.
:::

# Creative coverage and supply selection

Two build decisions sit inside the line item and quietly determine whether it can pace. The first is creative coverage: you must traffic the standard display sizes (300x250, 728x90, 160x600, 300x600, 320x50) plus video at 16:9 or 1:1 in a 15 to 30 second cut, because a line missing common sizes cannot win the inventory those sizes fill and under-paces as a result. Amazon DSP now surfaces this directly with an "Add missing creative sizes" recommendation that flags under-pacing orders, which tells you the fix for under-delivery is often trafficking, not bidding.

The second decision is supply selection: owned-and-operated versus open exchange versus a private marketplace deal, attached per line. The two decisions multiply, because the assets you traffic equal the sizes per line times the number of lines, and under-counting them is a direct cause of under-pacing.

:::predict
prompt: A trader needs 4 creative sizes per line across 6 offsite lines. How many creative assets must be trafficked and QA'd?
answer: 24
tolerance: 0
unit: assets
hint: Multiply sizes per line by the number of lines.
explain: 4 sizes per line times 6 lines equals 24 assets. Each one must be spec-matched and QA'd at the gate, because a line short on sizes cannot fill the inventory those sizes serve and will under-pace.
:::

:::predict
prompt: A trader requires 5 display sizes plus 1 CTV cut per creative concept and has 3 concepts to launch. How many distinct creative assets must be produced and spec-QA'd?
answer: 18
tolerance: 0
unit: assets
hint: Each concept needs 5 display sizes plus 1 CTV cut, then multiply by the number of concepts.
explain: Each concept needs 5 display sizes plus 1 CTV cut, which is 6 assets per concept. Across 3 concepts that is 6 times 3 equals 18 distinct assets, each spec-QA'd at the launch gate so no line goes live missing coverage.
:::

# Tying the build to the marginal-ROI hurdle

A build is not finished when it can serve. It is finished when its bid and budget are wired to the brand's marginal-ROI hurdle, because the signature CPG question is not "does this line spend" but "does the next dollar on this line earn its keep." Marginal ROI is the incremental revenue from the next increment of spend divided by that spend, and the rule you operationalize at build time is to set bids and budget so a line can scale only while its mROI clears the hurdle, commonly 1.0 incremental.

$$ \text{mROI} = \frac{\Delta \text{ incremental revenue}}{\Delta \text{ spend}} $$

If the next increment of spend on a line returns more incremental revenue than it costs, mROI exceeds 1.0 and the line earns more budget. If it returns less, mROI falls below the hurdle and the line should be capped or paused regardless of how high its blended platform ROAS looks. Wiring this hurdle into the build is what stops a trafficker from launching a line that spends cleanly yet destroys incremental value.

:::predict
prompt: A line's next $25,000 of spend returns $30,000 of incremental revenue per the lift read. The brand's hurdle is 1.0 incremental. What is the marginal ROI, and does the line clear the hurdle (answer the mROI ratio)?
answer: 1.2
tolerance: 0.01
unit: ratio
hint: Divide incremental revenue by the incremental spend, then compare to 1.0.
explain: mROI equals 30,000 divided by 25,000, which is 1.2. Because 1.2 is above the 1.0 hurdle, the next dollar earns more than it costs, so the line clears the hurdle and can take more budget.
:::

:::quiz
question: A line shows a 4.1x blended platform ROAS, but the next increment of spend on it returns only $0.80 of incremental revenue per $1.00 spent. The hurdle is 1.0 incremental. What is the correct build action?
- Scale the line, because a 4.1x blended ROAS proves it is efficient
- Cap or pause the line, because its mROI of 0.8 is below the 1.0 hurdle
- Raise the frequency cap so the line spends its full budget faster
- Leave the bid unchanged and let the platform optimize toward the 4.1x
answer: 1
hint: The decision rides on the marginal dollar, not the blended average.
explain: Blended ROAS can look strong while the marginal dollar is already unprofitable. Here mROI is 0.80, below the 1.0 hurdle, so the next dollar destroys incremental value. Cap or pause the line and move that budget to a line whose mROI still clears the hurdle.
:::

# Why each DSP build feels different, and the trap in it

Standing up the same plan in Amazon DSP, The Trade Desk, Criteo, and DV360 means re-learning each interface, because every DSP nests and names line items differently and each has its own audience attachment and fee behavior. The market is concentrated but not uniform: DV360 commands the largest share of global DSP spend (roughly 40 percent or more by 2025-2026 estimates) while The Trade Desk holds a smaller share (around 19 to 26 percent) but a disproportionate slice of premium CTV and open-internet supply. The chart below shows that split, which is why a CPG trader often runs more than one DSP rather than standardizing on a single tool.

The build trap is that retailer first-party audiences are now reachable through more than one path. Walmart opened its DSP roster beyond The Trade Desk (launch partners now include additional platforms, with Yahoo DSP among the newer ones and more planned), so the same Walmart 1P audience can be wired through different DSPs at different fees and match behavior. Choosing the path deliberately, rather than by habit, is a real cost lever newcomers overlook.

:::widget barChart
title: Approximate global DSP spend share (2025-2026 estimates)
labels: DV360, The Trade Desk, Amazon DSP, All others
data: 40, 22, 24, 14
unit: percent share of global DSP spend
:::

:::callout warning
A recurring operator complaint: every DSP nests and names line items differently, so standing up one brand plan across Amazon DSP, The Trade Desk, and Criteo means re-learning each interface and re-doing QA per platform, and the same retailer 1P audience prices and matches differently depending on which DSP you wire it through. Enforce one naming convention across all of them at build time and pick the audience path on fees and match rate, not on whichever interface you know best, or the cross-system reconciliation later becomes a manual, error-prone rebuild.
:::

:::sources
- EMARKETER, Walmart Connect expands offsite retail media beyond its own DSP | https://www.emarketer.com/content/walmart-connect-expands-offsite-retail-media-beyond-its-own-dsp
- Walmart Connect, Expanding access to Walmart first-party data across leading platforms | https://www.walmartconnect.com/resources/articles/2026/expanding-access-to-walmart-first-party-data-across-leading-platforms
- Digiday, As Walmart looks beyond The Trade Desk, brands look for their angle | https://digiday.com/media-buying/media-agencies-hope-to-drive-down-costs-as-walmart-opens-up-dsp-roster/
- Amazon Ads, Optimize Amazon DSP campaign pacing with additional creative sizes | https://advertising.amazon.com/resources/whats-new/optimize-amazon-dsp-campaign-pacing-with-additional-creative-sizes
- Improvado, The Trade Desk vs DV360: A 2026 DSP comparison for marketers | https://improvado.io/blog/dv360-vs-the-trade-desk
- SellTru, Walmart Connect Ads 2026: The brand owner's guide | https://selltru.com/blog/walmart-connect-ads-guide
- Tinuiti, Walmart's Demand-Side Platform (DSP): Key marketing guidance | https://tinuiti.com/blog/commerce/walmart-dsp/
:::
