---
id: vertical-ecommerce-10
track: vertical-ecommerce
module: 10
title: Closing the Loop, Make-Goods, Bulk Ops Tooling, Creative and Feed QA, and the QBR
summary: Diagnose delivery shortfalls and discrepancies, negotiate make-goods, run bulk operations at catalog scale, QA creative and feeds, and present a QBR scorecard led by contribution margin, blended CAC, MER, and incrementality rather than platform ROAS.
---
# The whole arc lands here, the P and L is the scoreboard

Every prior lesson built toward one quarterly act: defending real results to the client against the P and L instead of the platform dashboard. The through-line is that platform ROAS is an input you manage and a claim you verify, while contribution margin, blended CAC, MER, new-customer share, and incrementality are the scoreboard. This closing module is the operations layer that keeps that scoreboard honest at scale: troubleshooting delivery, recovering lost value through make-goods, running bulk changes across thousands of ASINs, QA-ing creative and feeds, and walking the QBR.

The role's north star stays fixed across all of it: LTV:CAC net of returns and MER, not a vanity platform ROAS. A trader who closes the loop well makes the next quarter's budget and bid targets follow the evidence.

:::callout key
The single test for a good QBR: would the story survive if you deleted every platform ROAS figure from the deck? If the recommendation only holds up with platform ROAS, you are defending a number the auction handed you, not a result you caused.
:::

The cheapest way to feel the difference between the dashboard and the scoreboard is to compute one scoreboard metric by hand. Blended CAC ignores which platform claimed the sale and just divides total acquisition spend across every channel by the new customers the business actually gained, so try it before the formula-heavy sections.

:::predict
prompt: Across all channels the account spent $240,000 to acquire customers this quarter and the business gained 4,000 net-new customers. What is blended CAC (to the nearest dollar)?
answer: 60
tolerance: 1
unit: USD
hint: Blended CAC is total cross-channel acquisition spend divided by total net-new customers.
explain: $240,000 / 4,000 = $60 blended CAC. Unlike summed platform CAC, this number cannot be inflated by two channels each claiming the same conversion, which is exactly why the QBR scorecard leads with it instead of platform ROAS.
:::

# Discrepancies, diagnose the cause before you claim a make-good

A discrepancy is the gap between two impression counts for the same flight, typically the platform's served count versus a third-party or log-level count (the same counting-point problem from the measurement plumbing lesson, now at the campaign level). The under-delivery or discrepancy percent is

$$ \text{Discrepancy \%} = \frac{\text{Contracted (or platform) impressions} - \text{Delivered (or log) impressions}}{\text{Contracted (or platform) impressions}} $$

A gap can come from viewability and measurement differences, IVT filtering stripping invalid impressions, or timezone cutoffs that split a day differently on each side, so the trader diagnoses the cause first rather than treating two raw numbers as proof. On a guaranteed or managed buy, a genuine shortfall is recoverable; on an open-auction buy there is nothing to make good because nothing was guaranteed.

:::predict
prompt: A campaign contracted 2,000,000 impressions but platform logs show 1,700,000 delivered. What is the under-delivery (discrepancy) percent?
answer: 15
tolerance: 0.5
unit: %
hint: Subtract delivered from contracted, then divide by contracted.
explain: (2,000,000 - 1,700,000) / 2,000,000 = 300,000 / 2,000,000 = 0.15, a 15 percent under-delivery. On a guaranteed buy that shortfall is the basis for a make-good claim, but only after ruling out viewability, IVT filtering, and timezone-cutoff causes.
:::

# Make-goods, turning a shortfall into recovered value

When a guaranteed buy under-delivers, the trader negotiates a make-good: added impressions or a credit that recovers the value the client paid for and did not receive. The value of an impression make-good is simply the owed impressions priced at the agreed CPM,

$$ \text{Make-good value} = \frac{\text{Under-delivered impressions}}{1000} \times \text{agreed CPM} $$

The practical craft is matching the make-good to the original intent: added impressions only help if they reach the same audience in a window the client still values, otherwise a credit is the cleaner recovery. Delivery pacing against the contract, $\text{Delivery pacing} = \text{Impressions delivered} / \text{Impressions contracted to date}$, is the metric you monitor mid-flight so a shortfall surfaces while there is still time to pace up rather than after the flight closes.

:::predict
prompt: A make-good owes 300,000 impressions at an agreed $8 CPM. What is the make-good value?
answer: 2400
tolerance: 1
unit: USD
hint: CPM is cost per thousand, so divide impressions by 1000 first.
explain: 300,000 / 1000 = 300 thousand-impression units, and 300 times $8 = $2,400. That is the value the trader recovers for the client, either as added delivery or as a credit.
:::

