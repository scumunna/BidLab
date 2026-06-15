---
id: planning-12
track: planning
module: 12
title: "Capstone: build a media plan"
summary: Put the track together: set objectives, size the audience, allocate budget for maximum outcome, and plan measurement.
---
# The plan is one connected argument

A media plan is not a budget spreadsheet. It is an argument that flows from an objective to an allocation to a way of proving it worked. Each step constrains the next, and the math from this track is what keeps the steps honest. This capstone walks the full chain so you can build one end to end.

Four steps: state the objective, size the audience, allocate the budget, and plan the measurement. Skip any one and the plan breaks. An allocation with no objective optimizes nothing. An objective with no measurement plan can never be checked.

:::figure funnel
caption: The plan is one chain: a single objective sets the audience target, the audience sizing caps what the budget can deliver, the allocation maximizes the objective, and the measurement proves it. Each stage narrows and constrains the next.
:::

# Objective and audience

Start with a single primary objective stated as a number: reach a defined audience at a target frequency, or hit a cost per acquisition at a volume. One primary metric keeps every later trade-off decidable.

Then size the audience using the reach math from earlier. Reach has diminishing returns, so the impressions needed to hit the last slice of an audience climb steeply. This sets a realistic ceiling on what the budget can deliver and flags when the right move is to widen the audience rather than buy more frequency.

$$ reach = N\,(1 - e^{-impressions / N}) $$

:::predict
prompt: Your audience is N = 2,000,000 people and you plan 4,000,000 impressions at random. Using reach = N(1 - e^(-impressions/N)), about how many unique people do you reach?
answer: 1729329
unit: people
tolerance: 4000
hint: Here impressions divided by N equals 2, so reach is N times (1 minus e to the minus 2).
explain: reach = 2,000,000 x (1 - e^-2) = 2,000,000 x (1 - 0.135) = about 1,729,000, an 86 percent reach. The remaining 14 percent would cost heavy added frequency to reach, which often argues for widening the audience.
:::

# Allocate the budget

Split the budget across channels using the equal-marginal rule from the media-mix lesson. Move money toward higher marginal return until every funded channel's next dollar buys the same incremental outcome. Use response curves to forecast what each channel delivers at its planned spend, and check the forecast against the spend range you have actually observed.

:::callout key
The optimal mix equalizes marginal return across funded channels, not average return. The plan should be able to say, for every channel, what the next dollar buys and why that dollar is not better spent elsewhere.
:::

:::widget responseCurve
:::

# Try it

Allocate the budget across channels and read the total outcome. Find the mix where shifting a dollar in any direction lowers the total. That balance point, where the slopes line up, is the plan you defend.

:::widget budgetAllocator
:::

# Plan the measurement

Decide how you will know it worked before you spend. Use MMM for the strategic split across all channels, MTA for granular path detail where you have it, and a geo holdout to get causal ground truth on the channels carrying the most budget. Size the holdout with a power calculation so the test can actually read the lift you expect.

:::callout warning
A media plan with no measurement plan is untestable. Decide the holdout, the metric, and the power up front. If you cannot size a test to read the lift, scope the objective down to something you can prove.
:::

:::quiz
question: Across the full plan, what links audience sizing, budget allocation, and measurement together?
- A single stated objective that every step is optimized and checked against
- The largest available budget
- The channel with the best average ROI
- The platform's default attribution report
answer: 0
explain: One primary objective makes every trade-off decidable: it sets the audience target, defines what the allocation maximizes, and gives the measurement plan the lift it must detect.
:::

:::sources
- Interactive Advertising Bureau, measurement guidelines | https://www.iab.com/guidelines/
- Measured, media mix modeling and diminishing-return curves | https://www.measured.com/faq/media-mix-modeling-diminishing-return-curves-mmm-budget-decision/
:::
