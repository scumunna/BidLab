---
id: vertical-healthcare-10
track: vertical-healthcare
module: 10
title: Reporting, Optimization, and the Pharma Calendar
summary: Close the loop in a healthcare buy by reading the dual-layer report, reallocating on lift times match rate, refreshing the NPI universe as deciles drift, and defending the only number that renews the budget, cost per incremental script.
---
# Two reports, not one

Every other vertical you have studied grades a campaign on a single live dashboard. Pharma does not, and the reason traces straight back to the funnel: the script is invisible at impression time and arrives weeks late from a clean room. So the operator runs two reports in parallel. The in-flight dashboard tracks the proxies you can see now (match rate, frequency, CPQA, deal fill, viewability), and the lagged clean-room readout (cost per NBRx or TRx, lift, statistical significance) is the one that actually grades the flight and funds the renewal.

The discipline is to never confuse the two. The proxy dashboard is a leading indicator you steer on mid-flight, and the clean-room number is the verdict you report up. Calling the proxy dashboard "the result" before the Rx-lag window has closed is the single most common way operators over-claim a flight that later undershoots on scripts.

:::callout key
The proxy dashboard tells you whether delivery is healthy. The clean-room lift study tells you whether the campaign worked. Steer on the first, grade on the second, and never present the first as the second.
:::

:::quiz
question: Which metric belongs on the in-flight proxy dashboard rather than the lagged clean-room readout?
- Cost per incremental NBRx
- Match rate
- Statistical significance of lift
- Cost per incremental TRx
answer: 1
hint: Which one can you actually see while the flight is still live?
explain: Match rate is a live delivery signal you steer on mid-flight, so it sits on the proxy dashboard. Cost per NBRx, cost per TRx, and lift significance all come from the clean room weeks after the flight and form the grading readout, not the in-flight view.
:::

# The signature number: cost per incremental script

The renewal case rests on one figure: program-level cost per incremental script, total media spend divided by the incremental NBRx or TRx the clean room attributes. Roll up every line, every channel, every flight in the program, divide by the proven incremental scripts, and compare against the brand's target CPS. If you beat the target, the budget renews and usually grows. If you miss it, you are defending the buy regardless of how good the in-flight proxies looked.

$$ \text{program CPS} = \frac{\text{total media spend}}{\text{total incremental scripts}} $$

This is why the whole vertical rewards the operator who can prove an impression became a prescription. CTR, CPM, and viewability are table stakes you report as context, but they do not appear in the renewal math.

:::predict
prompt: A full-year HCP program spends $3,000,000 and the clean room attributes 12,000 incremental scripts. What is the program-level cost per incremental script?
answer: 250
tolerance: 1
unit: USD
hint: Divide total spend by total incremental scripts.
explain: $3,000,000 / 12,000 = $250 per incremental script. That is the number you carry into the renewal conversation, not the in-flight CTR.
:::

:::predict
prompt: A program spends $2,500,000 and proves 10,000 incremental scripts in the clean room. The brand's target is $300 cost per script. By how many dollars per script does the program beat target?
answer: 50
tolerance: 1
unit: USD
hint: Compute achieved CPS first, then subtract from the target.
explain: Achieved CPS is $2,500,000 / 10,000 = $250. Target is $300, so the program beats target by $300 minus $250 = $50 per script. A clean renewal case, and a likely budget increase.
:::

# Reallocating on lift times match rate

Optimization in pharma is not "shift budget to the highest CTR." It is "shift budget to where each dollar buys the most proven scripts," and the cleanest signal for that is lift multiplied by match rate. A channel with great engagement but poor script lift, or a channel with high lift but a weak NPI-to-device match, both waste the renewal case. You rank segments and channels by the product of their measured lift and their addressability, then move spend toward the top of that ranking for the next flight.

$$ \text{reallocation score} = \text{lift} \times \text{match rate} $$

The same logic governs the NPI universe: concentrate on high-decile, high-match, high-lift prescribers and pull spend off the segments where any of the three is weak. Engagement metrics are deliberately absent from this formula because they have repeatedly failed to predict scripts in this vertical.

:::predict
prompt: Channel A shows 10pp lift at an 80% match rate. Channel B shows 6pp lift at a 95% match rate. Which channel has the higher reallocation score, and what are the two scores?
answer: 8
tolerance: 0.1
unit: score (Channel A)
hint: Multiply lift in pp by match rate as a decimal for each, then compare.
explain: Channel A scores 10 times 0.80 = 8.0. Channel B scores 6 times 0.95 = 5.7. Channel A wins at 8.0, so you shift budget toward A even though B has the higher headline match rate. Lift and match must be weighed together.
:::

:::quiz
question: A channel posts the program's best CTR but its clean-room script lift is near zero. What should the optimization do?
- Shift more budget into it because engagement is strong
- Hold it flat since CTR is a proven script driver in pharma
- Reallocate budget away from it toward higher lift-times-match segments
- Increase frequency on it to convert the engagement into scripts
answer: 2
hint: Which metric actually appears in the renewal math?
explain: CTR does not predict scripts in pharma, and a near-zero lift means the channel is not producing incremental prescriptions. You reallocate away from it toward segments with higher lift times match rate. Pouring more budget or frequency into high-CTR, low-lift inventory only worsens program CPS.
:::

# Refreshing the NPI universe as deciles drift

