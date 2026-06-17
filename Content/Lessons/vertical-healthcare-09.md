---
id: vertical-healthcare-09
track: vertical-healthcare
module: 9
title: Troubleshooting and QA, diagnose a failing campaign
summary: Diagnose an underperforming HCP campaign in a fixed top-down order so you name the broken funnel stage and the specific fix before touching a single lever.
---
# Work the funnel top-down, not the dashboard

When a healthcare campaign underperforms, the amateur reaction is to grab the loudest number on the dashboard and start moving bids. The operator instead runs a fixed diagnostic order: match rate first, then delivery and pacing, then cross-channel frequency dedup, then the proxy signal, and only last the lift and its statistical power. The order matters because each stage feeds the next, and because in pharma almost every fix has a regulatory or measurement side effect, so a blind tweak can break compliance while it chases performance.

The discipline is to produce a written diagnosis that names one broken stage and one specific fix, not a guess. A campaign that "feels slow" is not a diagnosis. "Match rate cratered from 78% to 55% after a vendor graph refresh on the 9th, so 45% of target NPIs went unaddressable, more than double the 20% rebuild threshold" is a diagnosis.

:::quiz
question: A healthcare campaign is underperforming. What is the correct first stage to check in the diagnostic order?
- The lift study's statistical power
- The NPI-to-device match rate
- The creative engagement rate
- The end-of-flight cost per script
answer: 1
hint: Start at the top of the funnel, with whether you can even address the audience.
explain: Match rate is first because if the DSP cannot connect target NPIs to live ad opportunities, every downstream metric (delivery, frequency, proxy, lift) is reading a broken foundation. Power and cost per script are last; engagement is a proxy you check after delivery.
:::

# Stage one, did match rate crater

The single biggest source of waste in HCP programmatic is a broken NPI-to-device match, so it is the first stop. Pull the match report and look for the named failure modes: a vendor identity-graph refresh, a list of stale or retired NPIs (typically 6 to 9 percent of a list), hospital-IP blocks that make on-premise prescribers look unmatched (5 to 8 percent), missing taxonomy (4 to 7 percent), email-domain collisions, and multi-state license conflicts. The rule is hard: if total NPI match-failure exceeds 20 percent, rebuild the identity graph before you relaunch, because campaigns routinely waste 15 to 30 percent of spend when the match breaks.

$$ \text{match rate} = \frac{\text{addressable NPIs}}{\text{target NPIs}} \qquad \text{wasted exposure} \approx \text{spend} \times (1 - \text{match rate}) $$

:::predict
prompt: You target 36,000 NPIs and the DSP can address 27,000 with live opportunities. What is the match rate?
answer: 75
tolerance: 0.5
unit: %
hint: Match rate is addressable NPIs divided by target NPIs.
explain: 27,000 / 36,000 = 0.75, a 75 percent match rate. That leaves 9,000 NPIs unaddressable, and 9,000 / 36,000 = 25 percent, which is 5 points over the 20 percent rebuild trigger, so the rule says rebuild the identity graph before relaunch. The composition of that 25 percent tail only sharpens the urgency: if those 9,000 skew toward your high-decile core rather than in-market noise, the rebuild is even more pressing, but at 25 percent the trigger has already fired either way.
:::

:::predict
prompt: A $600,000 line is running at a 58% match rate. Roughly how much spend is exposed to unmatched or mismatched delivery?
answer: 252000
tolerance: 1000
unit: USD
hint: Multiply spend by one minus the match rate.
explain: 600,000 times (1 minus 0.58) = 600,000 times 0.42 = 252,000. At a 58 percent match rate you are exposing $252,000 to delivery against NPIs the graph cannot confirm, and the 42 percent failure is more than double the 20 percent rebuild threshold.
:::

:::figure npiTargeting
caption: The match report is the first diagnostic. Each target NPI must resolve to real devices through the identity graph; the unmatched and mismatched tail is where 15 to 30 percent of spend leaks when the graph goes stale.
:::

# Stage two, is pacing behind on an MLR-gated flight

