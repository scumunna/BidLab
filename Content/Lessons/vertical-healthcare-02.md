---
id: vertical-healthcare-02
track: vertical-healthcare
module: 2
title: The Buyer and the Mandate, NPI, Deciles, and Cost per Script
summary: Size an NPI prescriber universe by decile, translate a brand team's incremental-script goal into a frequency and measurement plan, and compute cost per script and NBRx lift the way the buy-side actually grades the campaign.
---
# Who the buyer is and what they actually want

The buyer is a brand team inside a pharma manufacturer, usually working through a media agency or a specialist trading desk that holds the seat in the healthcare DSP. They do not want clicks, and they do not really want impressions. They want incremental prescriptions, and the number they renew the budget on is cost per script, which is cost per incremental new-to-brand (NBRx) or total (TRx) prescription.

Everything the operator builds, the sized NPI list, the deal package, the frequency cap, the clean-room study, exists to move and then to prove that one number. If you internalize nothing else from this lesson, internalize that the campaign is graded on a prescription it cannot see at impression time, so the plan has to be designed backward from the script.

:::quiz
question: What is the signature deliverable the buy-side trader is ultimately graded on in pharma?
- Click-through rate on endemic display
- Cost per incremental script (cost per NBRx or TRx)
- Viewable CPM across CTV and open web
- Cookie match rate on the open exchange
answer: 1
hint: It is the only metric that funds the next flight, and it is downstream of the impression.
explain: The brand team renews on cost per incremental script (NBRx or TRx), not CTR, CPM, or viewability. Those are in-flight proxies. The script is the lagging truth that grades the campaign and funds the renewal.
:::

# Deciles, where the writable volume actually sits

HCPs are ranked into deciles 1 to 10 by their prescribing volume in the relevant category, decile 10 being the heaviest writers. The mandate is concentration: for most brands, 65 to 95 percent of the writable volume sits in deciles 6 to 10, so that is where the spend goes. The exact concentration is specialty-dependent, running roughly 90 to 95 percent in rare disease, 85 to 90 in oncology, 75 to 85 in immunology, 70 to 80 in cardiology, and 65 to 75 in CNS.

The practical consequence is that targeting low-decile or non-writing prescribers burns budget on people who will not move the script number. Unless you are explicitly running an awareness or disease-state play, you suppress deciles 1 to 4 and build the universe from the high deciles.

:::widget barChart
title: Share of category Rx volume sitting in deciles 6 to 10
labels: Rare disease, Oncology, Immunology, Cardiology, CNS
data: 92, 87, 80, 75, 70
unit: %
:::

:::predict
prompt: An indication has 18,000 target NPIs, and 75 percent of the category's writable volume sits in deciles 6 to 10. Roughly how many NPIs make up that decile 6 to 10 core you should concentrate spend on?
answer: 13500
tolerance: 50
unit: NPIs
hint: Apply the concentration share to the universe count.
explain: 0.75 times 18,000 equals 13,500 NPIs in the decile 6 to 10 core. That is the addressable spine you build line items against. The remaining 4,500 lower-decile NPIs are candidates for suppression unless you are running disease-state awareness.
:::

:::figure npiTargeting
caption: An NPI is a license number, not a cookie. The trader sizes the universe from high-decile prescribers, then a healthcare DSP resolves each NPI to the devices that prescriber actually uses so the line items can serve against them.
:::

# Cost per script, the core arithmetic

Cost per script (CPS) is total media spend divided by the incremental scripts attributed to the campaign in a lift study. The word incremental matters: you only credit scripts above what an unexposed control wrote, because crediting every script the exposed group wrote would credit prescriptions that would have happened anyway. The incremental script count itself is the lift in script rate times the exposed population.

So two formulas drive the grade. Incremental scripts equals the test script rate minus the control script rate, times the exposed population. Cost per script equals media spend divided by those incremental scripts.

$$ \text{Incremental scripts} = (\text{rate}_{\text{test}} - \text{rate}_{\text{control}}) \times \text{exposed} $$

$$ \text{CPS} = \frac{\text{media spend}}{\text{incremental scripts}} $$

:::predict
prompt: A campaign spends $1,200,000 and a clean-room lift study attributes 4,000 incremental scripts. What is the cost per script?
answer: 300
tolerance: 1
unit: USD
hint: Divide spend by the incremental script count.
explain: 1,200,000 divided by 4,000 equals $300 per incremental script. That is the number the brand team compares against its target CPS to decide whether the flight renews.
:::

:::predict
prompt: The test group's NBRx rate is 14 percent and the control's is 9 percent, across 80,000 exposed prescribers. How many incremental NBRx did the campaign drive?
answer: 4000
tolerance: 10
unit: scripts
hint: Take the lift in rate first, then multiply by the exposed population.
explain: The lift is 0.14 minus 0.09 equals 0.05, or 5 percentage points. Times 80,000 exposed equals 4,000 incremental NBRx. Note that only the gap over control counts, not the full 14 percent.
:::

# What "good" looks like, NBRx lift over control

Good is not a CPM benchmark, it is NBRx lift over an unexposed control, measured in percentage points. Well-executed HCP targeting lands roughly 5 to 15 percentage points of lift, and the band varies by specialty: oncology runs about 3 to 8pp over a 16 to 20 week window, rare disease 8 to 15pp over 12 to 16 weeks, cardiology 4 to 10pp over 8 to 12 weeks, immunology 5 to 12pp, and CNS 3 to 9pp. A trader who promises a flat number across specialties does not understand the category.

