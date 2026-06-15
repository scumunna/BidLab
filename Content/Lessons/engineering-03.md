---
id: engineering-03
track: engineering
module: 3
title: The real-time constraint
summary: Decompose the latency budget of a bidder, see why the tail of the latency distribution sets your timeout rate, and reason about p99.
---
# The deadline is non-negotiable

Every exchange enforces a hard timeout. Per the OpenRTB spec the bid response window is typically capped between 100 and 300 milliseconds, and large exchanges like Google Authorized Buyers run near 100. A bid that arrives after the timeout is dropped before the auction settles, so a late bid earns exactly zero, the same as no bid at all.

This is what makes a DSP different from a normal web service. Latency is not a quality metric you tune later. It is a correctness constraint. Either you answer in time or you did not participate.

:::widget barChart
title: Typical exchange bid-response deadlines (illustrative, ms)
data: 100, 120, 150, 200, 300
labels: Google ADX, Exchange B, Exchange C, Exchange D, Spec max
unit: ms
:::

# Decomposing the budget

Of the exchange deadline, you do not get all of it. Subtract the round-trip network time between the exchange and your server, then subtract a safety margin for jitter, and what remains is your compute budget for parsing, candidate matching, model inference, and pacing.

$$ t_{compute} = t_{deadline} - 2\,t_{owd} - t_{margin} $$

Here `t_owd` is the one-way network delay, so the round trip is twice that. For a 100 millisecond deadline, a 15 millisecond one-way path, and a 10 millisecond margin, you are left with about 60 milliseconds of compute. Place your servers closer to the exchange and that budget grows. This is why DSPs deploy in multiple regions near major exchange data centers.

:::callout key
Your usable compute time is the exchange deadline minus the network round trip minus a jitter margin. Network proximity is not a nicety; it directly buys you milliseconds of model and matching work.
:::

:::predict
prompt: The exchange deadline is 120 ms, the one-way network delay is 20 ms, and you hold back a 10 ms jitter margin. How many milliseconds of compute does the bidder have left?
answer: 70
unit: ms
hint: Subtract the round trip (twice the one-way delay) and the margin from the deadline.
explain: Compute = 120 - (2 x 20) - 10 = 120 - 40 - 10 = 70 ms. The round trip costs 40 ms because the one-way delay is paid in both directions.
:::

# The tail is what kills you

Average latency lies. If your mean response time is 25 milliseconds but your p99 is 95, then one request in a hundred is brushing the timeout. At hundreds of thousands of QPS, that one percent is thousands of lost auctions every second, concentrated in exactly the moments when your system is under load.

A common operational rule: if p99 latency exceeds about 80 milliseconds against a 100 millisecond deadline, you are at real risk of timing out, and above 100 you are simply losing auctions. You manage the tail, not the average. That means bounding work per request: cap candidate counts, set hard deadlines on model calls, and return a partial decision rather than blowing the budget.

:::callout warning
Optimizing mean latency can hide a fattening tail. Track p99 and p999 against the deadline, because the tail, not the average, determines how many auctions you forfeit.
:::

:::predict
prompt: Your bidder runs at 400,000 QPS and its p99 latency exceeds the exchange deadline, so the slowest 1% of requests time out. How many auctions are lost every second?
answer: 4000
hint: The p99 tail is 1% of the requests. Apply that fraction to the QPS.
explain: A p99 over the deadline means 1% of traffic times out. 1% of 400,000 = 4,000 lost auctions every second, which is why the tail, not the mean, is what you manage.
:::

# Designing for timeouts

Because the tail is unavoidable, a well-built bidder treats the deadline as a first-class input. It runs a request-scoped timer, and when the clock runs low it short-circuits: skip the expensive model, fall back to a cheaper heuristic bid, and still return something inside the window. A bid computed from a coarse estimate beats a perfect bid that arrives one millisecond late.

The simulator below lets you set a deadline, a latency distribution, and a tail, then watch how many requests time out. Push the tail wider and see the loss climb even while the average stays flat.

:::widget latencySimulator
:::

:::quiz
question: Your bidder's mean response time is 25 ms but its p99 is 98 ms against a 100 ms exchange deadline. What is the main problem?
- The average is too high
- Roughly 1% of requests are nearly timing out, forfeiting many auctions at high QPS
- The exchange deadline is too short
- Network latency is irrelevant here
answer: 1
explain: The tail, not the mean, sets your timeout rate. A p99 near the deadline means about one request in a hundred is lost, which is enormous at hundreds of thousands of QPS.
:::

:::sources
- OpenRTB 2.6 Specification, IAB Tech Lab | https://iabtechlab.com/standards/openrtb/
- Testing and Releasing Your Application (latency and deadline requirements), Google Authorized Buyers RTB | https://developers.google.com/authorized-buyers/rtb/test-guide
:::
