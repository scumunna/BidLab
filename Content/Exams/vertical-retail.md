---
track: vertical-retail
title: Retail Media Certification
pass: 0.7
draw: 12
---
:::q KPIs and the buyer mandate
question: A branded-defense campaign reports $60,000 in attributed sales on $9,000 of spend. The client asks for the ACoS. What do you report?
- 6.67%
- 10%
- 12%
- 15%
answer: 3
explain: ACoS is ad spend divided by attributed sales: 9,000 / 60,000 = 0.15, which is 15%. The equivalent closed-loop ROAS is 60,000 / 9,000, about 6.7x.
:::

:::q KPIs and the buyer mandate
question: A SKU shows $30,000 in ad-attributed sales and $120,000 in organic sales on $12,000 of ad spend. What is the TACoS, and what does this level signal for an established product?
- 40%, an alarming TACoS that means advertising is unprofitable
- 8%, a healthy TACoS comfortably inside the under-10% band for established products
- 10%, exactly at the ceiling and a sign organic demand is collapsing
- 25%, the correct read because TACoS uses only ad-attributed sales
answer: 1
explain: TACoS is ad spend over total brand sales (ad plus organic): 12,000 / (30,000 + 120,000) = 8%. Under 10% is the cited healthy band for an established product, and a falling TACoS over time is the real success signal.
:::

:::q KPIs and the buyer mandate
question: The console prints a 10x closed-loop ROAS ($50,000 attributed sales on $5,000 spend) for a branded-defense line, but an AMC lift test finds only 25% of those sales were incremental. What is the iROAS the holdout actually supports?
- 10x, because closed-loop ROAS is the spend-efficiency number that matters
- 7.5x, because you subtract the 25% that was incremental
- 4x, because lift only reduces ROAS by one quarter
- 2.5x, because only the incremental quarter of sales counts against spend
answer: 3
explain: Incremental sales are 0.25 x 50,000 = 12,500, so iROAS is 12,500 / 5,000 = 2.5x (equivalently lift x ROAS = 0.25 x 10). The 10x print was mostly demand the brand already owned.
:::

:::q KPIs and the buyer mandate
question: Two lines compete for the next dollar. Branded defense posts 6x closed-loop ROAS at a measured 25% lift. A conquesting line posts 3x closed-loop ROAS at a measured 80% lift. Where should the incremental dollar go, and why?
- Branded defense, because its 6x closed-loop ROAS is double the conquesting line's 3x
- Branded defense, because its iROAS of 0.25 x 6 = 1.5x beats the conquesting line
- Split the dollar evenly, because closed-loop ROAS and lift offset each other exactly
- Conquesting, because its iROAS of 0.80 x 3 = 2.4x beats branded defense at 0.25 x 6 = 1.5x
answer: 3
explain: iROAS equals lift times closed-loop ROAS. Branded defense is 0.25 x 6 = 1.5x and conquesting is 0.80 x 3 = 2.4x, so the incremental dollar goes to the conquesting line despite its lower closed-loop ROAS.
:::

:::q Auction mechanics
question: On Amazon's upgraded second-price search auction, Bidder A enters a $1.30 max bid with a relevance score of 1.0 and Bidder B enters a $0.90 max bid with a relevance score of 1.6 for the same slot. Who ranks higher?
- Bidder A, because $1.30 is the higher raw dollar bid
- Bidder B, because its effective bid of $1.44 beats A's $1.30
- They tie, because the auction averages bid and relevance
- Bidder A, because relevance only affects the price paid, not rank
answer: 1
explain: Rank is set by effective bid = max bid x relevance. A is 1.30 x 1.0 = 1.30 and B is 0.90 x 1.6 = 1.44, so B ranks higher with a lower raw bid because its listing is more relevant.
:::

:::q Auction mechanics
question: You set a $1.20 base bid with a +50% top-of-search placement modifier. What bid actually enters the top-of-search auction?
- $1.20, because the modifier applies to the price paid, not the entered bid
- $0.60, because a 50% modifier halves the bid
- $1.80, because the base bid is multiplied by 1.5
- $2.40, because the base bid is doubled
answer: 2
explain: A placement-adjusted bid is base bid x (1 + modifier): 1.20 x 1.5 = 1.80. The modifier is a multiplier on the base bid for that slot, not a separate flat bid.
:::

