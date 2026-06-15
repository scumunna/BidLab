---
id: dsp-06
track: dsp
module: 6
title: Bid shading and surplus optimization
summary: Shade your bid below value in first-price auctions to maximize surplus, the win probability times the margin you keep.
---
# The first-price problem

Most display and video inventory now clears in first-price auctions, where the winner pays exactly what it bid. That changes everything. In a second-price auction you could bid your true value safely, because you paid only the runner-up's price. In a first-price auction, bidding your full value leaves you zero surplus on every win.

So you shade. Bid shading is lowering your bid below the impression's value, deliberately, to keep margin. You give up some win rate in exchange for profit on the auctions you do win. The whole skill is choosing how much to shade.

:::predict
prompt: An impression is worth $10.00 to you and you bid $7.00 in a first-price auction. Expressed as a percent of value, how much are you shading?
answer: 30
unit: %
tolerance: 0.5
hint: The shade is value minus bid. As a percent, divide that gap by the value.
explain: Shade = value - bid = $10.00 - $7.00 = $3.00, which is $3.00 / $10.00 = 30 percent of value. You keep that 30 percent as margin on every win.
:::

# Surplus is the thing to maximize

Surplus is the value you place on the impression minus the price you pay for it. If an impression is worth v and you win it at bid b, your surplus on that win is v minus b. But you only collect that surplus when you win, which happens with probability P(win | b).

So the quantity to maximize is expected surplus: the probability of winning times the surplus you keep if you win. This is the same expected-value logic as before, now pointed at margin rather than wins.

$$ E[surplus] = P_{win}(b) \times (v - b) $$

:::callout key
Bid shading maximizes expected surplus, win probability times margin, not win rate. The best shade is the bid where one more cent of bid buys exactly as much extra win rate as it costs you in margin.
:::

:::predict
prompt: An impression is worth $10.00 and you bid $7.00, which wins 40 percent of the time. What is your expected surplus per opportunity?
answer: 1.2
unit: $
tolerance: 0.01
hint: Expected surplus is the win probability times the margin you keep on a win, which is value minus bid.
explain: Margin on a win = $10.00 - $7.00 = $3.00. Expected surplus = P(win) x margin = 0.40 x $3.00 = $1.20 per opportunity.
:::

# Where the peak sits

Two forces pull against each other. Shade too little, bid near v, and you win often but keep almost no margin per win. Shade too much, bid far below v, and you keep fat margin but win almost nothing. Expected surplus peaks somewhere in between, and that peak depends on the shape of the bid landscape.

When clearing prices are tightly clustered, a small shade barely costs you wins, so shade harder. When prices are spread out, shading aggressively forfeits many winnable auctions, so shade gently. This is why production shaders estimate a per-request win curve instead of using one fixed discount.

:::widget bidPlayground
marketMean: 0.5
value: 1.0
:::

# Shading in practice

Drag the bid below value in the playground and watch expected profit. It rises, peaks, then falls. That peak is your optimal shade for this landscape. Move the market mean and the peak moves with it, which is exactly why a static shade underperforms.

Real shading engines also respect the floor (you cannot win below it) and feed back the prices they actually pay to refine the curve. Industry studies report that surplus-maximizing shaders deliver several percent more surplus and lower effective CPMs than naive fixed-discount rules.

:::callout insight
There is no single right shade. The optimal discount depends on the clearing-price distribution for that exact request, which is why shading is a per-impression prediction, not a global setting.
:::

:::quiz
question: In a first-price auction, what does an optimal bid shader maximize?
- Win rate alone
- The win probability times the surplus kept on a win
- The bid price subject to the floor
- The number of auctions entered
answer: 1
explain: Surplus on a win is value minus bid, collected only when you win. The optimal shade maximizes win probability times that surplus, balancing more wins against thinner margin.
:::

:::sources
- Bid Shading by Win-Rate Estimation and Surplus Maximization, Pan et al. | https://arxiv.org/pdf/2009.09259
- Bid Shading in The Brave New World of First-Price Auctions, Gligorijevic et al. | https://arxiv.org/pdf/2009.01360
:::
