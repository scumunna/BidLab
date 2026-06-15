---
id: analytics-15
track: analytics
module: 15
title: Data clean rooms and differential privacy
summary: How clean rooms join two parties' data without exposing individuals, and the k-anonymity, differential privacy, and match-rate math that governs the privacy-accuracy tradeoff.
---
# A neutral room where two datasets meet

A data clean room is a controlled environment where two parties, typically an advertiser and a retail media network, can join their data and run analysis without either side seeing the other's raw records. The retailer brings purchase data, the advertiser brings its customer or exposure list, and only aggregated, privacy-protected outputs come back out. Adoption is being driven hard by retail media, where buyers want to verify closed-loop results against the 94% trust gap in retailer-reported metrics (eMarketer; Digital Applied). The whole design rests on one idea: you can compute on data you are never allowed to read.

:::figure supplyChain
caption: Two parties feed inputs into a neutral middle layer. Raw records stay on each side; only aggregated, privacy-protected results leave the room.
:::

# Match rate: how much of the audience actually overlaps

Before any analysis, the two datasets are matched on shared keys such as hashed emails. The match rate is the share of your records that find a counterpart on the other side, and it caps how much of your audience the clean room can ever measure.

$$ Match\ Rate = \frac{Matched\ Records}{Total\ Records\ Submitted} \times 100 $$

A low match rate is not a privacy feature, it is a coverage problem: you are reasoning about a thin, possibly biased slice of your audience.

:::predict
prompt: An advertiser submits a list of 500,000 hashed customer records to a retailer's clean room, and 320,000 are matched to retailer profiles. What is the match rate?
answer: 64
unit: %
hint: Divide matched records by total records submitted, then multiply by 100.
explain: Match rate = 320,000 / 500,000 x 100 = 64%. The remaining 36% cannot be measured in the room, so any lift or overlap result describes only the matched two thirds.
:::

# k-anonymity: no answer about too few people

The first privacy guardrail most clean rooms enforce is a minimum aggregation threshold, expressed as k-anonymity: any reported cohort must contain at least k individuals, or the result is suppressed. This stops a query from isolating a single household by slicing filters until only one person remains. Typical thresholds sit in the tens of users, set by the data provider.

:::callout key
k-anonymity guarantees that every released row is indistinguishable from at least k - 1 others on the queried attributes. Set the threshold too low and you risk re-identification; set it too high and small but real segments get suppressed and disappear from your analysis.
:::

:::predict
prompt: A clean room enforces a k-anonymity threshold of k = 50. A requested audience segment contains only 38 matched users and is suppressed. How many additional users would the segment need to clear the threshold?
answer: 12
hint: The segment must reach the minimum cohort size k. Subtract the current count from that minimum.
explain: 50 - 38 = 12. The segment is 12 users short of the k = 50 floor, so the clean room returns no result until it grows or is merged with another segment.
:::

# Differential privacy: a budget for noise

k-anonymity protects against isolating an individual, but repeated overlapping queries can still leak information. Differential privacy closes that gap by adding calibrated random noise to each answer, controlled by a privacy budget called epsilon. A smaller epsilon means more noise, stronger privacy, and less accuracy; a larger epsilon means less noise, weaker privacy, and more accuracy. This is the core tradeoff: privacy and accuracy move in opposite directions, and epsilon is the dial.

$$ \epsilon_{per\ query} = \frac{\epsilon_{total}}{Number\ of\ Queries} $$

The budget is finite and consumed across queries. Spend it on too many questions and each answer gets noisier, which is why analysts plan their queries instead of fishing.

:::widget distributionExplorer
distribution: laplace
note: Differential privacy perturbs each true count with noise drawn from a distribution whose width grows as epsilon shrinks. Smaller epsilon, wider noise, more privacy, less accuracy.
:::

:::predict
prompt: An analyst is allotted a total differential-privacy budget of epsilon = 1.0 and plans to spend it equally across 4 separate queries. What is the epsilon budget per query?
answer: 0.25
tolerance: 0.01
hint: Divide the total epsilon budget evenly by the number of queries.
explain: Epsilon per query = 1.0 / 4 = 0.25. A smaller per-query epsilon means more noise on each answer, so splitting a fixed budget across more queries makes every individual result less accurate.
:::

# Federated learning: move the compute, not the data

The newest pattern inverts the clean-room flow. Instead of pooling records in a middle layer, federated learning sends the model or computation out to where each party's data already lives, trains locally, and returns only aggregated updates. The raw data never moves. Combined with k-anonymity thresholds and a differential-privacy budget on the shared outputs, it lets parties collaborate while keeping the accuracy-versus-privacy dial firmly in view (Digital Applied).

:::quiz
question: A brand lowers the differential-privacy epsilon on its clean-room queries from 1.0 to 0.1. What happens?
- More noise is added, so privacy increases and result accuracy decreases
- Less noise is added, so both privacy and accuracy increase
- The match rate rises because fewer records are suppressed
- Nothing changes, since epsilon only affects k-anonymity thresholds
hint: Smaller epsilon means a tighter privacy budget. Which direction does that push the noise?
answer: 0
explain: A smaller epsilon tightens the privacy budget and adds more noise to each answer. Privacy goes up and accuracy goes down. Epsilon governs differential-privacy noise, not the k-anonymity cohort threshold or the match rate.
:::

:::sources
- FAQ on Data Clean Rooms, eMarketer | https://www.emarketer.com/content/faq-on-data-clean-rooms-how-retail-media-driving-adoption-marketers-demand-proof
- Data Clean Rooms in Advertising 2026, Digital Applied | https://www.digitalapplied.com/blog/data-clean-rooms-advertising-2026-marketer-decision-guide
:::
