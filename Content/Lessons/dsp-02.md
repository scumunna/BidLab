---
id: dsp-02
track: dsp
module: 2
title: Auctions and the math of the bid
summary: How first-price and second-price auctions work, and why your bid is really a bet on expected profit.
---
# The impression is an auction

Every time an ad can show, a real-time auction decides who buys it. As a buyer you submit one number, your bid, and the exchange compares it to everyone else. Win and you pay. Lose and you move on, all in under 100 milliseconds.

:::figure rtbFlow
caption: A real-time bidding auction, from a user's page load to the winning ad, in under 100 milliseconds.
:::

Two rules dominate the market. In a second-price auction the highest bidder wins but pays the second-highest price. In a first-price auction the winner pays exactly what they bid. How you should bid is different in each.

# Second price: bid your true value

In a second-price auction your bid never sets your price, it only decides whether you win. That makes honesty optimal. Bidding your true value can never hurt you, because the price you pay is someone else's bid.

$$ E[\pi] = P_{win}(b)\,(v - price) $$

:::figure secondPriceAuction
caption: Three sealed bids. The highest bidder wins but pays the second-highest price, so honesty is safe.
:::

:::callout insight
Truthful bidding is a dominant strategy in a second-price auction. Bid what the impression is worth to you, no more and no less.
:::

:::predict
prompt: Three buyers bid $8.00, $6.00, and $5.00 for one impression in a second-price auction. What does the winner pay?
answer: 6
tolerance: 0.01
unit: $
hint: The highest bidder wins, but the price is not their own bid.
hint: In a second-price auction you pay the runner-up's bid.
explain: The $8.00 bidder wins but pays the second-highest bid, $6.00. Their own bid only decided that they won, not the price they pay.
:::

# First price: shade below value

First-price auctions are now the norm in display and video. Here you pay your bid, so bidding your full value leaves zero surplus. You shade: bid below value to keep some margin, trading a lower win rate for profit on the wins you get.

Expected profit per opportunity is the win probability times the surplus. Drag the bid below and watch where profit peaks. That peak is the optimal shade.

:::widget auctionSimulator
marketMean: 0.5
value: 1.0
:::

The optimal bid balances two forces. Bid higher and you win more often but earn less per win. Bid lower and you earn more per win but win less often. The peak is where the gain from winning more just offsets the loss in surplus.

:::callout key
Your bid is a bet on expected value. The right bid maximizes win probability times surplus, not win rate alone.
:::

:::quiz
question: In a first-price auction, why do buyers bid below their true value?
- To keep positive surplus on the impressions they win
- Because the exchange requires it
- To guarantee they win every auction
- Because bids must be whole numbers
answer: 0
explain: You pay your bid in a first-price auction, so bidding full value leaves no surplus. Shading below value preserves profit on the wins.
:::

:::sources
- OpenRTB 2.6 Specification, IAB Tech Lab | https://iabtechlab.com/standards/openrtb/
- Vickrey 1961, Counterspeculation, Auctions, and Competitive Sealed Tenders | https://www.jstor.org/stable/2977633
:::
