---
track: vertical-qsr
title: QSR Programmatic Certification
pass: 0.7
draw: 12
---
:::q Landscape and the Buyer Mandate
question: A QSR client keeps asking why CTR is so low on their footfall flight and wants you to optimize toward it. With roughly 65% of fast-food sales completing at the drive-thru and no digital purchase event, what is the right metric to anchor the buy to?
- Click-through rate, since it is the only real-time signal the DSP reports
- Cost per incremental visit, because the win condition is an extra physical store visit above a control
- Cost per acquisition, since CPIV and CPA measure the same thing
- Viewable CPM, because most spend is on CTV
answer: 1
explain: The business goal is incremental footfall, and with most sales closing offline there is no clean digital purchase signal, so the trader optimizes to CPIV (cost per incremental visit), not clicks. CPIV is not the same as CPA.
:::

:::q Landscape and the Buyer Mandate
question: AdImpact reports chicken-chain CTV impressions grew from 1.1B in Q1 2024 to 4.1B in Q1 2026 and headlines the growth as "310%." Before you repeat that figure to a client, what is the correct percent increase, and what should you do?
- 310%, the source is authoritative so use it as printed
- About 373%, because you add the two impression figures
- About 27%, because you divide the change by the new value
- About 273%, and flag that the source's headline does not match its own inputs
answer: 3
explain: Percent change is (4.1 - 1.1) / 1.1 = 2.727, about 273%, not the 310% the source printed. A trader sanity-checks vendor percentages before quoting them in a QBR.
:::

:::q Landscape and the Buyer Mandate
question: A QSR plan spends $500,000 total, with $325,000 going to connected TV. The client asks what share of budget is CTV and what measurement trade-off that share creates.
- 65% CTV, and the heavy CTV mix improves reach but weakens the device-to-doorstep link, pushing measurement onto geo and panel methods
- 65% CTV, and CTV carries a precise device location so footfall attribution gets easier
- 35% CTV, and the split has no effect on measurement
- 65% CTV, and a CTV-heavy mix automatically lowers CPIV because impressions are cheaper
answer: 0
explain: 325,000 / 500,000 = 0.65, so CTV is 65% of budget. CTV generally carries no deterministic device-to-store link, so a heavier CTV mix lifts reach but complicates footfall attribution versus mobile.
:::

:::q Landscape and the Buyer Mandate
question: Your QSR LTO spent $480,000 and a matched-control test isolated 60,000 incremental visits. The client also wants to know how that CPIV reads against the Cuebiq Fast Food benchmark range (Below-Average $28.65, Average $8.84, High-Performing $5.28).
- $8.00, which sits right around the Fast Food Average band
- $0.125, which is below the High-Performing mark
- $80.00, which is worse than Below-Average
- $8.00, which beats the High-Performing mark
answer: 0
explain: CPIV = 480,000 / 60,000 = $8.00 per incremental visit, just inside the Average band ($8.84). It is cheap relative to other verticals because fast food is a high-frequency purchase, not because trading is superior.
:::

:::q Geo Targeting and Audience Construction
question: A suburban strip-mall store is set up with a 1-mile radius and the client complains the visit numbers look inflated by the rival QSR directly across the street. Which combination of controls most directly fixes the bleed?
- Raise the bid on every line item to win more in-radius impressions
- Widen the radius to 2 miles so more of the trade area is covered
- Draw a polygon tight to the building, set a minimum dwell-time filter, and explicitly exclude the neighboring competitor
- Remove the dwell-time filter so more passing devices are counted as visits
answer: 2
explain: Polygon mapping tight to the building, a minimum dwell threshold, and neighbor exclusion are the named best-practice controls that keep the rival's lot and drive-by traffic out of both targeting and the footfall report. Widening the radius or dropping dwell makes bleed worse.
:::

:::q Geo Targeting and Audience Construction
question: Of 50,000 impressions served inside a store's 1-mile radius, 9,000 fell inside the competitor's polygon across the street. The flight spent $54,000 and reported 10,000 attributed visits, but QA shows that same 18% share were rival-lot or drive-by traffic. What is the honest CPIV after removing the bleed?
- $5.40, using all 10,000 attributed visits
- $3.00, because bleed lowers the true cost
- $6.00, by removing exactly 1,000 visits
- $6.59, after stripping the 18% bleed to 8,200 real visits
answer: 3
explain: Bleed rate is 9,000 / 50,000 = 18%. Real visits = 10,000 x (1 - 0.18) = 8,200, so CPIV = 54,000 / 8,200 = $6.59, up from the flattering $5.40 the loose radius implied. Cleaning the geo raises the reported CPIV to the defensible number.
:::

