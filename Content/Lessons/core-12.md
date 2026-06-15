---
id: core-12
track: core
module: 12
title: Header Bidding and the Unified Auction
summary: How header bidding replaced the waterfall, what Prebid and wrappers actually do, the client-side versus server-side tradeoff, why timeouts pull against yield, and the cookie-sync match loss that S2S quietly costs you.
---
# The waterfall was leaving money on the table

Before header bidding, a publisher's ad server sold inventory in a waterfall: demand sources were ranked in a fixed order, usually by their historical average price, and each impression was offered down the list until someone took it. The flaw is structural. A source ranked second might have bid more than the source ranked first on this particular impression, but it never got asked, because the order was set in advance, not by the live bid. The waterfall optimizes on averages and loses on specifics.

Header bidding fixed that by asking everyone at once. A snippet in the page header calls multiple demand partners in parallel, collects their live bids before the ad server is even called, and passes the winning price in as a competing line item. Now the order is decided by the actual bid on the actual impression, so the highest real bid can win. That single change, from sequential averages to a simultaneous auction, is why header bidding took over.

:::quiz
question: Why can the waterfall undersell an impression that header bidding would sell for more?
- The waterfall calls partners simultaneously but ignores the highest bid
- The waterfall offers inventory in a fixed order, so a lower-ranked partner that would bid more is never asked
- Header bidding only works for video inventory
- The waterfall always picks the lowest bid
answer: 1
hint: Think about what sets the order in a waterfall versus an auction.
explain: The waterfall ranks partners in a fixed order, usually by historical average price, and stops at the first taker. A partner that would have bid higher on this specific impression but sits lower in the order never gets the chance. Header bidding asks all partners at once, so the highest live bid can win.
:::

# Prebid and the wrapper

Running an auction in the browser needs orchestration: which partners to call, how to format each request, how long to wait, and how to hand the winner to the ad server. That orchestration layer is the wrapper, and the open-source standard is Prebid.js.

Prebid.js is the wrapper that loads in the page, fires the bid requests to each configured partner's adapter, gathers the responses, and sets the winning bid as a key-value targeting pair that the ad server (usually Google Ad Manager) reads to decide the final line item. Without a wrapper, every added partner would mean another hand-coded script and another serial delay. The wrapper makes the calls parallel and the configuration declarative, which is what makes adding or removing a dozen partners practical instead of a rebuild.

:::quiz
question: What is the main job of a wrapper like Prebid.js?
- To replace the publisher's ad server entirely
- To block third-party cookies in the browser
- To set the publisher's floor prices automatically
- To orchestrate parallel bid requests to many partners and pass the winner to the ad server
answer: 3
hint: The wrapper coordinates the auction, it does not become the ad server.
explain: Prebid.js orchestrates the header-bidding auction: it calls each partner's adapter in parallel, collects bids, and passes the winning bid to the ad server as targeting. It does not replace the ad server, and it is not a cookie or floor-pricing tool.
:::

# Client-side versus server-side

The auction can run in two places, and the choice is a genuine tradeoff, not a clear win either way.

Client-side, the auction runs in the browser with Prebid.js. Every partner call goes out from the user's device, which is heavy: more partners means more requests competing for the browser's limited connections, and page speed suffers. The upside is identity. Because each call originates in the browser, partners can read their own cookies and match the user directly, so match rates stay high.

Server-side (S2S), the browser makes one call to a Prebid Server, which fans out to all the partners from the server and returns the winner. The page stays light and you can add far more partners without slowing the user down. The cost is identity, covered in the next section. Many publishers run a hybrid: a few high-value partners client-side for match rate, the long tail server-side for scale.

$$ \text{client-side: heavy page, high match} \quad\text{vs}\quad \text{S2S: light page, lower match} $$

:::quiz
question: What does moving a demand partner from client-side to server-side primarily cost you?
- The partner can no longer bid at all
- Page load speed gets worse
- Cookie match rate drops because the call no longer originates in the browser
- The ad server stops reading the winning bid
answer: 2
hint: S2S makes the page lighter, so the cost is on the other side of the tradeoff.
explain: S2S improves page speed by moving partner calls off the device. The cost is identity: when the call comes from the server instead of the browser, the partner cannot read its own browser cookie directly, so match rates fall. That is the core S2S tradeoff.
:::

# The timeout, and why it fights yield

A header-bidding auction cannot wait forever, because the user is staring at an empty ad slot. So the wrapper sets a timeout: bids that arrive after it are thrown away. Prebid's own guidance is around 1000 milliseconds for the internal auction timeout and a higher failsafe (around 3000 milliseconds) in case the library fails to load at all.

