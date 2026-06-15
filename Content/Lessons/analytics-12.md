---
id: analytics-12
track: analytics
module: 12
title: Predictive modeling
summary: How regression and logistic regression predict outcomes like clicks, and how AUC, log-loss, and calibration tell you whether to trust them.
---
# Predicting the next click

Programmatic bidding runs on predictions. Before each auction the bidder estimates the probability a user clicks (CTR) or converts (CVR), then bids in proportion to that value. Linear regression predicts a continuous outcome; logistic regression predicts a probability between 0 and 1, which is what binary events like clicks require.

Logistic regression passes a weighted sum of features through the logistic function `p = 1 / (1 + e^{-z})`, where z is the linear score, squashing any real number into a valid probability. The weights are learned by maximizing the likelihood of the observed clicks and non-clicks.

:::quiz
question: Why predict click probability with logistic regression rather than plain linear regression?
- The logistic function bounds the output to a valid 0-to-1 probability; linear regression can return values below 0 or above 1
- Logistic regression always has higher accuracy
- Linear regression cannot use multiple features
- Clicks are continuous outcomes, so logistic fits better
hint: A probability must live between 0 and 1. Which model guarantees that?
answer: 0
explain: A click is a binary event whose predicted value must be a probability in [0, 1]. The logistic function squashes the linear score into that range, while a raw linear fit can produce impossible probabilities below 0 or above 1.
:::

# Ranking versus calibration

Two different things matter for a bidding model, and they are not the same. Ranking is whether the model orders impressions correctly, putting likely clicks above unlikely ones. Calibration is whether the predicted probabilities match reality: among impressions predicted at 2% CTR, about 2% should actually click.

AUC, the area under the ROC curve, measures ranking. It is the probability that a random positive scores higher than a random negative, with 0.5 meaning random and 1.0 perfect. Log-loss penalizes confident wrong probabilities and rewards calibration, so it is the metric to watch when the predicted value feeds a bid price.

$$ LogLoss = -\frac{1}{N} \sum [y \log p + (1-y) \log(1-p)] $$

:::callout key
A model can have high AUC and still bid badly. AUC only cares about order. If predicted CTRs are systematically double the truth, AUC is unchanged but you overbid on every impression. Calibration is what protects the budget.
:::

:::predict
prompt: AUC is the probability a random clicker is scored higher than a random non-clicker. Over 1,000 random clicker-versus-non-clicker pairs, your model ranks the clicker higher in 815 of them. What AUC does that imply?
answer: 0.815
tolerance: 0.005
hint: AUC is just that win rate: the share of pairs where the positive outranks the negative. Divide the count by the number of pairs.
explain: AUC = 815 / 1,000 = 0.815. The model orders a random positive above a random negative about 82% of the time, comfortably above the 0.5 of random guessing, though this ranking quality says nothing about whether the probabilities are calibrated.
:::

# Overfitting and honest evaluation

A model overfits when it memorizes noise in the training data and fails on new impressions. The tell is a large gap between training and held-out performance. Regularization shrinks the weights to fight this, and a validation split or cross-validation gives an honest estimate of how the model generalizes.

Always evaluate on data the model never trained on, and for time-ordered ad data split by time, training on earlier weeks and testing on later ones. A random split leaks future information and flatters the model. Recalibrate periodically, because CTR drifts as creatives, audiences, and seasons change.

:::callout warning
Never report metrics from the training set as if they measure real performance. Training AUC near 1.0 with much lower validation AUC is the classic overfitting signature, not a good model.
:::

:::quiz
question: Your CTR model has excellent AUC but predicted CTRs run about twice the actual rate. What is the practical risk?
- The bidder overbids because predictions feed bid prices, even though ranking is fine
- Nothing, because high AUC guarantees good bids
- The model underbids on every impression
- AUC will fall over time on its own
answer: 0
explain: AUC measures only ranking, so it stays high under miscalibration. Since bids scale with predicted probability, systematically inflated predictions cause systematic overbidding regardless of AUC.
:::

:::sources
- Hastie, Tibshirani, Friedman, The Elements of Statistical Learning | https://hastie.su.domains/ElemStatLearn/
- McMahan et al., Ad Click Prediction: a View from the Trenches, KDD | https://research.google/pubs/pub41159/
:::