:::q Auction mechanics
question: You win an on-site sponsored slot with a $1.40 max bid. The next-highest effective bid in the auction clears at $0.92. Ignoring relevance de-rating, what is your approximate cost per click?
- About $0.93, the runner-up effective bid plus one cent
- About $1.40, because you pay your own max bid
- About $1.16, the midpoint of your bid and the runner-up
- About $0.46, half of your max bid
answer: 0
explain: Second-price clearing is the next-highest effective bid plus about one cent: 0.92 + 0.01 = 0.93. Your $1.40 only determined that you won the slot, not the price, which is why a high max bid is safe when no competitor sits directly beneath you.
:::

:::q Auction mechanics
question: A trader sets a $1.50 base bid, a +100% top-of-search modifier, and leaves dynamic up-and-down on (which can raise top-of-search by up to another 100%). What is the worst-case bid that can enter the top-of-search auction?
- $6.00, because the platform applies the modifier first, then dynamic bidding can raise that result
- $1.50, because dynamic up-and-down only lowers bids
- $3.00, because the two adjustments do not stack
- $4.50, because each setting independently triples the base
answer: 0
explain: The placement modifier applies first: 1.50 x (1 + 1.00) = 3.00. Then dynamic up-and-down can raise that by up to 100%: 3.00 x (1 + 1.00) = 6.00. Compounding the modifier with dynamic bidding is the most common way traders blow a CPC ceiling.
:::

:::q Bidding, budgeting and pacing
question: A SKU has a target ACoS of 30%, an AOV of $60, and an expected conversion rate of 5%. What starting bid (the value of a click at target) should you enter?
- $0.90, because starting bid = target ACoS x AOV x CVR
- $1.80, because you bid the full AOV times the ACoS
- $3.00, because the bid equals AOV times the ACoS
- $0.30, because the bid equals AOV times CVR
answer: 0
explain: Starting bid = target ACoS x AOV x CVR = 0.30 x 60 x 0.05 = 0.90. That is the most you can pay per click and still hold a 30% ACoS at a 5% conversion rate.
:::

:::q Bidding, budgeting and pacing
question: A manual exact keyword is running at a $1.50 bid, your target ACoS is 25%, and the term's actual ACoS is 30%. Applying the bid-adjustment formula, what is the corrected bid?
- $1.80, because you raise the bid to capture more sales
- $1.50, because a 5-point overshoot is within tolerance
- $1.25, because new bid = current bid x (target / actual ACoS)
- $0.75, because you halve the bid when ACoS overshoots
answer: 2
explain: New bid = current bid x (target ACoS / actual ACoS) = 1.50 x (25 / 30) = 1.25. Actual ACoS ran above target, so the formula pulls the bid down to drag realized ACoS back toward 25%.
:::

:::q Bidding, budgeting and pacing
question: A campaign with a flat-paced daily budget exhausts its full budget by 3 PM every day. For roughly how many of the 24 hours is it dark on budget, and why does this matter?
- 0 hours, because the budget reset covers the rest of the day
- 3 hours, because only the final stretch before midnight is lost
- 15 hours, because the campaign spent for 15 hours before going dark
- 9 hours, ceding the high-intent evening auctions that often have softer CPCs
answer: 3
explain: From midnight to 3 PM is 15 hours of spending, so 24 minus 15 = 9 hours dark. The campaign never competes in the evening window where CPCs often soften as rivals run out of budget, so volume and sales are capped even if ACoS looks fine.
:::

:::q Bidding, budgeting and pacing
question: A campaign posts an unusually low ACoS but flat total sales, and its budget is fully spent by 11 AM every day. What is the most likely explanation?
- The bids are far too high for the category
- Budget exhaustion is hiding lost afternoon and evening sales, a pacing illusion rather than real efficiency
- The conversion rate has collapsed and the listing must be fixed
- The attribution window was shortened, which lowered reported sales
answer: 1
explain: An early-exhausting budget means only the cheapest morning clicks ran, so ACoS looks elite while afternoon and evening sales are never bought. It is a pacing artifact, and the fix is to raise or reallocate budget and consider dayparting, not to celebrate the low ACoS.
:::

