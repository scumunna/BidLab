---
id: analytics-02
track: analytics
module: 2
title: Data foundations and clean rooms
summary: How impressions, clicks, and conversions are modeled as events, how they join, and how clean rooms let you join across parties without sharing user-level data.
---
# Everything is an event

The atom of ad data is the event: a single thing that happened, stamped with who, what, when, and where. An impression is an event. A click is an event. A conversion is an event. Model each as one immutable row with a timestamp, an identifier, and a payload, and almost every metric becomes a query over events.

This event model matters because programmatic systems are append-only and high volume. You do not update an impression row, you write a new event. Counts, rates, and journeys are then aggregations over an ever-growing log, which is exactly what columnar warehouses are built to scan.

:::quiz
question: In an append-only event model, how do you record that an impression you logged was later found to be invalid (for example, fraudulent)?
- Write a new event marking it invalid; never mutate the original row
- Delete the original impression row
- Edit the original row's status column in place
- Reset the whole impressions table and re-import
hint: Append-only systems do not update or delete; every fact, including a correction, is a new immutable row.
answer: 0
explain: Append-only logs are never mutated. A correction is itself an event, so you append a new row (an invalidation) and let downstream aggregations net it out, preserving a complete, auditable history.
:::

# The core schema

Three tables carry most of the work, linked by shared keys. Impressions and clicks share an impression identifier, since a click is tied to the impression it came from. Conversions link back to a user identifier and a timestamp so you can ask which impressions preceded them.

```
impressions(impression_id, user_id, campaign_id, ts, cost)
clicks(click_id, impression_id, ts)
conversions(conversion_id, user_id, ts, value)
```

A click joins to its impression on `impression_id`, a one-to-one or one-to-zero link. A conversion joins to impressions on `user_id` within a time window, a one-to-many link that is the seed of all attribution. Getting these grains right (one row per impression, per click, per conversion) prevents the double-counting that quietly corrupts reports.

:::callout warning
Joining conversions to impressions on `user_id` alone, with no time bound, links a conversion to impressions that happened after it. Always constrain the join to impressions before the conversion and inside the attribution window.
:::

:::predict
prompt: A single conversion for one user joins to impressions on `user_id` within the window, and that user has 6 qualifying impressions. If you forget to deduplicate the conversion grain and the conversion row is itself duplicated 3 times, how many rows does this one conversion produce in the joined result?
answer: 18
hint: A one-to-many join multiplies rows. Multiply the duplicated conversion rows by the qualifying impressions each one matches.
explain: 3 conversion copies x 6 qualifying impressions = 18 rows. The conversion-to-impression join is one-to-many, so any duplication on either side multiplies through and silently inflates downstream counts. Get the grain right first.
:::

# Joining without sharing: clean rooms

Often the impressions live with a publisher and the conversions live with you, and neither side will hand over raw user-level data. A data clean room is a secure environment where two parties match records on a common key (a hashed email or a shared identifier) and run agreed queries, but neither party can read the other's row-level data. Only aggregated outputs leave the room.

The privacy guarantee comes from constraints on what queries run and what they return. Inputs are pseudonymized, access is restricted, and outputs are aggregated and often noised, so results above a minimum cohort size come out while individuals stay hidden. This is how an advertiser measures exposure-to-conversion across a publisher's inventory without either side seeing the other's users.

$$ \text{advertiser conversions} \;\bowtie_{\text{hashed id}}\; \text{publisher impressions} \;\to\; \text{aggregates only} $$

:::callout insight
A clean room is a join you are allowed to run but not allowed to look inside. The match key links the parties, the aggregation threshold protects the individuals, and only the summary crosses the boundary.
:::

:::widget sqlLab
:::

:::quiz
question: Why do clean-room queries enforce a minimum aggregation threshold (for example, suppress cells with fewer than 50 users)?
- To stop small cohorts from re-identifying individuals in the output
- To make queries run faster
- To reduce storage costs
- Because SQL requires a GROUP BY minimum
answer: 0
explain: Small cells can expose individuals even from aggregates. A minimum cohort size keeps outputs aggregate enough that no single user can be singled out.
:::

:::sources
- LiveRamp, What is a Data Clean Room | https://liveramp.com/explainer/data-clean-rooms
- IAB Tech Lab, Data Clean Room Guidance | https://iabtechlab.com/
:::
