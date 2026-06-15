---
id: dsp-05
track: dsp
module: 5
title: pCTR and pCVR prediction
summary: Predict click and conversion probabilities with logistic regression, and judge the models with calibration and log-loss.
---
# Predicting a probability

Impression valuation needs two numbers, pCTR and pCVR. Both are probabilities, so the model that produces them must output a value between 0 and 1. You feed it features from the bid request (domain, format, device, user signals, time of day) and it returns the chance of a click or a conversion.

The workhorse model for this is logistic regression. It is fast enough to score millions of requests per second, it is easy to update, and its output is a genuine probability rather than an arbitrary score. Even where deep models now lead, logistic regression remains the baseline everyone measures against.

:::widget barChart
title: Typical click-through rate by format (illustrative)
unit: %
labels: Standard display, Rich media, Native, Mobile interstitial, Video
data: 0.08, 0.12, 0.20, 0.55, 1.80
:::

# Logistic regression intuition

Logistic regression assigns a weight to each feature and adds up a weighted score. That score can be any real number, so it passes the score through the logistic (sigmoid) function, which squashes it into the 0 to 1 range. Large positive scores map near 1, large negative scores map near 0, and a score of 0 maps to one half.

$$ p = 1 / (1 + e^{-(\beta_0 + \beta_1 x_1 + \cdots)}) $$

The weights are learned from history. Features that tend to precede clicks get positive weights, features that suppress clicks get negative weights, and the model finds the combination that best matches what actually happened.

:::callout insight
The sigmoid is what turns an unbounded weighted score into a probability. It is the bridge between linear feature math and the 0 to 1 number that valuation needs.
:::

:::predict
prompt: A logistic model produces a weighted score of exactly 0 for an impression. After the sigmoid, what predicted probability does it output?
answer: 0.5
unit:
tolerance: 0.001
hint: Substitute the score into p = 1 / (1 + e^{-score}). Recall that e to the power 0 equals 1.
explain: p = 1 / (1 + e^0) = 1 / (1 + 1) = 0.5. A score of 0 sits exactly on the fence, so the sigmoid maps it to one half.
:::

# Calibration matters more than ranking

For bidding, the probability must be correct in level, not just in order. If your model says a group of impressions has a 1 percent click rate, that group had better click about 1 percent of the time. That property is calibration: predicted probabilities match observed frequencies.

Calibration is what separates CTR prediction from ordinary classification. A search-ranking model only needs to order items correctly. A bidding model multiplies its probability by real dollars, so a model that is double the true rate will systematically overbid. You check calibration by comparing the sum of predictions to the sum of actual outcomes across a slice, which should be close to 1.

:::callout warning
A well-ranked but poorly calibrated model will misprice every bid. If predicted click rates are systematically high or low, expected value is wrong and so is every bid built on it.
:::

:::predict
prompt: Across a slice of inventory the model's predicted click probabilities sum to 1000 clicks, but only 800 clicks actually happened. What is the calibration ratio of predicted to actual?
answer: 1.25
unit: x
tolerance: 0.01
hint: Calibration compares the sum of predictions to the sum of outcomes. A ratio above 1 means the model overpredicts.
explain: Calibration ratio = predicted / actual = 1000 / 800 = 1.25. The model overpredicts clicks by 25 percent, so every bid built on it is about 25 percent too high.
:::

# Scoring with log-loss

To train and compare these models you need a loss that rewards calibrated probabilities. Log-loss (logarithmic loss, also called cross-entropy) does exactly that. It penalizes confident wrong predictions heavily and rewards probabilities that match the truth, so minimizing it pushes the model toward both accuracy and calibration. Log-loss is the standard metric on benchmark datasets like the Criteo display advertising challenge.

:::widget codeLab
:::

:::quiz
question: Why is calibration especially important for a pCTR model used in bidding, beyond just ranking impressions correctly?
- The auction only accepts probabilities, not scores
- The predicted probability is multiplied by real money, so a biased level causes systematic over or under bidding
- Logistic regression cannot rank, only calibrate
- Calibration makes the model train faster
answer: 1
explain: Bidding multiplies the predicted probability by conversion value to get expected value. If the level is biased, every bid built on it is mispriced, regardless of how well impressions are ranked.
:::

:::sources
- Practical Lessons from Predicting Clicks on Ads at Facebook, He et al. | https://research.facebook.com/publications/practical-lessons-from-predicting-clicks-on-ads-at-facebook/
- Display Advertising Challenge, Criteo and Kaggle | https://www.kaggle.com/c/criteo-display-ad-challenge
:::
