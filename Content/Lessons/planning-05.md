---
id: planning-05
track: planning
module: 5
title: GRPs and TRPs
summary: The rating-point currency that ties TV planning to digital reach and frequency, and how to translate between them.
---
# The TV currency

Television planners buy in gross rating points (GRPs). One GRP is one percent of the target population reached one time. The clean property is that GRPs are just reach times frequency, with reach expressed as a percent of the population. Buy 50 percent reach at an average frequency of 4 and you have bought 200 GRPs.

$$ GRP = reach\% \times frequency $$

Because reach is capped at 100, the only way past 100 GRPs is frequency. A campaign at 300 GRPs that reached 60 percent of people did so at an average frequency of 5. GRPs alone hide that split, which is why planners always carry reach and frequency alongside the GRP total.

:::callout key
GRPs are not people and not impressions. They are a percent-of-population currency. The same 200 GRPs can mean broad and thin (80 reach, 2.5 frequency) or narrow and heavy (40 reach, 5 frequency).
:::

:::predict
prompt: A TV campaign reaches 60 percent of the population at an average frequency of 5. How many GRPs is that?
answer: 300
unit: GRPs
hint: GRPs are reach as a percent of population times average frequency.
explain: GRP = reach percent x frequency = 60 x 5 = 300 GRPs. Reach is capped at 100, so anything above 100 GRPs is bought with frequency, here a frequency of 5.
:::

# Target rating points

A GRP counts against the whole measured population, including people you do not care about. Target rating points (TRPs) count only against your target, $TRP = impressions\_to\_target / target\_population \times 100$. If your target is adults 25 to 54 and a spot also hits kids and retirees, the GRP credits all of it while the TRP credits only the slice inside your target.

TRPs are always less than or equal to GRPs for the same buy, because the target is a subset of the total. The ratio of TRPs to GRPs measures how well the placement concentrates on your audience. A high ratio means efficient targeting, a low ratio means you are paying for reach you did not want.

:::callout insight
Two buys can deliver identical GRPs and very different TRPs. The one with more TRPs put more of its weight on your actual target, so it is the better buy even though the headline GRP number is the same.
:::

:::predict
prompt: A buy delivers 3,000,000 impressions to a target population of 2,000,000 adults 25 to 54. How many TRPs is that?
answer: 150
unit: TRPs
hint: TRPs are impressions delivered to the target divided by the target population, times 100.
explain: TRP = 3,000,000 / 2,000,000 x 100 = 150 TRPs. That is an average frequency of 1.5 against the target, since each target person was reached 1.5 times on average.
:::

# Crossing into digital

Digital has its own native units, impressions, unique reach, and frequency, but rating points bridge the two so a planner can compare a TV buy and a programmatic buy on one scale. Divide impressions delivered to the target by the target population, in hundreds, and you get TRPs from a digital campaign too.

:::widget reachFrequency
population: 1000000
:::

This bridge powers cross-media planning, where TV and digital are bought against one combined reach goal. The catch is deduplication. A person reached on both TV and digital is one reached person, so you cannot just add the two rating-point totals without removing the overlap first.

:::quiz
question: A campaign delivers 45 percent reach of the target at an average frequency of 6. How many TRPs is that?
- 270
- 51
- 7.5
- 51 percent
answer: 0
explain: Rating points are reach percent times frequency, so 45 times 6 equals 270. Against a target population these are TRPs rather than GRPs.
:::

:::sources
- Adjust, What are target rating points (TRPs)? | https://www.adjust.com/glossary/target-rating-points/
- Adjust, What is a gross rating point (GRP)? | https://www.adjust.com/glossary/gross-rating-point-grp/
:::
