---
id: vertical-auto-03
track: vertical-auto
module: 3
title: The Conversion and the Funnel, VDP Views, Leads, and the Titled Sale
summary: Map the auto funnel from impression to titled sale, pick the right intermediate conversion to optimize per campaign, and tie it back to net cost per sale after co-op.
---
# The funnel you are actually trading against

Auto is a long, multi-stage funnel, and your first job as a trader is to know which stage each campaign is paid to move. The shape runs impression to SRP (Search Results Page) to VDP view (Vehicle Detail Page) to lead (form or phone) to appointment-set to show to titled sale (the VIN). Each step sheds volume, so the number of impressions that becomes a sale is tiny, and that single fact reshapes how you optimize: you steer to a dense mid-funnel signal you can see in-platform, not to the sparse sale buried in the dealer's DMS/CRM. Auto is a long-consideration purchase, with buyers spending an average of nearly 14 hours researching online across many sessions before they ever contact a dealer, so this funnel is not a same-session click-to-buy, it is a weeks-long consideration arc you have to stay present across.

:::callout key
The VDP view is the workhorse conversion in auto. It is high-volume, fires in-platform, and correlates with real shopping intent, so a Tier 3 trader optimizes display, PMax, and prospecting to VDP while reserving lead and sale optimization for the bottom of the funnel.
:::

:::quiz
question: Given the impression-to-VIN funnel sheds volume at every step over a weeks-long consideration arc, what should a Tier 3 trader optimize prospecting campaigns toward?
- The titled sale logged in the DMS/CRM, since that is the KPI you are graded on
- Same-session clicks, since auto buyers click a display ad and buy that day
- A dense mid-funnel signal like the VDP view that fires in-platform
- Raw impressions, since reach is all that matters at the top of the funnel
answer: 2
hint: The sale is sparse and lagged in the dealer's system, so a bidder cannot train on it.
explain: Because so few impressions ever become a titled sale and that sale sits lagged in the DMS/CRM, you steer the bidder to a dense, in-platform signal it can actually learn from. The VDP view is that workhorse mid-funnel proxy, while the sale stays the bottom-funnel KPI you reconcile later via VIN matchback.
:::

# VDP view, the conversion you optimize to

A VDP view is the moment a shopper lands on a specific vehicle's detail page, the single best mid-funnel proxy for intent that you control. You optimize to it because leads and sales are too sparse and too lagged to train a bidder on, and because the cost-per-VDP ceiling is a clean daily health check: aim for under roughly $2.50 used and under roughly $3.50 new. When cost-per-VDP drifts above that ceiling you have an early warning days before the sale data would ever show it. The math is the plain ratio of spend to qualified, on-domain VDP views.

$$ \text{CVV} = \frac{\text{media spend}}{\text{VDP views}} $$

:::predict
prompt: You spend $5,000 and drive 2,000 qualified VDP views. What is your cost per VDP view, and are you inside the ~$2.50 used ceiling?
answer: 2.5
tolerance: 0.05
unit: USD
hint: Divide spend by VDP views.
explain: $5,000 / 2,000 = $2.50 per VDP view, which sits right at the ~$2.50 used ceiling. One dollar more of spend or one fewer view and you breach it, so this is the line you watch daily before any sale data exists.
:::

:::figure funnel
caption: The auto funnel sheds volume at every step, impression to SRP to VDP view to lead to appointment to show to titled sale. VDP view is the dense, in-platform signal a trader optimizes to, while the sale sits sparse and lagged at the bottom in the DMS.
:::

# The drop-off is brutal, so close rate is mostly the store's

A representative new-vehicle internet funnel runs about 63% contact, then about 42% appointment-set of those contacted, then about 58% show, then about 41% close. Multiply those four and you get the lead-to-sale close rate, which compounds to roughly 5 to 6%, while phone leads close closer to 10%. The structural takeaway: most of the leakage lives in stages the dealer's BDC and sales floor control, not in your media, so a trader who cannot name where the drop happens absorbs blame for a store-side bottleneck.

$$ \text{close rate} = 0.63 \times 0.42 \times 0.58 \times 0.41 \approx 0.063 $$

