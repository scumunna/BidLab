---
id: analytics-07
track: analytics
module: 7
title: Statistical power and experiment design
summary: How large a test you need to detect a lift, and why small effects demand big samples.
---
# Could the test even see it

Power is the probability that your experiment detects a real effect of a given size. Run a test that is too small and a true lift hides inside the noise, so you conclude nothing worked when it did.

Three things set the sample you need: the baseline conversion rate, the minimum detectable effect you care about, and the power and significance you demand. The required sample per arm grows with the square of how small an effect you want to catch.

$$ n \propto \frac{(z_{\alpha} + z_{\beta})^2}{MDE^2} $$

:::callout insight
Halving the effect you want to detect roughly quadruples the sample you need. Tiny lifts are expensive to prove.
:::

:::predict
prompt: A test sized to detect a 4% minimum detectable effect needs 5,000 users per arm. Holding everything else fixed, roughly how many users per arm would it need to detect a 2% effect instead?
answer: 20000
hint: Required sample scales with 1 over MDE squared. Halving the MDE multiplies the sample by four.
explain: Since n is proportional to 1/MDE^2, halving the detectable effect (4% to 2%) multiplies the required sample by 4: 5,000 x 4 = 20,000 per arm. Small lifts are expensive to prove.
:::

# Try it

Drag the baseline, the minimum detectable effect, and the sample size. Watch power respond, and see the sample you would need to hit 80% power.

:::widget experimentPower
:::

Design the test before you run it. Decide the smallest lift worth acting on, then size the experiment so it can actually find a lift that big. Otherwise a flat result tells you nothing.

:::callout key
A non-significant result from an underpowered test is not evidence of no effect. It is evidence you could not see one.
:::

:::quiz
question: You want to detect a smaller lift than before. What happens to the sample you need?
- It grows, roughly with the inverse square of the effect
- It shrinks
- It stays the same
- It grows linearly
answer: 0
explain: Required sample scales with 1 over MDE squared, so detecting a smaller effect needs a much larger sample.
:::

:::sources
- Kohavi, Tang, Xu, Trustworthy Online Controlled Experiments | https://experimentguide.com
:::