Lift in percentage points is simply the test rate minus the control rate, the same gap that drives the incremental script count. Relative lift, which divides that gap by the control rate, is a different and often more flattering presentation, so always confirm which one a vendor is quoting.

$$ \text{NBRx lift (pp)} = \text{rate}_{\text{test}} - \text{rate}_{\text{control}} $$

:::predict
prompt: Test group NBRx rate is 17 percent and the control is 12 percent. What is the NBRx lift in percentage points?
answer: 5
tolerance: 0.1
unit: percentage points
hint: Percentage-point lift is a straight subtraction, not a ratio.
explain: 17 percent minus 12 percent equals 5 percentage points. If you instead reported relative lift it would be 5 divided by 12, about 42 percent, which is the same result dressed up. Know which one the brand team is asking for.
:::

:::quiz
question: A rare-disease brand asks you to commit to an NBRx lift target before launch. Which range is defensible for that specialty, per current practitioner benchmarks?
- 0 to 2 percentage points
- 8 to 15 percentage points
- 25 to 40 percentage points
- Lift is the same across all specialties, so the question is moot
answer: 1
hint: Rare disease has the highest decile concentration, so the high-value universe is small and tight, and lift runs at the top of the band.
explain: Rare disease lift runs about 8 to 15 percentage points over a 12 to 16 week window. Single-digit-low ranges understate it, 25 to 40pp is fantasy, and lift is decidedly not uniform across specialties (oncology runs lower at 3 to 8pp).
:::

# From mandate to plan, sizing, frequency, and measurement up front

The mandate becomes three concrete decisions the operator makes before a single impression serves. First, a sized NPI universe: count the NPIs in deciles 6 to 10 for the indication, run them through the healthcare DSP's identity graph, and confirm enough resolve to devices to be addressable. Second, a frequency plan, typically about 3 exposures per HCP per week across all channels combined, because response flattens past the third touch. Third, a measurement design, the test-versus-control or match-back study, sized for statistical power and timed for the multi-week Rx data lag.

Skipping any of the three is how flights fail quietly. An unsized universe leaks budget to low deciles, an unplanned frequency cap overserves the most valuable prescribers, and a study designed after launch usually cannot recover a clean control. The deliverable of this module is not a buy, it is a plan that ties spend to a provable script.

:::widget reachFrequency
title: HCP frequency response, lift flattens after the third weekly touch
:::

:::callout warning
A recurring brand-team complaint from operators in the field: promotion to non-accessible prescribers, the ones closed to in-person reps, generates demand that the field cannot service, which frustrates HCPs and wastes spend on both sides. Non-accessible prescribers can still be valuable in digital, but you must coordinate with the field and CRM so digital and reps are not double-spending the same NPI, and so digital does not manufacture demand no rep can fill.
:::

# Why the universe decays, and the access-barrier signal

A decile is computed off rolling prescribing data, so a physician's decile moves over time and a universe built six months ago has decayed. Refresh and re-decile the list before relaunch, roughly quarterly, or you are concentrating spend on yesterday's heavy writers. This is unglamorous list hygiene that quietly protects every downstream metric.

One more diagnostic worth carrying from day one is the NBRx-to-TRx ratio, new-to-brand scripts over total scripts, which reads how healthy new-patient acquisition is. A ratio under about 0.10 flags access barriers, meaning new patients are not starting therapy even where awareness exists, and that is a signal to investigate payer or fulfillment friction rather than to simply buy more impressions.

$$ \text{NBRx:TRx} = \frac{\text{NBRx}}{\text{TRx}} $$

:::predict
prompt: A brand reports 1,800 NBRx and 30,000 TRx in the period. What is the NBRx-to-TRx ratio, and does it clear the 0.10 access-barrier flag?
answer: 0.06
tolerance: 0.005
unit: ratio
hint: Divide new-to-brand scripts by total scripts, then compare to 0.10.
explain: 1,800 divided by 30,000 equals 0.06. That is below the 0.10 threshold, so it flags a likely access barrier. The fix is to diagnose payer, copay, or fulfillment friction, not to pour more spend into a funnel that cannot convert new starts.
:::

:::sources
- Improvado, HCP Targeting and Segmentation in Pharma: The 2026 Practitioner's Guide | https://improvado.io/blog/hcp-targeting-segmentation-pharma
- FiercePharma, 2026 forecast: Pharma ad dollars will continue shifting away from traditional TV | https://www.fiercepharma.com/marketing/2026-forecast-pharma-ad-dollars-will-continue-shifting-away-traditional-tv
- DeepIntent, Healthcare Audiences and Provider Targeting | https://www.deepintent.com/solutions/healthcare-audiences/
- Veeva Crossix, Data Platform and Methodology White Paper | https://www.veeva.com/wp-content/uploads/2023/08/Crossix-Data-and-Methodology-White-Paper.pdf
- PulsePoint, Curated Private Marketplaces and Endemic Markets | https://www.pulsepoint.com/blog/curated-private-marketplaces
- Doximity, About and Company | https://www.doximity.com/about/company
- Digiday, How programmatic firms deal with complex pharmaceutical laws | https://digiday.com/marketing/pharma-programmatic/
:::
