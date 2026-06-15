---
id: planning-13
track: planning
module: 13
title: Attention metrics and attention-adjusted CPM
summary: Why viewability is not engagement, how to price media on attentive seconds with aCPM and APM, and what the IAB and MRC attention standard changed.
---
# Viewability says rendered, not watched

Viewability is a low bar: a display ad counts as viewable when 50% of its pixels are on screen for at least one second, two seconds for video. That confirms the ad rendered, not that anyone looked at it. Industry research suggests that only about 30% of viewable digital ads are actually looked at, implying most spend lands on impressions that technically render but capture no real attention (eMarketer; treat the 30% as a directional research figure, not a hard constant). Attention metrics try to measure the thing viewability skips: whether a human actually engaged.

:::figure ctvAd
caption: A connected-TV ad can be fully viewable yet ignored. Viewability confirms the pixels rendered; attention asks whether anyone watched.
:::

# Pricing media on attentive seconds

The fix is to price on attention, not impressions. Attention-adjusted CPM, or aCPM, divides cost by the total attentive seconds a buy delivered, scaled to a thousand. It is the cost of one thousand attentive seconds.

$$ aCPM = \frac{Cost}{Total\ Attentive\ Seconds} \times 1000 $$

A related metric, attention per mille (APM), works the other way: it reports the attentive seconds delivered per thousand impressions, so a placement's quality can be compared independent of price.

$$ APM = \frac{Total\ Attentive\ Seconds}{Impressions} \times 1000 $$

:::predict
prompt: A campaign costs $5,000 and delivers 250,000 total attentive seconds. What is its attention-adjusted CPM (cost per 1,000 attentive seconds)?
answer: 20
unit: $
hint: Divide cost by total attentive seconds, then multiply by 1,000.
explain: aCPM = $5,000 / 250,000 x 1,000 = $20 per 1,000 attentive seconds. Unlike a standard CPM, this price reflects attention actually delivered, not impressions served.
:::

# Total attentive seconds is the input that matters

Attentive seconds are not handed to you, you build them from impressions and the average attention each impression earns. Multiply impressions by the average attentive seconds per impression to get the denominator both aCPM and APM depend on.

$$ Total\ Attentive\ Seconds = Impressions \times Avg\ Attentive\ Seconds\ per\ Impression $$

:::predict
prompt: A placement serves 800,000 impressions, each earning an average of 2.5 attentive seconds. The buy costs $10,000. What is the aCPM?
answer: 5
unit: $
tolerance: 0.05
hint: First compute total attentive seconds (impressions times average seconds), then apply the aCPM formula.
explain: Total attentive seconds = 800,000 x 2.5 = 2,000,000. aCPM = $10,000 / 2,000,000 x 1,000 = $5 per 1,000 attentive seconds.
:::

# A high CPM can be the cheaper attention buy

Because aCPM is denominated in attention, a placement with a higher sticker CPM can be cheaper per attentive second, and an 80%-viewable placement can score poorly on attention if each impression earns almost no attentive time. Made-for-advertising sites are the cautionary case: they post roughly 77% viewability while charging CPMs 30 to 40% below market, yet flood pages with units that earn little real attention (Adelaide). Compare buys on aCPM, not CPM.

:::widget pricingCalculator
metric: attention-adjusted CPM
note: Hold cost fixed and vary attentive seconds per impression to see how two placements with the same CPM can have very different aCPM.
:::

:::predict
prompt: Placement A has a $8 CPM and delivers 1.0 attentive second per impression. Placement B has a $12 CPM and delivers 4.0 attentive seconds per impression. What is Placement B's aCPM (cost per 1,000 attentive seconds)?
answer: 3
unit: $
tolerance: 0.05
hint: A $12 CPM buys 1,000 impressions for $12. At 4.0 attentive seconds each, those 1,000 impressions yield 4,000 attentive seconds.
explain: 1,000 impressions cost $12 and deliver 1,000 x 4.0 = 4,000 attentive seconds. aCPM = $12 / 4,000 x 1,000 = $3. Placement A's aCPM is $8 / 1,000 x 1,000 = $8, so B is the cheaper attention buy despite the higher CPM.
:::

# The first cross-vendor standard

For years every attention vendor scored differently, so numbers could not be compared across providers. In November 2025 the IAB and MRC released their Attention Measurement Guidelines, the industry's first standardized framework, developed with input from more than 200 experts across brands, agencies, publishers, and measurement companies (eMarketer). The guidelines define methodology categories such as data-signal, visual and audio tracking, physiological, and survey-based, which finally lets buyers compare attention scores on common ground rather than vendor by vendor.

:::quiz
question: Placement A is 80% viewable but earns 0.5 attentive seconds per impression. Placement B is 60% viewable but earns 3.0 attentive seconds per impression. Why might B be the better buy at equal CPM?
- B delivers far more attentive seconds per impression, so its cost per attentive second is much lower
- A is always better because higher viewability guarantees more attention
- Viewability and attention are the same metric, so A and B are equivalent
- B must be cheaper because lower viewability always means a lower CPM
hint: Viewability confirms the ad rendered; attention measures engaged time. Which one drives aCPM?
answer: 0
explain: aCPM is priced on attentive seconds, not pixels rendered. At equal CPM, B's 3.0 attentive seconds per impression beat A's 0.5, so B costs far less per attentive second despite lower viewability. High viewability does not guarantee attention.
:::

:::sources
- FAQ on Attention Metrics, eMarketer | https://www.emarketer.com/content/faq-on-attention-metrics-how-advertisers-turn-attention-performance
- Attention Metrics vs Viewability vs Duration, Adelaide | https://www.adelaidemetrics.com/blog/attention-metrics-vs-viewability-vs-duration
:::
