---
id: vertical-cpg-08
track: vertical-cpg
module: 8
title: QA and discrepancy reconciliation, DSP vs retailer vs IAS/DV vs the brand's sales read
summary: Localize and explain why four systems report four different numbers for the same CPG campaign, separate benign counting gaps from real double-counting and non-incremental credit, and land on a single defensible incrementality-anchored read.
---
# Four numbers, four systems, none of them agree

After a CPG offsite flight launches you are handed four readouts of the same campaign, and they will not match. The DSP reports impressions, clicks, and spend. The retailer reports attributed sales inside its walled garden. The verification vendor (IAS or DoubleVerify) reports viewable and valid impressions after filtering invalid traffic. The brand's own MMM or finance read reports incremental sales. The canonical CPG scene is the one your traderLens names: Amazon DSP shows 4.2x, Walmart Connect shows 3.8x, and the brand's MMM says the true incremental return is 1.6x, so the room turns to you and asks which number is real.

Reconciliation is the job here, not a chore at the end of it. The skill is to localize each gap to its cause, decide whether it is benign or decision-changing, and report the lowest causally-defensible figure rather than the flattering one. This lesson walks the four gaps in order and ends with the reconciliation ladder you present to the brand.

:::figure discrepancyWaterfall
caption: The same campaign loses or gains "performance" at each handoff. DSP-reported numbers step down through SSP or retailer counting, verification filtering, cross-platform de-duplication, and finally MMM or lift, and your job is to label each step as benign counting or a real change to the budget decision.
:::

# The impression and spend gap is almost always counting, not loss

The first gap is between what the DSP says it served and what the SSP, ad server, or retailer counted. This one is usually benign: timezone boundaries (the DSP rolls the day at midnight UTC while the SSP rolls at midnight Pacific), different counting moments (count at bid won vs at render), and invalid-traffic filtering applied on one side but not the other. A low single-digit discrepancy here is normal and you explain it, you do not chase it to zero.

The trigger for investigation is size. A gap of a few percent is timezone and counting noise. A gap of twenty or thirty percent is a tag problem, a mismatched timezone setting, or a filtering difference you have to find before any downstream number can be trusted.

:::predict
prompt: Your DSP reports 2,000,000 impressions for the flight. The SSP-side log shows 1,940,000. What is the discrepancy as a percent of the DSP-reported number?
answer: 3
tolerance: 0.2
unit: %
hint: Subtract the two counts, then divide by the DSP figure.
explain: (2,000,000 - 1,940,000) / 2,000,000 = 60,000 / 2,000,000 = 0.03, a 3 percent gap. That is comfortably inside the low-single-digit band you treat as benign timezone and counting noise, so you footnote it and move on rather than opening a ticket.
:::

# The viewability and valid-impression gap comes from sampling and IVT removal

The second gap is between DSP-reported impressions and the verification vendor's measured-and-valid count. IAS and DV measure a subset of impressions and then strip invalid traffic (bots, non-human, data-center) and non-viewable inventory, so their count is structurally lower than the DSP's raw served count. On benchmarked programmatic supply the ANA's Q3 2025 read puts invalid traffic near 0.4 percent and non-viewable inventory near 14.8 percent, which is exactly why the verified number sits below the served number even on clean supply.

This gap is mostly benign and is the same filtering that keeps your open-web spend clean (Lesson 9). You localize it to sampling plus IVT removal, confirm the vendor's measured rate is in range, and only escalate if the valid rate falls far outside benchmark, which would point at bad supply rather than a counting artifact.

:::predict
prompt: A DSP reports 1,000,000 impressions. The verification vendor counts 920,000 as measured-and-valid after filtering. What is the discrepancy as a percent of the DSP-reported impressions?
answer: 8
tolerance: 0.2
unit: %
hint: Subtract the valid count from the DSP count, then divide by the DSP count.
explain: (1,000,000 - 920,000) / 1,000,000 = 80,000 / 1,000,000 = 0.08, an 8 percent gap. That is the expected shape once you remove invalid traffic and non-viewable inventory and account for the vendor measuring a subset, so it is benign and you explain it as filtering, not loss.
:::

