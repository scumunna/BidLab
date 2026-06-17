---
id: vertical-auto-09
track: vertical-auto
module: 9
title: Co-op Compliance QA, passing OEM brand rules to protect reimbursement
summary: Learn to QA every creative, disclaimer, and claim package against OEM co-op rules so reimbursement clears the first time and your net cost per sale stays halved instead of doubled.
---
# Why co-op compliance is a media-math problem, not just legal busywork

The signature KPI you are graded on in Auto is net cost per sale: media spend net of co-op reimbursement divided by VIN-matched units. The "net of co-op" half of that fraction is the thing this lesson protects. OEMs reimburse roughly 50% of standard digital spend, up to 75% for approved-vendor programs and as high as 100% on some launch initiatives, but only if every asset passes brand rules and every claim package files on time. A failed QA does not just lose paperwork, it silently doubles the dealer's effective cost per sale because the spend already happened and the reimbursement never arrives.

That makes compliance QA a trader's job, not a side task you hand to legal. You sit between the OEM's brand standards and the dealer principal who budgeted a net number, so a denied claim lands on your report as if your media underperformed. The whole point is that a $600 gross cost per sale should report as $300 net, and a single missing disclaimer turns that $300 back into $600.

:::predict
prompt: Gross cost per sale is $600 and a compliant claim earns 50% co-op reimbursement. What is the net cost per sale?
answer: 300
tolerance: 1
unit: USD
hint: A 50% reimbursement means the dealer keeps half the spend per sale.
explain: Net cost per sale is gross times the unreimbursed share. With a 50% approved claim, $600 \times (1 - 0.50) = $600 \times 0.50 = $300. The reimbursement covers the other $300 per sale, which is exactly the money a denial would forfeit.
:::

# The compliance multiplier: how a denial doubles your KPI

Write the relationship as a multiplier on gross cost per sale. When a claim is approved you pay the unreimbursed share, $1 - r$, where $r$ is the reimbursement rate. When a claim is denied you pay the full gross, which is the same formula with $r = 0$. There is no partial-credit middle ground on a voided claim, so the swing is the entire reimbursement.

$$ \text{Net CPS} = \text{Gross CPS} \times (1 - r_{\text{approved}}) \quad\text{else}\quad \text{Gross CPS} \times 1 $$

This is why the trader treats a denial as a doubling event at 50% co-op, not a 10% rounding error. At a 75% approved-vendor rate the stakes are even higher: a clean claim cuts cost per sale to a quarter, and a denial restores it to the full gross, a 4x swing in the reported number. The math rewards getting it right the first time far more than any bid optimization can.

:::predict
prompt: At a 75% approved-vendor co-op rate, a $800 gross cost per sale clears compliance. What is the net cost per sale?
answer: 200
tolerance: 1
unit: USD
hint: A 75% reimbursement leaves the dealer paying one quarter of gross.
explain: $800 \times (1 - 0.75) = $800 \times 0.25 = $200. If that same claim were denied, the dealer would pay the full $800, a 4x jump from the $200 they budgeted, which shows why a higher reimbursement rate raises the cost of a QA miss.
:::

:::widget barChart
title: Net cost per sale by co-op outcome (gross $600)
labels: Gross CPS, Net at 50% co-op, Net at 75% co-op, Net if claim denied
data: 600, 300, 150, 600
unit: USD
:::

# The cascade from gross spend to net cost per sale

Picture the dollars flowing down a cascade: gross media spend enters at the top, the approved reimbursement is subtracted in the middle, and what remains is divided by VIN-matched units to land on net cost per sale at the bottom. Compliance QA is the gate in the middle of that cascade. If the gate is open, half or three quarters of the spend flows back; if a disclaimer is missing the gate slams shut and the full gross drops through to the dealer.

:::figure costPerFundedCascade
caption: Gross media spend flows down, the approved co-op reimbursement is subtracted at the compliance gate, and the remainder divided by VIN-matched units is the net cost per sale. A denied claim shuts the gate, so the full gross reaches the bottom.
:::

The trader's deliverable is the bottom of this cascade, defensible to the dealer principal. That means you must be able to show not just the net number but the recovery rate behind it, because a partially approved claim (some assets pass, some get kicked) lands somewhere between full reimbursement and zero.

