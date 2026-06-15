---
id: vertical-travel
track: travel
module: 1
title: Travel: the booking is the only conversion that pays
summary: How cost per booking, look-to-book, a trip-value bid ceiling, and saved OTA commission reframe travel ROAS.
---
# Travel media buys against a high-AOV booking

Travel is a high average-order-value business with a long, non-linear consideration path. A flight or a multi-night hotel stay can be hundreds or thousands of dollars, but a shopper may research for weeks across many sessions before a single booking lands. That shape makes the booking, not the click or the session, the only conversion that pays.

The money is moving. US travel media network ad spend reached about $2.13B in 2025 and is forecast at roughly $2.96B in 2026, growth of about 29.1% (eMarketer). That figure is the first-party retail-media slice (United Kinective, Expedia, Marriott, Uber), not total travel digital spend. United Kinective Media, the first airline media network, reported about $110M in new ad revenue in its first year. Travel was one of the slowest-growing verticals in 2025 under economic and tariff headwinds, so efficiency matters more than ever.

:::widget lineChart
title: US travel media network ad spend ($B, eMarketer, illustrative path)
labels: 2024, 2025, 2026
data: 1.65, 2.13, 2.96
unit: $
:::

# Look-to-book and cost per booking

The signature funnel metric is look-to-book, the ratio of sessions to bookings. Its inverse is booking conversion rate. Travel funnels leak badly. Average cart abandonment runs around 81%, and for online travel agencies (OTAs) it can reach 94%. A booking conversion rate above 2% puts you in the top 20% of sites, and 3 to 4% is top 10% territory.

$$ Look\text{-}to\text{-}Book = \frac{Sessions}{Bookings} $$

$$ Cost\ per\ Booking = \frac{Spend}{Bookings} $$

Cost per booking is the operating dial. Because a booking is worth so much, the allowable cost per booking is far higher than a retail CPA, but it is still bounded by trip economics, which we get to next.

:::predict
prompt: A hotel site drives 60,000 sessions and 1,500 bookings in a month. What is its look-to-book ratio?
answer: 40
hint: Look-to-book is sessions divided by bookings.
explain: Look-to-book = 60,000 / 1,500 = 40 sessions per booking, a 2.5% booking conversion rate.
:::

:::predict
prompt: A campaign spends $90,000 and produces 1,800 bookings. What is the cost per booking?
answer: 50
unit: $
hint: Cost per booking is spend divided by bookings.
explain: Cost per booking = $90,000 / 1,800 = $50 per booking.
:::

# The dynamic bid ceiling: AOV times margin times efficiency

You cannot bid a flat CPA in travel because trip value swings wildly. A $200 domestic hop and a $4,000 international business fare cannot share one ceiling. Instead you set a dynamic max cost per booking from trip value: average order value times margin times a target efficiency factor.

$$ Max\ CPA = AOV \times margin \times efficiency $$

A $1,200 flight at an 8% margin with a 0.5 efficiency target gives a ceiling of $1,200 x 0.08 x 0.5 = $48. Anything above that and the booking loses money at your efficiency bar. The margin is thin on flights and fatter on hotels and packages, so the same shopper can carry very different ceilings depending on what they book.

:::callout key
The trip-value bid ceiling is why travel bidding is dynamic, not flat. A flat CPA either overpays for cheap trips or starves bidding on expensive, high-margin ones. Bid the trip, not the average.
:::

:::predict
prompt: A package has an AOV of $2,000, a 10% margin, and you target a 0.4 efficiency factor. What is the maximum allowable cost per booking?
answer: 80
unit: $
hint: Multiply AOV by margin by the efficiency factor.
explain: Max CPA = $2,000 x 0.10 x 0.4 = $80 per booking.
:::

# Abandonment retargeting against the 80% pool

With abandonment near 80% on most travel sites and up to 94% on OTAs, the largest reservoir of demand is people who already searched dates, picked a property, and walked away. Retargeting that warm pool typically returns about 3 to 4 times the ROAS of cold prospecting (directional), because intent is already established. The math of standing up an abandonment program is simply applying your booking conversion rate and cost per booking to a much higher-intent audience. An abandonment pool of 50,000 users converting at a 3% booking rate yields 1,500 bookings, and at a 3.5x ROAS uplift those bookings carry far more efficient economics than cold prospecting.

:::widget reachFrequency
:::

# Adding back saved OTA commission

Direct-booking ROAS is structurally understated. Every direct booking avoids the 15 to 25% commission you would have paid an OTA on that same stay. That saved commission is real margin the direct channel creates, so a fair comparison adds it back. Suppose a direct booking has an AOV of $1,150 and the OTA commission you avoided is 18%. The saved commission is $1,150 x 0.18 = $207 of value the attributed ROAS never counted.

$$ Margin\text{-}adjusted\ ROAS = \frac{(AOV \times bookings) + (commission \times AOV \times bookings)}{Spend} $$

When you compare channels, also remember the attribution caveat. Blended travel ROAS sits around 4.0x, but reported spreads run from roughly 3.6x on Meta to 5.0x on Google Search, and up to a quoted 19:1 depending on attribution method. Treat that spread as an attribution lesson, not a single truth. The honest comparison values direct bookings at their margin-adjusted return.

:::predict
prompt: A direct booking has an AOV of $1,150 and avoids an 18% OTA commission. How many dollars of saved commission does that booking add back?
answer: 207
unit: $
hint: Multiply AOV by the commission percentage.
explain: Saved commission = $1,150 x 0.18 = $207 of margin the attributed ROAS did not credit.
:::

:::quiz
question: Two channels report the same attributed ROAS, but one drives direct bookings and the other drives OTA-routed bookings. Why might the direct channel be more valuable than the equal ROAS suggests?
- Each direct booking saves the 15 to 25% OTA commission, which adds margin the attributed ROAS does not count
- Direct bookings always have a higher AOV than OTA bookings
- OTA bookings cannot be tracked, so their ROAS is fabricated
- Attributed ROAS already includes saved commission by default
hint: Think about what a direct booking avoids paying that an OTA-routed booking does not.
answer: 0
explain: A direct booking avoids the OTA commission of 15 to 25%, so its margin-adjusted return is higher than the attributed ROAS at the same headline number.
:::

:::sources
- Travel Media Network Ad Spend, eMarketer | https://www.emarketer.com/content/travel-media-network-ad-spend
- Travel ROAS and Seasonality Benchmarks 2026, Propellic | https://www.propellic.com/
:::
