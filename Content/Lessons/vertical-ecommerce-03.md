---
id: vertical-ecommerce-03
track: vertical-ecommerce
module: 3
title: Amazon Efficiency Core, ACoS, TACoS, and the Ad-to-Organic Rank Flywheel
summary: Compute ACoS and TACoS, set a margin-based bid ceiling, and use the launch-then-taper flywheel to grow organic rank without confusing efficiency with growth.
---
# Two metrics that run the Amazon day

On a stack that is roughly 75 to 80 percent Amazon, two efficiency numbers anchor almost every decision you make. ACoS (Advertising Cost of Sale) is ad spend divided by ad-attributed sales, and it measures one campaign in isolation. TACoS (Total Advertising Cost of Sale) is ad spend divided by total sales, ad plus organic, and it tells you whether those ads are building durable momentum or just renting today's revenue.

$$ \text{ACoS} = \frac{\text{Ad spend}}{\text{Ad-attributed sales}} \qquad \text{TACoS} = \frac{\text{Ad spend}}{\text{Total sales (ad + organic)}} $$

The difference matters because ACoS is blind to organic sales by construction, and organic is exactly where the long-run profit lives. Average Amazon ACoS sat around 30 percent in 2025, with strong Sponsored Products campaigns in the 15 to 25 percent range, so a single number out of context tells you very little.

:::predict
prompt: A Sponsored Products campaign spends $3,000 and generates $12,000 in ad-attributed sales. What is the ACoS?
answer: 25
tolerance: 0.5
unit: %
hint: ACoS is ad spend divided by ad-attributed sales.
explain: 3,000 / 12,000 = 0.25, a 25 percent ACoS. That sits in the strong 15 to 25 percent Sponsored Products band, but ACoS alone says nothing about the organic sales the campaign may also be driving.
:::

# TACoS is the momentum gauge

Because ACoS ignores organic revenue, you need a second lens that sees the whole listing. TACoS divides the same ad spend by total sales, so when organic sales grow while ad spend holds flat, TACoS falls. A falling TACoS at flat or rising total sales is the signal that organic is carrying more of the listing, which is the entire point of advertising a product you also want to rank for.

$$ \text{Organic sales (implied)} = \text{Total sales} - \text{Ad-attributed sales} $$

Mature TACoS targets cluster by goal: under 10 percent for an established product, 10 to 12 percent when you are optimizing for profit, and 20 to 25 percent when you are deliberately prioritizing growth. Sellers who actually track TACoS are cited as about 2.3 times more likely to hit profitable growth, because they stop judging a listing on the half of the picture that ACoS shows.

:::predict
prompt: Ad spend is $5,000; ad-attributed sales are $20,000 and organic sales are $30,000. What is the TACoS?
answer: 10
tolerance: 0.5
unit: %
hint: TACoS is ad spend divided by total sales, where total sales is ad plus organic.
explain: Total sales = 20,000 + 30,000 = 50,000, so TACoS = 5,000 / 50,000 = 0.10, a 10 percent TACoS. Note the ACoS here is 5,000 / 20,000 = 25 percent. Same spend, two very different stories, and the 10 percent TACoS is the one that reflects the organic base.
:::

:::callout key
ACoS answers "is this campaign efficient right now." TACoS answers "are these ads making the listing healthier over time." When the two disagree, the trader leads with TACoS, because organic rank is the asset and ad spend is just the lever that builds it.
:::

# The flywheel: launch hot, then taper

The mechanic that connects the two metrics is the ad-to-organic flywheel. Sponsored Products drive sales velocity, velocity lifts organic rank in Amazon's A9/A10 algorithm, and that earned organic rank then produces sales with no incremental ad spend, sales that never appear in ACoS at all. The playbook is to run an aggressive launch ACoS, often 40 to 50 percent, to buy velocity early, then taper ad spend and manage to a mature TACoS as organic carries the listing.

This is why a launch judged on ACoS alone gets killed before it spins. During the launch window ACoS looks expensive precisely because you are paying to build a rank position that pays you back later through organic. Average Amazon CPCs climbed to about $1.12 in 2025, up 15.5 percent year over year, so the taper is not optional, you ramp velocity, then pull spend back as rank holds.

:::figure pacingCurve
caption: The flywheel over a launch. ACoS runs hot in the launch window to buy velocity and organic rank, then ad spend tapers and mature TACoS settles into the single digits as organic sales carry the listing.
:::

:::widget lineChart
title: ACoS taper across a product launch
labels: Launch, Month 2, Month 3, Month 4, Month 5, Month 6
data: 45, 32, 24, 18, 14, 11
unit: %
:::

# The bid ceiling comes from margin, not vanity

Neither ACoS nor TACoS tells you what to actually bid; contribution margin does. Your break-even ACoS is simply the contribution margin percent before ad spend, because at that point every incremental ad dollar is exactly offset by the margin it buys. Anything below break-even is profit on the ad-attributed sale, anything above it is buying rank (defensible during a launch) or burning money (not defensible at maturity).

$$ \text{Break-even ACoS} = \text{Contribution margin \% before ad spend} \qquad \text{Target CPC} = \text{Target ACoS} \times \text{AOV} \times \text{conversion rate} $$

That target CPC formula is how a P&L ceiling becomes an auction bid. With rising CPCs the discipline is to let the margin-derived ceiling cap the bid, not a round-number ACoS goal someone picked because it sounds healthy.

:::predict
prompt: A product carries a 35% contribution margin before ad spend. What is the break-even ACoS?
answer: 35
tolerance: 0.5
unit: %
hint: At break-even, ACoS equals the contribution margin available before ad spend.
explain: Break-even ACoS = contribution margin % = 35 percent. Below 35 percent ACoS the ad-attributed sale is profitable; above it you are either buying organic rank on purpose or eroding margin by accident.
:::