:::predict
prompt: You submit $20,000 in eligible spend and the OEM approves $15,000. What is the co-op recovery rate?
answer: 75
tolerance: 0.5
unit: %
hint: Recovery rate is approved dollars divided by eligible dollars submitted.
explain: $15{,}000 / $20{,}000 = 0.75, a 75% recovery rate. The $5,000 gap is spend that ran but failed a QA check or a deadline, so it converts to unreimbursed cost that pushes net cost per sale up.
:::

# What you actually QA: the asset checklist

Before anything runs, you check every creative, disclaimer, logo lockup, and landing page against the OEM's standards. The recurring buckets are approved logos, colors, typography, and imagery; mandatory legal disclaimers and financing disclosures; no competitor mentions; and correct tier alignment, meaning Tier 3 rooftop creative carries inventory plus price-and-payment messaging while Tier 2 co-op runs name-and-location only. Many OEMs require pre-launch submission and approval before a creative is even eligible to run as co-op, so the QA has to happen on your timeline, not after the flight.

The five denial drivers practitioners cite most are unapproved logos or creative, competitor mentions, missing or wrong disclaimers, non-approved vendors, and missed funding-cycle deadlines. Notice that two of those five, vendor approval and deadlines, have nothing to do with how the ad looks, so a visually perfect creative still bounces if your DSP or agency is not on the approved-vendor list or the claim files a day late.

:::quiz
question: Which of these is a compliance denial driver that a perfectly designed, on-brand creative can still fail on?
- The headline font is the approved typography
- The vendor running the campaign is not on the OEM approved list
- The logo lockup uses the correct OEM colors
- The financing disclaimer is present and current
answer: 1
hint: Two of the five denial drivers have nothing to do with how the ad looks.
explain: Vendor approval is independent of creative quality. An ad can pass every visual check and still be denied because the DSP or agency running it is not an approved vendor, just as it can be denied for missing a funding-cycle deadline. The other three options describe checks that already passed.
:::

# Filing the claim: documentation and deadlines

Passing creative QA is only half the workflow. The reimbursement claim package itself must include copies of the running ads, the invoices, and the required disclaimers and logos, all submitted before the funding-cycle deadline. Claim filing is as load-bearing as creative QA, because missing the deadline forfeits the money even when the creative was flawless. The trader's job is to build this into the cadence so the proof is captured while the campaign runs, not reconstructed in a panic at cycle close.

Track two numbers to manage this. Compliance pass rate is assets passing QA on first submission divided by total assets submitted, which tells you how clean your pre-launch process is. Co-op recovery rate is approved reimbursement divided by eligible spend, which tells you how much of the budgeted net you actually captured. A high pass rate with a low recovery rate usually means a deadline or documentation miss, not a creative problem.

:::predict
prompt: You submit 25 co-op assets for pre-approval and 20 pass on the first review. What is the first-submission compliance pass rate?
answer: 80
tolerance: 0.5
unit: %
hint: Pass rate is assets passing on first submission divided by total submitted.
explain: $20 / 25 = 0.80, an 80% first-pass rate. The 5 kicked-back assets need rework and resubmission before the deadline, and if any slips past the funding-cycle cutoff its spend becomes unreimbursed even after it is fixed.
:::

:::quiz
question: A dealer's creative is fully on-brand and approved, but the claim package is submitted two days after the funding-cycle deadline. What happens to the reimbursement?
- It is paid in full because the creative was compliant
- It is reduced by a small late penalty but mostly paid
- It is forfeited because the deadline was missed
- It rolls over automatically to the next funding cycle
answer: 2
hint: Deadlines are one of the five denial drivers, independent of creative quality.
explain: Missing the funding-cycle deadline forfeits the money even when the creative was perfectly compliant. Co-op funds expire in-period and do not roll over by default, so a late claim converts budgeted net spend into full unreimbursed cost, doubling the effective cost per sale at a 50% rate.
:::

# Edge cases, clawbacks, and the operator's real pain

The nastiest failures arrive after the spend is already booked as "net." A clawback can hit months later if an OEM audit finds a non-approved vendor or an unapproved asset, so a dealer who reported a clean net cost per sale gets billed the difference long after the flight ended. Reusing Tier 1 OEM-supplied creative at Tier 3 is a common trap: the polished national asset can still fail co-op if the dealer's required disclaimers or pricing messaging are not compliant for the local tier. And a single missing financing disclaimer can void an entire claim, turning a planned 50% reimbursement into 0% on spend that already ran.

