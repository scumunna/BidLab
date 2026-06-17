---
track: vertical-b2b
title: B2B and SaaS Programmatic Certification
pass: 0.7
draw: 12
---
:::q Landscape & Mandate
question: A new hire asks why your LinkedIn account-targeted CPMs run near $80 when the open web sits around $5. What is the correct buy-side explanation?
- LinkedIn pixels are technically larger files, so the inventory costs more to serve
- B2B CTRs are higher, so platforms charge more per impression
- Open-web CPMs are artificially low because of fraud, while LinkedIn is fraud-free
- You are filtering a thin pool down to specific companies and roles and competing for scarce, brand-safe inventory, and a $15K to $250K deal makes the premium pay back
answer: 3
explain: B2B CPMs are high because you narrow a small pool to named accounts and roles and compete for scarce premium inventory, and the large deal value behind one closed-won account is what lets a $50 to $100 CPM still clear the unit-economics bar.
:::

:::q Landscape & Mandate
question: A VP of Demand Gen says "our CTR is up 40 percent but the board is asking why pipeline is flat." What is the trader actually being measured on?
- Click-through rate and cost per click
- Viewable CPM and impression volume
- LTV:CAC and CAC payback (pipeline efficiency)
- Creative engagement rate on LinkedIn document ads
answer: 2
explain: B2B media is scored on the efficiency of acquired revenue, LTV:CAC and CAC payback, not CTR or CPM. A rising CTR with flat pipeline means the clicks are not becoming qualified accounts, so the trader must optimize to account quality.
:::

:::q Landscape & Mandate
question: A trader funds a buy with $50,000 of media, $8,000 of data fees, $5,000 of DSP fees, and $7,000 of agency fees. What is the working media percentage, and what does it tell you?
- 71.4 percent, meaning nearly 29 cents of every dollar went to fees before an impression rendered
- 86.2 percent, meaning fees are negligible on this buy
- 62.5 percent, meaning the data layer alone consumed most of the budget
- 50.0 percent, meaning exactly half the budget reached inventory
answer: 0
explain: Working media is media divided by all four line items: 50,000 / 70,000 = 0.714, or 71.4 percent. Roughly 29 percent of the budget went to data, DSP, and agency fees, which is why B2B traders watch this number closely.
:::

:::q Landscape & Mandate
question: An enterprise SaaS deal carries an LTV of $90,000 and a CAC of $30,000. Does it clear the 3:1 minimum, and what should the trader conclude?
- It fails the 3:1 bar at 2.5:1 and the account should be excluded
- It lands exactly at 3.0:1, passing the floor but with no cushion, so any rise in CAC or churn pushes it underwater
- It clears comfortably at 4.5:1, the enterprise benchmark
- The ratio cannot be computed without the gross margin
answer: 1
explain: 90,000 / 30,000 = 3.0, exactly the 3:1 minimum, so it passes the floor with no margin for error. This is why enterprise programs target the roughly 4.5:1 segment benchmark rather than the bare minimum.
:::

:::q Audience, Identity & Signal Loss
question: You onboard 20,000 contacts at a 55 percent contact match rate, then must suppress 1,500 existing customers and 600 opt-outs before activation. What is the deliverable contact audience?
- 11,000 contacts
- 17,900 contacts
- 10,100 contacts
- 8,900 contacts
answer: 3
explain: Apply the match rate first: 20,000 x 0.55 = 11,000 matched. Then subtract suppression: 11,000 - 1,500 - 600 = 8,900 deliverable contacts. Suppression runs on the matched pool and must run before flight so you never pay to retarget people you are barred from contacting.
:::

:::q Audience, Identity & Signal Loss
question: A target-account list comes back with a strong 85 percent account match but only a 32 percent contact match. What is the most likely cause and fix?
- The DSP is broken; retry the upload
- The accounts are too large to match individually; split them into smaller segments
- The intent layer ran before the match; reorder the workflow
- The list is heavy on personal Gmail and Yahoo addresses; source work emails and match at the domain level
answer: 3
explain: A high account match with a low contact match is the classic signature of a personal-email-heavy list. The companies resolve but the personal addresses do not, so the fix is to onboard work emails and match at the domain level, not to retry the upload.
:::

