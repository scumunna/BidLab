---
id: vertical-retail-04
track: vertical-retail
module: 4
title: Auction Mechanics: Second-Price Reserve, Effective Bid = Bid x Relevance, and Placement Modifiers Across Ad Types
summary: Learn how the on-site retail-media auction actually clears so you can size a bid, read why a lower bid can win and underpay, stack placement modifiers correctly, and switch your intuition to first-price when you move budget off-site.
---
# The auction is where the trader actually competes

Everything before this lesson was topology and KPIs. This is the engine room: when a shopper types "laundry detergent," the retail-media network runs a live auction to decide which sponsored listing shows and what the winner pays. On-site RMN search (Amazon Sponsored Products is the canonical case) runs an UPGRADED second-price auction with a reserve, so the winner generally pays one cent above the next-highest EFFECTIVE bid rather than their own max. The job of the trader is to enter a bid that wins the slots worth winning without overpaying for the ones that are not, and that requires knowing exactly how the clearing price is formed.

The single most expensive misconception a new commerce-media trader carries in is "highest bid wins, and I pay what I bid." Neither half is true on-site. Rank is set by an effective bid that folds in relevance, and the price is set by the runner-up, so the lever is rarely just "bid more."

:::callout key
On-site retail search is a second-price auction on EFFECTIVE bid, not raw bid. You rank on bid times relevance, and you pay just above the next bidder's effective bid. Raising your raw bid is only one of two ways to win, and often the worse one.
:::

:::predict
prompt: Two advertisers compete for one sponsored slot. Bidder A bids $1.50 with a relevance score of 1.0. Bidder B bids $1.20 with a relevance score of 1.4. Rank is set by effective bid (bid times relevance), so to know who wins you need B's effective bid. Enter B's effective bid in dollars.
answer: 1.68
tolerance: 0.01
unit: USD
hint: Effective bid is the raw dollar bid multiplied by the relevance score; compute B's and compare it to A's.
explain: A's effective bid is $1.50 x 1.0 = $1.50. B's effective bid is $1.20 x 1.4 = $1.68. B wins the slot despite bidding 30 cents less in raw dollars, because the 1.4 relevance score carried its effective bid 18 cents above A's. This is the whole engine of the rest of the lesson: rank follows the effective-bid column, not the raw-bid column, so the trader competes on bid AND on listing relevance.
:::

# Effective bid = bid x relevance

The ranking number is not your dollar bid. Amazon (and Walmart Connect, and Google before them) ranks eligible ads on an effective bid that multiplies your max bid by a relevance score, where relevance is proxied by expected click-through rate, expected conversion, and listing quality. Formally:

$$ \text{effective bid} = \text{max bid} \times \text{relevance score} $$

This is the same idea Google made famous as Ad Rank. The consequence is that two advertisers with the same dollar bid can rank differently and pay differently, and a more relevant listing can outrank and underpay a higher raw bid. A clean product detail page that converts is therefore a pricing lever, not just a conversion lever: it lifts your relevance, which lifts your effective bid at the same dollar cost.

:::figure secondPriceAuction
caption: On-site retail search ranks on effective bid (bid times relevance), then clears at one cent above the next-highest effective bid. The high raw bid does not always win, and the winner does not pay its own max.
:::

:::predict
prompt: Bidder A bids $1.00 with a relevance score of 1.0. Bidder B bids $0.80 with a relevance score of 1.5. Whose effective bid is higher, and by how much? Enter B's effective bid in dollars.
answer: 1.2
tolerance: 0.01
unit: USD
hint: Multiply each bid by its relevance score, then compare.
explain: A's effective bid is $1.00 x 1.0 = $1.00. B's effective bid is $0.80 x 1.5 = $1.20. B wins the slot with a 20-cent-higher effective bid despite bidding 20 cents less in raw dollars, because relevance carried it. This is why a better-converting listing can win cheaper.
:::

:::quiz
question: Two advertisers enter the same $1.50 max bid on the same keyword. One has a strong, high-converting listing and the other a weak one. What is the most likely outcome on Amazon's upgraded second-price auction?
- They tie exactly and the slot is split evenly
- The stronger listing ranks higher and can pay a lower realized CPC
- The weaker listing wins because Amazon rotates impressions fairly
- Both pay their full $1.50 because the bids are equal
answer: 1
hint: Rank is set by bid times relevance, and price is set by the runner-up's effective bid.
explain: Equal raw bids do not produce equal effective bids. The stronger listing has a higher relevance score, so its effective bid is higher, it ranks above, and because clearing is second-price on effective bid it can win the better slot at a lower realized cost per click. Relevance is the tiebreaker and the discount.
:::

