---
id: foundations-12
track: foundations
module: 12
title: Indices, Normalization, and Z-Scores
summary: Rebase a series to 100, turn an audience skew into an index, standardize a metric into a z-score, and compare numbers that started on completely different scales.
---
# The index, a number rebased to 100

Raw numbers are hard to compare when they live on different scales, so analysts rebase them. An index expresses a value relative to a reference, scaled so the reference equals 100. The most common form in media is the audience index: take the share of your target audience that has some trait, divide by the share of the general population with that trait, and multiply by 100.

$$ \text{index} = \frac{\text{target rate}}{\text{base rate}} \times 100 $$

An index of 100 means your audience matches the population exactly. Above 100 means the trait is over-represented in your audience, below 100 means under-represented. An index of 150 reads as "50 percent more likely than average," and an index of 75 reads as "25 percent less likely than average." That single normalized number lets you rank traits, placements, or segments that began on totally different raw scales.

:::predict
prompt: 18 percent of your target audience streams CTV daily, versus 12 percent of the general population. What is the index?
answer: 150
tolerance: 1
unit:
hint: Target rate divided by base rate, times 100.
explain: Index = (18 / 12) times 100 = 1.5 times 100 = 150. Your audience is 50 percent more likely than the general population to stream CTV daily, a strong over-index worth leaning into when you choose channels.
:::

# Rebasing a time series

The same trick tidies a time series. Pick a base period, set it to 100, and express every other period as a percentage of that base. Now a messy run of raw numbers becomes a clean growth story you can read at a glance, and two series that started miles apart become directly comparable because both begin at 100.

$$ \text{rebased value} = \frac{\text{period value}}{\text{base period value}} \times 100 $$

Suppose weekly conversions ran 104, then 130, then 156, and you rebase to the first week. Week one becomes 100 by definition. Week two is $\frac{130}{104} \times 100 = 125$, a 25 percent lift. Week three is $\frac{156}{104} \times 100 = 150$, half again above the base. The index strips out the awkward starting magnitude and leaves pure relative change, which is exactly what you want when you compare a tiny campaign to a giant one.

:::predict
prompt: Weekly conversions are 104 in the base week and 130 the next week. Rebasing the base week to 100, what is the index for the second week?
answer: 125
tolerance: 0.5
unit:
hint: Divide the period value by the base value, then multiply by 100.
explain: Rebased value = (130 / 104) times 100 = 1.25 times 100 = 125. The second week sits 25 percent above the base, and because the base is pinned at 100, that lift is readable instantly without knowing the raw counts.
:::

# Normalization, putting metrics on one ruler

Indexing is one flavor of a bigger idea called normalization: rescaling values so different metrics share a comparable range. You normalize whenever raw magnitudes would otherwise dominate. A CPA in dollars, a CTR in fractions of a percent, and a viewability score from 0 to 100 cannot be compared or combined as they stand, because the dollar figures are simply bigger numbers and would swamp everything else in any blend.

One common scheme is min-max normalization, which squeezes every value into a 0 to 1 range:

$$ x_{\text{norm}} = \frac{x - x_{\min}}{x_{\max} - x_{\min}} $$

The lowest value maps to 0, the highest to 1, and everything else lands proportionally between. That is handy for dashboards and composite scores, but it has a weakness: a single outlier stretches the whole range and crushes the rest of the data into a narrow band. When you care about how unusual a value is rather than just where it falls in a range, you reach for a better ruler, the z-score.

:::quiz
question: Why can you not directly average a CPA of 22 dollars, a CTR of 2 percent, and a viewability of 80 into one quality score?
- Because they are all rates
- Because they live on different scales, so the large raw numbers would dominate the blend
- Because averaging is never allowed in analytics
- Because CPA should always be the only metric that matters
answer: 1
hint: Think about which number is biggest in raw terms before any rescaling.
explain: The metrics sit on wildly different scales, so the 22 and the 80 would swamp the 0.02 in any raw average, producing a meaningless number. You must normalize each metric onto a shared ruler, with an index or a z-score, before you can fairly combine them.
:::

# The z-score, measuring in standard deviations

The z-score standardizes a value by asking how many standard deviations it sits above or below the mean of its distribution. It is the most powerful normalizer because it folds in both the center and the spread of the data.

