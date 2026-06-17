---
id: vertical-telecom-10
track: vertical-telecom
module: 10
title: Proving It, Incrementality, MMM, and the End-to-End Campaign Build
summary: Run geo holdouts and MMM to prove incremental gross adds, read a true incremental CPGA against the LTV:SAC gate, and assemble Lessons 1 to 9 into one buildable carrier campaign.
---
# Why observed conversions are not proof

The carrier did not hire you to generate clicks or even logged conversions. The mandate is incremental subscriber lift, the gross adds the carrier would not have won without the media, so your job in the final readout is to prove causation, not correlation. Many people who appear in your conversion report were going to switch anyway (they searched the brand, walked into a store, renewed at end of contract), so a platform-reported CPGA that takes credit for all of them flatters the truth and quietly inflates the LTV:SAC story the whole campaign was built to satisfy.

Incrementality reframes the question from "how many conversions did we observe" to "how many of those conversions were truly caused by the media." A 19% lift, for example, means only 19% of observed conversions were genuinely incremental, and the other 81% would have happened regardless. The trader who presents only the observed number is not measuring performance, they are measuring demand the carrier already had.

:::quiz
question: A carrier's platform report shows 10,000 conversions and a geo lift test finds the campaign was 25% incremental. How many gross adds did the media actually cause?
- 10,000
- 7,500
- 2,500
- 1,250
answer: 2
hint: Incremental share times observed conversions gives the caused gross adds.
explain: 25% of 10,000 = 2,500 truly incremental gross adds. The other 7,500 would have happened anyway, so reporting all 10,000 as media-driven overstates impact 4x and breaks the LTV:SAC gate downstream.
:::

# Geo holdouts, the cleanest read for footprint-bounded telecom

A geo holdout (geo lift test) splits markets into treatment, which receives media, and matched control, which is held dark, then reads the difference in gross adds against the difference in cost. This design fits telecom unusually well because so many carrier outcomes are footprint-bounded and offline (store visits, order activations inside a fiber build-out), so geographic containment is clean and spillover is manageable. You compute incremental gross adds as treatment-market adds minus the control-implied baseline, then divide incremental spend by those incremental adds to get a true CPGA.

Across 225 geo-based tests run between August 2024 and December 2025, the median iROAS was 2.31x and 88.4% of tests reached statistical significance, which is the evidence that geo holdouts produce decision-grade reads rather than directional guesses. The discipline is in the design: matched, contamination-free control markets and a flight long enough to detect the effect.

:::figure incrementalityHoldout
caption: Treatment markets receive media while matched control markets stay dark. Incremental gross adds are the treatment total minus the control-implied baseline, and incremental spend divided by those adds is the true CPGA.
:::

:::predict
prompt: Treatment markets produced 12,000 gross adds and the control-implied baseline was 9,500. How many gross adds were incremental?
answer: 2500
tolerance: 0
unit: gross adds
hint: Subtract the control-implied baseline from the treatment total.
explain: 12,000 treatment adds minus 9,500 control-implied baseline = 2,500 incremental gross adds. Only these 2,500 are attributable to the media; the 9,500 baseline would have arrived with the control markets dark.
:::

:::predict
prompt: Incremental media spend was $1,000,000 and incremental gross adds were 2,500. What is the incremental CPGA?
answer: 400
tolerance: 0
unit: USD
hint: Divide incremental spend by incremental gross adds.
explain: $1,000,000 / 2,500 = $400 incremental CPGA. This is the honest cost per caused gross add, often far above the observed last-click CPGA, and it is the number that must clear the allowable-SAC ceiling from Lesson 6.
:::

# Lift percent and the iROAS read

Lift percent isolates how much better the treatment group converted than the control, defined as (treatment conversion rate minus control conversion rate) divided by the control rate. It is the cleanest single expression of causal effect because it normalizes for baseline demand, so a 2.0% control versus a 2.5% treatment is a 25% lift regardless of raw volume. The trader pairs lift with iROAS, incremental revenue or LTV divided by incremental media spend, to translate the causal effect into the dollars-per-dollar language leadership funds against.

