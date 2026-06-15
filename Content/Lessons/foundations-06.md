---
id: foundations-06
track: foundations
module: 6
title: Optimization and marginal thinking
summary: Think at the margin, recognize diminishing returns, and use the equal-marginal rule to split a budget across channels.
---
# The margin is the next unit

Optimization is the search for the best choice given a goal and a limit. The key habit is to stop thinking about totals and start thinking at the margin, meaning the effect of the very next unit. The marginal value of a dollar is the extra outcome that one more dollar produces, right here, right now. Totals tell you where you have been; the margin tells you what to do next.

This reframing is powerful because good decisions are made one step at a time. You do not ask whether a channel is good overall, you ask whether the next dollar into it beats the next dollar somewhere else. Almost every allocation question in advertising reduces to comparing marginal values.

:::predict
prompt: A channel has produced 500 conversions on 20,000 dollars of spend so far. The very next 1,000 dollars is expected to add 20 conversions. What is the marginal return on that next 1,000 dollars, in conversions per 1,000 dollars?
answer: 20
unit: conversions per 1,000
tolerance: 0.1
hint: Marginal return looks only at the next unit, not the running total.
explain: The next 1,000 dollars buys 20 conversions, so the marginal return is 20 per 1,000 dollars. The average so far is 500 / 20 = 25 per 1,000, but it is the marginal number, not the average, that should decide where the next dollar goes.
:::

:::callout key
Average return tells you how a channel has done. Marginal return tells you what the next dollar will do. Decisions are always made at the margin, so the marginal number is the one that should move your money.
:::

# Diminishing returns

Marginal value rarely stays constant. As you pour more money into one channel, each additional dollar tends to buy a little less than the dollar before it, because you exhaust the cheapest, most responsive audience first and reach into less responsive ones. This is diminishing returns, and it is the same saturating shape from the lesson on curves, now seen through its slope.

Diminishing returns is why no single channel should absorb the whole budget. Even a great channel eventually has a low marginal value once it is saturated, while a channel that looked worse on average may still have a high marginal value because you have barely funded it. The shape of the slope, not the height of the total, is what should guide the next move.

:::predict
prompt: A channel returns 200 conversions at 10,000 dollars of spend and 230 conversions at 12,000 dollars. What is the marginal return on that last 2,000 dollars, in conversions per 1,000 dollars?
answer: 15
unit: conversions per 1,000
tolerance: 0.1
hint: Marginal return is the extra output divided by the extra spend that produced it.
explain: Extra conversions = 230 - 200 = 30, over an extra 2,000 dollars, which is 30 / 2 = 15 conversions per 1,000 dollars. Comparing this marginal number against another channel's next dollar is what guides the move, not the total of 230.
:::

# The equal-marginal rule

Here is the punchline of optimization under a fixed budget. To get the most outcome, move money from wherever the marginal value is low to wherever it is high, and keep going. As you add to the high-value channel its marginal value falls, and as you take from the low-value channel its marginal value rises. You stop when they meet. At the best allocation, the marginal value of the last dollar is equal across every channel.

$$ MV_A = MV_B = MV_C $$

If the next dollar in channel A would buy more than the next dollar in channel B, you have not finished, because shifting a dollar from B to A raises your total. Only when every channel returns the same on its next dollar is there no profitable move left. That single condition, equal marginal value everywhere, defines the optimum.

:::predict
prompt: At the current allocation, the next dollar in channel A returns 4.00 dollars and the next dollar in channel B returns 4.00 dollars, while channel C returns 6.00 dollars. To improve the total, you should move a dollar into C from a channel returning how much?
answer: 4
unit: $
tolerance: 0.01
hint: Move money toward the highest marginal return, taking it from the lower-returning channels.
explain: C returns 6.00 dollars on its next dollar versus 4.00 for A and B, so shifting a dollar out of a 4.00 dollar channel into C gains 2.00 dollars. You keep going until every channel's next dollar returns the same, which is the equal-marginal condition.
:::

:::callout warning
Equal marginal value is not equal spend. The right answer often pours very different amounts into different channels. What gets equalized is the return on the last dollar, not the size of the budgets, so do not mistake fairness in dollars for optimality.
:::

# Try it

Shift budget between channels and watch total outcome respond. Push toward the point where moving one more dollar in any direction stops helping, and notice that the marginal returns have lined up even though the spend levels have not.

:::widget budgetAllocator
:::

:::quiz
question: Under a fixed budget, the next dollar in channel A would return 3 dollars and the next in channel B would return 5 dollars. What should you do?
- Move budget from A to B until their marginal returns are equal
- Leave it, since both channels are profitable
- Move budget from B to A to balance the spend
- Split every new dollar evenly between A and B
answer: 0
explain: The next dollar does more in B than in A, so shifting from A to B raises the total. Keep moving until the marginal returns equalize, which is the equal-marginal condition for the optimum.
:::

:::sources
- Wikipedia, equi-marginal principle | https://en.wikipedia.org/wiki/Equi-marginal_principle
- Wikipedia, diminishing returns | https://en.wikipedia.org/wiki/Diminishing_returns
:::
