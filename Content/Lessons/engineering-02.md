---
id: engineering-02
track: engineering
module: 2
title: OpenRTB protocol anatomy
summary: Read the structure of an OpenRTB bid request and bid response, and understand how the ext object lets the contract evolve.
---
# OpenRTB is the wire contract

OpenRTB, maintained by the IAB Tech Lab, is the JSON contract that exchanges and DSPs speak over HTTP. An exchange POSTs a `BidRequest` to your endpoint with `Content-Type: application/json`, and you reply with a `BidResponse` or an HTTP 204 (no content) to pass. Version 2.6 (April 2022) is the common baseline today.

The contract matters because it is the only thing both sides agree on. If your parser is strict where the spec is loose, you reject revenue. If it is loose where the spec is strict, you bid on impressions you cannot serve. Reading the object model precisely is the whole job.

:::figure rtbFlow
caption: The wire contract in motion: the exchange POSTs a BidRequest as JSON over HTTP, and the DSP replies with a BidResponse or an HTTP 204 to pass. OpenRTB is the shared language for that round trip.
:::

# Anatomy of a bid request

The top-level `BidRequest` carries an `id` (the auction identifier), an `imp` array (the impressions for sale), exactly one of `site` or `app` (where the ad runs), and `device` and `user` objects describing who is seeing it. The `at` field declares the auction type: 1 for first price, 2 for second price.

Each `Imp` object in the array is one ad slot. It nests a format object, `banner`, `video`, `audio`, or `native`, plus a `bidfloor` (the minimum acceptable bid) and `bidfloorcur`. One request can offer several impressions, but you bid on each `Imp` independently and reference it by its `impid`.

:::callout key
A bid request is a tree: one BidRequest, an array of Imp slots, and shared context (site or app, device, user). Your bid must name the specific impid it is buying.
:::

:::predict
prompt: A single BidRequest carries an imp array with 5 slots. Your targeting matches 3 of those slots, and you submit at most one bid per slot. How many Bid objects do you return?
answer: 3
hint: You bid on each Imp independently, and only on the slots your targeting matches.
explain: Each Imp is evaluated independently, so you return one Bid per matched slot: 3 bids for the 3 matching slots. The 2 unmatched slots get no bid, and no slot gets more than one of your bids.
:::

# Anatomy of a bid response

The `BidResponse` mirrors the request. It echoes the request `id`, then carries a `seatbid` array. Each `SeatBid` groups bids from one buyer seat, and inside it the `bid` array holds individual `Bid` objects. A `Bid` sets `impid` (which slot), `price` (your bid in CPM), `adm` or `nurl` (the creative markup or a URL to fetch it), and creative metadata like `crid`, `adomain`, and `cat`.

The response also carries notification hooks. `nurl` is called on win, `burl` on billing, and `lurl` on loss, with price macros like `${AUCTION_PRICE}` substituted at fire time. We cover those mechanics in the auction module.

:::predict
prompt: A Bid sets price to $4.00, which is a CPM (cost per thousand impressions). If this bid wins and the impression renders at that price, what do you pay for the single impression?
answer: 0.004
unit: $
tolerance: 0.0005
hint: A CPM price is the cost for one thousand impressions, so divide by 1000 for one.
explain: Price in OpenRTB is a CPM. One impression costs $4.00 / 1000 = $0.004. Treating the CPM as a per-impression price would overcharge by 1000x.
:::

# The ext object is the escape hatch

Any OpenRTB object may carry an `ext` object. This is the spec's deliberate extension point: a place for an exchange to pass non-standard fields (supply-chain data, custom identifiers, deal terms) without breaking the core schema. Fields that prove broadly useful are sometimes promoted into the official spec in a later version.

The cost of `ext` is that it is exchange-specific. Your bidder needs adapter logic per partner to read the extensions you depend on, and a strict policy of ignoring unknown ones. Treat `ext` as a per-exchange dialect layered on a shared language.

:::callout warning
Never let unknown ext fields break parsing. Read the extensions you understand, ignore the rest, and keep a per-exchange adapter so one partner's dialect cannot corrupt your shared request model.
:::

:::widget codeLab
:::

:::quiz
question: In an OpenRTB bid response, what does the impid field on a Bid object do?
- Sets the price you are willing to pay
- Links the bid to the specific impression slot it is buying from the request
- Identifies the creative to serve
- Declares the auction type
answer: 1
explain: A request can contain multiple Imp slots. The impid on each Bid ties your bid to the exact impression it targets, so the exchange knows which slot you are buying.
:::

:::sources
- OpenRTB 2.6 Specification (PDF), IAB Tech Lab | https://iabtechlab.com/wp-content/uploads/2022/04/OpenRTB-2-6_FINAL.pdf
- openrtb2.x 2.6 object model, IAB GitHub | https://github.com/InteractiveAdvertisingBureau/openrtb2.x/blob/main/2.6.md
:::