$$ z = \frac{x - \mu}{\sigma} $$

Here $x$ is the raw value, $\mu$ (mu) is the mean, and $\sigma$ (sigma) is the standard deviation. A z of 0 sits right at the mean. A z of $+1$ is one standard deviation above, $-1$ is one below. The sign tells direction, the magnitude tells how extreme. Because the units cancel, a z-score is pure and dimensionless, which is precisely what lets you compare a CTR against a CPA against a completely unrelated metric.

Say your campaign posts a 3.2 percent CTR against a benchmark mean of 2.0 percent with a standard deviation of 0.5 percent. Then $z = \frac{3.2 - 2.0}{0.5} = \frac{1.2}{0.5} = 2.4$. Your CTR is 2.4 standard deviations above the benchmark, a genuinely strong result, not just nominally higher.

:::predict
prompt: Your CTR is 3.2 percent. The benchmark mean is 2.0 percent and the standard deviation is 0.5 percent. What is the z-score?
answer: 2.4
tolerance: 0.05
unit:
hint: Subtract the mean, then divide by the standard deviation.
explain: z = (3.2 - 2.0) / 0.5 = 1.2 / 0.5 = 2.4. Your CTR sits 2.4 standard deviations above the benchmark mean, which is far enough out to call the result clearly above average rather than ordinary noise.
:::

# Percentiles and comparing across scales

A z-score becomes even more useful once you map it to a percentile rank, the share of the distribution that falls below your value. For a bell-shaped (normal) distribution that mapping is fixed: a z of 0 is the 50th percentile, $+1$ is about the 84th, $+2$ is about the 98th, and $-1$ is about the 16th. So your CTR z of 2.4 lands above roughly 99 percent of comparable campaigns, a far more concrete statement than "above average."

The standardized scale is what finally lets you compare unlike things. Imagine a video line with a CTR z of $+2.0$ and a display line with a CPA z of $-1.0$, where a negative CPA z is good because cheaper is better. Both have beaten their own benchmarks, but the video line is the bigger outlier at two standard deviations versus one. You could never see that from the raw 0.9 percent CTR and 18 dollar CPA, because they share no scale at all. Standardizing is exactly why benchmarks get reported as z-scores or percentiles: it is the only honest way to say which result is more exceptional when the metrics started in different worlds.

:::quiz
question: A video line has a CTR z-score of +2.0 and a display line has a CPA z-score of -1.0 (lower CPA is better, so a negative z is good). Which line is the more exceptional performer relative to its own benchmark?
- The display line, because a negative number is always better
- The video line, because it is 2 standard deviations from its benchmark versus 1 for display
- They are exactly equal once standardized
- You cannot compare them because the raw metrics differ
answer: 1
hint: Standardizing already removed the units. Compare the magnitudes of the z-scores.
explain: Both lines beat their benchmarks, but magnitude measures how exceptional. The video line is 2.0 standard deviations out while the display line is 1.0 out, so video is the bigger outlier. The whole point of the z-score is that it lets you make this comparison even though CTR and CPA share no raw scale.
:::

:::callout key
Index when you want a ratio against a reference, rebased to 100. Standardize with a z-score when you want to know how unusual a value is, measured in standard deviations, so you can compare metrics that started on different scales and rank them by how exceptional they truly are.
:::

:::sources
- DataCamp, Z-Score, the complete guide to statistical standardization | https://www.datacamp.com/tutorial/z-score
- Comscore, What is my comp index | https://www.comscore.com/Insights/Blog/What-s-My-Comp-Index
- The Audience Agency, An introduction to indexes | https://www.theaudienceagency.org/resources/guide-introduction-to-indexes
- GWI Help Center, Understanding index scores | https://help.globalwebindex.com/en/articles/5880946-understanding-index-scores
- Maricopa Open, z-scores and the standard normal distribution | https://open.maricopa.edu/psy230mm/chapter/chapter-6-z-scores/
- QuestDB, Z-score normalization | https://questdb.com/glossary/z-score-normalization/
- Billups, How indexing enhances your OOH targeting | https://www.billups.com/articles/how-indexing-enhances-your-ooh-targeting
:::
