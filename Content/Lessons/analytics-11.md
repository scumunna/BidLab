---
id: analytics-11
track: analytics
module: 11
title: Marketing mix modeling
summary: How regression with adstock and saturation decomposes sales into channel contributions and estimates ROI per channel.
---
# Explaining sales from spend

Marketing mix modeling (MMM) regresses an outcome like weekly sales on media spend across channels plus controls for price, seasonality, and promotions. It uses aggregate time-series data, so it needs no user-level tracking and survives the loss of cookies. The payoff is a decomposition: how much of sales each channel drove, and the marginal ROI of the next dollar.

A raw regression of sales on spend is naive, because advertising does not act instantly or linearly. Two transformations fix that before the spend enters the model: adstock for timing and saturation for diminishing returns.

:::quiz
question: Why does marketing mix modeling keep working even after third-party cookies and user-level tracking disappear?
- It regresses aggregate time-series data (weekly sales versus spend), so it needs no user-level identifiers
- It secretly reconstructs user identities from spend
- It only works for channels that still have cookies
- It requires a clean room to join user records
hint: MMM operates on totals over time, not on individual user journeys. What does that free it from?
answer: 0
explain: MMM fits aggregate series (such as weekly sales on channel spend plus controls), never touching individual users. That is exactly why it survives the loss of cookies and cross-site identifiers that break user-level attribution.
:::

# Adstock and saturation

Adstock captures carryover. An ad seen this week still influences purchases next week, decaying over time. Geometric adstock applies a retention rate to last period's adstock and adds this period's spend, written as `A_t = S_t + lambda * A_{t-1}`. Retention runs high for brand TV and video (often 0.4 to 0.8) and low for paid search (often 0.1 to 0.3).

Saturation captures diminishing returns. Doubling spend never doubles response once an audience is saturated. The Hill function is a common shape, where K is the half-saturation point and the exponent sets steepness.

$$ R(x) = x^{\alpha} / (K^{\alpha} + x^{\alpha}) $$

:::widget adstockExplorer
:::

# Decomposition and ROI

After fitting, the model decomposes each period's sales into a baseline (what would sell with zero media) plus a contribution per channel. Channel ROI is that channel's incremental contribution divided by its spend, and marginal ROI is the slope of the saturation curve at the current spend level.

Marginal ROI is what guides reallocation. A channel below its half-saturation point sits on a steep curve with high marginal return, so shift budget toward it. A channel past saturation sits on a flat curve, so the next dollar there is nearly wasted. Modern MMM is usually Bayesian, placing priors on ROI, adstock, and saturation so the fit stays sane on noisy aggregate data.

:::callout key
Average ROI and marginal ROI differ. A channel can show a strong average ROI yet a weak marginal ROI because it is already saturated. Allocate on the margin, not the average.
:::

:::quiz
question: A channel has high average ROI but its saturation curve is nearly flat at the current spend. Should you add budget there?
- No, the flat curve means low marginal ROI, so the next dollar returns little
- Yes, high average ROI always justifies more spend
- Yes, because saturation increases returns
- It does not matter, ROI is constant
answer: 0
explain: A flat saturation curve means the channel is near its ceiling, so marginal ROI is low even when average ROI looks strong. Reallocation decisions depend on the marginal return.
:::

:::sources
- Google, Meridian open-source marketing mix modeling | https://developers.google.com/meridian
- Jin, Wang, Sun, Bayesian Methods for Media Mix Modeling with Carryover and Shape Effects | https://research.google/pubs/pub46001/
:::
