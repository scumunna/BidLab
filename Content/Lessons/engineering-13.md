---
id: engineering-13
track: engineering
module: 13
title: "Capstone: build a bidder to spec"
summary: Design a bidder that meets a latency, budget, and accuracy specification at scale, and prove it by simulating QPS and the tail.
---
# The spec is the contract

Everything in this track converges on one task: build a bidder that meets a written spec. A real spec reads like a contract with three clauses. Latency: respond within the exchange timeout, say 100 milliseconds at p99, or the bid is discarded. Budget: spend the campaign's daily cap exactly once, never over. Accuracy: predict value well enough that the bids you place are profitable. Miss any clause and the bidder fails, however well it does on the others.

These clauses pull against each other. A more accurate model takes longer to score, eating your latency budget. Tighter budget control adds reconciliation round trips, also latency. Engineering a bidder is choosing where on these tradeoffs to sit and proving the choice holds under load.

:::predict
prompt: The latency clause of the spec requires a p99 of 100 ms or better. Your bidder measures a p99 of 88 ms at target QPS. How many milliseconds of p99 headroom do you have against the spec?
answer: 12
unit: ms
hint: Subtract your measured p99 from the spec's p99 ceiling.
explain: Headroom = 100 - 88 = 12 ms. That cushion is what absorbs a cold cache or a GC pause before the tail breaches the spec, so a healthy bidder leaves margin rather than running right at 100 ms.
:::

# Budget the latency before you build

Your timeout is a total you must divide across stages. If the exchange allows 100 milliseconds end to end, subtract network transit each way (often 20 to 40 milliseconds round trip) and you may have only 50 to 60 milliseconds of compute. That compute splits across identity lookup, feature fetch, model scoring, budget check, and bid construction. Write the budget down as a table and hold every stage to its share.

$$ T_{p99} = T_{net} + T_{lookup} + T_{score} + T_{budget} + T_{build} $$

:::callout key
Latency is a budget you allocate, not a number you hope for. Decompose the timeout across every stage of the bid path, give each a share, and measure each independently. A stage that quietly overruns its share is what breaches the p99.
:::

:::predict
prompt: Your 100 ms timeout is spent as follows: network 30 ms, identity lookup 8 ms, model scoring 20 ms, budget check 5 ms, and bid construction 7 ms. How many milliseconds of slack remain in the budget?
answer: 30
unit: ms
hint: Add the five stage times, then subtract from the 100 ms timeout.
explain: Stages sum to 30 + 8 + 20 + 5 + 7 = 70 ms, leaving 100 - 70 = 30 ms of slack. That slack is your tail buffer; if any stage overruns its share it eats into the slack before the p99 breaches.
:::

# Design for the tail, not the average

A bidder that is fast on average and slow at p99 still loses. The tail is dominated by the worst case in each stage: a slow feature lookup, a garbage-collection pause, a cold cache, the slowest dependency you call. You defend the tail with timeouts on every downstream call (return a default rather than wait), with caching to make the common path cheap, and with hedging or fallbacks so one slow dependency cannot stall the whole bid.

At a million QPS, the p99 is ten thousand requests per second. Those are real auctions and real revenue. Designing for the tail means accepting a slightly worse answer occasionally (a cached feature, a default bid) in exchange for always answering in time.

:::callout warning
The most common capstone failure is tuning to the average. A bidder with a 20 millisecond mean and a 130 millisecond p99 against a 100 millisecond timeout loses one auction in a hundred to timeouts, silently, while every dashboard looks healthy. Test the tail under open-loop load.
:::

:::predict
prompt: A bidder runs at 250,000 QPS with a p99 above the timeout, so the slowest 1 percent of requests are lost to timeouts. How many auctions does it forfeit every second?
answer: 2500
hint: The p99 tail is 1 percent of the request rate.
explain: 1% of 250,000 = 2,500 auctions lost every second, silently, while the mean looks healthy. Designing for the tail trades a slightly worse cached or default answer for always answering inside the timeout.
:::

# Prove it under load

You cannot validate a latency spec at low traffic. Use open-loop load testing, where requests arrive at a fixed rate regardless of how fast the system responds, because that is what reveals queueing and tail behavior. Closed-loop tests, which wait for each response before sending the next, hide the very saturation you need to find. Ramp to target QPS, hold steady, then push past it to find the breaking point.

Watch the p99 and the timeout-loss rate as you raise load. The spec is met when the bidder holds its latency SLO and its budget cap at target QPS with headroom, and degrades gracefully (shedding load, not melting down) when pushed beyond it.

:::widget latencySimulator
:::

Use the simulator to set a timeout and a load level, then read the fraction of bids lost to the tail. Tune your stage budgets and caching until the loss rate at target QPS sits inside your error budget. That is the bidder meeting its spec, demonstrated rather than asserted.

:::quiz
question: Why use open-loop load testing (fixed arrival rate) rather than closed-loop (wait for each response) to validate a bidder's latency spec?
- Open-loop sends requests regardless of response time, exposing the queueing and tail latency that appear under real saturation
- Closed-loop is more accurate for measuring the tail
- Open-loop uses less hardware
- Closed-loop cannot measure throughput at all
answer: 0
explain: Closed-loop testing slows its own request rate when the system slows, which masks saturation. Open-loop keeps arriving at a fixed rate like real traffic, so queues build and the true p99 and timeout-loss rate become visible.
:::

:::sources
- Site Reliability Engineering, Addressing Cascading Failures, Google | https://sre.google/sre-book/addressing-cascading-failures/
- Testing and Releasing Your Application, Google Authorized Buyers RTB | https://developers.google.com/authorized-buyers/rtb/test-guide
:::