The distinction matters because a campaign can post a high observed ROAS and a thin incremental one at the same time, which is exactly what happens when the media harvests demand that already existed. Reporting incremental iROAS keeps the readout honest and connects it back to the LTV:SAC gate.

:::predict
prompt: Control-market conversion rate is 2.0% and treatment is 2.5%. What is the lift percent?
answer: 25
tolerance: 0
unit: percent
hint: Subtract the control rate from the treatment rate, then divide by the control rate.
explain: (2.5% minus 2.0%) / 2.0% = 0.5 / 2.0 = 0.25 = 25% lift. A quarter more conversions occurred in treatment than the matched control baseline, the causal signal the test is built to isolate.
:::

:::predict
prompt: A test drove $5,800,000 in incremental subscriber LTV on $2,000,000 of incremental media spend. What is the incremental iROAS?
answer: 2.9
tolerance: 0.05
unit: ratio (x)
hint: Divide incremental LTV by incremental media spend.
explain: $5,800,000 / $2,000,000 = 2.9x incremental iROAS, in line with the 2.31x median across 225 geo tests. Because the numerator is incremental LTV rather than observed revenue, this read ties directly to the LTV:SAC mandate.
:::

:::widget barChart
title: Geo holdout read, treatment vs control-implied baseline
labels: Treatment Gross Adds, Control-Implied Baseline, Incremental Gross Adds
data: 12000, 9500, 2500
unit: gross adds
:::

# MMM for the always-on, cross-channel picture

Geo holdouts answer one question for one flight; marketing mix modeling (MMM) answers the always-on, cross-channel question by regressing outcomes against spend across all channels over time. The two are complements, not rivals: geo experiments give you a clean causal point estimate, and you use that estimate to calibrate the MMM so the model is anchored to ground truth rather than trusting either alone. MMM typically needs at least about 2 years (around 104 weeks) of clean weekly historical data, 3 years for national models, with the most data-flexible vendors starting around 6 to 12 months, and it can mis-attribute when several channels change at once, which is precisely why experiment calibration matters.

The tooling matured fast. Google's open-source MMM, Meridian, reached general availability on January 29, 2025, and added a no-code Scenario Planner in February 2026, lowering the barrier for a trading team to run modeled what-ifs alongside the geo test. The trader's posture is to treat MMM as the strategic, cross-channel allocator and geo holdouts as the calibrating experiments that keep it honest.

:::quiz
question: Why should a trader calibrate an MMM with geo-holdout results rather than trusting the model on its own?
- MMM is always wrong and geo tests are always right
- MMM can mis-attribute when channels change simultaneously, so an experiment anchors it to causal ground truth
- Geo holdouts replace the need for any modeling
- MMM does not require any historical data
answer: 1
hint: Think about what breaks when several channels move at the same time.
explain: MMM regresses outcomes on spend and can mis-assign credit when channels change together; a geo holdout gives a clean causal estimate that calibrates the model. Geo tests do not replace MMM, and MMM needs at least about 2 years (around 104 weeks) of weekly history (3 years for national models), with some modern vendors operating on a 6 to 12 month minimum.
:::

:::callout key
Geo holdouts and MMM are a triangle with platform attribution, not substitutes. Use the geo experiment for a clean causal point estimate, MMM for the always-on cross-channel allocation, and treat platform-reported conversions as directional only. The number you defend to leadership is the incremental CPGA, calibrated, not the observed one.
:::

# The end-to-end capstone build

Now assemble the whole machine. Take a fiber carrier's switching brief and wire it in order: set the LTV:SAC gate at 3:1 and derive the allowable-SAC bid ceiling (Lessons 2 and 6), onboard the serviceable-footprint file and clean-room-match the CRM with current-customer suppression so you only bid where the carrier can sell and never re-serve the existing base (Lessons 3 and 4), construct footprint-relevant PMP and PG deals for premium CTV and local supply (Lesson 5), and enforce cross-publisher CTV frequency caps so a handful of households do not absorb the budget (Lesson 7). Each layer compounds, so a miss early (a stale footprint file, a low match rate) silently corrupts every downstream metric.

