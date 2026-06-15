---
id: adops-01
track: adops
module: 1
title: The AdOps Role and the Campaign Lifecycle
summary: What ad operations does across the buy side and sell side, the campaign from RFP through wrap report, and the pacing math that keeps delivery on track.
---
# What ad operations actually does

Ad operations is the team that turns a signed deal into ads that actually serve, on time, in full, and measured correctly. Sales and planning agree on what a campaign should do. AdOps makes it happen and keeps it happening. The job sits in the middle of the workflow: it receives a booked order, sets it up in the ad server or DSP, gets the creative live, watches delivery every day, fixes what breaks, and closes the books at the end.

The same function exists on both sides of the market, mirrored. On the sell side, publisher AdOps takes a signed insertion order from the direct-sold team, builds the line items in the ad server, traffics the creative, and is accountable for delivering the contracted impressions. On the buy side, agency or DSP AdOps (often called a campaign manager or trader) takes the media plan, builds the campaign in the buying platform, and is accountable for spending the budget efficiently against the goal. One side owes impressions, the other owes performance, and both live or die on pacing.

:::callout key
AdOps owns execution: setup, trafficking, QA, delivery monitoring, optimization, and reconciliation. Sales owns the deal, planning owns the strategy, AdOps owns whether it actually runs.
:::

:::quiz
question: A publisher's direct-sold team closes a $200,000 guaranteed display deal. Whose job is it to build the line items, traffic the creative, and make sure the impressions deliver?
- The sales rep who closed the deal
- The media planner who built the plan
- The publisher's ad operations team
- The advertiser's creative agency
answer: 2
hint: Think about who owns execution after the deal is signed.
explain: Sales closes the deal and planning shapes the strategy, but ad operations owns execution. On the sell side that means building the line items, trafficking the creative, and being accountable for delivering the contracted impressions.
:::

# The handoff from sales and planning to ops

Nothing reaches AdOps until a deal is real. On the sell side the sequence is RFP, then proposal, then negotiation, then a signed insertion order. The advertiser or agency builds a media plan, sends a Request for Proposal to publishers, the publishers respond with available inventory and pricing, the two sides negotiate, and the agreed terms are written into an insertion order, or IO. The IO is the contract. It names the advertiser and publisher, the flight dates, the placements and ad specs (for example a 300x250 or 728x90 unit), the targeting, the pricing model (CPM, CPC, CPA, or flat fee), the total budget, the reporting cadence, and the cancellation and make-good terms. IAB and the 4As publish standard templates and terms so both sides start from the same language.

When the IO is signed it hands off to AdOps. A clean handoff includes the IO, the final creative or tags, the tracking and verification requirements, and a named owner for questions. A messy handoff (missing specs, late creative, a budget that does not match the plan) is the single most common reason a campaign launches late. Ops cannot start the clock until the inputs are complete.

:::callout insight
The insertion order is the source of truth for the whole lifecycle. The numbers you bill against at the end, and the make-good math if you under-deliver, all trace back to the budget and dates written on the IO.
:::

:::quiz
question: In a sell-side direct deal, which document is the binding contract that ad operations sets up against and bills against at the end?
- The Request for Proposal (RFP)
- The media plan
- The insertion order (IO)
- The wrap report
answer: 2
hint: One of these is signed by both parties before any ad serves.
explain: The RFP starts the conversation and the media plan shapes strategy, but the insertion order is the signed contract. It carries the budget, dates, specs, and make-good terms that govern setup, billing, and reconciliation.
:::

# The campaign lifecycle, end to end

Once ops owns the campaign, the lifecycle runs in a fixed order. Skipping a step shows up later as a discrepancy, an under-delivery, or a billing dispute.

Setup and trafficking come first. The trafficker builds the campaign structure (orders and line items on the sell side, campaigns and ad groups on the buy side), enters the budget, dates, targeting, and pacing from the IO, then traffics the creative or third-party tags into each placement. Pre-launch QA follows: confirm the creative renders, the click-through URL and landing page work, the tracking and verification pixels fire, targeting and frequency caps are set, and the budget and dates match the IO exactly. A second person usually checks, because the cheapest bug to fix is the one caught before launch.

