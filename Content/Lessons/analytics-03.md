---
id: analytics-03
track: analytics
module: 3
title: Descriptive analytics
summary: Aggregate events into distributions and summary statistics, and read cohorts before you reach for any model.
---
# Aggregate before you model

Descriptive analytics compresses millions of events into a few numbers a human can hold. You group rows by a dimension (campaign, day, audience) and apply an aggregate (count, sum, average) to a measure (impressions, spend, conversions). Reach, frequency, click-through rate, and cost per acquisition are all just group-and-aggregate over the event tables.

The discipline is choosing the grain and the aggregate that answer the question. "Average conversions per user" and "conversion rate per impression" both sound like conversion measures, but they have different denominators and answer different questions. Name the denominator out loud before you trust the ratio.

:::predict
prompt: A campaign serves 800,000 impressions and records 12,000 conversions. What is the conversion rate per impression, as a percent?
answer: 1.5
unit: %
tolerance: 0.01
hint: Conversion rate per impression is conversions divided by impressions, times 100.
explain: CVR = 12,000 / 800,000 x 100 = 1.5%. Note the denominator is impressions, not users, so this answers a different question than "conversions per user." Always name the denominator before trusting the ratio.
:::

# Distributions, not just averages

The mean hides as much as it reveals. Ad metrics are almost always right-skewed: a handful of heavy users or expensive impressions pull the average far above the typical value. Frequency per user, time-to-conversion, and bid prices all have long right tails, so the mean sits well above the median.

Always look at the shape. Report the median and a few percentiles (p50, p90, p99) alongside the mean, and the picture changes. If mean frequency is 4 but the median is 2 and the p99 is 40, your "average" user barely sees the campaign while a small group is bombarded.

:::callout warning
Reporting only the mean of a skewed distribution misleads. A long right tail drags the mean above what almost every user actually experiences. Pair it with the median and tail percentiles.
:::

:::quiz
question: Mean frequency on a campaign is 4.0, but the median is 2 and the p99 is 40. What does this combination tell you?
- Most users see the campaign about twice; a small group is heavily overexposed and drags the mean up
- Every user sees the campaign roughly four times
- The data is corrupt because the mean and median disagree
- Frequency is evenly distributed across all users
hint: When the mean sits well above the median, a long right tail is pulling it up. Who lives in that tail?
answer: 0
explain: A median of 2 with a mean of 4 and a p99 of 40 is a classic right-skewed distribution. The typical user sees the campaign about twice while a small overexposed group inflates the mean, which is exactly why you report the median and tail percentiles alongside it.
:::

# Summary statistics that travel

A useful summary survives being passed to someone who never saw the raw data. Center (mean or median), spread (standard deviation or interquartile range), and shape (skew, tail percentiles) together describe a distribution compactly. The standard deviation measures typical distance from the mean.

$$ \sigma = \sqrt{\Sigma (x_i - \mu)^2 / n} $$

Spread is as important as center. Two campaigns can share a mean CPA of \$20 while one is steady at \$18 to \$22 and the other swings from \$5 to \$80. The first is a reliable buy, the second is a gamble, and only the spread tells you which is which.

:::widget distributionExplorer
:::

# Cohorts reveal what averages bury

A cohort is a group defined by when or how it entered (users first exposed in week 1, users acquired through channel A). Tracking a cohort over time separates real change from mix shift. A blended conversion rate can fall simply because a low-converting cohort grew, even though every individual cohort improved. This is Simpson's paradox, and cohorts are how you catch it.

:::callout insight
When a blended metric moves, ask whether the underlying rates changed or just the mix of cohorts. Cohort analysis tells the two apart before you credit or blame anyone.
:::

:::quiz
question: A campaign's blended CTR dropped this month, yet CTR rose for every individual audience. What most likely happened?
- The audience mix shifted toward lower-CTR audiences (a mix effect)
- Every audience genuinely got worse
- The tracking broke
- CTR is impossible to compute
answer: 0
explain: This is Simpson's paradox. The blended rate is a weighted average, so a shift toward lower-CTR audiences can pull the blend down even as each audience improves.
:::

:::sources
- Tukey, Exploratory Data Analysis | https://archive.org/details/exploratorydataa0000tuke
- Wikipedia, Simpson's paradox | https://en.wikipedia.org/wiki/Simpson%27s_paradox
:::