:::predict
prompt: Take 100 contacted leads. 42% set an appointment and 58% of those show. How many show up?
answer: 24
tolerance: 0.5
unit: shows
hint: Apply 42% first, then 58% of that result.
explain: 100 x 0.42 = 42 appointments set, then 42 x 0.58 = 24.36, which rounds to 24 shows. Two compounding store-side steps already cut the contacted pool to roughly a quarter before close rate even applies.
:::

:::quiz
question: A campaign sends 1,000 internet leads. Using a 6% lead-to-sale close rate, about how many titled sales should you expect?
- About 6 sales
- About 24 sales
- About 60 sales
- About 240 sales
answer: 2
hint: Multiply leads by the close rate.
explain: 1,000 x 0.06 = 60 titled sales. Knowing this expected yield lets you sanity-check whether a soft month is a media problem or just normal funnel variance on a small sale count.
:::

# Expected sales, and why you forecast from leads not hope

Once you trust the close rate, expected sales is just leads times that rate, and that single multiplication is how you set expectations with a dealer principal before the month closes. It also tells you which lever to pull: if leads are healthy but sales lag, the leak is downstream in the store, not upstream in your buy. This is the difference between a trader who reports activity and one who forecasts outcomes.

$$ \text{expected sales} = \text{internet leads} \times \text{close rate} $$

:::predict
prompt: You expect to deliver 1,500 internet leads next month at a 6% close rate. How many titled sales should you forecast?
answer: 90
tolerance: 1
unit: sales
hint: Multiply leads by 0.06.
explain: 1,500 x 0.06 = 90 forecast sales. If the store actually titles far fewer, you point to the contact, appointment, show, and close stages rather than to the media, because the lead volume did its job.
:::

:::widget barChart
title: Auto internet funnel, units remaining per 100 leads
labels: Leads, Contacted, Appt-Set, Showed, Sold
data: 100, 63, 26, 15, 6
unit: per 100 leads
:::

# Speed-to-lead, the lever that beats any bid

The single biggest swing in close rate is not your bid, it is how fast the BDC responds. Cox Automotive data puts a 5-minute first response around a 25 to 32% close versus only 3 to 5% after an hour, the difference between closing one lead in four and one in twenty, and dealerships that respond within 15 minutes close roughly 50% more leads than slow ones. Only about 51% of dealers deliver a "perfect" multichannel first response inside 15 minutes (Pied Piper PSI 2026, across 3,290 dealership websites), so nearly half of all rooftops still bleed this real and common leak. Speed-to-lead is the gap between the lead timestamp and the first CRM activity, and it belongs on your report precisely because it proves a sales drought can be a store problem, not a media one.

$$ \text{speed-to-lead} = t_{\text{first CRM activity}} - t_{\text{lead created}} $$

:::predict
prompt: You deliver 1,000 leads. At a fast response they close near 25%; after an hour they close near 5%. How many more sales does fast response produce?
answer: 200
tolerance: 1
unit: sales
hint: Compute sales at each rate, then subtract.
explain: 1,000 x 0.25 = 250 sales fast, versus 1,000 x 0.05 = 50 sales slow, a difference of 200 sales on the exact same media. The BDC clock, not your bid, is the dominant lever here.
:::

:::callout warning
A recurring DealerRefresh complaint: internet leads sit unworked in the CRM long past the competitive window, with third-party leads the worst offenders, torching the close rate before the media is ever evaluated. The trader gets blamed for flat sales when the real leak is appointment-to-show and speed-to-lead, both store-controlled. Always separate the media-stage drop-offs from the store-stage ones on your report so the fix routes to the right owner.
:::

# From the funnel to net cost per sale

Everything above ladders up to the only number the dealer principal truly grades you on, net cost per sale, which is media spend net of co-op reimbursement divided by VIN-matched units sold. The funnel is why you do not optimize to that number directly: a single rooftop titles tens of cars a month, so the sale signal is statistically noisy, and you defend it with the dense VDP and lead proxies above. OEM co-op typically reimburses 50% of standard digital (up to 75% for approved-vendor programs, and some programs reach 100% of qualifying spend), so the net figure can be roughly half of gross, which is why you always state whether a cost-per-sale is gross or net.

