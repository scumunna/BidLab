---
id: vertical-auto-04
track: vertical-auto
module: 4
title: Audience and Data Targeting: Building In-Market, Conquest, and Loyalty Segments
summary: Construct in-market, conquest, and loyalty audiences from Polk and onboarded first-party data, geo-fence them to the dealership PMA, and grade each one against the right stage of the net-cost-per-sale ladder.
---
# Why the audience is the lever everything else hangs on

In the Auto vertical the segment you build is the single decision that no later choice can rescue. If the audience is wrong, no bid strategy, creative, supply path, or pacing plan downstream can save the campaign, because you are simply paying to reach people who will never buy from this rooftop. The trader's core daily build is therefore picking the data source, constructing the segment, and fencing it to geography before touching anything else. Get this right and the rest of the funnel has a chance, get it wrong and you are optimizing waste.

The discipline is matching each segment to its tier and to its KPI stage. Conquest is expensive and upper-funnel, so you judge it on consideration signals like VDP views, while lease-end and owner audiences are high-intent and bottom-funnel, so you judge them on leads and VIN-matched sales. The signature KPI you are ultimately graded on is net cost per sale, total media spend net of co-op reimbursement divided by VIN-matched units, so the question behind every audience is whether it can plausibly produce a titled sale at a defensible cost.

:::callout key
The order of operations is audience first, then supply, then bid, then pacing. A trader who tunes bids on a badly built audience is polishing a broken foundation. Spend your first hour on the segment, not the bid.
:::

:::quiz
question: A conquest campaign is missing its net cost per sale target. Following the audience-first order of operations, what does the trader check before touching the bid?
- Whether the segment and its geo-fence are actually reaching plausible in-market buyers for this rooftop
- Push the bid higher to win more impressions and force the volume up
- Switch the KPI from VDP views to VIN-matched sales so the number looks better
- Open a tighter pacing schedule to spend the budget faster
answer: 0
hint: No downstream lever can rescue a wrong audience, so start where the waste originates.
explain: If the audience is wrong you are paying to reach people who will never buy from this rooftop, and no bid, supply, or pacing change can fix that. You validate the segment and its geo-fence first. Raising the bid on a broken audience just buys more waste, and conquest is judged on consideration signals like VDP views anyway, not forced down to a sale KPI it cannot yet support.
:::

# The Polk and S&P Global Mobility backbone

The backbone of auto targeting is Polk predictive audiences from S&P Global Mobility, which score 125M+ US households for in-market and future-in-market timing. The catalog runs 2,000+ unique audience segments, including 200+ built specifically for hybrid and EV buyers, and Polk Auto Direct layers on another 1,000+ across every make, model, and fuel type. On top of timing, Polk attaches loyalty, conquest, and defection signals plus lease-end status and brand-and-model profiles, which are exactly the fields you slice to build the three archetypes.

You then layer Oracle and similar third-party in-market auto data, and the dealer's own owner list, on top of the Polk spine. The skill is not knowing that these segments exist, it is selecting the few that map to this rooftop's tier and inventory rather than buying a giant generic in-market blob. A Tier 3 trader building for one store wants make/model/lease-end precision inside a drive radius, not a national new-car intender pool.

:::predict
prompt: Polk's main catalog has 2,000 unique segments and 200 of them are built for hybrid and EV buyers. What percent of the catalog is hybrid or EV?
answer: 10
tolerance: 0.5
unit: %
hint: Divide the hybrid/EV segment count by the total segment count.
explain: 200 / 2,000 = 0.10, which is 10 percent. As EV and hybrid shopping grows you will lean on that 10 percent slice far more than its share of the catalog suggests, because fuel-type intent is one of the sharpest signals you can buy.
:::

:::quiz
question: A Tier 3 dealer trader has access to Polk's 2,000-plus segments. What is the correct first move when building an in-market campaign for one rooftop?
- Target the broadest national new-vehicle intender segment for maximum reach
- Select make/model and lease-end segments scoped to the store's drive radius
- Buy every hybrid and EV segment regardless of what the store stocks
- Skip Polk and rely only on the DSP's default contextual targeting
answer: 1
hint: A single rooftop sells inside a local radius, to buyers of the makes it actually stocks.
explain: A rooftop's sales are concentrated in a local drive radius and in the makes it stocks, so you scope to make/model and lease-end segments inside that geography. The broadest national pool wastes spend on people who will never visit, and buying segments for inventory the store does not carry sends traffic to vehicles it cannot sell.
:::

