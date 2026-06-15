---
id: core-07
track: core
module: 7
title: Retail media and incremental ROAS
summary: Why reported ROAS overstates value, the identity that ties it to iROAS, and how ACoS, TACoS, and geo holdouts measure the real lift.
---
# The fastest-growing line item in media

Retail media networks let brands buy ads inside the retailer's own site and app, right where the purchase happens, sold against first-party transaction data. US retail media ad spend reached $60.32B in 2025 and is forecast at $71.09B in 2026, roughly 18% growth (eMarketer, Dec 2025). The pitch is closed-loop attribution: the retailer sees the ad and the checkout in the same deterministic data, so it can tie a specific click to a specific purchase (Osmos). That is cleaner than the modeled attribution of the open web, but cleaner is not the same as causal.

:::figure displayAd
caption: A sponsored on-site placement intercepts a shopper at the moment of purchase intent. The attribution is exact, but exact attribution credits revenue it may not have caused.
:::

# ROAS reports correlation, iROAS reports cause

Return on ad spend divides attributed revenue by spend. Incremental ROAS divides only the lift, the revenue that would not have happened without the ad, by spend.

$$ ROAS = \frac{Attributed\ Revenue}{Ad\ Spend} $$

$$ iROAS = \frac{Incremental\ Revenue}{Ad\ Spend} $$

The gap between them is the organic baseline you paid to re-claim. Sponsored placements often intercept shoppers who were already going to buy, especially on branded keywords, so attributed revenue counts sales the ad merely captured rather than created.

:::callout key
ROAS equals iROAS only when baseline organic sales are zero. Whenever some shoppers would have bought without the ad, the baseline is positive and ROAS is strictly greater than iROAS. The wider the gap, the more organic demand the campaign is cannibalizing.
:::

:::predict
prompt: A campaign spends $200,000 and is reported at a 6.0x ROAS, so $1,200,000 in attributed revenue. A geo holdout shows that $700,000 of that revenue would have happened organically anyway. What is the true iROAS?
answer: 2.5
unit: x
tolerance: 0.05
hint: Incremental revenue is attributed revenue minus the organic baseline. Divide that by spend.
explain: Incremental = $1,200,000 - $700,000 = $500,000. iROAS = $500,000 / $200,000 = 2.5x, well below the 6.0x reported ROAS. The 3.5x gap is cannibalized organic demand.
:::

# ACoS and TACoS: the operating dials

Because sponsored placements run as a keyword CPC auction, the working metrics look like search. Advertising Cost of Sale (ACoS) is spend as a percent of attributed sales, the inverse of ROAS. Total Advertising Cost of Sale (TACoS) divides the same spend by total sales including organic, which makes it a brand-health gauge rather than a campaign dial.

$$ ACoS = \frac{Ad\ Spend}{Attributed\ Sales} \times 100 $$

$$ TACoS = \frac{Ad\ Spend}{Total\ Sales} \times 100 $$

Keep ACoS below your product margin so each advertised sale stays profitable. For an established product a healthy TACoS often sits in the 5 to 10% range (Perpetua), but treat that as a guidepost, not a hard target.

:::predict
prompt: A campaign spends $45,000 and drives $180,000 in attributed sales. What is the ACoS?
answer: 25
unit: %
hint: ACoS is ad spend divided by attributed sales, times 100.
explain: ACoS = $45,000 / $180,000 x 100 = 25%. If the product margin exceeds 25%, the advertised sales remain profitable.
:::

:::predict
prompt: That same $45,000 in spend sits alongside $750,000 in total sales across all channels. What is the TACoS?
answer: 6
unit: %
hint: TACoS uses total sales, not just the ad-attributed portion.
explain: TACoS = $45,000 / $750,000 x 100 = 6%, comfortably inside the 5 to 10% healthy band for an established product.
:::

# Measuring lift with a geo holdout

You cannot read incrementality off a dashboard, you have to design a test. The cleanest is a geo holdout: split comparable markets into a test group that sees the ads and a control group that does not, then scale the control baseline to the test group's size. Incremental revenue is test sales minus that scaled control baseline. Ghost-bid and PSA controls do the same thing at the impression level.

$$ Incremental\ Revenue = Sales_{test} - Sales_{control} $$

:::widget didExplorer
treatment: retail media on-site
metric: incremental revenue
note: Compare test-market sales against a scaled control baseline to isolate the lift the ads actually caused.
:::

:::predict
prompt: In a geo holdout, the test markets generate $880,000 in sales while the scaled control baseline is $610,000. What is the incremental revenue attributable to the campaign?
answer: 270000
unit: $
hint: Incremental revenue is test-group sales minus the scaled control-group baseline.
explain: Incremental = $880,000 - $610,000 = $270,000. Only this lift, not the full $880,000, should be divided by spend to compute iROAS.
:::

# When the best ROAS is the worst buy

Put it together and the verdict can flip. The highest-ROAS channel is frequently the one cannibalizing the most organic demand, because it sits closest to a purchase that was already going to happen. Upper-funnel and off-site placements that look weak on attributed ROAS often carry the real incremental load and a higher new-to-brand share. This is why incrementality testing reallocates budget instead of just reporting on it.

:::quiz
question: A retailer reports a 6.0x ROAS on a branded-keyword campaign, but a geo holdout shows iROAS of 1.4x. What is the most likely explanation?
- The ads mostly reached shoppers who would have purchased anyway, so attributed revenue overstates the lift
- The holdout test was run incorrectly and should be discarded
- ROAS and iROAS must always be equal, so one figure is a typo
- Branded keywords always deliver the highest incremental return
hint: Think about who searches a brand name, and whether the ad caused or merely captured the purchase.
answer: 0
explain: Branded-keyword shoppers are high intent and often convert without the ad. Closed-loop ROAS credits that organic revenue, so iROAS lands far below reported ROAS. The gap is cannibalization, not a measurement error.
:::

:::sources
- FAQ on Retail Media Networks, eMarketer | https://www.emarketer.com/content/faq-on-retail-media-networks-how-marketers-should-allocate-budgets-2026
- Closed-Loop Attribution, Osmos | https://www.osmos.ai/blog/closed-loop-attribution-the-key-to-unlocking-higher-roas
:::
