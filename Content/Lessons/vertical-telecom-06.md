---
id: vertical-telecom-06
track: vertical-telecom
module: 6
title: Bidding and Pacing, Bid Ceilings from SAC and Smooth Delivery of Big Budgets
summary: Turn allowable SAC into a defensible max CPM bid ceiling and pace eight-figure carrier flights so they deliver smoothly without front-loading the switching window.
---
# From LTV:SAC to a number you can bid

Everything in the earlier mandate lesson was theory until it becomes a price you are willing to pay for an impression. The chain is short and it is the whole job: the carrier sets a target lifetime value and a required LTV:SAC ratio, that fixes the allowable SAC (the loaded cost you can pay per gross add), and that allowable SAC, divided across the impressions it takes to win one subscriber, becomes a max CPM bid ceiling. If you bid above that ceiling you win impressions at a media cost that loses money on loaded economics, no matter how good the click-through looks.

The first formula is the one that anchors every line item. Allowable SAC is target LTV divided by the required ratio, so a richer LTV or a looser ratio lets you bid higher, and a strict 3:1 gate forces discipline.

$$ \text{Allowable SAC} = \frac{\text{Target LTV}}{\text{Target LTV:SAC}} $$

:::predict
prompt: A postpaid subscriber has a target Net LTV of $1,200 and the carrier requires a 4:1 LTV:SAC ratio. What is the allowable SAC?
answer: 300
tolerance: 0.5
unit: USD
hint: Divide the target LTV by the required ratio.
explain: Allowable SAC = 1,200 / 4 = 300. The carrier can load at most $300 of total acquisition cost (media plus handset subsidy plus commission) per gross add and still clear a 4:1 return on lifetime value.
:::

# The bid ceiling, derived from allowable cost-per-gross-add

The allowable SAC is a per-subscriber budget, but a DSP bids per thousand impressions, so you have to translate. The bridge is your expected impression-to-gross-add rate: how many gross adds you win per impression served. Multiply the allowable cost-per-gross-add by that conversion rate, then by 1000, and you have the maximum CPM that keeps the unit economics whole.

$$ \text{Bid ceiling (max CPM)} = \text{Allowable CPGA} \times \frac{\text{gross adds}}{\text{impressions}} \times 1000 $$

A worked example fixes the intuition. At an allowable CPGA of $300 and an expected one gross add per 2,000 impressions (a 0.05% rate), the ceiling is $300 times 0.0005 times 1000, which is a $150 CPM. Industry CPGA for a wireless phone gross add runs roughly $350 to $400, so this ceiling sits inside real carrier economics rather than a made-up number.

:::predict
prompt: Allowable CPGA is $300 and you expect 1 gross add per 2,000 impressions (0.05%). What is the max CPM bid ceiling?
answer: 150
tolerance: 0.5
unit: USD CPM
hint: Multiply allowable CPGA by gross-adds-per-impression, then by 1000.
explain: 300 x (1 / 2,000) x 1,000 = 300 x 0.0005 x 1,000 = 150. Bidding above a $150 CPM means paying more than $300 of media per gross add before you even load the handset subsidy and commission.
:::

:::predict
prompt: A different line item has an allowable CPGA of $360 and converts 1 gross add per 1,500 impressions. What is the max CPM bid ceiling?
answer: 240
tolerance: 0.5
unit: USD CPM
hint: Same formula. Allowable CPGA times gross-adds-per-impression times 1000.
explain: 360 x (1 / 1,500) x 1,000 = 360 x 0.000667 x 1,000 = 240. A higher conversion rate (1 in 1,500 versus 1 in 2,000) lets you bid a richer CPM for the same allowable cost per gross add, because each impression is worth more.
:::

:::quiz
question: Two line items share the same allowable CPGA. Line A wins 1 gross add per 1,500 impressions; Line B wins 1 per 3,000. How should their max CPM ceilings compare?
- Line A's ceiling should be lower than Line B's
- Line A's ceiling should be higher than Line B's
- The ceilings should be identical because the allowable CPGA is the same
- Conversion rate does not affect the bid ceiling
answer: 1
hint: A more efficient line turns each impression into more gross-add value.
explain: Line A converts twice as efficiently (1 in 1,500 versus 1 in 3,000), so each impression carries more expected gross-add value and earns a higher CPM ceiling. The allowable CPGA is per gross add, not per impression, so conversion rate scales the ceiling directly.
:::

# Loaded SAC, not media-only, sets the ceiling

The most expensive mistake in this whole arc is anchoring the bid ceiling on media cost alone. SAC by accounting definition includes sales and marketing spend plus handset subsidies plus dealer commissions, so a media-only ceiling silently treats the subsidy and commission as free. You can win every impression under a media-only cap and still lose money on every subscriber once the real loaded cost lands.

The fix is to reconcile the bid ceiling to loaded SAC: subtract the non-media acquisition costs from allowable SAC first, then derive the media bid ceiling from what is left. If allowable SAC is $400 but the handset subsidy and commission already consume $250, only $150 is available for media per gross add, and the CPM ceiling must be built off that $150, not the full $400.

:::callout warning
A recurring AdOps complaint is that leadership conflates a falling CPA with success even as the acquired base skews to credit-thin prepaid and high-churn segments. Autobidding to the cheapest conversion adverse-selects toward low-ARPU prepaid (about $33 per line) when the mandate is high-ARPU postpaid, so the cheap lead is the expensive mistake. Hard-cap bids and exclude prepaid-skewing supply, or the algorithm optimizes against the very LTV:SAC gate you set.
:::

