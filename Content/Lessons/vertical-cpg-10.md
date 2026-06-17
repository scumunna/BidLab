---
id: vertical-cpg-10
track: vertical-cpg
module: 10
title: Measurement Execution and Seasonal Flighting, Running Lift Tests and Pacing the Calendar
summary: Stand up geo holdout, ghost-ads, and clean-room lift tests that produce defensible incremental numbers, read them against MMM on cadence, and shape a flat-or-seasonal budget into a flighting curve that lands on plan.
---
# The capstone, where the incremental number comes from

Every earlier lesson leaned on an incremental read: the bid ceiling in Lesson 2, the reconciled truth in Lesson 8, the brand hurdle the trader defends. This lesson is where the trader actually produces those reads. The signature CPG KPI is marginal ROI, the return on the next dollar, $\text{mROI} = \Delta \text{incremental revenue} / \Delta \text{spend}$, and a lift test is the only instrument that measures it causally rather than crediting demand the brand already had. The trader who can stand up a test, check its significance, and translate the result into a bid and a flighting curve has closed the full 0-to-100 loop.

The three execution methods the trader runs are geo holdout (pair similar regions, expose one set, hold the other out, read the gap), ghost-ads or PSA conversion lift (serve a control that registers exposure without showing the ad), and clean-room incrementality (causal queries inside AMC or Walmart Luminate). Adoption is now mainstream: 52% of US brand and agency marketers use incrementality testing and experiments to measure campaigns (EMARKETER/TransUnion, July 2025), so the trader is expected to run these, not just read a vendor slide.

:::predict
prompt: A trader spends an extra $50,000 on a line and a lift test attributes $65,000 of incremental revenue to that next increment. What is the marginal ROI of that dollar?
answer: 1.3
tolerance: 0.05
unit: mROI x
hint: mROI is the incremental revenue from the next dollars divided by the extra spend that produced it.
explain: mROI = $65,000 / $50,000 = 1.3. That clears the 1.0 incremental hurdle, so the next dollar on this line still creates value and the trader can keep funding it. Note this is the return on the NEXT increment, not the line's blended ROAS, which can look far higher while the marginal dollar has already decayed below the hurdle.
:::

:::callout key
mROI is the return on the NEXT dollar, not the average dollar. A line can show a strong blended ROAS while its mROI has already fallen below the hurdle, which is exactly when the trader should stop scaling it. The lift test is what tells you which world you are in.
:::

# Running the geo holdout, the trader's workhorse test

A geo holdout splits the country into test markets that get the media and matched control markets that do not, then reads the sales gap as incremental lift. The math is direct: $\text{iROAS} = (\text{sales in test geos} - \text{sales in matched holdout}) / \text{incremental spend}$. The design discipline is what separates a real read from noise: match control geos to test geos on history (modern setups calibrate on dozens of variables, Albertsons cites nearly 60 for store-level matching), size the test for at least 80% power to detect your minimum lift, run it 4 to 8 weeks, and watch for spillover where a control region accidentally sees the media.

Benchmarks tell the trader what a healthy read looks like. Across a dataset of 225 geo and holdout experiments, the median iROAS was about 2.31 with roughly 88.4% of well-designed tests reaching statistical significance (Stella, Aug 2024 to Dec 2025). That second number matters as much as the first: a well-built test usually resolves, so a test that fails to reach significance often signals a design flaw (poorly matched geos, too little spend, too short a window) rather than zero effect.

:::predict
prompt: In a geo test, the test geos generated $480,000 in sales versus $300,000 in the matched holdout geos, on $112,500 of incremental media spend. What is the incremental ROAS?
answer: 1.6
tolerance: 0.05
unit: ROAS x
hint: Incremental sales is test minus holdout; divide that by incremental spend.
explain: Incremental sales = $480,000 - $300,000 = $180,000. iROAS = $180,000 / $112,500 = 1.6. That sits below the ~2.31 geo-test median, so the trader treats this line as modestly incremental and would not scale it aggressively.
:::

:::figure geoHoldout
caption: A geo holdout exposes matched test markets and withholds matched control markets. The sales gap between them, divided by incremental spend, is the causal iROAS the trader reports, provided the geos are matched and the result reaches significance.
:::

# Ghost-ads and PSA lift, the user-level cousin

When geo splitting is too coarse, the trader runs a user-level lift test. In ghost-ads (and the older PSA variant) the platform identifies the users who WOULD have been served the ad, then shows the control group nothing (or a public-service ad) while logging that they were eligible. Incremental conversions are the exposed-group rate minus the control-group rate, applied to the exposed audience: $\text{incremental conversions} = (r_{\text{exposed}} - r_{\text{control}}) \times N_{\text{exposed}}$. Because both groups were genuinely eligible, the difference isolates the ad's causal effect rather than the audience's pre-existing intent.

The control group is the whole game. If control users see the ad somewhere else (a different line, a different platform, an organic touch), the control is contaminated, the measured lift collapses, and the trader reports a falsely low number. Kroger Precision Marketing runs randomized holdouts against loyalty data covering roughly 95% of transactions and returns reads in under two weeks (EMARKETER, 2026), which is the kind of clean panel that makes user-level lift trustworthy.