:::predict
prompt: You ran $100,000 in gross media on 200 VIN-matched sales and reported net cost per sale assuming a 50% co-op reimbursement. A later audit voids the claim over a missing financing disclaimer, clawing the reimbursement to 0%. What is the corrected net cost per sale?
answer: 500
tolerance: 5
unit: USD
hint: With the reimbursement clawed back to 0%, the full gross spend is now your net spend, then divide by the same VIN-matched units.
explain: The reported number assumed 50% back, so net spend was $100{,}000 \times 0.50 = $50{,}000 and net cost per sale was $50{,}000 / 200 = $250. The clawback flips reimbursement to 0%, so the full $100{,}000 is now net spend and corrected net cost per sale is $100{,}000 / 200 = $500. One missing disclaimer doubled the KPI on spend that already ran, with no change to the media.
:::

:::callout warning
A recurring operator complaint on DealerRefresh: co-op claims get denied or clawed back over small disclaimer or logo violations, and the dealer eats spend they assumed was reimbursed. Practitioners also vent that every OEM has different rules, rates, and deadlines, so a vendor compliant for one brand fails another and claims bounce. The overhead is heavy enough that some dealers leave co-op money unclaimed rather than fight the process, which is the worst outcome of all because it forfeits the reimbursement by default.
:::

:::callout key
Co-op compliance is the cheapest "optimization" you have. No bid change, audience swap, or supply-path tweak can halve cost per sale the way a clean, on-time claim does, and none can double it the way a denial does. Build the checklist into the workflow and treat the funding-cycle deadline like a flight launch.
:::

# Diagnosing a net-cost-per-sale spike: media or money?

When net cost per sale jumps, the trader's skill is routing the cause to the right owner instead of just raising a bid. A spike from a denied or clawed-back co-op claim looks exactly like a media failure on the report, because the gross media number did not move at all, only the reimbursement vanished. The tell is that gross cost per sale is flat while net cost per sale rises by precisely the reimbursement share, which points at compliance, not at the auction.

Run the check as a quick decomposition. If gross CPS is stable and net CPS rose toward gross, the leak is money (a denied claim or missed deadline). If gross CPS itself climbed, the leak is media (drift, fatigue, a disapproved feed, a mispriced VIN soaking spend). Naming which lever broke, with the numbers to back it, is what separates a strong 0-to-100 hire from one who absorbs the blame.

:::predict
prompt: Last month a $600 gross cost per sale reported as $300 net at a 50% approved co-op rate. This month gross is still $600 but the claim was denied. What is this month's net cost per sale, and how many dollars per sale did the denial add?
answer: 600
tolerance: 1
unit: USD
hint: A denied claim means the unreimbursed share is the full gross, then compare to last month's net.
explain: With the claim denied, net cost per sale equals gross, $600 \times (1 - 0) = $600. Last month was $300 net, so the denial added $600 - $300 = $300 per sale. Gross never changed, which is the signal that this is a compliance failure, not a media one.
:::

:::sources
- Demand Local, How to Ensure OEM Compliance in Your Automotive Marketing Campaigns | https://www.demandlocal.com/blog/oem-compliance-automotive-marketing-campaigns/
- Dealer Spike, Maximizing Your OEM Co-Op Funds: A Comprehensive Guide for Dealerships | https://www.dealerspike.com/blog/maximizing-your-oem-co-op-funds-a-comprehensive-guide-for-dealerships/
- Foundry CRO, Automotive Marketing Benchmarks 2026: CPC to Cost per Sale | https://foundrycro.com/blog/automotive-marketing-benchmarks-2026/
- Demand Local, How AI is Revolutionizing Attribution in Automotive Marketing | https://www.demandlocal.com/blog/ai-revolutionizing-attribution-automotive-marketing/
- DealershipGuy, Dealer ad spend nears $10 billion as digital marketing dominates (NADA 2025 data) | https://news.dealershipguy.com/p/dealer-ad-spend-nears-10-billion-as-digital-marketing-dominates
- DataFeedWatch, 6 Common Vehicle Ads Errors and How to Fix Them in Merchant Center | https://www.datafeedwatch.com/blog/google-vehicle-ads-errors
:::
