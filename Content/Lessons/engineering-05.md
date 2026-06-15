---
id: engineering-05
track: engineering
module: 5
title: The auction at scale
summary: Follow the auction from the exchange's clearing logic to the DSP's internal selection, price computation, and asynchronous win notifications.
---
# Two auctions, not one

There are really two auctions stacked on top of each other. Inside the DSP, the bidder runs a local auction among its own candidate campaigns to choose the single best bid to submit. At the exchange, that submitted bid competes against bids from other DSPs in the market auction that actually clears the impression.

Understanding which auction you control matters. You set the rules of the internal auction completely. You only influence the external one through the number you submit and the price you are willing to pay.

:::figure rtbFlow
caption: Two stacked auctions. The bidder runs an internal auction among its own candidates to pick one champion, then that single bid travels to the exchange to compete in the market auction that actually clears the impression.
:::

# The internal auction picks your champion

After candidate selection, the bidder has a few dozen surviving campaigns. It scores each one, typically predicted response rate times the advertiser's value goal, applies pacing and budget throttles, and ranks them. The top campaign becomes the one bid placed in the OpenRTB response. The DSP submits one bid per impression, so internal competition is resolved before anything leaves your servers.

$$ bid = pCTR \times value \times throttle $$

Here `pCTR` is the model's predicted response probability, `value` is what a response is worth to the advertiser, and `throttle` is the pacing multiplier between 0 and 1 that holds spend on plan. The product is the bid in CPM units after the usual scaling.

:::callout key
The DSP submits exactly one bid per impression. The internal auction is where pacing, prediction, and advertiser value combine to choose which campaign gets to compete externally.
:::

:::predict
prompt: A candidate has a predicted response rate (pCTR) of 0.04, the advertiser values a response at $5.00, and the pacing throttle is 0.5. Using bid = pCTR x value x throttle, what is the per-impression bid value in dollars (before CPM scaling)?
answer: 0.10
unit: $
tolerance: 0.005
hint: Multiply the three factors together.
explain: bid = 0.04 x $5.00 x 0.5 = $0.10 of expected value per impression. Scaled to CPM that is a $100 bid, and the throttle of 0.5 has halved it to hold the campaign on plan.
:::

# Price computation depends on the auction type

The OpenRTB `at` field tells you how the exchange clears. In a first-price auction (`at` = 1), now the market norm, the winner pays exactly what they bid, so your submitted price is your clearing price and shading below value preserves margin. In a second-price auction (`at` = 2), the winner pays just above the runner-up, so truthful bidding is the dominant strategy.

The exchange computes the actual clearing price and reports it back through a macro. Your bidder cannot know the final price at bid time in a second-price market, only the rules. Building the bidder to handle both `at` values correctly is non-negotiable, because the optimal bid differs between them.

:::callout insight
The clearing price is computed by the exchange, not by you. Your bidder's job is to submit the right number given the declared auction type, then learn the actual price from the win notification.
:::

:::predict
prompt: In a first-price auction (at = 1) you value the impression at $10.00 CPM but shade your bid down to $7.00 CPM to preserve margin. You win and pay your bid. What is your margin per thousand impressions?
answer: 3
unit: $
hint: In a first-price auction the winner pays exactly the submitted bid, so margin is value minus the bid.
explain: First price means you pay what you bid, so you pay $7.00 against a $10.00 value, leaving $3.00 CPM of margin. Bidding your full value would have won the impression but left zero margin.
:::

# Win notifications close the loop asynchronously

Winning the auction is not the end of the request. The bidder returns its bid synchronously, but it learns the outcome later, out of band. The exchange fires the `nurl` (win notice) when the auction closes, the `burl` (billing notice) when the ad actually renders, and the `lurl` (loss notice) when you lose, each with macros like `${AUCTION_PRICE}` substituted to the real values.

This asynchronous callback is how the DSP reconciles spend. The win and billing notices feed the budget and pacing controllers and the logging pipeline, which is why `burl` (fired on render, not just on win) is the more reliable basis for charging an advertiser. Money and spend tracking ride on these notifications, not on the bid response itself.

:::callout warning
Do not treat a returned bid as a win. Spend is only confirmed when the win and billing notifications fire, and bill on the render-based burl rather than the win-based nurl to avoid charging for impressions that never showed.
:::

:::widget auctionSimulator
marketMean: 0.5
value: 1.0
:::

:::quiz
question: When does a DSP learn the actual clearing price of an impression it won in a second-price auction?
- At bid time, computed locally by the bidder
- From the win or billing notification fired by the exchange with the price macro substituted
- It never learns the price
- From the bid floor in the original request
answer: 1
explain: In a second-price auction the bidder cannot know the clearing price at bid time. The exchange reports it asynchronously via the nurl or burl with the ${AUCTION_PRICE} macro filled in.
:::

:::sources
- Win and loss notifications, Google Authorized Buyers | https://developers.google.com/authorized-buyers/rtb/response-guide/win-and-loss-notifications
- OpenRTB 2.6 Specification, IAB Tech Lab | https://iabtechlab.com/standards/openrtb/
:::
