---
id: vertical-retail-05
track: vertical-retail
module: 5
title: Bidding, Budgeting and Pacing, Bid Strategies, Translating an ACoS Target into a Starting Bid, and Intraday Pacing
summary: Choose the right bid strategy, size a starting bid from a target ACoS, correct it with the bid-adjustment formula, and read intraday pacing so a budget does not go dark before the shopper does.
---
# Three bid strategies, one decision per campaign

This is the day-one operational core of the retail-media trader role. Before any audience or keyword logic, Amazon makes you choose one bid strategy per campaign, and the choice decides whether your entered bid is used as-is or quietly rewritten in every auction. FIXED uses your bid unchanged in every opportunity (manual placement modifiers still apply). DYNAMIC DOWN-ONLY lowers the bid in real time when a conversion looks unlikely and never raises it, while DYNAMIC UP-AND-DOWN raises the bid by up to +100% for top-of-search and up to +50% for other placements when a conversion looks likely, and lowers it otherwise.

The practitioner default is down-only as the safe start, fixed once a SKU is ranked and converting to protect margin, and up-and-down for launches where velocity and rank matter more than short-term ACoS. The trap is that up-and-down compounds with the top-of-search placement modifier from the auction lesson, so the realized cost per click can run far above the base bid you sized.

:::quiz
question: Which Amazon bid strategy can RAISE your entered bid (up to +100% at top-of-search) when a conversion looks likely?
- Fixed bids
- Dynamic down-only
- Dynamic up-and-down
- Automated portfolio bidding
answer: 2
hint: Only one strategy is allowed to bid higher than the number you typed.
explain: Dynamic up-and-down is the only strategy that increases your bid in real time, by up to 100 percent at top-of-search and up to 50 percent elsewhere. Fixed never adjusts, and down-only can only lower the bid, never raise it.
:::

# Translating a target ACoS into a starting bid

The foundational skill is turning an efficiency mandate into a number you can actually enter. A click is worth, at most, the sales it is expected to drive times the share of those sales you are willing to spend on advertising. That gives the starting-bid formula, where AOV is average order value and CVR is the expected conversion rate.

$$ \text{starting bid} = \text{target ACoS} \times \text{AOV} \times \text{CVR} $$

This is also the maximum profitable cost per click at target: bid above it and you breach the ACoS ceiling, bid below it and you leave efficient volume on the table. A brand-new ASIN has no CVR history, so traders seed the CVR with a category benchmark, then tighten the bid after the first conversion data lands.

:::predict
prompt: Target ACoS is 25%, AOV is $40, and expected CVR is 10%. What is the starting bid (the value of a click at target)?
answer: 1
tolerance: 0.01
unit: USD
hint: Multiply the three inputs: target ACoS times AOV times CVR.
explain: 0.25 times 40 times 0.10 = 1.00, so the starting bid is $1.00. That is the most you can pay per click and still hold a 25 percent ACoS at a 10 percent conversion rate, because 10 clicks at $1.00 cost $10 and produce one $40 order, which is exactly 25 percent ACoS.
:::

:::predict
prompt: A second SKU has target ACoS 20%, AOV $50, and expected CVR 8%. What is its starting bid?
answer: 0.8
tolerance: 0.01
unit: USD
hint: Same formula: 0.20 times 50 times 0.08.
explain: 0.20 times 50 = 10, and 10 times 0.08 = 0.80, so the starting bid is $0.80. Lower conversion or a tighter ACoS target both pull the affordable click price down, which is why two SKUs at the same price can warrant very different bids.
:::

# The bid-adjustment formula keeps you on target

You rarely hit the target on the first try, so the continuous-optimization move is to scale the live bid toward the goal. When actual ACoS overshoots the target you are overpaying and must come down, and when actual beats target you have room to push up for more volume. The practitioner-standard rule multiplies the current bid by the ratio of target to actual ACoS.

$$ \text{new bid} = \text{current bid} \times \frac{\text{target ACoS}}{\text{actual ACoS}} $$

A common guardrail layered on top: disable up-and-down once actual ACoS exceeds target by roughly 5 percentage points, so the automation stops bidding higher into a campaign that is already inefficient. The figure below shows why pacing context matters before you trust any ACoS reading at all.

:::figure pacingCurve
caption: Cumulative budget burn across the day. A campaign that exhausts its daily budget by noon goes dark for the entire afternoon and evening, so the only clicks it ever bought were the cheap morning ones, which flatters ACoS while hiding lost sales.
:::

:::predict
prompt: Current bid is $1.20, target ACoS is 20%, and actual ACoS is 30%. What is the adjusted bid?
answer: 0.8
tolerance: 0.01
unit: USD
hint: Multiply the current bid by target divided by actual: 1.20 times (20 / 30).
explain: 20 / 30 = 0.667, and 1.20 times 0.667 = 0.80, so the bid drops to $0.80. Actual ACoS ran 1.5 times the target, so the formula cuts the bid to two-thirds of its former level to pull realized ACoS back toward 20 percent.
:::

# Pacing decides whether the budget lasts the day

A budget is daily or lifetime, and intraday pacing decides whether the daily cap burns by noon or stretches across all open hours. Flat pacing aims to spend the daily budget evenly, while accelerated pacing front-loads it. Budget utilization is spend divided by budget: below 1.0 means you are underpacing and leaving auctions unentered, while hitting 1.0 early in the day is the exhaustion signal.

$$ \text{daily pace target} = \frac{\text{daily budget}}{\text{hours open}} $$

When a $300 daily budget is gone by noon, the campaign is dark on budget for the remaining 12 hours, ceding every afternoon and evening auction to competitors whose budgets are still live. The widely cited 2026 operator pattern is that CPCs often soften from roughly 6 PM to midnight as rivals run out of money, so the trader who paces to reach that window can buy cheaper clicks the noon-exhausted competitor never sees.

