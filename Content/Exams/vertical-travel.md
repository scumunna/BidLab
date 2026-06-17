---
track: vertical-travel
title: Travel Programmatic Certification
pass: 0.7
draw: 12
---
:::q Market & Money Map
question: A CMO points out that travel is a small ad category (about $9.86B US total media in 2024) and asks why your desk still buys it almost entirely programmatically through curated deals rather than spray-and-pray open auction. What is the best answer?
- Programmatic is mandatory for any category under $10B in total media spend
- High-AOV, intent-rich purchases mean each media dollar chases a far larger conversion, so data-driven deals that target verified travel intent pay off
- Open auction is unavailable for travel inventory in the major DSPs
- Small categories always clear at lower CPMs, so programmatic is simply the cheapest option
answer: 1
explain: Travel is small in total dollars but intent-dense and high-AOV, so the same media dollar chases a much larger conversion, which is why the buying surface is dominated by data-driven deals rather than blind open auction.
:::

:::q Market & Money Map
question: You spend $50,000 on open exchange for 10,000,000 impressions and $50,000 on a travel-intent PMP for 5,000,000 impressions. The client asks for your "average CPM." What blended CPM do you report, and what does it conceal?
- $5.00, and it conceals that the open line cleared near $3.33 while the PMP cleared near $10.00
- $6.67, and it conceals that both lines cleared at exactly $6.67
- $6.67, and it conceals that the open line cleared near $5.00 while the PMP cleared near $10.00
- $7.50, and it conceals that the PMP cleared below the open line
answer: 2
explain: Blended CPM is $100,000 / 15,000,000 x 1000 = $6.67. The open line alone was $50,000 / 10,000,000 x 1000 = $5.00 and the PMP was $50,000 / 5,000,000 x 1000 = $10.00, so the blend hides that you paid a premium for the booking-measurable half.
:::

:::q Market & Money Map
question: An independent hotel can only afford open-exchange display and asks you to optimize the buy to confirmed bookings. What is the central measurement limitation you must flag before they set that expectation?
- Open-exchange CPMs are higher than a PMP, so the budget will not stretch
- Open exchange does not support dynamic creative, so retargeting is impossible
- Metasearch and open exchange share one reconciled report, so numbers will conflict
- The booking happens off-network and open exchange cannot confirm it deterministically, so the booking signal is effectively invisible and you optimize to proxies
answer: 3
explain: Open exchange is the cheap, blind surface where the booking completes off-network and cannot be confirmed deterministically, so the booking signal is invisible and you are forced to optimize to mid-funnel proxies rather than bookings.
:::

:::q Market & Money Map
question: A client compares your DV360 display report against an Expedia Group TMN report and a Google Hotel Ads metasearch report, and is furious the booking counts do not tie out. What is the correct way to frame this?
- Force all three into one number by trusting the DSP report, since it is the system of record
- Treat TMNs and metasearch as walled gardens with their own reporting that will not reconcile to the DSP, maintain two to three sources of truth, and explain the gap rather than forcing one figure
- Drop the TMN and metasearch lines because their reporting cannot be trusted
- Average the three booking counts to produce a single reconciled total
answer: 1
explain: TMNs and metasearch are closed reporting environments (walled gardens) whose numbers will not reconcile to the DSP, so the trader maintains multiple reconciled sources of truth and explains the gap instead of forcing one number.
:::

:::q Buyer Mandate & Cost-Per-Booking KPI
question: A state tourism board (DMO) hires you to "get more people to visit the state." Which primary success metric is correct for this client, and why?
- Cost per confirmed booking pulled from the booking engine, because every travel client is judged on CPB
- Incremental arrivals or visitation lift measured by a location or holdout study, because a DMO is a demand-shaper with no booking pixel of its own
- Add-to-cart rate on the booking funnel, because it is the closest mid-funnel proxy to a booking
- Cost per click on the display creative, because clicks are the only thing a DMO can measure
answer: 1
explain: A DMO is a demand-shaper that owns no booking confirmation, so success is arrivals or visitation lift measured by a location or incrementality study. CPB, add-to-cart, and CPC all assume a transaction the DMO never sees.
:::

:::q Buyer Mandate & Cost-Per-Booking KPI
question: A hotel program reports 300 gross bookings on $43,200 of spend and a glowing last-click ROAS, but 10% of those bookings later cancel. What is the honest net cost per booking the client should be judged on?
- $144, using all 300 gross bookings
- $130, after applying a volume discount for the cancellations
- $160, using the 270 net bookings that survive cancellation
- $432, because cancellations triple the effective cost
answer: 2
explain: Net bookings are 300 x (1 - 0.10) = 270, so net CPB is $43,200 / 270 = $160, versus the flattering $144 gross. A booking must be defined net of cancellations up front or the CPB is fiction once cancellations post.
:::

