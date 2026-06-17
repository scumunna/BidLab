---
id: vertical-travel-07
track: vertical-travel
module: 7
title: Channels and Formats, Dynamic Retargeting, Metasearch, App-Install, and Deep-Linked Re-Engagement
summary: Build a booking-driven channel mix that judges app-install on cost-per-in-app-booking, deep-links near-buyers to the exact property or route, and treats metasearch as its own auction.
---
# What each channel is actually for

A travel plan is not one channel with one job. It is four jobs, and the trader who blurs them burns budget. Prospecting display, CTV, and social create demand and feed the DMO visitation story; metasearch (Google Hotel Ads, Trivago, Kayak via Koddi) catches users already comparing price; dynamic abandoned-search retargeting recovers the enormous near-buyer pool; and the mobile-app channel splits again into app-install (user acquisition) and app re-engagement (deep-linking an existing app user back to the item they abandoned). Each channel has its own KPI, its own bid logic, and its own economics, so the first skill is naming what a line item is for before you ask whether it is working.

The reason this matters in Travel specifically is the funnel shape from earlier modules: roughly 81.7% of carts are abandoned and look-to-book runs 50:1 or worse, so the largest addressable pool is people who already raised their hand and walked. Retargeting and re-engagement are not a supplement to the plan; in Travel they are the plan's efficiency engine, delivering 3 to 4 times the ROAS of prospecting.

:::predict
prompt: A travel client sends 50,000 sessions to the booking cart in a week. At Travel's roughly 81.7% cart-abandonment rate, how many of those sessions abandon and become the near-buyer pool that retargeting and re-engagement exist to recover?
answer: 40850
tolerance: 50
unit:
hint: Multiply the sessions by the abandonment rate.
explain: 50,000 times 0.817 equals 40,850 abandoned sessions. That huge walked-away pool, not the fresh-demand top of the funnel, is why the channel mix is built around recovery: dynamic retargeting and deep-linked app re-engagement go after these near-buyers one itinerary at a time.
:::

:::callout key
The channel mix in Travel is built around recovery, not discovery. Prospecting fills the top, but the dynamic retargeting and deep-linked app re-engagement lines are where a booking-driven plan earns its CPB, because the near-buyer pool dwarfs the fresh-demand pool.
:::

# Dynamic abandoned-search retargeting

The highest-leverage tactic in Travel is dynamic creative optimization (DCO) keyed to property or route IDs. The ad does not say "book your next trip"; it renders the exact hotel the user viewed, with live price and scarcity ("2 rooms left at this rate"), pulled from a product feed at impression time. This is what separates a travel retargeting line from generic e-commerce retargeting: the unit of recovery is a specific itinerary, not a category.

The metric that governs this line is the retargeting recovery rate, defined as recovered bookings over abandoned sessions retargeted.

$$ \text{Retargeting recovery rate} = \frac{\text{Recovered bookings}}{\text{Abandoned sessions retargeted}} $$

Two operational rules from the funnel module carry forward here. The trigger should fire on a 2 to 4 hour delay, not in minutes, because travel intent stays warm and a minutes-later ad just annoys a still-shopping user. And the click must deep-link to the precise property or route, not a homepage, or the recovery rate collapses.

:::predict
prompt: A dynamic retargeting line reaches 60,000 abandoned sessions and recovers 3,000 confirmed bookings. What is the retargeting recovery rate?
answer: 5
tolerance: 0.25
unit: %
hint: Divide recovered bookings by abandoned sessions retargeted.
explain: 3,000 / 60,000 = 0.05, a 5 percent recovery rate. In a funnel where 80 to 89 percent of carts are abandoned, even a single-digit recovery rate on a huge abandoner pool is the plan's most efficient source of bookings.
:::

# Metasearch is its own auction

Metasearch is not RTB display and must never be paced like it. On Google Hotel Ads, Trivago, and Kayak, you bid (often via Koddi) on a CPC or commission basis to appear in the price-comparison unit, and the user clicks through to your booking engine. The economics behave like search, not like a CPM impression buy, so it needs its own bid strategy, its own budget, and its own targets rather than being folded into the RTB playbook.