Then the campaign launches. Within roughly the first 90 minutes ops checks the server to confirm impressions are serving and clicks are tracking, and over the first 24 to 72 hours watches that spend ramps as expected. After that comes the daily work: delivery and pacing monitoring, plus in-flight optimization (shifting budget to the placements, audiences, or creative that perform, pausing what does not, and correcting pacing). At the end of the flight, billing and reconciliation match the numbers that bill against the delivered numbers, resolve any discrepancy, and apply credits or make-goods. Finally the wrap report, or post-campaign analysis (PCA), tells the client what happened against goal and what to do next time.

:::quiz
question: A trafficker finishes building a campaign from the IO and is about to set it live. What is the correct next step before launch?
- Bill the advertiser for the full budget
- Run pre-launch QA on creative, links, tracking, targeting, and dates
- Write the post-campaign analysis
- Start optimizing budget across placements
answer: 1
hint: One step exists specifically to catch errors before any impression serves.
explain: Pre-launch QA comes between setup and launch. You confirm the creative renders, links and landing pages work, pixels fire, and targeting, caps, budget, and dates match the IO. Billing, optimization, and the PCA all happen later in the lifecycle.
:::

# Pacing math: index, projection, and the flags

Pacing is the rate at which a campaign spends its budget or serves its impressions across the flight. The core question every day is simple: are we spending fast enough, too fast, or just right for where we are in the flight? You answer it with a pacing index, which compares how much of the budget is gone against how much of the flight is gone.

$$ \text{pacing index} = \frac{\text{spend to date} / \text{total budget}}{\text{days elapsed} / \text{flight length}} $$

An index of 1.0 is perfectly on pace. Above 1.0 means over-pacing (you are spending ahead of schedule and risk exhausting the budget early). Below 1.0 means under-pacing (you are behind and risk leaving money or impressions on the table at the end). Even pacing spreads delivery flat across the flight, the default for most guaranteed deals. ASAP and front-loaded pacing deliberately spend faster early: Google Ad Manager's even mode actually front-loads a small 5 percent each day, while its front-loaded mode targets about 40 percent above the flat daily goal at the start, and a common front-load heuristic is to spend roughly 60 percent of budget in the first half.

To see where you will land, project end-of-flight spend by extending your current daily rate across the whole flight.

$$ \text{projected end spend} = \frac{\text{spend to date}}{\text{days elapsed}} \times \text{flight length} $$

If the projection lands well under the budget, you are under-delivering and need to raise bids, loosen targeting, or add inventory. If it lands well over, you will exhaust early and go dark before the flight ends, so you throttle. A small drift is normal; a sustained gap of more than about 10 to 20 percent is the flag to act, and most IOs treat under-delivery beyond a contracted threshold (often around 20 percent) as triggering a make-good.

:::figure pacingCurve
caption: The even pacing line rises steadily to the budget by the flight's end. A campaign tracking above the line is over-pacing and will exhaust early, one tracking below is under-pacing and will under-deliver.
:::

:::predict
prompt: A campaign has spent 40% of its budget at the point when 50% of the flight has elapsed. What is its pacing index?
answer: 0.8
tolerance: 0.02
hint: Divide the share of budget spent by the share of the flight elapsed.
explain: Pacing index = (40% / 100%) / (50% / 100%) = 0.40 / 0.50 = 0.8. An index of 0.8 is below 1.0, so the campaign is under-pacing and will under-deliver unless spend accelerates.
:::

:::predict
prompt: A $90,000 campaign runs for a 30-day flight. After 12 days it has spent $30,000. Projecting the current daily rate across the full flight, what is the projected end-of-flight spend?
answer: 75000
tolerance: 100
unit: $
hint: Find the daily spend rate, then multiply by the full flight length.
explain: Daily rate = $30,000 / 12 days = $2,500 per day. Projected end spend = $2,500 x 30 days = $75,000. That is $15,000 (about 17 percent) under the $90,000 budget, so the campaign is under-delivering and needs spend accelerated.
:::

# Reading the flag and deciding the fix

