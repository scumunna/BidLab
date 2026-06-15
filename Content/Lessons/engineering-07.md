---
id: engineering-07
track: engineering
module: 7
title: Pacing as a control system
summary: Model budget pacing as a feedback controller, see how a PID loop smooths spend over a flight, and reason about over- and under-delivery.
---
# Pacing is a control problem

A campaign has a budget and a flight (a window of time), and the job is to spend that budget smoothly across the flight rather than blowing it in the first hour. This is not a bidding question, it is a control question: a system observes how much it has spent, compares that to where it should be, and adjusts its behavior to close the gap.

That framing is exact. Pacing is a closed feedback loop. The setpoint is the target spend curve, the measured variable is actual spend, the error is the difference, and the control output is a throttle that scales bids or admission. Build it as a controller and it self-corrects; build it as a fixed schedule and it cannot react to a market that changes minute to minute.

:::predict
prompt: A campaign has a $36,000 daily budget and you pace it evenly across a 24 hour flight. What is the target spend per hour, the setpoint the controller tracks?
answer: 1500
unit: $
hint: Even pacing divides the budget by the number of hours in the flight.
explain: Target = $36,000 / 24 = $1,500 per hour. That straight-line setpoint is what the controller compares actual spend against to compute its error each interval.
:::

# The throttle is the control output

The bidder cannot spend money directly. It can only change how aggressively it bids, so the controller's output is a throttle, a multiplier between 0 and 1 applied to the bid (or used as a probability of participating at all). Throttle down and you win fewer impressions and spend slower. Throttle up and spend accelerates.

The error driving the throttle is simply how far actual spend has drifted from the plan.

$$ e(t) = spend_{target}(t) - spend_{actual}(t) $$

When `e(t)` is positive you are behind plan and should speed up. When it is negative you are ahead and should slow down. A naive controller reacts to this instantaneous error alone, but that tends to oscillate: overshoot, slam the brakes, undershoot, repeat.

:::callout key
A pacing controller does not spend money. It outputs a throttle on bidding, and the input that drives it is the error between target spend and actual spend over the flight.
:::

:::predict
prompt: At this point in the flight the target spend is $1,500 and actual spend is $1,100. Using e(t) = spend_target - spend_actual, what is the pacing error in dollars?
answer: 400
unit: $
hint: Subtract actual spend from target spend.
explain: e(t) = $1,500 - $1,100 = +$400. A positive error means the campaign is behind plan, so the controller raises the throttle to speed spend up.
:::

# PID smooths the response

A proportional-integral-derivative (PID) controller, borrowed straight from control engineering, smooths the response by combining three terms. The proportional term reacts to the current error. The integral term accumulates past error to remove steady drift. The derivative term responds to how fast the error is changing, damping overshoot.

$$ u(t) = K_p\,e(t) + K_i \Sigma\,e + K_d\,\Delta e $$

Tuned well, a PID loop holds spend on the target curve without the violent swings of a pure on-off throttle. Patents and production systems across the industry use exactly this structure: when a campaign over-paces, the controller eases the bid down; when it under-paces, it raises the bid until spend settles at the lowest price that keeps the campaign on plan.

:::callout insight
The three PID terms answer three questions: how big is the error now (P), how much has it accumulated (I), and how fast is it moving (D). Together they hold spend on plan without oscillating.
:::

:::predict
prompt: A PID controller has Kp = 0.5 with current error 400, Ki = 0.1 with accumulated error 200, and Kd = 0.2 with error change -50. Using u = Kp*e + Ki*sum(e) + Kd*delta(e), what is the control output u?
answer: 210
hint: Compute each of the three terms, then add them. The derivative term is negative here.
explain: u = 0.5*400 + 0.1*200 + 0.2*(-50) = 200 + 20 - 10 = 210. The proportional term dominates, while the negative derivative term trims the output to damp overshoot.
:::

# Failure modes: over- and under-delivery

Two things go wrong. Over-delivery means spending the budget too early, leaving the rest of the flight dark and often overpaying during the rush. Under-delivery means failing to spend the budget at all, which wastes the advertiser's reach and the DSP's revenue. A good controller is judged on pacing error (drift from the curve) and volatility (how jumpy the throttle is), and recent work shows feedback control cutting both substantially over fixed schedules.

The simulator lets you set a budget, a flight, and controller gains, then watch the throttle react to changing supply. Detune the gains and you can see oscillation; tune them and spend tracks the line.

:::callout warning
Over-pacing and under-pacing are both failures. Spending the budget by noon wastes the flight, and ending the day with budget unspent wastes reach. The controller must hold the curve, not just hit the total.
:::

:::widget pacingController
:::

:::quiz
question: In a PID pacing controller, what does the integral term contribute?
- It reacts only to the instantaneous spend error
- It accumulates past error to eliminate steady drift from the target spend curve
- It predicts future click-through rates
- It sets the campaign's total budget
answer: 1
explain: The integral term sums error over time, which corrects persistent bias that a purely proportional controller would leave as a standing gap. The proportional term handles the current error and the derivative term damps overshoot.
:::

:::sources
- Real Time Bid Optimization with Smooth Budget Delivery in Online Advertising | https://arxiv.org/pdf/1305.3011
- Using a PID controller engine for controlling the pace of an online campaign in realtime (US10878448B1) | https://patents.google.com/patent/US10878448B1/en
:::
