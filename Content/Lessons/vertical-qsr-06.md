---
id: vertical-qsr-06
track: vertical-qsr
module: 6
title: Daypart, Frequency Cap and Flighted LTO Pacing: Landing Budget in the Meal Window Without Front-Loading
summary: Set dayparts to meal-decision windows, cap frequency at the household level, and pace a flighted limited-time-offer so budget lands inside the promo window without front-loading or stranding co-op money.
---
# QSR demand runs on a clock

QSR purchase intent is not spread evenly across the day, it spikes at meal-decision moments, so the trader's three optimization levers are dayparting, frequency capping, and flighted pacing rather than the open-ended bid tuning a brand-awareness buy uses. Dayparts map to the breakfast and commute window, the lunch rush, and the late-night occasion, and each daypart typically carries its own creative, channel, and offer. The win condition is still an incremental store visit (the CPIV from module 2), so every pacing decision is judged by whether budget lands in the hours and weeks that actually drive footfall. Getting the clock wrong wastes the co-op's money on hours nobody is deciding where to eat, or strands it after a limited-time offer has already expired.

This module is the buy-side mechanics of landing spend in the right window. The hardest math is LTO (limited-time-offer) pacing, because a promo runs a fixed window and the budget has to be exhausted inside it, neither blown in week one nor left unspent when the offer dies.

:::quiz
question: Why does a QSR trader lean on dayparting and flighted pacing instead of running a flat, always-on bid like a brand-awareness campaign?
- QSR inventory is only available during meal hours
- QSR demand spikes at meal-decision moments, so budget must land in those windows and inside the promo flight
- Dayparting is required by every DSP for CTV buys
- Frequency caps cannot be set without dayparts
answer: 1
hint: Think about when a person actually decides where to eat, and when an LTO is valid.
explain: QSR intent is clock-driven and concentrated at breakfast, lunch, and late-night, and LTOs are valid only for a fixed window, so the trader steers budget into those hours and that flight. Inventory is available all day, dayparting is a choice not a requirement, and frequency caps are independent of dayparts.
:::

# Dayparts map to meal-decision moments

A QSR daypart schedule standardly targets three windows, breakfast and commute, the lunch rush, and late-night, with distinct creative, channels, and offers in each, and dynamic creative decisioning swaps the message by time of day. The same engine often fires on a weather trigger, for example serving cold-drink creative once a local temperature threshold is crossed, so the message tracks both the clock and the conditions. The trader allocates a budget weight to each daypart, and those weights must sum to the full budget so no spend leaks into untargeted hours.

The split is rarely even. Lunch carries the heaviest decision volume for most brands, so a typical weighting tilts budget toward midday, then breakfast, then late-night. The trader sets these weights deliberately rather than letting the DSP spread spend flat across 24 hours, because a flat spread funds 3am impressions that will never convert a visit.

$$ \text{daypart weight} = \frac{\text{budget allocated to daypart}}{\text{total budget}}, \quad \sum \text{weights} = 100\% $$

:::figure daypartingHeatmap
caption: A QSR daypart schedule concentrates budget in breakfast, lunch, and late-night meal-decision windows, with creative and offer swapping by time of day. A flat 24-hour spread would fund hours where nobody is choosing where to eat.
:::

# Frequency caps at the household, not the device

Frequency is capped at a household level, typically tuned to a 3x to 5x range per period, which is the practical band to stay top-of-mind at the meal decision without burning impressions or annoying viewers. Cap too low and the brand is forgotten by lunch, cap too high and the co-op pays to over-serve the same family. The cap multiplied by the reached household universe gives the planned impression load, which in turn drives the media cost at a given CPM, so frequency is a budget lever, not just a hygiene setting.

The recurring failure is capping at the device level instead of the household level. A modern home has a connected TV, two phones, and a tablet, so a device-level cap of 4x can deliver 12x or more to one household across screens, blowing past the intended exposure and wasting spend. Because QSR runs heavy CTV, this multi-device leakage is acute, and post-signal-loss household resolution (module 7) makes the household cap harder to enforce reliably.

