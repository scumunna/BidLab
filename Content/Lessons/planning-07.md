---
id: planning-07
track: planning
module: 7
title: Cross-channel media mix
summary: How to split a fixed budget across channels so the last dollar in each one buys the same value.
---
# The media-mix problem

You have one budget and several channels: display, social, video, search, audio. Each channel turns spend into outcomes at a different rate, and each one slows down as you push more money through it. The question is not which channel is best on average. It is how much to put in each one so the total outcome is as large as the budget allows.

Average return hides the answer. A channel can look great on average while its next dollar barely moves the needle, because the cheap, easy outcomes were bought first. What matters for allocation is the marginal return, the outcome you get from the very next dollar.

:::callout key
Allocate on marginal return, not average return. Average return tells you how a channel did. Marginal return tells you what the next dollar will do, which is the only thing a budget decision can change.
:::

:::widget barChart
title: A budget split across channels (illustrative typical mix)
xLabel: Channel
yLabel: Budget share (%)
data: Display 20, Social 25, Video 20, Search 25, Audio 10
:::

# The equal-marginal rule

Suppose channel i returns outcome $r_i(s_i)$ from spend $s_i$, and the curves bend (diminishing returns). To maximize total outcome under a fixed budget B, shift money from any channel with a low marginal return to any channel with a higher one. You stop when no such move helps, which is exactly when every funded channel has the same marginal return.

$$ dr_1 / ds_1 = dr_2 / ds_2 = \cdots = \lambda, \quad \Sigma\, s_i = B $$

Here $\lambda$ is the shared marginal value of a dollar at the optimum. Read it as a price: at the best allocation, every channel is delivering its next unit of outcome at the same cost. Channels whose marginal return never reaches $\lambda$ get nothing.

:::predict
prompt: A $4,500 budget splits across two channels. Channel A has marginal return MR = 8 - (spend / 500) and channel B has MR = 8 - (spend / 250), spend in dollars. At the optimum both marginal returns are equal. How many dollars go to channel A?
answer: 3000
unit: $
tolerance: 50
hint: Set the two marginal returns equal to find that channel A spend is twice channel B spend, then use that they sum to 4,500.
explain: Equal marginal return requires s_A/500 = s_B/250, so s_A = 2 s_B. With s_A + s_B = 4,500 that gives s_A = 3,000 and s_B = 1,500, and both channels return a marginal 2.0.
:::

# Try it

Move budget between channels and watch total outcome. Push too much into one channel and its curve flattens, so the same dollar would have done more elsewhere. The peak sits where the slopes line up.

:::widget budgetAllocator
:::

:::callout insight
The optimum is rarely all-in on the single best channel. Diminishing returns drag that channel's marginal value down until a second, then a third channel becomes the better home for the next dollar.
:::

:::quiz
question: Two channels are funded at the optimal mix under a fixed budget. What is true at that point?
- The next dollar in each channel buys the same incremental outcome
- Both channels have the same average return
- All budget sits in the higher-average channel
- The cheaper channel by CPM gets everything
answer: 0
explain: Under diminishing returns the optimum equalizes marginal return across funded channels. If one channel's next dollar bought more, you would move budget there until the slopes matched.
:::

:::sources
- Measured, media mix modeling and diminishing-return curves | https://www.measured.com/faq/media-mix-modeling-diminishing-return-curves-mmm-budget-decision/
- Towards Data Science, optimizing budget in marketing mix modeling | https://towardsdatascience.com/practical-approaches-to-optimizng-budget-in-marketing-mix-modeling-7816a27f2f71/
:::
