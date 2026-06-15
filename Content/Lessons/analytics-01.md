---
id: analytics-01
track: analytics
module: 1
title: The analyst's role and the measurement stack
summary: Start from the decision, not the dashboard, and learn where ad data comes from and how it stacks up into answers.
---
# Start with the question

The analyst's job is not to produce numbers. It is to reduce uncertainty about a decision someone is about to make. Before you query anything, name the decision: raise this campaign's budget, kill that line item, renegotiate a publisher deal. The question fixes the metric, the population, and the bar for action.

A question-first analyst writes the conclusion sentence before the query. "We should shift spend to channel A because its incremental cost per acquisition is at least 20% lower." That sentence tells you exactly what to measure (incremental CPA), what to compare (channel A versus the rest), and how big a gap matters (20%). A dashboard built without that sentence answers questions nobody asked.

:::callout key
A metric only earns its place by changing a decision. If the number moves and nobody does anything differently, you measured the wrong thing.
:::

:::quiz
question: Your conclusion sentence reads "shift spend to channel A because its incremental CPA is at least 20% lower." Which detail does that sentence NOT fix in advance?
- The exact dashboard color scheme to use
- The metric to measure (incremental CPA)
- The comparison to run (channel A versus the rest)
- The action bar (a 20% gap)
hint: A conclusion sentence pins down the metric, the comparison, and the threshold. Which option is none of those?
answer: 0
explain: The sentence fixes the metric, the comparison, and the bar for action. Presentation details like color are downstream of the decision and do not belong in the conclusion sentence.
:::

# Where the data comes from

Programmatic data arrives from several systems that rarely agree. The demand-side platform logs bids, wins, and spend. The ad server logs impressions and clicks. The publisher or supply-side platform logs its own impressions. Your site or app logs conversions. Each counts with its own clock, its own dedup rules, and its own definition of a valid event, so two "impression" totals can differ by 10% or more for honest reasons.

Treat every source as a witness with a point of view, not as ground truth. The analyst's craft is reconciling these witnesses into one defensible story, knowing which source is authoritative for which metric (the ad server for delivery, your own backend for conversions).

:::predict
prompt: Your ad server logs 1,000,000 impressions for a campaign while the publisher's SSP logs 1,100,000 for the same line item. By what percent does the SSP count exceed the ad server count?
answer: 10
unit: %
tolerance: 0.1
hint: Take the difference between the two counts, divide by the ad server count, then multiply by 100.
explain: Discrepancy = (1,100,000 - 1,000,000) / 1,000,000 x 100 = 10%. Different clocks and dedup rules routinely produce double-digit gaps between two honest "impression" totals, which is why you name the authoritative source per metric.
:::

# The measurement stack

Think of measurement as a stack you climb. At the bottom sit raw event logs: one row per bid, impression, click, or conversion. Above that, those events are joined and cleaned into sessions and user journeys. Above that, you aggregate into metrics like reach, frequency, and conversion rate. At the top sit the causal questions: did the ad cause the conversion, and what would have happened without it.

$$ \text{logs} \to \text{events} \to \text{metrics} \to \text{causal claims} $$

Each layer up loses detail and gains meaning, and each adds assumptions. A conversion rate hides the join logic beneath it. A lift estimate hides the conversion rate beneath that. Good analysts can always descend the stack to defend a number when someone challenges it.

:::callout insight
Reporting answers "what happened" from the metrics layer. Causal inference answers "what would have happened otherwise" and requires a design, not just a query. Do not confuse the two.
:::

:::widget funnelExplorer
:::

:::quiz
question: A stakeholder asks for "all the data we have on this campaign." What is the best first move?
- Ask which decision the data will inform, then scope the pull to that
- Export every table and let them sort it out
- Build a dashboard with every available metric
- Pull only the metrics that look good
answer: 0
explain: Question-first analysis scopes the work to a decision. Without the decision, "all the data" is unbounded and most of it will not change any action.
:::

:::sources
- Avinash Kaushik, Web Analytics 2.0 | https://www.kaushik.net/avinash/
- IAB Tech Lab, Ad Measurement Standards | https://iabtechlab.com/
:::
