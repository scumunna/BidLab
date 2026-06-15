---
id: dsp-01
track: dsp
module: 1
title: The bid landscape
summary: Understand the buyer's seat in programmatic and read the anatomy of an OpenRTB bid request.
---
# The buyer's seat

As a trader you sit on the demand side. Your job is to turn an advertiser's budget into impressions that move a business metric. You do not buy media by hand. You configure a demand-side platform (DSP) to bid for you, millions of times a day, in real-time auctions.

The chain of value runs in one direction. An advertiser hires you, you operate a DSP, the DSP connects to ad exchanges, exchanges sit on top of supply-side platforms (SSPs), and SSPs represent publishers who have inventory to sell. Money flows from advertiser to publisher, and an impression flows back the other way.

:::figure supplyChain
caption: The programmatic supply chain, from advertiser budget through the DSP, exchange, and SSP to the publisher's inventory.
:::

# The flow of a single impression

When a user opens a page or app, the publisher's SSP packages the available ad slot and sends it to exchanges. The exchange broadcasts a bid request to many DSPs at once. Each DSP decides in a few milliseconds whether to bid and how much.

The exchange runs the auction, picks a winner, and returns the winning ad to the page. From request to rendered ad the whole loop usually closes in under 100 milliseconds. You never see most of these auctions individually. You set strategy, and the DSP executes it at machine speed.

:::figure rtbFlow
caption: A single impression's path, from page load through the exchange's auction to the rendered winning ad, in under 100 milliseconds.
:::

:::callout insight
You do not buy impressions. You buy a bidding policy. Everything you control as a trader is a rule that decides whether to bid and how much on each incoming request.
:::

# Anatomy of a bid request

The bid request is the data the exchange hands you to make a decision. It follows the OpenRTB standard from IAB Tech Lab. At the top is the BidRequest object, which carries a unique id and at least one Imp (impression) object describing the slot for sale.

The Imp object names the format: a Banner, Video, Audio, or Native object, plus a bidfloor (the minimum price the seller will accept). Surrounding objects give you context to value the slot. A Site or App object identifies where the ad shows, a Device object describes the hardware and connection, and a User object carries audience signals. You read these fields, attach a value, and respond with a price.

:::widget codeLab
:::

:::callout key
Every field in the bid request is a feature you can price on. Format, floor, domain, device, and user signals all feed the single number you send back.
:::

:::quiz
question: In the OpenRTB chain, which party sends the bid request that your DSP responds to?
- The advertiser directly
- The ad exchange, on behalf of the publisher's supply
- Another competing DSP
- The user's browser
answer: 1
explain: The publisher's SSP offers inventory to exchanges, and the exchange broadcasts the bid request to DSPs. You respond to the exchange, not to the advertiser or the browser.
:::

:::sources
- OpenRTB 2.6 Specification, IAB Tech Lab | https://iabtechlab.com/standards/openrtb/
- OpenRTB 2.6 Markdown, Interactive Advertising Bureau | https://github.com/InteractiveAdvertisingBureau/openrtb2.x/blob/main/2.6.md
:::