:::q Audience, Identity & Signal Loss
question: Your account match rates are quietly eroding month over month even though nobody changed the targeting. What is the cause, and the durable fix?
- The DSP raised its floor price; renegotiate the deal
- Third-party cookies and MAIDs are decaying out of the bidstream; migrate the audience to deterministic IDs like UID2 and RampID keyed off the same work emails
- The suppression list grew too large; stop suppressing competitors
- Creative fatigue lowered delivery; rotate the ads more often
answer: 1
explain: As cookies and MAIDs churn, the same onboarded list maps to fewer live identifiers each month, so the audience shrinks and the campaign underpaces. UID2 and RampID are deterministic, built from the work email you already upload, so they persist as cookies deprecate.
:::

:::q Audience, Identity & Signal Loss
question: A purchased prospecting list comes back matching at a respectable 65 percent in the DSP. Under 2026 rules, is it safe to activate, and what must the trader check first?
- Yes, a 65 percent match clears the delivery threshold, so activate immediately
- Yes, because B2B work-contact data is exempt from GDPR and CAN-SPAM
- No, "it matched" is not "it is legal"; the trader must confirm a lawful basis and cross-reference suppression for opt-outs, customers, and competitors before flight
- No, but only legal owns that risk, so the trader can activate and let legal review afterward
answer: 2
explain: In 2026 B2B work-contact data is personal data under GDPR and CAN-SPAM, so a technically deliverable list with no consent basis is a compliance exposure. The trader must verify a lawful basis and run the suppression cross-reference before activation, not after.
:::

:::q Pacing & Budget
question: A $126,000 flight is set to run across the full 84-day median B2B cycle, paced evenly. What is the daily pacing budget, and why pace this way?
- $4,200 per day, pacing to a 30-day month to read ROAS faster
- $1,500 per day, but front-loaded so the impression goal is hit early
- $2,100 per day, pacing to a 60-day window
- $1,500 per day, pacing to the 84-day cycle so delivery stays alive while the committee forms and the deal clears legal and procurement
answer: 3
explain: 126,000 / 84 = $1,500 per day. Pacing evenly across the cycle (not a calendar month) keeps the account warm while the buying committee deliberates and the deal works through legal and procurement, the number-one delay.
:::

:::q Pacing & Budget
question: You target 300 accounts and expect to reach 8 stakeholders in each at a target frequency of 5 impressions per stakeholder. What is the required monthly impression reach, and why size it this way?
- 1,500 impressions, because you pace to accounts, not people
- 12,000 impressions, sizing on stakeholders per account so the whole committee is covered rather than single-threading the champion
- 2,400 impressions, covering each stakeholder once
- 1,920 impressions, sizing on accounts times frequency
answer: 1
explain: 300 accounts x 8 stakeholders = 2,400 people, x 5 frequency = 12,000 impressions. Sizing on stakeholders per account (not 300 x 5 = 1,500) is what reaches the full buying committee instead of single-threading one contact.
:::

:::q Pacing & Budget
question: A more complex deal pushes the committee from a typical 8 to 11 stakeholders per account, while accounts (300) and target frequency (5) hold fixed. How many MORE impressions per month does the larger committee require?
- 16,500 more impressions
- 1,500 more impressions
- 4,500 more impressions
- 3,000 more impressions
answer: 2
explain: At 11 stakeholders: 300 x 11 x 5 = 16,500. At 8 it was 12,000. The difference is 16,500 - 12,000 = 4,500 additional impressions, the cost of covering a bigger committee on the same account list.
:::

:::q Pacing & Budget
question: An in-flight enterprise deal's close date is about to cross the buyer's fiscal year-end. What is the correct pacing response?
- Re-plan flight length and keep always-on delivery across the procurement reset, tracking the spend as budget-at-risk rather than dead
- Pause the flight, since a deal that has not closed by year-end is clearly stalled
- Front-load the remaining budget to force a close before year-end
- Cut the account from the target list to protect the monthly ROAS number
answer: 0
explain: Crossing fiscal year-end can restart procurement and budget approval, so progress is not linear to close. The trader re-plans flight length and sustains always-on delivery across the reset, treating the spend as budget-at-risk, rather than killing a deal that is waiting on a new budget cycle.
:::

