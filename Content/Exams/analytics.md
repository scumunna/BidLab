---
track: analytics
title: Analytics / Data Science Certification
pass: 0.7
draw: 12
---
:::q Experiment Design
question: You want your A/B test to detect a smaller lift than the one your last test was sized for. What happens to the sample size you need per arm?
- It shrinks proportionally
- It grows, roughly with the inverse square of the effect size
- It stays the same
- It grows linearly with the effect size
answer: 1
explain: Required sample scales with 1 over the minimum detectable effect squared, so halving the effect you want to catch roughly quadruples the sample. Tiny lifts are expensive to prove.
:::

:::q Experiment Design
question: A flat, non-significant result comes back from a test that was badly underpowered. What does it tell you?
- That the treatment definitely had no effect
- That the treatment definitely had an effect
- Little, because the test may have been too small to see a real effect
- That the baseline conversion rate was wrong
answer: 2
explain: A non-significant result from an underpowered test is not evidence of no effect, it is evidence you could not see one. Power must be designed in before the test runs.
:::

:::q Experiment Design
question: A team runs 20 independent A/B comparisons at a 5% significance level with no effects truly present. About how many false positives should they expect by chance?
- About 0
- About 5
- About 1
- About 10
answer: 2
explain: At a 5 percent significance level each independent test has a 5 percent false-positive chance, so 20 times 0.05 equals about 1 expected false positive. Testing many hypotheses at once inflates the chance of a spurious win, which is why multiple comparisons need correction.
:::

:::q Causal & Incrementality
question: Exposed users convert at 5% and unexposed users at 2%, but exposure was assigned by a targeting model. What can you conclude about the ad's causal lift?
- The ad caused a 3 point absolute lift
- The ad more than doubled the conversion rate
- The ad caused a 150% relative lift
- Little, because targeting confounds exposure with conversion intent
answer: 3
explain: The targeting model selected high-intent users into exposure, so the gap reflects selection bias, not a measured causal effect. Only a randomized control group turns the observed difference into a defensible causal claim.
:::

:::q Causal & Incrementality
question: A test region's sales rise 14% while a comparable control region's sales rise 6% over the same window. What is the difference-in-differences estimate of campaign lift?
- 14 percentage points
- 8 percentage points
- 20 percentage points
- 2.3 times
answer: 1
explain: Difference-in-differences subtracts the control change from the test change, 14 percent minus 6 percent equals 8 points, which removes shared trends like seasonality. It rests on the parallel-trends assumption that the regions would have moved together absent the campaign.
:::

:::q Causal & Incrementality
question: Why do ghost ads improve on a naive holdout when measuring incremental lift?
- They show the ad to the control group as well
- They remove the need for any control group
- They log when control users would have won the impression, so you compare only users who would have been exposed in both arms
- They guarantee a larger measured lift
answer: 2
explain: In a plain holdout the control group never entered the auction, so you cannot tell which control users would have been served the ad. Ghost ads record the would-have-won moment, matching exposed and control on auction eligibility and removing selection bias.
:::

:::q Attribution & MMM
question: A branded-search keyword captures nearly all conversion credit under last-touch attribution. What is the most likely concern?
- Last-touch overcredits the final click and hides the upper-funnel channels that created the demand
- Branded search is proven to be the true incremental driver
- A Shapley model would assign it even more credit
- Last-touch measures incrementality correctly
answer: 0
explain: Branded search sits at the end of journeys, so last-touch over-attributes to it while ignoring the awareness channels that drove users to search. Attribution is correlational accounting and does not establish incrementality, so validate winners with a holdout.
:::

:::q Attribution & MMM
question: In a Bayesian marketing-mix model, what does the adstock transformation capture?
- That each extra dollar of spend buys less than the last
- That advertising carries over, so spend today still drives sales in later periods
- That conversion credit goes entirely to the last touch
- That the model coefficient is causal without any calibration
answer: 1
explain: Adstock models the carryover of advertising, where a flight today still contributes to sales next week. It is one of the two effects, alongside saturation for diminishing returns, that an MMM must capture and that simple last-click attribution misses.
:::

:::q Statistics & Modeling
question: Your click-through-rate model has excellent AUC, but its predicted rates run about twice the actual rate. What is the practical risk?
- Nothing, because high AUC guarantees good bids
- The model underbids on every impression
- The bidder overbids, because predictions feed bid prices even though ranking is fine
- AUC will fall over time on its own
answer: 2
explain: AUC measures only ranking, so it stays high under miscalibration. Since bids scale with predicted probability, systematically inflated predictions cause systematic overbidding. Calibration, not ranking, is what protects the budget.
:::