:::q Geo Targeting and Audience Construction
question: A bulk store sheet truncated every lat/long from 4 decimal places to 2 before upload. The client asks how far that could move a store pin and whether the DSP would have warned you.
- About 11 meters, and the DSP throws a validation error
- About 111 meters, and the bid stream rejects the row
- About 1.1 kilometers, and nothing throws an error so it must be caught in QA
- About 11 kilometers, and the SSP auto-corrects it
answer: 2
explain: 4 decimals resolve to roughly 11 m, 3 to roughly 111 m, and 2 to roughly 1.1 km, so dropping to 2 decimals can move a pin about a kilometer into the wrong neighborhood. Truncation throws no error, so a pre-flight map and bounding-box check is the only defense.
:::

:::q Geo Targeting and Audience Construction
question: A national bulk upload comes back with several stores plotted in the ocean off West Africa near coordinates (0,0). What most likely happened, and what pre-flight check catches it?
- The polygons were drawn too tight; loosen them
- Malformed or empty coordinate rows defaulted to (0,0); a bounding-box check confirming every pin is in-country catches it
- The dwell-time filter was set too high; lower it
- The competitor exclusion ran twice; remove one
answer: 1
explain: Empty or malformed coordinate fields commonly default to (0,0), which sits in the Gulf of Guinea. A bounding-box sanity check (is every pin inside the US or the expected DMA) catches null-coordinate failures before budget is wasted.
:::

:::q Trafficking and Franchise Co-op Budgeting
question: An owner-operator with $1,200,000 in annual gross sales pays a 4% national ad-fund fee plus a 3% regional co-op fee. The operator wants the total annual contribution and how it splits.
- $84,000 total, split $36,000 national and $48,000 regional
- $7,000 total, because you apply 7% to $100,000
- $84,000 total, split $48,000 national and $36,000 regional
- $168,000 total, because the fees stack on each other twice
answer: 2
explain: Combined obligation is 4% + 3% = 7%, so $1,200,000 x 0.07 = $84,000, split into a national share of $1,200,000 x 0.04 = $48,000 and a regional share of $1,200,000 x 0.03 = $36,000.
:::

:::q Trafficking and Franchise Co-op Budgeting
question: A QSR campaign covers 600 stores, 3 dayparts, and 2 creatives, with one deal per line item. How many line items must be trafficked, and what is the only sane way to build that?
- 1,205 line items, built by hand in the UI
- 605 line items, since you add the dimensions
- 3,600 line items, built with templated line-item trees and bulk-sheet (SDF) uploads
- 1,800 line items, because creatives do not multiply the count
answer: 2
explain: Fan-out is multiplicative: 600 x 3 x 2 = 3,600 line items. At that scale templated trees plus bulk SDF or Trade Desk bulk-sheet uploads are mandatory, because manual copy-paste guarantees silent per-row errors.
:::

:::q Trafficking and Franchise Co-op Budgeting
question: A regional co-op fund of $180,000 is split evenly across 400 participating stores. What is the per-store budget, and what is the main drawback of this even-split method?
- $450 per store, and it under-funds high-volume stores while over-funding low-traffic ones
- $450 per store, and it always overspends the total fund
- $4,500 per store, and it violates state privacy law
- $45 per store, and it cannot be uploaded via a bulk sheet
answer: 0
explain: $180,000 / 400 = $450 per store. An even split is simple to reconcile but ignores store volume, so a busy drive-thru and a slow unit get the same $450 even though the busy store could convert far more incremental visits. The math still sums to the total fund.
:::

:::q Trafficking and Franchise Co-op Budgeting
question: After a flight, an owner-operator audits their fund statement and the budgets do not tie out. A national fund of $48,000 and a regional co-op of $36,000 were supposed to be trafficked. What reconciliation rule was most likely broken?
- The grand total must exceed the funded amount to leave a buffer
- Each store must receive an identical budget regardless of fund
- Co-op budgets can borrow from one another mid-flight to balance pacing
- The sum of all national and co-op line-item budgets must equal the $84,000 funded amount, with no store drawing from the wrong co-op
answer: 3
explain: Reconciliation is a balance equation: national line items must sum to the national share, each co-op's line items to that co-op's share, and the grand total must equal the funded $84,000, no more and no less. A mis-mapped store drawing another region's money breaks the tie-out.
:::

