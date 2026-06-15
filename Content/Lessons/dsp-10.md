---
id: dsp-10
track: dsp
module: 10
title: Fraud, viewability, and supply-path optimization
summary: How invalid traffic and unviewable impressions destroy value, and how a trader prices the real cost of a supply path.
---
# Not every impression is real

You bid on an opportunity assuming a human might see your ad. Invalid traffic (IVT) breaks that assumption. IVT is any activity that does not represent a legitimate human chance to view, from simple bots and crawlers (general IVT) to deliberate fraud like hidden ads and spoofed domains (sophisticated IVT). Paying for IVT is paying for nothing.

The honest cost of any impression is its nominal price adjusted for how much of it is real. If 10% of a path's traffic is invalid, your effective price per valid impression is the CPM divided by 0.9. A cheap path with high fraud can cost more per real human than a pricier clean one.

$$ CPM_{valid} = CPM / (1 - IVT) $$

:::callout warning
A low CPM is not a low price if part of the inventory is fake or unviewable. Always reprice on the impressions that actually reach a human and can be seen.
:::

:::predict
prompt: A supply path quotes a $3.00 CPM, but 25 percent of its traffic is invalid (IVT). What is the effective CPM per valid impression?
answer: 4
unit: $
tolerance: 0.01
hint: Divide the quoted CPM by the share of traffic that is valid, which is 1 minus the IVT rate.
explain: Valid share = 1 - 0.25 = 0.75, so CPM_valid = $3.00 / 0.75 = $4.00. A quarter of the traffic is junk, so each real impression costs a third more than the sticker price.
:::

# Viewability is a measured threshold

An impression can be valid and still never appear on screen. The Media Rating Council (MRC) viewability standard draws a hard line: at least 50% of the ad's pixels in view for at least one continuous second for display, or two continuous seconds for video. Below that threshold, the impression counts as served but not viewable.

Viewability stacks with IVT, because both shrink the pool of impressions worth paying for. Multiply the two rates, (1 minus IVT) times the viewable rate, to get the share of bought impressions that are both real and seeable. That share is what you should price against.

:::callout key
Filter IVT before measuring viewability. A viewability rate computed on unfiltered traffic is inflated, because bots and rendered-but-unseen impressions distort the denominator.
:::

:::predict
prompt: A path runs 10 percent IVT and, after filtering, a 70 percent viewable rate. What share of bought impressions are both real and viewable?
answer: 63
unit: %
tolerance: 0.5
hint: Multiply the valid share (1 minus IVT) by the viewable rate.
explain: Real-and-seeable share = (1 - 0.10) x 0.70 = 0.90 x 0.70 = 0.63, or 63 percent. Only that 63 percent is worth paying for, so price against it, not the raw impression count.
:::

# Supply-path optimization

The same impression is often available through several routes: a direct seller, a reseller, a chain of intermediaries. Each path adds fees, latency, and risk, and some carry far more IVT or unauthorized selling than others. Supply-path optimization (SPO) is the practice of routing spend through the cleanest, shortest, cheapest paths and cutting the rest.

SPO is a ranking problem. For each path, combine its take rate, its IVT level, and its viewability into one effective cost per quality impression, then consolidate spend toward the best paths. Tools like ads.txt and the SupplyChain object (schain) help verify that the seller in the chain is authorized, which is the first filter before you even price the path.

:::widget yieldExplorer
:::

:::quiz
question: Path A is a 2.00 CPM with 20% IVT. Path B is a 2.20 CPM with 0% IVT. Which is cheaper per valid impression?
- Path B, because A's valid CPM is 2.50 versus B's 2.20
- Path A, because its CPM is lower
- They are equal once you round
- Cannot tell without viewability
answer: 0
explain: Path A's valid CPM is 2.00 divided by 0.8, which is 2.50. Path B has no IVT, so its valid CPM stays 2.20. The clean path is cheaper per real impression despite the higher sticker price.
:::

:::sources
- MRC Viewable Ad Impression Measurement Guidelines | https://mediaratingcouncil.org/standards-and-guidelines
- IAB Tech Lab, ads.txt and Supply Chain Object | https://iabtechlab.com/ads-txt/
:::