If match rate is healthy, check delivery. In pharma, pacing failures hide behind regulatory and supply causes, not bid caps. First confirm the creative is still MLR-approved and has not been silently paused, because an expired approval forces an immediate stop on that asset and the dashboard will read "underdelivery" with no obvious reason. Next check whether brand-safety over-blocking is starving supply: aggressive keyword blocklists routinely strip legitimate medical and news inventory, choking pacing on perfectly safe content. Only after ruling those out do you re-pace against the remaining flight days.

$$ \text{required daily pace} = \frac{\text{remaining budget}}{\text{remaining flight days}} $$

:::predict
prompt: A flight has $420,000 left with 28 days remaining. What is the required daily pace to land on budget?
answer: 15000
tolerance: 50
unit: USD per day
hint: Divide the remaining budget by the remaining flight days.
explain: 420,000 / 28 = 15,000 per day. If yesterday's actual was well under $15,000, the question is why (paused creative, over-blocked supply, deal under-fill), not simply raise the bid, because the response window closes at flight end and underdelivery cannot be recovered after the Rx-lag window passes.
:::

:::callout warning
A recurring operator pain point: traders chase a pacing shortfall for days only to discover an MLR-expired creative was quietly auto-paused, or a third-party keyword blocklist was starving the buy by stripping legitimate medical publishers. Always confirm creative-approval status and audit the blocklist for false positives before you re-pace, because loosening the blocklist to fix pacing can re-introduce brand-safety risk you then have to re-check.
:::

# Stage three, reconcile frequency across channels

Pharma caps frequency at roughly 3 exposures per HCP per week across all channels combined, because the response curve flattens after the third touch and the fourth through sixth add negligible lift while risking negative HCP sentiment. The trap is that endemic, EHR, open-web, and CTV DSPs each count frequency in their own silo, so per-channel caps do not equal a global cap. The fix is to reconcile every channel's frequency into one NPI-level view and find the dedup gap, then tighten coordinated caps so the highest-value prescribers are not overserved.

$$ \text{overdelivery} = \sum_{\text{channels}} \text{frequency}_\text{channel} - \text{unified cap} $$

:::predict
prompt: An NPI receives 3 impressions/week on endemic, 2 on open web, and 2 on CTV with no cross-channel dedup. By how much does combined weekly frequency exceed a 3/week cap?
answer: 4
tolerance: 0
unit: exposures per week
hint: Sum the per-channel frequencies, then subtract the unified cap.
explain: 3 plus 2 plus 2 = 7 exposures per week, and 7 minus the 3/week cap = 4 over. Each channel may look compliant in its own silo, but the NPI is getting more than double the effective ceiling, burning budget on touches four through seven that add almost no lift.
:::

:::widget lineChart
title: Cumulative NBRx lift index vs weekly frequency
labels: 1, 2, 3, 4, 5, 6
data: 100, 165, 200, 210, 213, 210
unit: lift index
:::

# Stage four, is the lift study actually valid yet

Before declaring a lift study a failure, check whether it is even readable. A "flat" or negative read is often premature: a 12-week flight needs roughly 4 more weeks of Rx lag before the panel adjudicates, so the valid measurement window is the flight length plus the lag (8 to 20 weeks of flight by specialty, plus about 4 weeks). The pre-mortem check is simple: is (flight weeks plus Rx lag) less than or equal to elapsed weeks? If not, do not grade the flight. Killing a flight on pre-conversion noise is one of the most expensive mistakes in the vertical.

$$ \text{window valid if} \quad (\text{flight weeks} + \text{Rx lag}) \le \text{elapsed weeks} $$

:::predict
prompt: A 12-week flight carries a 4-week Rx panel lag. How many elapsed weeks must pass before the lift read is valid?
answer: 16
tolerance: 0
unit: weeks
hint: Add the flight length to the data lag.
explain: 12 plus 4 = 16 weeks. A read at week 13 or 14 is inside the lag and can show flat even when real lift is building; a study that looks dead at week 10 can turn clearly positive by week 16. Set this expectation with stakeholders before launch so an early read is not mistaken for the grade.
:::

