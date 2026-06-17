---
id: vertical-qsr-09
track: vertical-qsr
module: 9
title: Footfall Attribution and Incrementality, Geo-Holdout, PSA-Control and Ghost-Bid Tests
summary: Design and read footfall measurement so reported store visits are causal incremental lift over a control, then tie that lift back to CPIV instead of selling attributed visits as if they were proof.
---
# From ad exposure to a store visit

Footfall attribution is the chain that connects an ad exposure to a later physical store visit. The mechanics are SDK-derived device locations matched to a store polygon, gated by a minimum dwell time so a car idling at a red light is not counted as a visit. The vendors you will meet are Foursquare, Cuebiq/Near, PlaceIQ/Precisely and Adsquare, and each one resolves the same exposed device to a visit using its own panel, polygon tightness and dwell threshold. This is the same geometry you QA'd at trafficking time, so a sloppy polygon upstream corrupts the visit count downstream.

The thing to internalize first is that an attributed visit is not the same as an incremental visit. Attribution answers "did an exposed device later show up at the store," but some of those people would have walked in anyway. The job in this lesson is to separate the visits the media caused from the visits that would have happened regardless.

:::figure attributionPaths
caption: Footfall attribution links an exposed device to a later store visit through SDK location matched to a store polygon with a dwell gate. The raw attributed count includes visitors who would have come anyway, which is why a control group is required to isolate causal lift.
:::

# Attributed is not incremental

Raw attributed visits overstate what the campaign actually drove. To isolate causal lift you compare the exposed group's visit rate against a control group's visit rate, and only the gap is incremental. The formula is the same one introduced with CPIV in the buyer-mandate lesson, applied now to a measured control.

$$ \text{incremental visits} = (\text{exposed visit rate} - \text{control visit rate}) \times \text{exposed audience} $$

If you report attributed visits with no control behind them you are reporting correlation, and clients increasingly reject it in the QBR. The control visit rate is your baseline for what would have happened anyway, so the entire credibility of the number rests on having a clean, matched control.

:::predict
prompt: An exposed audience of 500,000 had a 3.0% visit rate. The matched control visit rate was 2.4%. How many incremental visits did the campaign drive?
answer: 3000
tolerance: 1
unit: visits
hint: Take the gap between the two visit rates, then multiply by the exposed audience.
explain: The incremental rate is 3.0% minus 2.4% = 0.6%, or 0.006. Multiply by the exposed audience, 0.006 x 500,000 = 3,000 incremental visits. The other attributed visits among the exposed group would have happened without the media, so they are not credited to the campaign.
:::

:::quiz
question: A footfall vendor reports 40,000 attributed visits for a flight but provides no control group. What can you correctly claim?
- That at most 40,000 visits occurred, but the incremental share is unknown without a control
- That the campaign drove 40,000 incremental visits
- That the CPIV equals spend divided by 40,000
- That 40,000 is the lift over what would have happened anyway
answer: 0
hint: Without a baseline you cannot subtract the visits that would have happened regardless.
explain: With no control you only know the attributed count, not how many of those visits were caused by the media. You cannot call it incremental, you cannot build a defensible CPIV on it, and it is not lift. The honest statement is that 40,000 visits were attributed and the incremental share is unmeasured.
:::

# Three ways to build a control

There are three practical designs, and they trade rigor against feasibility. A geo-holdout splits matched test and control markets (DMAs or store sets), runs ads in the test markets only, and reads the difference in visits per capita. It is the practical sweet spot, more rigorous than a crude on/off and often $0 incremental cost when layered onto an existing campaign. A PSA-control shows the control group a public-service or charity ad, so the priming effect of seeing some ad is netted out, which is rigorous but harder to set up and not natively supported everywhere. A ghost-bid (ghost-ad) test has the DSP record which control users would have won an impression, then suppresses the serve, producing the cleanest matched cohort and increasingly used by sophisticated buyers.

The geo-holdout is where most QSR measurement actually lives because it is cheap and feasible at the franchise/DMA grain the buy already runs on. Ghost bids are the most precise but require DSP support and patience to accrue a large enough suppressed cohort.

:::figure geoHoldout
caption: A geo-holdout runs ads in matched test markets and withholds them in matched control markets, then reads visits per capita in each. The per-capita gap is the causal lift, and on an existing campaign the control simply withholds spend it would have placed anyway, so incremental cost is often zero.
:::

:::predict
prompt: In a geo-holdout, test-market visits per capita are 0.060 and matched control-market visits per capita are 0.050. What is the geo-holdout lift?
answer: 20
tolerance: 0.5
unit: %
hint: Lift is the per-capita gap divided by the control's per-capita rate.
explain: The gap is 0.060 minus 0.050 = 0.010. Divide by the control rate, 0.010 / 0.050 = 0.20, a 20% lift. Expressing lift relative to the control is what makes it comparable across markets of different baseline traffic.
:::

:::quiz
question: Which control design nets out the priming effect of merely having seen some ad, by showing the control group a charity ad instead of nothing?
- Geo-holdout
- PSA-control
- Ghost-bid
- Last-touch attribution
answer: 1
hint: One of these deliberately exposes the control group to an unrelated ad.
explain: The PSA-control shows the control a public-service or charity ad, so any uplift from simply seeing an ad is present in both groups and cancels out, isolating the effect of the brand's specific creative. Geo-holdout and ghost-bid build a no-exposure or suppressed-serve control, and last-touch is not an incrementality design at all.
:::

# Reading the lift honestly