:::q Deal Plumbing
question: A PG CTV deal for a tentpole LTO commits 2,000,000 impressions at a $34 fixed CPM. What is the committed spend, and how does PG differ from a PMP if pacing gets soft?
- $68,000, and because PG is a reservation a starved deal is a breached volume commitment, not just soft pacing
- $68,000, and PG is an elastic auction so under-delivery has no consequence
- $58,000, and PG behaves exactly like a PMP at a floor
- $680,000, and a low bid simply wins less on a PG deal
answer: 0
explain: PG cost is fixed CPM times impressions in thousands: 2,000 x $34 = $68,000. PG is a reservation with committed volume, so starving it breaches the guarantee, unlike a PMP auction where a low bid just wins less.
:::

:::q Deal Plumbing
question: A PG deal shows 0 bid requests for 48 hours, even though the line item is active, uncapped, and has approved creative. Where do you look first, and why?
- At the bid price, because you are clearly under the floor
- At the creative sizes, because a size mismatch always causes zero requests
- At deal setup and seller activation (wrong deal ID or SSP, or the seller never turned the deal on), because zero requests means the auction is not reaching your DSP
- At the daily spend cap, because the line item is throttled
answer: 2
explain: Zero bid requests means the auction is not even reaching your DSP, which points at setup or activation: a wrong deal ID or SSP, or an unactivated seller. Floor, creative, and cap problems produce bid requests but no wins, a different failure.
:::

:::q Deal Plumbing
question: A PMP deal received 200,000 bid requests and your DSP submitted bids on 50,000 of them, winning very little. What is the bid responsiveness, and what does it tell you the problem is NOT?
- 400%, and it confirms the deal is mis-activated
- 25%, and it proves the seller never turned the deal on
- 75%, and it means the creative is ineligible
- 25%, and it rules out a setup or activation problem because requests are clearly arriving
answer: 3
explain: Bid responsiveness is bids submitted / bid requests = 50,000 / 200,000 = 25%. Requests are arriving, so this is not a setup or activation problem; the gap points at targeting, eligibility, or floor reasons the DSP declined the other 75%.
:::

:::q Deal Plumbing
question: A curated CTV deal is bidding but not winning. The deal floor is $32.00 and your DSP is submitting $27.50. What is the floor gap, and can you win as-is?
- A $4.50 gap; you are under the floor and cannot win until you bid above $32.00
- A $4.50 gap; you are above the floor and should be winning
- A $59.50 gap; the floor and bid add together
- No gap; floor and bid are unrelated to winning
answer: 0
explain: Floor gap is deal floor minus submitted bid: $32.00 - $27.50 = $4.50. A positive gap means the bid is under the floor and cannot clear, so you raise the bid above $32.00 (or fix whatever capped it) to start winning.
:::

:::q Pacing, Dayparting and Frequency
question: An LTO has a $210,000 budget over a 42-day flight. By day 10 you have spent $70,000 against a planned even spend of $50,000. What is the pacing index and the correct action?
- 1.4, meaning you are 40% ahead and front-loading, so cap daily spend to protect the back half of the promo
- 0.7, meaning you are under-pacing, so raise bids
- 1.4, meaning you are on pace, so take no action
- 0.71, meaning you should pause the flight entirely
answer: 0
explain: Pacing index is actual / planned = 70,000 / 50,000 = 1.4, so you are 40% ahead of plan and front-loading. Without a daily cap the budget runs out before the LTO ends, so you re-pace by capping daily spend.
:::

:::q Pacing, Dayparting and Frequency
question: Continuing that flight: after day 10 you have spent $70,000 of the $210,000 budget with 32 flight days left. What daily budget re-paces the remainder?
- $5,000, the original even pace
- $2,188, half the remaining budget per day
- $4,375, the remaining budget divided by remaining days
- $6,562, to catch back up to plan
answer: 2
explain: Remaining daily budget is (total - spent) / remaining days = (210,000 - 70,000) / 32 = 140,000 / 32 = $4,375. That is below the original $5,000 even pace because you front-loaded and now must slow down to reach the LTO end date.
:::