:::q Off-site DSP execution and supply path
question: An off-site line buys an RMN audience at a $6.00 working-media CPM, and the stacked DSP, exchange, and data fees add 30%. What effective gross CPM does the brand actually pay?
- $4.20, because the fees are subtracted from working media
- $6.00, because fees apply only to on-site media
- $6.30, because a 30% fee adds about thirty cents
- $7.80, because gross CPM = working CPM x (1 + fee load)
answer: 3
explain: Effective gross CPM = working CPM x (1 + fee load) = 6.00 x 1.30 = 7.80. The brand pays $7.80 per thousand impressions but only $6.00 actually buys the audience; the rest is the take-rate stack that SPO and deal-IDs work to claw back.
:::

:::q Off-site DSP execution and supply path
question: A campaign serves 3,600,000 impressions across on-site and off-site to 900,000 unique users. What is the cross-channel frequency, and what is the operational risk hidden in that average?
- 0.25 impressions per user, so the campaign is under-delivering badly
- 4.0 impressions per user, but a per-DSP-only cap can let a tail of users sit at 15-plus
- 4.0 impressions per user, which guarantees no user is over-exposed
- 3.24 million, because frequency is total impressions times reach
answer: 1
explain: Cross-channel frequency = 3,600,000 / 900,000 = 4.0 impressions per user. A defensible average can still hide over-exposure if frequency is only capped inside each DSP and not across on-site plus off-site, letting some shoppers see 15 or more impressions on the most expensive media in the plan.
:::

:::q Off-site DSP execution and supply path
question: Two CTV deals both quote a $36 CPM. Deal A completes at 90% and Deal B at 80%. Using completion-weighted CPM, which is cheaper per completed view?
- Deal B, because a lower completion rate means cheaper inventory
- They cost the same, because the headline CPM is identical
- Deal A, because $36 / 0.90 = $40.00 beats $36 / 0.80 = $45.00 per completed view
- Deal A, but only if it also carries a deal-ID
answer: 2
explain: Completion-weighted CPM is CPM divided by completion rate. Deal A is 36 / 0.90 = $40.00 and Deal B is 36 / 0.80 = $45.00 per completed view, so Deal A is cheaper despite matching headline CPMs. CTV is never compared on raw CPM alone.
:::

:::q Off-site DSP execution and supply path
question: An off-site DSP line drives $36,000 of incremental sales (measured against a holdout) on $12,000 of gross spend that already includes all DSP, exchange, and data fees. How should you judge it, and what is the iROAS?
- 3.0x iROAS on gross spend, a real and defensible result because the fees are already inside the denominator
- 3.0x iROAS, but only valid if measured on working media instead of gross
- 4.5x iROAS, because you should exclude the take-rate from the spend
- Reject it, because any off-site ACoS above 100% is automatically a failure
answer: 0
explain: iROAS on gross is incremental sales over gross spend: 36,000 / 12,000 = 3.0x. Because the $12,000 already carries the full take-rate stack, a 3.0x iROAS on gross is the honest, defensible number; measuring on working media would flatter it.
:::

:::q Fees, take-rates and reconciliation
question: A brand pays $250,000 in gross media for an off-site flight, and total fees plus agency margin come to 40% of gross. How much working media actually reaches impressions?
- $100,000, because working media is 40% of gross
- $150,000, because working media is gross minus the 40% fee load
- $350,000, because fees are added on top of gross
- $210,000, because only the agency margin is deducted
answer: 1
explain: Fees plus margin take 40% of 250,000, which is $100,000, so working media is 250,000 minus 100,000 = $150,000, a working-media ratio of 0.60. The brand is charged on gross but the campaign only performs on working.
:::

:::q Fees, take-rates and reconciliation
question: Your Amazon Campaign Manager reports $118,000 of spend for the month, but the advertising invoice (which folds in off-site DSP media and stacked fees) comes to $145,000. What is the reconciliation gap, and how should you treat it?
- $263,000, because you add the console and invoice figures
- $27,000, and it should be ignored as a normal rounding difference
- $118,000, because the console number is the true spend
- $27,000, and every dollar must be attributed to off-site media, fee layers, or accrual timing
answer: 3
explain: Reconciliation gap is invoice minus console: 145,000 minus 118,000 = $27,000. That gap is the off-site media and fee layer the on-site console did not display, and it must be explained line by line rather than left as an unexplained variance finance will distrust.
:::

