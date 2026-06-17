---
id: vertical-cpg-09
track: vertical-cpg
module: 9
title: Verification, brand safety, and creative specs, keeping offsite spend clean and live
summary: Configure pre-bid and post-bid verification, set MFA and IVT and suitability controls to the brand's tier, and traffic full-coverage spec-correct creative so offsite lines launch and pace instead of stalling.
---
# What verification actually buys you offsite

When a CPG trader spends offsite in the DSP, every impression rides open or PMP supply that the brand does not own, so verification is the layer that keeps that spend off junk inventory before and after it serves. The trader configures two things: a pre-bid segment that blocks unsafe, invalid, or made-for-advertising supply before the auction, and post-bid measurement (IAS, DV) that verifies viewability, suitability, and invalid-traffic rates after the impression renders. The same filtering is why DSP-reported impressions and verification-counted impressions never match exactly (the discrepancy you reconcile in Lesson 8), so understanding verification here is what lets you explain that gap there. The order of operations is the whole point: pre-bid stops you paying for waste, post-bid only tells you about waste you already bought.

$$ \text{verification stack} = \text{pre-bid block (before auction)} + \text{post-bid measurement (after render)} $$

:::predict
prompt: A trader buys an open-exchange line with no pre-bid block, then layers post-bid measurement on top. Of the two layers, how many recover money you have already spent on bad impressions?
answer: 0
tolerance: 0
unit: layers
hint: Think about when each layer acts relative to the auction.
explain: The answer is 0. Pre-bid blocking acts before the auction, so it prevents the spend rather than recovering it, and post-bid measurement acts after the render, so it only documents waste you already paid for. Neither layer claws spend back after the fact, which is exactly why the pre-bid block has to be set first instead of leaned on as a reporting afterthought.
:::

:::callout key
Pre-bid blocking is cheaper than post-bid reporting. A pre-bid MFA or IVT segment costs you nothing per blocked bid, while post-bid measurement just documents the waste you already paid for and now have to explain in reconciliation. Set the block first, measure second.
:::

# Made-for-advertising and invalid traffic, why the blocks stay on

Made-for-advertising (MFA) sites exist to arbitrage ads, not to serve real audiences, and even after the post-Adalytics cleanup they still draw spend on the open web. The ANA Q3 2025 Programmatic Transparency Benchmark put MFA at roughly 0.39 to 0.4 percent of spend on monitored supply, collapsed from the 15 percent of programmatic spend the ANA flagged in its 2023 baseline, while invalid traffic (IVT) held near 0.4 percent and non-viewable inventory sat around 14.8 percent on benchmarked supply. The catch the trader must internalize: that sub-1-percent number describes clean, monitored buys with blocks already in place. Look wider at the open programmatic web and the long tail is not clean. Pixalate's Q2 2025 benchmark still flagged about 10 percent of global open programmatic web spend (roughly 716 million dollars) going to MFA domains, which is the supply your pre-bid block is keeping you out of. The MFA share of a monitored buy is low precisely because somebody set the block, not because the open web cleaned itself up.

:::predict
prompt: An open-exchange line spends 4,000,000 dollars across the broad open programmatic web with no MFA block. Using Pixalate's Q2 2025 open-web rate of about 10%, how many dollars land on MFA domains?
answer: 400000
tolerance: 0
unit: dollars
hint: Take 10 percent of the spend.
explain: 4,000,000 times 0.10 equals 400,000 dollars landing on MFA domains. That is the spend a pre-bid block keeps you out of before the auction, so you never pay for it instead of discovering it in a post-bid report. Note this is the unmonitored open-web rate; on clean monitored supply ANA measures MFA near 0.4 percent precisely because the block is already set.
:::

:::widget barChart
title: Why the trader keeps MFA and IVT blocks on (programmatic spend, %)
labels: MFA 2023 baseline, MFA monitored 2025 (ANA), MFA open web 2025 (Pixalate), IVT monitored 2025 (ANA)
data: 15, 0.4, 10, 0.4
unit: percent
:::

