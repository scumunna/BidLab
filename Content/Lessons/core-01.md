---
id: core-01
track: core
module: 1
title: The ecosystem
summary: Identify every party in the programmatic supply chain and trace how a dollar and an impression move through it.
---
# The cast of characters

Programmatic advertising is a marketplace with a fixed set of roles. On the demand side sits the advertiser (the brand that wants to reach people) and often an agency that plans and runs campaigns on the advertiser's behalf. They buy through a demand-side platform (DSP), software that bids on individual ad impressions across the open web.

On the supply side sits the publisher (the app or site with content and audience) and the ad server that decides which ad to show. Publishers expose their inventory through a supply-side platform (SSP), software that packages impressions and runs them through an ad exchange, the marketplace where DSPs and SSPs meet to transact.

:::figure supplyChain
caption: The fixed cast of programmatic. Demand-side parties buy through a DSP, supply-side parties sell through an SSP, and the ad exchange in the middle matches their bids to inventory.
:::

# Data layers

Two kinds of data systems wrap around the buy. A data management platform (DMP) stores and segments audience signals, traditionally third-party data, into targetable groups. A customer data platform (CDP) unifies a brand's own first-party data (purchases, site visits, CRM records) into durable profiles.

As third-party signals decline, the CDP has become the more strategic of the two. First-party data is consented, owned by the brand, and harder for competitors to replicate.

:::widget donutChart
title: Where the strategic weight has shifted (illustrative)
labels: First-party (CDP), Third-party (DMP)
data: 70, 30
:::

:::callout key
Demand side buys, supply side sells, the exchange matches them, and data platforms decide who is worth bidding on. Almost every other tool is a variation on one of these roles.
:::

# The flow of a dollar and an impression

The two flows move in opposite directions. An impression travels from publisher to SSP to exchange to DSP, where a winning bid sends a creative back the same path to render on the page. A dollar moves the other way: the advertiser pays the agency or DSP, fees are taken at each hop (the ad tech tax), and what remains reaches the publisher.

$$ Publisher_{revenue} = Advertiser_{spend} \times (1 - tax) $$

The take rate at each intermediary compounds. If a DSP, an exchange, and an SSP each keep 15 percent, the publisher nets roughly 0.85 times 0.85 times 0.85, about 61 cents on the dollar. Supply path optimization exists to shorten this chain and recover some of that loss.

:::widget codeLab
:::

:::callout insight
Every intermediary you add takes a margin. Fewer, cleaner hops between buyer and seller mean more of the budget actually buys media.
:::

:::quiz
question: Which party runs the auction logic that matches DSP bids to publisher inventory?
- The ad exchange
- The data management platform
- The customer data platform
- The creative agency
answer: 0
explain: The ad exchange is the marketplace that receives bids from DSPs and inventory from SSPs and selects a winner. DMPs and CDPs supply audience data but do not run the auction.
:::

:::sources
- IAB, International Report on Programmatic In-Housing | https://www.iab.com/insights/2020-international-report-on-programmatic-in-housing/
- IAB Tech Lab, OpenRTB and Supply Chain Standards | https://iabtechlab.com/standards/openrtb/
:::
