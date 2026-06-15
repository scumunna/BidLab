---
id: foundations-05
track: foundations
module: 5
title: Distributions and uncertainty
summary: Read a normal curve through its mean and spread, and understand why a single average can hide the tails that drive results.
---
# A distribution is the shape of the data

A single number like an average tells you where data sits, but not how it is spread out. A distribution shows the whole picture: which values are common, which are rare, and how widely the values scatter. Picture the cost you pay to win impressions across a day. Most wins cluster around a typical price, a few are very cheap, and a few are very expensive. That spread of outcomes is a distribution.

The most famous distribution is the normal curve, the symmetric bell shape. Many quantities that result from lots of small independent effects pile up into roughly this shape. It is common enough that recognizing it, and knowing it has a center and a width, gives you a fast mental model for a great deal of advertising data.

:::widget barChart
title: Winning prices across a day pile up into a bell (illustrative)
labels: $3, $4, $5, $6, $7, $8, $9
data: 4, 14, 27, 34, 27, 14, 4
unit: %
:::

# Mean and spread

Two numbers summarize a normal curve. The mean, written with the Greek letter mu, is the center, the balance point of the bell. The standard deviation, written sigma, is the spread, how wide the bell is. A small sigma makes a tall narrow bell where values stay close to the mean, and a large sigma makes a short wide bell where values scatter far.

$$ \mu \pm \sigma $$

For a normal curve, about 68% of values fall within one sigma of the mean, and about 95% fall within two sigma. So if winning prices average 6 dollars with a sigma of 1 dollar, roughly two-thirds of your wins cost between 5 and 7 dollars, and about 95% cost between 4 and 8. The mean tells you where, and sigma tells you how confidently you can plan around that where.

:::predict
prompt: Winning prices are normal with a mean of 6 dollars and a sigma of 1.50 dollars. The two-sigma band (about 95% of wins) runs from what lower bound to what upper bound? Enter the upper bound.
answer: 9
unit: $
tolerance: 0.01
hint: Two sigma above the mean is the mean plus two times the standard deviation.
explain: Upper bound = 6 + 2 x 1.50 = 9 dollars (the lower bound is 6 - 3 = 3 dollars). About 95% of winning prices fall in the 3 to 9 dollar band, two sigma on each side of the mean.
:::

:::callout key
The mean says where the data centers. The standard deviation says how far it typically strays. You need both. A mean without a spread is half a description, and it is the missing half that usually surprises you.
:::

# Why averages hide tails

The tails are the far ends of the distribution, the rare large values. Averages are blind to them because a handful of extreme outcomes barely nudge a mean computed over thousands of points. Yet those rare events often dominate what actually happens: a few very high converting users, a few enormous winning bids, a few moments of runaway spend.

In advertising this matters constantly. Average CPA can look healthy while a long tail of expensive conversions quietly eats the budget. Average latency can be fine while a thin tail of slow responses loses real auctions. When the tail carries the risk or the value, planning to the average alone will mislead you. Look at the spread and the extremes, not just the center.

:::predict
prompt: Out of 100 conversions, 95 cost 20 dollars each and 5 tail conversions cost 400 dollars each. What is the average CPA across all 100?
answer: 39
unit: $
tolerance: 0.01
hint: Add the total cost of both groups, then divide by the total number of conversions.
explain: Total cost = 95 x 20 + 5 x 400 = 1,900 + 2,000 = 3,900 dollars over 100 conversions, so the average CPA is 39 dollars. Five tail conversions nearly doubled an average that 95% of the data said was 20, exactly how fat tails hide inside a mean.
:::

:::callout warning
Two campaigns can share an identical average and behave nothing alike. The one with the fatter tails has more very good and very bad outcomes hiding inside the same mean. Never judge performance on the average without also checking the spread.
:::

# Try it

Adjust the mean and the spread and watch the bell move and stretch. Notice how growing the spread fattens the tails while the center holds, and how much of the action lives away from the middle.

:::widget distributionExplorer
:::

:::quiz
question: Winning prices are normally distributed with a mean of 5 dollars and a standard deviation of 1 dollar. About what share of wins cost between 4 and 6 dollars?
- About 68%
- About 95%
- About 50%
- About 99%
answer: 0
explain: The range from 4 to 6 dollars is one standard deviation on each side of the mean. For a normal curve, about 68% of values fall within one standard deviation of the mean.
:::

:::sources
- Khan Academy, normal distributions and the empirical rule | https://www.khanacademy.org/math/statistics-probability/modeling-distributions-of-data
- NIST/SEMATECH e-Handbook of Statistical Methods, normal distribution | https://www.itl.nist.gov/div898/handbook/eda/section3/eda3661.htm
:::
