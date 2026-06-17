---
id: vertical-travel-08
track: vertical-travel
module: 8
title: Measurement and Incrementality, Geo Holdouts vs Last-Click and SKAN-Truncated ROAS
summary: Prove real booking lift with geo-holdout incrementality, expose how last-click overstates retargeting ROAS, and model the SKAN truncation that under-credits in-app bookings before you judge or cut an app line.
---
# The credit problem at the center of travel measurement

In travel, the question is almost never "did bookings happen near the ads." It is "would those bookings have happened without the ads." A near-buyer who already searched a route forty days ago and was always going to book gets claimed by whatever retargeting impression lands last, so last-click and standard attribution hand the retargeting line credit it did not earn. Your job is to separate the bookings the media caused from the bookings the media merely witnessed.

That gap is large in travel specifically because the funnel is long and self-selected. The retargeting pool is, by construction, people who already raised their hand, so a high last-click return on ad spend (ROAS) is partly a measurement artifact, not a media effect. Everything in this lesson is about replacing "claimed" demand with "caused" demand.

:::predict
prompt: Last-click credits a retargeting line with 5,000 bookings, but a holdout shows only 1,500 were actually caused by the media (the rest were near-buyers who would have booked anyway). What percent of the last-click-credited bookings did the media merely witness rather than cause?
answer: 70
tolerance: 0.5
unit: %
hint: Witnessed bookings are the claimed total minus the caused bookings, divided by the claimed total.
explain: Witnessed (non-caused) bookings = 5,000 - 1,500 = 3,500. As a share of the claimed total, 3,500 / 5,000 = 0.70, so 70 percent of what last-click credits is demand the media only witnessed. Only the remaining 30 percent (1,500 bookings) is caused demand you can defensibly bill.
:::

:::callout key
The single sentence to carry out of this lesson: last-click ROAS measures correlation with bookings, a geo holdout measures causation of bookings, and only the second number sets a defensible Cost per booking.
:::

# The four definitions you will compute every quarter

Four formulas turn a holdout into a decision. Incremental bookings is test-geo bookings minus the scaled control-geo bookings (the counterfactual), incrementality percent is incremental bookings over test-geo bookings, true incremental CPB is media spend over incremental bookings, and ROAS overstatement is last-click ROAS over incremental ROAS. The scaling factor exists because test and control geos are rarely the same size, so you normalize the control to the test population before subtracting.

$$ \text{Incremental bookings} = B_{\text{test}} - (B_{\text{control}} \times s) $$

$$ \text{Incrementality \%} = \frac{\text{Incremental bookings}}{B_{\text{test}}} \qquad \text{True CPB} = \frac{\text{Media spend}}{\text{Incremental bookings}} $$

The control geos answer the only question that matters: how many bookings would have arrived with zero media. Subtract that baseline from what the test geos actually produced, and the remainder is the lift you can honestly bill to the campaign.

:::predict
prompt: Test geos produce 5,000 confirmed bookings. Matched control geos, scaled to the same population, imply 4,000 bookings would have happened anyway. What is the incrementality percent of test-geo bookings?
answer: 20
tolerance: 0.5
unit: %
hint: Incremental bookings divided by test-geo bookings.
explain: Incremental bookings = 5,000 - 4,000 = 1,000. Incrementality % = 1,000 / 5,000 = 0.20, so 20 percent of the test-geo bookings were actually caused by the media. The other 80 percent would have booked with no ads at all.
:::

# Turning incremental bookings into a true CPB

Last-click CPB and incremental CPB are different numbers off the same spend, and the spread between them is the whole argument you bring to a client. Take the holdout above and attach dollars: if the campaign spent 200,000 dollars, the true incremental CPB is 200,000 over the 1,000 caused bookings, not over the full booked volume that last-click would have credited. The signature travel KPI, Cost per booking, only means something once the denominator is incremental bookings.

$$ \text{True (incremental) CPB} = \frac{\text{Media spend}}{\text{Incremental bookings}} = \frac{200{,}000}{1{,}000} = 200 $$

This is why a desk that reports only last-click CPB looks like a hero and a desk that reports incremental CPB keeps its budget when finance audits it. The first number flatters retargeting, the second survives scrutiny.

