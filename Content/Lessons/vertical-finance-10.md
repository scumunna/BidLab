---
id: vertical-finance-10
track: vertical-finance
module: 10
title: Seasonality, Dayparting and Defending the Budget, the Finance Trader in Full
summary: You will learn to time finance buys to the tax and open-enrollment calendar, set daypart bid multipliers and a pacing index, and defend cost per funded account in budget review as the synthesis of the whole role.
---
# Why finance demand has a calendar

Finance is not a flat-demand vertical. Two structural spikes dominate the year: tax season, roughly January through April and peaking near the mid-April filing deadline, lifts demand for tax-prep, refund-advance, debt-payoff, and lump-sum-to-invest products, while insurance open enrollment compounds Q4. The trader's problem is that auction prices rise with this demand and also with non-finance retail competition, so more spend at the peak does not automatically buy more funded accounts. The signature KPI does not change with the season: success is still cost per funded account (CPFA), media spend divided by accounts that opened and funded, measured against the LTV-derived ceiling from module 4.

Open enrollment is two distinct windows, not one, and a finance trader pacing insurance buys must respect both. Medicare Annual Enrollment runs October 15 to December 7, with coverage taking effect January 1. ACA Marketplace open enrollment is a separate, longer window that runs November 1 to January 15 for 2026 coverage: full-year coverage starting January 1 requires plan selection by December 15, and a final deadline of January 15 covers those who start coverage February 1. That means ACA funded intent does not stop in early December the way Medicare does, it carries a high-intent tail through the December 15 surge and on to the January 15 deadline. A trader who paces only to a December 7 cutoff would under-fund the exact ACA weeks that convert. Note that these January 15 and February 1 dates apply only to plan-year-2026 coverage. Beginning with plan year 2027 (the season that opens in fall 2026), CMS shortens the federal Marketplace open enrollment period to November 1 to December 15 and removes the January 15 deadline and February 1 effective date, so for PY2027 onward a trader should pace ACA buys to a December 15 close, not a January 15 tail. State-based exchanges may set their own dates but must close no later than December 31.

:::predict
prompt: ACA Marketplace open enrollment for 2026 coverage runs from November 1 to January 15. How many days long is that window, counting both endpoints?
answer: 76
tolerance: 0.5
unit: days
hint: Count all of November, all of December, then the days into January.
explain: November contributes 30 days, December contributes 31, and January contributes 15. So 30 plus 31 plus 15 equals 76 days inclusive. This is the window a finance trader must pace ACA insurance buys against, and its high-intent tail runs past the December 15 full-coverage deadline to the January 15 close, well beyond the December 7 Medicare cutoff.
:::

# Seasonal CPM premium and when to pull back

Q4 is expensive for everyone, not just finance. General retail competition lifts CPMs by roughly 30 percent or more into November (current US benchmarks show the November peak running about 28 to 38 percent above baseline, with some holiday segments higher) before they fall back in December and January as that demand recedes, and finance bids ride on top of that. The seasonal CPM premium is the percentage lift of peak CPM over baseline, $\text{premium} = (\text{CPM}_{\text{peak}} - \text{CPM}_{\text{baseline}}) / \text{CPM}_{\text{baseline}}$, and it tells the trader how much extra they pay for the same impression purely because of the calendar. The judgment call is whether that higher CPM is matched by higher funded intent. If it is not, the incremental CPFA worsens and the right move is to pull back, not chase volume.

:::predict
prompt: Baseline finance CPM is $10 and the November peak CPM is about $13. What is the seasonal CPM premium, rounded to the nearest whole percent?
answer: 30
tolerance: 0.5
unit: %
hint: Subtract baseline from peak, then divide by baseline.
explain: 13 minus 10 is 3. Then 3 divided by 10 is 0.30, which is a 30 percent premium. You are paying 30 percent more per impression in November before any change in funded rate.
:::

