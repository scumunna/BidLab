---
id: planning-11
track: planning
module: 11
title: Scenario and sensitivity planning
summary: How to stress-test a media plan by varying inputs and ranking which assumptions actually move the result.
---
# A plan is a set of assumptions

Every media plan rests on numbers you do not fully know: a conversion rate, a CPM, a saturation point, a decay rate. A single forecast hides this by reporting one outcome as if it were certain. Scenario and sensitivity planning pull the uncertainty back into view, so you ship a plan you understand the failure modes of, not just a point estimate.

There are two distinct techniques and they answer different questions. Sensitivity analysis changes one input at a time to see how much the result moves. Scenario planning changes a whole coherent set of inputs at once to describe a believable future, like a recession or a CPM spike.

:::widget forecastExplorer
:::

# Sensitivity: which input matters

Sensitivity analysis takes each input, swings it across a plausible range, and measures the swing in the output while holding everything else fixed. Rank the inputs by how much they move the result and you get a tornado chart, widest bars on top. The point is focus: a plan can have twenty assumptions, but usually three or four drive most of the uncertainty.

$$ S_i \approx \Delta\,output / \Delta\,input_i $$

This sensitivity $S_i$ is just the size of the output change per unit change in input i. Large $S_i$ means the result is fragile to that input, so it deserves real data or a hedge. Small $S_i$ means you can stop arguing about it.

:::callout key
Sensitivity analysis tells you where to spend your certainty. Nail down the two or three high-sensitivity inputs with measurement, and stop polishing the assumptions that barely move the outcome.
:::

:::predict
prompt: You swing the conversion-rate assumption up by 0.5 percentage points and forecast conversions rise by 1,200. Using S = change in output divided by change in input, what is the sensitivity per percentage point of conversion rate?
answer: 2400
unit: conversions per point
hint: Divide the change in output by the change in the input, expressed per one percentage point.
explain: S = 1,200 / 0.5 = 2,400 conversions per percentage point. A large sensitivity means the forecast is fragile to this input, so it deserves real measurement rather than a guess.
:::

# Scenarios: coherent futures

Scenario planning bundles inputs into named cases: base, upside, downside. In the downside, CPMs rise and conversion rates fall together, because in a real slump they move together. Each scenario produces its own forecast, and the spread between them is your honest range of outcomes.

:::callout insight
Sensitivity comes first, scenarios second. You cannot build a meaningful downside case until you know which inputs the result is actually sensitive to. Otherwise you are just varying numbers that do not matter.
:::

:::widget barChart
title: Forecast conversions by scenario (illustrative typical cases)
xLabel: Scenario
yLabel: Forecast conversions
data: Downside 18000, Base 25000, Upside 31000
:::

# Try it

Shift spend and curve assumptions and watch the projected outcome respond. Steep response regions make the plan sensitive to spend, so small budget changes swing the result. Flat regions make it robust, where you can move money with little effect on the total.

:::widget budgetAllocator
:::

:::quiz
question: What is the purpose of a tornado chart in sensitivity analysis?
- To rank inputs by how much each one moves the output
- To show outcomes over time
- To compare channels by average ROI
- To display the budget split across channels
answer: 0
explain: A tornado chart orders inputs by the size of the output swing each one causes, widest bars on top, so you see at a glance which assumptions the plan is most fragile to.
:::

:::sources
- Farseer, scenario planning versus sensitivity analysis for FP&A | https://www.farseer.com/blog/scenario-planning-or-sensitivity-analysis/
- Finance Alliance, sensitivity analysis vs scenario analysis | https://www.financealliance.io/sensitivity-analysis-vs-scenario-analysis/
:::
