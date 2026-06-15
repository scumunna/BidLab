---
id: planning-03
track: planning
module: 3
title: Budget allocation
summary: Splitting a fixed budget across channels by chasing marginal return until the last dollar earns the same everywhere.
---
# The wrong question and the right one

Faced with a budget, the tempting question is "which channel has the best return?" That is the wrong question, because no channel keeps its return as you pour more into it. The right question is "where does the next dollar earn the most?" Average return tells you where you have been. Marginal return tells you where to put the next dollar.

The reason is diminishing returns. Every channel has a response curve that rises fast at first, when you are reaching fresh, high-intent people, then flattens as you saturate that pool. The first dollars in a channel are efficient. Later dollars buy frequency on people you already reached, so each one adds less.

:::callout insight
A channel with a great average ROI can still be the wrong place for your next dollar. If it is already saturated, its marginal return has collapsed even though its average still looks strong.
:::

:::widget responseCurve
:::

# The equimarginal principle

To maximize total return from a fixed budget, you shift money from channels with low marginal return to channels with high marginal return, and you keep shifting until they are equal. At that point no move can improve the total, because pulling a dollar from anywhere loses more than putting it anywhere else gains. This is the equimarginal principle.

$$ MR_1 = MR_2 = MR_3 = \dots = MR_n $$

Concretely, if search returns 1.2 on the marginal dollar and social returns 3.5, move budget from search to social. As you do, search recovers and social saturates, and the two marginal returns converge. The optimum is where they meet, not where either is highest alone.

:::callout key
The optimum equalizes marginal return, not spend and not average return. Equal budgets across channels is almost never optimal, because channels saturate at different rates.
:::

:::predict
prompt: A $8,000 budget splits across two channels. Search has marginal return MR = 10 - (spend / 1000) and social has MR = 6 - (spend / 1000), with spend in dollars. At the equimarginal optimum the two marginal returns are equal. How many dollars go to search?
answer: 6000
unit: $
tolerance: 50
hint: Set the two marginal returns equal and use that search spend plus social spend equals 8,000.
explain: Setting 10 - s/1000 = 6 - (8000 - s)/1000 gives s = 6,000 to search and 2,000 to social. Both then return a marginal 4.0, so no dollar can be moved to improve the total.
:::

# Allocate by hand

Drag budget between channels and watch total outcome rise as you balance the marginal returns, then fall again if you overcorrect. The peak is flat near the top, so being roughly balanced captures most of the gain.

:::widget budgetAllocator
:::

In practice you stop short of the textbook optimum because of constraints, minimum buys, brand-safety floors, and channels that cannot absorb more volume. The principle still guides you, move toward equal marginal return until a constraint stops you.

:::quiz
question: Search returns 4.0 on its next dollar and display returns 1.5 on its next dollar. What should you do?
- Move budget from display to search until their marginal returns converge
- Split the budget evenly between them
- Put everything into search permanently
- Move budget from search to display
answer: 0
explain: The next dollar earns more in search, so shift budget there. As search saturates and display recovers, the marginal returns move toward each other, and you stop when they meet.
:::

:::sources
- Measured, Media mix optimization and diminishing return curves | https://www.measured.com/faq/media-mix-modeling-diminishing-return-curves-mmm-budget-decision/
- Umbrex, The equimarginal principle in microeconomic theory | https://umbrex.com/resources/economics-concepts/microeconomic-theory/equimarginal-principle/
:::