:::q Buyer Mandate & Cost-Per-Booking KPI
question: A CMO says only "drive direct bookings" and the OTA you would displace charges a 25% loaded commission on a property with a $1,000 ADR. Which direct CPB target is defensible as a starting bid ceiling?
- $300 per booking, because higher bids win more auctions
- Any CPB, because direct is always cheaper than an OTA
- $0 per booking, because direct bookings should cost nothing
- $250 per booking, the break-even against the OTA's loaded take
answer: 3
explain: The direct channel wins when loaded CPB as a percent of ADR is below the OTA's effective commission. 25% of $1,000 is $250, so $250 is break-even and a defensible ceiling sits at or under it; $300 loses money versus the OTA.
:::

:::q Buyer Mandate & Cost-Per-Booking KPI
question: An app-install campaign spent $30,000, generated 6,000 installs at a $5 cost per install, and drove 200 in-app bookings. Your manager wants to average that $5 cost per install into the web CPB for one blended number. What do you do?
- Report cost per in-app booking ($150) separately from web CPB, because an install is a mid-funnel proxy and blending the $5 install cost would flatter the plan
- Average $5 and the web CPB, since both represent acquisition cost
- Report the $5 cost per install as the app CPB, since it is the cheapest reliable number
- Drop the app line because its economics cannot be compared to web
answer: 0
explain: An install is a mid-funnel proxy that only pays off on the later in-app booking, so the app line is judged on cost per in-app booking ($30,000 / 200 = $150). Blending the cheap $5 install cost into web CPB hides the real economics; report the surfaces separately.
:::

:::q Funnel, Conversion & Attribution Window
question: You are configuring the optimization conversion for an OTA campaign. Which event should you set, given travel's leaky funnel and routine cancellations?
- A flight or hotel search, because it signals the earliest intent
- An item added to the booking cart, because it is closest to purchase
- A click on the ad, because it is the only deterministic event
- A net confirmed, paid booking after cancellations, because it is the only event that represents revenue
answer: 3
explain: The travel conversion is a net confirmed, paid booking. Searches, cart-adds, and clicks are mid-funnel proxies that wildly overstate intent given look-to-book of 50:1 or worse, and gross bookings overstate the count until cancellations are netted out.
:::

:::q Funnel, Conversion & Attribution Window
question: A profitable-feeling display channel reads as a money-loser in the platform, which is set to a 7-day click attribution window. Travel's consideration window averages about 45 days. What is the most likely explanation?
- The channel genuinely lost money and the window is irrelevant
- Most bookings complete around 45 days after first exposure, well outside the 7-day window, so the channel is under-credited until the window is extended
- A 7-day window double-counts bookings, inflating cost
- Travel users click many times, which dilutes the click window
answer: 1
explain: With a ~45-day consideration window, most bookings land well after 7 days, so a short click window credits almost none of them and a profitable channel reads as unprofitable until the window is stretched to match the journey.
:::

:::q Funnel, Conversion & Attribution Window
question: A dynamic abandoned-search retargeting line spends $48,000 to retarget 60,000 abandoned sessions and recovers them to bookings at a 5% recovery rate. What is this line's cost per booking, and why is it typically the plan's most efficient line?
- $16 per booking, because it re-engages near-buyers who already showed item-level intent
- $0.80 per booking, because abandoned sessions are nearly free to reach
- $160 per booking, because recovery lines carry the highest CPB in a plan
- $48 per booking, because recovery rate does not affect CPB
answer: 0
explain: Recovered bookings are 60,000 x 0.05 = 3,000, so CPB is $48,000 / 3,000 = $16. Abandoned-search recovery posts the lowest CPB in a travel plan because it re-engages near-buyers who already showed item-level intent, making it the funnel's efficiency engine.
:::

:::q Funnel, Conversion & Attribution Window
question: A booking completes inside an OTA's iOS app 40 days after install, but the app line shows almost no attributed bookings while the equivalent web line looks strong. Before concluding the app line failed, what is the most likely cause?
- The MMP only measures web bookings, so app events never register
- A third-party cookie set at first impression expired, dropping the booking
- SKAdNetwork collapses the post-install window and cannot carry late re-engagement, so an in-app booking 40 days out fires after the postback closed and goes uncredited
- The web pixel stole the app conversion through cross-device matching
answer: 2
explain: SKAdNetwork truncates the iOS post-install window into a short, coarse postback that cannot represent a 45-day journey, so a booking 40 days out fires after the postback closed and is never tied back to the ad. AdAttributionKit restores configurable re-engagement windows; modeling the gap is required before cutting the line.
:::

