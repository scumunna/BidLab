---
id: engineering-01
track: engineering
module: 1
title: How a DSP is built
summary: Understand the major components of a demand-side platform and trace a single bid request from arrival to response.
---
# A DSP is a request-response machine

A demand-side platform (DSP) is, at its core, a high-throughput web service. Supply-side platforms (SSPs) and exchanges send it bid requests over HTTP, and it must answer each one with either a bid or a "no bid" decision. Everything else in the system exists to make that one decision fast, correct, and profitable.

What makes a DSP hard is scale combined with deadlines. A mid-size DSP sees hundreds of thousands of requests per second, and each one must be answered in tens of milliseconds. There is no queue you can let fill up. A late response is the same as no response.

:::predict
prompt: A bidder handles 18,000,000 bid requests over a 60 second window. What is its average throughput in queries per second?
answer: 300000
hint: QPS is total requests divided by the number of seconds.
explain: QPS = 18,000,000 / 60 = 300,000 requests per second. That is the steady arrival rate the fleet must answer inside the deadline, with no queue allowed to build.
:::

# The major components

A DSP splits into two loosely coupled halves. The hot path is the bidder: the stateless service that handles live traffic and returns bid responses. The cold path is everything that prepares the bidder to decide well: campaign management, budget and pacing controllers, audience and targeting data, trained models, and reporting pipelines.

The bidder reads precomputed state and almost never blocks on a database during a request. Campaign configuration, targeting rules, model parameters, and budget signals are pushed into in-memory caches and key-value stores ahead of time. The cold path runs on its own clock (seconds to minutes) and feeds the hot path through these caches.

:::callout key
The bidder is stateless and read-only during a request. All the slow work (training, aggregation, pacing math) happens off the hot path and is delivered as precomputed state.
:::

:::figure rtbFlow
caption: The hot path: an exchange sends a bid request to the stateless bidder, which reads precomputed state from in-memory caches and returns a bid response. The cold path that fills those caches runs on its own clock, off the request.
:::

# The bid path

When a request arrives, the bidder runs a fixed sequence. First it parses the OpenRTB payload and validates it. Then it matches the impression against active campaigns: does the inventory, geo, device, and audience match any targeting rule. Surviving campaigns become bid candidates.

For each candidate the bidder estimates value, usually a predicted click or conversion rate from a served model, multiplies by the advertiser's goal to get a bid, applies pacing throttles and budget caps, and picks a winner among its own candidates. It writes that single best bid into an OpenRTB bid response and returns it. The whole sequence is a budget, not a best effort.

$$ t_{compute} = t_{deadline} - t_{network} - t_{margin} $$

The time the bidder actually has for logic is the exchange deadline minus the round-trip network latency minus a safety margin. If the exchange allows 100 milliseconds and the round trip is 30, the bidder has roughly 60 to 65 milliseconds of compute before it risks timing out.

:::callout insight
A DSP does not "try to bid quickly." It works backward from a hard deadline and spends its remaining budget on the steps that add the most expected value per millisecond.
:::

:::widget codeLab
:::

:::quiz
question: Why does a DSP bidder avoid querying a database during a live bid request?
- Databases cannot store campaign data
- A blocking query risks blowing the per-request latency budget, so state is precomputed and cached in memory
- OpenRTB forbids database access
- It would cost too much money per query
answer: 1
explain: The bidder has only tens of milliseconds. Blocking on a database is unpredictable and can exceed the deadline, so configuration, models, and budget signals are pushed into in-memory state ahead of time.
:::

:::sources
- OpenRTB 2.6 Specification, IAB Tech Lab | https://iabtechlab.com/standards/openrtb/
- Best Practices for RTB Applications, Google Authorized Buyers | https://developers.google.com/authorized-buyers/rtb/get-started/practices-guide
:::