:::callout warning
A recurring operator complaint is that leadership wants "more spend" during seasonal peaks even when the incremental CPFA is deteriorating because of auction competition, not real demand. Another common pain point: budgets get front-loaded and burn out before the actual high-intent window, the refund-disbursement weeks and the enrollment deadlines, so the campaign misses the funded accounts that mattered most. For ACA the deadlines that matter are December 15 and January 15, not the December 7 Medicare cutoff. Pace to when money lands, not to the headline season.
:::

# The seasonality curve a finance trader buys against

Plotting indexed finance CPM and demand across the year shows the shape the trader pages against: a Q4 climb into November, a December and January trough in general CPM, then a steep tax-season rise into April. The peak is not a single day. Medicare funded intent concentrates around the December 7 deadline, ACA funded intent carries through the December 15 and January 15 deadlines, and many tax products see their real funded-deposit windows during refund-disbursement weeks in February and March, not only at the April filing date. Reading this curve tells the trader where to add budget, where the off-season floor sits, and where guaranteed deals risk overpaying.

:::figure seasonalityCurve
caption: Indexed finance CPM and seasonal demand across the year. The November Q4 lift, the December to January trough in general CPM, and the tax-season climb into April are the three structural features a finance trader paces and dayparts around, while ACA insurance intent tails past December into the January 15 deadline.
:::

:::widget lineChart
title: Indexed finance CPM and seasonal demand by month
labels: Aug, Sep, Oct, Nov, Dec, Jan, Feb, Mar, Apr
data: 100, 104, 118, 130, 101, 92, 100, 110, 122
unit: index
:::

# Dayparting to where funded intent actually is

Within any week and day, funded intent is not uniform. Paydays, evenings, and post-paycheck deposit windows convert better than dead hours, and tax-refund disbursement weeks beat the rest of the calendar for deposit products. The trader expresses this with a daypart bid multiplier, $\text{multiplier} = \text{funded rate in daypart} / \text{average funded rate}$, capped so the implied bid never breaches the CPFA ceiling. A daypart that funds at one and a half times the average earns up to a 1.5x bid, while a 3am daypart that barely funds earns a cut. The point is to move budget toward where it produces funded accounts, not impressions.

:::predict
prompt: A payday-evening daypart funds at 0.09 percent (funded per impression) while the campaign average funded rate is 0.06 percent. What daypart bid multiplier does that imply, before any ceiling cap?
answer: 1.5
tolerance: 0.05
unit: x
hint: Divide the daypart funded rate by the average funded rate.
explain: 0.09 divided by 0.06 equals 1.5. The daypart funds at one and a half times the average, so it can justify up to a 1.5x bid, as long as the resulting bid still respects the CPFA ceiling.
:::

:::quiz
question: A daypart shows a high funded rate, so its bid multiplier comes out above 1.0. What still has final say over the bid?
- The daypart multiplier overrides everything else
- The CPFA ceiling caps the bid regardless of the multiplier
- The publisher's floor price sets the bid
- The seasonal CPM premium sets the bid
answer: 1
hint: Module 4 built one hard limit that every bidding decision must respect.
explain: The daypart multiplier scales the bid toward productive hours, but the LTV-derived CPFA ceiling is the hard cap. A high-funding daypart can earn a higher bid only up to the point where the implied cost per funded account still clears the ceiling.
:::

# Pacing the flight without burning out early

Pacing is the discipline of spending a flight budget evenly enough that money is still available when the highest-intent days arrive. The pacing index compares actual spend to expected spend, $\text{pacing index} = \text{actual spend to date} / (\text{flight budget} \times \text{elapsed share of flight})$, where 1.0 is exactly on pace, above 1.0 is overspending, and below 1.0 is underspending. In finance the classic mistake is front-loading a flight into rising-CPM season so the budget exhausts before the refund or enrollment deadline. For an ACA flight that means burning out before the December 15 and January 15 deadlines. A pacing index well above 1.0 early in a flight is a warning, not a win.

