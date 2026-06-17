---
id: vertical-travel-09
track: vertical-travel
module: 9
title: Compliance and waste, drip-pricing rules, consent on intent data, rate-parity, and cross-surface suppression
summary: You will be able to enforce the travel-specific compliance the desk owns (all-in price display, consent on intent data, rate-parity co-op rules) and quantify and close the spend that leaks to already-booked travelers and broken cross-surface suppression.
---
# The compliance the desk actually owns

In Travel, the trader is not a passive media buyer who waits for Legal to wave a flag. Three rule sets land directly on the desk and break campaigns when ignored: price-display and drip-pricing rules (ads and landing pages must show the all-in price, not a bait fare that grows fees at checkout), GDPR and CCPA consent on intent data (travel audiences are built from sensitive search and booking signals, so consent state has to gate audience-building and retargeting), and rate-parity plus co-op brand-safety constraints (hotel and airline co-op dollars come with rules about where the ad runs and what price it shows). Get any of these wrong and you do not just risk a fine, you also tank conversion or lose the co-op funding that was paying for the line. This lesson treats compliance and waste together because in Travel they are the same money leaving the building: out-of-consent reach and bait-fare creative are both spend you cannot keep.

:::quiz
question: In Travel, how should the trader treat the three desk-owned rule sets (all-in price display, consent on intent data, rate-parity and co-op brand-safety)?
- As Legal's responsibility that sits upstream of the desk and never affects campaign performance
- As hard inputs to bid and audience setup, because breaking any one can void the spend or pull co-op funding on an otherwise well-bid line
- As optional best practices to apply only when a client specifically asks
- As pure brand concerns with no connection to wasted media dollars
answer: 1
hint: The lesson frames out-of-consent reach and bait-fare creative as the same thing: spend you cannot keep.
explain: These three rules land directly on the desk, not Legal, and each can void spend even when the bid, pacing, and deep link are perfect: a bait fare tanks conversion and risks enforcement, out-of-consent retargeting is a GDPR exposure, and breaking co-op rules forfeits the funding. Treating them as hard inputs is the same discipline as honoring a CPB target, because non-compliant reach is just spend you cannot keep.
:::

:::callout key
The three rules the trader owns in Travel are drip-pricing and all-in price display, consent on travel-intent data, and rate-parity and co-op brand-safety. None of these is optional or someone else's job. Each one can void the spend on a line that is otherwise perfectly bid and paced.
:::

# Drip-pricing and the all-in price rule

Drip-pricing is the practice of advertising a low headline fare and then adding mandatory fees (resort fees, carrier-imposed charges, baggage, service fees) on the path to checkout. US regulators have moved hard on this: the US Department of Transportation full-fare advertising rule requires airfare ads to show the total price including taxes and mandatory carrier charges, and the FTC junk-fee actions of 2024 to 2025 target hidden mandatory fees in hotels and short-term rentals. Operationally this means the price in your dynamic-retargeting creative and the price on the deep-linked landing item must match, all-in, or you have both a legal exposure and a conversion killer (a $99 hotel ad that becomes $148 at checkout abandons the near-buyer you paid to recover). The fix the desk controls is feed hygiene: the property or route price that populates DCO creative must be the all-in price, refreshed often enough that it still matches when the user clicks.

:::quiz
question: A hotel dynamic-retargeting ad shows "$99/night" but the deep-linked checkout adds a mandatory $49 resort fee, landing at $148 all-in. What is the trader's correct read?
- It is fine because the resort fee is disclosed at checkout
- It is both a price-display compliance exposure and a conversion killer, and the feed must show the all-in price
- It is purely a Legal problem with no effect on campaign performance
- It improves recovery rate because the headline price looks cheaper
answer: 1
hint: All-in price-display rules are actively enforced in travel, and a bait fare abandons the exact near-buyer you paid to recover.
explain: All-in price-display rules (DOT full-fare, FTC junk-fee actions) are actively enforced, so the mismatch is a real compliance exposure. It also kills conversion because the recovered near-buyer sees a price jump at checkout and abandons again. The desk owns the feed, so the answer is to populate DCO with the all-in price, not to hope disclosure at checkout covers it.
:::

# Consent gates the intent audience

Travel retargeting is built on exactly the data privacy regulators care about most: where a person searched to fly, which property they viewed, when they plan to travel. Under GDPR and CCPA (and CPRA), that intent data can only build an audience and drive retargeting when the user's consent state allows it, so consent is not a checkbox upstream of you, it is a filter on your addressable reach. Concretely, your consent-eligible reach is the consented slice of the total audience, and retargeting an out-of-consent EU user on travel-intent signals is a GDPR exposure even when the creative, the bid, and the deep link are all perfect. The trader has to know that the size of a travel-intent audience on paper is not the size you can legally activate, and plan reach and frequency against the consented number.

