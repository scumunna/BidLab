---
id: core-04
track: core
module: 4
title: Pricing models
summary: Choose the right buying unit (CPM, CPC, CPA, and their cousins) and convert between them with confidence.
---
# Paying per impression

The base currency of programmatic is the impression, and the base price is the CPM, the cost per thousand impressions (the M is the Roman numeral for one thousand). A CPM of 5 dollars means a thousand impressions cost 5 dollars, so each impression costs half a cent.

CPM is the natural unit because the auction sells impressions. The buyer takes on all the risk of whether those impressions turn into clicks or sales. It is the standard for awareness and reach campaigns where the impression itself is the goal.

:::predict
prompt: A reach campaign spends 12,000 dollars and delivers 1,500,000 impressions. What CPM did it pay?
answer: 8
unit: $
tolerance: 0.01
hint: CPM is total cost divided by impressions, times 1,000.
explain: CPM = (12,000 / 1,500,000) x 1,000 = 0.008 x 1,000 = 8 dollars. Each impression cost 0.8 cents, and the CPM just expresses that per-impression price per thousand.
:::

# Paying for actions further down the funnel

Other models shift risk toward the seller by pricing later events. CPC (cost per click) charges only when someone clicks. CPA (cost per acquisition) charges only on a conversion such as a purchase or signup. Both convert back to an effective CPM once you know the rates that connect impressions to those events.

$$ eCPM = CPC \times CTR \times 1000 $$

The same logic chains further. To get an effective CPM from a CPA, multiply the CPA by the click-through rate and the conversion rate, then by a thousand. Every model is ultimately comparable in CPM terms, which is how buyers evaluate offers on one scale.

:::widget pricingCalculator
:::

# Video and viewable variants

Video has its own units. CPV (cost per view) charges per view, where a platform defines what counts as a view. CPCV (cost per completed view) charges only when the viewer watches the whole ad, which suits brand video where completion signals real attention.

Two more adjust the impression itself. vCPM (viewable CPM) charges per thousand viewable impressions, so you only pay when the ad actually had a chance to be seen. dCPM (dynamic CPM) lets the price float per impression based on its predicted value, rather than locking one flat rate.

:::callout key
Pick the model that matches your goal and your risk tolerance. CPM buys reach and puts risk on the buyer. CPA buys outcomes and puts risk on the seller, who therefore charges more per event.
:::

:::callout insight
You can always translate any pricing model into an effective CPM. That common denominator lets you compare a CPC deal, a CPA deal, and a flat CPM buy on a single axis.
:::

:::quiz
question: A campaign runs at a 4 dollar CPC with a 2 percent click-through rate. What is the effective CPM?
- 80 dollars
- 8 dollars
- 0.80 dollars
- 200 dollars
answer: 0
explain: eCPM equals CPC times CTR times 1000. That is 4 times 0.02 times 1000, which equals 80 dollars per thousand impressions.
:::

:::sources
- Google Ads Help, How CPM, CPC, and CPA Bidding Work | https://support.google.com/google-ads/answer/2472725
- IAB, glossary of terminology | https://www.iab.com/insights/glossary-of-terminology/
:::