:::predict
prompt: A flight has a $200,000 budget over 30 days. Twelve days in, $96,000 has been spent. What is the pacing index, where 1.0 is on pace?
answer: 1.2
tolerance: 0.02
unit: index
hint: Expected spend is the budget times the elapsed share of the flight; divide actual by expected.
explain: Elapsed share is 12 divided by 30, which is 0.4. Expected spend is 200,000 times 0.4, which is 80,000. Actual is 96,000, so the pacing index is 96,000 divided by 80,000 equals 1.2, meaning the flight is spending 20 percent ahead of pace and risks burning out before the deadline.
:::

# Defending the budget: CPFA against the ceiling

The synthesis is one number defended in review. Tax-season and off-season CPFA must be compared, $\text{effective season CPFA} = \text{season media spend} / \text{season funded accounts}$, against the off-season baseline and against the LTV-derived ceiling, so the trader can say whether a peak was worth it. A higher season CPFA is acceptable only if it still clears the ceiling and the incremental funded accounts justify it, which is exactly the incrementality discipline from module 6 applied to timing. The finance trader buys against the CPFA ceiling (module 4), inside compliance rails that strip targeting (module 3), through a leaky impression to KYC to funded cascade they instrument (module 5), defends spend with geo holdouts rather than last-click ROAS (module 6), activates first-party CRM via clean rooms (module 7), on premium PMP and PG deals with SPO (module 8), kept clean by brand-safety and disclosure ops (module 9), and timed to the calendar (this module).

:::predict
prompt: During tax season a flight spends $480,000 and produces 2,400 funded accounts. What is the effective tax-season CPFA, in dollars?
answer: 200
tolerance: 1
unit: USD
hint: Divide season media spend by season funded accounts.
explain: 480,000 divided by 2,400 equals 200. The tax-season CPFA is $200. If the off-season CPFA is $150 and the LTV-derived ceiling is, say, $210, this peak still clears the ceiling but is materially less efficient, so the trader must show incremental funded accounts justify the premium.
:::

:::quiz
question: A guaranteed PG deal from module 8 keeps delivering impressions at 3am, a daypart that almost never funds. What is the correct read?
- It is fine because guaranteed impressions are already paid for
- It wastes guaranteed spend the CPFA ceiling cannot justify, so the PG must be paced into productive dayparts
- It should be reported as incremental funded volume
- It proves the seasonal premium is too low
answer: 1
hint: A guaranteed commitment still has to land where funded intent exists.
explain: A PG deal fixes price and committed volume, but those impressions still must be paced into dayparts that produce funded accounts. Delivering guaranteed spend at 3am burns budget the CPFA ceiling cannot justify, so the trader paces the PG into productive windows rather than letting it dump in dead hours.
:::

:::sources
- KFF, When can I enroll in Marketplace health plan coverage? (ACA open enrollment November 1 to January 15, December 15 deadline) | https://www.kff.org/faqs/faqs-health-insurance-marketplace-and-the-aca/marketplace-enrollment-periods/when-can-i-enroll-in-marketplace-health-plan-coverage/
- Center for Medicare Advocacy, Medicare Annual Enrollment Period Lasts Through December 7 (October 15 to December 7) | https://medicareadvocacy.org/medicare-annual-enrollment-period-lasts-through-december-7/
- SuperAds, Facebook Ads CPM Cost Benchmarks (Q4 and seasonal CPM lift) | https://www.superads.ai/facebook-ads-costs/cpm-cost-per-mille/united-states
- incrmntal, Understanding Incremental ROAS vs ROAS (incrementality for budget defense) | https://www.incrmntal.com/resources/understanding-incremental-roas-vs-roas-for-marketers
- Publift, Deal ID Explained: PMP vs Programmatic Guaranteed | https://www.publift.com/blog/deal-id
- eightx, LTV:CAC Ratio and CAC Payback Benchmarks | https://eightx.co/blog/ltv-cac-ratio-guide
- Epom, How to Reduce Ad Discrepancy (counting-point reconciliation) | https://epom.com/blog/metrics/how-to-reduce-ad-discrepancy
- AppsFlyer, What is SKAdNetwork (SKAN)? MMP postbacks for funded events | https://www.appsflyer.com/glossary/skadnetwork/
:::