A prescriber's decile is recomputed off rolling Rx data, so the universe you built last quarter quietly decays as physicians move between deciles, retire, or change taxonomy. A stale NPI universe degrades every downstream metric at once: match rate, lift, and CPS all slide, and because scripts are lagged you often do not notice until the renewal read disappoints. The fix is a standing re-decile cadence, roughly quarterly, rather than waiting for the numbers to fall apart.

$$ \text{refresh cadence: re-decile when rolling Rx data shifts decile membership} \approx \text{quarterly} $$

This is preventive maintenance, not troubleshooting. The operator schedules the refresh into the calendar the same way you schedule the match-quality audit, so the universe entering each new flight is current before the first impression serves.

:::figure npiTargeting
caption: The NPI universe is deciled by Rx volume and decays as prescribers shift deciles, retire, or change taxonomy. A quarterly re-decile keeps spend concentrated on the high-decile, high-match prescribers that move scripts.
:::

:::quiz
question: Why schedule a quarterly re-decile of the NPI universe instead of waiting to see if performance drops?
- Because clean rooms charge less for fresher panels
- Because the script number is lagged, so a stale universe shows up too late to fix in-flight
- Because FDA requires quarterly universe refreshes
- Because match rate is fixed once an IO is signed
answer: 1
hint: Think about when you would actually find out the universe had gone stale.
explain: Scripts arrive weeks after the flight, so a universe that decayed mid-quarter only surfaces in the lagged read, after the budget is spent. Re-deciling on a schedule keeps the universe current before each flight rather than discovering the decay post-mortem. The other options are invented constraints.
:::

# The pharma calendar and the bigger picture

The role sits inside a roughly $24.8B (2025) US healthcare and pharma digital market heading to about $26.2B in 2026, and 2025 was the first year social (around $6B) passed linear TV in this vertical. The HCP and B2B slice is smaller but growing fast, roughly $2.11B in 2025 and reaching about $2.54B by 2027, with CTV displacing linear TV and EHR point-of-care scaling as the growth edges (PulsePoint multiplied point-of-care reach 10x via EHR deals, and DeepIntent stood up the first pharma CTV marketplace). The calendar matters because flights are gated by MLR approval windows and indication seasonality, so you feed each lift learning into the next approved flight rather than optimizing on a flat quarterly clock.

The throughline of all ten lessons: pharma runs on a purpose-built NPI stack no generalist DSP replicates, it is uniquely gated by FDA OPDP and HIPAA OCR, and it rewards the operator who can prove an impression became a prescription. Master match rate, clean-room lift, MLR and ISI ops, endemic supply, and cross-channel pacing, and you own the only metric that renews the budget.

:::widget barChart
title: US healthcare and pharma digital ad spend, total vs HCP slice
labels: Digital 2025, Digital 2026, HCP digital 2025, HCP digital 2027
data: 24.8, 26.2, 2.11, 2.54
unit: US$B
:::

:::predict
prompt: HCP and B2B healthcare digital spend is $2.11B in 2025 and reaches $2.54B in 2027. What is the approximate total growth over those two years?
answer: 20.4
tolerance: 0.5
unit: percent
hint: Divide the change by the starting value.
explain: ($2.54B minus $2.11B) / $2.11B = $0.43B / $2.11B = 0.204, about 20.4% growth. The HCP slice is small but outpacing the broader market on a percentage basis.
:::

:::predict
prompt: Total US healthcare and pharma digital spend grows from $24.8B in 2025 to $26.2B in 2026. What is the year-over-year growth rate?
answer: 5.6
tolerance: 0.3
unit: percent
hint: Subtract, then divide by the 2025 figure.
explain: ($26.2B minus $24.8B) / $24.8B = $1.4B / $24.8B = 0.0565, about 5.6% year over year. Steady single-digit growth, with the mix shifting from linear TV toward social, CTV, and point-of-care.
:::

:::callout insight
The pattern that funds your seat: leadership conflates the in-flight proxy dashboard with proven ROI, then questions the budget when the lagged script number undershoots. Set the expectation up front that proxies are leading indicators and the clean-room cost per script is the grade, and you turn the lag from a liability into a credibility asset.
:::

:::sources
- eMarketer, Healthcare and pharma social media ad spending keeps growing as TV ad spending declines | https://www.emarketer.com/content/healthcare-pharma-social-media-ad-spending-keeps-growing-tv-ad-spending-declines
- FiercePharma, 2026 forecast: Pharma ad dollars will continue shifting away from traditional TV | https://www.fiercepharma.com/marketing/2026-forecast-pharma-ad-dollars-will-continue-shifting-away-traditional-tv
- Improvado, HCP Targeting and Segmentation in Pharma: The 2026 Practitioner's Guide | https://improvado.io/blog/hcp-targeting-segmentation-pharma
- Veeva Crossix, Data Platform and Methodology White Paper | https://www.veeva.com/wp-content/uploads/2023/08/Crossix-Data-and-Methodology-White-Paper.pdf
- PulsePoint, Curated Private Marketplaces and Endemic Markets | https://www.pulsepoint.com/blog/curated-private-marketplaces
- DeepIntent, Healthcare Audiences and Provider Match | https://www.deepintent.com/solutions/healthcare-audiences/
- Digiday, How programmatic firms deal with complex pharmaceutical laws | https://digiday.com/marketing/pharma-programmatic/
:::
