---
id: vertical-travel-03
track: vertical-travel
module: 3
title: The conversion and the funnel, look-to-book, cart abandonment, and the 45-day window
summary: Define the only event that counts in Travel, a net confirmed booking, then size the leaky funnel and tune your attribution window, frequency caps, and abandoned-search recovery to a 45-day journey that splits across web and app.
---
# What actually counts as a conversion

In Travel the conversion is a confirmed, paid booking, net of cancellations, and nothing else. A search is not a booking, a click is not a booking, and an added cart is not a booking, so a desk that optimizes to clicks or sessions is optimizing to noise. The signature KPI hangs off that definition: Cost per booking is media spend divided by net confirmed bookings, and if you count gross bookings the number is fiction the moment cancellations land.

$$ \text{CPB} = \frac{\text{media spend}}{\text{net confirmed bookings}} $$

The practical consequence is that your conversion event must be the booking-confirmation signal (web pixel or app event), deduplicated on a transaction ID and reduced by cancellations, not the cart or the checkout-start.

:::quiz
question: In a Travel campaign, which event should the trader set as the optimization conversion?
- A flight or hotel search
- An item added to the booking cart
- A net confirmed, paid booking (post-cancellation)
- A click on the ad
answer: 2
hint: Only one of these survives a cancellation and represents revenue.
explain: The conversion is the net confirmed, paid booking. Searches, cart-adds, and clicks are mid-funnel proxies that wildly overstate intent in Travel, and gross bookings overstate the count until cancellations are netted out.
:::

# The leakiest funnel in e-commerce

Travel has the worst cart abandonment of any e-commerce category. SaleCycle, tracking more than 280 million online bookings, puts the overall travel rate near 81.7%, with OTAs near 89%, airlines near 87.8%, and hotels in the 80% to 87% band. At the overall 81.7% rate, for every 100 people who start a booking about 18 finish; in the worst segments it is far tighter, with the OTA rate near 89% leaving about 11 finishers per 100 and the airline rate near 87.8% leaving about 12. Either way, the rest are a recoverable pool the desk can re-engage. Cart abandonment is one minus the completion rate of started booking sessions.

$$ \text{abandonment} = 1 - \frac{\text{completed bookings}}{\text{booking sessions started}} $$

:::figure lookToBookFunnel
caption: The Travel funnel collapses from search to confirmed booking. Look-to-book runs from roughly 50:1 on a site to 1,500:1 on airline search, and the abandoned middle is the trader's highest-leverage recovery pool.
:::

:::predict
prompt: An OTA records 50,000 started booking sessions and completes 5,500 of them. What is the cart abandonment rate?
answer: 89
tolerance: 0.5
unit: %
hint: Abandonment is one minus completed divided by started.
explain: 5,500 / 50,000 = 0.11 completion, so abandonment is 1 - 0.11 = 0.89, or 89 percent, right in line with the OTA benchmark.
:::

# Look-to-book is brutal, and it sets the bid

Look-to-book is searches (or sessions) divided by confirmed bookings, and in Travel it ranges from about 50:1 on a typical site to as high as 1,500:1 on airline metasearch and search. That ratio is why a great CPC or CPM can still produce a terrible CPB: cheap mid-funnel actions mean nothing if 1,499 of every 1,500 searchers never book. The trader who quotes a healthy click cost while the booking cost quietly balloons is the classic Travel failure mode.

$$ \text{look-to-book} = \frac{\text{searches or sessions}}{\text{confirmed bookings}} $$

:::predict
prompt: An airline metasearch line generates 1,500,000 searches and 1,000 confirmed bookings. What is the look-to-book ratio, expressed as searches per booking?
answer: 1500
tolerance: 5
unit: searches per booking
hint: Divide searches by confirmed bookings.
explain: 1,500,000 / 1,000 = 1,500, so the ratio is 1,500:1. At that dilution, optimizing to clicks instead of bookings is how a desk burns a budget and reports a great CPC alongside an awful CPB.
:::

:::callout key
A low CPC or CPM is not a win in Travel. Because look-to-book runs from 50:1 to 1,500:1, the only honest scoreboard is Cost per booking. Always carry the booking conversion through to the bid, never stop at a mid-funnel proxy.
:::

# The 45-day window changes everything

The average Travel consideration window is about 45 days: Expedia Group's path-to-purchase research finds travelers consume roughly 303 minutes of content (about 141 pages) across channels in the 45 days before a booking. That single fact resets the whole measurement and cadence design: your attribution window, frequency caps, and retargeting cadence must be tuned to weeks, not the 30 to 60 minutes a retail desk uses. A booking that completes 30 to 45 days after the first impression is invisible to a 7-day click window, so a channel that is actually profitable looks dead unless the window is extended.

Concretely, if you re-engage a near-buyer with one touch every three days across a 45-day window, you plan for $45 / 3 = 15$ touches, which is a frequency budget, not a one-day burst.

:::predict
prompt: You set a 45-day attribution and retargeting window and cap dynamic retargeting at one touch every 3 days. How many touches does that frequency plan allow across the full window?
answer: 15
tolerance: 0
unit: touches
hint: Divide the window length by the days between touches.
explain: 45 days / 3 days per touch = 15 touches. Travel's slow deliberation rewards a paced cadence across weeks, not the minutes-scale frequency a retail recovery flow would use.
:::