:::quiz
question: A 12-week oncology flight reads flat at week 13. The Rx panel lags 4 weeks. What should you do?
- Kill the flight immediately, the lift is flat
- Wait until at least week 16, the lag window has not closed
- Double the bids to force more conversions
- Switch the measurement to match-back to get a faster read
answer: 1
hint: Compare elapsed weeks to flight length plus the data lag.
explain: 12 plus 4 = 16, so at week 13 you are reading inside the lag window and the result is not yet valid. Wait for week 16 before grading. Switching to match-back trades away causal rigor and still cannot beat the adjudication lag.
:::

# Stage five, did budget leak to the wrong prescribers

If the window has closed and lift is genuinely weak, check where the money went. Decile concentration is the tell: if less than 60 percent of spend reached deciles 6 to 10, budget leaked to low-volume prescribers who were never going to move scripts, and you tighten segmentation before relaunch. Two more checks sit here: validate the proxy-to-script correlation (a proxy you optimized hard, like CTR, may not predict scripts at all), and watch the NBRx:TRx ratio, where a value under 0.10 signals access barriers rather than a media failure. Negative lift can also be a measurement artifact (a contaminated control or a mis-scoped match-back), so audit the study design before you report failure.

$$ \text{decile concentration} = \frac{\text{spend in deciles 6 to 10}}{\text{total spend}} \qquad \text{program CPS} = \frac{\text{media spend}}{\text{incremental scripts}} $$

:::predict
prompt: A flight delivered $48,000 of a $90,000 budget to deciles 6 to 10. What is the decile 6 to 10 concentration, and is it below the 60% flag?
answer: 53.3
tolerance: 0.3
unit: %
hint: Divide spend in deciles 6 to 10 by total spend.
explain: 48,000 / 90,000 = 0.533, about 53.3 percent, which is below the 60 percent threshold and flags over-investment in low-volume HCPs. The fix is to suppress deciles 1 to 4 and re-concentrate the budget on writable volume before relaunch.
:::

:::predict
prompt: After fixing the decile leak and re-running, a flight spends $900,000 and the clean room attributes 3,600 incremental scripts. What is the cost per script?
answer: 250
tolerance: 1
unit: USD
hint: Divide media spend by incremental scripts.
explain: 900,000 / 3,600 = 250. A $250 cost per script is the number that funds renewal, and it only becomes defensible once the upstream stages (match rate, pacing, frequency dedup, a valid lift window, and clean decile concentration) are all verified, since each broken stage would have inflated this figure.
:::

:::widget barChart
title: NPI match rate by environment (diagnostic baseline)
labels: DeepIntent deterministic, Doximity, Epocrates, Medscape, Open display
data: 95, 78, 73, 68, 60
unit: % match rate
:::

:::sources
- Improvado, HCP Targeting and Segmentation in Pharma, The 2026 Practitioner's Guide | https://improvado.io/blog/hcp-targeting-segmentation-pharma
- DeepIntent, Provider Audiences, Verified and Addressable HCPs (95%+ average NPI match, 7 identifiers per NPI, under 10s) | https://www.deepintent.com/solutions/healthcare-audiences/providers/
- Veeva Crossix, Data Platform and Methodology White Paper (SafeMine match-back, daily-adjudicated claims) | https://www.veeva.com/wp-content/uploads/2023/08/Crossix-Data-and-Methodology-White-Paper.pdf
- MM+M, Turning off programmatic ads, Why one pharma took the bold step (brand-safety over-blocking) | https://www.mmm-online.com/news/turning-off-programmatic-ads-why-one-pharma-took-the-bold-step/
- Digiday, How programmatic firms deal with complex pharmaceutical laws (whitelists, contextual targeting, direct deals) | https://digiday.com/marketing/pharma-programmatic/
- Improvado, Pharma Ad Compliance 2026, FDA and FTC Requirements for Fair Balance and ISI | https://improvado.io/blog/pharma-ad-compliance-fda-ftc-fair-balance-and-isi-requirements
- PulsePoint, Curated Private Marketplaces / Endemic Markets (NPI-targetable endemic plus EHR supply) | https://www.pulsepoint.com/blog/curated-private-marketplaces
:::
