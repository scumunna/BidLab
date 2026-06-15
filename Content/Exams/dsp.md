---
track: dsp
title: DSP / Trader Certification
pass: 0.7
draw: 12
---
:::q Auctions & Bidding
question: Your bidder submits a 6 dollar bid and wins an impression that clears in a first-price auction. What do you pay?
- The publisher floor, whatever it happens to be
- 6 dollars, exactly the amount you bid
- The runner-up's bid, just below 6 dollars
- The average of all submitted bids
answer: 1
explain: In a first-price auction the winner pays its own bid, so winning at a 6 dollar bid costs 6 dollars. Paying the runner-up's bid is the second-price rule, which is why first-price buyers must shade.
:::

:::q Auctions & Bidding
question: An impression is worth 4 dollars to you and you win it in a first-price auction. Bidding the full 4 dollars instead of shading below it would mean:
- You keep more surplus per win
- You keep zero surplus on every win, even though you win more often
- You lose every auction you enter
- The exchange rejects the bid for being too high
answer: 1
explain: Surplus is value minus the price you pay, and in first-price you pay your bid. Bidding full value leaves value minus value, which is zero margin on each win, so traders shade below value to keep surplus.
:::

:::q Auctions & Bidding
question: Clearing prices on a particular request are tightly clustered just below your value. Compared with a request where prices are widely spread, the right move is to:
- Shade harder, because a small shade barely costs you wins here
- Shade more gently, because every cent of shade forfeits many wins
- Bid your full value, because shading never helps with clustered prices
- Stop bidding, because clustered prices mean the auction is rigged
answer: 0
explain: When prices cluster tightly, a small shade barely lowers your win rate, so you can shade harder and keep more margin. Spread-out prices punish shading, so you shade gently. This is why optimal shade is a per-request prediction.
:::

:::q Valuation & Prediction
question: An advertiser values a conversion at 150 dollars. For an impression with a predicted click rate of 0.2 percent and a predicted post-click conversion rate of 5 percent, what is the expected value of the impression?
- 150 dollars
- 0.15 dollars
- 0.015 dollars
- 7.50 dollars
answer: 1
explain: Expected value is pCTR times pCVR times conversion value: 0.002 times 0.05 times 150 equals 0.15 dollars per impression. You discount the conversion value by both funnel probabilities rather than bidding the full conversion value.
:::

:::q Valuation & Prediction
question: Two impressions are offered to the same advertiser at the same conversion value, yet one is worth a hundred times more than the other. The most direct reason is:
- The conversion value changes between the two impressions
- The predicted click and conversion probabilities differ enormously by user and context
- One impression is in a first-price auction and the other in a second-price auction
- The advertiser's budget is larger on one of them
answer: 1
explain: With a fixed conversion value, the impression's worth is driven by pCTR times pCVR. Those probabilities vary enormously by user, context, and placement, so two impressions can differ a hundredfold in expected value.
:::

:::q Valuation & Prediction
question: In the expected-value framework, valuation and bidding are best understood as:
- The same step, since the bid is always the impression's full value
- Separate steps, where valuation finds the ceiling and bidding decides how much of it to give up
- Separate steps, where bidding comes first and valuation adjusts it afterward
- Interchangeable, since shading replaces the need to value the impression
answer: 1
explain: Valuation answers what the impression is worth, the ceiling. Bidding then decides how much of that value to surrender in the auction. Confusing the two leads to overbidding, which is why they are kept as distinct steps.
:::

:::q Pacing & Delivery
question: Under even pacing on a 24 hour flight, roughly how much of the budget should be spent by hour 12?
- The full budget, to avoid going dark
- About half the budget
- None of it, holding spend for the final hours
- Whatever fraction wins the most auctions
answer: 1
explain: Even pacing ties spend to elapsed time, so the target is fraction of budget spent equal to fraction of flight elapsed. At the halfway point that is about half the budget, and the control loop keeps actual spend near that line.
:::

:::q Pacing & Delivery
question: Halfway through a flight you are comfortably under your target cost per acquisition but well behind on spend. The right move is to:
- Lower the bid to protect cost per acquisition even further
- Raise the bid to spend faster, using the headroom while staying under target
- Hold the bid and let the remaining budget go unspent
- Remove the frequency cap so you can spend on already-saturated users
answer: 1
explain: You have cost-per-acquisition headroom, so the binding problem is underspend. Raising the bid speeds delivery and uses that headroom as long as cost per acquisition stays under target. Letting budget go unspent forfeits reach and conversions.
:::

