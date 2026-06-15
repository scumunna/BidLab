---
id: analytics-05
track: analytics
module: 5
title: Sampling and uncertainty
summary: Why a measured rate is an estimate, how standard error shrinks with sample size, and how to put an honest interval around a number.
---
# Every rate is an estimate

A conversion rate computed from one week is a sample, not a truth. Run the same campaign again and you would get a slightly different number, because the users, the auctions, and the moment all differ. The job is to report not just the estimate but how much it would wobble if you reran the world.

Model a binary outcome (converted or not) as Bernoulli trials with unknown rate p. Your observed rate p-hat is the sample mean of those trials. It is unbiased, meaning across many repetitions it centers on the true p, but any single estimate carries sampling noise that you must quantify.

:::quiz
question: You compute a 2.0% conversion rate from one week of a campaign. In what sense is that number an estimate rather than a fact?
- It is one draw from a noisy process; rerun the week and you would get a slightly different rate
- It is exact, because you counted every conversion that week
- It is wrong, because conversion rates cannot be measured directly
- It becomes a fact only after rounding to one decimal place
hint: The users, auctions, and timing of any single week are themselves a sample of all the ways the week could have gone.
answer: 0
explain: The observed rate is the sample mean of Bernoulli trials. It is unbiased but carries sampling noise, so a single week's number is an estimate of the true rate, not the truth itself, which is why you quantify how much it would wobble on a rerun.
:::

# Standard error shrinks with the square root of n

The standard error is the standard deviation of your estimate across hypothetical repeats. For a proportion it has a clean closed form, and it falls as the sample grows. This is the central fact of measurement: more data buys precision, but at a decreasing rate.

$$ SE = \sqrt{p(1-p)/n} $$

The square root is the catch. To halve your standard error you need four times the sample, not twice. A rate measured on 1,000 impressions is roughly three times noisier than one measured on 10,000, so small slices of a campaign carry error bars far wider than people expect.

:::callout key
Precision scales with the square root of sample size. Quadrupling the data only halves the standard error, which is why cutting reports into tiny segments produces numbers too noisy to act on.
:::

:::predict
prompt: A conversion rate of p = 0.02 is measured on n = 10,000 impressions. What is the standard error of that rate, as a percent?
answer: 0.14
unit: %
tolerance: 0.01
hint: SE = sqrt( p(1-p) / n ). Compute it as a proportion, then multiply by 100 to express it as a percent.
explain: SE = sqrt(0.02 x 0.98 / 10,000) = sqrt(0.00000196) = 0.0014, or 0.14%. So a 2.0% rate on 10,000 impressions carries a standard error of about 0.14 points, the building block of its confidence interval.
:::

# Confidence intervals make the noise visible

A confidence interval turns the standard error into a range. A 95% interval is the estimate plus or minus about 1.96 standard errors, and "95% confidence" means the procedure traps the true value 95% of the time across repeated samples. It does not mean a 95% probability that this particular interval contains the truth, a subtlety worth keeping straight.

$$ p \pm 1.96 \cdot SE $$

The practical use is comparison. If campaign A is at 2.0% with an interval of 1.6% to 2.4%, and campaign B is at 2.2% with an interval of 1.8% to 2.6%, the intervals overlap heavily and the difference is well within noise. Report intervals, not bare point estimates, and most "wins" reveal themselves as noise.

:::callout warning
Two point estimates that differ are not different until their uncertainty says so. A 2.0% versus 2.2% gap on small samples is usually noise wearing the costume of a result.
:::

:::widget distributionExplorer
:::

:::quiz
question: You measured a 3% click rate on 1,000 impressions and want to halve the width of your confidence interval. Roughly how much more data do you need?
- About four times the sample (4,000 total)
- About twice the sample (2,000 total)
- The same sample, measured twice
- About ten times the sample
answer: 0
explain: Standard error scales with 1 over the square root of n, so halving it requires roughly quadrupling the sample size.
:::

:::sources
- Wasserman, All of Statistics | https://www.stat.cmu.edu/~larry/all-of-statistics/
- NIST/SEMATECH e-Handbook of Statistical Methods | https://www.itl.nist.gov/div898/handbook/
:::
