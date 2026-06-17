---
id: vertical-travel-05
track: vertical-travel
module: 5
title: Pacing and Seasonality, Buying Against a Demand Curve You Don't Control
summary: You will learn to pace a fixed travel budget against booking-lead times you cannot move, weight spend to the weeks people book rather than the weeks they travel, and protect cost per booking when demand softens.
---
# The demand curve buys itself, you just choose when to show up

In retail you pace toward a calendar you can predict: spend ramps into Q4, peaks on the days everyone already knows, and a flat daily budget is a defensible default. Travel is the opposite. Demand is driven by booking lead times the trader cannot move, so the job is not to create the peak but to have budget left when it arrives. The signature KPI does not change, it sharpens: cost per booking (CPB) is only good if your spend lands in the weeks when sessions actually convert, and a budget burned in a low-intent month posts a great click-through rate and a terrible CPB.

The mental model for the whole lesson is that you are flighting media against a curve someone else controls, and your only levers are when to spend, how fast, and on which surface. Get the timing right and an average channel hits target; get it wrong and a great channel still misses, because the bookings simply were not there the week you spent.

:::callout key
Travel pacing is timing, not just budgeting. The same dollars, the same creative, and the same audience produce a wildly different CPB depending only on whether they fire in a booking-lead week or a dead week. Pace to when people book, not when they travel.
:::

:::quiz
question: A flight client hands the desk a fixed budget for a summer-travel campaign. The single biggest pacing mistake the trader can make is to pace spend against which calendar?
- The booking-lead calendar (the weeks people search and book)
- The travel calendar (the weeks people actually fly)
- The competitor's flight calendar
- The agency's billing calendar
answer: 1
hint: Demand is set by when people book, which leads the trip by weeks to months.
explain: Pacing to the travel calendar front-loads dollars into the month people fly and starves the booking-lead weeks (months earlier) when sessions actually convert, posting a fine click-through rate and a terrible cost per booking. The job is to flight spend against the booking-lead curve someone else controls, not the travel dates.
:::

# Spend leads the trip, by weeks not days

The single most important offset in travel is between the travel date and the booking date. Flights are commonly booked two to eight months out, hotels in a roughly 21 to 90 day window, and cruises cluster in January through March "wave season" regardless of when the sailing departs. Layer on a consideration window that averages about 45 days, and the implication is blunt: a summer-flight budget has to peak in late winter, because that is when the searches and the carts happen.

The formula that operationalizes this is the booking-window offset. You take the travel date the client cares about and subtract the median booking lead time to find when to spend.

$$ \text{Booking-window offset} = \text{Travel date} - \text{Median booking lead time} $$

So for a July departure with a five-month median lead time, your spend has to be live and pacing hard in February, not June. The classic rookie failure is spending against the travel date, which front-loads dollars into the month people fly and starves the month people book.

:::predict
prompt: A flight campaign targets a July 1 departure. The median booking lead time for the route is 5 months. In which month (as a month number, January = 1) should spend peak?
answer: 2
tolerance: 0
unit: month number
hint: Subtract 5 months from July (month 7).
explain: Travel date is month 7 (July). Median lead time is 5 months. 7 minus 5 equals 2, so spend must peak in February, five months before anyone actually flies. Pacing to July would put the budget in the month of travel, not the month of booking.
:::

:::figure seasonalityCurve
caption: Travel media flights against the booking curve, not the travel calendar. Spend has to ramp into the booking-lead weeks (late winter for a summer trip) and taper as the booking window for that travel date closes, because that is when sessions convert.
:::

# Daily pacing and the pacing index

Within a flight, the two numbers you watch every morning are the daily pacing target and the pacing index. The daily target is simply how much you can spend per remaining day to land the budget exactly.

$$ \text{Daily pacing target} = \frac{\text{Remaining budget}}{\text{Remaining days in flight}} $$

The pacing index tells you whether you are ahead of or behind plan. It is actual spend to date divided by planned spend to date, where 1.0 is perfectly on pace, above 1.0 means you are overspending and risk going dark before the booking peak, and below 1.0 means you are underspending and may leave budget stranded after the window closes.

$$ \text{Pacing index} = \frac{\text{Actual spend to date}}{\text{Planned spend to date}} $$