# The three audiences you build every day

There are three audience archetypes the auto trader constructs daily, and each one behaves differently in the funnel. First is in-market by make, model, and lease-end, where someone whose lease ends in roughly 60 to 90 days is the single highest-value signal you can target because their purchase window is both near and certain. Second is conquest, the drivers loyal to a competitive make that you want to flip to your brand, which is inherently upper-funnel and slow to convert. Third is loyalty and owner, the dealer's existing owners targeted for service revenue and repurchase, which is the cheapest, highest-converting pool because these people already chose this store once.

The conquest pool itself takes a small piece of arithmetic. You start from the competitive-make owners inside the dealership's market area and subtract the store's existing owners so you are not paying to conquest people you already have, which keeps the pool clean and the spend honest.

$$ \text{Conquest pool} = \text{competitive-make owners in PMA} - \text{your existing owners} $$

:::predict
prompt: Polk shows 18,000 competitive-make owners inside the dealership's market area, and your DMS already counts 3,000 of them as your own owners. How large is the clean conquest pool?
answer: 15000
tolerance: 0
unit: owners
hint: Subtract your existing owners from the competitive-make owners in the area.
explain: 18,000 competitive-make owners minus 3,000 existing owners equals a 15,000-owner conquest pool. Skipping the subtraction would have you spend conquest dollars re-targeting 3,000 people who already belong to your loyalty audience, double-serving them and inflating conquest cost for no incremental flip.
:::

:::figure dealerTiers
caption: The three audience archetypes map onto the tier structure. In-market and lease-end and owner audiences are bottom-funnel and graded on leads and sales, while conquest sits higher and is graded on consideration signals like VDP views.
:::

# Geo-fence to the PMA before you spend a dollar

Everything you build gets geo-fenced to the dealership's Primary Market Area, the defined local drive radius inside which a rooftop actually makes its sales. PMA geo-fencing is standard precisely because you do not want to pay to serve a high-intent shopper 200 miles away who will never drive in for a test drive, no matter how perfect the Polk segment looks. The addressable audience you can actually activate is the in-market households inside that PMA multiplied by the share your onboarding can match to addressable IDs.

$$ \text{Addressable PMA audience} = \text{in-market households in PMA} \times \text{match rate} $$

The match-rate term is load-bearing, because a list or segment only activates the share of records that resolve to a valid, hashable, addressable identifier. A clean-room or hashed-ID match is what turns a raw household count into a number you can actually bid against, which is why identity and match rates sit one layer under every audience decision.

:::predict
prompt: A dealership's PMA holds 40,000 in-market households, and your onboarding resolves 65 percent of them to addressable IDs. How large is the audience you can actually activate?
answer: 26000
tolerance: 0
unit: households
hint: Multiply the in-market households by the match rate.
explain: 40,000 households times 0.65 equals 26,000 addressable households. The other 14,000 exist in the segment but cannot be reached through that onboarding path, so planning reach off the raw 40,000 would overstate your real addressable base by more than 50 percent.
:::

# Segments decay, so refresh the window

Lease-end and in-market timing data decays fast, and treating a segment as static is a classic way to burn budget. Over 50 percent of auto buyers take more than 90 days to decide, so you build the in-market window wide, but the flip side is that a 90-day-old lease-end segment is mostly people who have already bought, meaning you are advertising into a sold market. The fix is operational, refresh the segment on a cadence so the timing signal stays live rather than letting it age into noise.

Quantify the decay so you can defend the refresh. If a slice of an in-market segment has already purchased by the time you re-pull it, only the remaining, still-shopping share is worth activating, and bidding the full stale count means paying to reach owners of a car they just parked in their driveway.

:::predict
prompt: A 12,000-record lease-end segment is now 90 days old, and matchback shows 35 percent of those people have already purchased. How many records are still worth activating?
answer: 7800
tolerance: 0
unit: records
hint: Keep only the share that has not already bought, which is 100 percent minus 35 percent.
explain: 35 percent already bought, so 65 percent remain, and 12,000 times 0.65 equals 7,800 still-shopping records. Continuing to bid the full 12,000 would spend roughly a third of the budget chasing 4,200 people who are out of market, which is exactly how a "great" CPM segment quietly produces a terrible cost per sale.
:::

