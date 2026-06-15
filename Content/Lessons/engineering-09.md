---
id: engineering-09
track: engineering
module: 9
title: Data pipelines
summary: How ad events flow from the bidder to reporting, and when to choose streaming, batch, or a hybrid that reconciles both.
---
# From bid to dashboard

Every bid, win, impression, click, and conversion is an event. A large platform emits millions per second. The data pipeline carries these events from the edge where they are generated to the aggregates that power pacing, billing, and reporting. Get it wrong and pacing reacts late, billing disagrees with the exchange, and analysts lose trust in the numbers.

A pipeline has three jobs: ingest events reliably, aggregate them into counts and sums, and serve those aggregates with acceptable freshness. The hard part is doing all three at scale while tolerating duplicates, late events, and machine failures.

:::predict
prompt: A platform emits 3,000,000 ad events per second. How many events does the pipeline ingest over a 5 minute window?
answer: 900000000
hint: Multiply the per-second rate by the number of seconds in 5 minutes.
explain: 3,000,000 events/sec x 300 sec = 900,000,000 events in five minutes. At this volume the aggregation step has to be idempotent and horizontally scalable, because no single machine can count that stream.
:::

# Ingestion and the replayable log

Events land first in a durable, append-only log such as Apache Kafka. The log decouples producers from consumers: the bidder writes events and moves on, while many independent consumers read at their own pace. Because the log is replayable, a consumer that crashes or ships a bug can rewind and reprocess from a known offset rather than losing data.

Events arrive out of order and sometimes twice, because at-least-once delivery is cheaper and more reliable than exactly-once. Downstream aggregation must therefore be idempotent: processing the same event twice should not double-count it. A common trick is to deduplicate on a unique event id within a time window before counting.

:::callout insight
Treat the event log as the source of truth, not the database. If aggregates are derived from a replayable log, you can rebuild any table by reprocessing the log, which turns a class of bugs from data-loss disasters into a replay.
:::

:::predict
prompt: At-least-once delivery means duplicates. A consumer reads 1,000,000 records from the log, but 50,000 are repeats of events it has already seen. After idempotent deduplication on event id, how many unique events does it count?
answer: 950000
hint: Subtract the duplicate records from the total records read.
explain: Unique = 1,000,000 - 50,000 = 950,000. Without idempotent dedup the consumer would count the 50,000 repeats and inflate every aggregate, which is why dedup on a unique event id is mandatory under at-least-once delivery.
:::

# Streaming versus batch

Streaming processes each event as it arrives, updating counters continuously. It gives you freshness measured in seconds, which pacing and fraud systems need. The cost is that streaming aggregates are approximate for a while: late events have not all arrived, so a count can revise upward minutes later.

Batch processes large windows of events at once, say hourly or daily. It is simpler to reason about, easy to recompute, and produces the authoritative numbers used for billing. The cost is latency: a daily batch tells you nothing about the last five minutes.

$$ freshness \approx window + processing_{lag} $$

:::predict
prompt: A streaming aggregation uses a 60 second window and adds 15 seconds of processing lag. Using freshness = window + processing_lag, how stale (in seconds) is the freshest available aggregate?
answer: 75
hint: Add the aggregation window to the processing lag.
explain: freshness = 60 + 15 = 75 seconds. Shrinking the window improves freshness but makes each count noisier, which is the streaming tradeoff against the slower but exact batch path.
:::

# Lambda and kappa

The lambda architecture runs both paths in parallel. A speed layer streams approximate results for freshness, and a batch layer recomputes exact results for correctness, with a serving layer that prefers the batch numbers once they land. It is correct but you maintain two code paths and must keep their logic in sync, which is a recurring source of bugs.

The kappa architecture collapses this into one streaming path over a replayable log. There is no separate batch layer: to recompute history you replay the log through the same stream processor. You get a single codebase and one set of semantics, at the cost of needing a stream engine robust enough to also serve as your batch tool.

:::widget codeLab
:::

:::callout key
Lambda buys correctness with two systems and the burden of reconciling them. Kappa buys simplicity with one system and a replayable log, betting that one stream engine can serve both real-time and reprocessing needs. Most modern platforms trend toward kappa.
:::

:::quiz
question: Why must ad-event aggregation be idempotent in a pipeline built on a replayable log with at-least-once delivery?
- Because the same event can be delivered or replayed more than once, and counting it twice corrupts the aggregates
- Because events always arrive exactly once and in order
- Because idempotency makes the network faster
- Because billing requires events to be processed in random order
answer: 0
explain: At-least-once delivery and log replay both mean an event can be seen more than once. Idempotent aggregation (for example deduplicating on event id) ensures a repeated event does not inflate counts.
:::

:::sources
- Lambda architecture (with the Kappa architecture section), Wikipedia | https://en.wikipedia.org/wiki/Lambda_architecture
- Big Data Architectures, Microsoft Azure Architecture Center | https://learn.microsoft.com/en-us/azure/architecture/databases/guide/big-data-architectures
:::