:::q Fees, take-rates and reconciliation
question: The ANA Q1 2026 benchmark shows a top cohort converting 54.0% of programmatic spend into qualified impressions while the bottom cohort converts 32.1%. For a line with a 0.60 working-media ratio, what is the ad-tech tax, and what is the ANA's core finding about the gap?
- 40%, and the cohort gap is driven mostly by media productivity (quality), not transaction cost
- 60%, and the gap is driven mostly by DSP fee differences
- 40%, and the gap is driven mostly by currency conversion on invoices
- 46%, and the gap is purely a transaction-cost problem
answer: 0
explain: Ad-tech tax is 1 minus the working-media ratio: 1 minus 0.60 = 40%. The ANA's framing is that the cohort gap is a quality gap (media productivity, the non-viewable and made-for-advertising supply that burns working media) far more than a transaction-cost gap, so cutting low-quality supply beats only negotiating fees.
:::

:::q Fees, take-rates and reconciliation
question: An off-site campaign drives $60,000 of incremental sales (versus a holdout) on $40,000 of gross media, and its working-media ratio is 0.50. A vendor quotes the iROAS as 3.0x. On which denominator did they compute it, and what is the gross figure the CFO should see?
- They used gross media, and the gross iROAS is 3.0x
- They used working media; the honest iROAS on gross is 2.0x
- They used working media; the honest iROAS on gross is 1.5x
- They used gross media; the working figure would be lower at 1.5x
answer: 2
explain: Working media is 40,000 x 0.50 = $20,000, so 60,000 / 20,000 = 3.0x is the working-media iROAS. On gross the figure is 60,000 / 40,000 = 1.5x, which is the cash the brand actually paid, so the first operator question on any quoted iROAS is which dollar it sits on.
:::

:::q Measurement, incrementality and clean rooms
question: A conversion-lift study shows the exposed group converting at 7.5% and the matched control converting at 5.0%. What is the lift percentage?
- 2.5%, the raw difference in conversion rates
- 33%, the difference divided by the exposed rate
- 50%, the difference divided by the control rate
- 150%, the exposed rate divided by the control rate
answer: 2
explain: Lift % = (exposed conv rate minus control conv rate) / control conv rate = (7.5 minus 5.0) / 5.0 = 0.50, a 50% lift. The control proves 5 points would have converted anyway, and the ad caused the extra 2.5 points, measured over the control baseline.
:::

:::q Measurement, incrementality and clean rooms
question: A geo holdout runs across 200 matched stores. The 100 exposed stores post $600,000 in category sales over the test, the 100 control stores post $480,000, and the campaign spent $40,000. What is the iROAS?
- 3.0x, because incremental sales are exposed minus control, then divided by spend
- 15.0x, because you divide exposed sales by spend
- 1.25x, because you divide exposed by control sales
- 12.0x, because you divide control sales by spend
answer: 0
explain: Incremental sales are exposed minus control: 600,000 minus 480,000 = $120,000. iROAS = 120,000 / 40,000 = 3.0x. The console might credit the full $600,000 and print a far higher closed-loop ROAS, but only the $120,000 gap survives the holdout.
:::

:::q Measurement, incrementality and clean rooms
question: Amazon reports $50,000, Walmart reports $35,000, and Instacart reports $25,000 in attributed sales, but a clean-room match finds $18,000 of those conversions were claimed by more than one network. What is the de-duplicated total finance should book?
- $128,000, the simple sum of all three consoles
- $110,000, the sum with no adjustment because each console is closed-loop
- $92,000, the sum minus the overlap counted once
- $18,000, only the overlap that was double-claimed
answer: 2
explain: The sum is 50,000 + 35,000 + 25,000 = $110,000, and de-duplicated sales subtract the overlap once: 110,000 minus 18,000 = $92,000. Summing the raw consoles would overstate reality by the $18,000 that overlapping windows let multiple networks claim.
:::

:::q Measurement, incrementality and clean rooms
question: An AMC review shows a retargeting line spending $25,000 at a 1.2x iROAS while a new-to-brand segment measures at 3.6x iROAS. If you move the full $25,000 from retargeting to new-to-brand, how many additional incremental dollars do you generate?
- $90,000, the new-to-brand incremental sales alone
- $60,000, the difference between 3.6x and 1.2x applied to the moved budget
- $30,000, the retargeting incremental sales alone
- $120,000, the sum of both incremental figures
answer: 1
explain: New-to-brand incremental is 3.6 x 25,000 = $90,000 and retargeting incremental is 1.2 x 25,000 = $30,000, so the reallocation adds 90,000 minus 30,000 = $60,000 in caused sales. This is the documented AMC-revealed lever of shifting budget from low-incremental retargeting to high-incremental new-to-brand.
:::