:::widget donutChart
title: Typical monthly budget split across the auto audience archetypes
labels: In-Market Make/Model, Lease-End, Conquest, Loyalty/Owner, Service
data: 30, 20, 22, 18, 10
unit: %
:::

# Grading each audience on the right KPI

The discipline that separates a strong hire is grading each audience on the funnel stage it actually serves, then rolling the whole thing up to net cost per sale. Conquest looks cheap on CPM but converts slowly, so judging it on last-click leads makes a working upper-funnel audience look like a failure and gets it cut prematurely. Lease-end and owner audiences are bottom-funnel, so it is fair to hold them to leads and to VIN-matched sales. The headline number across all of them is net cost per sale, media spend net of co-op reimbursement divided by VIN-matched units.

$$ \text{Net cost per sale} = \frac{\text{media spend} - \text{co-op reimbursement}}{\text{VIN-matched units sold}} $$

The co-op term is why the same campaign can look twice as expensive depending on whether you quote gross or net, which ties this audience work directly to the compliance QA that protects reimbursement.

:::predict
prompt: A lease-end and owner campaign spends $12,000 in media, earns 50 percent co-op reimbursement, and VIN matchback credits it with 24 titled sales. What is the net cost per sale?
answer: 250
tolerance: 0
unit: USD
hint: Net the spend down by the co-op rate first, then divide by VIN-matched sales.
explain: $12,000 times 50 percent reimbursement leaves $6,000 net media spend, and $6,000 divided by 24 VIN-matched sales is $250 per sale. Quoting the gross figure of $12,000 / 24 equals $500 would tell the dealer the bottom-funnel audience is twice as expensive as it really is, which is why net of co-op is the only honest way to grade it.
:::

:::callout warning
A recurring DealerRefresh complaint is that vendors sell "in-market" audiences that are really stale third-party lists, so spend lands on people who bought months ago, and that conquest budgets get killed by a principal who only looks at last-click sales even though conquest is inherently upper-funnel. The defense is the same on both fronts: refresh timing data on a cadence so it stays live, and grade conquest on VDP and consideration rather than last-click, with VIN matchback proving the slower sales that last-click misses entirely.
:::

:::quiz
question: A dealer principal wants to cut the conquest line because it shows almost no last-click sales this month. What is the correct trader response?
- Agree and reallocate the conquest budget to last-click search
- Defend conquest as upper-funnel and grade it on VDP views and view-through, proven by VIN matchback
- Raise the conquest bid to force more last-click conversions
- Move conquest spend into the loyalty/owner audience instead
answer: 1
hint: Conquest converts slowly, so the wrong yardstick makes a working audience look broken.
explain: Conquest is inherently upper-funnel and converts slowly, so a last-click view of one month makes it look worthless. The right move is to defend it on consideration signals and view-through credit confirmed by VIN matchback, not to defund it, raise bids to chase the wrong metric, or fold it into a fundamentally different audience.
:::

:::sources
- S&P Global Mobility, Polk Predictive Automotive Audiences | https://www.spglobal.com/mobility/en/products/polk-audiences.html
- Foundry CRO, Automotive Marketing Benchmarks 2026: CPC to Cost per Sale | https://foundrycro.com/blog/automotive-marketing-benchmarks-2026/
- Demand Local, 21 Co-Op Fund Utilization Statistics in Dealership Advertising | https://www.demandlocal.com/blog/co-op-fund-utilization-statistics/
- Tealium, Sweeping Away Third Party Cookies with Data Clean Rooms | https://tealium.com/blog/data-strategy/sweeping-away-third-party-cookies-with-data-clean-rooms/
- DealershipGuy, Dealer ad spend nears $10 billion as digital marketing dominates (NADA 2025 data) | https://news.dealershipguy.com/p/dealer-ad-spend-nears-10-billion-as-digital-marketing-dominates
- DealerRefresh, Why are third parties running Google VLA ads on MY vehicles? Shut it down! | https://forum.dealerrefresh.com/threads/why-are-third-parties-running-google-vla-ads-on-my-vehicles-shut-it-down.9894/
:::
