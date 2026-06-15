---
id: engineering-12
track: engineering
module: 12
title: Reliability and cost
summary: How to run a bidder against service-level objectives and an error budget while driving down the cost of every query at scale.
---
# Reliability is a number, not a vibe

At a million queries per second you cannot reason about reliability anecdotally. You define a service-level indicator (SLI), a measurable quantity such as the fraction of bid requests answered within the timeout, and a service-level objective (SLO), the target for that SLI, for example 99.9 percent answered in time. Everything downstream, alerting, on-call, release pace, hangs off these numbers.

The complement of the SLO is the error budget. An SLO of 99.9 percent allows 0.1 percent of requests to miss, and that 0.1 percent is a budget you get to spend. When the budget is healthy you ship features fast. When you are burning it, you stop shipping and fix reliability. The error budget turns a vague tradeoff into an explicit policy.

$$ budget_{error} = 1 - SLO $$

:::callout key
An SLO of 99.9 percent is not a promise of perfection, it is a permit to fail 0.1 percent of the time. The error budget makes that failure quota explicit, so reliability and velocity stop being an argument and become arithmetic.
:::

:::predict
prompt: You set an SLO of 99.95 percent of bid requests answered within the timeout. Using error budget = 1 - SLO, what is the error budget as a percentage?
answer: 0.05
unit: %
tolerance: 0.005
hint: Subtract the SLO from 100 percent.
explain: Error budget = 100% - 99.95% = 0.05%. That 0.05% of requests is a quota you are allowed to miss, and burning it fast is the signal to stop shipping features and fix reliability.
:::

# Observe the tail, not the average

Averages hide the failures that matter. If your mean response is 20 milliseconds but your p99 is 95 milliseconds against a 100 millisecond timeout, one request in a hundred is about to time out and earn nothing. At a million QPS, that p99 tail is ten thousand requests every second. You instrument percentiles (p50, p95, p99, p99.9), not just the mean, because revenue is lost in the tail.

Observability rests on three pillars: metrics for aggregate trends, logs for individual events, and traces for following one request across services. Together they let you answer not just that the SLO is breached but where the time went.

:::callout warning
Watching averages is how you miss the failures customers feel. A healthy mean can sit on top of a p99 that is timing out continuously. Alert on tail percentiles and on error-budget burn rate, not on averages.
:::

:::predict
prompt: At 500,000 QPS, your p99 latency sits above the timeout, so the slowest 1 percent of requests fail. How many requests fall in that p99 tail every second?
answer: 5000
hint: The p99 tail is 1 percent of the request rate.
explain: 1% of 500,000 = 5,000 requests every second land in the tail and time out. A healthy mean hides this entirely, which is why you alert on p99 and p99.9, not the average.
:::

# Cost per query

At scale, efficiency is measured per query. Total infrastructure cost divided by queries served gives a cost per query (or per thousand, to match CPM units). A bidder that costs more per query than the margin it earns per query loses money on every auction, no matter how clever the bid.

Two levers dominate. The first is doing less per query: trimming redundant feature lookups, caching hot data, and skipping auctions you will not win. The second is packing machines tighter, raising utilization so you pay for fewer idle cores. Both push cost per query down, and both must respect the latency tail you just measured.

$$ cost_{query} = cost_{total} / queries $$

:::predict
prompt: A bidder fleet costs $5,000 to run while serving 10,000,000 queries. Expressed per thousand queries to match CPM units, what is the cost?
answer: 0.50
unit: $
tolerance: 0.01
hint: Divide total cost by queries, then multiply by 1000 to get the per-thousand figure.
explain: Cost per query = $5,000 / 10,000,000 = $0.0005, and per thousand that is $0.50. If the bidder earns less than $0.50 margin per thousand queries, it loses money on every auction it serves.
:::

# Utilization fights latency

Here is the trap. Higher utilization lowers cost per query, but as a system approaches saturation, queues grow and tail latency explodes. Push CPU toward 90 percent to save money and your p99 blows through the timeout, you lose auctions, and revenue falls faster than cost. The efficient operating point is the highest utilization that still meets your latency SLO, not the highest utilization possible.

:::widget throughputSimulator
:::

Use the simulator to push utilization up and watch the queue and tail respond. The lesson is that cost and reliability are not independent dials. You optimize cost per query subject to the SLO as a hard constraint, and the sweet spot is well below 100 percent.

:::quiz
question: Why is the most cost-efficient operating point for a bidder usually well below 100 percent utilization?
- Because as utilization approaches saturation, queueing makes tail latency explode and breaches the latency SLO
- Because machines cannot run above 100 percent
- Because lower utilization always means lower total cost
- Because the average latency rises linearly with utilization
answer: 0
explain: Cost per query falls as utilization rises, but near saturation queue depth and tail latency grow sharply. The efficient point is the highest utilization that still satisfies the latency SLO, which is below full saturation.
:::

:::sources
- Site Reliability Engineering, Chapter on Service Level Objectives, Google | https://sre.google/sre-book/service-level-objectives/
- M/M/1 queue (queueing delay rises sharply near saturation), Wikipedia | https://en.wikipedia.org/wiki/M/M/1_queue
:::
