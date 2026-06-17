---
id: vertical-b2b-10
track: vertical-b2b
module: 10
title: Capstone: Running One ABM Campaign End to End
summary: Chain every prior skill into one live ABM campaign, from ACV tier and list match through bid ceiling, inventory, creative, pacing, funnel, incrementality, and final LTV:CAC reporting.
---
# The scenario and the chain

You sell a $60,000-ACV mid-market SaaS product, and the buying committee runs around 11 stakeholders across roughly four functions. The VP of Demand Gen hands you a 4,000-account target list and a quarterly pipeline goal, and the only question that will matter at the readout is LTV:CAC on a cycle-length window, not CTR or CPM. Every individual tactic you learned now runs once, in order, on one campaign: tier, then list and match, then bid, then inventory, then creative and flight, then pacing, then funnel, then reconcile, then incrementality, then LTV:CAC.

The thing new hires freeze on is not any single step. It is holding the whole chain in their head while a live campaign runs, because data owns the list, sales owns the opps, finance owns the CAC target, and nobody sees the loop end to end except the trader. This lesson is that loop, run once.

:::callout key
The capstone is one rule: spend flows tier to list/match to bid to inventory to creative/flight to pacing to funnel to reconcile to incrementality to LTV:CAC. Skip a link and the campaign either underpaces, overpays, or gets killed at the 30-day read before the 84-day cycle has even closed a deal.
:::

:::quiz
question: At the end-of-quarter readout for this $60K-ACV ABM campaign, what is the single metric the trader is actually accountable for?
- Click-through rate on the LinkedIn document ads
- Average CPM versus the open-exchange benchmark
- LTV:CAC (and CAC payback) measured on a cycle-length window
- Total impressions delivered against the target accounts
answer: 2
hint: The mandate from Lesson 2 never changes, no matter how many tactics sit underneath it.
explain: The whole chain exists to produce efficient pipeline, scored as LTV:CAC and CAC payback over a window at least as long as the sales cycle. CTR, CPM, and raw impressions are inputs the trader controls, not the outcome leadership judges.
:::

# Step 1: Tier sets the budget, list and match set the reach

The ACV tier is the first decision because it sizes everything downstream. A $60,000-ACV mid-market deal sits between SMB and enterprise, so the team sets an allowable CAC of about $6,000 (roughly 10 percent of ACV) as the per-acquisition planning ceiling that feeds the bid math in Step 3. Then you onboard the 4,000-account list into the DSP and LinkedIn and read the match rate, the number that decides whether the audience can deliver at all.

Accounts match at about 78 percent on company domain, and contacts match at about 55 percent on work email, far better than the 30 percent you would get from personal Gmail or Yahoo addresses. You suppress current customers, opt-outs, and competitors before activation, confirm a lawful basis under GDPR and CAN-SPAM, and migrate the matched audience to durable identity (UID2 and RampID, both keyed off the same work emails) so the list does not silently shrink as cookies and MAIDs decay.

:::predict
prompt: You upload 4,000 target accounts and 3,120 match in the DSP on company domain. How many accounts are reachable?
answer: 3120
tolerance: 0
unit: accounts
hint: Reachable accounts equals uploaded accounts times the account match rate.
explain: 4,000 times 0.78 equals 3,120 reachable accounts. The other 880 are unaddressable this flight, which is why the trader plans reach off 3,120, not the full 4,000.
:::

:::predict
prompt: You onboard 16,000 contacts at a 55% work-email match rate, then suppress 1,300 existing customers and opt-outs. What is the deliverable contact audience?
answer: 7500
tolerance: 0
unit: contacts
hint: Apply the match rate first, then subtract suppression.
explain: 16,000 times 0.55 equals 8,800 matched contacts. Subtract the 1,300 suppressed and you have 7,500 deliverable contacts. Activating before suppression would have wasted budget on people you must not contact and risked compliance penalties.
:::

# Step 2: Bid ceiling, then inventory

With the tier and the allowable CAC fixed, you work backward to a defensible bid ceiling. The max CPM equals the allowable CAC times the closed-won rate per thousand impressions, so a richer mid-market account justifies a far higher CPM than an SMB one, and you set the ceiling per tier and per funnel stage rather than one global cap that overpays for SMB and starves enterprise reach. Because CTR is a vanity signal on this inventory, you optimize bids toward downstream account and pipeline value, not cheap clicks.

