---
id: foundations-08
track: foundations
module: 8
title: Logarithms, Growth, and Decay
summary: Logs as the inverse of exponents, exponential growth and decay, why reach and adstock curves saturate, log scales for skewed ad data, and reading a campaign by its half-life.
---
# Exponents and their inverse, the logarithm

An exponent is repeated multiplication. Writing $b^n$ means multiply the base $b$ by itself $n$ times, so $10^3 = 1000$ and $2^4 = 16$. A logarithm runs that machine backwards. It asks the question, to what power must I raise the base to land on this number. So $\log_{10}(1000) = 3$, because ten to the third power is a thousand, and $\log_2(16) = 4$.

That is the whole idea. A log is the exponent. When you see $\log_{10}(x)$ you should read it as the number of zeros, roughly, or more precisely the order of magnitude of $x$. Ten thousand is $10^4$, so its log is 4. A million is $10^6$, so its log is 6. The log compresses a wide range of sizes into a short, tame range of exponents, which is exactly why it shows up everywhere ad data is lopsided.

$$ \log_b(x) = n \iff b^n = x $$

:::predict
prompt: A list of advertiser spends ranges from small to enormous. One advertiser spends 1,000,000 dollars. What is the base-10 logarithm of that spend?
answer: 6
tolerance: 0.01
unit: 
hint: How many times do you multiply 10 by itself to reach 1,000,000? Count the zeros.
explain: 1,000,000 is 10 multiplied by itself 6 times, so it is $10^6$ and $\log_{10}(1{,}000{,}000) = 6$. The log turns a seven-figure number into the single digit 6, which is the whole point of a log scale.
:::

# Exponential growth

Growth is exponential when a quantity gets multiplied by the same factor every period, rather than having a fixed amount added. Adding the same amount each period is linear and traces a straight line. Multiplying by the same factor each period is exponential and curves upward ever faster, because each period builds on a larger base than the one before.

The formula is $V = V_0 \times g^t$, where $V_0$ is the starting value, $g$ is the growth factor per period, and $t$ is the number of periods. If a channel's weekly conversions start at 1,000 and grow by 50 percent each week, the growth factor is $g = 1.5$. After four weeks you have $1000 \times 1.5^4 = 1000 \times 5.0625 = 5062.5$ conversions, not the $1000 + 4 \times 500 = 3000$ that linear thinking would predict. The gap between exponential and linear widens with every period.

$$ V = V_0 \times g^t $$

:::predict
prompt: Weekly conversions start at 1,000 and grow by 50 percent each week, so the growth factor is 1.5. How many conversions are there after 4 weeks?
answer: 5062.5
tolerance: 1
unit: 
hint: Multiply 1,000 by 1.5 raised to the 4th power. Note 1.5 to the 4th is 5.0625.
explain: $1000 \times 1.5^4$. Since $1.5^2 = 2.25$ and $1.5^4 = 2.25^2 = 5.0625$, the result is $1000 \times 5.0625 = 5062.5$. Compounding at 50 percent beats the linear guess of 3,000 by a wide margin.
:::

# Exponential decay and half-life

Decay is exponential growth run in reverse. Instead of multiplying by a factor above one, you multiply by a retention factor between zero and one each period, so the quantity falls by a constant percentage rather than a constant amount. Awareness from a flight of ads behaves this way. It does not vanish the day the ads stop, it fades by roughly the same fraction each week.

The natural way to summarize a decay is its half-life, the time it takes to fall to half its value. With a weekly retention rate $r$, the half-life in weeks is $t_{1/2} = \ln(0.5) / \ln(r)$. A 70 percent weekly retention ($r = 0.7$) gives a half-life of $\ln(0.5)/\ln(0.7) \approx 1.94$ weeks. Industry studies put advertising half-lives around 2 to 5 weeks for many brands, and roughly 2.5 weeks on average for fast moving consumer goods, so awareness from a campaign is mostly gone within a month or two of going dark.

$$ t_{1/2} = \frac{\ln(0.5)}{\ln(r)} $$

:::predict
prompt: Brand awareness sits at 100 index points when ads stop. Each week it retains 70 percent of the prior week's level. What is the index after 2 weeks of decay?
answer: 49
tolerance: 0.5
unit: 
hint: Multiply by 0.7 once per week, so apply 0.7 twice.
explain: Week 1 is $100 \times 0.7 = 70$, and week 2 is $70 \times 0.7 = 49$. The level falls by the same 30 percent fraction each week, not by a fixed number of points, which is the signature of exponential decay.
:::

:::callout key
A half-life is the practitioner's shorthand for a decay rate. A 2-week half-life means half the effect is gone in 2 weeks, three quarters in 4 weeks, seven eighths in 6 weeks. Knowing the half-life tells you how long to keep crediting a flight of ads after it ends.
:::

# Why reach and adstock curves saturate

The same multiply-by-a-fraction logic explains the most important curve in media planning, the reach curve. Each new impression you buy reaches some fresh people and some you have already hit. As a campaign runs, the pool of unreached people shrinks, so every additional dollar adds a little less new reach than the dollar before it. Reach therefore climbs steeply at first and then bends over toward a ceiling. A common model is $R = R_{max}(1 - e^{-k \cdot x})$, where $x$ is spend or impressions and $R_{max}$ is the addressable ceiling. This is a saturating, concave shape, and on the right axis it looks logarithmic.