:::q Statistics & Modeling
question: Why is logistic regression, rather than plain linear regression, the natural model for predicting whether a click happens?
- It always produces a higher AUC than linear regression
- It cannot overfit the training data
- It predicts a continuous dollar value rather than a probability
- It passes a linear score through the logistic function to return a probability between 0 and 1
answer: 3
explain: A click is a binary event, so the prediction must be a valid probability. Logistic regression squashes the linear score through the logistic function into the range 0 to 1, while linear regression can return values outside that range.
:::

:::q Causal & Incrementality
question: A holdout finishes with the test arm at 3.0% on 8,000 users and the control arm at 2.0% on 8,000 users. The 95% confidence interval on the absolute lift runs from about 0.5 to 1.5 percentage points. What is the right read?
- The lift is not significant, because the two rates are close
- Nothing can be said until you rerun the test
- The interval includes zero, so the result is noise
- The lift is significant, because the interval on the difference excludes zero
answer: 3
explain: The absolute difference is 3.0% minus 2.0% equals 1.0 point, and the 95% interval (about 0.5 to 1.5 points) sits entirely above zero. An interval on the difference that excludes zero is the signal that the gap is unlikely to be sampling noise, so the lift is significant at that level.
:::

:::q Causal & Incrementality
question: A geo test runs difference-in-differences. The test region's sales rise 18% from before to after, while a comparable control region rises 7% over the same window. What is the difference-in-differences estimate of campaign lift?
- 25 percentage points
- 18 percentage points
- 11 percentage points
- 2.6 times
answer: 2
explain: Difference-in-differences subtracts the control change from the test change, 18% minus 7% equals 11 points, which cancels shared trends like seasonality. It rests on the parallel-trends assumption that the two regions would have moved together without the campaign.
:::

:::q Causal & Incrementality
question: A holdout measures a treatment conversion rate of 4.5% and a control conversion rate of 3.6%. Using lift equals (CVR test minus CVR control) divided by CVR control, what is the incremental lift over baseline?
- 0.9 percentage points
- 25%
- 9%
- 12.5%
answer: 1
explain: Lift equals (4.5% minus 3.6%) divided by 3.6%, which is 0.9 divided by 3.6 equals 0.25, or 25%. The campaign raised conversions 25% above the baseline that would have converted anyway, which is the incremental signal a raw conversion count hides.
:::

:::q Causal & Incrementality
question: A team compares users who clicked an ad against users who never clicked and finds clickers convert far more often. Why is this a weak basis for a causal lift claim?
- Click rates are too unreliable to compare
- The sample of clickers is always too small
- Clicking has no relationship to conversion
- Clicking is self-selected, so clickers were already higher-intent before any comparison
answer: 3
explain: Users choose whether to click, so the clicker group is self-selected toward high intent rather than randomly assigned. The conversion gap mixes that pre-existing intent with any ad effect, which is selection bias, and only a randomized holdout separates the two.
:::

:::q Experiment Design
question: You measured a 4% click rate on 2,500 impressions and want to halve the width of the confidence interval. Roughly how many impressions do you need in total?
- About 5,000
- About 7,500
- About 10,000
- About 2,500, measured twice
answer: 2
explain: Standard error scales with 1 over the square root of n, so halving it requires about four times the sample. Four times 2,500 is 10,000 impressions. Precision buys data at a decreasing rate, which is why small slices carry wide error bars.
:::

:::q Experiment Design
question: A test sized to detect a 3% minimum detectable effect needs 8,000 users per arm. Holding the baseline, significance, and power fixed, roughly how many users per arm would it need to detect a 1.5% effect instead?
- About 4,000
- About 16,000
- About 32,000
- About 8,000
answer: 2
explain: Required sample scales with 1 over the minimum detectable effect squared, so halving the effect (3% to 1.5%) multiplies the sample by four. Four times 8,000 equals 32,000 users per arm. Tiny lifts are expensive to prove.
:::

:::q Experiment Design
question: A team runs 10 independent A/B comparisons at the 5% significance level on treatments that truly have no effect. Roughly what is the chance at least one comes back significant by pure chance?
- About 5%
- About 40%
- About 10%
- About 64%
answer: 1
explain: The family-wise error is 1 minus (1 minus 0.05) to the tenth power, which is 1 minus 0.95 to the tenth, about 0.40. Running many comparisons without correction makes a false positive likely, which is why you pre-register a primary metric or correct the threshold.
:::

