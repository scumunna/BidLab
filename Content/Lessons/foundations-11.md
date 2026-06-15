---
id: foundations-11
track: foundations
module: 11
title: Rates of Change and the Derivative
summary: Read slope as a rate of change, treat the derivative as the marginal effect of one more unit, and find the spend where the next dollar stops paying for itself.
---
# Slope is a rate of change

Every curve in advertising tells a story of change. Spend goes up and conversions follow, but not in a straight line. The first tool for reading that story is slope, which is just rise over run: how much the output moves for a given move in the input.

$$ \text{slope} = \frac{\text{change in output}}{\text{change in input}} = \frac{\Delta y}{\Delta x} $$

The Greek letter $\Delta$ (delta) means "change in." If spend rises from 10,000 dollars to 12,000 dollars and conversions rise from 500 to 560, the slope over that stretch is $\frac{560 - 500}{12{,}000 - 10{,}000} = \frac{60}{2{,}000} = 0.03$ conversions per dollar. Slope is a rate, and a rate is the whole game when you are deciding whether the next dollar is worth spending.

:::predict
prompt: Spend rises from 4,000 dollars to 6,000 dollars and conversions rise from 180 to 240. What is the slope in conversions per dollar?
answer: 0.03
tolerance: 0.001
unit:
hint: Change in conversions divided by change in spend.
explain: Slope = (240 - 180) / (6,000 - 4,000) = 60 / 2,000 = 0.03 conversions per dollar. Over this stretch each extra dollar bought 0.03 of a conversion, or one conversion for every 33.33 dollars.
:::

# The derivative is the marginal effect

When you shrink that run down to a single unit, the slope becomes the derivative. The derivative of a function at a point is the slope of the curve right there, the instantaneous rate of change. In plain operational terms, the derivative answers "if I add one more unit of input, how much does the output move?" That is the marginal effect, and marginal thinking is the heartbeat of optimization.

We write the derivative of cost with respect to conversions as $\frac{dC}{dn}$, the marginal cost per conversion. We write the derivative of revenue with respect to spend as $\frac{dR}{ds}$, the marginal revenue per dollar. The averages you usually report, like blended CPA or account-level ROAS, look backward at everything you already bought. The derivative looks at the very next unit, which is the only unit you actually control going forward.

:::quiz
question: Your account CPA averaged 25 dollars across the whole campaign, but the last 2,000 dollars of spend bought only 40 conversions. Which number should guide your decision to spend more?
- The 25 dollar average CPA, because it covers more data
- The marginal CPA of 50 dollars from the most recent spend
- The midpoint of the two, about 37.50 dollars
- Whichever number is lower
answer: 1
hint: The next dollar behaves like the most recent dollars, not like the lifetime average.
explain: The marginal CPA is 2,000 / 40 = 50 dollars, double the average. The next dollar you spend will perform like the recent marginal dollars, not like the cheap early ones baked into the average. Decisions about more spend always ride on the margin.
:::

# Marginal CPA and marginal ROAS

These two metrics are derivatives wearing operational clothes. Marginal CPA is the cost of the next conversion at your current spend level, computed as the extra spend divided by the extra conversions it produced. Marginal ROAS is the revenue from the next dollar, the extra revenue divided by the extra spend.

$$ \text{marginal CPA} = \frac{\Delta \text{spend}}{\Delta \text{conversions}}, \qquad \text{marginal ROAS} = \frac{\Delta \text{revenue}}{\Delta \text{spend}} $$

These are the slopes of the response curve at the point where you are operating now. The reason practitioners increasingly plan on marginal ROAS rather than average ROAS is that the average flatters you with the cheap early wins, while the margin tells you the truth about the next increment. A campaign can show a healthy 4.0 average ROAS while its marginal ROAS has already fallen below 1.0, meaning the next dollar loses money even though the account still looks green.

:::predict
prompt: Revenue rises from 40,000 dollars to 46,000 dollars when spend rises from 8,000 dollars to 10,000 dollars. What is the marginal ROAS over that increment?
answer: 3
tolerance: 0.01
unit:
hint: Change in revenue divided by change in spend.
explain: Marginal ROAS = (46,000 - 40,000) / (10,000 - 8,000) = 6,000 / 2,000 = 3.0. The last 2,000 dollars returned 3 dollars of revenue per dollar spent, which is the slope of the revenue curve at that spend level.
:::

# Diminishing returns

Response curves bend because the best opportunities go first. An auction-based system spends your early budget on the most responsive users, the best placements, the cheapest converting audiences. Each additional dollar then reaches a slightly less responsive pocket of demand, so the marginal return falls as spend climbs. That bending shape is diminishing returns, and it is the single most important pattern in budget planning.