:::quiz
question: A guaranteed CTV buy shows the platform reporting 1,000,000 impressions but the advertiser's third-party verification logs only 880,000. Before claiming a make-good, what should the trader do first?
- Immediately demand 120,000 make-good impressions
- Diagnose whether the gap is viewability, IVT filtering, or a timezone cutoff
- Pause the campaign and reallocate the budget
- Lower the agreed CPM retroactively
answer: 1
hint: Two raw numbers rarely tell the whole story; some of the gap may be legitimate filtering.
explain: A 12 percent gap can be partly legitimate (IVT filtering, viewability measurement, or a timezone cutoff splitting the day differently). The trader diagnoses the cause before claiming, because some of that gap is not owed. Demanding the full 120,000 blindly, pausing, or rewriting the CPM are all wrong responses to an undiagnosed discrepancy.
:::

# Bulk operations, no one manages a catalog one keyword at a time

A real Amazon or Walmart account spans thousands of ASINs and campaigns, so the trader works through operator tooling, Pacvue, Skai, Perpetua, and platform bulksheets, to run bulk bid changes, dayparting, negative-keyword and negative-ASIN application, and reporting at scale. Tooling fluency is a core role skill, not a convenience, because manual single-keyword management does not survive contact with a production catalog. The trade-off the trader weighs constantly is whether a paid bulk tool earns its cost versus native bulksheets for a given catalog size.

The danger of leverage is blast radius: a bulk bid change can mass-apply an error across thousands of campaigns in one upload, so bulksheet edits need validation and staging the same way a code change needs review before it ships to production.

:::callout warning
The most-cited operator pain in this layer, straight from practitioner forums: bulk tools are a debate (Pacvue vs Skai vs Perpetua vs native bulksheets is a recurring cost-versus-value argument), and a single un-validated bulksheet upload can push a typo'd bid or a wrong negative across an entire account before anyone notices. Treat every bulk edit as a deploy: stage it, validate a sample, and keep the prior state so you can roll back.
:::

Dayparting is the canonical bulk move: one bulksheet sets hour-by-hour, day-by-day bid modifiers across thousands of ASINs at once, which is precisely why a single wrong cell has account-wide blast radius. Read the heatmap as the staged diff you validate before upload, then picture a typo flipping a whole column the wrong way.

:::figure daypartingHeatmap
caption: A dayparting bid-modifier grid (hour of day by day of week) of the kind a single bulksheet applies across an entire catalog at once. Warmer cells push bids up in high-conversion windows and cooler cells pull them down in weak ones. The leverage is the point and the danger: because one upload writes every cell, a trader stages the sheet, validates a sample of ASINs, and keeps the prior state to roll back, treating the bulk edit like a production deploy.
:::

# Creative and feed QA, what silently stops serving

Two upstream gates decide whether spend can convert at all, and both fail quietly. Creative must stay approved and on-policy across Sponsored Brands, DSP, PMax, and Meta, and it must be refreshed to fight fatigue, which shows up as CTR decay at stable frequency: $\text{Creative fatigue signal} = \text{CTR decline \%}$ over the flight at flat frequency. The product feed must stay clean (correct GTIN and MPN, price and availability parity, disapprovals fixed) because a disapproved or stale Merchant Center feed silently halts Shopping and PMax delivery, the open-web analog of an out-of-stock Amazon ASIN.

Refresh cadence is a balance: refreshing creative too late wastes spend on fatigued units, while refreshing too often resets the learning phase and starves automated bidding of the volume it needs to exit learning. The trader times the swap to the fatigue signal, not the calendar.

:::widget lineChart
title: Creative fatigue, CTR decay at stable frequency over a flight
labels: Week 1, Week 2, Week 3, Week 4, Week 5, Week 6
data: 0.62, 0.58, 0.51, 0.44, 0.38, 0.33
unit: % CTR
:::

:::quiz
question: A PMax campaign's spend drops to near zero overnight with no setting change. Which cause should the trader check first?
- The CFO cut the budget
- A silent Merchant Center feed disapproval stopped products from serving
- Consumer demand collapsed in a single night
- The platform ROAS target was met
answer: 1
hint: This is the open-web analog of an out-of-stock Amazon ASIN.
explain: A stale or disapproved feed (wrong GTIN, price or availability mismatch) silently halts Shopping and PMax delivery while spend reallocates blindly, exactly like a stocked-out ASIN that keeps a campaign from converting. Demand rarely vanishes overnight, a budget cut would be a known change, and hitting a ROAS target throttles rather than zeroes delivery.
:::

# The QBR scorecard, lead with the mandate not the dashboard

The QBR closes the loop by reporting against the mandate. The recommended buy-side scorecard leads with contribution margin (CM2 and CM3 net of returns), blended CAC, MER, new-customer share, and incrementality, explicitly not platform ROAS. MER is the un-gameable top-line check because it ignores who claimed the sale: $\text{MER} = \text{Total revenue} / \text{Total ad spend (all channels)}$. A QBR that leads with platform ROAS lets a cannibalizing or non-incremental campaign look like a win, the exact failure this arc was built to prevent.

