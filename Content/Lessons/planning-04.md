---
id: planning-04
track: planning
module: 4
title: Reach and frequency
summary: How impressions turn into unique people reached, and why the curve bends as you buy more.
---
# One person, many impressions

Buy a million impressions and you do not reach a million people. Some people see your ad once, some twice, some ten times, and some not at all. Reach is the count of unique people hit at least once. Frequency is how often, on average, each reached person saw it.

If impressions land at random across a population of size N, the number of times any one person is hit follows a Poisson distribution with mean equal to impressions divided by N. Unique reach is then the share hit at least once.

$$ reach = N\,(1 - e^{-impressions / N}) $$

:::callout insight
Reach has diminishing returns. The first impressions find fresh people. Later impressions increasingly hit people you already reached, so frequency climbs while new reach slows.
:::

:::predict
prompt: You buy 1,000,000 impressions at random across a population of 1,000,000 people. Using reach = N(1 - e^(-impressions/N)), about how many unique people do you reach?
answer: 632121
unit: people
tolerance: 2000
hint: Here impressions divided by N equals 1, so reach is N times (1 minus e to the minus 1).
explain: reach = 1,000,000 x (1 - e^-1) = 1,000,000 x (1 - 0.368) = about 632,000. One impression per person on average reaches only 63 percent, because some people get hit twice while others are missed.
:::

# Try it

Drag impressions and watch reach bend while average frequency rises. Notice how reaching the last slice of the audience costs far more than the first.

:::widget reachFrequency
population: 1000000
:::

Planners use effective reach, the people hit at least some minimum number of times, because one exposure rarely moves anyone. The threshold depends on the goal and the creative.

:::callout key
Spending more does not keep buying reach at the same rate. Past a point you are mostly buying frequency, which is the moment to widen the audience or change channels.
:::

:::quiz
question: You double impressions on the same audience. What happens?
- Reach less than doubles and average frequency rises
- Reach exactly doubles
- Frequency stays the same
- Reach falls
answer: 0
explain: Reach has diminishing returns. Doubling impressions adds some new reach but increasingly repeats on people already reached, so average frequency goes up.
:::

:::sources
- Interactive Advertising Bureau, measurement guidelines | https://www.iab.com/guidelines/
:::
