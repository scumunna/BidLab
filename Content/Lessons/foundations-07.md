---
id: foundations-07
track: foundations
module: 7
title: Working with data
summary: Tell counts apart from rates, combine rates with weighted averages, and read a results table the way an analyst does.
---
# Counts and rates in a results table

Almost every advertising report is a table. Rows are the things you are comparing, like campaigns or days or audiences, and columns are the numbers, like impressions, clicks, spend, and CTR. The first skill is telling two kinds of column apart. A count is a raw total you can add up, like 200,000 impressions or 600 clicks. A rate is a ratio of two counts, like CTR, and you cannot simply add rates across rows.

The reason matters. If campaign one has a 1% CTR and campaign two has a 3% CTR, the combined CTR is not 4% and it is usually not 2% either. To get the true combined rate you go back to the underlying counts, add the clicks, add the impressions, and divide. Rates are derived; counts are the ground truth, so when in doubt, return to the counts.

:::predict
prompt: Campaign one has 2,000 clicks on 200,000 impressions and campaign two has 1,000 clicks on 50,000 impressions. Recomputing from counts, what is the combined CTR?
answer: 1.2
unit: %
tolerance: 0.01
hint: Add the clicks, add the impressions, then divide. Never add the two rates.
explain: Combined CTR = (2,000 + 1,000) / (200,000 + 50,000) = 3,000 / 250,000 = 1.2%. Returning to the counts is the only honest way to blend rates.
:::

:::callout warning
Never add or average rates as if they were counts. Two campaigns at 1% and 3% CTR do not combine to 4% or to a flat 2%. Recompute the rate from summed clicks and summed impressions, because the larger campaign should pull the combined rate toward itself.
:::

# Weighted averages

When you do want to combine rates correctly, you use a weighted average, which weights each rate by the size of the group it came from. The bigger the group, the more it counts. This is exactly what recomputing from counts does, just written as a formula, and it is the everyday tool for blending CTRs, CVRs, or CPAs across campaigns of different sizes.

$$ \bar{r} = \Sigma (n_i \times r_i) / \Sigma n_i $$

Here each r is a group's rate, each n is that group's size, the symbol sigma means add across all groups, and r-bar is the blended rate. Suppose campaign one has 100,000 impressions at 1% CTR and campaign two has 300,000 at 3%. The weighted CTR is (100,000 times 0.01 + 300,000 times 0.03) / 400,000 = (1,000 + 9,000) / 400,000 = 2.5%. The larger campaign pulls the average toward its 3%, exactly as it should.

:::predict
prompt: Campaign one has 50,000 impressions at a 2% CTR and campaign two has 150,000 impressions at a 6% CTR. What is the weighted (blended) CTR?
answer: 5
unit: %
tolerance: 0.01
hint: Weight each rate by its impressions, sum, and divide by total impressions.
explain: Blended CTR = (50,000 x 0.02 + 150,000 x 0.06) / 200,000 = (1,000 + 9,000) / 200,000 = 5%. The larger campaign carries three-quarters of the weight, so the blend sits much closer to its 6% than to a naive 4% midpoint.
:::

:::callout key
A weighted average is what you get when you go back to the counts. Weighting each rate by its group size gives the same answer as summing the numerators, summing the denominators, and dividing. It is the only honest way to blend rates.
:::

# Reading the table critically

A good analyst reads a table with two questions. First, is each column a count or a rate, so I know what I am allowed to add. Second, how large is each row, because a flashy rate on a tiny number of impressions is noise, not signal. A 10% CTR on 50 impressions is five clicks and could vanish tomorrow, while a 2% CTR on 5 million impressions is a solid, trustworthy fact.

Sorting, filtering, and grouping a results table is the daily work of optimization. You group rows to see patterns, you sort by a rate to find winners, and you always glance at the count beside the rate to check that the pattern is real. The math is simple. The discipline of always pairing a rate with its sample size is what separates a useful read from a misleading one.

:::predict
prompt: A row shows a flashy 10% CTR but only 50 impressions. How many clicks does that rate actually represent?
answer: 5
unit: clicks
hint: Clicks are the CTR times the number of impressions.
explain: Clicks = 0.10 x 50 = 5. A rate that impressive resting on just five clicks is noise that could vanish tomorrow, which is why you always read the count beside the rate.
:::

# Try it

Write a query against an impressions-and-clicks table to compute a blended rate, then group by campaign and compare. Notice how grouping and summing the counts before dividing gives the weighted average for free.

:::widget sqlLab
:::

:::quiz
question: Campaign A has 100,000 impressions at 1% CTR and campaign B has 300,000 impressions at 3% CTR. What is the combined CTR?
- 2.5%
- 2%
- 4%
- 3%
answer: 0
explain: Recompute from counts. Clicks are 1,000 plus 9,000 = 10,000, impressions are 400,000, so combined CTR is 10,000 / 400,000 = 2.5%. The bigger campaign pulls the blend toward its 3%.
:::

:::sources
- ThoughtSpot SQL tutorial, aggregate functions | https://www.thoughtspot.com/sql-tutorial/sql-aggregate-functions
- Khan Academy, weighted averages | https://www.khanacademy.org/math/statistics-probability/summarizing-quantitative-data
:::
