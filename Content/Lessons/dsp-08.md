---
id: dsp-08
track: dsp
module: 8
title: Frequency and reach capping
summary: How frequency caps reshape unique reach, and the Poisson and inclusion-exclusion math a trader uses to predict it.
---
# Capping the same face

Show a person the same ad twenty times and the twenty-first does almost nothing. A frequency cap is a limit a trader sets on how many times one user can see a campaign over a window, say three impressions per day. Below the cap you keep buying useful exposures. Above it you are paying to annoy people you already reached.

Caps are enforced per user identifier (a cookie, a device id, or a hashed login) over a defined window. The cap trades raw impression volume for cleaner reach. The math question is what a given cap does to the unique people you touch and to the average frequency among them.

:::predict
prompt: A campaign serves 3,000,000 impressions and reaches 1,000,000 unique people. What is the average frequency per reached person?
answer: 3
unit: x
hint: Average frequency is total impressions divided by the number of unique people reached.
explain: Average frequency = 3,000,000 / 1,000,000 = 3. On average each reached person saw the ad three times, which a cap of 3 per window would hold in place.
:::

# Reach as a Poisson draw

If impressions land roughly at random across a population of size N, the number of times any one person is hit follows a Poisson distribution with mean equal to total impressions divided by N. Call that mean lambda. The chance a person is hit zero times is e to the minus lambda, so unique reach is the share hit at least once.

$$ reach = N\,(1 - e^{-\lambda}), \quad \lambda = impressions / N $$

A frequency cap of k changes the picture. Impressions that would have landed on someone already at the cap are blocked, so they either find fresh users or go unspent. Capped delivery pushes the distribution of exposures toward the low end, which lifts unique reach per impression and pulls average frequency down toward the cap.

:::callout insight
Without a cap, extra impressions pile onto people you already reached. A cap forces spend toward fresh users, so each capped impression buys more incremental reach than an uncapped one.
:::

:::predict
prompt: Impressions land at random across a population of N = 1,000,000 with mean lambda = 1 impression per person. Using reach = N(1 - e^-lambda), about how many unique people are reached? Use e^-1 = 0.368.
answer: 632000
unit: people
tolerance: 2000
hint: Plug into N times (1 - e^-lambda). The share reached is 1 minus the chance of being hit zero times.
explain: reach = 1,000,000 x (1 - 0.368) = 1,000,000 x 0.632 = 632,000 people. Even with one impression per person on average, about 37 percent are missed entirely because impressions cluster.
:::

# Counting overlap with inclusion-exclusion

When a campaign runs across several sites or placements, the same person can be reached by more than one. Total unique reach is not the sum of each placement's reach, because that double counts the overlap. Inclusion-exclusion corrects it for two placements A and B, the union size is |A| plus |B| minus |A and B|: add the singles, subtract the pairwise overlaps, add back the triples, and so on.

For two placements that each reach 600k people with 200k in common, unique reach is 600k plus 600k minus 200k, which is 1,000,000, not 1,200,000. The more your supply paths overlap, the more raw reach numbers overstate the truth, and the more a cap shared across placements actually saves.

:::widget reachFrequency
population: 1000000
:::

:::callout key
A frequency cap only works if it is enforced across every path that can reach the same user. A per-placement cap leaks: the user hits the cap on each site separately and still gets over-served overall.
:::

:::quiz
question: You add a strict frequency cap to a campaign that was over-delivering on a narrow audience. What happens to unique reach per impression?
- It rises, because blocked impressions get redirected toward users not yet reached
- It falls, because fewer impressions are served
- It stays the same, caps only affect frequency
- It rises only if the population is infinite
answer: 0
explain: A cap blocks impressions on already-saturated users, so remaining spend lands on fresh users. That raises incremental reach per impression while pulling average frequency down toward the cap.
:::

:::sources
- Interactive Advertising Bureau, measurement guidelines | https://www.iab.com/guidelines/
- Reach Measurement, Optimization and Frequency Capping Under k-Anonymity | https://arxiv.org/pdf/2501.04882
:::
