---
id: engineering-04
track: engineering
module: 4
title: Bidder architecture
summary: See how a bidder handles requests, narrows millions of campaigns to a few candidates, and scales horizontally to hundreds of thousands of QPS.
---
# The bidder is a stateless worker

The bidder is the service that touches live traffic. It is deliberately stateless: any instance can handle any request, because everything it needs (campaigns, targeting, models, budgets) is loaded into local memory and refreshed out of band. Statelessness is what lets you scale it horizontally, by adding identical instances behind a load balancer.

A single request flows through a fixed pipeline: accept the connection, parse and validate the OpenRTB payload, select candidates, score and price them, choose a winner, serialize the response. Each stage has a time budget, and the pipeline is designed so no stage can block indefinitely.

:::figure rtbFlow
caption: Any stateless instance can serve any request because campaigns, models, and budgets live in local memory. The bid request flows through one fixed pipeline, and a load balancer spreads traffic across identical workers.
:::

# Candidate selection is the hard filter

A DSP may run millions of active line items, but only a handful can possibly match any given impression. Evaluating every campaign per request is impossible at the deadline, so candidate selection is an indexing problem. The bidder builds inverted indexes keyed on targeting dimensions (geo, device type, inventory, audience segment) and intersects them to retrieve only campaigns that match.

This narrows millions of campaigns to tens of candidates in microseconds. Only those survivors get the expensive treatment: model inference, pacing checks, and pricing. Getting selection wrong in either direction is costly: too loose and you waste your compute budget scoring junk, too tight and you silently drop winnable demand.

:::callout key
Candidate selection is a retrieval problem, not a scan. Inverted indexes on targeting dimensions cut millions of campaigns to a few dozen before any expensive scoring runs.
:::

:::widget barChart
title: Typical candidate funnel through the bid pipeline (illustrative count)
data: 2000000, 40000, 800, 40, 1
labels: All line items, Geo match, Device match, Audience match, Winner
:::

# Throughput and utilization

Exchanges send traffic at a rate measured in queries per second (QPS), and large DSPs sustain several hundred thousand QPS with daily peaks far higher. Exchanges enforce a per-bidder QPS quota and treat it as a not-to-exceed SLA: send timeouts or errors and they throttle the traffic they offer you.

Capacity planning rests on a simple relationship. If one instance safely serves a given QPS at acceptable latency, the fleet size you need is total QPS divided by per-instance QPS, plus headroom.

$$ N = QPS_{total} / (QPS_{instance} \times U_{target}) $$

`U_target` is your target utilization, kept well below 1 (often 0.6 to 0.7) because latency climbs sharply as a server approaches saturation. Running hot to save machines fattens your latency tail and costs you auctions, which is the opposite of efficient.

:::callout warning
Do not size a bidder fleet for 100% utilization. Queueing delay rises steeply near saturation, so plan for 60 to 70% target utilization to keep the latency tail inside the deadline.
:::

:::predict
prompt: You must serve 300,000 QPS. One instance safely handles 5,000 QPS, and you target 60% utilization. How many instances does the fleet need?
answer: 100
hint: Divide total QPS by the effective per-instance capacity, which is instance QPS times target utilization.
explain: N = 300,000 / (5,000 x 0.6) = 300,000 / 3,000 = 100 instances. Targeting 60% rather than 100% utilization is what raises the count from 60 to 100, buying you tail-latency headroom.
:::

# Horizontal scale and traffic shaping

Because the bidder is stateless, scaling is mostly mechanical: provision more identical instances and spread load across them. QPS swings dramatically through the day, so fleets autoscale, and DSPs often apply admission control, sampling or dropping low-value request patterns when load spikes, so the requests most likely to win get the full compute budget.

Use the simulator to set per-instance capacity and incoming QPS, then watch utilization and the resulting latency and drop rate. Push utilization past the safe zone and see the tail blow out.

:::widget throughputSimulator
:::

:::quiz
question: Why do DSPs target around 60 to 70% utilization on bidder instances rather than running them near 100%?
- Exchanges require idle capacity
- Latency and queueing delay rise sharply near saturation, fattening the tail and losing auctions
- Higher utilization violates OpenRTB
- It reduces the number of campaigns that can match
answer: 1
explain: As a server approaches full utilization, queueing delay grows nonlinearly. The latency tail blows past the deadline, so running hot loses more revenue than the machines saved.
:::

:::sources
- Best Practices for RTB Applications, Google Authorized Buyers | https://developers.google.com/authorized-buyers/rtb/get-started/practices-guide
- From 0.5 Million to 2.5 Million: Efficiently Scaling up Real-Time Bidding (Shen et al., ICDM 2015) | https://ieeexplore.ieee.org/document/7373421
:::