Adstock, the carryover of advertising over time, is the time-domain cousin of this idea. The geometric adstock model is $A_t = X_t + \lambda A_{t-1}$, where this week's effect $A_t$ is this week's new advertising $X_t$ plus a decayed fraction $\lambda$ of last week's accumulated effect. The decay piece is the exponential fade from the previous section, and the accumulation piece is what builds the saturating curve. Both reach and adstock curves are concave because the next unit always does a bit less than the last, which is diminishing returns made visible.

The curve below makes this concrete. Drag spend along it and watch each extra dollar buy less new reach than the one before, the saturation the math predicts.

:::widget responseCurve
:::

:::predict
prompt: Reach follows $R = 100(1 - e^{-0.5x})$ percent, where x is spend in thousands. The values are 86.5 percent at x = 4 and 95.0 percent at x = 6. How many points of new reach does the spend from 4 to 6 thousand add?
answer: 8.5
tolerance: 0.3
unit: percentage points
hint: Subtract the reach at x = 4 from the reach at x = 6.
explain: $95.0 - 86.5 = 8.5$ percentage points for a 2,000 dollar increase. Earlier, going from 0 to 2 thousand added about 63 points, so the same spend buys far less reach once the curve has started to saturate. That is the saturation point in action.
:::

# Log scales for skewed ad data

Advertising data is almost always skewed. A handful of publishers, keywords, or audiences carry most of the spend while a long tail carries tiny amounts, the familiar Pareto or 80-20 shape. Plotting that on a normal linear axis crushes the long tail against zero and tells you nothing. The fix is a logarithmic axis, where equal distances represent equal multiples rather than equal amounts. On a log axis the step from 10 to 100 takes the same space as the step from 100 to 1,000, because each is a tenfold jump.

A log scale spreads out the small values so you can actually see them and pulls in the giant values so they do not dominate the picture. It is the standard tool whenever data spans several orders of magnitude, from CPMs to impression counts to spend by publisher. A straight line on a log axis is not a constant amount of growth, it is a constant percentage of growth, which is precisely the exponential behavior from earlier in this lesson.

:::quiz
question: Your spend-by-publisher data ranges from 50 dollars to 5,000,000 dollars, with most publishers near the low end. Why plot it on a logarithmic axis?
- A log axis adds the values instead of multiplying them
- A log axis spreads out the many small values and compresses the few giant ones so the whole range is readable
- A log axis removes the long tail of small publishers from the chart
- A log axis converts dollars into percentages automatically
answer: 1
hint: Think about what equal spacing means on a log axis versus a linear one.
explain: On a log axis equal distances are equal multiples, so the cluster of small publishers spreads out and becomes readable while the few enormous ones stop dominating. The data spans about five orders of magnitude, exactly the case a log scale is built for.
:::

# Reading a campaign by its curves

Put the pieces together and you can read a campaign at a glance. Exponential growth warns you that a small early trend can become huge fast, so an unmonitored spend or frequency can compound out of control. Saturation tells you when to stop pouring money into one tactic, because past the bend each dollar buys almost nothing new. Decay and half-life tell you how long an effect lingers after you stop, which is how you decide attribution windows and reflight timing.

The unifying idea is that advertising is multiplicative, not additive. Effects compound, audiences saturate, and awareness fades by fractions. Logs are the lens that turns all of this multiplicative behavior into straight lines and single-digit exponents you can reason about. Once you see a curve and ask whether it is growing exponentially, saturating, or decaying, you are reading media the way an analyst does.

:::predict
prompt: An effect has a 2.0-week half-life. Starting at 100 index points, what is the level after 4 weeks, which is exactly two half-lives?
answer: 25
tolerance: 0.5
unit: 
hint: Each half-life cuts the level in half. Two half-lives means halve it twice.
explain: One half-life takes 100 to 50, and a second half-life takes 50 to 25. Two half-lives is $100 \times (1/2)^2 = 25$ index points. Half-life thinking lets you do decay math in your head without touching the exponential formula.
:::

:::callout insight
Growth, saturation, and decay are the same exponential machine pointed in different directions. Growth multiplies by a factor above one, decay multiplies by a fraction below one, and saturation is decay seen from the side as a shrinking pool of fresh reach. Spot which one you are looking at and the right decision usually follows.
:::

:::sources
- Khan Academy, Intro to logarithms | https://www.khanacademy.org/math/algebra2/x2ec2f6f830c9fb89:logs/x2ec2f6f830c9fb89:log-intro/a/intro-to-logarithms
- Wikipedia, Logarithm | https://en.wikipedia.org/wiki/Logarithm
- Wikipedia, Advertising adstock | https://en.wikipedia.org/wiki/Advertising_adstock
- Recast, Adstocks and the lagged effect of advertising | https://getrecast.com/adstock-rates/
- Recast, Diminishing returns and channel saturation | https://getrecast.com/diminishing-returns/
- Impression, Diminishing returns and saturation curves | https://www.impressiondigital.com/blog/saturation-curves/
- Google for Developers, Meridian reach and frequency | https://developers.google.com/meridian/docs/advanced-modeling/reach-frequency
- SAS, How to use a log scale on a histogram | https://blogs.sas.com/content/iml/2023/05/30/log-scale-histogram.html
:::