:::q Inventory & Deal Mechanics
question: A hotel-group desk must prove confirmed bookings on every dollar it spends. Across the four travel deal types, which one leaves it blind to the booking outcome it is judged on?
- Open auction
- A travel-intent PMP
- A preferred deal on travel-intent supply
- Programmatic guaranteed on a Travel Media Network
answer: 0
explain: Open auction is the cheap, anonymous floor where anyone can bid and you cannot tell whether the impression sits in front of a traveler or a booking, so it is blind to CPB. PMP, preferred deals, and PG all transact on curated travel-intent supply where the closed-loop booking signal can be measured.
:::

:::q Inventory & Deal Mechanics
question: A programmatic-guaranteed deal on a Travel Media Network commits 4,000,000 impressions at a $12 fixed CPM, and that inventory drives 300 net confirmed bookings. What is the cost per booking?
- $144 per booking
- $120 per booking
- $200 per booking
- $160 per booking
answer: 3
explain: The locked commitment cost is 4,000,000 x $12 / 1,000 = $48,000, and cost per booking is $48,000 / 300 = $160. The fixed CPM only matters once you convert it into the booking number you are judged on.
:::

:::q Inventory & Deal Mechanics
question: A travel-intent PMP spends $24,000 and drives 200 net confirmed bookings, while an open-auction line spends the same $24,000 but drives only 150 net bookings. The PMP's CPM is higher. Which line is more efficient on the number that matters, and by how much per booking?
- The open-auction line, by $40 per booking, because its CPM is lower
- The PMP, by $40 per booking, because the higher CPM still yields a lower cost per booking
- They are equal, because spend is identical
- The PMP, by $120 per booking, because CPM differences scale to CPB directly
answer: 1
explain: The PMP CPB is $24,000 / 200 = $120 and the open-auction CPB is $24,000 / 150 = $160, so the higher-CPM PMP is $40 per booking cheaper on the metric that matters. A higher CPM can still mean a lower CPB when the audience converts better.
:::

:::q Inventory & Deal Mechanics
question: An in-app travel inventory deal looks identical to a web deal in your DSP UI, same deal ID format, same CPM, same creative slots. Why must you reconcile it differently before judging its CPB?
- In-app deals always clear at a higher CPM than web deals
- Its conversions route through a Mobile Measurement Partner, not the web booking pixel, so the booking count comes from a separate, non-reconciling source
- In-app deal IDs cannot be activated in a general DSP
- App inventory has no booking event, so CPB cannot be computed at all
answer: 1
explain: In-app inventory bought through the same deal mechanics still has its conversions attributed by an MMP rather than the web booking pixel, so the deal's bookings come from a separate book that will not reconcile to the web engine, and you must reconcile before judging its CPB.
:::

:::q Pacing & Seasonality
question: A client hands you a fixed budget for a campaign promoting summer flights (July departures, roughly a 5-month median booking lead time). Pacing spend against which calendar is the single biggest mistake?
- The booking-lead calendar (the weeks people search and book)
- The travel calendar (the weeks people actually fly)
- The competitor's flight calendar
- The agency's billing calendar
answer: 1
explain: Pacing to the travel calendar front-loads dollars into the month people fly (July) and starves the booking-lead weeks (around February) when sessions actually convert. Spend must lead the travel date by the booking lead time, so a summer-flight budget peaks in late winter.
:::

:::q Pacing & Seasonality
question: A flight campaign has $84,000 of budget remaining with 28 days left, and the pacing index currently reads 1.25. What is the daily pacing target, and what does the index tell you?
- $3,000 per day, and the 1.25 index means you are 25% ahead of plan and at risk of going dark before the booking peak
- $3,000 per day, and the 1.25 index means you are 25% behind plan and will strand budget
- $2,250 per day, and the 1.25 index means you are exactly on pace
- $4,200 per day, and the 1.25 index means delivery is healthy
answer: 0
explain: Daily pacing target is $84,000 / 28 = $3,000 per day. A pacing index of 1.25 (actual / planned) means you are 25% ahead of plan and on track to exhaust the budget early, so unless it is intentional front-loading into a booking-lead week, throttle to avoid going dark before the peak.
:::

