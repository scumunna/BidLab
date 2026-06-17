---
id: vertical-retail-07
track: vertical-retail
module: 7
title: "Off-Site DSP Execution and Supply Path: Amazon DSP vs TTD vs DV360, Deal-IDs/PMPs, SPO, Frequency, and CTV"
summary: Run an RMN audience off-site through a DSP, set up PMP deal-IDs, optimize the supply path, control cross-channel frequency, and price the stacked take-rate so you can judge off-site spend on iROAS rather than on a console number that does not exist.
---
# From keyword bidding to real programmatic

On-site retail media is keyword and audience bidding inside a closed console: you set a bid, the retailer runs a second-price auction on its own digital shelf, and the sale gets credited in closed-loop. Off-site is a different craft entirely. The RMN packages its first-party shopper audience, hands it to a demand-side platform (DSP), and you buy that audience on the open web and on connected TV (CTV) through first-price programmatic auctions you learned in the core auction lessons. The audience is the same retail-intent shopper, but the plumbing, the pricing, and the measurement all change, and most of the operational pain in this module comes from that gap.

The economic catch the trader must internalize before touching a deal-ID: off-site media carries a STACKED take-rate the on-site console never charged, so the identical audience costs materially more per impression off-site, and that off-site spend often appears only on the invoice, not in any campaign manager. The signature buy-side KPI for the vertical, iROAS (incremental return on ad spend, the return on only the sales the ad actually caused), is what survives this. ROAS gets inflated by attribution windows and brand halo; iROAS on gross off-site spend is the number that tells you whether the off-site dollar was worth more than the take-rate it paid.

:::figure supplyChain
caption: Off-site routes an RMN audience through a DSP, an exchange, and a data layer before it reaches an impression. Each hop is a take-rate, so the working-media CPM that actually buys the audience is a fraction of the gross CPM the brand pays.
:::

# The DSP choice: Amazon DSP, The Trade Desk, DV360

The trader picks the seat that fits the audience, the reach, and the transparency they need to reconcile spend later. Amazon DSP is the default for Amazon retail-intent data and owned premium CTV (Prime Video, Fire TV, Twitch), and in 2026 it sits inside a unified Campaign Manager that merges Sponsored Ads and DSP into one console. The Trade Desk (TTD) leads on open-web and CTV reach, identity, and supply-path transparency, charging a line-item fee of roughly 15 to 20 percent of spend that you can see and reconcile. DV360 bundles its take-rate into media cost and restricts log-level access far more than TTD, which weakens true-cost comparison and supply-path optimization.

Access is gated by minimums, and that gate decides who can self-serve. Amazon DSP managed service runs about $50K per month; self-service is roughly $35K direct or about $10K to $15K per month through a managed partner, and anything under about $5K per month is too thin to optimize. The practitioner lesson is that the transparent seat (TTD) lets you prove where the working-media dollar went at reconciliation time, while the bundled seat (DV360) leaves the working-media share unknowable, which is exactly the leak the next lesson on fees has to chase.

:::quiz
question: A mid-market brand wants to run RMN audiences off-site, needs to reconcile fees line by line, and wants the strongest supply-path transparency. Which seat fits best?
- DV360, because its take-rate is bundled into media cost
- The Trade Desk, because its fee is a visible line item and it exposes the supply path
- Amazon DSP managed service, because it has the highest minimum
- Any of them, because take-rate transparency is identical across DSPs
answer: 1
hint: One DSP charges a fee you can see on every line; another buries it in the media cost.
explain: The Trade Desk charges a transparent line-item fee (roughly 15 to 20 percent) and exposes supply-path data, so the trader can reconcile working versus gross media. DV360 bundles its take-rate into media cost, making the working-media share unknowable, and Amazon DSP's high minimum is about access, not transparency.
:::

# PMP deal-IDs and supply-path optimization

Off-site execution is not just open-exchange bidding. The trader negotiates PRIVATE MARKETPLACE (PMP) deals, each carrying a deal-ID, that guarantee specific inventory at an agreed price for the RMN audience. A deal-ID is a priority lane: at equal price, a PMP or guaranteed deal clears ahead of an open-exchange bid, so the trader uses deals to lock premium retail-context inventory rather than fight for it in the open auction. SUPPLY-PATH OPTIMIZATION (SPO) is the discipline of cutting redundant intermediary hops, the same impression resold through three exchanges, so more of the gross CPM survives as working media and the win rate holds at a lower true cost.