Here is the tension. A short timeout protects the user experience and page speed, but it discards slow bids, and a discarded bid cannot win, so a short timeout can cap your yield. A longer timeout lets more bids land, which raises competition and the clearing price, but it delays the ad and hurts speed metrics. There is no universally correct number. You tune the timeout per setup by watching what extra time actually buys in won revenue against what it costs in latency.

:::figure headerBidding
caption: The wrapper fires bid requests to all partners in parallel, waits until the timeout, then passes the best bid that arrived to the ad server as a competing line item.
:::

:::predict
prompt: At a 1000 ms timeout, four of your six partners respond and the winning bid clears at a 4.20 CPM. You raise the timeout to 1500 ms, all six now respond, and the winning bid clears at 5.40. By what percent did the winning CPM increase?
answer: 28.6
tolerance: 0.5
unit: %
hint: Compute the change in CPM divided by the starting CPM.
explain: (5.40 - 4.20) / 4.20 = 1.20 / 4.20 = 0.2857, about a 28.6% lift in clearing CPM. The extra 500 ms let two more partners into the auction, and more competition raised the price. You would weigh that against the added latency before keeping the longer timeout.
:::

# The hidden cost of S2S: match-rate loss

The identity cost of server-side is concrete and measurable. When the auction runs client-side, each partner's request leaves the browser carrying that partner's own cookie, so the user is recognized and match rates run high, often around 70%. When the same partner runs through a Prebid Server, the browser does not carry that partner's cookie to a different domain, so the server has to run a separate cookie sync, and many users are simply never synced. Industry measurements put S2S sync rates closer to 45%.

A lower match rate means more impressions where the partner cannot identify the user, which means lower bids or no bid, which means less revenue on that demand. This is the real reason publishers keep their most valuable partners client-side even though S2S would be lighter on the page. The relative loss is the gap divided by the client-side baseline.

$$ \text{relative match loss} = \frac{\text{client rate} - \text{S2S rate}}{\text{client rate}} $$

:::predict
prompt: A partner matches 70% of users when run client-side. Moved to server-side, it matches only 45%. What is the relative drop in match rate versus the client-side baseline?
answer: 35.7
tolerance: 0.5
unit: %
hint: Take the difference, then divide by the client-side rate, not by 100.
explain: (70 - 45) / 70 = 25 / 70 = 0.357, about a 35.7% relative drop. More than a third of the previously matched users are lost when this partner goes server-side, which is why high-value demand often stays client-side.
:::

# The unified auction and fill

Header bidding plus the ad server's own demand only pay off if you judge them on one scale. The unified auction is that scale: the header-bidding winner enters the ad server as a real, price-comparable line item and competes head to head with everything else, so the genuinely highest bid wins rather than whatever the server's internal ranking would have favored. Google's server-side equivalent, Open Bidding, runs the same idea inside Ad Manager, letting multiple exchanges compete simultaneously on the server.

Once the auction is unified, the operational number you watch is fill: of the ad requests you sent, how many actually returned a paid ad. Empty timeouts, no-bids, and below-floor bids all leave a request unfilled, and unfilled requests are unearned revenue.

$$ \text{fill rate} = \frac{\text{filled impressions}}{\text{ad requests}} $$

:::predict
prompt: Your page sent 1,000,000 ad requests in a day. 420,000 of them returned a paid ad. What is the fill rate?
answer: 42
tolerance: 0.5
unit: %
hint: Divide filled impressions by total ad requests.
explain: 420,000 / 1,000,000 = 0.42, a 42% fill rate. The other 580,000 requests returned nothing paid, lost to no-bids, below-floor bids, or bids that missed the timeout, and that is where a unified auction and a tuned timeout earn their keep.
:::

:::callout insight
Header bidding turned sequential averages into a simultaneous auction, and the unified auction made every bid price-comparable in the ad server. The two knobs you tune are the timeout (latency against yield) and the client-side versus server-side split (page speed against match rate), and both come down to revenue you can measure.
:::

:::sources
- Prebid, Prebid.js FAQ and timeout guidance | https://docs.prebid.org/dev-docs/faq.html
- Prebid, What is Prebid | https://docs.prebid.org/overview/intro.html
- AdExchanger, Client-side vs server-side header bidding | https://www.adexchanger.com/adexplainer/adexplainer-client-side-vs-server-side-header-bidding-whats-the-difference/
- Setupad, Client-side vs server-side header bidding | https://setupad.com/blog/client-side-vs-server-side/
- Epom, Header bidding vs waterfall | https://epom.com/blog/ad-server/header-bidding-vs-waterfall
- Criteo, Header bidding demystified, client-side vs server-side | https://www.criteo.com/blog/header-bidding-demystified-client-side-vs-server-side/
- Google, About Open Bidding in Ad Manager | https://support.google.com/admanager/answer/7128453
:::