# Setting viewability, suitability, and the brand's risk tier

Viewability and brand suitability are not one global setting, they are dialed to the channel and to the specific brand. On display the trader holds a viewability target and watches the roughly 14.8 percent non-viewable share, while CTV runs far higher: IAS measures CTV viewability near 93 percent on average and premium streaming PMPs run close to fully viewable, which is a concrete quality reason CPG traders favor deals (Lesson 6) over open auction for video. Brand suitability is brand-specific, not a default, because a category-sensitive CPG brand (think a kids cereal or an alcohol brand) will block contexts that another brand happily allows. The trader applies the brand's suitability tier and blocklist or allowlist, then verifies post-bid that delivery actually respected it.

:::quiz
question: A CPG trader wants the highest-viewability offsite video supply for a brand. Which choice best reflects the 2025 benchmarks?
- Open-auction display, because reach is widest there
- A premium streaming CTV PMP, where viewability runs near fully viewable
- Open-auction CTV, because all CTV is identical in quality
- Whichever line has the lowest CPM regardless of channel
answer: 1
hint: One channel and deal type sits near the top of the 2025 viewability benchmarks.
explain: Premium streaming CTV PMPs run near fully viewable (CTV averages around 93 percent and premium PMPs higher), which is exactly why CPG traders route video through deals rather than open auction. Open-auction display and untiered open CTV carry more non-viewable and lower-quality risk, and chasing the lowest CPM ignores quality entirely.
:::

# The creative-coverage problem, the real CPG launch blocker

The verification half keeps spend clean, but the half that actually stalls CPG launches is creative ops: trafficking the right specs at full size coverage. Offsite display requires the standard set the DSP serves against, 300x250, 728x90, 160x600, 300x600, and 320x50, with video at 16:9 or 1:1 in a 15 to 30 second cut, and onsite has its own retailer image, title, and item rules. When a line is missing common sizes it cannot fill enough inventory, so it under-paces, which is why Amazon DSP surfaces an explicit "Add missing creative sizes" recommendation on underpacing orders. The operational lesson: missing or wrong-spec creative is the most frequent launch blocker and a top cause of the under-pacing you saw in Lesson 5, so size coverage is a launch-gate item, not something you fix after delivery stalls.

$$ \text{creative launch gate} = \text{onsite specs met} + \text{all required offsite sizes} + \text{video ratio and duration} + \text{DCO feed validated} $$

:::predict
prompt: A trader needs 5 display sizes plus 1 CTV cut per creative concept and has 3 concepts to launch. How many distinct creative assets must be produced and spec-QA'd?
answer: 18
tolerance: 0
unit: assets
hint: Assets per concept times number of concepts.
explain: Each concept needs 5 display sizes plus 1 CTV cut, which is 6 assets. Across 3 concepts that is 6 times 3 equals 18 distinct assets, every one of which has to clear spec QA before the launch gate opens.
:::

:::figure discrepancyWaterfall
caption: Verification filtering removes invalid, MFA, and non-viewable impressions from the served pool, so the brand-safe impressions a verification vendor credits are fewer than the DSP requested. The same filtering drives the DSP-versus-verification count gap the trader reconciles in Lesson 8.
:::

# Dynamic creative and the feed that silently breaks

Retail CPG leans on dynamic creative optimization (DCO) to pull live price, availability, and the retailer logo into each impression, which is powerful and is also a quiet failure mode. If the price or availability feed lapses, the line keeps serving but renders stale offers, advertising a promo that ended or a product that is out of stock, and nothing in the delivery report flags it because the line is technically live. The trader validates the DCO feed as part of creative QA, not just at launch but on an ongoing basis, because a feed that was healthy on day one can go stale mid-flight. This is the creative analog of the verification discipline: a thing that looks live in the platform can still be quietly wrong.

