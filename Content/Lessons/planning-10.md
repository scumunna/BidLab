---
id: planning-10
track: planning
module: 10
title: Incrementality and MMM
summary: The intuition behind marketing mix modeling: adstock, saturation, and decomposing sales into drivers.
---
# What MMM is doing

Marketing mix modeling fits a regression that explains a sales series using spend across channels plus baseline factors like price, seasonality, and promotions. The goal is decomposition: splitting total sales into the share each driver is responsible for, so you can see what media actually contributed on top of the baseline that would have sold anyway.

The incremental part is the key word. Some sales happen with zero media because of brand, distribution, and demand. MMM estimates that baseline, then attributes the rest to the drivers, which is why the model only earns its keep if it handles the two ways media behaves over time and over spend.

:::widget donutChart
title: MMM sales decomposition (illustrative typical shares)
data: Baseline 60, Search 12, Social 10, Video 9, Display 5, Promotions 4
:::

# Two transformations make it real

Raw spend is the wrong input, because media does not work linearly or instantly. Two transforms fix that before the spend ever enters the regression.

Adstock handles carryover: a week of spend keeps influencing sales for several weeks, decaying by a factor $\theta$ each period. Saturation handles diminishing returns: doubling adstocked spend does not double effect, because audiences and attention are finite. Apply adstock, then saturation, then let the model estimate each channel's coefficient on the transformed input.

$$ a_t = x_t + \theta\, a_{t-1} $$

:::callout insight
Without adstock and saturation, MMM would read every channel as linear and instant, which is false. The transforms are what let a single coefficient stand in for a curved, delayed effect, and they are where most of the modeling judgment lives.
:::

:::predict
prompt: With adstock a_t = x_t + theta times a_(t-1) and decay theta = 0.6, last week's adstock was 50 and this week's raw spend is 100 (same units). What is this week's adstocked spend a_t that enters the regression?
answer: 130
unit: units
hint: Add this week's raw spend to theta times last week's adstock.
explain: a_t = 100 + 0.6 x 50 = 100 + 30 = 130. The carried-over 30 is why the model sees more than the 100 spent this week, encoding the tail from prior spend.
:::

# Try it

Adjust the decay rate and watch a single spend burst stretch into a tail across later periods. A high decay keeps the effect alive for weeks. A low decay means the impact lands and fades fast, which changes how you would time and pace the buy.

:::widget adstockExplorer
:::

:::callout warning
MMM is correlational. It can confuse a channel that always runs during your busy season with a channel that causes the busy season. Validate the headline channels with a geo holdout, then recalibrate the model so its decomposition reflects real causal lift.
:::

:::quiz
question: In MMM, why is raw weekly spend transformed by adstock before entering the model?
- To capture that media keeps affecting sales in later weeks
- To convert spend into impressions
- To remove seasonality from sales
- To force a linear relationship with sales
answer: 0
explain: Adstock encodes carryover, the fact that a spend burst keeps driving sales after the week it ran. The decay rate controls how long that tail persists.
:::

:::sources
- Meta Robyn, marketing mix modeling features | https://facebookexperimental.github.io/Robyn/docs/features/
- Google Meridian, media saturation and lagging | https://developers.google.com/meridian/docs/advanced-modeling/media-saturation-lagging
:::