:::quiz
question: A DSP reports 12 percent more impressions than the verification vendor's measured-and-valid count. How should you treat this gap first?
- As lost media you should bill back to the SSP immediately
- As a likely benign sampling-plus-IVT-filtering gap to confirm against benchmark before escalating
- As proof the DSP is inflating delivery and the line should be paused
- As an attribution-window problem in the retailer console
answer: 1
hint: Verification vendors measure a subset and strip invalid and non-viewable inventory by design.
explain: The verified count sits below the served count by construction, because the vendor samples and then removes invalid traffic and non-viewable impressions. A double-digit gap is worth confirming against benchmark (IVT near 0.4 percent, non-viewable near 14.8 percent), but it is a filtering artifact first, not fraud, billing, or a window issue.
:::

# The attributed-sales gap is windows and last-touch inside each wall

The third gap is the dangerous one. Each retailer last-touch-credits sales inside its own walls on its own attribution window, and those windows differ by retailer and ad type. Amazon defaults to last-click attribution on a 14-day click window for offsite measurement, while Walmart Connect sponsored search defaults to a 3-day click window with a 14-day option, and Instacart windows vary by format. Re-pull the same impressions on a different window and the "sales" change, so a number with no window footnote is not a number you can compare.

Worse, the windows move under you. Amazon tightened its DSP view attribution in early 2026, producing double-digit declines in attributed DSP revenue that were a measurement methodology change, not a sales regression, and a trader who read that drop as performance loss would have cut a working line. Always footnote the window and the methodology version on every attributed-sales figure.

:::predict
prompt: A campaign drove 10,000 onsite-attributed sales on a 14-day window. Re-pulled on a 7-day window it shows 6,500. By how many sales does the shorter window reduce the reported count?
answer: 3500
tolerance: 0
unit: sales
hint: Subtract the shorter-window count from the longer-window count.
explain: 10,000 - 6,500 = 3,500 fewer attributed sales on the 7-day window for the exact same impressions. No media changed, only the lookback did, which is why comparing a 14-day pull to a 7-day pull as if equal manufactures a false discrepancy.
:::

:::callout key
Every attributed-sales number is window-bound and last-touch inside one retailer's walls. Footnote the window length, the ad type, and the methodology version on each figure, because Amazon 14-day, Walmart 3-day, and Instacart format-specific numbers are not the same unit and cannot be summed into one "retail media sales" total.
:::

# Cross-platform double-counting credits the same purchase twice

Two walled gardens will last-touch-credit the same physical store purchase, so naively adding Amazon-claimed and Walmart-claimed sales double-counts the household that saw both. This is real, not benign, and it changes the budget decision: the summed number overstates true reach and tempts you to scale lines that are mostly re-claiming demand other lines already touched. De-duplication needs the overlap, which only a neutral clean room or operator layer can supply, because AMC and Luminate do not join directly (Lesson 7).

The mechanics are simple once you have the overlap. Take the union of claimed sales minus the double-counted overlap to get unique de-duplicated sales, and the size of that overlap is exactly the inflation you remove before reporting anything up.

:::predict
prompt: Amazon claims 3,000 attributed store sales and Walmart claims 1,200 attributed store sales for the same brand and period. A clean-room overlap shows 800 of those are the same households credited by both. How many unique de-duplicated sales should you report?
answer: 3400
tolerance: 0
unit: sales
hint: Add the two claims, then subtract the double-counted overlap once.
explain: 3,000 + 1,200 = 4,200 summed claims, minus the 800 households both platforms claimed = 3,400 unique de-duplicated sales. The 800 overlap is the inflation the raw sum hides, and reporting 4,200 would overstate true reach and push budget into lines that are re-claiming the same buyers.
:::

# The ROAS-vs-MMM gap is platform over-credit of existing demand

The fourth and deepest gap is between platform-reported ROAS and the brand's MMM or lift read. Platform ROAS credits demand the brand already had: shoppers who would have bought anyway get counted as ad-driven, which is why a 4.2x platform number collapses to a 1.6x incremental number. This is the gap that connects reconciliation back to the signature KPI of this vertical, the marginal ROI on the next dollar, because a line whose platform ROAS looks healthy can still have an mROI below the brand's hurdle once you strip the demand it was never responsible for.

The decision rule follows directly. You report the lowest, most causal figure as truth, and you act on the margin: if the incremental read says the next dollar on the 4.2x line returns less than the hurdle, you cap its bid and shift budget to under-saturated prospecting lines (Lesson 2), regardless of how good the platform number looks.