:::predict
prompt: A campaign spends $200,000 and a geo holdout attributes 1,000 incremental bookings to it. What is the true incremental cost per booking?
answer: 200
tolerance: 1
unit: USD per booking
hint: Spend divided by incremental bookings.
explain: True incremental CPB = $200,000 / 1,000 = $200 per booking. If last-click had instead credited the campaign with, say, 2,667 bookings, it would have reported roughly $75 CPB, a number that vanishes once you subtract the demand that was always going to convert.
:::

# Why last-click overstates retargeting so badly

Retargeting in travel routinely shows 3x to 4x the ROAS of prospecting on a last-click basis, and case data circulates of single hotels claiming 24x on retargeting. Much of that is non-incremental: the line is being served to people who already chose to book, so the last impression collects credit for a decision made earlier. The defensible read is the ratio of what last-click claims to what the holdout proves.

$$ \text{ROAS overstatement} = \frac{\text{Last-click ROAS}}{\text{Incremental ROAS}} = \frac{5.87}{2.2} \approx 2.67\times $$

A line can post 5.87x last-click and prove out at roughly 2.2x incremental, an overstatement of about 2.67 times. That is the same multiple you see on the cost side, because for one line the spend is fixed and each booking is worth the same dollars no matter which attribution method counts it: roughly 2,667 bookings credited by last-click collapse to 1,000 caused bookings, which is why a 75 dollar last-click CPB becomes a 200 dollar incremental CPB. That does not mean retargeting is worthless. It means the headline number is inflated by a known factor, and you size budgets to the incremental figure while still running the line for its real, smaller lift.

:::figure incrementalityHoldout
caption: A matched-market geo holdout. Media runs in the test geos and is withheld in the scaled control geos, and the booking gap between them, normalized to the same population, is the incremental lift. The pixel reports correlation, the holdout reports causation.
:::

:::widget barChart
title: Last-click vs incremental, same retargeting line
labels: Last-click ROAS, Incremental ROAS, Last-click CPB, Incremental CPB
data: 5.87, 2.2, 75, 200
unit: x or USD
:::

# The second break, SKAN truncates the app side

Travel measurement breaks twice, in opposite directions. On the web, last-click over-credits because the window is long enough to scoop up demand that was already converting. On iOS apps, SKAdNetwork does the reverse: it collapses the post-install window into a short, coarse, privacy-preserving postback, so an in-app booking that completes weeks later, well inside travel's roughly forty-five-day consideration cycle, often fires after the postback already closed and is never tied back to the ad. Web ROAS reads too high and app ROAS reads too low, so a naive blend distorts in both directions at once.

The operational consequence is concrete. An app-install or in-app retargeting line can look unprofitable purely because SKAN did not credit the late bookings it actually drove, and a client will ask you to kill it. Before you cut, you model the truncation: estimate the bookings that landed after the SKAN window using your MMP cohort curves, add them back, and only then compute the line's real CPB.

:::quiz
question: An iOS in-app booking line shows a terrible ROAS while the equivalent web line looks strong. What is the most likely measurement explanation before you conclude the app line is failing?
- Web last-click under-counts and app SKAN over-counts
- Web last-click over-credits while SKAN truncates and under-credits the app's late in-app bookings
- The app and web lines are measuring the identical event the identical way
- SKAdNetwork extends the attribution window beyond the web window
answer: 1
hint: The two surfaces distort in opposite directions, not the same direction.
explain: Web last-click over-credits because its window is long, while SKAN collapses the iOS post-install window and under-credits in-app bookings that complete after the postback fires. Modeling the SKAN gap is required before judging or cutting the app line.
:::

# Running a holdout that spans both surfaces

Because the two surfaces distort oppositely, a single blended ROAS is not a valid input to an incrementality read. You run geo holdouts that cover both surfaces, then feed MMP-attributed app bookings and web-pixel bookings into the lift calculation as separate inputs rather than a pre-blended total. The holdout measures total caused bookings in the test geos regardless of surface, which is exactly why it sidesteps both the last-click inflation and the SKAN truncation that corrupt the per-surface pixels.

Matched-market design is the discipline that makes this trustworthy. The control geos must be isolated and demographically matched to the test geos, or the baseline is wrong. The classic contaminant is spillover: a held-out user who travels into a test market and sees the ad there is no longer a clean control, which deflates measured lift. You pick markets that do not bleed into each other and you watch travel routes between them.

