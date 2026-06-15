---
id: core-05
track: core
module: 5
title: Measurement
summary: Read the core campaign metrics and tell the difference between activity, attribution, and true causal lift.
---
# Counting what happened

The most basic metric is the impression, a rendered ad. But a rendered ad is not always a seen ad, so the industry counts viewable impressions separately. The Media Rating Council (MRC) standard counts a display ad as viewable when at least 50 percent of its pixels are in view for at least 1 second, and a video ad when 50 percent is in view for at least 2 seconds.

From there, two rate metrics describe engagement. CTR (click-through rate) is clicks divided by impressions. CVR (conversion rate) is conversions divided by clicks (or sometimes impressions). Both are simple ratios, and both are easy to misread if the denominator is the wrong population.

$$ \text{CTR} = \frac{\text{clicks}}{\text{impressions}} \quad \text{CVR} = \frac{\text{conversions}}{\text{clicks}} $$

:::predict
prompt: A campaign serves 800,000 rendered impressions, of which 560,000 met the MRC viewability standard. What is the viewable share?
answer: 70
unit: %
tolerance: 0.1
hint: Viewable share is viewable impressions divided by rendered impressions, times 100.
explain: Viewable share = 560,000 / 800,000 x 100 = 70%. The other 30% rendered but never had a real chance to be seen, which is why buyers separate rendered from viewable counts.
:::

# Attribution

Attribution assigns credit for a conversion to the ads that preceded it. The simplest rule is last-touch, which gives all the credit to the final ad before the conversion. It is easy to compute but systematically overcredits whatever sits closest to the sale, often retargeting.

Data-driven attribution distributes credit across touchpoints using a model fit to real conversion paths. It is fairer than last-touch, but it still only divides up conversions that happened. It cannot tell you whether the ad caused any of them.

:::widget funnelExplorer
:::

# Incrementality and brand lift

To measure cause you need a control group. Incrementality testing holds out a randomized group that does not see the ad, then compares conversion rates. The difference is incremental lift, the conversions the campaign actually caused rather than ones that would have happened anyway.

Brand lift applies the same logic to perception. You survey an exposed group and a control group on metrics like awareness or favorability and measure the gap. Both methods answer the question attribution cannot: did the advertising change behavior?

:::callout warning
A conversion that follows an ad is not proof the ad caused it. Many of those people would have converted regardless. Only a holdout test separates real incremental lift from credit for the inevitable.
:::

:::callout insight
Attribution divides credit among the conversions you already got. Incrementality measures how many of those conversions you would not have gotten without the spend. The second number is the one tied to profit.
:::

:::quiz
question: Why can data-driven attribution still mislead a marketer?
- It only redistributes conversions that occurred and cannot prove the ad caused them
- It always assigns all credit to the last touchpoint
- It requires a randomized control group to compute
- It measures brand favorability rather than conversions
answer: 0
explain: Attribution models, even sophisticated ones, divide credit among conversions that happened. They do not include a control group, so they cannot isolate causal lift the way an incrementality test does.
:::

:::sources
- MRC, standards and guidelines (Viewable Ad Impression Measurement Guidelines) | https://mediaratingcouncil.org/standards-and-guidelines
- The Trade Desk, the Resource Desk (measurement and incrementality resources) | https://www.thetradedesk.com/resources
:::
