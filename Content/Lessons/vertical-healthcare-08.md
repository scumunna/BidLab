---
id: vertical-healthcare-08
track: vertical-healthcare
module: 8
title: Frequency, Cross-Channel Pacing, and MLR-Gated Flighting
summary: Cap an HCP at roughly three exposures a week across every channel, dedup the per-channel silos into one NPI view, and pace to the MLR-approved flight instead of the calendar.
---
# Two constraints at once

Delivery in most verticals is a one-axis problem: spend the budget evenly and hit the flight. Pharma constrains you on two axes at the same time. The first is frequency, because the HCP response curve flattens after the third weekly touch and extra impressions buy fatigue, not scripts. The second is regulatory flighting, because every asset only serves inside an MLR-approved window and must stop the moment that approval lapses or the creative expires.

The operator who only watches the pacing bar will overserve the highest-value prescribers and keep running an out-of-approval asset. This lesson is about delivering smooth, deduped, MLR-compliant impressions that fill the flight without blowing frequency on deciles 6 to 10.

:::callout key
Pharma pacing is not "spend evenly across the quarter." It is "spend inside the MLR-approved flight, deduped to roughly 3 per HCP per week across every channel." Miss either half and you waste budget or serve out of compliance.
:::

:::quiz
question: Compared with a typical retail or commerce buy, what makes pharma delivery a two-axis problem?
- Pharma has no frequency considerations at all
- Delivery is constrained by both a frequency ceiling and an MLR-approved flight window
- The only constraint is hitting the budget evenly across the quarter
- Pharma ignores creative approval once a flight is live
answer: 1
hint: One axis is about how often you hit a prescriber, the other is about when an asset is even allowed to serve.
explain: A generalist buy mostly worries about spending the budget on pace. Pharma adds a second hard axis: every asset only serves inside an MLR-approved window and must stop when approval lapses or the creative expires, on top of the cross-channel frequency ceiling. You have to satisfy both at once.
:::

# The 3-per-week ceiling

Cap exposure at about 3 per HCP per week across all channels combined: endemic (Doximity, Medscape, Epocrates), EHR/point-of-care, open-web display, and CTV. The frequency-response curve climbs steeply through the third touch, then flattens, and beyond roughly 6 in a short window response can actually decline as channel fatigue sets in. The fourth, fifth, and sixth touches add negligible NBRx lift while risking negative HCP sentiment, so the marginal dollar is better spent reaching a new in-market prescriber than re-hitting one already at frequency.

This is why "effective frequency" matters more than raw impressions: the lift you can attribute to weekly touches 4 through 6 is small, so paying for them is almost pure waste against cost per script.

:::widget lineChart
title: Cumulative NBRx lift index vs weekly frequency
labels: 1, 2, 3, 4, 5, 6
data: 100, 165, 200, 210, 213, 210
unit: lift index
:::

:::predict
prompt: Cumulative NBRx lift indexes 200 at a weekly frequency of 3 and 210 at a weekly frequency of 6. What percent does pushing from 3 to 6 add over the frequency-3 level?
answer: 5
tolerance: 0.2
unit: %
hint: Take the gain from 3 to 6 over the value at 3.
explain: (210 - 200) / 200 = 0.05, a 5 percent gain for doubling the weekly touches from 3 to 6. That tiny lift is why touches 4 through 6 are treated as waste against cost per script, and why the cap sits at 3.
:::

# Why per-channel caps are not a global cap

The hard part is cross-channel dedup. Each DSP and each publisher counts frequency inside its own silo, so a 3-per-week cap set on endemic, on open web, and on CTV separately is not a 3-per-week cap on the prescriber. Three channels each capped at 3 deliver up to 9 weekly impressions on the same NPI, three times the intended ceiling, concentrated on exactly the high-decile doctors you most want to keep happy. The fix is a unified frequency view, or coordinated caps managed to a single NPI-level ledger, so the silos sum to the global ceiling rather than each enforcing it alone.

$$ \text{overdelivery} = \sum_{c} f_c - \text{cap} $$

where $f_c$ is the per-channel weekly frequency on the NPI and the cap is the unified ceiling (about 3). A positive result is the dedup gap, the weekly impressions you are overdelivering because the channels do not talk to each other.

:::figure pacingCurve
caption: Per-channel caps each look disciplined, but without a shared NPI-level ledger they stack. Three channels at 3 per week each deliver up to 9 on the same prescriber, three times the intended ceiling.
:::

:::predict
prompt: An NPI is capped at 3 per week on each of three channels (endemic, open web, CTV) with no cross-channel dedup. Against a unified cap of 3, what is the weekly overdelivery on that NPI?
answer: 6
tolerance: 0
unit: exposures per week
hint: Sum the per-channel caps, then subtract the unified cap.
explain: 3 + 3 + 3 = 9 weekly impressions, minus the unified cap of 3, leaves 6 overdelivered per week. Per-channel caps do not equal a global cap, so the highest-value prescribers get hit three times over until you dedup.
:::

:::predict
prompt: An NPI receives 2 impressions per week on endemic and 2 per week on open web with no dedup. By how much does the combined weekly frequency exceed a 3-per-week cap?
answer: 1
tolerance: 0
unit: exposure per week
hint: Add the two channels, then compare to the cap.
explain: 2 + 2 = 4 weekly impressions against a 3-per-week cap is 1 over. Even two modest, individually compliant channels breach the global ceiling once you sum them on the NPI.
:::

