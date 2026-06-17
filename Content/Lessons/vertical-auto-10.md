---
id: vertical-auto-10
track: vertical-auto
module: 10
title: Reporting, Troubleshooting, and the Operator's Daily Reality
summary: Build a tiered report that climbs from controllable proxies to VIN-matched net cost per sale, and diagnose a net-cost spike to its true owner (media, measurement, money, or store) instead of just raising a bid.
---
# The capstone: one report, the whole arc

Everything in this path collapses into a single weekly deliverable: a report that walks the dealer principal from numbers you control up to the one number they care about. The ladder runs cost per VDP view (Lesson 3) to cost per lead to cost per appointment to VIN-matched net cost per sale (Lessons 2 and 8), every rung framed against the co-op-funded budget and net of reimbursement (Lessons 2 and 9). The signature KPI sits at the top, but the proxy rungs underneath are what let you defend it when a single rooftop's sale count is too sparse to trust month to month.

The reason you report a ladder and not a single number is statistical: a rooftop sells tens of cars a month, not thousands, so net cost per sale is noisy and one slow week can swing it. The proxy rungs (VDP, leads, appointments) are high-volume and in your control, so they tell the real story while the sale count catches up.

:::figure costPerFundedCascade
caption: The tiered report climbs from high-volume proxies you control (VDP cost, CPL) up to the sparse money KPI (net cost per sale), each rung framed net of co-op reimbursement.
:::

:::predict
prompt: Your display line spends $6,000 and drives 2,000 qualified VDP views, and those generate 150 leads. Report the cost per VDP view and the cost per lead.
answer: 40
tolerance: 0.5
unit: USD per lead
hint: Cost per VDP view is spend over VDP views; cost per lead is the same spend over leads.
explain: Cost per VDP view is $6,000 / 2,000 = $3.00, just over the ~$2.50 used ceiling. Cost per lead is $6,000 / 150 = $40.00, in the self-generated search band. The predicted answer is the CPL, $40.
:::

# The money KPI, reported net of co-op

The top rung is net cost per sale, and the word "net" is load-bearing. You take total media spend, subtract the approved co-op reimbursement, and divide by VIN-matched units (Lesson 8). Reporting gross when the dealer expects net, or reporting net when a claim has actually been denied, both misstate the story by a factor of roughly two, because OEM co-op typically reimburses 50% of standard digital (up to 75% for approved-vendor programs).

This is why a co-op denial is dangerous on a report: it does not look like a compliance failure, it looks like your media got twice as expensive overnight. The cause lives in Lesson 9, but the symptom lands on your reporting line.

:::predict
prompt: You report net cost per sale on $36,000 of media. The OEM approves a 50% co-op reimbursement, and VIN matchback confirms 60 sold units that saw or clicked the media. What is the reported net cost per sale?
answer: 300
tolerance: 1
unit: USD
hint: Subtract the reimbursement from spend, then divide by VIN-matched units.
explain: Net spend is $36,000 - (0.50 x $36,000) = $18,000. Net cost per sale is $18,000 / 60 = $300.00. If that same claim were denied, the divisor stays 60 but net spend jumps to $36,000, doubling the reported figure to $600.
:::

:::quiz
question: A dealer principal sees net cost per sale jump from $300 to $600 month over month with identical spend and identical units sold. What is the most likely cause to check first?
- The display creative lost CTR
- The OEM denied or clawed back the co-op reimbursement claim
- The audience fatigued and CPMs rose
- The BDC got slower at responding to leads
answer: 1
hint: Spend and units did not change, so the divisor and the gross are the same. Only one input to net cost per sale moved.
explain: With spend and VIN-matched units both unchanged, only the co-op reimbursement could have flipped the net. A denied or clawed-back claim turns net spend from half to full, doubling net cost per sale. Creative, fatigue, and BDC speed would have moved units or proxy metrics, not just the net.
:::

# Per-channel ranking: where to move the next dollar

A blended number hides the lever. The actionable cut is net cost per sale by source, ranked, so you can shift budget from the highest-cost channel to the lowest. In auto the spread is enormous: Vehicle Listing Ads run roughly $150 to $450 per sale and Google search roughly $380 to $765, versus AutoTrader near $8,000 and Cars.com near $12,000 (Foundry CRO 2026). Reporting only the blend lets an $8,000 portal line quietly drag the average while you stay blind to it.