:::predict
prompt: A two-surface holdout spends $150,000. The test geos book 3,400 and the scaled control geos imply 2,400 would have happened anyway. What is the true incremental cost per booking across both surfaces?
answer: 150
tolerance: 1
unit: USD per booking
hint: First get incremental bookings, then divide spend by it.
explain: Incremental bookings = 3,400 - 2,400 = 1,000. True incremental CPB = $150,000 / 1,000 = $150 per booking. Because the holdout counts caused bookings on web and app together, it is immune to both the web last-click inflation and the iOS SKAN truncation that would distort a per-surface pixel read.
:::

:::quiz
question: Why is a matched-market geo holdout the buy-side standard for proving travel lift, rather than just trusting the booking pixel?
- Because the pixel is cheaper to run than a holdout
- Because no pixel fully captures offline, cross-device, and cross-surface booking truth, so only a withheld control isolates causation
- Because holdouts credit more bookings than the pixel does
- Because regulators require a geo holdout on every campaign
answer: 1
hint: Think about what the pixel structurally cannot see versus what a control group reveals.
explain: Travel bookings complete offline, across devices, and across web and app, so no single pixel sees the full truth and last-click over-credits what it does see. A withheld, matched control isolates the bookings that would have happened anyway, which is the only way to read true incremental lift.
:::

# Where this goes wrong in the field

The recurring operator complaint is political, not mathematical: clients celebrate the last-click retargeting ROAS and resist the holdout that would reveal most of it is non-incremental, because the holdout makes a celebrated number shrink. The parallel complaint is that iOS app ROAS looks dismal next to web purely because SKAN under-reports, and clients push to kill a channel that is actually working once the truncation is modeled back in. Both failures come from trusting a distorted pixel over a designed experiment.

Treat the holdout as the source of truth and the pixels as biased estimators you correct, not the other way around. Report incremental CPB as the headline, keep last-click visible only as the inflated comparison, and never let a SKAN-truncated app number be the sole basis for cutting a line.

:::quiz
question: A client wants to defund the geo holdout (because it shrinks the celebrated 5.87x last-click retargeting ROAS) and simultaneously kill the iOS app line (because its SKAN-reported ROAS looks terrible). What is the correct buy-side response?
- Agree to both, since the pixel numbers are the data the client trusts
- Keep the holdout as the source of truth and model the SKAN-truncated late bookings back in before any budget moves
- Defund the holdout but keep the app line running on its SKAN number
- Kill the app line but keep funding the holdout
answer: 1
hint: Both client reactions trust a distorted pixel over a designed experiment.
explain: Both reactions trust biased pixels over the experiment. The holdout is the only read that strips the non-incremental near-buyers inflating the 5.87x down to a proven 2.2x, and the app line's true CPB only appears once you add back the in-app bookings SKAN truncated. So you protect the holdout and run the SKAN model before reallocating any spend.
:::

:::callout warning
A real desk pain point: traders report that clients fixate on a 5.87x last-click retargeting ROAS and refuse to fund a geo holdout, while simultaneously demanding the iOS app line be shut off because its ROAS looks terrible. Both reactions are backwards. The retargeting line is likely far below 5.87x incremental (closer to the proven 2.2x), and the app line is likely far above its SKAN-reported figure once the truncated late bookings are modeled back in. Insist on the holdout and the SKAN model before any budget moves.
:::

:::sources
- AppsFlyer, Travel app growth powered by AI and retargeting in 2025 (retargeting drives over 75% of conversions, 80% of activity from re-engagement vs 20% paid UA) | https://www.appsflyer.com/company/newsroom/pr/travel-app-growth-2025/
- Adjust, AdAttributionKit vs SKAdNetwork (short post-install windows of 0-48h, 2-7d, 8-35d truncate late conversions, coarse conversion values, limited re-engagement) | https://www.adjust.com/blog/adattributionkit/
- AppsFlyer, Travel and Local app attribution and marketing analytics (MMP stitching of web research to in-app booking) | https://www.appsflyer.com/solutions/travel-local/
- calc4marketers, Average ROAS for Travel Advertising 2026 (blended travel averages around 4.0-4.5x are last-click figures that overstate incremental lift) | https://www.calc4marketers.com/average-roas-travel
- Condor Ferries, Online Travel Booking Statistics 2025 (mobile grew to nearly 50% of digital travel sales, mobile 0.7% vs desktop 2.4% booking completion) | https://www.condorferries.co.uk/online-travel-booking-statistics
- Skift, RateGain to Buy Sojern in $250 Million Deal | https://skift.com/2025/10/02/rategain-to-buy-sojern-in-250-million-deal-expanding-its-marketing-reach/
:::
