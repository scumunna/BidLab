---
id: foundations-03
track: foundations
module: 3
title: Functions and graphs
summary: Recognize linear, exponential, and saturating curves, and read an outcome off a curve the way a marketer reads a spend response.
---
# A function turns an input into an output

A function is a rule that takes a number in and gives a number back. Put spend in, get conversions out. Put impressions in, get reach out. We draw a function as a curve: the input runs along the horizontal axis, the output along the vertical axis, and the curve shows what output each input produces. Reading a curve is just answering the question, if I go this far right, how high is the line.

The shape of the curve carries the story. A straight line says the output grows at a steady rate, the same bump in output for every extra unit of input. A bending line says the rate of growth itself is changing. Most of advertising lives in the bends, so learning to read shape is the goal of this lesson.

:::widget lineChart
title: Reading an output off a curve (input on the bottom, output up the side)
labels: 0, 1, 2, 3, 4, 5, 6
data: 0, 18, 32, 43, 51, 56, 59
:::

# Linear, exponential, and saturating

A linear function is a straight line, written y = m x + b, where m is the slope (how steep) and b is where the line starts on the vertical axis. Every extra unit of x adds exactly m to y. Doubling clicks at a fixed CPC doubles cost: that is linear.

$$ y = m x + b $$

An exponential function grows by a constant percentage instead of a constant amount, written y = a times b to the power x. It starts slow and then explodes, the way viral sharing or compounding interest does. A saturating function is the opposite: it rises fast at first and then flattens toward a ceiling it never quite reaches, the way reach approaches the size of the audience or extra spend stops buying new customers. The S-shaped cousin of saturation, slow then fast then flat, is the most common shape for a real spend response.

:::predict
prompt: A linear cost function is y = 2x + 50, where x is clicks and y is dollars. What is the cost at 300 clicks?
answer: 650
unit: $
hint: Multiply the slope by x, then add the starting value b.
explain: y = 2(300) + 50 = 600 + 50 = 650 dollars. Each extra click adds exactly 2 dollars, the slope, because a linear function grows by a constant amount per unit.
:::

:::callout insight
Linear means constant amount per unit. Exponential means constant percentage per unit, which compounds. Saturating means each unit adds less than the last, bending toward a ceiling. Knowing which shape you are on tells you whether the next dollar is worth spending.
:::

# Reading a response curve

A spend response curve plots money spent on the horizontal axis against an outcome like conversions on the vertical axis. Real ones saturate: the first dollars find the cheapest, most ready buyers, and as you spend more you reach into less responsive audiences, so the curve flattens. The height at a given spend is your total outcome, and the steepness at that point is what one more dollar buys.

:::predict
prompt: On a saturating response curve, spending 10,000 dollars yields 400 conversions and spending 11,000 dollars yields 410 conversions. How many extra conversions did that last 1,000 dollars buy?
answer: 10
unit: conversions
hint: Read the outcome off the curve at each spend, then take the difference.
explain: 410 - 400 = 10 conversions for the extra 1,000 dollars. The small gain reflects the flattening of the curve, where the steepness, what one more dollar buys, has already dropped well below where it started.
:::

:::callout warning
A flat stretch of the curve is a warning, not a wall. When the line has gone nearly horizontal, extra spend is buying almost nothing. That is the signal to widen the audience, change creative, or move budget elsewhere rather than push harder.
:::

# Try it

Drag the spend input and watch the outcome rise and then bend. Notice where the curve is steep (cheap growth) and where it goes flat (expensive growth), and read the outcome straight off the height of the line.

:::widget responseCurve
:::

:::quiz
question: A spend response curve has gone nearly flat at your current spend. What does that tell you about the next dollar?
- It buys almost no additional outcome
- It buys more outcome than the first dollar did
- It buys the same outcome as every earlier dollar
- The curve shape says nothing about the next dollar
answer: 0
explain: On a saturating curve, a flat stretch means the slope is near zero, so each additional dollar adds very little outcome. Steepness at a point is what one more unit of input buys.
:::

:::sources
- Khan Academy, introduction to functions and their graphs | https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:functions
- The Trade Desk, the Resource Desk (marketing and measurement resources) | https://www.thetradedesk.com/resources
:::