Then make it trustworthy and provable: QA pixels and server-side postbacks and watch discrepancies against the ~10% tolerance (Lesson 8), apply SPO, IVT, and brand-safety controls so the eight-figure budget is not eaten by fees and junk (Lesson 9), pace the budget evenly so the highest-intent switching days stay funded (Lesson 6), and stand up a geo holdout from day one so the final readout is incremental CPGA against the 3:1 gate, not a vanity CTR. That sequence, gate to ceiling to targeting to deals to frequency to QA to quality to pacing to holdout, is the job.

:::predict
prompt: The capstone's signature gate is LTV:SAC. A fiber sub has a Net LTV of $1,470 and the geo holdout proved an incremental SAC of $420. What is the LTV:SAC ratio, and does it clear the 3:1 gate?
answer: 3.5
tolerance: 0.05
unit: ratio (x:1)
hint: Divide Net LTV by the incremental SAC, then compare to 3.
explain: $1,470 / $420 = 3.5, so LTV:SAC is 3.5:1 and clears the 3:1 gate. Critically this uses the incremental SAC from the holdout, not the flattering observed CPGA; using observed cost would overstate the ratio and the program's true health.
:::

:::quiz
question: In the end-to-end build, which step protects against spending acquisition budget re-serving people who already pay the carrier?
- Cross-publisher frequency capping
- Clean-room CRM match with current-customer suppression
- Even pacing of the budget
- Pre-bid IVT blocking
answer: 1
hint: One layer specifically removes the existing subscriber base from the addressable pool.
explain: Current-customer suppression inside the clean-room match (Lesson 4) removes the existing base, so acquisition dollars target prospects, not renewals. Frequency capping controls exposure, pacing controls timing, and IVT blocking controls quality, but none of them excludes current subscribers.
:::

# When the readout fights the org

The hardest part of incrementality is rarely the math, it is the politics. Leadership often rewards observed last-click conversions, so a clean geo-holdout result that reveals a higher, truer CPGA becomes a hard internal sell against inflated platform-reported numbers, and teams feel pressure to quietly let attribution take credit for organic gross adds. Running the holdout cleanly is also operationally painful: matching markets, holding a control dark while a region "loses" media, and avoiding coverage or media spillover that contaminates the read.

The practitioner's defense is to set expectations before the flight, not after. Agree the test design and the definition of success up front, name incremental CPGA as the metric that governs the LTV:SAC gate, and present the observed and incremental numbers side by side so the gap itself becomes the teaching tool rather than an awkward surprise at readout.

:::callout warning
A recurring operator complaint: leadership treats a falling observed CPGA as success even when a clean geo holdout shows the incremental CPGA is far higher, so genuinely incremental results are punished and teams skip the holdout entirely, falling back on attribution that silently credits organic gross adds. Lock the test design and the incremental-CPGA definition of success before the flight launches, or the truer, higher number will always lose to the flattering one.
:::

:::widget lineChart
title: Observed vs incremental CPGA over a flight (illustrative)
labels: Week 2, Week 4, Week 6, Week 8 (holdout read)
data: 250, 280, 300, 400
unit: USD CPGA
:::

:::sources
- Digital Applied, Incrementality Testing: Proving Ads Actually Caused Sales | https://www.digitalapplied.com/blog/incrementality-testing-paid-media-causal-lift-2026
- Google, Meridian open-source marketing mix modeling | https://developers.google.com/meridian
- Recast, Geo Testing and Synthetic Control for Incrementality | https://getrecast.com/geo-testing/
- Triple Whale, What Incrementality and Lift Actually Mean | https://www.triplewhale.com/blog/incrementality-testing
- ANA, Q2 2025 Programmatic Transparency Benchmark | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
- Brainlabs, Cross-Publisher Frequency Capping in DV360 | https://www.brainlabsdigital.com/connected-tv-cross-publisher-frequency-capping-dv360/
- LiveRamp, What to Look for in a Data Clean Room Provider | https://liveramp.com/blog/what-to-look-for-in-a-data-clean-room-provider-a-guide
- Lifesight, Marketing Mix Modeling and Pre-Period Data Requirements | https://lifesight.io/blog/marketing-mix-modeling/
:::