The reason this matters more in travel than in retail is asymmetry of regret. Going dark a week early in a flat-demand category costs you a slice of average days; going dark a week early in travel can mean missing the entire booking surge for that travel date, which you cannot recover later because the window has closed.

:::predict
prompt: A flight campaign has $84,000 of budget remaining and 28 days left in the flight. What is the daily pacing target?
answer: 3000
tolerance: 0
unit: USD per day
hint: Divide remaining budget by remaining days.
explain: 84,000 divided by 28 equals 3,000. The desk should pace to roughly $3,000 per day to land the budget exactly across the remaining flight, then re-check tomorrow as remaining budget and remaining days both update.
:::

:::predict
prompt: Planned spend to date is $40,000 and actual spend to date is $50,000. What is the pacing index, to two decimals?
answer: 1.25
tolerance: 0.01
unit: index
hint: Divide actual by planned.
explain: 50,000 divided by 40,000 equals 1.25. A pacing index of 1.25 means you are 25 percent ahead of plan and on track to exhaust the budget early, so unless this is intentional front-loading into a booking-lead week, throttle daily caps to avoid going dark before the peak.
:::

# Weight the budget to the booking weeks

A flat daily budget is a trap in travel because it implicitly assumes every week converts equally, and they do not. The fix is to weight the budget by expected bookings, not by calendar days. The seasonal budget weight for a period is that period's expected bookings divided by total expected bookings across the flight, and you allocate dollars in those proportions.

$$ \text{Seasonal budget weight} = \frac{\text{Expected bookings in period}}{\text{Total expected bookings}} $$

Concretely, if a flight runs eight months and 40 percent of expected bookings for the target travel date fall in two of those months, those two months should carry roughly 40 percent of the budget, not 25 percent (which is what an even split across eight months would give the same two months). The booking-lead curve below is the kind of shape you weight against: spend ramps into the booking peak and tapers as that travel date's window closes.

:::widget lineChart
title: Booking-lead curve, share of bookings by month for a summer travel date
labels: Jan, Feb, Mar, Apr, May, Jun, Jul, Aug
data: 40, 70, 95, 85, 60, 45, 35, 30
unit: index
:::

:::quiz
question: A travel flight runs for eight months. Booking data shows that two of those months will produce 40 percent of all bookings for the target travel date. How should the trader allocate budget?
- Spread it evenly: each of the eight months gets one-eighth (12.5 percent).
- Weight it: the two high-booking months get about 40 percent of the budget between them.
- Hold most of it for the travel month itself, when the trips happen.
- Front-load everything into month one to build awareness early.
answer: 1
hint: Allocate dollars in proportion to expected bookings, not in proportion to calendar days.
explain: Seasonal budget weight allocates spend by expected bookings, so two months that drive 40 percent of bookings should carry about 40 percent of the budget, not the 25 percent an even split would hand them. Spreading evenly under-serves the peak, holding for the travel month spends after the booking window has closed, and front-loading month one wastes dollars before intent exists.
:::

# Off-peak: tilt to retargeting and re-engagement

When prospecting demand is thin, the worst move is to keep paying open-market CPMs to chase cold users who are not in a booking window. The better move is to tilt budget toward re-engagement, because near-buyers persist after broad demand fades. In travel, retargeting delivers roughly 3 to 4 times the ROAS of prospecting, and in 2025 about 75 percent of travel app conversions came from re-engaged users, which is exactly the population that smooths a demand trough.

This is also where the app surface earns its keep in the pacing plan. App re-engagement often carries the off-peak load: the abandoned-search and abandoned-cart pool keyed to property and route IDs is still warm even when prospecting demand has dried up, so deep-linked re-engagement keeps converting at a defensible CPB while broad prospecting would not. The pacing decision is therefore not just how much to spend, but what to spend it on as the curve falls.

:::predict
prompt: In a peak week, prospecting drives bookings at a $200 cost per booking. In an off-peak week, prospecting CPB degrades to $400 while retargeting holds at $100. If you shift $20,000 of off-peak spend from prospecting to retargeting, how many additional bookings do you get from that $20,000 versus leaving it in prospecting?
answer: 150
tolerance: 0
unit: bookings
hint: Compute bookings each way: $20,000 at $100 CPB versus $20,000 at $400 CPB, then take the difference.
explain: At a $100 retargeting CPB, $20,000 buys 200 bookings. At the degraded $400 off-peak prospecting CPB, the same $20,000 buys only 50 bookings. The shift nets 200 minus 50, or 150 additional bookings from the identical spend, which is why off-peak budget tilts to re-engagement.
:::