:::predict
prompt: A ghost-ads test shows a 5.0% conversion rate in the exposed group and 3.5% in the PSA control group, applied to 400,000 exposed users. How many incremental conversions did the media drive?
answer: 6000
tolerance: 0
unit: conversions
hint: Take the rate difference first, then apply it to the exposed audience.
explain: Rate lift = 5.0% - 3.5% = 1.5%. Incremental conversions = 0.015 x 400,000 = 6,000. The raw exposed count would credit 0.05 x 400,000 = 20,000 conversions, so 14,000 of those would have happened anyway and are NOT incremental.
:::

:::quiz
question: A ghost-ads test returns a surprisingly low incremental lift. Before reporting it, what is the FIRST thing the trader should check?
- Whether the exposed group was large enough to spend the budget
- Whether the control group was contaminated by seeing the ad elsewhere
- Whether the platform-reported ROAS was above the brand hurdle
- Whether the creative used all required display sizes
answer: 1
hint: A user-level lift test is only as clean as its control.
explain: If control users were exposed to the ad through another line or platform, the control rate rises toward the exposed rate and the measured lift shrinks toward zero. A contaminated control is the most common reason a real effect reads as flat, so the trader validates control isolation before reporting. Platform ROAS and creative sizes do not affect the causal lift calculation.
:::

# Clean-room incrementality and the truth ladder

Inside a retailer clean room the trader runs causal queries against purchase data: AMC SQL against Amazon Ads plus the advertiser's first-party data, or the Walmart Luminate equivalent. These produce matched, in-window incrementality reads, but they inherit the constraints from Lessons 3 and 7: a result is gated by match rate, and a query cannot span two walled gardens (AMC and Luminate cannot be joined directly, so cross-retailer work needs a neutral room or operator layer). The trader's job is to know which causal read came from which room before rolling anything up.

The reads will disagree, and the trader reconciles them on a truth ladder rather than picking a favorite: platform-reported ROAS sits highest and least causal, de-duplicated cross-platform sits in the middle, and the incrementality or MMM-anchored figure sits lowest and most defensible. The deliverable to the brand is the lowest, most causal number that the budget decision can stand on. This is why the canonical CPG discrepancy (Amazon DSP 4.2x, Walmart 3.8x, MMM 1.6x) resolves DOWN, not to an average.

:::widget barChart
title: The truth ladder, same campaign by measurement method (illustrative)
labels: Platform-reported ROAS, De-duped cross-platform, Clean-room/MMM incremental
data: 4.2, 2.8, 1.6
unit: ROAS (x)
:::

:::quiz
question: A clean-room incrementality query and the platform's reported ROAS disagree sharply. Which number does the trader report to the brand as the defensible one?
- The platform-reported ROAS, because it is the largest
- The clean-room incremental figure, because it is causally anchored
- The average of the two, to split the difference
- Whichever is closest to last quarter's number
answer: 1
hint: Walk the truth ladder from least causal to most causal.
explain: Platform ROAS over-credits demand the brand already had and sits at the top of the ladder. The clean-room or MMM-anchored incremental number is the causal one and is the deliverable, even though it is the smallest. Averaging two non-comparable methods or anchoring to a prior quarter manufactures a number with no causal meaning.
:::

# Measurement cadence and the actionability gap

Tests only matter if the trader acts on them in time, and the data says most teams do not. In a March 2026 Harvard Business Review Analytic Services study (n=547, fielded Sept-Oct 2025), 87% of marketers said MMM is important but only 28% said their organization is very effective at turning that insight into timely, impactful action. That 87/28 gap IS the trader's job description: causally validated measurement commonly improves media efficiency 10% to 30% when the trader actually reallocates against it, and yields nothing when the insight sits in a deck.

Cadence keeps the loop honest. The practitioner rhythm is to refresh MMM roughly quarterly for budget reallocation, run geo and lift tests per major flight, and reconcile MMM against platform and clean-room reads before reporting (Lesson 8). Refreshing MMM too rarely (for example annually) leaves the trader optimizing against stale elasticities while the season changes underneath them, which is especially dangerous in CPG where demand swings hard by quarter.

:::predict
prompt: A trader reallocates against a fresh lift read and lifts media efficiency by 18% on a $2,500,000 quarterly working-media budget. How much effective working media does that 18% gain free up?
answer: 450000
tolerance: 0
unit: USD
hint: Apply the efficiency gain to the budget.
explain: 0.18 x $2,500,000 = $450,000 of effective working media recovered, squarely inside the 10% to 30% range causally validated measurement delivers when the trader acts on it. That freed budget is what funds the next under-saturated prospecting line.
:::

# Equalizing mROI across lines after a test