:::q Inventory & Bidding
question: Your DSP logs 1,200,000 impressions and the SSP logs 1,104,000 for the same line item. What is the impression discrepancy, and is it actionable?
- 9.6 percent, well beyond the normal band, so escalate as fraud
- 8.7 percent, exactly at the escalation threshold, so pause the line
- 12.0 percent, above the threshold, so move the budget to open exchange
- 8.0 percent, inside the roughly 10 percent normal band, so log it as routine variance and do not escalate
answer: 3
explain: (1,200,000 - 1,104,000) / 1,200,000 = 0.08, an 8 percent discrepancy. That sits inside the roughly 10 percent normal band driven by counting points, latency, and filtering, so it is routine variance to log rather than escalate.
:::

:::q Inventory & Bidding
question: You spend $100,000, and 15 percent goes to MFA while another 5 percent is invalid traffic, with no discrepancy loss. What is your working media, and by how much does the waste inflate your effective cost per working dollar?
- $80,000 working, and the waste inflates effective cost by 25 percent ($20,000 wasted over $80,000 working)
- $80,000 working, and the waste inflates effective cost by 20 percent ($20,000 over $100,000)
- $85,000 working, and the waste inflates effective cost by 15 percent
- $95,000 working, and the inflation is negligible
answer: 0
explain: Working media is 100,000 x (1 - 0.20) = $80,000. The inflation is computed against the working spend, not the gross: 20,000 / 80,000 = 0.25, a 25 percent inflation, so a CAC built on gross spend is understated by 25 percent.
:::

:::q Inventory & Bidding
question: An enterprise tier carries an allowable CAC of $30,000 and the campaign wins 0.0008 closed-won deals per 1,000 impressions. What is the max CPM, and why does the ceiling have to be tiered by ACV?
- $24, and because allowable CAC scales with ACV, a $4,000 SMB tier at the same win rate tops out near a $3.20 CPM, so one global cap would misprice both
- $24, but a single global cap is fine because the win rate is constant
- $3.20, because the win rate dominates the ceiling
- $240, because you multiply by impressions, not per thousand
answer: 0
explain: Max CPM = allowable CAC x closed-won per 1,000 = 30,000 x 0.0008 = $24. With the win rate held equal, the ceiling scales only with allowable CAC, so a $4,000 SMB tier sustains just $3.20. A single cap would overpay for SMB and starve enterprise reach.
:::

:::q Inventory & Bidding
question: A trader raised the max CPM after marketing modeled LTV at 5x ACV, won far more auctions, and the campaign overspent on accounts that never closed. What went wrong?
- The ceiling was inflated off an optimistic, unrealized LTV instead of a conservative realized one, which inflated the allowable CAC and the max CPM
- The win rate was set too high in the bid algorithm
- LinkedIn CPMs fell, so the ceiling should have dropped automatically
- The CPC target was set too low, starving the campaign of clicks
answer: 0
explain: Allowable CAC is LTV divided by the target ratio, so an inflated 5x LTV inflates the allowable CAC and therefore the max CPM, letting the trader win expensive auctions on accounts whose realized value never justified the bid. Ceilings must use conservative, realized LTV.
:::

:::q Creative, Formats & Offer
question: A trader needs cheap, high-engagement top-of-funnel education on LinkedIn for cold accounts. Which format and why?
- Single-image Sponsored Content at roughly $13 CPC, for maximum reach
- A conversation ad pushing a demo to cold accounts, to drive intent fast
- A thought-leader ad at roughly $2 to $3 CPC and a ~2.68 percent CTR, the cheapest high-engagement education lever
- A contact-sales lead-gen form on cold prospecting, to capture intent early
answer: 2
explain: Thought-leader ads run about $2 to $3 CPC at a ~2.68 percent CTR, far cheaper than the ~$13 single-image unit, making them the right top-of-funnel education lever. Conversation-ad demos and contact-sales forms belong on warm, high-intent audiences, not cold prospecting.
:::

:::q Creative, Formats & Offer
question: A gated campaign spends $9,000 for 200 leads that convert to SQL at 10 percent. A demo campaign spends $9,000 for 80 leads that convert to SQL at 40 percent. Which offer is cheaper per SQL, and by how much?
- The gated offer, at $281 per SQL versus $450 for demo
- The demo offer, at about $281 per SQL versus $450 for gated, because its lead-to-SQL rate is 4x even though its raw CPL is higher
- They are equal, since both spent $9,000
- The gated offer, because it produced more raw leads
answer: 1
explain: Gated: 200 x 0.10 = 20 SQLs, so $9,000 / 20 = $450 per SQL. Demo: 80 x 0.40 = 32 SQLs, so $9,000 / 32 = about $281 per SQL. Compared on cost per quality lead, the demo wins despite a higher CPL because its downstream conversion is 4x.
:::