:::quiz
question: Per-channel frequency caps are set to 3 per week on each of three channels, with no cross-channel deduplication. What is the real weekly exposure ceiling on a single NPI?
- 3 per week, because the cap is 3
- Up to 9 per week, because the silos stack
- 1 per week, because they average out
- Unlimited, because caps never apply to NPIs
answer: 1
hint: Each channel enforces its own cap independently.
explain: With no shared ledger, three channels at 3 each can stack to 9 weekly impressions on the same prescriber. A per-channel cap is not a global cap, which is exactly why cross-channel dedup is the core pacing competency in pharma.
:::

# Pacing to the MLR flight, not the calendar

Pacing in pharma is gated by two things a generalist trader never thinks about: the MLR approval window and indication seasonality. You pace to spend the budget inside the approved flight, which means front-loading or holding back when an approval renews or lapses, rather than smearing spend evenly across the quarter. The mechanical part is ordinary: required daily pace is remaining budget over remaining flight days. The judgment part is recognizing that an approval lapse, a seasonal indication (think allergy or flu), or an expiring asset can move the right pacing curve off the calendar entirely.

$$ \text{required daily pace} = \frac{\text{remaining budget}}{\text{remaining flight days}} $$

When approved creative expires, delivery on that asset must stop, full stop. So the deliverable is not "even pacing" but pacing that lands the spend within the approved, in-season window without a delivery gap.

:::predict
prompt: A flight has $420,000 of budget remaining and 30 days left in its MLR-approved window. What is the required daily pace?
answer: 14000
tolerance: 100
unit: USD per day
hint: Divide remaining budget by remaining days.
explain: $420,000 / 30 = $14,000 per day. That is the flat pace to exhaust the budget exactly at the end of the approved window. If an approval lapse looms, you front-load above this; you never let it spill past the flight.
:::

:::quiz
question: An MLR approval for the only running creative lapses mid-flight. What is the correct pacing response?
- Immediately pause that creative and switch to an approved backup asset
- Keep serving the expired creative to hit the budget
- Ignore it until the lift study comes back
- Double the daily pace to spend before anyone notices
answer: 0
hint: Out-of-approval delivery is a regulatory event, not a pacing inconvenience.
explain: An expired or lapsed approval means that asset must stop serving at once. The disciplined operator keeps an approved backup creative ready precisely so the lapse does not open a delivery gap, and re-paces the remaining budget across the approved asset.
:::

# When pacing and frequency collide

Underdelivery and overdelivery are not symmetric in pharma, because the Rx-response window is unforgiving. If you fall behind pace, you cannot simply make it up in the final week: scripts that would have followed a late-week impression land after the measurement window closes and never get counted in the lift study, so a flight-end catch-up is partly wasted budget. That is why you catch a pacing shortfall in week 2, not week 11. The compounding trap is fixing a shortfall by re-trafficking new line items that serve the same NPIs as the old ones, which stacks frequency and blows the cap on your best prescribers.

So the two axes interact: the pacing fix (more delivery, faster) can directly cause the frequency failure (overdelivery on high-decile NPIs) unless you coordinate the old and new line items into one deduped plan rather than stacking them.

:::callout warning
A recurring operator complaint on the forums: frequency "blows out" on top prescribers because endemic, EHR, and open-web DSPs each count frequency in their own silo with no shared cap, and the same crews vent about flights stalling when an MLR approval lapses, then having to burn the remaining budget in a compressed window that overserves the very HCPs already at frequency. Both failures trace to the same root, no unified NPI-level ledger spanning channels and approval status.
:::

:::predict
prompt: A flight spends $480,000 and a clean-room lift study attributes 1,600 incremental scripts. What is the cost per incremental script?
answer: 300
tolerance: 1
unit: USD
hint: Divide spend by incremental scripts.
explain: $480,000 / 1,600 = $300 per incremental script. Overdelivering touches 4 through 6 on prescribers already at frequency, or burning a compressed end-of-flight catch-up, inflates the numerator without adding scripts to the denominator, so undisciplined pacing shows up directly as a worse cost per script.
:::

:::quiz
question: You are behind pace at the midpoint and decide to re-traffic fresh line items to catch up. What is the main pacing-meets-frequency risk if you do not coordinate them?
- The new line items will lower the CPM automatically
- Old and new line items both serve the same NPIs and stack frequency past the cap
- MLR approval transfers automatically to the new line items
- The Rx data lag disappears
answer: 1
hint: Two sets of line items hitting the same prescriber list do not cancel out.
explain: Stacking new line items on top of old ones that target the same NPIs doubles up delivery on the highest-value prescribers and breaches the unified frequency cap. The fix is to coordinate into one deduped plan, not to layer a second buy on the first.
:::

:::sources
- Improvado, HCP Targeting and Segmentation in Pharma: The 2026 Practitioner's Guide | https://improvado.io/blog/hcp-targeting-segmentation-pharma
- eHealthcare Solutions, HCP advertising frequency and channel fatigue best practices | https://www.ehealthcaresolutions.com/
- Pharma Marketing Network, Reaching HCPs without overwhelming them: frequency and timing | https://www.pharma-mkting.com/
- Improvado, Pharma Ad Compliance 2026: FDA and FTC Requirements for Fair Balance and ISI | https://improvado.io/blog/pharma-ad-compliance-fda-ftc-fair-balance-and-isi-requirements
- PulsePoint, Curated Private Marketplaces and Endemic Markets | https://www.pulsepoint.com/blog/curated-private-marketplaces
- Veeva Crossix, Data Platform and Methodology White Paper | https://www.veeva.com/wp-content/uploads/2023/08/Crossix-Data-and-Methodology-White-Paper.pdf
- FiercePharma, 2026 forecast: Pharma ad dollars keep moving away from traditional TV | https://www.fiercepharma.com/marketing/2026-forecast-pharma-ad-dollars-will-continue-shifting-away-traditional-tv
:::
