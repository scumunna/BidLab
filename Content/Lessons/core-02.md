---
id: core-02
track: core
module: 2
title: The impression and the auction
summary: Follow a single impression through a real-time auction and understand how OpenRTB, price rules, and header bidding shape what you pay.
---
# A market that clears in milliseconds

When a page or app loads an ad slot, the impression is sold in a real-time bidding (RTB) auction that resolves in well under 100 milliseconds. The publisher's supply-side platform broadcasts a request to many demand-side platforms, each returns a price, and the highest valid bid wins. The whole exchange happens before the content finishes rendering.

The common language for this conversation is OpenRTB, an open protocol maintained by the IAB Tech Lab. The SSP sends a structured bid request describing the user, device, page, and slot. Each DSP replies with a bid response carrying a price and the creative markup to show if it wins.

:::figure rtbFlow
caption: One impression through a real-time auction. The SSP broadcasts an OpenRTB bid request, each DSP returns a bid response, and the highest valid bid wins before the page finishes rendering.
:::

# What the request and response carry

A bid request is a JSON object. It includes the impression object (size, position, floor price), context about the site or app, device and geo signals, and any user identifiers the publisher is allowed to share. The DSP reads all of this to decide whether the impression is worth buying and how much to pay.

The bid response returns the bid price, a creative, and tracking URLs. If the bid wins, the SSP fires a win notice and the creative renders. OpenRTB 2.6 added structured support for connected TV, including ad pods, which matters as video and CTV grow.

:::predict
prompt: Four bid responses come back at CPMs of 8.00, 6.50, 5.00, and 4.20 dollars. Under a classic second-price auction, what CPM does the winner pay?
answer: 6.50
unit: $
tolerance: 0.01
hint: In a second-price auction the highest bid wins but pays the price set by the runner-up, not its own bid.
explain: The 8.00 dollar bid wins, but a second-price auction charges the second-highest bid, so the winner pays 6.50 dollars CPM. That gap between the top bid and what is paid is why truthful bidding is safe under second price.
:::

:::callout insight
The bid request is the entire basis for the decision. Richer, cleaner signals let the DSP value the impression more accurately, which is why identity and context (covered next module) move so much money.
:::

# First price versus second price

For years the open market ran second-price auctions, where the winner paid one cent above the second-highest bid. Around 2019 the industry shifted to first-price auctions, where the winner pays exactly what it bid. That change made bid shading (deliberately bidding below your true value) the standard buyer strategy.

$$ E[\pi] = P_{win}(b) \times (v - b) $$

In a first-price auction your expected profit per opportunity is the probability of winning at bid b times the surplus v minus b. Bid too high and you erode surplus. Bid too low and you rarely win. The optimal bid sits where those two pressures balance.

:::widget bidPlayground
marketMean: 0.5
value: 1.0
:::

# Header bidding

Header bidding is a technique that lets a publisher offer inventory to several exchanges at once, before calling its primary ad server. Instead of a waterfall that asks demand sources one at a time, header bidding holds a unified auction so the highest bid across all partners wins. It raised publisher yield and competitive pressure, at the cost of added page latency that publishers manage with timeouts.

:::callout key
Second price rewards honest bidding. First price rewards shading below value. Most open-web inventory today is first price, so disciplined bid pricing is where buyers protect margin.
:::

:::quiz
question: In a first-price auction, what does the winning buyer pay?
- Exactly the amount it bid
- One cent above the second-highest bid
- The publisher's floor price
- The average of all submitted bids
answer: 0
explain: First-price auctions charge the winner its own bid. That is why buyers shade below their true value to preserve surplus, unlike second-price auctions where the price is set by the runner-up.
:::

:::sources
- OpenRTB 2.6 Specification, IAB Tech Lab | https://iabtechlab.com/standards/openrtb/
- IAB Tech Lab, OpenRTB 2.6 (April 2022) | https://github.com/InteractiveAdvertisingBureau/openrtb2.x/blob/main/2.6.md
:::