$$ \text{Consent-eligible reach} = \frac{\text{Consented audience}}{\text{Total audience}} $$

:::predict
prompt: A travel-intent retargeting pool holds 500,000 users, but only 320,000 have a consent state that permits intent-based retargeting. What is the consent-eligible reach, as a percent?
answer: 64
tolerance: 0.5
unit: %
hint: Divide the consented users by the total pool.
explain: 320,000 / 500,000 = 0.64, so consent-eligible reach is 64 percent. The other 36 percent (180,000 users) cannot legally be retargeted on travel-intent data, so the real addressable audience is 320,000, not the 500,000 the pool appears to offer.
:::

# Rate-parity and co-op brand-safety constraints

When a hotel chain or airline funds part of a campaign through co-op or brand dollars, that money arrives with strings: rate-parity rules (the price you advertise cannot undercut the brand's own published rate in ways the agreement forbids) and brand-safety and placement constraints (where the ad may run, which contexts are off-limits, what creative and price are allowed). The trader has to honor these or the co-op funding is pulled, which is its own kind of waste because the desk loses budget it had already planned around. The friction is real and practitioners feel it: the placement or price that would actually perform is sometimes exactly the one the co-op rule blocks, so part of the job is optimizing inside the constraint rather than around it. Treat the co-op terms as hard inputs to bid strategy and audience setup, the same way you treat a CPB target or a flight end date.

:::quiz
question: A hotel brand co-op funds 40 percent of a campaign on the condition that advertised rates honor rate-parity and ads avoid certain contexts. The single best-performing placement violates the brand-safety rule. What does the trader do?
- Run the placement anyway because performance is what matters
- Keep the placement but quietly lower the advertised rate below parity to compensate
- Honor the co-op constraints and optimize within them, since violating either rule risks losing the co-op funding
- Drop the entire campaign because the constraint makes it unwinnable
answer: 2
hint: Co-op dollars are budget you already planned around, and they disappear if the rules are broken.
explain: Co-op funding comes with rate-parity and brand-safety strings, and breaking either typically forfeits the funding, which is real budget loss. Lowering the rate below parity violates the other rule, and abandoning the campaign throws away usable budget. The practitioner-grade move is to treat the constraints as hard inputs and optimize the remaining placements and bids within them.
:::

# Where the money actually leaks

Beyond compliance, Travel quietly leaks roughly 5 to 10 percent of spend to three things: chasing travelers who already booked, serving stale abandoned-cart audiences whose intent has gone cold, and broken cross-surface suppression. Net working spend is gross spend minus the wasted spend and the non-compliant or blocked spend, and the single biggest recoverable piece is suppression. The leak exists because about 63 percent of bookings now complete on mobile devices while retargeting is often wired web-only, so a user who books in the app keeps seeing web ads for the trip they already bought (and vice versa). The waterfall below shows a representative breakdown of a gross budget into working spend versus the leaks, and the suppression slice is the one the trader can close fastest.

$$ \text{Net working spend} = \text{Gross spend} - (\text{Wasted spend} + \text{Non-compliant spend}) $$

:::figure discrepancyWaterfall
caption: A representative travel budget waterfall. Gross spend steps down through already-booked waste, stale-audience waste, and non-compliant or blocked spend to land on net working spend. Cross-surface suppression is the largest single recoverable step.
:::

:::predict
prompt: A travel campaign spends $500,000 gross. 8 percent leaks to already-booked and out-of-consent users. How many dollars is wasted?
answer: 40000
tolerance: 1
unit: USD
hint: Multiply the gross spend by the waste rate.
explain: $500,000 times 0.08 = $40,000 of wasted spend on already-booked or out-of-consent users. That $40,000 is the recovery target, and most of it is reachable by fixing suppression and consent gating rather than by buying anything new.
:::

# Cross-surface suppression is the biggest fix

Suppression leakage is the share of confirmed bookings that keep getting retargeted after the booking is confirmed, and in Travel it is usually caused by suppression being wired on only one surface. The fix is a booking-confirmation suppression feed that spans both surfaces: when a user books, whether in the app (attributed by the MMP) or on the web (the booking pixel or server-side import), that user is removed from retargeting on both surfaces, not just the one they booked on. This is the highest-leverage waste recovery the desk controls because the wasted impressions are not just inefficient, they are actively annoying a customer who already converted. Building cross-surface, post-booking suppression closes the leak that web-only or app-only suppression leaves wide open.

$$ \text{Suppression leakage} = \frac{\text{Bookings still retargeted after confirmation}}{\text{Total bookings}} $$

:::predict
prompt: Out of 2,000 confirmed bookings, 200 keep receiving retargeting after the booking confirmed. What is the suppression leakage rate?
answer: 10
tolerance: 0.5
unit: %
hint: Divide the still-retargeted bookings by total bookings.
explain: 200 / 2,000 = 0.10, a 10 percent suppression leakage rate. One in ten booked customers is still being chased with ads for a trip they already bought, which is both wasted spend and a bad post-purchase experience, and a cross-surface suppression feed is what drives this toward zero.
:::

:::predict
prompt: A campaign has 8,000 confirmed bookings paying an average $1,200, all retargeted at a frequency that costs about $0.90 per booked user per remaining week. Cross-surface suppression had been broken for 3 weeks, so every booked user was still being served. How many dollars were wasted retargeting already-booked travelers over those 3 weeks?
answer: 21600
tolerance: 50
unit: USD
hint: Wasted dollars = booked users times cost per user per week times the number of weeks. The $1,200 booking value is a distractor.
explain: 8,000 booked users times $0.90 per user per week times 3 weeks = $21,600 spent retargeting people who already booked. The $1,200 average booking value is irrelevant to the waste calculation, it only tells you these were valuable customers being annoyed. Closing cross-surface suppression recovers this entire amount in future weeks.
:::

:::callout warning
A real and recurring operator complaint: the desk keeps serving ads for hotels and flights people already booked because the booking-confirmation suppression feed is delayed or wired web-only, so app bookers never get suppressed on web (and the reverse). Practitioners also vent that co-op brand rules and rate-parity constraints block exactly the placements and prices that would perform best. Both are waste the trader owns: fix suppression to stop chasing booked travelers, and treat co-op rules as hard inputs rather than fighting them.
:::

# Putting compliance and waste on one scorecard

The graduate-level move is to report compliance and waste as one working-spend picture, not as separate afterthoughts. The chart below shows a representative split of a gross budget: the large majority is working spend, with thin slices lost to already-booked waste, stale-audience waste, and non-compliant or blocked spend. The trader's job is to push the working-spend slice up by closing the leaks the desk controls (cross-surface suppression first, then consent hygiene and feed accuracy) while honoring the rules that void spend if broken (all-in pricing, consent, rate-parity). When you can show a client that you grew net working spend from, say, 88 percent toward the mid-90s by fixing suppression and consent rather than by adding budget, you have demonstrated the part of the job that separates an operator from a button-pusher.

:::widget donutChart
title: Representative travel budget split, working spend vs leaks
labels: Working spend, Already-booked waste, Stale-audience waste, Non-compliant or blocked
data: 88, 5, 4, 3
unit: %
:::

:::quiz
question: A trader wants to raise net working spend without increasing the budget. Which single action recovers the most leaked spend in a typical travel campaign?
- Lowering the open-exchange bid floor
- Fixing cross-surface, post-booking suppression so app bookers are removed from web retargeting and vice versa
- Increasing frequency caps on prospecting
- Switching all inventory to programmatic guaranteed
answer: 1
hint: The biggest single leak in travel comes from one surface not knowing the user booked on the other.
explain: Cross-surface suppression is the largest single recoverable leak because roughly 63 percent of bookings are on mobile devices while retargeting is often web-only, so booked travelers keep getting chased on the other surface. Lowering floors or raising frequency does not address already-booked waste, and forcing all inventory to PG raises cost rather than recovering leaked spend.
:::

:::sources
- US Department of Transportation, Full-Fare Advertising Rule (airfare price advertising) | https://www.transportation.gov/individuals/aviation-consumer-protection/price-advertising
- Federal Trade Commission, Rule on Unfair or Deceptive Fees (junk-fee / drip-pricing enforcement 2024-2025) | https://www.ftc.gov/legal-library/browse/rules/rule-unfair-or-deceptive-fees
- AppsFlyer, Travel app marketing trends in 2025: Retargeting leads the way (75% of conversions from re-engaged users) | https://www.appsflyer.com/blog/mobile-marketing/travel-app-marketing-trends/
- Business of Apps, Booking Revenue and Usage Statistics 2026 (mobile ~63% of online travel bookings, mobile web and apps combined) | https://www.businessofapps.com/data/booking-statistics/
- Adjust, AdAttributionKit vs SKAdNetwork (re-engagement and deep-link signal on iOS) | https://www.adjust.com/blog/adattributionkit/
- AppsFlyer, Travel and Local App Attribution and Marketing Analytics (OTA/airline/hotel MMP measurement) | https://www.appsflyer.com/solutions/travel-local/
- Hospitality Net, RateGain Consolidates MarTech Capabilities Under Sojern (travel-intent data scale) | https://www.hospitalitynet.org/news/4131164/rategain-consolidates-martech-capabilities-under-sojern-creating-the-worlds-largest-source-of-travel-intent-data
:::