SPO is where the transparent DSP pays off. Each hop the trader removes is a take-rate removed, and the objective is to minimize hops per won impression while holding win rate steady. The brief's edge case is concrete: because DV360's take-rate is bundled, a trader cannot cleanly see the redundant hops, so SPO is materially weaker there than on TTD, where log-level data exposes the duplicate paths.

:::predict
prompt: Working-media off-site CPM is $4.00 and stacked fees (DSP plus exchange plus data) add 25%. What effective gross CPM does the buyer pay?
answer: 5
tolerance: 0.05
unit: USD
hint: Multiply the working CPM by one plus the total fee load.
explain: Effective CPM = working CPM x (1 + fee load) = $4.00 x 1.25 = $5.00. The brand pays $5.00 per thousand impressions but only $4.00 of it actually buys the audience; the other $1.00 is the take-rate stack. SPO and deal-IDs are how the trader claws that working-media share back up.
:::

:::callout key
A deal-ID is a priority instruction, not a discount. At equal price the PMP deal clears before the open-exchange bid, so deals are how a retail-media trader secures premium, brand-safe, retail-context inventory at a known price instead of winning it by chance in the open auction.
:::

# Cross-channel frequency: the same shopper, two pipes

The most common off-site waste is frequency the trader never sees. On-site impressions and off-site DSP impressions are managed in separate systems, so unless frequency is capped ACROSS both, the same shopper gets pounded by the retailer's on-site placements and the DSP's open-web and CTV ads at once. Cross-channel frequency is total impressions (on-site plus off-site) divided by unique reached users, and when it climbs past a sane cap the marginal impressions buy nothing, they just annoy the buyer and burn the off-site budget that already paid a take-rate to exist.

The fix is a unified frequency cap or a clean-room view that joins on-site and off-site exposure to the same pseudonymous user, the same identity spine the measurement lesson leans on. The edge case to flag: frequency managed per-DSP but not across on-site plus off-site routinely lets a shopper see 15-plus impressions, which is pure leakage on the most expensive media in the plan.

:::predict
prompt: A campaign serves 2,000,000 impressions across on-site and off-site to 500,000 unique users. What is the cross-channel frequency?
answer: 4
tolerance: 0.05
unit: impressions per user
hint: Divide total impressions by unique reached users.
explain: Cross-channel frequency = 2,000,000 / 500,000 = 4.0 impressions per user. That is a defensible average, but it can hide a long tail: if frequency is only capped inside each DSP and not across on-site plus off-site, a slice of those users can sit at 15-plus while the average still reads 4.
:::

:::widget barChart
title: Off-site cost stacking for the same RMN audience (index, on-site working CPM = 100)
labels: On-site working, Off-site working, + DSP fee, + exchange fee, + data fee
data: 100, 100, 115, 122, 130
unit: index
:::

# CTV: fastest-growing, most fragmented

CTV is the fastest-growing slice of off-site retail media, and it is also the most fragmented to buy. Premium inventory is consolidating into a handful of ecosystems (by 2026 only YouTube, Amazon, and Disney each take more than 10 percent of US CTV ad sales), while access fragments into direct and preferred-DSP paths that push mid-market brands outside their primary platform. Amazon DSP is increasingly the central CTV buying route, carrying Prime Video and Fire TV plus third-party supply, but measurement is fragmenting rather than converging as Netflix, Disney, NBCU, and Roku each run proprietary methodologies that do not reconcile cleanly.

CTV pricing forces a completion adjustment the trader must apply. A CTV line is priced on a CPM, but you only get value from a completed view, so the comparison metric is completion-weighted CPM: the CPM divided by the video completion rate, which is the true price per completed view. Two CTV deals at the same headline CPM are not equal if one completes at 95 percent and the other at 70 percent.

:::predict
prompt: A CTV line buys at a $30 CPM with a 75% completion rate. What is the completion-weighted CPM (cost per completed view)?
answer: 40
tolerance: 0.5
unit: USD
hint: Divide the CPM by the completion rate.
explain: Completion-weighted CPM = $30 / 0.75 = $40 per thousand completed views. The 25 percent of impressions that never finish are paid for but worthless, so a line that looks cheaper on headline CPM can be more expensive per completed view once you weight it.
:::