:::predict
prompt: Amazon DSP reports 4.2x and the brand's MMM says the true incremental ROAS is 1.6x. What is the over-crediting gap (platform minus incremental) you must explain to the brand?
answer: 2.6
tolerance: 0
unit: ROAS x
hint: Subtract the incremental figure from the platform figure.
explain: 4.2 - 1.6 = 2.6x of over-credit, which is the demand the brand already had being counted as ad-driven. That 2.6x is the number you walk the brand down, and it is why the platform ROAS is never the bid input, the incremental read is.
:::

:::widget barChart
title: One line, three numbers, the reconciliation ladder (illustrative ROAS, x)
labels: DSP reported, Cross-platform de-duped, MMM incremental truth
data: 4.2, 2.8, 1.6
unit: ROAS (x)
:::

# The deliverable, and the pain everyone hits

Your output is not four dashboards forwarded up. It is one reconciled read that footnotes each number's source, window, and method, labels which gaps are benign (timezone, sampling, IVT filtering) and which are real (cross-platform double-counting, non-incremental credit), and lands on a single incrementality-anchored figure even when it is the smallest one. Reporting platform ROAS to the brand as truth is the cardinal sin of this role, because it sends budget toward saturated, already-loyal demand and fails the penetration mandate the brand actually pays for.

The reason teams move this work onto an operator or clean-room layer is volume: rebuilding the reconciliation logic by hand in a spreadsheet every month is effectively a full-time job, and the root cause is the lack of standardization that 55 percent of marketers rank as the single biggest retail media challenge (ANA, July 2024). Normalize once with a layer that emits comparable outputs, and your monthly job shifts from rebuilding formulas to explaining causality.

:::quiz
question: After reconciling, you have a 4.2x platform ROAS, a 2.8x de-duplicated cross-platform figure, and a 1.6x MMM incremental read for the same line. Which do you report to the brand as the line's true performance?
- 4.2x, because it is the number the platform optimized to
- 2.8x, because de-duplication already removed the double-counting
- 1.6x, the incrementality-anchored figure, even though it is the smallest
- The simple average of the three, to be balanced
answer: 2
hint: The reconciled truth ladder ends at the most causal figure, not the most flattering or the average.
explain: You report the 1.6x incremental read. The 4.2x over-credits existing demand and the 2.8x only removes double-counting, not non-incremental credit, while averaging three non-comparable methodologies is meaningless. The lowest causal number is the deliverable, and it is what sets the bid and budget moves.
:::

:::callout warning
The canonical operator complaint, heard across CPG AdOps teams, is blunt: "Amazon DSP shows 4.2x, Walmart Connect claims 3.8x, but our actual sales numbers don't add up, every platform lives in its own universe." The trap is treating that as a data error to fix rather than the structure of the job. The discrepancy is permanent because each walled garden defines its own window, last-touch logic, and conversion, so your value is not making the numbers match, it is explaining which gaps are benign and which change the decision, then anchoring to one causal figure. Practitioners who try to hand-reconcile every platform monthly describe it as a full-time spreadsheet job and recommend an ingestion or clean-room layer that normalizes outputs instead.
:::

:::sources
- Osmos, Walmart vs Amazon vs Instacart Attribution: 2026 Deep Dive | https://www.osmos.ai/blog/closed-loop-attribution-deep-dive-walmart-amazon-instacart
- ANA, Programmatic Transparency Benchmark Q3 2025 (IVT ~0.4%, non-viewable ~14.8%) | https://s3.amazonaws.com/media.mediapost.com/uploads/Q32025ProgrammaticTransparencyBenchmark.pdf
- ANA, Q4 2025 Programmatic Transparency Benchmark Shows Media Quality Is Now Driving Measurable Performance Outcomes | https://www.ana.net/content/show/id/pr-2026-02-programatic
- ANA, Retail Media Networks: Optimism Tempered with Caution (55% cite lack of standardization) | https://www.ana.net/content/show/id/pr-2024-07-rmn
- EMARKETER, FAQ on retail media networks: how marketers should allocate budgets in 2026 | https://www.emarketer.com/content/faq-on-retail-media-networks-how-marketers-should-allocate-budgets-2026
- LiveRamp, What is a Data Clean Room (cross-retailer identity and de-duplication context) | https://liveramp.com/explainer/data-clean-rooms
- Harvard Business Review Analytic Services, Bridging the Marketing Mix Modeling Actionability Gap | https://hbr.org/sponsored/2026/03/bridging-the-marketing-mix-modeling-actionability-gap
:::
