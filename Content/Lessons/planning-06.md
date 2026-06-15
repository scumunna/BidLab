---
id: planning-06
track: planning
module: 6
title: Flighting and pacing
summary: Choosing a spending pattern over time, continuity, flighting, or pulsing, and pacing the budget so it lands evenly within each flight.
---
# Three shapes of a schedule

A budget has to be spread across time, and the shape of that spread is the schedule. Three patterns cover almost every plan. Continuity spends a steady amount the whole period. Flighting alternates bursts of spend with stretches of zero. Pulsing keeps a low baseline running and layers bursts on top.

The choice follows demand. Steady demand, an everyday staple, suits continuity. Demand clustered in seasons or around events, a tax service or a holiday gift, suits flighting because off-season spend is wasted. Products with stable demand plus seasonal spikes, a soft drink that sells year round but peaks in summer, suit pulsing.

:::callout key
Match the schedule to the demand curve, not to the calendar by habit. Spending evenly against demand that is wildly uneven leaves money on the table during peaks and burns it during troughs.
:::

:::widget lineChart
title: A pulsing schedule over a year (illustrative weekly spend)
data: 22,24,30,55,42,28,24,34,62,46,30,24
labels: J,F,M,A,M,J,J,A,S,O,N,D
:::

# Seasonality and weight

When demand is seasonal you weight spend toward the peak, but not perfectly in proportion, because of two competing forces. Competition is fiercest at the peak, so impressions cost more exactly when everyone wants them. Carryover means ads run before the peak still influence purchases during it, so some pre-peak weight pays off later.

The planning question is how far ahead of the peak to start. Start too late and you miss early deciders, start too early and the effect decays before it matters. The right lead time depends on how long your category's ad effect lingers, which you estimate from past campaigns.

:::callout insight
The cheapest impressions and the most valuable moment rarely coincide. Buying only at the peak means buying when prices are highest, so a measured run-up often beats a pure spike.
:::

:::widget adstockExplorer
:::

# Pacing within a flight

Picking the pattern sets how much each flight gets. Pacing is the separate job of spending that flight budget smoothly across its days and hours. Left alone, an aggressive campaign front-loads, blowing the budget by noon and going dark when valuable users show up later. A pacing throttle releases spend on schedule so it lasts the whole flight.

$$ target\_spend(t) = budget \times t / T $$

The throttle compares actual spend against the straight-line target at each moment and tightens or loosens bidding to stay on the line. Drag the controls and watch the throttle hold spend to the target even when demand surges.

:::widget pacingController
:::

:::quiz
question: A product sells steadily all year with a strong spike every December. Which schedule fits best?
- Pulsing, a steady baseline with a burst layered on for December
- Continuity, the same spend every week
- Flighting, all spend in December and nothing the rest of the year
- No schedule, spend whenever impressions are cheapest
answer: 0
explain: Year-round demand argues for a continuous baseline, and the December spike argues for an added burst. Pulsing combines both, which pure continuity or pure flighting cannot.
:::

:::sources
- RCStrat, Marketing professional glossary: flighting and pacing | https://rcstrat.com/glossary/flighting-and-pacing
- Interactive Advertising Bureau, measurement guidelines | https://www.iab.com/guidelines/
:::