:::quiz
question: Two CTV deals both quote a $24 CPM. Deal A completes at 96%, Deal B at 80%. Which is cheaper per completed view, and why?
- They cost the same, because the headline CPM is identical
- Deal B, because a lower completion rate means cheaper inventory
- Deal A, because $24 / 0.96 = $25.00 beats $24 / 0.80 = $30.00 per completed view
- Deal A, but only if it also carries a deal-ID
answer: 2
hint: Weight each headline CPM by its completion rate.
explain: Completion-weighted CPM is CPM divided by completion rate. Deal A is $24 / 0.96 = $25.00; Deal B is $24 / 0.80 = $30.00. Deal A delivers a completed view for $5.00 less even though the headline CPMs match, which is why the trader never compares CTV on raw CPM alone.
:::

# Judging off-site on iROAS, not on a console number

Off-site is where the ROAS-versus-iROAS gap bites hardest, because the take-rate makes the gross dollar expensive and the closed-loop console often does not even show the spend. The discipline is to judge off-site on iROAS measured against a holdout, using gross spend (everything the brand paid, including fees), not on a flattering working-media or last-touch number. An off-site line that posts a healthy reported ROAS but near-zero incremental lift is paying a full take-rate to re-reach shoppers who would have bought anyway, which is worse than the same waste on-site because off-site cost more to begin with.

This is also where the worst operator surprise lives. Off-Amazon DSP placements routinely run ACoS well over 100 percent, and because that spend surfaces on the invoice rather than in Campaign Manager, a trader can be bleeding budget into off-site inventory that is invisible in the daily console view. The defense is to reconcile off-site spend against the invoice every cycle (the fees lesson goes deep here) and to gate off-site budget on a holdout-based iROAS, not on a dashboard that cannot see it.

:::predict
prompt: An off-site DSP line drives $24,000 of incremental sales (measured against a holdout) on $8,000 of gross spend including all fees. What is the iROAS on gross spend?
answer: 3
tolerance: 0.05
unit: x
hint: Divide incremental sales by gross spend.
explain: iROAS = incremental sales / gross spend = $24,000 / $8,000 = 3.0x. Because the $8,000 already includes the DSP, exchange, and data take-rate, a 3.0x iROAS on gross is a real, defensible result. Measuring iROAS on working media instead would overstate it, which is exactly the flattery the trader has to refuse.
:::

:::callout warning
A real operator pain point: one seller discovered nearly half their PPC budget was flowing to off-Amazon DSP placements running ACoS over 100 percent, invisible in Campaign Manager and visible only on the monthly invoice (r/AmazonSeller, ppc.land). Even with the 2026 unified Campaign Manager, off-site spend still surfaces mainly on the bill, so reconcile every cycle and gate off-site budget on holdout iROAS, never on the console alone.
:::

:::sources
- mediaplanningtool, Amazon DSP Review 2026: Is the $50K Minimum Worth It? | https://www.mediaplanningtool.com/amazon-dsp
- mediaplanningtool, The Trade Desk vs DV360 vs Amazon DSP (2026 Comparison) | https://www.mediaplanningtool.com/the-trade-desk
- improvado, The Trade Desk vs DV360: A 2026 DSP Comparison for Marketers | https://improvado.io/blog/dv360-vs-the-trade-desk
- Velocity Sellers, Amazon DSP Self-Service for Mid-Size Brands in 2026 | https://www.velocitysellers.com/2026/05/25/amazon-dsp-self-service-mid-size-brands-2026/
- Skai, The 2026 State of Retail Media: DSP, CTV, and Social Commerce | https://skai.io/blog/the-2026-state-of-retail-media-dsp-ctv-and-social-commerce-accelerating-beyond-the-shelf/
- Direct Agents, CTV Turning Point: How the Amazon and Netflix Deal Could Redefine CTV Advertising | https://www.directagents.com/news/ctv-turning-point-how-the-amazon-netflix-deal-could-redefine-ctv-advertising/
- ppc.land, Amazon ad costs to auto-deduct from seller proceeds; off-site spend invoice-only | https://ppc.land/amazons-payment-grab-ad-costs-to-auto-deduct-from-seller-proceeds-april-15/
- IAB, Guidelines for Incremental Measurement in Commerce Media (Nov 2025) | https://www.iab.com/guidelines/guidelines-for-incremental-measurement-in-commerce-media/
:::
