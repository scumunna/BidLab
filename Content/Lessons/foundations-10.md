---
id: foundations-10
track: foundations
module: 10
title: Conditional Probability and Bayes
summary: Read a probability that depends on a condition, flip it with Bayes theorem, and see why a rare event turns an accurate test into a flood of false positives.
---
# Probability with a condition attached

Most of the probabilities you actually care about are conditional. You rarely want the bare chance that a user converts. You want the chance that a user converts given that they clicked, or the chance a transaction is fraud given that a detector flagged it. The little word "given" changes everything, because it narrows the world to the rows that already satisfy the condition.

The notation is $P(A \mid B)$, read as the probability of $A$ given $B$. It is defined as the share of the $B$ world that is also $A$:

$$ P(A \mid B) = \frac{P(A \text{ and } B)}{P(B)} $$

You take the slice where both happen and divide by the whole condition slice. If 1,000 users click and 50 of them convert, then $P(\text{convert} \mid \text{click}) = 50 / 1{,}000 = 5\%$. The denominator is the clickers, not everyone, because the condition already restricted the world.

:::predict
prompt: Of 8,000 users who saw an ad, 2,000 clicked, and 120 of those clickers converted. What is P(convert given click)?
answer: 6
tolerance: 0.05
unit: %
hint: Divide conversions by clickers, not by everyone who saw the ad.
explain: P(convert given click) = 120 / 2,000 = 0.06, a 6 percent rate. You divide by the 2,000 clickers because the condition "given click" already narrowed the world to them. Dividing by 8,000 would answer a different question.
:::

# The order of the condition matters

Here is the trap that breaks most intuition. $P(A \mid B)$ is not the same as $P(B \mid A)$. The probability that a flagged transaction is fraud is a completely different number from the probability that a fraudulent transaction gets flagged. One asks how trustworthy the alarm is, the other asks how good the detector is at catching real fraud. Confusing the two is called the inverse fallacy, and it shows up everywhere from medical tests to brand-safety filters.

A detector might catch 90 percent of all fraud, which sounds excellent. That is $P(\text{flag} \mid \text{fraud}) = 90\%$. But the number you act on in operations is $P(\text{fraud} \mid \text{flag})$, the share of flagged transactions that are genuinely fraud. Those two can be wildly far apart, and the gap depends entirely on how common fraud is in the first place.

:::quiz
question: A fraud model catches 95 percent of fraudulent transactions. Which probability does that 95 percent describe?
- P(fraud given flagged), how trustworthy the alarm is
- P(flagged given fraud), how good the detector is at catching fraud
- The overall fraud rate in the population
- The false positive rate on legitimate transactions
answer: 1
hint: "Catches 95 percent of fraud" starts from the fraud cases and asks how many get caught.
explain: Catching 95 percent of fraud means that among the truly fraudulent transactions, 95 percent get flagged, which is P(flagged given fraud). That is a property of the detector, not a statement about how many of your alarms are real. The trustworthiness of an alarm is the reversed conditional, P(fraud given flagged).
:::

# Bayes theorem flips the condition

Bayes theorem is the formula that converts the conditional you have into the conditional you want. It lets you go from $P(B \mid A)$, which a vendor usually reports, to $P(A \mid B)$, which you need to act on:

$$ P(A \mid B) = \frac{P(B \mid A) \times P(A)}{P(B)} $$

Read it as a recipe. $P(A)$ is the prior, your belief before the evidence. $P(B \mid A)$ is the likelihood, how expected the evidence is when $A$ is true. The denominator $P(B)$ is the total probability of seeing the evidence at all, across both the $A$ world and the not-$A$ world. The result $P(A \mid B)$ is the posterior, your updated belief after seeing the evidence.

The denominator is where people slip, so expand it. The evidence can appear two ways, with $A$ true or with $A$ false, so $P(B) = P(B \mid A)\,P(A) + P(B \mid \text{not }A)\,P(\text{not }A)$. That full version is the one you compute with.

:::predict
prompt: An email is spam with prior probability 40%. The word "wire" appears in 60% of spam but only 2% of real mail. Using Bayes, what is the probability the email is spam given it contains "wire"? Posterior = (0.60 times 0.40) divided by (0.60 times 0.40 plus 0.02 times 0.60).
answer: 95.2
tolerance: 0.3
unit: %
hint: Numerator is likelihood times prior. Denominator adds the spam path and the real-mail path.
explain: Numerator = 0.60 times 0.40 = 0.24. Real-mail path = 0.02 times 0.60 = 0.012. Denominator = 0.24 + 0.012 = 0.252. Posterior = 0.24 / 0.252 = 0.952, about 95.2 percent. The strong likelihood ratio (60 percent versus 2 percent) pushes the 40 percent prior up sharply.
:::

# The base rate trap

Now the operational lesson that catches even smart teams. When the thing you are testing for is rare, an accurate test still produces mostly false alarms, because there are so many more negatives to misfire on. The base rate, the prior prevalence, dominates the result.