:::q Quality & Fraud
question: Path A is a 2 dollar CPM with 20 percent invalid traffic. Path B is a 2.20 dollar CPM with no invalid traffic. Which is cheaper per valid impression?
- Path A, because its sticker CPM is lower
- Path B, because A's valid CPM is 2.50 dollars versus B's 2.20 dollars
- They are equal once you account for viewability
- You cannot tell without knowing each path's win rate
answer: 1
explain: Reprice on real impressions: A's valid CPM is 2 divided by 0.8, which is 2.50 dollars. Path B has no invalid traffic, so its valid CPM stays 2.20 dollars. The clean path is cheaper per real human despite the higher sticker price.
:::

:::q Measurement
question: A campaign shows strong attributed conversions, but a matched control group converts at the same rate as the treatment group. The incremental lift is:
- Near zero, because the ad did not change behavior versus the matched control
- High, because the attributed conversion count is high
- Negative, because attribution always double counts
- Impossible to compute without a ghost-bid design
answer: 0
explain: Lift is the treatment conversion rate minus the control conversion rate. If a matched control converts just as often, the ad caused no additional conversions, regardless of how many conversions attribution credited to it.
:::

:::q Auctions & Bidding
question: Three buyers submit sealed bids of 9 dollars, 7 dollars, and 4.50 dollars for one impression in a second-price auction. What does the winner pay?
- 7 dollars, the second-highest bid
- 9 dollars, the winning bid
- 4.50 dollars, the lowest bid
- 6.83 dollars, the average of the bids
answer: 0
explain: In a second-price auction the highest bidder (9 dollars) wins but pays the second-highest bid, which is 7 dollars. The winner's own bid only decides that it won, not the price it pays.
:::

:::q Auctions & Bidding
question: A trader is moved to a pure second-price exchange and asks how to bid. What is the dominant strategy?
- Shade well below value, as you would in a first-price auction
- Bid a fixed 20 percent above value to guarantee wins
- Bid the impression's true value, since your bid sets only whether you win, not the price
- Bid the publisher floor, since the floor is always the clearing price
answer: 2
explain: In a second-price auction the price you pay is the runner-up's bid, not your own, so bidding true value can never hurt you and is the dominant strategy. Shading is a first-price tactic and does not apply here.
:::

:::q Auctions & Bidding
question: An impression is worth 8 dollars to you, and in a first-price auction you bid 5.60 dollars. Expressed as a percent of value, how much are you shading?
- 56 percent
- 30 percent
- 70 percent
- 24 percent
answer: 1
explain: Shade is value minus bid, which is 8.00 minus 5.60 equals 2.40 dollars. As a percent of value that is 2.40 divided by 8.00, which equals 30 percent. You keep that 30 percent as margin on every win.
:::

:::q Valuation & Prediction
question: An impression has a predicted click rate of 0.4 percent and a predicted post-click conversion rate of 2 percent, and the advertiser values a conversion at 90 dollars. What is the expected value of the impression?
- 90 dollars
- 0.36 dollars
- 0.072 dollars
- 0.0072 dollars
answer: 3
explain: Expected value is pCTR times pCVR times conversion value: 0.004 times 0.02 times 90 equals 0.0072 dollars per impression. You discount the 90 dollar conversion by both funnel probabilities rather than bidding the full conversion value.
:::

:::q Valuation & Prediction
question: Across a slice of inventory a pCTR model's predicted click probabilities sum to 600 clicks, but 750 clicks actually occurred. What is the calibration ratio of predicted to actual, and which way is the model biased?
- 0.8, the model underpredicts clicks by 20 percent
- 1.25, the model overpredicts clicks by 25 percent
- 1.0, the model is perfectly calibrated
- 150, the model is off by 150 clicks
answer: 0
explain: Calibration ratio is predicted divided by actual, which is 600 divided by 750 equals 0.8. A ratio below 1 means the model underpredicts, here by 20 percent, so bids built on it are systematically too low.
:::

:::q Valuation & Prediction
question: Without a context signal an impression's expected value is 0.010 dollars. On pages that match the signal the expected value rises to 0.015 dollars. What context bid modifier does that justify?
- 5x, the difference in cents times 10
- 1.5x, the ratio of expected value with the signal to without it
- 0.67x, the inverse ratio
- 2.5x, the sum of the two values scaled
answer: 1
explain: A bid modifier should equal expected value with the signal divided by expected value without it: 0.015 divided by 0.010 equals 1.5x. That prices the signal correctly without overpaying for impressions you would win anyway.
:::