The right KPI for any booking channel, metasearch included, is cost per booking, computed for that channel in isolation.

$$ \text{Channel CPB} = \frac{\text{Channel media spend}}{\text{Channel confirmed bookings}} $$

The payoff is real: metasearch CAC commonly lands at 8 to 14 percent of booking value, far below OTA loaded commissions of 28 to 42 percent, which is exactly why direct-booking hotels lean on it. Case data cited by AppsFlyer (Plaza La Reina) showed 8x ROI on metasearch and 24x on retargeting within three months, a useful reminder that recovery channels and metasearch, not prospecting, carry travel efficiency.

:::quiz
question: Why can a metasearch line not be paced and bid like an open-exchange RTB display line?
- Metasearch only runs on connected TV inventory
- Metasearch uses a CPC or commission auction that behaves like search, not a CPM impression buy
- Metasearch has no measurable conversion event
- Metasearch is bought only as programmatic guaranteed
answer: 1
hint: Think about what you are actually paying for on Google Hotel Ads or Trivago.
explain: Metasearch transacts on a CPC or commission basis in a price-comparison auction, so its bid logic, budget, and targets are search-like, not the CPM pacing used for RTB display. Treating it as RTB is a classic mistake.
:::

# App-install: judge the booking, not the install

Roughly 63 percent of online travel bookings now complete in mobile apps, so the app channel is primary, not optional. App-install (user acquisition) buys a new app user, but an install is only a mid-funnel cost that pays off later, on the in-app booking. The fatal error is optimizing to cost-per-install, which rewards cheap junk installs that never book. The correct KPI is cost per in-app booking.

$$ \text{Cost per in-app booking} = \frac{\text{App media spend}}{\text{In-app bookings}} $$

Crucially, this number is measured by a Mobile Measurement Partner (AppsFlyer, Adjust, or Branch), not by the web booking pixel, so the app CPB and the web CPB are different economics that must be reported separately rather than averaged blindly. A second diagnostic, install-to-booking rate, tells you whether the installs you bought are real travelers or volume padding.

$$ \text{Install-to-booking rate} = \frac{\text{In-app bookings}}{\text{App installs}} $$

:::predict
prompt: An app-install campaign spends $30,000 and yields 200 in-app bookings (measured by the MMP). What is the cost per in-app booking?
answer: 150
tolerance: 1
unit: USD per booking
hint: Divide app media spend by in-app bookings, not by installs.
explain: $30,000 / 200 = $150 per in-app booking. If you had instead divided by, say, 6,000 installs you would report a flattering $5 cost-per-install that hides whether any of those users actually booked.
:::

:::predict
prompt: The same campaign drove 20,000 app installs and those installs produced 1,000 in-app bookings over the attribution window. What is the install-to-booking rate?
answer: 5
tolerance: 0.25
unit: %
hint: Divide in-app bookings by app installs.
explain: 1,000 / 20,000 = 0.05, a 5 percent install-to-booking rate. A line with cheap installs but a near-zero install-to-booking rate is buying junk; the booking rate is what protects you from optimizing to the wrong number.
:::

# Deep-linking is the connective tissue

Deep-linking is what makes every recovery play work. An abandoned-search retargeting ad must drop the near-buyer onto the exact property or route inside the app (or on web), because "the same itinerary with an updated price and a frictionless deep link" is what converts travel's massive near-buyer pool. A retargeting ad that deep-links to a generic homepage instead of the viewed item kills the recovery rate, and a broken or missing deep link is a silent conversion killer with no obvious cause in the dashboard.

On iOS this is where measurement breaks. SKAdNetwork does not support deep linking or re-engagement attribution and collapses the post-install window, so an in-app booking days after a re-engagement tap often never ties back to the ad. AdAttributionKit restores configurable re-engagement windows and retains the deep-link source signal, and owned channels (email or SMS keyed to hashed email or phone) are the other way app re-engagement stays measurable. This is why roughly 75 percent of 2025 travel app conversions came from re-engaged users: the near-buyer who already installed the app is the cheapest booking you can recover, if the deep link and its attribution survive.

