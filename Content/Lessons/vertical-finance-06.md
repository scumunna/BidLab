---
id: vertical-finance-06
track: vertical-finance
module: 6
title: Measurement That Lies: Incrementality and Geo Holdouts
summary: Learn to prove that media actually caused funded accounts, run a geo holdout, compute incremental cost per funded account, and defend the right budget when last-click and view-through overstate ROAS.
---
# Why last-click flatters and view-through lies

A finance trader is judged on cost per funded account, and the dashboard reports that number against whichever attribution model is wired up. The trap is that on warm, affluent finance audiences the default models credit the ad even when the customer was already going to fund. Last-click hands all the credit to whatever touchpoint sat closest to the conversion, and view-through counts a funded account as ad-driven merely because an impression was served, regardless of whether anyone saw it or acted on it.

The result is systematic overstatement. Last-click and view-through can overstate paid impact by 30 percent or more because neither can separate organic demand from demand the ad actually created. The cleanest example is retargeting a high-intent user who already had the app open: last-click shows a spectacular return, and the true incremental contribution is close to zero.

:::callout key
Attribution answers "which touchpoint was nearest the conversion." Incrementality answers "would this funded account have happened anyway." Only the second question maps to the CPFA ceiling, and only the second one survives a budget review.
:::

:::quiz
question: A view-through model credits a funded account to your campaign. What is the model actually asserting about that account?
- That the person clicked the ad before funding
- That the ad created demand that would not have existed otherwise
- That the funded account was incremental to organic demand
- That an impression was served before the account funded, regardless of whether anyone saw or acted on it
answer: 3
hint: Think about the weakest possible thing that has to be true for view-through to fire.
explain: View-through attribution only requires that an impression was served before the conversion. It does not require a click, a viewable impression, or any proof the ad caused the funding, which is exactly why it overstates paid impact on warm finance audiences. The other options describe a click, or describe incremental causation, neither of which view-through establishes.
:::

# Incrementality: the counterfactual that attribution skips

Incrementality measures the difference between what happened with the ad running and what would have happened without it. That second world, the counterfactual, is unobservable for any single user, so you estimate it with a control group: a comparable population that did not get the ad. Incremental funded accounts are the funded accounts in the exposed group minus the funded accounts the control group produced, scaled to the same size.

$$ \text{incremental funded} = \text{funded}_{\text{test}} - \text{funded}_{\text{control, scaled}} $$

The honest version of your KPI is incremental cost per funded account: incremental media spend divided by incremental funded accounts. This is almost always a larger, less flattering number than the reported CPFA, because the denominator drops the accounts that would have funded for free.

$$ \text{iCPFA} = \frac{\text{incremental media spend}}{\text{incremental funded accounts}} $$

:::predict
prompt: A retargeting line spends $84,000 and the dashboard credits it with 420 funded accounts on a last-click basis. What is the reported (last-click) cost per funded account, in dollars?
answer: 200
tolerance: 1
unit: USD
hint: Reported CPFA is media spend divided by the funded accounts the model credits.
explain: $84,000 / 420 = $200 reported CPFA. This is the flattering number the dashboard shows before any incrementality test strips out the accounts that would have funded anyway.
:::

# Reading the gap: the last-click overstatement factor

Once you have both numbers you can quantify the lie directly. The last-click overstatement factor is reported ROAS divided by incremental ROAS (equivalently, reported funded divided by incremental funded for the same spend). A factor of 1.0 means the line is fully incremental. Retargeting and brand search routinely come back at 2x to 5x, meaning the dashboard claimed two to five times the return the ad actually drove.

$$ \text{overstatement} = \frac{\text{reported ROAS}}{\text{incremental ROAS}} $$

This is why a finance trader keeps two columns: the reported CPFA everyone stares at, and the incremental CPFA that actually tells you whether to keep spending. The bar chart below shows the pattern across line types, with prospecting holding more of its reported value than retargeting.

:::widget barChart
title: Reported vs incremental ROAS by line type
labels: Reported prospecting, Incremental prospecting, Reported retargeting, Incremental retargeting
data: 5.0, 2.0, 8.0, 1.5
unit: ROAS (x)
:::

:::predict
prompt: A retargeting line reports a 5.0 ROAS, but a holdout measures its incremental ROAS at 1.25. By what factor did last-click overstate the return?
answer: 4
tolerance: 0.05
unit: x
hint: Divide the reported ROAS by the incremental ROAS.
explain: 5.0 / 1.25 = 4. Last-click claimed four times the return the ad actually generated; three of every four "retargeting-driven" funded accounts would have funded without the ad.
:::

:::quiz
question: A brand-search line shows a 9x last-click ROAS, and a clean holdout measures its incremental ROAS at 1.2x. What is the most defensible read?
- Brand search is your best channel; shift budget into it
- Brand search is mostly harvesting demand that already existed; most of its credit is not incremental
- The holdout is wrong because last-click is the platform's official number
- Incremental ROAS below the reported number always means the test failed
answer: 1
hint: A high reported number next to a near-1.0 incremental number is the signature of demand harvesting.
explain: A 9x reported next to a 1.2x incremental is the classic "measurement that lies" pattern: the line is capturing users already converting. The honest, smaller number is the point of the test, not a failure of it, and it outranks last-click for budget decisions.
:::

