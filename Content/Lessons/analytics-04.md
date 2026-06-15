---
id: analytics-04
track: analytics
module: 4
title: SQL for ad data
summary: Write clean-room-grade SQL: window functions, deduplication, and the time-bounded joins that drive attribution.
---
# SQL is the language of the event log

Ad data lives in columnar warehouses, and SQL is how you interrogate it. The same `GROUP BY` that produces a report also produces a feature for a model, so fluent SQL is the analyst's most leveraged skill. The hard parts are not the syntax, they are getting the grain right, deduplicating honestly, and joining across time without leaking the future into the past.

:::quiz
question: You write `SELECT campaign_id, SUM(cost) FROM impressions GROUP BY campaign_id`, but the impressions table has duplicate rows for some impressions. What is wrong with the result?
- The summed cost is inflated, because duplicate rows add their cost again
- Nothing; SUM automatically ignores duplicate rows
- The GROUP BY will fail to run
- Only the row count is affected, not the cost
hint: SUM adds the value in every row it sees, including duplicates. What does that do to a cost column?
answer: 0
explain: SUM aggregates every row at the table's grain, so duplicated impression rows add their cost again and overstate spend. Getting the grain right (deduplicate to one row per impression) must come before any SUM.
:::

# Window functions order the journey

A window function computes across a set of rows related to the current row without collapsing them, which is exactly what you need to reconstruct a user's path. `ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY ts)` numbers each user's events in time order, so you can label the first touch, the last touch before a conversion, or the gap between exposures.

```
SELECT user_id, ts, campaign_id,
       ROW_NUMBER() OVER (
         PARTITION BY user_id ORDER BY ts
       ) AS touch_rank
FROM impressions
```

Window functions are how last-touch and first-touch attribution get expressed: rank the touches, then keep the one you care about. `MIN(ts)` per user gives first touch, `MAX(ts)` before the conversion gives last touch, and the count of touches per conversion is the denominator for linear attribution.

:::predict
prompt: A conversion is preceded by 5 qualifying touches in the window. Under linear attribution, which splits credit evenly across all touches, what fraction of the conversion credit does each single touch receive?
answer: 0.2
tolerance: 0.01
hint: Linear attribution divides one whole conversion equally by the count of touches.
explain: Linear credit per touch = 1 / 5 = 0.2. The count of touches per conversion is the denominator, so each of the 5 touches earns 0.2 of the conversion, summing back to 1.0.
:::

# Deduplicate before you count

Raw logs contain duplicates: retried beacons, double-fired pixels, the same impression reported by two systems. Counting them inflates every metric downstream. The standard fix keeps one row per logical event by ranking duplicates and keeping rank 1.

```
WITH ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY impression_id ORDER BY ts
    ) AS rn
  FROM impressions
)
SELECT * FROM ranked WHERE rn = 1
```

:::callout warning
`COUNT(DISTINCT impression_id)` hides duplicates from a count but does nothing for a `SUM`. If a duplicated row carries cost, summing it double-counts spend. Deduplicate the rows first, then aggregate.
:::

:::predict
prompt: True spend on a line item is $40,000. Because of double-fired beacons, 5% of the impression rows are exact duplicates that each still carry their cost. What total spend does a naive `SUM(cost)` report?
answer: 42000
unit: $
hint: The duplicated rows add their cost on top of the true total. Add 5% of the true spend to the true spend.
explain: Duplicate rows add 5% x $40,000 = $2,000 of phantom cost, so the naive sum reports $40,000 + $2,000 = $42,000. Deduplicating to one row per impression before summing removes the inflation.
:::

# Attribution is a time-bounded join

Attribution joins conversions back to the impressions that preceded them, and the time bound is what makes it honest. You link a conversion to impressions for the same user that happened before the conversion and within the attribution window (say 7 days). Without the lower bound on time you credit impressions that came after the sale, which is impossible.

$$ \text{impression.ts} \le \text{conversion.ts} \le \text{impression.ts} + W $$

```
SELECT c.conversion_id, i.campaign_id
FROM conversions c
JOIN impressions i
  ON i.user_id = c.user_id
 AND i.ts <= c.ts
 AND i.ts >= c.ts - INTERVAL '7' DAY
```

:::callout insight
Every attribution model is this join plus a credit rule. Last touch keeps the latest qualifying impression, first touch the earliest, linear splits credit evenly. The join defines the candidates, the rule splits the value.
:::

:::widget sqlLab
:::

:::quiz
question: Why must an attribution join include the condition `impression.ts <= conversion.ts`?
- To avoid crediting impressions that occurred after the conversion
- To make the query run faster
- Because SQL joins require a timestamp condition
- To deduplicate impressions
answer: 0
explain: An impression can only cause a conversion if it came first. Without the lower time bound, the join would credit impressions served after the conversion, which is impossible.
:::

:::sources
- Google BigQuery, Analytic (window) functions | https://cloud.google.com/bigquery/docs/reference/standard-sql/analytic-functions
- PopSQL, Marketing Attribution in SQL | https://popsql.com/sql-templates/marketing/marketing-attribution-in-sql
:::