:::q Experiment Design
question: An analyst watches an A/B test live and stops it the moment the p-value first dips below 0.05. Why does this inflate the false-positive rate above the stated 5%?
- Repeated peeking gives the noise many chances to cross the threshold once
- Stopping early reduces the sample below what power requires, biasing the estimate downward
- The p-value is computed incorrectly during a live test
- Early stopping changes the baseline conversion rate
answer: 0
explain: A wandering p-value will dip below 0.05 by chance at some point even under the null, so checking repeatedly and stopping at the first crossing captures those flukes. Fixing the sample size up front and reading the result only when the flight ends keeps the false-positive rate at the stated level.
:::

:::q Attribution & MMM
question: A conversion journey has 8 qualifying touches in the window. Under linear attribution, which splits credit evenly across all touches, what fraction of the conversion does each single touch receive?
- 0.5
- 0.25
- 0.125
- 1.0
answer: 2
explain: Linear attribution divides one whole conversion equally by the count of touches, so each touch earns 1 divided by 8 equals 0.125. The eight shares sum back to 1.0, and the touch count is the denominator that defines the split.
:::

:::q Attribution & MMM
question: A geometric adstock is written as A_t equals S_t plus lambda times A_(t-1). This week's spend contributes S_t equals 10,000, the retention rate lambda is 0.5, and last week's adstock A_(t-1) was 8,000. What is this week's adstock A_t?
- 18,000
- 14,000
- 13,000
- 10,000
answer: 1
explain: A_t equals 10,000 plus 0.5 times 8,000 equals 10,000 plus 4,000 equals 14,000. Adstock carries part of last period's advertising forward, which is why spend keeps driving sales after the week it ran, an effect last-click attribution misses.
:::

:::q Attribution & MMM
question: A marketing-mix model reports that a channel has strong average ROI, but its saturation curve is nearly flat at the current spend level. Should you shift more budget into it?
- No, a flat curve means low marginal ROI, so the next dollar returns little
- Yes, strong average ROI always justifies more spend
- Yes, because a flat curve means returns are constant and safe
- It cannot be decided without rerunning the whole model
answer: 0
explain: A flat saturation curve means the channel is near its ceiling, so marginal ROI is low even when average ROI looks strong. Reallocation depends on the slope at the current spend, the margin, not the average, so the next dollar belongs in a channel still on a steep part of its curve.
:::

:::q Statistics & Modeling
question: Over 900 random clicker-versus-non-clicker pairs, your CTR model scores the clicker higher in 720 of them. What AUC does that imply?
- 0.72
- 0.90
- 0.50
- 0.80
answer: 3
explain: AUC is the share of pairs where the positive outranks the negative, so AUC equals 720 divided by 900 equals 0.80. The model orders a random clicker above a random non-clicker 80% of the time, well above the 0.5 of random guessing, though this says nothing about calibration.
:::

:::q Statistics & Modeling
question: For time-ordered ad data, why is a random train-test split a worse choice than splitting by time (train on earlier weeks, test on later ones)?
- A random split lets future rows leak into training, flattering the model's apparent performance
- A random split always produces a smaller test set
- Time-based splits are required by logistic regression
- A random split makes the model train faster but less accurate
answer: 0
explain: A random split mixes later events into the training set, so the model effectively sees the future and its held-out score overstates real-world performance. Splitting by time trains on earlier weeks and tests on later ones, which mirrors how the model is actually used and gives an honest generalization estimate.
:::

:::q Statistics & Modeling
question: A clean-room match joins an advertiser's 400,000 hashed records against a retailer, and 260,000 find a counterpart. What is the match rate, and what does the unmatched share mean?
- 65%, and the unmatched 35% cannot be measured in the room
- 35%, and the matched 65% cannot be measured in the room
- 65%, and the unmatched share is a privacy protection, not a coverage gap
- 260%, because matches can exceed the submitted total
answer: 0
explain: Match rate equals 260,000 divided by 400,000 equals 65%. The unmatched 35% have no counterpart on the other side, so any lift or overlap result describes only the matched two thirds. A low match rate is a coverage problem, not a privacy feature, because you are reasoning about a thin, possibly biased slice.
:::