The discipline is to rank, then reallocate, then re-measure. Moving spend off a lead portal and onto owned-channel VLAs is the single highest-leverage move a Tier 3 trader makes, and it only becomes visible when the report is per-source.

:::widget barChart
title: Net cost per sale by channel (Tier 3 benchmarks)
labels: VLA, Google Search, Meta, AutoTrader, Cars.com
data: 300, 572, 611, 8000, 12000
unit: USD per sale
:::

:::predict
prompt: A portal line spends $24,000 and VIN matchback credits it with just 3 sales. The same $24,000 reallocated to VLAs at a $300 net cost per sale would produce how many sales, and what is the portal's net cost per sale?
answer: 8000
tolerance: 50
unit: USD per sale
hint: Portal net cost per sale is its spend over its sales; VLA sales are the same spend divided by the VLA cost per sale.
explain: The portal's net cost per sale is $24,000 / 3 = $8,000.00. That same $24,000 at $300 per sale on VLAs would yield $24,000 / $300 = 80 sales. The predicted answer is the portal's net cost per sale, $8,000, the number that justifies moving the budget.
:::

# Diagnosis: routing a spike to its true owner

The skill that separates a strong 0-to-100 hire from a bid-raiser is diagnosis. When net cost per sale spikes, it is one of four owners: media (drift, audience fatigue, a stale or disapproved feed), measurement (too-short attribution window, source-field mislogging), money (a denied or clawed-back co-op claim), or the store (slow BDC speed-to-lead, weak close rate). The wrong reflex is to raise the bid, which only treats a media symptom and misses the other three causes entirely.

Each owner has a tell. A media break moves your proxy rungs (VDP cost climbs above ~$2.50 used or ~$3.50 new, CTR drops, VLA-eligible inventory falls). A measurement break leaves proxies healthy but undercounts sales. A money break moves only the net (spend and units unchanged). A store break shows healthy media and leads but collapses at appointment-set or show. Your job is to read which rung moved and route the fix with evidence.

:::quiz
question: VDP cost and lead volume are both healthy and on benchmark, but VIN-matched sales came in low and net cost per sale spiked. The drop-off is at appointment-set and show, not at contact. Who owns the fix?
- Media: raise bids and refresh creative
- The store: BDC speed-to-lead and appointment-to-show
- Measurement: widen the attribution window
- Money: refile the co-op claim
answer: 1
hint: The media proxies are fine and leads arrived. The leak is downstream of anything a trader controls.
explain: Healthy VDP cost and lead volume mean media did its job; the collapse at appointment-set and show is store-side, owned by the BDC's speed-to-lead and the sales team's appointment-to-show. Sub-60-second response can close ~24% versus ~6% at 90-plus minutes, so the fix is routed to the store with that evidence, not to the bid.
:::

:::callout warning
A recurring DealerRefresh complaint: traders get blamed for flat sales when the real leak is BDC speed-to-lead or appointment-to-show, leads sit unworked in the CRM for 45-plus minutes, and feed breakage or Merchant Center disapprovals go unnoticed until a sales dip lands the blame on the media report. Co-op denials, OEM creative takedowns, and DMS source mislogging all surface on the trader's report as if they were media performance problems. The defense is the proxy ladder plus per-owner diagnosis: show that media-stage proxies were healthy and point to the exact downstream rung that broke.
:::

# The measurement trap and the store-side trap

Two non-media causes masquerade as media failures, and both are common enough to check by reflex. The measurement trap: a last-click-only model on a 7-to-30-day window drops auto's long-consideration sales (over 50% of buyers take 90-plus days), so good view-through-heavy display looks worthless. The fix is a 30-to-90-day window with view-through weighted (Lesson 8), and matchback on exposure data rather than the rep-entered source field, because a busy salesperson typing "walk-in" silently deletes your sale from the report.