:::figure lookToBookFunnel
caption: Travel's funnel is brutally leaky (look-to-book 50:1 or worse, 80 to 89 percent cart abandonment), so the near-buyer pool at the bottom is enormous. Dynamic retargeting and deep-linked app re-engagement exist to recover that pool one specific itinerary at a time.
:::

:::quiz
question: An iOS app re-engagement line shows almost no attributed bookings even though deep-linked taps are high. What is the most likely cause before you cut the line?
- The deep links are pointing to the correct property pages
- SKAdNetwork cannot carry deep-link re-engagement and collapses the post-install window, so late in-app bookings go uncredited
- Metasearch is stealing the conversions
- The MMP only measures web bookings
answer: 1
hint: Think about what SKAN can and cannot represent for an existing app user.
explain: SKAN does not support deep-link or re-engagement attribution and truncates the window, so in-app bookings that occur after the postback fires are under-credited. AdAttributionKit or owned-channel deep links are the fix, not killing a line that may be working.
:::

# Putting the channel mix together

The trader's job is to assemble these channels into one plan and read a blended channel CPB across them, while never losing the per-channel and per-surface splits underneath. Prospecting and DMO upper-funnel work fills demand; metasearch catches active comparers on its own auction; dynamic retargeting and deep-linked app re-engagement recover the near-buyer pool; and the app lines are judged on cost-per-in-app-booking, reported separately from web.

$$ \text{Blended channel CPB} = \frac{\text{Total channel spend}}{\text{Total channel bookings}} $$

The ROAS profile makes the priority obvious. On a last-click basis (and module 8 will show how much of this is overstated), retargeting runs about 4x, app re-engagement about 4.5x, and metasearch about 5x, all above prospecting's roughly 3.6x. Recovery and metasearch earn the efficiency; prospecting earns the demand they recover.

:::widget barChart
title: Travel channel ROAS by type (last-click basis, 2025-2026)
labels: Prospecting, Metasearch, Retargeting, App re-engage
data: 3.6, 5, 4, 4.5
unit: x ROAS
:::

:::predict
prompt: A plan runs two booking channels. Retargeting spends $200,000 and drives 2,000 bookings; prospecting spends $250,000 and drives 1,000 bookings. What is the blended channel CPB across the two?
answer: 150
tolerance: 1
unit: USD per booking
hint: Add both spends, add both booking counts, then divide.
explain: ($200,000 + $250,000) / (2,000 + 1,000) = $450,000 / 3,000 = $150 per booking. Note the blend hides that retargeting is $100 per booking while prospecting is $250, which is exactly why you keep the per-channel split.
:::

:::callout warning
Operators on Reddit repeatedly vent that a broken or missing deep link sends retargeted near-buyers to a homepage and conversion craters with no obvious cause, while app marketers complain cheap installs inflate volume metrics as in-app bookings stay flat, masking wasted UA spend. Both failures share one root: judging the channel by the wrong event (the click or the install) instead of the in-app booking and the item-level deep link. Audit the deep-link destination and tie every app line to cost-per-in-app-booking before you trust the dashboard.
:::

:::sources
- AppsFlyer, Travel app marketing trends in 2025: Retargeting leads the way | https://www.appsflyer.com/blog/mobile-marketing/travel-app-marketing-trends/
- AppsFlyer, Travel and Local App Attribution and Marketing Analytics | https://www.appsflyer.com/solutions/travel-local/
- Adjust, AdAttributionKit vs. SKAdNetwork: What's the difference | https://www.adjust.com/blog/adattributionkit/
- Condor Ferries, Over 70+ Online Travel Booking Statistics 2025 | https://www.condorferries.co.uk/online-travel-booking-statistics
- calc4marketers, Average ROAS for Travel Advertising 2026 | https://www.calc4marketers.com/average-roas-travel
- Skift, RateGain to Buy Sojern in $250 Million Deal | https://skift.com/2025/10/02/rategain-to-buy-sojern-in-250-million-deal-expanding-its-marketing-reach/
:::