The two findings a QBR must surface to reset targets honestly are the ones from the incrementality lesson: Performance Max showed keyword overlap with Search in roughly 91 percent of accounts (Optmyzr, 503 accounts, Feb 2025), and head-to-head incrementality tests found Meta Advantage Plus Shopping delivered lower incremental lift than manual campaigns (Haus, 640 experiments, roughly 17 percent post-treatment lift versus about 32 percent for manual). The ANA's finding that roughly $26.8B of programmatic value was wasted in 2025 is why supply-quality and SPO evidence now sit alongside incrementality in the deck.

:::predict
prompt: Total revenue across all channels is $640,000 and total ad spend is $160,000. What is MER (x)?
answer: 4
tolerance: 0.05
unit: ratio (x)
hint: MER is total revenue divided by total ad spend.
explain: $640,000 / $160,000 = 4.0x. Because MER blends every channel and ignores which platform claimed the sale, it cannot be inflated by attribution the way summed platform ROAS can, which is why it anchors the QBR scorecard.
:::

:::figure discrepancyWaterfall
caption: The discrepancy-to-recovery waterfall a QBR walks through. Contracted impressions step down to platform-delivered, then to log-verified after IVT and viewability filtering, exposing the genuine shortfall, and the make-good adds impressions or credit back to close the gap. The same diagnose-then-recover logic feeds the QBR scorecard rather than a raw two-number comparison.
:::

# Re-basing bid targets on incrementality, the honest reset

The payoff of the scorecard is a corrected bid ceiling. Platform-reported CAC flatters itself by claiming observed conversions, so the trader re-bases targets on incremental CAC: $\text{Incremental CAC} = \text{Ad spend} / \text{Incremental (truly caused) new customers}$. When a geo holdout or lift test shows only part of the reported conversions were caused by the media, the true cost per customer jumps, and the bid target must come down to keep the campaign inside the contribution-margin ceiling.

This is where the vertical's north star, LTV:CAC net of returns, gets enforced in the actual auction levers. A ratio that looked healthy on platform CAC can fall to or below target once incremental CAC replaces it, and that is the number you re-base bids against, not the dashboard's flattering version.

:::predict
prompt: A campaign spent $30,000 and the platform reported 600 new customers, but a geo holdout shows only 30% were truly incremental. What is the incremental CAC (to the nearest dollar)?
answer: 167
tolerance: 1
unit: USD
hint: First find truly incremental customers (30% of 600), then divide spend by that.
explain: Incremental customers = 600 x 0.30 = 180. Incremental CAC = $30,000 / 180 = $166.67, about $167, versus the platform-reported $30,000 / 600 = $50. The honest cost is more than 3x the dashboard figure, so the bid ceiling must drop accordingly.
:::

:::predict
prompt: Gross-margin LTV per customer is $180. Using the incremental CAC of about $90 (after a holdout halves a 600-customer claim to 300 truly incremental at $27,000 spend), what is the LTV:CAC ratio you should re-base bids against?
answer: 2
tolerance: 0.05
unit: ratio (x:1)
hint: Recompute incremental CAC first ($27,000 / 300), then divide LTV by it.
explain: Incremental CAC = $27,000 / 300 = $90. LTV:CAC = $180 / $90 = 2.0:1. If platform CAC had implied a comfortable 4.0:1 ($180 / $45, where platform CAC is $27,000 / 600 = $45), the holdout-corrected 2.0:1 is the real picture, and bids should be reset to push the ratio back toward the 3:1 target rather than scaled up on a flattering platform number.
:::

:::sources
- AdExchanger, For Meta Marketers, Automation Isn't Always The Advantage | https://www.adexchanger.com/measurement/for-meta-marketers-automation-isnt-always-the-advantage-but-its-complicated/
- Optmyzr, Is Performance Max Cannibalizing Your Search Campaigns? | https://www.optmyzr.com/blog/is-pmax-cannibalizing-search/
- ANA, Q2 2025 Programmatic Transparency Benchmark | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
- Perpetua, Amazon Total ACoS (TACoS): Introduction to a Key Ad Metric | https://perpetua.io/blog-amazon-tacos/
- Stella, How to Conduct an Incrementality Study on Meta's ASC Campaigns | https://www.stellaheystella.com/blog/how-to-conduct-an-incrementality-study-on-metas-asc-campaigns-advantage-shopping-campaigns
- SalesDuo, Amazon Advertising Benchmarks 2026 | https://salesduo.com/blog/amazon-advertising-benchmarks/
- Google, Merchant Center: About product data quality and disapprovals | https://support.google.com/merchants/answer/6149970
:::