$$ \text{planned impressions} = \text{households reached} \times \text{frequency cap} $$

:::predict
prompt: A CTV flight reaches 60,000 households at a 4x household frequency cap, buying at a $25 CPM. What is the media cost for that capped delivery?
answer: 6000
tolerance: 1
unit: USD
hint: First get total impressions (households times cap), then multiply by CPM divided by 1,000.
explain: 60,000 households times 4 = 240,000 impressions. At a $25 CPM that is 240 times $25 = $6,000. Note the cap is a budget lever, so raising it to 8x would double impressions and cost to $12,000.
:::

:::quiz
question: A trader sets a 4x frequency cap at the device level. Why does a multi-device QSR household end up over-served?
- Device caps automatically double on CTV
- The DSP ignores device-level caps
- Each device (TV, two phones, tablet) gets its own 4x, so the household sees far more than 4 total
- Household caps and device caps are identical in practice
answer: 2
hint: Count the screens in one home and apply the cap to each separately.
explain: A device-level cap applies independently to each screen, so a four-device home can see 16x while the trader intended 4x per household. The cap does not auto-double, the DSP does honor it (per device), and household versus device caps are materially different.
:::

# LTO pacing, the front-loading trap

A limited-time offer runs a fixed window, roughly 2 to 6 weeks, and the budget must be spent inside it. The front-load guardrail baseline is the even daily budget, total flight budget divided by the number of flight days, which is the pace that exhausts the budget exactly on the last valid day. DSP auto-pacing left unchecked tends to front-load, spending aggressively early, so the trader caps daily spend to protect the back half of the promo when awareness should be peaking. Under-pacing is the mirror failure, leaving co-op money unspent when the offer expires, and because the LTO is gone the budget cannot be re-flighted, so it is simply lost.

The trader monitors a pacing index, actual spend to date divided by planned spend to date, where 1.0 is on pace and a value above 1.0 signals front-loading. When the index drifts, the fix is to re-pace the remainder, dividing the unspent budget by the remaining flight days to reset the daily target.

$$ \text{even daily budget} = \frac{\text{total flight budget}}{\text{flight days}}, \qquad \text{pacing index} = \frac{\text{actual spend to date}}{\text{planned spend to date}} $$

:::predict
prompt: An LTO has a $210,000 budget over a 6-week (42-day) flight. What is the even daily budget target?
answer: 5000
tolerance: 1
unit: USD
hint: Divide the total budget by the number of flight days.
explain: $210,000 / 42 = $5,000 per day. That even pace is the front-load guardrail: hold near it and the budget lands on the last valid day of the LTO rather than going dark early.
:::

:::predict
prompt: By day 10 of the 42-day flight you have spent $70,000, but the planned even spend by day 10 is $50,000. What is the pacing index, rounded to one decimal?
answer: 1.4
tolerance: 0.05
unit: index
hint: Divide actual spend to date by planned spend to date.
explain: $70,000 / $50,000 = 1.4. An index of 1.4 means you are 40% ahead of plan and front-loading, so without a daily cap the budget will run out before the LTO ends.
:::

:::callout warning
A recurring r/adops complaint: DSP auto-pacing front-loads flights, and traders have to manually cap daily spend to keep an LTO alive through its end date. r/programmatic adds that household frequency capping is unreliable post-signal-loss, so homes get over-served across CTV and mobile and the effective frequency blows past plan. Treat auto-pacing and device-level caps as the default failure modes to QA on every LTO, not edge cases.
:::

# Re-pacing mid-flight and the pacing curve

