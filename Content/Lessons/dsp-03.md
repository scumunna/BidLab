---
id: dsp-03
track: dsp
module: 3
title: Win-rate curves and bid landscapes
summary: Model the probability of winning as a function of your bid using the bid landscape and log-normal clearing prices.
---
# Winning is a probability

You never know in advance whether a given bid will win. You face a hidden competing bid, the highest other price (inclusive of the floor), and you only learn it when you win and sometimes not even then. So the right way to think is probabilistic: for any bid you place, there is a chance you win.

The win-rate curve is the function that maps your bid to that chance. Call it P(win | b). It starts near zero for tiny bids, rises as you bid more, and approaches one as your bid grows large enough to beat almost everyone. The shape of this curve is the core object a trader needs to understand.

:::widget lineChart
title: Win rate versus bid (typical S-shaped curve)
unit: %
labels: $0.50, $1.00, $1.50, $2.00, $2.50, $3.00, $3.50, $4.00
data: 4, 14, 35, 60, 80, 91, 96, 99
:::

# The bid landscape

The bid landscape is the distribution of clearing prices for a slice of inventory. The clearing price is the lowest amount you would have needed to win that auction. If you knew the full distribution of clearing prices, you would know your win rate at every bid, because winning at bid b just means the clearing price came in at or below b.

That is the key identity. The win-rate curve is the cumulative distribution function of the clearing price. Estimate the price distribution and the win curve follows directly.

$$ P_{win}(b) = \Pr(price \le b) $$

:::callout insight
The win-rate curve and the clearing-price distribution are the same object viewed two ways. The win curve is the running total (the CDF) of the price distribution.
:::

:::widget distributionExplorer
distribution: lognormal
:::

# Why log-normal

Clearing prices are strictly positive and skewed. Most auctions clear cheap, a few clear expensive, and the right tail is long. A log-normal distribution fits this well: the logarithm of the price is roughly normal, which keeps prices positive and produces that long high-price tail.

Modeling prices as log-normal gives a smooth, well-behaved win curve you can differentiate and optimize against. Production bid-landscape forecasters often start from this assumption, then add features (domain, format, time of day) so each request gets its own curve rather than one global average.

:::widget bidPlayground
marketMean: 0.5
value: 1.0
:::

# Reading the curve as a trader

Slide your bid along the landscape and the win rate responds. In the cheap part of the distribution a small bid increase buys a lot of extra wins. Past the bulk of the mass, paying more buys very few additional wins, you are just overpaying on auctions you already would have won.

That diminishing return is why bidding is an optimization, not a race to the top. Knowing the curve tells you where each extra cent of bid actually converts into incremental wins.

:::quiz
question: If clearing prices for a slice of inventory follow a known distribution, what does the win-rate curve P(win | b) equal?
- The probability density of that distribution at b
- The cumulative distribution function evaluated at b
- The mean clearing price divided by b
- One minus the floor price
answer: 1
explain: Winning at bid b means the clearing price was at or below b, which is exactly the CDF of the clearing-price distribution evaluated at b.
:::

:::sources
- Scalable Bid Landscape Forecasting in Real-time Bidding, Ghosh et al. | https://arxiv.org/abs/2001.06587
- Bid Shading by Win-Rate Estimation and Surplus Maximization, Pan et al. | https://arxiv.org/pdf/2009.09259
:::