Read it on a spend ladder, where each rung is an extra 1,000 dollars and each conversion is worth 50 dollars:

:::widget lineChart
title: Marginal conversions per extra 1,000 dollars of spend (illustrative)
labels: 0 to 1k, 1k to 2k, 2k to 3k, 3k to 4k, 4k to 5k
data: 40, 32, 24, 16, 8
unit:
:::

The first 1,000 dollars buys 40 conversions, the next buys 32, then 24, then 16, then 8. The slope is positive the whole way, so total conversions keep rising, but the slope is shrinking, which is exactly what diminishing returns means: still growing, growing more slowly each step.

:::predict
prompt: On the ladder above, conversions are worth 50 dollars each. For the 2k to 3k step that adds 24 conversions, what is the marginal ROAS of that 1,000 dollar block?
answer: 1.2
tolerance: 0.01
unit:
hint: Revenue from the block is 24 times 50. Divide by the 1,000 dollars spent.
explain: Block revenue = 24 times 50 = 1,200 dollars. Marginal ROAS = 1,200 / 1,000 = 1.2. The block still returns more than a dollar per dollar, so it is worth buying, but the margin has fallen from 2.0 on the first block toward the break-even line.
:::

# The optimum is where the margin hits zero

Here is the punchline of the whole lesson. A maximum sits exactly where the derivative equals zero. On a profit curve that rises and then falls, the very top is flat, slope zero, because just before the peak the next unit still adds profit and just after it the next unit subtracts profit. So the rule for the best spend level is: keep spending while the marginal dollar adds profit, and stop the instant it stops.

$$ \text{optimal spend: } \quad \frac{d(\text{profit})}{d(\text{spend})} = 0 \quad \Leftrightarrow \quad \text{marginal ROAS} = 1 $$

With conversions worth 50 dollars, a dollar of spend breaks even when it returns one dollar of revenue, which is marginal ROAS of 1.0, which on the ladder is the block that yields 20 conversions per 1,000 dollars. Walk the rungs: the 2k to 3k block yields 24 conversions (ROAS 1.2, still profitable), and the 3k to 4k block yields 16 conversions (ROAS 0.8, now losing money). The crossover sits between them, so the profit-maximizing spend is 3,000 dollars.

Check it against total profit. At 3,000 dollars you have $40 + 32 + 24 = 96$ conversions, revenue $96 \times 50 = 4{,}800$, profit $4{,}800 - 3{,}000 = 1{,}800$. Push to 4,000 dollars and you get 112 conversions, revenue 5,600, profit $5{,}600 - 4{,}000 = 1{,}600$. Profit fell by spending more, which confirms the peak was at 3,000, right where the margin crossed zero.

:::predict
prompt: At 3,000 dollars spend, profit is 1,800 dollars (96 conversions at 50 dollars, minus 3,000). At 4,000 dollars, profit is 1,600 dollars (112 conversions at 50 dollars, minus 4,000). What is the profit-maximizing spend level?
answer: 3000
tolerance: 1
unit: $
hint: Pick the spend with the higher profit, where the next block would push marginal ROAS below 1.0.
explain: Profit is 1,800 dollars at 3,000 and only 1,600 dollars at 4,000, so 3,000 dollars is the optimum. The 3k to 4k block returns a marginal ROAS of 0.8, below the break-even 1.0, so adding it destroys 200 dollars of profit. The peak is exactly where the marginal dollar stops paying for itself.
:::

:::callout key
Optimize on the margin, not the average. Keep spending while marginal ROAS is above 1.0 and stop when it reaches 1.0, because that flat top, where the derivative of profit is zero, is the most profit you can make. The lifetime average can look great long after the next dollar has started losing money.
:::

:::sources
- Lifesight, What is Marginal ROAS | https://lifesight.io/glossary/marginal-roas/
- WITHIN, Marginal CPA and ROAS, the guide to CPA optimization | https://www.within.co/blog/marginal-metrics-why-youve-got-cpas-wrong/
- Precis, Why marginal ROAS should be your most important metric for media planning | https://www.precis.com/resources/why-marginal-roas-should-be-your-most-important-metric-for-media-planning
- Khan Academy, Derivatives, definition and basic rules | https://www.khanacademy.org/math/differential-calculus/dc-diff-intro
- Grove City College, Business Calculus, applied optimization | http://www2.gcc.edu/dept/math/faculty/BancroftED/buscalc/chapter2/section2-9.php
- CORE Econ, Marginal revenue and marginal cost | https://www.core-econ.org/the-economy/v1/book/text/leibniz-07-06-01.html
- Saxifrage, Diminishing returns in marketing | https://www.saxifrage.xyz/post/diminishing-returns
:::