# Second-price clearing: you pay the runner-up, not yourself

In a second-price auction the winner pays just enough to beat the next bidder, not their own ceiling. The practical clearing rule on-site is approximately the next-highest effective bid plus one cent, then de-rated back through your own relevance to a realized cost per click:

$$ \text{clearing price} \approx \text{next-highest effective bid} + \$0.01 $$

This is why your max bid behaves like a ceiling, not a price tag. If you bid $1.00 and the runner-up's effective bid clears at $0.62, you pay about $0.63, not $1.00, assuming the click happens. Bidding higher widens your safety margin to win the auction but does not raise the price you actually pay unless a competitor is sitting right beneath you. That decoupling of bid from price is the whole reason traders can bid to the value of a click (Lesson 5) without fearing they will always pay that full value.

:::predict
prompt: You bid $1.40. The next-highest effective bid in the auction clears at $0.74. Ignoring relevance de-rating, what do you pay per click to the nearest cent?
answer: 0.75
tolerance: 0.01
unit: USD
hint: Second price is the runner-up's bid plus one cent, not your own bid.
explain: You pay the next-highest effective bid of $0.74 plus $0.01, which is $0.75. Your $1.40 bid only determined that you won the slot, not the price. The 65-cent gap between your bid and your cost is your bid headroom, and it is why a high max bid is safe when no competitor is directly beneath you.
:::

:::callout insight
A high max bid is not the same as a high cost. In a second-price auction your bid buys rank and the runner-up sets the price, so the lever for cost control is the competitive density just below you, not your own ceiling. This is exactly backwards from the first-price world you enter off-site.
:::

# Placement modifiers multiply the bid by slot

A single keyword bid is not one number into one auction. The trader can multiply the entered bid by placement: top-of-search, rest-of-search, and product pages each carry their own modifier, and a modifier scales the bid that enters that specific slot's auction. A 50% top-of-search modifier means the bid competing for the top-of-search slot is your base bid times 1.5:

$$ \text{placement-adjusted bid} = \text{base bid} \times (1 + \text{placement modifier}) $$

So a $1.00 base bid with a +50% top-of-search modifier enters the top-of-search auction at $1.50, while rest-of-search might enter at the base $1.00 or a separate modifier. The order of operations is the trap: the platform applies the placement modifier FIRST, then dynamic bidding (Lesson 5) can adjust on top of that. The two compound, which is how traders accidentally enter bids far above what they sized from their efficiency target.

:::predict
prompt: Your base bid is $2.00 and you set a +25% rest-of-search modifier. What bid enters the rest-of-search auction?
answer: 2.5
tolerance: 0.01
unit: USD
hint: Multiply the base bid by (1 + the modifier).
explain: $2.00 x (1 + 0.25) = $2.00 x 1.25 = $2.50. The modifier is a multiplier on the base bid for that one placement, not a separate flat bid. Set it as a percentage, not a dollar figure, or you will badly misprice the slot.
:::

:::quiz
question: You set a $1.00 base bid, a +100% top-of-search modifier, and dynamic up-and-down bidding (which can raise top-of-search by up to another 100%). What is the worst-case bid that could enter the top-of-search auction?
- $2.00, because the modifier and dynamic bidding do not stack
- $3.00, because both adjustments are applied in sequence
- $4.00, because each setting independently doubles the base bid from scratch
- $1.00, because dynamic bidding only lowers bids
answer: 2
hint: Apply the placement modifier first, then let dynamic up-and-down raise that result by up to 100%.
explain: Placement modifier first: $1.00 x (1 + 1.00) = $2.00. Then dynamic up-and-down can raise that by up to 100%: $2.00 x (1 + 1.00) = $4.00. The correct worst case is $4.00, but the common operator error is assuming they do not stack and entering far higher than intended. Compounding placement and dynamic adjustments is the number-one way new traders blow a CPC ceiling.
:::

# The three on-site ad types run separate auctions

There is no single "Amazon auction." Sponsored Products (keyword- and product-targeted search plus the detail page), Sponsored Brands (the headline banner and brand creative at top-of-search), and Sponsored Display (audience- and product-targeted, and the one type that extends off-site) each run their own auction with their own inventory and their own relevance signals. A trader cannot reason about one from the other: a winning Sponsored Products keyword strategy says nothing about whether your Sponsored Brands banner clears the top-of-search banner auction, which has different competitors and creative gating. The brief's benchmark below shows how effective bid, not raw bid, decides the winner across bidders in a single auction.