:::predict
prompt: Target ACoS is 20%, AOV is $50, and the conversion rate is 12%. What is the max CPC?
answer: 1.2
tolerance: 0.02
unit: USD
hint: Max CPC = target ACoS x AOV x conversion rate.
explain: 0.20 x 50 x 0.12 = 1.20, a max CPC of $1.20. Each click costs at most $1.20, each converting click (12 percent of them) returns $50 of sales, and ad cost lands at 20 percent of that sales value. With 2025 CPCs near $1.12 this product has almost no headroom, so the margin ceiling, not a vanity ACoS, must govern the bid.
:::

# Why the north star is still LTV to CAC

ACoS and TACoS keep the Amazon listing honest, but the role's actual scoreboard is LTV:CAC and contribution margin net of returns, not any platform efficiency number. A low ACoS on a product that buyers return, or that never earns a second purchase, is a bad outcome dressed up as a good one. Tie the launch-hot decision to the lifetime value you expect to earn, because that is what justifies a 40 to 50 percent launch ACoS in the first place.

$$ \text{LTV:CAC} = \frac{\text{Customer Lifetime Value}}{\text{Customer Acquisition Cost}} $$

A healthy DTC target is about 3:1, with payback under roughly 12 months. If your launch math only pencils on a 3-month payback that the CFO will not fund, the aggressive launch ACoS is a fantasy, so the efficiency metrics and the north star have to be set together.

:::predict
prompt: Gross-margin LTV is $210 and fully-loaded CAC is $70. What is the LTV:CAC ratio?
answer: 3
tolerance: 0.05
unit: ratio (x:1)
hint: Divide lifetime value by acquisition cost.
explain: 210 / 70 = 3.0, a 3:1 ratio, right at the healthy DTC benchmark. This is the number that tells you whether the launch-ACoS investment pays back, where ACoS alone never could.
:::

:::quiz
question: A product launch is running a 45% ACoS while its TACoS is falling month over month and total sales are climbing. What is the most likely correct read?
- The campaign is failing and should be paused to protect margin
- The flywheel is working, velocity is buying organic rank that is now carrying total sales
- ACoS and TACoS are contradicting each other, so the data must be wrong
- The product is being returned at a high rate
answer: 1
hint: Falling TACoS with rising total sales is the signature of the flywheel.
explain: A high launch ACoS with a falling TACoS and rising total sales is exactly the flywheel spinning up, velocity is lifting organic rank, and organic is taking over total sales. Pausing here would kill the rank you are paying to build. The other readings misinterpret a healthy launch.
:::

# Where the flywheel quietly breaks

The flywheel only spins if the listing can actually convert the velocity you are buying, and two silent failures can stop it cold. Brand-defense keywords inflate reported ACoS performance with sales you would have won organically anyway, so the paid-versus-organic cannibalization question is unanswerable without a brand-term holdout (covered in the incrementality lesson). And because organic sales are not ad-attributed, a stockout or a lost buy box tanks both organic rank and the flywheel even while ACoS still looks fine.

:::callout warning
Operators rank "ads kept spending while we were out of stock" as their most expensive, most repeated Amazon mistake, and many only find out from a sudden ACoS spike rather than any alert. Amazon does not auto-pause Sponsored Products during a stockout, so spend keeps flowing, almost nothing converts, the lost velocity drops organic rank, and A9 gets a weak signal that undoes the flywheel you spent to build. Inventory-aware automation or a manual stock-check cadence is mandatory hygiene, not a nice-to-have.
:::

:::quiz
question: Which scenario should worry a trader the MOST, even though the reported ACoS looks acceptable?
- ACoS at 22% with stable total sales and the buy box owned
- ACoS at 28% during a planned launch ramp
- ACoS at 20% while the best-seller has been out of stock for three days
- ACoS at 25% with TACoS slowly falling
answer: 2
hint: Think about what ACoS cannot see when conversions and organic rank are collapsing underneath it.
explain: A stockout keeps ads spending with almost no conversions and silently destroys organic rank, yet ACoS can still read acceptable on the residual sales, which is why it is the dangerous one. The other three are normal or healthy states. ACoS hiding a catalog-gate failure is the classic trap.
:::

:::sources
- SalesDuo, Amazon Advertising Benchmarks 2026 (ACoS ~15-30%, CPC ~$1.12 in 2025 +15.5% YoY) | https://salesduo.com/blog/amazon-advertising-benchmarks/
- Perpetua, Amazon Total ACoS (TACoS): Introduction to a Key Ad Metric | https://perpetua.io/blog-amazon-tacos/
- Canopy Management, The Ultimate Guide to ACoS and TACoS | https://canopymanagement.com/ultimate-guide-to-acos-and-tacos/
- Carbon6, Inventory-Aware Amazon PPC: Stop Wasting Ad Spend on Low-Stock Products | https://www.carbon6.io/blog/inventory-aware-amazon-ppc-reduce-wasted-ad-spend/
- Aura, Suppressed Buy Box: Why It Happens and How to Fix It | https://goaura.com/blog/suppressed-buy-box
- Finsi, LTV:CAC Ratio Explained: What 3:1 Means and When It Lies | https://www.finsi.ai/blog/ltv-cac-ratio-explained/
- EMARKETER, FAQ on Retail Media Networks: How Marketers Should Allocate Budgets in 2026 | https://www.emarketer.com/content/faq-on-retail-media-networks-how-marketers-should-allocate-budgets-2026
:::
