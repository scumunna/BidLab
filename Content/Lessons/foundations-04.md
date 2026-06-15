---
id: foundations-04
track: foundations
module: 4
title: Probability and expected value
summary: Reason about events and simple probability, and use expected value as the core idea behind what an impression is worth.
---
# An event and its probability

An event is something that either happens or does not: a user clicks, a click converts, an auction is won. The probability of an event is a number between 0 and 1 that measures how likely it is, where 0 means never and 1 means certain. A probability of 0.05 means we expect the event to happen about 5 times in every 100 tries.

When events do not influence each other, the probability that both happen is the product of their probabilities. If 0.4% of impressions get clicked and 5% of clicks convert, then the chance an impression eventually converts is 0.004 times 0.05 = 0.0002, or 2 in 10,000. Chaining probabilities by multiplying is exactly how a single impression's odds of paying off get computed.

:::predict
prompt: An impression is clicked with probability 0.5% (a 0.5% CTR) and a click converts with probability 8% (an 8% CVR). What is the probability a single impression converts?
answer: 0.0004
unit: probability
tolerance: 0.00001
hint: Multiply the two independent probabilities along the chain.
explain: P(convert) = 0.005 x 0.08 = 0.0004, which is 4 in 10,000. Chaining CTR and CVR by multiplying gives the odds that one impression turns into the outcome you care about.
:::

:::callout key
Probabilities of independent events multiply along the chain. Impression to click to conversion is CTR times CVR. That product is the probability that one impression turns into the outcome you actually care about.
:::

# Expected value

Expected value is the average outcome you would get if you repeated a gamble many times. You compute it by multiplying each possible payoff by its probability and adding the results. A bet that pays 100 dollars with probability 0.02 and nothing otherwise has an expected value of 0.02 times 100 = 2 dollars, even though no single play ever pays exactly 2 dollars.

$$ E[V] = \Pr(convert) \times value $$

The power of expected value is that it collapses an uncertain future into one comparable number. You will lose most individual bets and win a few big ones, but over thousands of impressions the average is what your budget actually experiences. This is why advertisers think in expected value rather than in any one outcome.

:::predict
prompt: A bet pays 250 dollars with probability 0.03 and nothing otherwise. What is its expected value?
answer: 7.5
unit: $
tolerance: 0.01
hint: Expected value is each payoff times its probability, summed.
explain: E[V] = 0.03 x 250 + 0.97 x 0 = 7.5 dollars. No single play ever pays exactly 7.5 dollars, but that is the average outcome over many repetitions.
:::

# Expected value is the bid

Here is the whole idea programmatic buying rests on. The expected value of showing an ad to a specific user is the probability that the impression converts times the value of a conversion. If a conversion is worth 50 dollars and this impression converts with probability 0.0002, the impression is worth 0.0002 times 50 = 0.01 dollars, or a 10 dollar CPM, in expected value.

That number is the ceiling on what you should pay. Bid more than the expected value and you lose money on average. Bid less and you leave profit on the table when you win. Every smart bidding system, underneath the machinery, is estimating this expected value for each impression and pricing against it.

:::predict
prompt: A conversion is worth 60 dollars and a given impression converts with probability 0.0003. Expressed as a CPM, what is this impression worth in expected value?
answer: 18
unit: $
tolerance: 0.01
hint: First find the per-impression expected value, then multiply by 1,000 to get a CPM.
explain: Per impression = 0.0003 x 60 = 0.018 dollars. Times 1,000 that is an 18 dollar CPM, the ceiling on what you should pay before losing money on average.
:::

:::callout warning
Expected value is an average over many tries, not a promise about the next impression. A positive expected value can still lose money on a small number of bids. It only reliably wins when you place the bet many times, which is why scale and patience matter.
:::

# Try it

Set the value of a conversion and the market, then move your bid and watch expected profit rise to a peak and fall. The peak sits where your bid respects the expected value of the impression, not above it.

:::widget bidPlayground
marketMean: 0.5
value: 1.0
:::

:::quiz
question: A conversion is worth 40 dollars and a given impression converts with probability 0.001. In expected value, what is that impression worth?
- 4 cents
- 40 cents
- 4 dollars
- 0.4 cents
answer: 0
explain: Expected value is probability times payoff, 0.001 times 40 = 0.04 dollars, which is 4 cents. That is the most you should pay for the impression on average before losing money.
:::

:::sources
- Khan Academy, expected value | https://www.khanacademy.org/math/statistics-probability/random-variables-stats-library
- IAB Tech Lab, OpenRTB specification | https://iabtechlab.com/standards/openrtb/
:::
