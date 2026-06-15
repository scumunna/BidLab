---
id: dsp-04
track: dsp
module: 4
title: Impression valuation
summary: Price an impression by chaining click probability, conversion probability, and the value of a conversion into an expected value.
---
# What is an impression worth

An impression has no fixed price tag. It is worth whatever outcome it is likely to produce for the advertiser. A view that almost never leads to a sale is worth little. A view from a high-intent user who often converts is worth a lot. Valuation is the act of turning those odds into a number you can bid.

The advertiser usually cares about a downstream action: a click, then a conversion (a purchase, signup, or install). So you value the impression by the expected revenue it generates, working backward from the value of that final action.

:::predict
prompt: A conversion is worth $50 to the advertiser. Past data says a single impression leads to a sale 2 percent of the time. What is the impression worth in expected value?
answer: 1
unit: $
tolerance: 0.01
hint: Expected value discounts the conversion value by the probability the conversion actually happens.
explain: Expected value = probability x conversion value = 0.02 x $50 = $1.00. You bid against the expected outcome, not the full $50, because the sale only happens 2 percent of the time.
:::

# The chain of probabilities

Two things must happen for a display impression to pay off. The user must click, and then the user must convert. You estimate each as a probability: pCTR, the predicted click-through rate, and pCVR, the predicted conversion rate given a click. Multiply them by the value of a conversion and you have the expected value of the impression.

$$ value = pCTR \times pCVR \times V_{conv} $$

This is the impression's worth to the advertiser, expressed per impression. Multiply by 1000 and you have the expected revenue per thousand impressions, which is directly comparable to the CPM prices you bid into auctions.

:::callout key
Expected value bidding values an impression as pCTR times pCVR times the value of a conversion. Each term is a number your models or your advertiser supply, and the product is what the impression is worth before you decide how much margin to keep.
:::

:::predict
prompt: An impression has a pCTR of 0.5 percent and a pCVR of 3 percent, and the advertiser values a conversion at $80. What is the expected value of the impression?
answer: 0.012
unit: $
tolerance: 0.001
hint: Chain the two probabilities, then multiply by the conversion value: pCTR x pCVR x conversion value.
explain: Value = 0.005 x 0.03 x $80 = $0.012 per impression. Multiplied by 1000 that is a $12 expected CPM, the ceiling you would bid into the auction before keeping any margin.
:::

# Expected value, not best case

Notice that you do not bid the full value of a conversion. You bid the expected value, which discounts that conversion by how unlikely it is. A 200 dollar conversion behind a 0.1 percent click rate and a 5 percent post-click conversion rate is worth 200 times 0.001 times 0.05, which is 1 cent per impression, not 200 dollars.

This is why two impressions for the same advertiser can be worth a hundred-fold different amounts. The conversion value is fixed, but the probabilities in front of it vary enormously by user, context, and placement.

:::widget pricingCalculator
:::

# From value to bid

Valuation gives you the ceiling, the most an impression is worth. It is not yet your bid. In a first-price auction you bid below this value to keep surplus, a topic we cover under bid shading. For now, hold the distinction clearly: valuation answers what is it worth, bidding answers what should I pay.

:::callout insight
Valuation and bidding are separate steps. First estimate the impression's expected value, then decide how much of that value to give up in the auction. Confusing the two leads to overbidding.
:::

:::quiz
question: An advertiser values a conversion at 100 dollars. For an impression with pCTR of 0.2 percent and pCVR of 4 percent, what is the expected value of the impression?
- 100 dollars
- 0.8 dollars
- 0.008 dollars
- 4 dollars
answer: 2
explain: Expected value is 100 times 0.002 times 0.04, which equals 0.008 dollars per impression. You discount the conversion value by both probabilities.
:::

:::sources
- Profit Maximization for Online Advertising Demand-Side Platforms, Grigas et al. | https://arxiv.org/pdf/1706.01614
- Real-Time Bidding by Reinforcement Learning in Display Advertising, Cai et al. | https://arxiv.org/pdf/1701.02490
:::