Walk a concrete fraud case with natural frequencies, which are far easier than percentages. Take 100,000 transactions where the fraud rate is 0.5 percent, so 500 are fraud and 99,500 are legitimate. The detector flags 90 percent of fraud and has a 3 percent false positive rate on legitimate transactions.

$$ P(\text{fraud} \mid \text{flag}) = \frac{0.90 \times 500}{0.90 \times 500 + 0.03 \times 99{,}500} $$

True positives are $0.90 \times 500 = 450$. False positives are $0.03 \times 99{,}500 = 2{,}985$. So flagged transactions total $450 + 2{,}985 = 3{,}435$, and only 450 are real fraud. A flagged transaction is genuine fraud just $450 / 3{,}435 = 13.1\%$ of the time, even though the detector catches 90 percent of fraud. The 3 percent error rate, applied to a huge legitimate pool, drowns the rare true cases.

:::predict
prompt: Per 100,000 transactions, 450 flagged are real fraud and 2,985 flagged are legitimate false positives. What share of flagged transactions are actually fraud?
answer: 13.1
tolerance: 0.2
unit: %
hint: Real fraud flags divided by all flags, true plus false.
explain: All flags = 450 + 2,985 = 3,435. Real fraud share = 450 / 3,435 = 0.131, about 13.1 percent. Even a detector that catches 90 percent of fraud sends an analyst chasing roughly seven false alarms for every real one, because fraud is rare.
:::

:::callout insight
The rarer the event, the more a fixed false positive rate dominates. A 3 percent error on 99,500 clean transactions is 2,985 false alarms, which swamps the few hundred true cases. Lowering the base rate makes precision worse even when the detector itself never changes.
:::

# Updating beliefs, one piece of evidence at a time

Bayes is not a one-shot calculation, it is a loop. Today's posterior becomes tomorrow's prior. A second independent signal updates the belief again, and the math compounds. This is exactly how spam filters, fraud scores, and bid-quality models sharpen over time: each new feature shifts the probability, and the prior carries the accumulated evidence forward.

Try the disease-test version, the canonical base-rate case, because the same shape governs any rare-event detector you will ever operate. Take 10,000 people where 1 percent have a condition, so 100 are sick and 9,900 are healthy. The test catches 99 percent of sick people and has a 5 percent false positive rate.

$$ P(\text{sick} \mid \text{positive}) = \frac{0.99 \times 100}{0.99 \times 100 + 0.05 \times 9{,}900} $$

:::predict
prompt: Per 10,000 people, 99 true positives come from the 100 sick, and 0.05 times 9,900 = 495 false positives come from the healthy. What is the probability a positive person is actually sick?
answer: 16.7
tolerance: 0.3
unit: %
hint: True positives divided by all positives, 99 over 99 plus 495.
explain: All positives = 99 + 495 = 594. P(sick given positive) = 99 / 594 = 0.167, about 16.7 percent. A test that is 99 percent sensitive still leaves a positive person far more likely healthy than sick, because the 1 percent base rate is so low. Most people guess around 99 percent and neglect the base rate entirely.
:::

:::quiz
question: A positive result on the rare-condition test above leaves only a 16.7 percent chance of really being sick. What is the single best way to raise that posterior toward certainty?
- Make the test catch a higher share of sick people
- Run a second independent test and update again, using 16.7 percent as the new prior
- Increase the population size
- Lower the false positive rate to exactly zero, which is impossible in practice
answer: 1
hint: Bayes is a loop. The posterior from one test becomes the prior for the next.
explain: A second independent positive test updates the belief again, now starting from a prior of 16.7 percent instead of 1 percent, which drives the posterior much higher. This is why screening programs confirm with a second test rather than trusting a single positive on a rare condition.
:::

:::sources
- Investopedia, Bayes Theorem definition and formula | https://www.investopedia.com/terms/b/bayes-theorem.asp
- Khan Academy, Conditional probability and independence | https://www.khanacademy.org/math/statistics-probability/probability-library
- Statistics By Jim, Base Rate Fallacy overview and examples | https://statisticsbyjim.com/probability/base-rate-fallacy/
- Wikipedia, Base rate fallacy | https://en.wikipedia.org/wiki/Base_rate_fallacy
- Brilliant, Bayes Theorem and Conditional Probability | https://brilliant.org/wiki/bayes-theorem/
- Harvey Mudd College, Medical Tests and Bayes Theorem | https://math.hmc.edu/funfacts/medical-tests-and-bayes-theorem/
- Nature Scientific Reports, Risk-adaptive Bayesian ensemble model for fraud detection | https://www.nature.com/articles/s41598-025-20651-0
- Corporate Finance Institute, Bayes Theorem definition formula and example | https://corporatefinanceinstitute.com/resources/data-science/bayes-theorem/
:::