:::q Pacing & Delivery
question: A campaign has a 60,000 dollar budget over a 24 hour flight and paces evenly. By hour 18, what is the target cumulative spend?
- 60,000 dollars, the full budget
- 30,000 dollars, half the budget
- 45,000 dollars, three quarters of the budget
- 18,000 dollars, scaled to the hour number
answer: 2
explain: Fraction of the flight elapsed is 18 divided by 24, which equals 0.75. Target spend is 0.75 times 60,000, which equals 45,000 dollars. Even pacing keeps spent budget tracking elapsed time.
:::

:::q Pacing & Delivery
question: At a checkpoint the even-pacing target is 45,000 dollars but actual spend is 50,000 dollars. What is the pacing error (actual minus target), and what should the controller do?
- Minus 5,000 dollars, behind pace, so bid up
- Zero, on pace, so hold the bid
- 95,000 dollars, the running total
- Plus 5,000 dollars, ahead of pace, so pull back
answer: 3
explain: Error is actual minus target, which is 50,000 minus 45,000 equals plus 5,000 dollars. A positive error means the campaign is ahead of pace, so the controller should throttle down or lower the bid to protect the budget.
:::

:::q Quality & Fraud
question: A supply path quotes a 3.60 dollar CPM, but 10 percent of its traffic is invalid (IVT). What is the effective CPM per valid impression?
- 3.24 dollars
- 4.00 dollars
- 3.60 dollars
- 36.00 dollars
answer: 1
explain: Divide the quoted CPM by the valid share, which is 1 minus the IVT rate: 3.60 divided by 0.90 equals 4.00 dollars. A tenth of the traffic is junk, so each real impression costs more than the sticker price.
:::

:::q Quality & Fraud
question: A path runs 20 percent IVT and, after filtering, a 75 percent viewable rate. What share of bought impressions are both real and viewable?
- 95 percent
- 55 percent
- 60 percent
- 75 percent
answer: 2
explain: Multiply the valid share by the viewable rate: (1 minus 0.20) times 0.75 equals 0.80 times 0.75 equals 0.60, or 60 percent. Only that 60 percent is worth paying for, so price against it rather than the raw impression count.
:::

:::q Quality & Fraud
question: You must consolidate spend across several supply paths that reach the same inventory. What single number should rank the paths?
- The effective cost per quality impression, combining take rate, IVT, and viewability
- The raw sticker CPM alone, lowest first
- The number of intermediaries in the chain, most first
- The path with the highest win rate, ignoring fees
answer: 0
explain: Supply-path optimization is a ranking problem. You combine each path's take rate, IVT level, and viewability into one effective cost per quality impression, then route spend toward the best paths. Sticker CPM alone hides fraud and fees.
:::

:::q Measurement
question: A holdout test shows a treatment conversion rate of 4.0 percent and a matched control rate of 2.5 percent. A colleague reports a 60 percent lift. Which lift definition produced that number?
- Absolute lift, the difference in percentage points
- The calibration ratio of the two rates
- The attributed conversion count divided by control
- Relative lift, the difference divided by the control baseline
answer: 3
explain: Absolute lift is 4.0 minus 2.5 equals 1.5 percentage points. Relative lift divides that gap by the baseline: 1.5 divided by 2.5 equals 0.60, or 60 percent. The same experiment yields both numbers, so always state which one you mean.
:::

:::q Measurement
question: An analyst proposes measuring lift by comparing exposed users to all users who never saw the ad. Why is this control invalid?
- Unexposed users differ in ways the ad did not cause, so the comparison overstates lift
- It is valid, because a larger control is always better
- It undercounts lift, because unexposed users convert more
- It only works in a second-price auction
answer: 0
explain: An unmatched control of all non-exposed users differs systematically (less active, less in-market) from exposed users, and those differences were not caused by the ad. The control must be users who could have been treated but, by random assignment, were not, such as a ghost-bid holdout.
:::

:::q Measurement
question: A trader runs a difference-in-differences test across a test region and a control region. What assumption must hold for the estimate to be trustworthy?
- That both regions ran first-price auctions
- That the test region spent more than the control region
- That, absent the ad, the two regions would have moved together (parallel trends)
- That attribution credited every conversion correctly
answer: 2
explain: Difference-in-differences rests on the parallel-trends assumption: without the ad the two regions would have followed the same trend. If pre-period trends already diverged, the control no longer captures the counterfactual and the estimate is biased, so traders check that pre-period trends run parallel before trusting it.
:::