:::predict
prompt: Allowable SAC is $400 per gross add. The handset subsidy and dealer commission together consume $250. What dollar amount remains available for media per gross add?
answer: 150
tolerance: 0.5
unit: USD
hint: Subtract the non-media loaded costs from allowable SAC.
explain: 400 - 250 = 150. Only $150 per gross add can go to media. A bid ceiling built on the full $400 would overpay by $250 of media per subscriber and quietly break the loaded LTV:SAC gate.
:::

:::figure churnLtvCurve
caption: Lifetime value is set by ARPU, margin, and how long a subscriber stays. A lower monthly churn stretches the retention curve, lifts LTV, and (at a fixed LTV:SAC gate) raises the allowable SAC and therefore the bid ceiling.
:::

# Pacing big budgets without front-loading

The second half of the job is delivery. A single carrier flight can be eight figures, and the signature failure mode is front-loading: aggressive or ASAP pacing exhausts the budget before the highest-intent days arrive, leaving a device launch or back-to-school switching window dark exactly when conversions peak. You watch this with the pacing index, actual spend to date divided by planned spend to date, where 1.0 is on pace, above 1.0 is spending ahead, and below 1.0 is underdelivering.

$$ \text{Pacing index} = \frac{\text{Actual spend to date}}{\text{Planned spend to date}} $$

The recovery lever is required daily spend, the remaining budget divided by the remaining flight days, which tells you the run rate the back half needs to land on plan.

$$ \text{Required daily spend} = \frac{\text{Remaining budget}}{\text{Remaining flight days}} $$

:::predict
prompt: A $6,000,000 flight is 40% through its days but has already spent $3,000,000. What is the pacing index?
answer: 1.25
tolerance: 0.02
unit: index
hint: Planned spend to date is 40% of the total budget. Divide actual by planned.
explain: Planned to date = 0.40 x 6,000,000 = 2,400,000. Pacing index = 3,000,000 / 2,400,000 = 1.25. The flight is spending 25% ahead of plan, the classic front-load signature that risks going dark before the key window.
:::

:::predict
prompt: That same $6,000,000 flight runs 30 days. After day 12 it has spent $3,000,000. To finish exactly on budget, what is the required daily spend for the rest of the flight?
answer: 166666.67
tolerance: 200
unit: USD per day
hint: Remaining budget divided by remaining days. 30 - 12 = 18 days left.
explain: Remaining budget = 6,000,000 - 3,000,000 = 3,000,000. Remaining days = 30 - 12 = 18. Required daily spend = 3,000,000 / 18 = 166,666.67. That is well below the early run rate of $250,000/day (3,000,000 / 12), confirming you must throttle to protect the back half.
:::

:::widget lineChart
title: Budget spent versus flight elapsed, even pace vs front-loaded
labels: Start, Quarter, Midpoint, Three-Quarter, End
data: 0, 50, 85, 100, 100
unit: percent of budget spent
:::

# Pace at the right level, and mind the platform gotchas

Where you set pacing matters as much as how. The guidance is to pace at the highest level that can hit goal, usually the campaign, and only drop to line-item pacing when campaign-level pacing cannot reach the target. Double-setting pacing at both the campaign and the line-item level silently throttles or spikes delivery because the two controllers fight each other, producing the underspend or spend spike you were trying to avoid.

Platform rules add concrete trafficking gotchas you cannot guess your way around. DSP pacing modes are even, ahead-of-schedule, or ASAP, and in DV360 the ASAP mode (PACING_TYPE_ASAP) is no longer compatible with flight-period pacing (PACING_PERIOD_FLIGHT) for insertion orders as of November 5, 2024. Choosing the wrong combination either fails to save or paces in a way you did not intend, so the trader confirms the mode against current platform docs rather than muscle memory.

:::quiz
question: A campaign is underdelivering. Pacing is already set at the campaign level. A teammate suggests also enabling aggressive line-item pacing on every child line item. What is the risk?
- It is the correct fix and carries no risk
- Conflicting campaign and line-item pacing can throttle or spike delivery
- Line-item pacing always overrides and is strictly safer
- Pacing level has no effect on delivery smoothness
answer: 1
hint: Two pacing controllers set at once tend to fight each other.
explain: Double-set pacing at both campaign and line-item levels makes the controllers conflict, which silently throttles or spikes delivery. Pace at the highest level that meets goal, then step down to line items only if the campaign level cannot reach plan.
:::

:::predict
prompt: A carrier requires a 3:1 LTV:SAC gate and the target Net LTV is $1,800. What is the maximum allowable SAC that still clears the gate?
answer: 600
tolerance: 0.5
unit: USD
hint: Allowable SAC is target LTV divided by the required ratio.
explain: Allowable SAC = 1,800 / 3 = 600. Any loaded acquisition cost up to $600 per gross add clears the 3:1 gate; spend more than $600 all-in and the campaign fails the gate even if the media looked efficient.
:::

:::sources
- eMarketer, Programmatic ad spending set to reach nearly $180 billion by 2025 | https://www.emarketer.com/content/programmatic-ad-spending-set-reach-nearly-180-billion-by-2025
- Google, Display & Video 360 API Pacing (PACING_TYPE_ASAP flight rule) | https://developers.google.com/display-video/api/reference/rest/v3/Pacing
- Investopedia, Cost Per Gross Addition (CPGA) | https://www.investopedia.com/terms/c/cpga.asp
- Umbrex, LTV to CAC Ratio | https://umbrex.com/resources/financial-modeling/ltv-to-cac-ratio/
- Accounting for Everyone, Subscriber Acquisition Cost (SAC) explained | https://www.accountingforeveryone.com/subscriber-acquisition-cost-sac/
- Microsoft, Xandr Invest pacing options documentation | https://learn.microsoft.com/en-us/xandr/invest/pacing
:::