# Running a geo holdout

The workhorse incrementality test in finance is the geo holdout, also called geo-lift. You split comparable markets into a test group that gets the media (or a deliberate budget increase) and a control group that gets none (or a reduced budget), hold everything else constant, and measure the difference in funded accounts. Geo works in finance because you can turn spend on and off by DMA or state cleanly, and because it does not depend on user-level identifiers that privacy rules and ATT have stripped away.

Match markets on size and baseline funded rate, scale the control to the test population, and run long enough to accumulate funded events. Lift percent is the relative gap in conversion rate between the groups.

$$ \text{lift \%} = \frac{\text{rate}_{\text{test}} - \text{rate}_{\text{control}}}{\text{rate}_{\text{control}}} $$

:::figure geoHoldout
caption: A geo holdout splits comparable markets into test (ads on) and control (ads off or scaled down). Funded accounts in the control estimate the counterfactual, and the difference, scaled to test size, is the incremental lift.
:::

:::predict
prompt: A test market produces 1,000 funded accounts with ads on. The matched control, scaled to the same population, produces 700 with ads off. How many funded accounts were incremental?
answer: 300
tolerance: 1
unit: funded accounts
hint: Incremental funded is test funded minus the scaled control funded.
explain: 1,000 - 700 = 300 incremental funded accounts. The 700 in the control would have funded without any ad, so only the 300-account difference is attributable to the media.
:::

:::predict
prompt: That same test spent $66,000 of incremental media to generate the 300 incremental funded accounts. What is the incremental cost per funded account, in dollars?
answer: 220
tolerance: 1
unit: USD
hint: Divide incremental media spend by incremental funded accounts.
explain: $66,000 / 300 = $220 incremental CPFA. Compare this to your LTV-derived CPFA ceiling, not to the flattering last-click CPFA, when deciding whether the line clears the bar.
:::

# What breaks a test, and the org fight that follows

Geo holdouts fail quietly when they are run wrong. Finance's funded signal is sparse and delayed because KYC and first deposit can take hours or days, so a test that runs for days instead of weeks measures noise rather than lift. Contamination is the other killer: national CTV, spillover into adjacent DMAs, and PR or earned media bleed the treatment into the control and wash out the measured difference, so you pick clean, non-adjacent geos and keep national campaigns out of the read.

There is also an organizational cost. The honest incremental number is smaller than the dashboard number, so reporting incremental CPFA while peers report last-click CPFA makes your performance look worse even though it is truer. Align the team on one attribution standard before review season, or the trader who did the rigorous thing gets blamed for performance that was never real.

:::callout warning
A recurring practitioner complaint: leadership refuses to cut a high last-click-ROAS retargeting line even after a clean geo test shows it is roughly zero incremental, because "the dashboard says it works." Bring the holdout result, the matched-market design, and the incremental CPFA to that meeting; the dashboard alone will lose the argument every time.
:::

:::predict
prompt: In a holdout, the test market funds at a 1.8 percent rate and the matched control funds at a 1.2 percent rate. What is the lift, in percent?
answer: 50
tolerance: 0.5
unit: percent
hint: Lift is the difference in rates divided by the control rate.
explain: (1.8 - 1.2) / 1.2 = 0.6 / 1.2 = 0.50, a 50 percent lift. The exposed market funds half again as often as the control, which is the incremental effect of the media before you convert it to an incremental CPFA.
:::

:::quiz
question: A finance geo test ran for five days and returned a noisy, non-significant lift. What is the most likely fix?
- Switch from geo holdout to last-click attribution
- Run the test for several weeks so enough sparse, delayed funded events accumulate
- Add national CTV to the test markets to boost volume
- Declare the channel non-incremental and cut it immediately
answer: 1
hint: Think about how long a funded event takes to fire and how many you need for significance.
explain: Funded events are sparse and delayed in finance, so a five-day window cannot accumulate enough to reach significance. Extending the flight to weeks fixes it; switching to last-click reintroduces the bias, adding national CTV contaminates the control, and cutting on a noisy result is premature.
:::

:::sources
- incrmntal, Understanding Incremental ROAS vs ROAS for Marketers | https://www.incrmntal.com/resources/understanding-incremental-roas-vs-roas-for-marketers
- AppsFlyer, Incrementality testing 101: a marketer's guide | https://www.appsflyer.com/blog/tips-strategy/incrementality-testing-for-marketers/
- Meta, Conversion Lift testing for incrementality measurement | https://www.facebook.com/business/measurement/conversion-lift
- Google Ads, Set up Conversion Lift based on geography | https://support.google.com/google-ads/answer/14097193
- id-pal, KYC delays slowing customer onboarding: 1 in 5 checks take more than 24 hours | https://www.id-pal.com/blog/kyc-delays-slowing-customer-onboarding/
- ExchangeWire, Navigating Brand Safety in 2025: insights from the ad industry | https://www.exchangewire.com/blog/2025/10/06/navigating-brand-safety-in-2025-insights-from-the-ad-industry/
:::