$$ \text{Net CPS} = \frac{\text{media spend} - \text{co-op reimbursement}}{\text{VIN-matched units sold}} $$

:::predict
prompt: You spend $12,000, co-op reimburses 50%, and VIN matchback credits 24 titled sales. What is your net cost per sale?
answer: 250
tolerance: 1
unit: USD
hint: Net out the co-op first, then divide by VIN-matched sales.
explain: Co-op covers 50% of $12,000, so net spend is $6,000. Then $6,000 / 24 = $250 net cost per sale. Quoting the gross $12,000 / 24 = $500 instead would double the apparent cost and misrepresent the buy.
:::

:::quiz
question: Why does a Tier 3 trader optimize campaigns to VDP views instead of directly to titled sales?
- VDP views are worth more revenue than sales
- Sales are sparse and lagged, while VDP views are dense, in-platform, and correlate with intent
- Google does not allow optimizing to sales
- VDP views are the KPI the dealer principal grades you on
answer: 1
hint: Think about signal density and how fast each event is observable.
explain: A rooftop titles only tens of cars a month and the sale lands lagged in the DMS, so it is a poor optimization signal. VDP views are high-volume, fire in-platform within the session, and track intent, so they train a bidder well and feed up to the net-cost-per-sale KPI the principal actually cares about.
:::

# Filtering the funnel, where the counts lie

The funnel only works if each stage counts clean events, and two stages lie by default. VDP views inflate when bots or third-party syndication hit the page, so you filter to qualified, on-domain VDP traffic before you ever optimize to it. Leads lie too: phone and form leads close at very different rates (phone closer to 10%, form lower), so a single blended cost-per-lead hides which channel actually drives appointments. Optimize the wrong stage and you starve the consideration pool, a lead-heavy push can dry up the VDP-rich upper funnel that feeds next month's sales.

:::quiz
question: Your blended cost-per-lead looks great, but sales are flat. Which funnel hygiene issue is the most likely culprit to check first?
- VDP views were under-counted
- The blend hides that cheap form leads dominate while higher-closing phone leads are scarce
- The attribution window is too long
- Co-op reimbursement was denied
answer: 1
hint: A blended average can mask a bad channel mix.
explain: Phone and form leads close at very different rates, so a flattering blended CPL can be carried by cheap, low-closing form leads while the higher-intent phone leads stay scarce. Splitting CPL by lead type exposes the real driver of appointments and sales, before you touch windows or co-op.
:::

:::sources
- Demand Local, 37 Lead-to-Sale Conversion Statistics for Car Dealerships | https://www.demandlocal.com/blog/lead-to-sale-conversion-statistics/
- Demand Local, 24 Speed-to-Lead Impact Statistics on Auto Sales | https://www.demandlocal.com/blog/speed-to-lead-impact-statistics/
- ReWork, Lead Response Time Optimization: Why the First 5 Minutes Determine Your Close Rate (Cox Automotive data) | https://resources.rework.com/libraries/automotive-sales-growth/lead-response-time-optimization
- AI Journal, Infiniti Dealers Rank Highest in 2026 Web Lead Response Study (Pied Piper PSI Internet Lead Effectiveness, 51% perfect response within 15 minutes) | https://aijourn.com/infiniti-dealers-rank-highest-in-2026-web-lead-response-study-ai-and-automation-drive-industry-improvement/
- Foundry CRO, Automotive Marketing Benchmarks 2026: CPC to Cost per Sale | https://foundrycro.com/blog/automotive-marketing-benchmarks-2026/
- Demand Local, How to Ensure OEM Compliance in Your Automotive Marketing Campaigns | https://www.demandlocal.com/blog/oem-compliance-automotive-marketing-campaigns/
- DealershipGuy, Dealer Ad Spend Nears $10 Billion as Digital Marketing Dominates (NADA 2025 data) | https://news.dealershipguy.com/p/dealer-ad-spend-nears-10-billion-as-digital-marketing-dominates
- DataFeedWatch, 6 Common Vehicle Ads Errors and How to Fix Them in Merchant Center | https://www.datafeedwatch.com/blog/google-vehicle-ads-errors
:::