A point-estimate lift is not a result until you know whether it is statistically distinguishable from zero. Small store sets or short flights produce wide confidence intervals, so a positive-looking lift can be noise. The discipline is a z-test on two proportions (exposed visit rate vs control visit rate): the lift is real only if the difference exceeds the confidence interval. Good measurement, in the words of the footfall methodology guidance, admits uncertainty, quantifies noise, and leans on the control and baseline rather than the headline visit number.

Test and control markets must be matched on baseline visit rate, seasonality and store density, or the "lift" is just a pre-existing difference between the markets and not the media. A vendor that cannot clearly state its visit definition (dwell threshold, polygon tightness, panel vs deterministic) is selling marketing, not measurement.

:::widget barChart
title: Exposed vs control visit rate, only the gap is incremental
labels: Exposed visit rate, Control visit rate, Incremental (lift)
data: 3.0, 2.4, 0.6
unit: %
:::

:::callout key
The incremental visit count, not the attributed visit count, is the denominator under CPIV. If you hand a client a CPIV built on raw attributed visits you have understated the true cost per incremental visit, sometimes by a wide margin, and the number will not survive a QBR challenge.
:::

# Tying lift back to CPIV

Measurement only matters because it feeds the buying KPI. Once you have incremental visits from a control-backed design, CPIV closes the loop back to the buyer mandate.

$$ \text{CPIV} = \frac{\text{media spend}}{\text{incremental visits}} $$

A ghost-bid test is worth working an example because it is the design most likely to give you a clean, small, suppressed cohort and a defensible incremental count. Suppose the test arm of a flight spent $48,000 and the exposed-minus-suppressed comparison yields 4,000 incremental visits.

:::predict
prompt: A ghost-bid test attributes 4,000 incremental visits to a flight that spent $48,000 on the exposed arm. What is the CPIV?
answer: 12
tolerance: 0.1
unit: USD
hint: Divide spend by the incremental visits the control-backed test isolated.
explain: CPIV is $48,000 / 4,000 = $12.00 per incremental visit. Because the count came from a suppressed-serve control, this is causal cost per visit, not cost per attributed visit, and it is the figure you defend in the readout.
:::

:::predict
prompt: A flight spent $90,000 and a geo-holdout isolated 9,000 incremental visits. What CPIV do you report?
answer: 10
tolerance: 0.1
unit: USD
hint: Spend over incremental visits, using the control-backed count.
explain: $90,000 / 9,000 = $10.00 per incremental visit. Because lower CPIV is better, position it against the Cuebiq Fast Food benchmarks (High-Performing $5.28, Average $8.84, Below-Average $28.65). At $10.00 it sits just above the $8.84 Average, between the Average and Below-Average bands, so it reads as middling and below the QSR average, with material room to improve toward $8.84 and ultimately the $5.28 high-performing mark.
:::

# DOOH, vendor variance and the offline gap

Programmatic DOOH adds a wrinkle: there is often no household identifier at all, so device-level attribution is impossible and lift must be inferred from exposure-area geo-holdouts, which are coarser and easier for a client to dispute. Read DOOH and a heavy-CTV mix directionally, and say so, rather than presenting an exposure-area estimate as if it were a deterministic device-to-door count.

Two more honesty traps sit at the edge of measurement. Vendor visit definitions differ, so the same flight returns different incremental counts depending on who measures it, which means you pre-agree a primary source before launch instead of cherry-picking the cheapest CPIV afterward. And roughly 65% of fast-food sales still complete at the drive-thru with no digital purchase event, so even a perfect visit count is a proxy for sales until the brand shares POS or loyalty data.

:::callout warning
A recurring r/adops and r/programmatic complaint: clients line up two footfall vendors' numbers side by side and demand to know why the visit counts (and therefore CPIV) disagree, while DOOH and CTV footfall that can only be read directionally gets treated as an exact headline figure. The defense is set before the flight runs, not after: agree one primary measurement vendor and its visit definition up front, label DOOH and CTV lift as directional in the plan, and document the dwell threshold and polygon logic so the readout is a reconciliation, not an argument.
:::

:::quiz
question: Why must DOOH footfall lift usually be read directionally rather than as a precise device-to-door attribution?
- Because DOOH inventory is never sold programmatically
- Because drive-thru sales are always captured digitally
- Because there is often no household identifier, so lift is inferred from coarser exposure-area geo-holdouts
- Because DOOH dwell times are longer than CTV dwell times
answer: 2
hint: Think about what identifier a billboard exposure does or does not carry.
explain: A DOOH exposure typically carries no household or device identifier, so you cannot match an exposed device to a later visit the way you can on mobile. Lift is estimated from exposure-area geo-holdouts, which are coarser and easier to dispute, so the honest framing is directional.
:::

:::sources
- Remerge, Incrementality Tests 101: PSA, Ghost Ads and Ghost Bids | https://www.remerge.io/blog-post/incrementality-tests-101-intent-to-treat-psa-ghost-ads-and-ghost-bids
- aidigital, Foot Traffic Attribution: polygon mapping, dwell, neighbor exclusion | https://www.aidigital.com/blog/footfall-attribution
- Cuebiq, Footfall Attribution Benchmarks (CPIV, visit rate, uplift by vertical) | https://cuebiq.com/benchmarks/
- Restaurant Dive, Drive-thru share of US fast-food sales and digital order growth | https://www.restaurantdive.com/news/drive-thru-sales-qsr/
- KORTX, Restaurant Marketing Strategy: The 2026 QSR Playbook | https://kortx.io/news/restaurant-marketing-strategy-qsr/
- AdImpact, Q1 2026 Fast Food Advertising Trends | https://adimpact.com/blog/fast-food-advertising-trends/
:::