:::quiz
question: Why does a 7-day click attribution window systematically understate a Travel channel's performance?
- Because Travel users click more than once
- Because the average booking completes around 45 days after first exposure, outside a 7-day window
- Because click windows ignore impressions entirely
- Because 7-day windows double-count bookings
answer: 1
hint: Compare the window length to Travel's consideration cycle.
explain: With a ~45-day consideration window, most bookings land well after 7 days. A short click window credits almost none of them, so a profitable channel reads as unprofitable until the window is stretched to match the journey.
:::

# Abandoned-search recovery is the highest-leverage play

Because the abandoned middle is so large, abandoned-search and abandoned-cart recovery keyed to the exact property or route ID is the single highest-leverage tactic in Travel. Recoverable demand is the abandoned pool times the recovery rate, and the trigger delay should be 2 to 4 hours, not minutes, because intent stays warm while the traveler deliberates and a minutes-fast ad just annoys someone still shopping. The recovery economics fold straight into CPB: spend on the recovery line divided by the bookings it recovers is the line's cost per booking.

$$ \text{recoverable demand} = \text{abandoned sessions} \times \text{recovery rate} $$

:::widget barChart
title: Travel cart abandonment by segment
labels: Overall, OTA, Airline, Hotel
data: 81.7, 89, 87.8, 84
unit: %
:::

:::predict
prompt: A recovery line retargets 60,000 abandoned sessions at a 5% recovery rate and spends $48,000. What is its cost per booking?
answer: 16
tolerance: 0.5
unit: USD per booking
hint: First find recovered bookings (sessions times recovery rate), then divide spend by that.
explain: Recovered bookings are 60,000 x 0.05 = 3,000, so CPB is $48,000 / 3,000 = $16 per booking. Recovery lines post the lowest CPB in a Travel plan because they re-engage near-buyers who already showed item-level intent, which is why they are the efficiency engine of the funnel.
:::

# Two funnels, web and app, and iOS truncates one

A first-order complication: the abandoned booker may be a web session or an app session, and the two funnels do not measure the same way. Mobile is about 63% of online travel bookings in 2025, yet mobile completes at roughly 0.7% versus desktop near 2.4%, so the app surface holds an enormous mid-funnel abandonment pool that is recovered by deep-linking the near-buyer back into the exact item inside the app. On iOS the app path also loses signal because SKAdNetwork collapses postbacks into a short, coarse window that cannot represent a 45-day journey, while AdAttributionKit partially restores longer re-engagement windows. Effective attribution coverage is the conversions credited within the window divided by all true conversions, and it drops sharply once SKAN truncates the window.

$$ \text{attribution coverage} = \frac{\text{conversions credited in window}}{\text{all true conversions}} $$

:::callout warning
A recurring operator complaint on Reddit and practitioner forums: the web booking engine and the app MMP never reconcile, so the same booking is double-counted or under-counted, and Google, Meta, the DSP, and the OTA app each claim it, leaving true CPB un-auditable. On iOS an in-app booking days after install often never ties back to the ad because the SKAN postback already fired and collapsed, so app booking CPB looks worse than reality. Do not force one blended number; report web-pixel and MMP bookings as two reconciled sources and explain the gap.
:::

:::predict
prompt: Mobile drives 10,000 booking sessions at a 0.7% completion rate; desktop drives 10,000 at 2.4%. How many more bookings does desktop complete than mobile on equal sessions?
answer: 170
tolerance: 1
unit: bookings
hint: Compute each completed-booking count, then subtract.
explain: Desktop completes 10,000 x 0.024 = 240; mobile completes 10,000 x 0.007 = 70. The gap is 240 - 70 = 170 bookings, which is the mid-funnel app pool deep-linking and in-app re-engagement exist to recover, not a reason to abandon the app surface that carries ~63 percent of bookings.
:::

:::sources
- SaleCycle, Global Cart Abandonment Statistics (travel ~81% overall; airline 87.87%; OTA ~89%; hotel ~84%; from 280M+ tracked bookings) | https://www.salecycle.com/airline-case-study-download
- Amadeus / SaleCycle, Converting abandoned bookings in the airline business (travel abandonment 81.3%, airline 87.8%) | https://amadeus.com/en/blog/articles/converting-abandoned-bookings-airlines-salecycle
- Expedia Group (with Luth Research), Understanding the Traveler Path to Purchase (303 minutes of content across 141 pages in the 45 days before booking) | https://partner.expediagroup.com/en-us/resources/blog/path-to-purchase-insights
- Netacea, Look-to-Book Ratio (typical ~50:1 worked example for a travel site) | https://netacea.com/learn/look-to-book-ratio/
- TPConnects, Solving the look-to-book challenge in the airline industry (airline and metasearch ratios into the thousands-to-1 and beyond) | https://tpconnects.com/resources/look-to-book-challenge-airline-industry
- Perk, 70+ Online Travel Booking Statistics and Trends 2025 (mobile ~63% of online travel bookings) | https://www.perk.com/blog/online-travel-booking-statistics/
- AppsFlyer, AdAttributionKit explained: what it is and how it differs from SKAdNetwork | https://www.appsflyer.com/glossary/adattributionkit/
- AppsFlyer, Travel and Local app attribution and marketing analytics | https://www.appsflyer.com/solutions/travel-local/
:::
