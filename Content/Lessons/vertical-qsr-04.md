---
id: vertical-qsr-04
track: vertical-qsr
module: 4
title: Franchise Co-op Budgets and Line-Item Fan-Out, Trafficking Thousands of Stores Without Dying
summary: Learn how QSR ad money splits across national and co-op funds, how to fan one strategy into thousands of store-level line items, and how to reconcile per-store budgets so the CPIV the brand sees is real.
---
# QSR money does not arrive as one budget

A QSR campaign brief looks like one number, but the money behind it is fragmented before it ever reaches the DSP. National brands fund a central ad pool from franchisee dues, then regional and local franchise co-ops layer on top, each funded by owner-operators paying a percentage of their own gross sales. The trader's first job is to understand that one insertion order is really dozens of separately-funded sub-campaigns with different budgets, flight dates, creatives, and store lists, and that a dollar from one co-op cannot legally subsidize another region.

The standard structure is a national ad fee of roughly 2 to 4 percent of an operator's gross sales per month, plus a regional or DMA co-op of another 2 to 3 percent, so total ad obligations can reach 6 to 7 percent of gross sales. Franchise media is deliberately bought at national, regional, co-op, and DMA tiers to consolidate buying power and pull CPMs down. The trader inherits that tiering as a budgeting and trafficking problem, not a media-strategy one.

:::predict
prompt: An operator with $1,200,000 in annual gross sales pays a national fund fee of 4% plus a regional co-op of 3%. What is the total annual ad-fund contribution?
answer: 84000
tolerance: 1
unit: USD
hint: Add the two fee percentages, then apply the combined rate to gross sales.
explain: The combined ad-fund obligation is 4% + 3% = 7%. Then $1,200,000 x 0.07 = $84,000 contributed across the national and regional funds for the year. That is the money the trader must place and later reconcile, split into a national share of $1,200,000 x 0.04 = $48,000 and a regional share of $1,200,000 x 0.03 = $36,000.
:::

# The fan-out: one strategy, thousands of line items

The defining operational pain of QSR trafficking is fan-out. A single strategy (a daypart, a creative, a geo) has to be replicated across every participating store, and the line-item count is multiplicative, not additive. The load is the product of stores, dayparts, and creatives, so a campaign that feels small on paper explodes into thousands of rows the moment you cross it with the store list.

The only sane way to build this is templated line-item trees plus bulk-sheet uploads (DV360 Structured Data Files, The Trade Desk bulk sheets): one template per daypart-and-creative combination, multiplied across the store list, with co-op budgets allocated per owner-operator. Manual copy-paste at this scale guarantees silent errors, and the same fan-out error class shows up in deals too, where roughly 90 percent of structured-deal-ID PMP campaigns fail to scale (often spending under $10 a day) because of manual setup mistakes and metadata inconsistencies.

:::figure lineItemTree
caption: One insertion order fans out into a tree of store-level line items. Each store node carries its own geo, co-op budget, and flight, multiplied by every daypart and creative. The count is stores x dayparts x creatives, which is why hand-trafficking does not scale.
:::

:::predict
prompt: A campaign covers 600 stores x 3 dayparts x 2 creatives. How many line items must be trafficked?
answer: 3600
tolerance: 0
unit: line items
hint: Fan-out is multiplicative across all three dimensions.
explain: 600 stores x 3 dayparts x 2 creatives = 3,600 line items. Adding even one more creative would push it to 600 x 3 x 3 = 5,400, which is why traders fix the template set first and build the store list last, then upload via SDF rather than by hand.
:::

$$ \text{line-item count} = \text{stores} \times \text{dayparts} \times \text{creatives} $$

:::quiz
question: Why is a templated line-item tree with bulk-sheet upload preferred over building store line items one at a time in the UI?
- It lets the trader charge the client a higher management fee
- Fan-out is multiplicative, so manual building does not scale and invites silent per-row errors
- Bulk sheets bypass the DSP's creative-approval step
- Manual line items deliver more impressions than templated ones
answer: 1
hint: Think about what happens to the row count when you multiply stores by dayparts by creatives.
explain: The line-item count is the product of stores, dayparts, and creatives, so even a few hundred stores becomes thousands of rows. Templated trees plus SDF or bulk-sheet uploads are the only way to build that without copy-paste error. Bulk sheets do not skip creative approval, and templated line items deliver no differently than hand-built ones.
:::

# Allocating budget per store, evenly or by sales

Once the tree exists, money has to land on each store node. The simplest method is an even split: the co-op fund divided by the number of participating stores. It is easy to reconcile but it under-funds high-volume stores and over-funds low-traffic ones, because a busy drive-thru in a dense metro deserves more weight than a slow rural unit. The fairer method is sales-weighted allocation, where each store's budget is its share of total co-op-area sales, but that needs per-store sales data the franchisor may not be willing to share.

The trader picks the method the co-op agrees to and documents it, because the allocation choice directly shapes which stores get reach and therefore which stores generate the incremental visits the brand will judge the campaign on. Whatever the method, the budget that reaches a store is what converts into footfall at some cost per incremental visit, so allocation is not just an accounting step, it is the first lever on CPIV.

:::predict
prompt: A regional co-op fund of $180,000 is split evenly across 400 participating stores. What is the per-store budget?
answer: 450
tolerance: 0
unit: USD
hint: Even split means total fund divided by the number of stores.
explain: $180,000 / 400 stores = $450 per store. That flat number is simple to reconcile, but it ignores store volume, so a high-traffic unit and a slow one get the same $450 even though the busy store could convert far more incremental visits from the same spend.
:::