The store-side trap is speed-to-lead. It is the top store-controlled lever and it swings the close rate more than any bid: a sub-60-second first response can close around 24% versus around 6% at 90-plus minutes. When sales lag but leads are healthy, you measure the lead-timestamp against the first-CRM-activity-timestamp and hand the dealer the speed data instead of absorbing the blame.

:::predict
prompt: Two stores each receive 50 of your leads. Store A responds in under 60 seconds and closes 24%. Store B responds in 90-plus minutes and closes 6%. How many more cars does Store A sell from the same 50 leads?
answer: 9
tolerance: 0.5
unit: sales
hint: Apply each close rate to 50 leads, then take the difference.
explain: Store A sells 50 x 0.24 = 12 cars. Store B sells 50 x 0.06 = 3 cars. The difference is 12 - 3 = 9 more sales from identical media and identical leads, which is a store-side lever, not a media one.
:::

:::widget lineChart
title: Close rate vs lead response time
labels: <60 sec, 1-5 min, 5-30 min, 30-90 min, 90+ min
data: 24, 20, 14, 9, 6
unit: percent close
:::

# The weekly cadence and the handoff

The operator's real rhythm is a loop: pull the tiered report, scan the proxy ladder against benchmark, rank channels by net cost per sale, diagnose any spike to its owner, and route fixes with evidence (a feed disapproval back to Merchant Center, a denied claim back to co-op QA, a slow-response pattern back to the BDC, a fatigued audience back to the bid and creative). The deliverable that earns trust is not a dashboard, it is a diagnosis: "net cost per sale rose because X broke, here is the proof, here is who fixes it."

That is the whole job in one sentence. You sit in the middle of a chain you do not fully own, and the value you add is knowing which link broke and proving it, so the right person fixes the right thing instead of the bid going up and the budget going to waste.

:::callout key
The strongest signal of a senior auto trader is the per-owner diagnosis. When net cost per sale spikes, name whether the cause is media, measurement, money, or store, back it with the proxy ladder, and route it. Anyone can raise a bid; the hire who gets promoted is the one who can prove the spike was a denied co-op claim or a slow BDC and keep the media line clean.
:::

:::quiz
question: Which weekly report structure best lets a Tier 3 trader defend performance on a low-volume rooftop and act on it?
- A single blended net cost per sale, reported alone
- Total impressions and clicks only
- A proxy ladder (VDP cost, CPL, cost per appointment) plus per-channel net cost per sale, net of co-op
- View-through impressions with no cost figures
answer: 2
hint: Sparse monthly sales are noisy, so you need high-volume proxies underneath and a per-source view to know where to move budget.
explain: The proxy ladder gives high-volume, controllable rungs that stabilize a noisy monthly sale count, and per-channel net cost per sale (net of co-op) shows where to reallocate. A lone blended number hides the dragging portal; impressions and clicks never reach the money KPI.
:::

:::sources
- Foundry CRO, Automotive Marketing Benchmarks 2026: CPC to Cost per Sale | https://foundrycro.com/blog/automotive-marketing-benchmarks-2026/
- Strolid, Lead Response Time: Why Speed Matters (Data and Benchmarks) | https://strolid.com/learn/lead-response-time-why-speed-matters-data-benchmarks
- Demand Local, How AI is Revolutionizing Attribution in Automotive Marketing (VIN matchback) | https://www.demandlocal.com/blog/ai-revolutionizing-attribution-automotive-marketing/
- DataFeedWatch, 6 Common Vehicle Ads Errors and How to Fix Them in Merchant Center | https://www.datafeedwatch.com/blog/google-vehicle-ads-errors
- Demand Local, How to Ensure OEM Compliance in Your Automotive Marketing Campaigns | https://www.demandlocal.com/blog/oem-compliance-automotive-marketing-campaigns/
- DealershipGuy, Dealer Ad Spend Nears $10 Billion as Digital Marketing Dominates (NADA 2025) | https://news.dealershipguy.com/p/dealer-ad-spend-nears-10-billion-as-digital-marketing-dominates
- DealerRefresh, Why are third parties running Google VLA ads on MY vehicles? Shut it down! | https://forum.dealerrefresh.com/threads/why-are-third-parties-running-google-vla-ads-on-my-vehicles-shut-it-down.9894/
:::