:::predict
prompt: A $300 daily budget is fully spent by 12:00 noon. For roughly how many of the 24 hours is the campaign dark on budget?
answer: 12
tolerance: 0.5
unit: hours
hint: Subtract noon (hour 12) from the full 24-hour day.
explain: From midnight to noon is 12 hours of spending, leaving 24 minus 12 = 12 hours dark. The campaign never competes in the afternoon or evening, so its impression volume and total sales are capped no matter how strong the bids look.
:::

:::widget lineChart
title: Cumulative ad availability across the day when a daily budget exhausts at noon
labels: 8am, 10am, 12pm, 2pm, 4pm, 6pm, 8pm
data: 100, 100, 100, 0, 0, 0, 0
unit: percent available
:::

# The pacing illusion and the iROAS that survives it

Here is the buy-side trap that ties pacing to the vertical's signature KPI. Early budget exhaustion makes ACoS look excellent, because only the cheapest morning clicks ever ran, while the afternoon sales you never had simply do not appear in the denominator. A pretty ACoS print on a budget-starved campaign is a measurement artifact, not real efficiency, and the only number that survives the scrutiny is iROAS, the return on the sales the ad actually CAUSED rather than merely got credited.

$$ \text{iROAS} = \frac{\text{incremental sales}}{\text{ad spend}} $$

A campaign can post a glamorous closed-loop ROAS while its iROAS is mediocre, especially on branded-defense terms that harvest demand you already owned. The trader's job is to pace the budget to compete when shoppers are actually buying, then judge the result on incremental return, not on a flattering ACoS produced by going dark at lunchtime.

:::predict
prompt: A campaign drives $30,000 of incremental sales (measured against a matched holdout) on $10,000 of ad spend. What is the iROAS?
answer: 3
tolerance: 0.05
unit: x
hint: Divide incremental sales by ad spend.
explain: 30,000 / 10,000 = 3.0, so the iROAS is 3.0x. Unlike closed-loop ROAS, this number counts only the sales the ad caused, so a high closed-loop ROAS with a low iROAS is a sign you are paying for demand that would have converted anyway.
:::

:::callout warning
A top operator complaint on r/PPC and r/AmazonSeller is "my ACoS is amazing but sales are flat." The cause is almost always mid-morning budget exhaustion: the campaign spends out before the high-intent afternoon and evening hours, so it never competes when most shoppers buy, and the surviving morning clicks make ACoS look elite while total volume stalls. Always check budget utilization and the hour of exhaustion before celebrating a low ACoS, and never optimize a bid on a campaign that is going dark by lunch.
:::

# Putting the dials together in the weekly loop

In practice the trader runs these dials as a loop, not a one-time setup. Size the starting bid from the target ACoS, choose down-only or fixed for stable SKUs and up-and-down only for launches, set a daily budget that survives to the high-converting evening window, and then each week apply the bid-adjustment ratio to drag actual ACoS toward target while watching for exhaustion and the up-and-down guardrail. Every move is a small, reversible step, and you verify the pacing curve and the iROAS before trusting any single ACoS number.

:::callout key
The starting-bid formula and the bid-adjustment formula are two ends of the same control loop: one sizes the bid from a target, the other corrects it from observed results. Bid equals target ACoS times AOV times CVR to start; new bid equals current bid times target over actual ACoS to optimize. Master both and you can defend an efficiency mandate without guessing.
:::

:::quiz
question: A campaign reports an unusually low ACoS but flat total sales, and its budget is spent by 11 AM every day. What is the most likely explanation?
- The bids are far too high for the category
- Budget exhaustion is hiding lost afternoon and evening sales
- The conversion rate has collapsed
- The attribution window was shortened
answer: 1
hint: Think about which auctions the campaign is no longer entering after late morning.
explain: An early-exhausting budget means only the cheapest morning clicks ran, so ACoS looks great while afternoon and evening sales are simply never bought. It is a pacing illusion, not real efficiency, and the fix is to raise or reallocate budget and consider dayparting toward high-converting hours.
:::

:::sources
- Amazon Ads, Guide to dynamic bidding (up and down) with Sponsored Products | https://advertising.amazon.com/library/guides/dynamic-bidding-sponsored-products
- Advigator, Amazon Ads Course: Bidding Strategies, Dynamic vs Fixed Bids | https://www.advigator.com/amazon-ads-course/optimization/bidding-strategies.html
- Clickstera, Amazon PPC Bid Calculator 2026: How to Set the Right Bid | https://clickstera.com/blog/amazon-ppc-bid-calculator-2026-how-to-set-the-right-bid
- AdLabs, Amazon PPC Bid Optimization: The 4 Essential Formulas for Hitting Your Target ACoS | https://adlabs.app/amazon-ppc-bid-optimization-the-4-essential-formulas-for-optimizing-bids-hitting-your-target-acos/
- Off-Hours, Amazon Ads Budget Rules: How to Stop Running Out of Budget at the Wrong Time | https://www.off-hours.app/blog/amazon-ads-budget-rules-guide
- Seller Labs, How Amazon Dayparting Can Skyrocket Your Ad Profits in 2026 | https://www.sellerlabs.com/blog/amazon-dayparting-ad-strategy-2026/
- Titannetwork, Amazon Bid Strategy Guide for 2026 | https://titannetwork.com/amazon-bid-strategy-guide/
- IAB, Guidelines for Incremental Measurement in Commerce Media (Nov 2025) | https://www.iab.com/guidelines/guidelines-for-incremental-measurement-in-commerce-media/
:::