:::quiz
question: Why does off-peak budget in travel tilt toward retargeting and app re-engagement rather than prospecting?
- Prospecting is always cheaper per impression, so it should be paused entirely year-round.
- Near-buyers persist after broad demand fades, so re-engagement holds a far better cost per booking when prospecting CPB degrades.
- Retargeting is exempt from frequency caps, so it can absorb unlimited budget.
- App re-engagement is free because deep links do not cost media.
answer: 1
hint: Think about which audience is still in a booking window when prospecting demand has dried up.
explain: The reason is that the abandoned and past-booker pool stays warm after broad prospecting demand fades, so re-engagement keeps a defensible CPB while cold prospecting CPB inflates. The other options are false: prospecting is not pause-it-forever, retargeting still respects frequency caps, and deep-linked re-engagement absolutely costs media.
:::

# When pacing meets commitments and shocks

Pacing does not happen in a vacuum; it collides with the deal commitments from the inventory lesson and with external shocks. Programmatic-guaranteed (PG) inventory is reserved volume at a fixed price, which means if you over-commit on PG in peak-season optimism and demand then softens, you still owe the impressions and the pacing pain lands on you as make-goods or wasted delivery. The lesson from pacing is to size PG to the floor of expected demand and use flexible PMP and open-auction supply for the part of the curve you are unsure about.

External shocks make this worse. Weather, fuel-price swings, or an event cancellation can collapse demand mid-flight, and a rigid PG commitment cannot flex to meet it. This is the real-world tension the desk owns, and it is exactly the complaint operators raise.

:::callout warning
A recurring operator pain point: traders report budgets getting burned in slow months because automated pacing spreads spend evenly and ignores travel's booking-lead reality, and account ops complain that clients set annual budgets by travel season rather than booking season, then blame the desk when the peak booking weeks are underfunded. The fix is to weight the flight to booking-lead weeks up front and to size rigid PG commitments to the demand floor, not the optimistic peak, so a soft month does not become owed-impression dead weight.
:::

:::quiz
question: Why is over-committing on programmatic-guaranteed inventory a pacing risk against travel's demand curve?
- PG impressions are billed only when they convert, so unused volume is free.
- PG reserves fixed volume at a fixed price, so if demand softens mid-flight you still owe the impressions and cannot flex spend down.
- PG automatically reallocates to open auction when bookings stall.
- PG has no minimum and can be paused like an open-auction line at any time.
answer: 1
hint: The defining feature of PG is reserved volume at a fixed price, guaranteed by you.
explain: PG is a guaranteed commitment: you owe the reserved impressions at the agreed price regardless of whether the booking curve holds, so a demand collapse leaves you delivering (and paying for) volume that no longer converts. It is not pay-on-conversion, it does not self-reallocate, and it cannot be casually paused, which is why you size it to the demand floor and pace flexible supply on top.
:::

:::sources
- AppsFlyer, Travel app growth powered by AI and retargeting in 2025 | https://www.appsflyer.com/company/newsroom/pr/travel-app-growth-2025/
- AppsFlyer, Travel and Local App Attribution and Marketing Analytics | https://www.appsflyer.com/solutions/travel-local/
- Condor Ferries, Over 70+ Online Travel Booking Statistics 2025 | https://www.condorferries.co.uk/online-travel-booking-statistics
- calc4marketers, Average ROAS for Travel Advertising 2026 | https://www.calc4marketers.com/average-roas-travel
- Skift, RateGain to Buy Sojern in $250 Million Deal | https://skift.com/2025/10/02/rategain-to-buy-sojern-in-250-million-deal-expanding-its-marketing-reach/
- Hospitality Net, RateGain Consolidates MarTech Capabilities Under Sojern | https://www.hospitalitynet.org/news/4131164/rategain-consolidates-martech-capabilities-under-sojern-creating-the-worlds-largest-source-of-travel-intent-data
:::