The index and the projection answer different questions, so practitioners use both. The pacing index is the snapshot: where am I right now versus where I should be. The projection is the forecast: if nothing changes, where do I finish. A campaign can have an index near 1.0 today and still be drifting, which is why the daily check looks at the trend, not just one number.

When the flag fires, the fix depends on the direction and the constraint. Under-pacing on the buy side usually means the bid is too low or targeting is too tight, so you raise bids, broaden audiences, or open more inventory. Over-pacing means you will go dark early, so you lower bids, add daily caps, or narrow delivery. On the sell side, under-delivery against a guaranteed IO forces a choice near the end: accelerate to ASAP to hit the number, or accept the shortfall and owe a make-good. The numbers that drive all of this must reconcile at the end, which is why ops watches pacing daily rather than discovering a 25 percent shortfall in the wrap report.

:::predict
prompt: A campaign has spent 70% of its budget at the point when 50% of the flight has elapsed. What is its pacing index, and is it over or under pacing?
answer: 1.4
tolerance: 0.02
hint: Divide the share of budget spent by the share of flight elapsed, then compare to 1.0.
explain: Pacing index = (70% / 100%) / (50% / 100%) = 0.70 / 0.50 = 1.4. An index of 1.4 is well above 1.0, so the campaign is over-pacing and will exhaust its budget and go dark before the flight ends unless spend is throttled.
:::

:::callout warning
A pacing index of 1.0 today does not guarantee a clean finish. Check the trend across days and the end-of-flight projection together, because a campaign drifting from 1.05 to 1.15 over a week is heading for early burnout even though no single day looks alarming.
:::

# Closing the books: reconciliation and the wrap

A flight ending is not the campaign ending. Billing and reconciliation match three numbers that rarely agree perfectly: what the IO promised, what the ad server says delivered, and what the counterparty's report says delivered. Counting points differ (a publisher counts at ad request, an advertiser at render), time zones differ, and processing lags differ, so a gap of under roughly 10 percent is treated as normal noise. Larger gaps get investigated. Whose number bills is set in the IO, and when delivery falls short of a contracted threshold the remedy is a credit or a make-good (bonus impressions to cover the shortfall) rather than a silent write-off. Best practice is to wait 24 to 48 hours after the flight before reconciling, because late-arriving data closes much of the apparent gap on its own.

The last step is the wrap report, or post-campaign analysis (PCA). It states results against the goal on the IO, explains what drove them, and recommends what to change next time. A good PCA is a narrative, not just a number dump: it turns a finished campaign into the starting point for the next plan, which is where the lifecycle loops back to planning and sales.

:::predict
prompt: A publisher's ad server reports 5,200,000 impressions delivered. The advertiser's ad server reports 5,000,000 for the same flight. What is the discrepancy, measured against the publisher's count?
answer: 3.85
tolerance: 0.15
unit: %
hint: Subtract the two counts, then divide by the publisher's number.
explain: (5,200,000 - 5,000,000) / 5,200,000 = 200,000 / 5,200,000 = 0.0385, about 3.85 percent. That is comfortably inside the roughly 10 percent treated as normal counting-point noise, so it bills without a dispute.
:::

:::sources
- IAB and 4As, Standard Terms and Conditions for Internet Advertising v3.0 | https://www.iab.com/wp-content/uploads/2015/06/IAB_4As-tsandcs-FINAL.pdf
- Improvado, Insertion Order (IO): The Ultimate Guide for Advertisers | https://improvado.io/blog/what-is-an-insertion-order
- Google Ad Manager Help, How line item delivery is paced | https://support.google.com/admanager/answer/2669484?hl=en
- Amobee, Budget Pacing Best Practices | https://www.amobee.com/guides/budget-pacing-best-practices/
- Pathlabs, Understanding Pacing in Digital Advertising and Optimizing Results | https://www.pathlabs.com/blog/what-is-pacing-in-advertising
- smartclip, Pacing | Adtech Glossary | https://smartclip.tv/adtech-glossary/pacing/
- Claravine, Digital and Media Ad Trafficking Overview | https://www.claravine.com/digital-ad-trafficking-overview/
- Permutive, Post Campaign Analysis | https://support.permutive.com/hc/en-us/articles/360014275520-Post-Campaign-Analysis
:::
