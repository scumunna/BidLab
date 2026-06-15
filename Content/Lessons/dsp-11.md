---
id: dsp-11
track: dsp
module: 11
title: Attribution and optimization loops
summary: How attribution assigns credit for conversions, and how a trader closes the loop to optimize toward CPA or ROAS.
---
# Who gets the credit

A person sees your display ad, then a video ad, then searches and converts. Attribution is the rule that decides which touch gets credit for that conversion. Last-touch attribution hands all the credit to the final touch before conversion. It is simple and auditable, but it systematically over-credits the closer and starves the upper funnel that created demand.

Multi-touch attribution (MTA) spreads credit across the path. It can be rule-based (linear, time-decay, position-based) or data-driven, where a model estimates each touch's marginal contribution from patterns across many converting and non-converting paths. Data-driven models need volume, often a few hundred conversions a month, or the platform falls back to a simpler rule.

:::callout insight
Last-touch is not wrong so much as biased. It rewards the channels closest to the sale, which is why retargeting always looks great under it and prospecting always looks weak.
:::

:::predict
prompt: A converting path has 4 touches and the conversion is worth $200. Under linear multi-touch attribution, how much credit does each touch receive?
answer: 50
unit: $
hint: Linear attribution splits the conversion value evenly across every touch on the path.
explain: Linear MTA gives each touch an equal share: $200 / 4 = $50. Unlike last-touch, the upper-funnel touches that opened the path get counted too.
:::

# The optimization loop

Attribution feeds the loop. The DSP records bids and wins, ties them to attributed conversions, and learns which signals predict conversion. It then adjusts bids and modifiers to chase the campaign goal, usually a target CPA (cost per acquisition) or a target ROAS (return on ad spend). The loop runs continuously: bid, observe, attribute, update.

$$ CPA = spend / conversions, \quad ROAS = revenue / spend $$

CPA and ROAS are two views of the same trade. Optimizing to a CPA cap means bidding only up to the point where expected cost per conversion stays under target. Optimizing to ROAS weights by conversion value, so a high-value conversion justifies a higher bid even at a worse CPA. The attribution rule decides which conversions the loop is even allowed to count.

:::widget attributionComparison
:::

# Explore, do not just exploit

A loop that always bids on what looks best today never learns whether something else is better. This is the explore-exploit tension. A multi-armed bandit frames each option (a segment, a placement, a creative) as an arm with an unknown payoff, and balances exploiting the current best against exploring uncertain arms that might be better.

Thompson sampling is a clean way to do this: keep a probability distribution over each arm's true conversion rate, draw a sample from each, and play the arm with the highest draw. Arms you are unsure about get tried often enough to learn; arms that prove weak get sampled less and fade. The result is a loop that converges on the best options without freezing out promising ones too early.

:::callout key
Change the attribution rule and you change what the optimizer chases. If credit shifts to the upper funnel, the loop starts bidding up prospecting. Attribution is not just reporting, it is the objective the machine optimizes.
:::

:::quiz
question: Why does a pure exploit strategy, always bidding on the current best segment, risk leaving performance on the table?
- It never gathers enough data on alternatives to discover a better segment
- It converges too slowly to a target CPA
- It violates the frequency cap
- It always over-credits the last touch
answer: 0
explain: Pure exploitation stops testing alternatives, so a genuinely better segment with little early data never gets the chance to prove itself. A bandit explores uncertain arms to avoid this trap.
:::

:::sources
- Google Ads Help, About attribution models | https://support.google.com/google-ads/answer/6259715
- Thompson sampling overview | https://en.wikipedia.org/wiki/Thompson_sampling
:::
