---
id: analytics-14
track: analytics
module: 14
title: "Capstone: run an incrementality experiment"
summary: The full loop, power the test then run it then analyze the result with SQL then decide, on a real holdout design.
---
# The full loop

This capstone ties the track together into one workflow: power, run, analyze, decide. You will design a holdout incrementality test, size it so it can detect the lift you care about, query the result, and make a go or no-go call. Skipping any step turns the experiment into an expensive guess.

The discipline is to commit to the decision rule before you see data. Decide the minimum detectable effect that would change your budget, the significance level, and the action you will take at each outcome. Lock those in first, then run.

:::quiz
question: Why commit to the minimum detectable effect, significance level, and action for each outcome before any data arrives?
- It stops you from rationalizing the result after the fact and inflating false positives
- It makes the experiment run faster
- It is required by SQL before you can query the results
- It guarantees the test will reach significance
hint: Decisions made after seeing the data invite cherry-picking. What does pre-committing protect against?
answer: 0
explain: Locking the decision rule up front removes the temptation to redefine "success" once results are in. Choosing thresholds or stopping rules after seeing data is how false positives creep in, so pre-registration keeps the readout honest.
:::

# Power first

Sizing comes before spending. From the previous power module, the sample per arm scales with the baseline rate and the inverse square of the minimum detectable effect, at your chosen significance and power.

$$ n \propto \frac{(z_{\alpha} + z_{\beta})^2}{MDE^2} $$

If a 5% baseline conversion rate and a target of catching a 10% relative lift demands more users than your flight can deliver, you learn that now, before wasting budget on a test that could never reach significance. Adjust the holdout share, extend the flight, or accept a larger detectable effect.

:::widget experimentPower
:::

# Run, then analyze

Randomly assign eligible users to test (served the ad) or control (held out), at the split your power analysis justified. Use ghost-ad logging so the control captures only users who would have been served, removing auction-selection bias. Let the flight complete; do not peek and stop early, which inflates false positives.

To analyze, count conversions and users per arm, then compare rates. A query like this returns the inputs for the lift calculation and an export for the readout.

```sql
SELECT arm,
       COUNT(*)                              AS users,
       SUM(converted)                        AS conversions,
       AVG(converted)                        AS cvr
FROM   experiment_assignments
WHERE  flight_id = 'q3_ctv_holdout'
GROUP  BY arm;
```

Export those rows to your readout, one line per arm, and the lift falls straight out of the two conversion rates.

:::predict
prompt: Your readout returns a test-arm conversion rate of 2.4% and a control-arm conversion rate of 2.0%. Using lift = (CVR_test - CVR_control) / CVR_control, what is the incremental lift, as a percent?
answer: 20
unit: %
tolerance: 0.1
hint: Subtract the control rate from the test rate, divide by the control rate, then multiply by 100.
explain: Lift = (2.4% - 2.0%) / 2.0% x 100 = 0.4 / 2.0 x 100 = 20%. The two per-arm rates from the query feed straight into the lift formula; the remaining step is checking whether that 20% clears your significance threshold and minimum detectable effect.
:::

# Decide

Compute lift as `(CVR_test - CVR_control) / CVR_control`, the test rate minus the control rate over the control rate, then check whether the difference clears your significance threshold. If it does and the lift beats your minimum detectable effect, scale the channel. If the interval straddles zero, the honest read is no detected effect, not proof of none.

:::callout key
A null result from a properly powered test is a real finding: this channel did not move the needle at a size worth caring about. That is decision-grade information, not a failed experiment.
:::

:::callout warning
Stopping the moment the result looks significant inflates the false-positive rate well above your stated level. Fix the sample size up front and read the result only when the flight ends.
:::

:::quiz
question: Your powered holdout finishes and the lift confidence interval includes zero. What is the correct conclusion?
- No incremental effect was detected at the size you powered for
- The campaign definitely caused zero conversions
- The test failed and should be discarded
- You should keep running until it turns significant
answer: 0
explain: An interval spanning zero means you did not detect an effect at your chosen size, which is a valid decision-grade result. It does not prove zero effect, and extending a finished test to chase significance inflates false positives.
:::

:::sources
- Kohavi, Tang, Xu, Trustworthy Online Controlled Experiments | https://experimentguide.com
- Johnson, Lewis, Nubbemeyer, Ghost Ads: Improving the Economics of Measuring Online Ad Effectiveness (Journal of Marketing Research) | https://doi.org/10.1509/jmr.15.0297
:::