:::q Creative, Formats & Offer
question: A personalized ABM landing page converts at 34 percent and the generic page at 11 percent. What is the message-match lift, and why is this the cheapest lever in the plan?
- About 2.3x, and it is cheap because it requires more media spend
- About 3.1x, and it costs no media because the same impressions, bid, and offer convert multiples better when the page continues the ad's message
- About 0.32x, and it only matters on LinkedIn
- About 23x, and it replaces the need for targeting
answer: 1
explain: 34 / 11 = about 3.1x. The lift comes from message continuity, not added media, so the same impressions and bid convert far better when the landing page delivers the same account, pain, and offer the ad promised.
:::

:::q Creative, Formats & Offer
question: A LinkedIn line runs at a $60 CPM. Fresh creative delivers a 0.50 percent CTR, but after three weeks of fatigue the CTR decays to 0.40 percent. By what percent does the effective CPC rise with the bid unchanged?
- 10 percent
- 20 percent
- 25 percent
- 0 percent, because the bid did not change
answer: 2
explain: Effective CPC is (CPM / 1000) / CTR. Fresh: 0.06 / 0.005 = $12.00. Fatigued: 0.06 / 0.004 = $15.00. The rise is (15 - 12) / 12 = 0.25, a 25 percent increase from fatigue alone, which is why LinkedIn creative is rotated every 2 to 3 weeks.
:::

:::q Measurement & Synthesis
question: 1,000 leads convert at 40 percent to MQL, then 20 percent MQL-to-SQL, 45 percent SQL-to-opp, and 35 percent opp-to-won. How many closed-won deals result, and what is the lesson?
- About 12.6 deals, showing that the multiplicative decay collapses a large lead count into few deals, so volume alone cannot be judged
- About 80 deals, because the MQL stage dominates
- About 126 deals, reading the rates as additive
- About 36 deals, stopping at the opportunity stage
answer: 0
explain: 1,000 x 0.40 x 0.20 x 0.45 x 0.35 = about 12.6 closed-won. The chain compounds, so flooding the top with low-intent leads grows the headline number while the closed-won count barely moves, which is why a trader reads the chain, not the lead count.
:::

:::q Measurement & Synthesis
question: A campaign's 30-day ROAS reads 0.6x while its 180-day ROAS reads 6.0x on the same spend. Why the gap, and what window must the trader use?
- The media degraded over time; use the 30-day read to react fast
- The platform recalculated conversions; trust the 30-day number
- Open-exchange CPMs fell over time, lifting ROAS automatically
- The deals that close between day 30 and day 180 are invisible at the early read, so the window must be at least the median sales cycle (here 180 days), understating the truth by 10x at 30 days
answer: 3
explain: 6.0 / 0.6 = 10x understatement. On an 84-day-plus motion most deals close well after 30 days, so a short window systematically reads like a loss. The evaluation window must be greater than or equal to the median cycle.
:::

:::q Measurement & Synthesis
question: A trader wants to prove a LinkedIn ABM flight was incremental, not just correlated with deals that would have closed anyway. Which single step establishes causation?
- Show that exposed accounts converted above the overall average
- Report the platform-attributed conversions from the LinkedIn dashboard
- Run a matched account holdout for 60 to 90 days and compare exposed versus held-out conversion
- Extend the attribution window to 180 days
answer: 2
explain: Only a holdout with a matched control group proves the spend caused the lift rather than capturing existing demand. A higher-than-average rate is correlation, platform conversions over-claim, and a longer window improves the read but still cannot separate caused from captured demand.
:::

:::q Measurement & Synthesis
question: LinkedIn reports 150 conversions for the flight, but the CRM shows only 90 became real opportunities. By what percent does the platform over-claim, and how should the trader report?
- 40 percent over-claim; report the 150 platform number since it is the system of record
- 66.7 percent over-claim; treat CRM opps as the only scoreboard and reconcile platform numbers down to them
- 60 percent over-claim; average the two figures for the readout
- 0 percent; the platform and CRM should always match exactly
answer: 1
explain: (150 - 90) / 90 = 0.667, about 66.7 percent over-claim. Platforms double-count across the LinkedIn and open-DSP split and count form-fills that never became opps, so the CRM opp count is the source of truth and platform numbers are reconciled down to it.
:::