:::predict
prompt: A high-volume store represents 5% of its co-op area's total sales. Under sales-weighted allocation of a $100,000 co-op fund, what budget does that store receive?
answer: 5000
tolerance: 0
unit: USD
hint: Sales-weighted means the store's budget equals its share of area sales times the fund.
explain: 0.05 x $100,000 = $5,000 for that store. Sales-weighting hands the busy store more than 10x the flat $450-style even split would, matching budget to where the footfall opportunity actually is, but it only works if the franchisor shares per-store sales figures.
:::

:::quiz
question: What is the main drawback of splitting a co-op fund evenly across all stores?
- It always overspends the total fund
- It cannot be uploaded via a bulk sheet
- It under-funds high-volume stores and over-funds low-traffic ones
- It violates state privacy law
answer: 2
hint: Even split ignores how busy each store actually is.
explain: An even split gives every store the same budget regardless of volume, so it starves high-traffic stores of reach and wastes spend on slow ones. It does not overspend the fund (the math sums to the total), uploads fine via SDF, and has nothing to do with privacy law.
:::

# Reconciliation: the budgets have to add up

The control that keeps fan-out honest is the allocation check: the sum of every store-level and co-op-level line-item budget must equal the total funded amount, with no over-allocation (which overspends a co-op's money) and no under-allocation (which strands it). The reason this matters operationally is accountability. Spend is fragmented across owner-operators who each see their own fund statement, so a mis-mapped store or a budget off by a decimal surfaces only when an operator audits their statement and the numbers do not reconcile.

For the trader, reconciliation is a pre-flight and in-flight discipline: confirm that national-fund line items sum to the national share, regional line items sum to the regional share, and that no store is drawing from the wrong co-op. Tie this back to CPIV. If a region's funded budget converts into a known number of incremental visits, the CPIV is just budget divided by incremental visits, and a reconciliation error that moves budget to the wrong region quietly corrupts that per-region CPIV too.

:::predict
prompt: A single co-op region is funded at $63,000 for a flight and the agreed footfall vendor reports it drove 9,000 incremental visits. What CPIV do you report for that region?
answer: 7
tolerance: 0.05
unit: USD
hint: CPIV is media spend divided by incremental visits.
explain: $63,000 / 9,000 incremental visits = $7.00 CPIV. That sits between the Cuebiq 2023 fast-food High-Performing mark of $5.28 and the Average of $8.84, so this region is performing well, but the number is only trustworthy if the $63,000 actually reconciles to that region and was not partly drawn from another co-op's fund.
:::

:::callout key
Reconciliation is a balance equation, not a vibe. National-fund line items must sum to the national share, each co-op's line items must sum to that co-op's share, and the grand total must equal the funded amount. A $48,000 national plus a $36,000 regional fund must show $84,000 trafficked across the tree, no more and no less, or some operator's fund statement will not tie out.
:::

# The fan-out is also where it silently breaks

Because the tree is built once and multiplied thousands of times, a single bad input propagates everywhere before anyone notices. A bulk SDF upload fails silently on one malformed row (a bad geo, a missing creative ID), dropping that store from delivery with no obvious error. A templated tree can inherit the wrong start date and burn co-op budget before the promo legally begins. And owner-operators opt in and out of national LTO pushes individually, so the live store list changes mid-flight and the tree has to be re-fanned without disturbing the pacing on stores that are already running.

The defenses are unglamorous and mandatory: validate the bulk sheet before upload (geo bounds, non-null creative IDs, correct co-op tags), diff the new tree against the running one before re-fanning, and reconcile budgets after every change, not just at launch.

:::callout warning
A recurring r/adops thread: trafficking thousands of franchise line items by hand is called soul-crushing, and one bad bulk sheet can mis-map dozens of stores' budgets before anyone catches it. Account teams on r/PPC and r/agency add that franchise co-op approvals and per-operator opt-in/opt-out churn make it nearly impossible to keep store lists and budgets in sync across a flight, so a store can be spending another region's money until that operator audits their fund statement.
:::

:::widget barChart
title: Typical QSR franchise ad-fund fees (% of operator gross sales)
labels: National fund, Regional co-op, Total obligation
data: 4, 3, 7
unit: %
:::

:::widget budgetAllocator
title: Fan-out budget allocator, even split vs sales-weighted across a store list
:::

:::sources
- Goodway Group, How Does Franchise Co-Op Advertising Work? | https://goodwaygroup.com/blogs/franchise-co-op-advertising
- QSR Magazine, Solving the Restaurant Franchise Ad Fund Problem | https://www.qsrmagazine.com/growth/franchising/solving-restaurant-franchise-ad-fund-problem/
- PubMatic, PMP Troubleshooting Playbook | https://community.pubmatic.com/pages/viewpage.action?spaceKey=PMP&title=PMP+troubleshooting+playbook
- Cuebiq, Footfall Attribution Benchmarks (CPIV by vertical) | https://cuebiq.com/benchmarks/
- KORTX, Restaurant Marketing Strategy: The 2026 QSR Playbook | https://kortx.io/news/restaurant-marketing-strategy-qsr/
- Restaurant Dive, Drive-thru share of US fast-food sales and digital order growth | https://www.restaurantdive.com/news/drive-thru-sales-qsr/
:::
