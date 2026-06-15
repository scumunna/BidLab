---
id: dsp-07
track: dsp
module: 7
title: Budget pacing
summary: Spend a campaign budget smoothly across its flight using even pacing and a feedback control loop.
---
# Spending is a timing problem

A campaign has a budget and a flight, the window over which it must spend. Pacing is the discipline of deciding not where to spend but when. Spend too fast and you blow the budget by noon, missing the cheap inventory that shows up later. Spend too slow and you end the flight with money left and goals unmet.

The DSP cannot simply bid on everything until the money runs out. It has to ration participation across the day so the budget lasts and the spend curve tracks the goal. That rationing is pacing.

:::widget lineChart
title: Even-pacing target, cumulative spend over a 24-hour flight (typical)
unit: $k
labels: 0h, 4h, 8h, 12h, 16h, 20h, 24h
data: 0, 8, 16, 24, 32, 40, 48
:::

# Even pacing versus ASAP

There are two basic styles. ASAP pacing (as soon as possible) bids aggressively from the start and spends the budget as fast as auctions allow. It front-loads delivery, which is fine for a flash sale but tends to overpay during peak hours and ignores cheaper supply later.

Even pacing spreads spend smoothly across the flight, aiming to have spent roughly the same fraction of budget as the fraction of time elapsed. At hour 12 of a 24-hour flight, an even-paced campaign has spent about half its budget. Even pacing samples inventory across the whole day, which usually buys more impressions per dollar and smooths delivery.

:::callout insight
Even pacing ties spend to time. The target at any moment is simple: fraction of budget spent should equal fraction of the flight elapsed. Everything else is keeping the campaign on that line.
:::

:::predict
prompt: A campaign has a $48,000 budget over a 24-hour flight and paces evenly. By hour 6, what is the target cumulative spend?
answer: 12000
unit: $
hint: Multiply the budget by the fraction of the flight that has elapsed.
explain: Fraction elapsed = 6 / 24 = 0.25, so target spend = 0.25 x $48,000 = $12,000. Even pacing keeps spent budget tracking elapsed time.
:::

# The control loop

Pacing cannot be set once and forgotten, because traffic and prices change hour to hour. So it runs as a feedback loop. The controller repeatedly measures the error, the gap between where spend actually is and where the even-pacing target says it should be, and adjusts a throttle or a bid multiplier to close that gap.

$$ error = spend_{actual} - spend_{target} $$

If spend is behind target, the controller bids more often or higher. If spend is ahead, it pulls back. The industry workhorse for this is a PID controller (proportional-integral-derivative), which reacts to the current error, the accumulated error, and the rate of change, giving smooth and stable pacing that does not oscillate.

:::callout key
Pacing is closed-loop control. Measure the spend error against the even-pacing target, adjust the throttle, and repeat. A PID controller does this smoothly enough to stay on pace without lurching.
:::

:::predict
prompt: At hour 6 the even-pacing target is $12,000 but actual spend is only $9,500. What is the pacing error, spend actual minus spend target?
answer: -2500
unit: $
hint: Error is actual spend minus the target. A negative value means the campaign is behind pace.
explain: error = $9,500 - $12,000 = -$2,500. The campaign is $2,500 behind target, so the controller should bid more often or higher to catch up.
:::

# Watching it run

The pacing controller below tracks a target spend line across a flight and throttles participation to stay on it. Push the spend rate up and the controller throttles down to protect the budget. Starve it and the controller opens up to catch back up to target.

A well-tuned controller lands on budget at the end of the flight with smooth delivery throughout. A poorly tuned one overspends early then goes dark, or limps along and under-delivers. Pacing quality is judged by both: hit the budget and stay close to the target line the whole way.

:::widget pacingController
:::

:::quiz
question: Under even pacing, roughly what fraction of the budget should be spent at the midpoint of a campaign's flight?
- All of it
- About half
- None until the final hour
- Whatever wins the most auctions
answer: 1
explain: Even pacing ties spend to elapsed time, so at the halfway point of the flight a campaign should have spent about half its budget. The control loop keeps actual spend close to that target.
:::

:::sources
- A Practical Guide to Budget Pacing Algorithms in Digital Advertising | https://arxiv.org/pdf/2503.06942
- Smart Pacing for Effective Online Ad Campaign Optimization, Xu et al. | https://arxiv.org/pdf/1506.05851
:::