:::widget barChart
title: Effective bid decides the winner (index, bid x relevance)
labels: A high bid low relevance, B mid bid high relevance, C low bid low relevance
data: 100, 130, 60
unit: index
:::

:::predict
prompt: Bidder A's effective bid indexes at 100 and Bidder C's at 60. By what percentage is A's effective bid higher than C's? Round to the nearest whole percent.
answer: 67
tolerance: 1
unit: percent
hint: Percentage higher is (A minus C) divided by C, times 100.
explain: (100 - 60) / 60 = 0.6667, or about 67% higher. Even though A outranks C comfortably, B at index 130 beats both, which is the point: B's mid bid plus strong relevance produced the highest effective bid and wins the slot. Rank follows the effective-bid column, not the raw-bid column.
:::

# Off-site flips you from second-price to first-price

The moment you move budget off the retailer's own site and into open-web display or CTV through a DSP, the auction type changes and your on-site intuition stops transferring. Open-web and CTV programmatic auctions are predominantly FIRST-PRICE: you pay your bid, header-bidding style, with no runner-up discount. The clearing logic inverts, so the value of a winning bid is your own number, and the skill becomes bid shading rather than bidding to a ceiling:

$$ \text{first-price cost} = \text{your bid}, \qquad \text{shade} = \text{bid} - \text{expected clearing price} $$

Practically: on-site you can bid to the full value of a click and trust second-price to discount you; off-site that same behavior overpays on every impression, because first-price charges you exactly what you bid. The same target audience can cost more per impression off-site purely from the auction type, before you even add the stacked DSP, exchange, and data fees that Lesson 7 and Lesson 8 quantify. A trader who carries the "bid high, pay second" reflex into a first-price DSP will burn the budget at full freight.

:::predict
prompt: In a first-price off-site auction you bid a $7.00 CPM and the expected clearing price is $5.20. What is your shade (the amount you could cut and still expect to clear), and what do you pay if you bid the full $7.00? Enter the amount you pay in CPM dollars.
answer: 7
tolerance: 0.01
unit: USD CPM
hint: First-price means you pay your bid; the shade is bid minus expected clearing price.
explain: First-price charges your bid, so you pay the full $7.00 CPM. The shade is $7.00 - $5.20 = $1.80, meaning a disciplined buyer would lower the bid toward $5.20-ish to avoid overpaying while still clearing. On-site second-price would have charged you about $5.21 for the same competitive picture, which is why the auction type alone can swing your effective cost.
:::

:::callout warning
A real and recurring operator complaint: traders set a high top-of-search placement modifier AND leave dynamic up-and-down on, not realizing the platform applies the modifier first and then lets dynamic bidding raise it again. The two compound, and people report a $1.00 base bid quietly entering auctions at several dollars and draining a daily budget in minutes (r/PPC, r/AmazonSeller). Always compute your worst-case stacked bid, base x (1 + modifier) x (1 + dynamic cap), before turning both on.
:::

:::sources
- Feedvisor, Amazon Sponsored Products Bids: Default, Suggested and Dynamic | https://feedvisor.com/university/amazon-sponsored-products-default-suggested-and-maximum-bids/
- Amazon Ads, Guide to dynamic bidding for Sponsored Products | https://advertising.amazon.com/library/guides/dynamic-bidding-sponsored-products
- Cornell INFO 2040 Networks blog, The Complexities of Advertising Bidding on Amazon | https://blogs.cornell.edu/info2040/2022/09/17/the-complexities-of-advertising-bidding-on-amazon/
- ScaleInsights, Amazon Bid Modifiers: Top of Search, Rest of Search, and Product Placements | https://scaleinsights.com/learn/bid-modifiers-top-of-search-rest-of-search-and-product-placements
- ensobrands, What is Amazon PPC and How the Amazon PPC Auction Works | https://ensobrands.com/what-is-amazon-ppc-how-the-amazon-ppc-auction-works/
- Skai, The 2026 State of Retail Media DSP, CTV, and Social Commerce | https://skai.io/blog/the-2026-state-of-retail-media-dsp-ctv-and-social-commerce-accelerating-beyond-the-shelf/
- AdExchanger, How Retail Media Ad Platforms Are Rewriting The Walled Garden Playbook (walled gardens, DSP integration) | https://www.adexchanger.com/ecommerce-2/how-retail-media-ad-platforms-are-rewriting-the-walled-garden-playbook/
:::