:::q Pacing & Seasonality
question: In an off-peak week, prospecting CPB has degraded to $400 while retargeting holds at $100. If you shift $20,000 from prospecting to retargeting, how many additional bookings does that same $20,000 produce versus leaving it in prospecting?
- 50 additional bookings
- 200 additional bookings
- 150 additional bookings
- No additional bookings, because total spend is unchanged
answer: 2
explain: At a $100 retargeting CPB, $20,000 buys 200 bookings; at the degraded $400 off-peak prospecting CPB it buys only 50. The shift nets 200 - 50 = 150 additional bookings from identical spend, which is why off-peak budget tilts to re-engagement where near-buyers persist.
:::

:::q Pacing & Seasonality
question: Your team over-committed on programmatic-guaranteed inventory during peak-season optimism, and now an event cancellation has collapsed demand mid-flight. Why is the PG commitment specifically a pacing risk here?
- PG impressions are billed only when they convert, so unused volume is free
- PG automatically reallocates to open auction when bookings stall
- PG reserves fixed volume at a fixed price, so you still owe the impressions and cannot flex spend down when demand softens
- PG has no minimum and can be paused like an open-auction line at any time
answer: 2
explain: PG is a guaranteed commitment of fixed volume at a fixed price that you owe regardless of whether demand holds, so a mid-flight collapse leaves you delivering and paying for volume that no longer converts. The fix is to size PG to the demand floor and pace flexible PMP and open-auction supply on top.
:::

:::q Measurement, Channels & Compliance
question: A travel program reports 600 bookings from the client-side confirmation pixel, but a server-side import recovers an additional 240 late and call-center bookings for 840 true bookings. The same booking sometimes fires both the pixel and the import. What two facts must you act on?
- The client pixel captured about 71% of true bookings, and you must dedupe on the booking or transaction ID so the pixel and server feed do not double-count
- The server-side import is redundant and should be removed
- The client pixel captured 100% of bookings, so the import adds nothing
- The two sources should be summed to 1,440 to be safe
answer: 0
explain: The client pixel captured 600 / 840 = about 71% of true bookings, so the server-side import is essential for the late and call-center bookings travel's lag creates. Because the same booking can fire both paths, deduplication on a shared booking or transaction ID is mandatory before the CPB is trustworthy.
:::

:::q Measurement, Channels & Compliance
question: A trader wants to raise net working spend without adding budget on a plan where about 63% of bookings complete in-app while retargeting is wired web-only. Which single action recovers the most leaked spend?
- Lowering the open-exchange bid floor
- Increasing frequency caps on prospecting
- Fixing cross-surface, post-booking suppression so app bookers are removed from web retargeting and vice versa
- Switching all inventory to programmatic guaranteed
answer: 2
explain: Cross-surface suppression is the largest single recoverable leak because most bookings are in-app while retargeting is often web-only, so booked travelers keep getting chased on the other surface. Lowering floors or raising frequency does not address already-booked waste, and forcing all inventory to PG raises cost.
:::

:::q Measurement, Channels & Compliance
question: A hotel dynamic-retargeting ad shows "$99/night" but the deep-linked checkout adds a mandatory $49 resort fee, landing at $148 all-in. What is the trader's correct read of this situation?
- It is fine because the resort fee is disclosed at checkout
- It is purely a Legal problem with no effect on campaign performance
- It improves recovery rate because the lower headline price attracts more clicks
- It is both a price-display compliance exposure (DOT full-fare and FTC junk-fee rules) and a conversion killer, so the feed must populate the all-in price
answer: 3
explain: All-in price-display rules are actively enforced, so the mismatch is a real compliance exposure, and the price jump abandons the exact near-buyer you paid to recover. The desk owns the feed, so the fix is to populate DCO creative with the all-in price, not to rely on disclosure at checkout.
:::

:::q Measurement, Channels & Compliance
question: A client wants to defund the geo holdout (because it shrinks a celebrated 5.87x last-click retargeting ROAS) and simultaneously kill the iOS app line (because its SKAN-reported ROAS looks terrible). What is the correct buy-side response?
- Agree to both, since the pixel numbers are the data the client trusts
- Defund the holdout but keep the app line running on its SKAN number
- Kill the app line but keep funding the holdout
- Keep the holdout as the source of truth and model the SKAN-truncated late bookings back in before any budget moves
answer: 3
explain: Both reactions trust biased pixels over a designed experiment. The holdout is the only read that strips the non-incremental near-buyers inflating the 5.87x toward a proven ~2.2x, and the app line's true CPB only appears once you add back the in-app bookings SKAN truncated, so protect the holdout and run the SKAN model before reallocating spend.
:::