The payoff of measurement is the reallocation rule from Lesson 2, now driven by real numbers: shift budget toward lines until mROI is equalized across them, and cap or pause any line whose mROI falls below the hurdle (commonly 1.0 incremental). After a lift test the trader has a measured mROI per line, so the move is mechanical: pull dollars off the saturated line whose next dollar returns less and push them to the under-saturated line whose next dollar returns more, until the marginal returns meet.

This is where the trader earns the seat. Leadership often sees a high blended ROAS and pushes to scale that line, but if its mROI is already below the hurdle, scaling it pours budget into demand the brand already owned. The lift read is the evidence that lets the trader cap the 4.2x line and defend moving the freed budget to a prospecting line measured at a healthier margin.

:::predict
prompt: Line A's next dollar returns $0.80 of incremental revenue (mROI 0.80) and Line B's next dollar returns $1.90 (mROI 1.90), against a 1.0 hurdle. Which line should the trader cap, and which should receive the reallocated budget?
answer: 0
tolerance: 0
unit: code (0 = cap A, fund B)
hint: Compare each line's mROI to the 1.0 hurdle and to each other.
explain: Line A's mROI of 0.80 is below the 1.0 hurdle, so its next dollar destroys incremental value and the trader caps it. Line B's mROI of 1.90 is the higher marginal return, so it receives the reallocated budget until its mROI falls toward A's and they equalize. Answer 0 encodes cap A, fund B.
:::

:::callout warning
A recurring operator pain point: leadership conflates average ROAS with marginal value and pushes the trader to scale the 4x line. The defense is a clean lift read showing that line's mROI is already below 1.0. Without it, the trader has no evidence and the budget gets poured into a saturated, non-incremental line, which is the single most expensive mistake in CPG trading.
:::

# Seasonal flighting, pacing the calendar to the JBP

CPG demand is not flat, so a flat pacing curve is wrong twice: it wastes budget off-peak and under-delivers at the tentpole. Spend follows retailer joint-business-plan calendars and category tentpoles (summer beverages, back-to-school, holiday), so the trader shapes a flat-or-committed budget into a flighting curve indexed to the season, then paces to that curve using the levers from Lesson 5 (budget caps, dayparting, frequency caps) so committed dollars land without going dark before the purchase window. A real CPG proof point: the Albertsons Media Collective and Mondelez matched-market test delivered about $2.41 incremental ROAS and roughly 14% in-store sales lift across 116 locations, the kind of seasonally timed, defensible read the trader is hired to produce.

The arithmetic of flighting is index-weighting a base. Take an annual budget, find the even monthly share, then scale each month by its seasonal index (100 = average month). The trader still has to land total committed spend on plan, so over-weighting the tentpoles means deliberately under-weighting the troughs by the offsetting amount.

:::predict
prompt: A brand commits $1,200,000 for the year across 12 months. The even monthly share is the baseline (index 100). What does the trader plan to spend in a holiday month indexed at 160?
answer: 160000
tolerance: 0
unit: USD
hint: Find the even monthly share first, then scale it by the index.
explain: Even monthly share = $1,200,000 / 12 = $100,000 (index 100). Holiday month at index 160 = $100,000 x 1.60 = $160,000. The extra $60,000 over baseline must be pulled from below-average months so the full $1,200,000 still lands on plan.
:::

:::widget lineChart
title: Seasonal flighting curve, indexed monthly spend (100 = average)
labels: Jan, Mar, May, Aug, Nov, Dec
data: 60, 70, 110, 120, 160, 150
unit: index (100 = avg month)
:::

:::sources
- EMARKETER, FAQ on incrementality: how to prove your ads actually work in 2026 | https://www.emarketer.com/content/faq-on-incrementality-how-prove-your-ads-actually-work-2026
- Marketing Dive, Mondelez lifts sales as Albertsons tackles in-store retail media measurement | https://www.marketingdive.com/news/mondelez-lifts-sales-albertsons-tackles-in-store-retail-media-measurement/808842/
- Albertsons Companies, Albertsons Media Collective launches incrementality measurement | https://www.albertsonscompanies.com/newsroom/press-releases/news-details/2026/Albertsons-Media-Collective-Launches-Incrementality-Measurement-to-Prove-True-Media-Impact-of-In-Store-Campaigns-and-Plans-Expansion/default.aspx
- HBR Analytic Services, Bridging the Marketing Mix Modeling Actionability Gap | https://hbr.org/sponsored/2026/03/bridging-the-marketing-mix-modeling-actionability-gap
- Stella, 2025 DTC Digital Advertising Incrementality Benchmarks | https://www.stellaheystella.com/blog/2025-dtc-digital-advertising-incrementality-benchmarks
- Triple Whale, GeoLift 101: your guide to geo-based incrementality testing | https://www.triplewhale.com/blog/geolift-geo-based-incrementality-testing
- Osmos, Closed-loop attribution deep dive: Walmart vs Amazon vs Instacart | https://www.osmos.ai/blog/closed-loop-attribution-deep-dive-walmart-amazon-instacart
- ANA, Programmatic Transparency Benchmark Q3 2025 | https://www.ana.net/miccontent/show/id/rr-2025-11-programmatic-transparency-benchmark-q3
:::