:::predict
prompt: A DCO line serves 2,000,000 impressions over a flight, but a lapsed price feed renders a stale (ended) promo on the final 25% of impressions. How many impressions advertised the wrong offer?
answer: 500000
tolerance: 0
unit: impressions
hint: Take 25 percent of total served impressions.
explain: 2,000,000 times 0.25 equals 500,000 impressions that ran a stale offer. The line looked perfectly healthy in the pacing report the whole time, which is exactly why feed validation belongs in ongoing creative QA, not just at launch.
:::

# What goes wrong, and the pain points that catch you

The two failure families converge on launch and on reconciliation. On creative, wrong-spec or missing-size assets are the single most common reason a launch slips or a line under-delivers, and trafficking teams describe it bluntly: the DSP will not serve because the size sheet did not match the ask. On verification, open-web buyers warn that the cleanup is concentrated on monitored supply, so even though ANA measures MFA near 0.4 percent on monitored buys, third-party measurement (Pixalate Q2 2025) still flags roughly 10 percent of open programmatic web spend going to MFA on the broader long tail, which is why pre-bid MFA and IVT blocks remain non-negotiable rather than a legacy setting you can relax. Both problems are preventable at the gate, which is the whole reason verification and creative QA are launch-readiness items and not post-launch firefighting.

:::callout warning
Operator pain point: trafficking teams cite wrong-spec or missing-size creative as the top reason a launch slips, summed up as "the DSP won't serve and the size sheet didn't match the ask," while open-web buyers note that the post-Adalytics cleanup mostly cleaned monitored supply. ANA puts MFA near 0.4 percent on monitored buys, but Pixalate's Q2 2025 benchmark still flags about 10 percent of open programmatic web spend going to MFA on the long tail, so pre-bid MFA and IVT blocks stay on. Treat full size coverage and pre-bid blocks as launch-gate items, because both failures are silent until the line under-delivers or the reconciliation gap shows up.
:::

:::quiz
question: An offsite line is under-pacing and the DSP shows an "Add missing creative sizes" recommendation. What is the correct first move?
- Add the missing standard creative sizes so the line can fill more inventory
- Lower the bid, since under-pacing means the bid is too high
- Pause the line and rebuild it in a different DSP
- Raise the frequency cap to force more impressions to existing buyers
answer: 0
hint: The DSP is telling you the cause directly, and it is not the bid.
explain: Under-pacing flagged with a missing-sizes recommendation is a creative-coverage problem, so the fix is to add the standard sizes (300x250, 728x90, 160x600, 300x600, 320x50) so the line can fill more inventory. Lowering the bid before adding sizes wastes a cycle, and raising frequency just deepens hits on existing buyers, which hurts the penetration mandate from Lesson 2.
:::

:::sources
- ANA, Q3 2025 Programmatic Transparency Benchmark (MFA ~0.39% of monitored spend, IVT ~0.4%, non-viewable ~14.8%) | https://s3.amazonaws.com/media.mediapost.com/uploads/Q32025ProgrammaticTransparencyBenchmark.pdf
- The Current, How MFA collapsed and signal quality became the new performance frontier (15% of spend in 2023 collapsed to ~0.4%) | https://www.thecurrent.com/opinion/mfa-collapsed-signal-quality-performance-frontier
- Pixalate, Q2 2025 Global Made for Advertising (MFA) Benchmarks Reports (~10% of open programmatic web spend, ~$716M, to MFA) | https://www.pixalate.com/blog/pixalates-q2-2025-global-made-for-advertising-mfa-benchmarks-reports
- Amazon Ads, Optimize Amazon DSP campaign pacing with additional creative sizes | https://advertising.amazon.com/resources/whats-new/optimize-amazon-dsp-campaign-pacing-with-additional-creative-sizes
- Amazon Ads, Amazon DSP desktop and mobile web static display ad specs | https://advertising.amazon.com/resources/ad-specs/dsp/desktop
- Integral Ad Science, Measuring what matters on Connected TV | https://integralads.com/insider/measuring-what-matters-on-connected-tv/
- StackAdapt, Why are viewability rates on connected TV so high | https://www.stackadapt.com/resources/blog/connected-tv-viewability
:::