:::q Pacing, Dayparting and Frequency
question: A CTV-heavy QSR flight reaches 60,000 households and you intend a 4x household frequency cap, but you set the 4x cap at the device level. A typical home has a TV, two phones, and a tablet. What happens?
- Delivery stays at the intended 4x per household because the DSP consolidates devices
- Each of the four devices gets its own 4x, so the household can see roughly 16x, far past the intended exposure
- The cap auto-doubles to 8x on CTV only
- Household and device caps are identical, so nothing changes
answer: 1
explain: A device-level cap applies independently to each screen, so a four-device home can see about 16x while you intended 4x per household. Because QSR runs heavy CTV, this multi-device leakage over-serves households and wastes co-op spend.
:::

:::q Pacing, Dayparting and Frequency
question: A national QSR LTO sets a single "11am to 2pm lunch" daypart in the DSP's account time zone for stores across all four US time zones. Why is this a problem?
- Dayparts cannot be set on CTV, so the schedule is ignored
- The flight serves at the wrong local hour in other zones unless dayparts are set in each store's local time
- Frequency caps stop working when dayparts are enabled
- The DSP automatically converts every impression to local time, so there is no issue
answer: 1
explain: A daypart set in one account time zone serves at the wrong local clock hour in other zones, so a Pacific store could run the "lunch" window mid-morning. Dayparts must be set in each store's local time so budget lands in the real meal-decision window.
:::

:::q Identity, Fraud and Measurement Governance
question: A QSR loyalty onboard has hop match rates of 50% (email to MAID), 80% (MAID to household-IP), and 90% (IP to geo). What share of input emails survive all the way to a geo anchor, and why does this matter?
- 73%, the average of the three rates
- 220%, the sum of the three rates
- 90%, only the last hop matters
- 36%, the product of the three rates, so a large CRM file resolves to a much smaller attributable pool
answer: 3
explain: Chain survival is the product of the hops, not the average: 0.50 x 0.80 x 0.90 = 0.36. Only 36 of every 100 emails reach a geo anchor, which is why a large loyalty file resolves to a much smaller addressable and attributable audience.
:::

:::q Identity, Fraud and Measurement Governance
question: Last year a $90,000 QSR LTO drove 10,000 incremental visits (CPIV $9.00). This year, with an identical plan and budget, MAID deprecation shrinks the attributable pool to 7,500 incremental visits. What is this year's CPIV and the most defensible explanation?
- $7.50, and the campaign improved
- $12.00, and the rise is identity decay shrinking the attributable pool, not worse trading
- $9.00, and nothing changed
- $13.33, and the footfall vendor raised prices
answer: 1
explain: CPIV = 90,000 / 7,500 = $12.00, up from $9.00 last year, a 33% rise. With plan and budget held constant, a shrinking deterministic ID pool means fewer attributable visits per dollar, so the trader attributes the increase to signal loss, not trading skill.
:::

:::q Identity, Fraud and Measurement Governance
question: You negotiated a $30 CPM on a CTV deal, but a verification vendor measures 18% of delivered impressions as invalid traffic. What effective (clean) CPM did you actually pay on valid impressions?
- $25.42, because invalid traffic lowers your true cost
- $30.00, because the rate card is what you pay
- $36.59, because you only paid for the 82% of impressions that were valid
- $35.40, by subtracting 18% from the CPM
answer: 2
explain: Effective CPM is nominal CPM divided by the valid share: 30 / (1 - 0.18) = 30 / 0.82 = $36.59. The 18% invalid traffic quietly raised your true cost per clean impression about 22% over the rate card.
:::

:::q Identity, Fraud and Measurement Governance
question: A QSR brand wants to run competitor-conquest geo-fences around rival stores in Maryland for a 2026 flight. Under MODPA, what constrains this and what is the right move?
- Nothing; MODPA only applies to email data, so geo-fencing is unaffected
- MODPA defines precise geolocation as within 1,750 feet, bans its sale, and bars geofences within 1,750 feet of health facilities, so you run a compliant-geo screen and get legal sign-off before launch
- MODPA requires every geo-fence to be at least 5 miles wide, so widen the radius
- MODPA only restricts CTV, so move the conquest budget to display
answer: 1
explain: MODPA classes precise geolocation (within 1,750 feet) as sensitive data with an absolute sale ban and bars geofences within 1,750 feet of mental-health or reproductive/sexual-health facilities. Competitor-conquest geo is the most scrutinized tactic, so you screen the store list and get brand-safety and legal sign-off before the flight runs.
:::
