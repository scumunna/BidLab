---
id: vertical-qsr-02
track: vertical-qsr
module: 2
title: The Buyer and the Mandate, Who Buys QSR Media and Why CPIV Is the North Star
summary: Identify who funds QSR media, define the incremental-visit mandate, and compute CPIV, visit rate, and visit lift so you can optimize to causal footfall instead of clicks.
---
# Who actually buys QSR media

The buyer you serve is not one person. It is a national QSR brand team that owns the master strategy, plus a stack of franchise co-op funds paid into by owner-operators, executed through either an agency trading desk or an in-house programmatic team. Each of those funders cares about a different slice (the national team wants brand-wide footfall, a regional co-op wants visits to its own stores), but they share one win condition. The business goal is incremental footfall and incremental same-store sales, not clicks, not CTR, not landing-page conversions.

That mandate is the thing that makes QSR trading different from a typical performance buy. A drive-thru visit leaves no click and no on-site conversion event, so the trader is paid to move bodies through physical doors and then to prove that the media, and not the weather or the season, caused the move.

:::quiz
question: In a QSR footfall campaign, who are you ultimately optimizing for and against what win condition?
- A single national brand manager who wants the lowest CPM
- The DSP account team, optimizing to platform spend
- The creative agency, optimizing to CTR
- A national brand team plus franchise co-op funders, optimizing to incremental store visits
answer: 3
hint: QSR money has more than one funder, and none of them are paid in clicks.
explain: QSR media is funded by a national brand team and franchise co-op funds (owner-operators), executed by a desk. They all share one win condition, incremental footfall and same-store sales, which is why CTR and CPM are the wrong scoreboard.
:::

# CPIV, the north star metric

The signature KPI of QSR programmatic is CPIV, cost per incremental visit, the media budget required to drive one extra store visit above a control group. It is the buy-side number that survives a QBR, because it ties spend directly to the only outcome the brand funds. The formula is simple, and the discipline is in the word incremental.

$$ \text{CPIV} = \frac{\text{total media spend}}{\text{incremental visits}} $$

Incremental visits are not the same as attributed visits. Some of the people who saw the ad and then visited a store would have visited anyway, so only the lift over a control counts. The trader's mandate is to push CPIV toward the cheap, high-performing end while keeping those incremental visits statistically real, which means balancing cheap reach against measurable, causal lift rather than chasing whichever vendor reports the most visits.

:::predict
prompt: A QSR campaign spends $90,000 and drives 10,000 incremental visits. What is the CPIV?
answer: 9
tolerance: 0.1
unit: USD
hint: Divide total spend by incremental visits.
explain: $90,000 / 10,000 = $9.00 per incremental visit. That sits right around the Fast Food Average CPIV benchmark of $8.84, so this campaign is performing at, not above, the vertical norm.
:::

:::predict
prompt: A brand wants to hit the Fast Food Average CPIV of $8.84 and your plan forecasts 5,000 incremental visits. What media budget should you book?
answer: 44200
tolerance: 50
unit: USD
hint: CPIV times incremental visits gives the spend.
explain: Rearranging the formula, spend equals CPIV times incremental visits, so $8.84 times 5,000 = $44,200. Planning backward from a target CPIV is how you size a QSR flight before you ever set a bid.
:::

# Reading the benchmark range

CPIV is not a single pass/fail number. Cuebiq publishes it as a per-vertical range with a Below-Average, an Average, and a High-Performing column, and your job is to know where your campaign sits. For Fast Food (QSR), the 2023 benchmark is a Below-Average CPIV of $28.65, an Average of $8.84, and a High-Performing of $5.28. The lower the cost, the better, so High-Performing means the cheapest cost to buy one extra visit.

That QSR range looks cheap next to most other verticals, and the reason is purchase frequency, not trading skill. Fast food is a high-frequency, low-consideration buy, so a nudge converts cheaply. The same Cuebiq Average column shows Convenience Store at $1.32 and Consumer Electronics at $1.68 (both lower, very high frequency or high density), while sit-down Restaurants run $10.55, Grocery $27.97, Finance and Insurance $122.85, and Furniture sits at the costly extreme of $2,886.46.

:::widget barChart
title: Average CPIV by vertical (Cuebiq 2023, USD, lower is better)
labels: Convenience, ConsumerElec, FastFood, Restaurants, Grocery
data: 1.32, 1.68, 8.84, 10.55, 27.97
unit: USD
:::

:::predict
prompt: Holding incremental visits at 5,000, how much more do you spend at the Below-Average CPIV of $28.65 than at the High-Performing CPIV of $5.28?
answer: 116850
tolerance: 100
unit: USD
hint: Find the per-visit cost gap, then multiply by the 5,000 incremental visits.
explain: The cost gap per visit is $28.65 minus $5.28, which is $23.37. Across 5,000 incremental visits that is $23.37 times 5,000 = $116,850 of extra spend for the same outcome. Moving from Below-Average to High-Performing CPIV is where the trader earns the fee.
:::