Then you source the impressions. Open-exchange B2B is thin, and while industry-wide made-for-advertising waste has fallen sharply (the ANA's Q2 2025 benchmark puts MFA at a median of about 0.8 percent of spend, down from roughly 15 percent in 2023), the open market still carries disproportionately more MFA and low-quality inventory than curated supply (top-quartile exposure still runs as high as 28.7 percent), so you buy through curated PMP deals where the inventory is cleaner and more targetable, apply pre-bid brand-safety and IVT filters, and reconcile the DSP-versus-SSP impression gap against the roughly 10 percent normal threshold. A perfect account match rendered on an MFA page is still wasted, so supply quality and audience quality have to hold together.

:::predict
prompt: Allowable CAC is $6,000 and the campaign converts 0.0008 closed-won deals per 1,000 impressions. What max CPM can the mid-market tier sustain (to one decimal)?
answer: 4.8
tolerance: 0.05
unit: USD CPM
hint: Multiply the allowable CAC by the closed-won rate per thousand impressions.
explain: 6,000 times 0.0008 equals 4.8, so the tier can sustain a max CPM of about $4.80 on prospecting inventory. A $100K-ACV enterprise account at the same conversion rate would justify a far higher ceiling, which is exactly why ceilings are tiered.
:::

:::quiz
question: Open-market CPM is $4.41 and the curated PMP deal is $7.15. Why does the trader often pay the PMP premium anyway?
- PMP impressions are cheaper per thousand than open-market
- The cleaner, more targetable PMP inventory can be cheaper per real, on-target impression once MFA and IVT waste are removed
- LinkedIn requires all B2B inventory to be bought through PMP deals
- PMP deals are exempt from impression discrepancy reconciliation
answer: 1
hint: Compare cost per legitimate, on-target impression, not the raw CPM sticker.
explain: The higher PMP CPM buys impressions that actually reach target accounts on brand-safe pages, while the cheap open-market CPM quietly loses a disproportionate slice to MFA and IVT (open-market MFA exposure still reaches as high as 28.7 percent in the top quartile even as the blended median has fallen below 1 percent). Net of waste, the premium inventory is frequently cheaper per impression that can pay back.
:::

# Step 3: Creative, flight, and pacing the cycle

Now the levers that decide performance on expensive inventory. You run the forced split: LinkedIn as a walled garden bought in-platform (thought-leader and document ads top-funnel for cheap engagement, conversation ads to push the demo offer to warm in-market accounts) and the open DSP for display, native, and CTV, then de-duplicate frequency across both so accounts are not over-served on one and missed on the other. You match the offer to intent (gated assets for cold prospecting, the higher-friction demo for sales-ready accounts), enforce ad-to-landing-page message match because personalized ABM pages convert about 3x generic ones, and rotate creative every 2 to 3 weeks before LinkedIn fatigue quietly lifts your effective CPM.

Pacing is where naive monthly thinking breaks. The median cycle is about 84 days, so you pace to sustained always-on reach across the cycle, not a burst you judge at 30 days, and you size reach on stakeholders per account, not accounts, because one impression per company never reaches an 11-person committee. Front-loading the budget burns reach before the committee has even formed.

:::predict
prompt: You pace to reach all 3,120 matched accounts at 8 stakeholders each, at a target frequency of 5 over the month. What is the required monthly impression reach?
answer: 124800
tolerance: 0
unit: impressions
hint: Multiply accounts by stakeholders per account, then by target frequency.
explain: 3,120 times 8 equals 24,960 unique people, and 24,960 times 5 equals 124,800 impressions per month. Pacing to 3,120 accounts at frequency 5 would have bought only 15,600 impressions and left most of each committee untouched.
:::

:::figure abmPipeline
caption: The capstone funnel for one ABM campaign. Each prior lesson owns one stage, from list match and intent prioritization through engagement, opportunities, and closed-won, so the trader can read where the chain leaks.
:::

# Step 4: Funnel, reconciliation, and the long-cycle read

With the campaign live, you connect ad exposure to CRM stages by passing UTMs and account IDs through, so a display or LinkedIn impression can be traced to an account that later becomes an opportunity. You read the stage-to-stage decay to find the leak, knowing the MQL-to-SQL handoff is the usual bottleneck, and you do not panic at this month's flat pipeline because the cohort matures about 84 days later. You also reconcile twice: DSP-versus-SSP impressions against the 10 percent threshold, and platform-reported conversions against CRM opportunities, because platforms over-claim and double-count across the LinkedIn and open-DSP split.

The trap that kills working B2B campaigns is the short window. A 30-day ROAS read on an 84-day cycle systematically understates the buy, so you evaluate on a window at least as long as the cycle. The chart below shows the same spend reading like a loss early and 3-8x by 180 days.

:::widget lineChart
title: Same spend, ROAS by evaluation window (180-day truth vs 30-day illusion)
labels: 30 days, 60 days, 90 days, 120 days, 180 days
data: 0.6, 1.4, 2.5, 4.0, 6.0
unit: x ROAS
:::

:::quiz
question: At day 30 the campaign shows a 0.6x ROAS and leadership wants it turned off. What does the trader correctly point to?
- The CTR is above benchmark, so the campaign is healthy
- The 84-day median cycle means the window is too short, and the same spend trends toward 3-8x by 180 days
- The platform-reported conversions already prove the campaign worked
- Open-exchange CPMs were cheaper, so ROAS will recover automatically
answer: 1
hint: The problem is the measurement window, not the media buy.
explain: A 30-day window on an 84-day cycle guarantees a long-cycle channel looks unprofitable before deals close. The correct response is to evaluate on a cycle-length window, where the same spend reads 3-8x, not to cut a working campaign at day 30.
:::

# Step 5: Prove incrementality, then report in LTV:CAC

Correlation is not enough at the readout, so you prove the spend caused pipeline. You withhold the paid channel from a matched subset of target accounts for 60 to 90 days and measure incremental lift as the difference in conversion between exposed and held-out accounts, then layer self-reported attribution ("how did you hear about us?" at high-intent conversion) to surface the roughly 70 percent of the journey that lives in the dark funnel and that last-click never sees. You blend the quantitative model at about 70 percent weight with self-reported survey data at about 30 percent.

Then you report the only thing that matters. Five closed-won deals at $60,000 ACV, with an LTV of 3x ACV, against the campaign spend, gives the campaign LTV:CAC and a CAC payback in months, both on a cycle-length window. That number, not CTR or CPM or a 30-day ROAS, is what tells leadership the campaign worked, and it closes the loop the whole chain was built to reach.

:::predict
prompt: The campaign spends $90,000 and produces 5 closed-won deals at $60,000 ACV each, with an LTV equal to 3x ACV. What is the campaign LTV:CAC ratio (to one decimal)?
answer: 10
tolerance: 0.1
unit: ratio (:1)
hint: Total LTV across the won deals, divided by total campaign spend.
explain: LTV per deal is 3 times $60,000, which is $180,000, and 5 deals give $900,000 in lifetime value. Divided by the $90,000 spend that is a 10.0:1 LTV:CAC, comfortably clearing the 3:1 minimum from Lesson 2.
:::

:::predict
prompt: Same campaign: $90,000 spend, 5 closed-won deals. Monthly ARPA is $5,000 and gross margin is 80%. What is the CAC payback in months?
answer: 4.5
tolerance: 0.1
unit: months
hint: First get CAC per customer, then divide by monthly gross-margin dollars per customer.
explain: CAC is $90,000 divided by 5, or $18,000 per customer. Monthly gross-margin dollars are $5,000 times 0.80, which is $4,000. So payback is 18,000 divided by 4,000, equal to 4.5 months, faster than the 6-to-8-month top-quartile band and inside the best-in-class under-6-month tier, against a B2B SaaS median near 15 months.
:::

:::widget barChart
title: One ABM campaign down the funnel (account count by stage)
labels: Target, Matched, In-Market, Engaged, Opps, Won
data: 4000, 3120, 900, 320, 40, 5
unit: accounts
:::

:::callout warning
The most common operator failure is not running any single step, it is tying media exposure all the way to closed-won and LTV:CAC while four teams each own a different link in the chain. New hires can recite the tactics but freeze on a live campaign that spans all of them, and the trader who declares success on platform-reported conversions without an incrementality holdout or a CRM reconciliation over-credits the buy and loses the room.
:::

:::sources
- eMarketer, US B2B Digital Ad Spending 2026 | https://www.emarketer.com/content/b2b-digital-ad-spending
- Optifai, B2B Sales Cycle Length Benchmarks (939 companies by deal size and segment) | https://optif.ai/learn/questions/sales-cycle-length-benchmark/
- The Trade Desk, A Marketer's Guide to Testing Unified ID 2.0 | https://www.thetradedesk.com/resources/marketers-guide-to-testing-unified-id-2-0
- ANA, Q2 2025 Programmatic Transparency Benchmark (waste, MFA, curation) | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
- The Digital Bloom, 2025 B2B SaaS Funnel Benchmarks and Pipeline Audit Framework | https://thedigitalbloom.com/learn/pipeline-performance-benchmarks-2025/
- Improvado, B2B Marketing Attribution in 2026: Multi-Touch, MMM, Incrementality and Dark Funnel | https://improvado.io/blog/b2b-marketing-attribution
- Growthspree, Dark Funnel ABM Attribution for B2B 2026 (self-reported attribution, geo holdouts) | https://www.growthspreeofficial.com/blogs/dark-funnel-abm-attribution-b2b-2026
- Foundry CRO, CAC Payback Period Benchmarks 2026 (Bessemer scale, top-quartile and median by stage) | https://foundrycro.com/blog/cac-payback-benchmarks-2026/
:::