Once the pacing index shows a flight off track, the trader resets the daily target by dividing the remaining budget by the remaining flight days, which re-paces the back half so delivery neither spikes nor stalls. This is a live operation, run mid-flight while the campaign is delivering, so the trader adjusts daily caps and bids rather than rebuilding the line items. A small intentional ramp at launch is also healthy, so delivery does not slam to the full daily target on day one before the creative and deals are fully warmed.

The shape to aim for is a steady curve that tracks the planned line, with weekday and weekend weighting layered on so budget tilts toward the hours and days that convert footfall. A front-loaded curve spikes early and flatlines to zero; an under-paced curve trails below plan and ends with money on the table.

$$ \text{remaining daily budget} = \frac{\text{total budget} - \text{spend to date}}{\text{remaining flight days}} $$

:::predict
prompt: After day 10 you have spent $70,000 of the $210,000 budget, with 32 flight days left. What daily budget re-paces the remainder, rounded to the nearest dollar?
answer: 4375
tolerance: 5
unit: USD
hint: Subtract spend to date from the total, then divide by the remaining days.
explain: ($210,000 - $70,000) / 32 = $140,000 / 32 = $4,375 per day. That is below the original $5,000 even pace, which makes sense because you front-loaded early and now have to slow down to reach the LTO end date.
:::

:::widget lineChart
title: Even LTO pacing vs front-loaded risk (weekly spend)
labels: Wk1, Wk2, Wk3, Wk4, Wk5, Wk6
data: 35000, 35000, 35000, 35000, 35000, 35000
unit: USD
:::

# Tying pacing back to CPIV

Pacing is not an end in itself, it exists to put budget where it produces incremental visits at an acceptable CPIV (module 2). A flight that lands its full budget evenly inside the meal windows and the promo dates gives the cleanest read on lift, because spend is not distorted by a week-one spike or a dark back half. The trader's closing check is to divide the delivered media spend by the incremental visits the flight drove, and confirm the result sits in the QSR band rather than ballooning because budget burned in low-intent hours.

If a well-paced LTO drives its incremental visits efficiently, the CPIV lands toward the Average-to-High-Performing end of the QSR range (Cuebiq's 2023 Fast Food benchmarks: High-Performing $5.28, Average $8.84). A front-loaded flight that went dark before the offer peaked tends to push CPIV the wrong way, because the spend bought reach in hours that did not convert.

$$ \text{CPIV} = \frac{\text{media spend}}{\text{incremental visits}} $$

:::predict
prompt: A well-paced LTO spends its full $210,000 and drives 30,000 incremental visits. What CPIV do you report?
answer: 7
tolerance: 0.1
unit: USD
hint: Divide media spend by incremental visits.
explain: $210,000 / 30,000 = $7.00 CPIV. That sits between Cuebiq's High-Performing $5.28 and Average $8.84 for Fast Food, so the pacing held and the budget converted in the meal windows rather than burning early.
:::

:::callout key
Pacing, dayparting, and frequency are all CPIV levers in disguise. Even pacing inside the flight protects the incrementality read, daypart weighting steers budget to converting hours, and a household frequency cap stops the co-op from paying for over-exposure. Judge every one of them by the cost per incremental visit, not by raw delivery or CTR.
:::

:::sources
- AdImpact, Q1 2026 Fast Food Advertising Trends | https://adimpact.com/blog/fast-food-advertising-trends/
- Eskimi, Dayparting and Daypart Targeting | https://www.eskimi.com/blog/daypart-targeting
- KORTX, Restaurant Marketing Strategy: The 2026 QSR Playbook | https://kortx.io/news/restaurant-marketing-strategy-qsr/
- Cuebiq, Footfall Attribution Benchmarks (CPIV, visit rate, uplift by vertical) | https://cuebiq.com/benchmarks/
- Goodway Group, How Does Franchise Co-Op Advertising Work? | https://goodwaygroup.com/blogs/franchise-co-op-advertising
- Restaurant Dive, Drive-thru share of US fast-food sales and digital order growth | https://www.restaurantdive.com/news/drive-thru-sales-qsr/
:::