:::callout key
CPIV is only comparable within QSR. The vertical's cheap $8.84 reflects high purchase frequency, not superior trading, so benchmarking a QSR campaign against Grocery or Furniture CPIV is apples to oranges. Always compare against the Fast Food range.
:::

# The math that makes a visit incremental

To compute CPIV you first have to isolate incremental visits, and that requires an exposed group and a matched control. Visit rate is the attributed store visits divided by exposed unique users. Incremental visits are the gap between the exposed and control visit rates, applied to the exposed audience. The lift percentage expresses that same gap relative to the control baseline.

$$ \text{incremental visits} = (\text{exposed visit rate} - \text{control visit rate}) \times \text{exposed audience} $$

$$ \text{visit lift \%} = \frac{\text{exposed visit rate} - \text{control visit rate}}{\text{control visit rate}} $$

For context on what good looks like, Cuebiq's 2023 QSR visit-rate benchmark runs from a Below-Average 0.98 percent to an Average 2.63 percent to a High-Performing 3.75 percent, with an Average uplift of 18.70 percent. Notice that only the gap between exposed and control is yours to claim. A high raw visit rate with an almost-as-high control rate is mostly people who would have come anyway.

:::predict
prompt: Exposed audience is 500,000 with a 3.0% visit rate. The control visit rate is 2.4%. How many incremental visits did the campaign drive?
answer: 3000
tolerance: 10
unit: visits
hint: Take the rate gap as a decimal, then multiply by the exposed audience.
explain: The gap is 3.0% minus 2.4%, which is 0.6%, or 0.006. Multiplied by 500,000 exposed users that is 3,000 incremental visits. The other 2.4% who visited would have shown up without the ad, so they do not count.
:::

:::predict
prompt: Exposed visit rate is 3.0% and the control visit rate is 2.5%. What is the visit lift % (uplift)?
answer: 20
tolerance: 0.5
unit: %
hint: Divide the rate gap by the control rate, not by the exposed rate.
explain: The gap is 3.0% minus 2.5%, which is 0.5 percentage points. Divided by the 2.5% control baseline that is 0.5 / 2.5 = 0.20, a 20 percent lift. Uplift is always measured against the control, because the control is the world where your media never ran.
:::

:::figure incrementalityHoldout
caption: Only the gap between the exposed visit rate and the matched control visit rate is incremental. The control captures the visits that would have happened anyway, and CPIV divides spend by that gap, not by total attributed visits.
:::

# How the mandate breaks in the wild

The two failures that get traders challenged in a QBR both come from skipping the control. The first is reporting raw attributed visits with no holdout, so correlation gets sold as causation and the CPIV is meaningless. The second is the opposite trap, a cheap CPIV that looks brilliant only because a loose vendor over-counted visits, which is a measurement artifact, not performance. A suspiciously low CPIV deserves the same scrutiny as a suspiciously high one.

There is also a hard ceiling on the whole model. Cost-per-incremental-sale, the number the CFO really wants, can only be computed once the brand shares POS or loyalty data, and roughly 65 percent of fast-food sales still complete offline at the drive-thru with no digital event. Until that data is shared, the trader optimizes to visits as the best available proxy for sales and says so out loud.

:::callout warning
A recurring r/adops and r/programmatic complaint: clients fixate on CTR for footfall campaigns even though a click is irrelevant to a drive-thru visit, and the visits a DSP or vendor labels incremental often have no control group behind them, so the CPIV gets torn apart in the QBR. Re-educate on CPIV and lift at kickoff, and refuse to report incremental visits without a defined control.
:::

:::quiz
question: A vendor reports an unusually cheap CPIV of $3.00 for a QSR flight with no control group described. What is the right read?
- CPIV that low is impossible, the report is fabricated
- It proves QSR is cheaper than every other vertical
- The CPIV is likely a measurement artifact from loose visit counting and no control, so it cannot be trusted yet
- Excellent performance, scale the budget immediately
answer: 2
hint: Cheap is not the same as real, and incrementality needs a control.
explain: Without a control group there are no true incremental visits, and a loose visit definition inflates the denominator, which drives CPIV artificially low. A cheap CPIV with no stated methodology is an artifact to investigate, not a win to scale.
:::

:::sources
- Cuebiq, Footfall Attribution Benchmarks (CPIV, visit rate, uplift by vertical) | https://cuebiq.com/benchmarks/
- Restaurant Dive, Drive-thru share of US fast-food sales and digital order growth | https://www.restaurantdive.com/news/drive-thru-sales-qsr/
- Remerge, Incrementality Tests 101: Intent-to-Treat, PSA, Ghost Ads and Ghost Bids | https://www.remerge.io/blog-post/incrementality-tests-101-intent-to-treat-psa-ghost-ads-and-ghost-bids
- aidigital, Foot Traffic Attribution: polygon mapping, dwell, neighbor exclusion | https://www.aidigital.com/blog/footfall-attribution
- Goodway Group, How Does Franchise Co-Op Advertising Work? | https://goodwaygroup.com/blogs/franchise-co-op-advertising
- KORTX, Restaurant Marketing Strategy: The 2026 QSR Playbook | https://kortx.io/news/restaurant-marketing-strategy-qsr/
:::
