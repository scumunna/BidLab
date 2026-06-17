---
id: vertical-qsr-03
track: vertical-qsr
module: 3
title: Geo, Polygon, POI and Lat/Long QA, Hitting Your Doors, Not the Competitor Across the Street
summary: Build and QA radius, polygon, and POI geo-targeting tight to the brand's own doors so budget and footfall attribution reach your stores, not the rival across the street.
---
# Three geometries: radius, polygon, POI

Every QSR line item is, at bottom, a shape drawn around a store address, and the trader has three ways to draw it. A radius is a circle around a single lat/long: fastest to set up and the only practical option when you are fanning out across thousands of stores, but crude, because a circle does not respect the building, the road, or the property line. A polygon is a hand-drawn shape that follows the actual parking lot and building footprint, the gold-standard for precision, and a POI list is a set of named points-of-interest pulled from a location vendor (Foursquare, Precisely, Adsquare) keyed to the brand's real outlets.

The reason this matters is that the same geometry you target on is the geometry footfall attribution measures on later, so a sloppy shape here corrupts both the buy and the proof. A 1-mile radius covers roughly $\pi \times 1^2 \approx 3.14$ square miles, almost always far larger than a fast-food store's true trade area, while a polygon hugged to the building can be a fraction of an acre. The craft of this module is choosing the right shape and then proving it actually lands on your door.

:::quiz
question: A trader needs the tightest possible geo that follows the store's real parking-lot and building footprint, not a circle. Which geometry is the gold standard?
- A hand-drawn polygon tight to the building
- Radius around the store lat/long
- A 2-mile DMA-cluster radius
- An untrimmed POI vendor list
answer: 0
hint: Only one of these respects the actual property line rather than a circle or a vendor default.
explain: A polygon follows the real parking lot and building footprint, so it disambiguates the brand's door from the rival next door. A radius is a blunt circle, a wide DMA radius is even blunter, and a raw POI list still needs trimming and QA before it is trustworthy.
:::

# Bleed: paying to reach the rival across the street

The recurring failure in QSR geo is bleed: a circle drawn around a strip-mall store also catches the competitor QSR across the street, the gas station, the highway drive-by traffic, and the apartments behind it. The campaign then pays to reach people who were never near the brand's door, and worse, footfall attribution later credits some of those people's visits to the wrong building. Bleed rate is simply the impressions that fell inside a competitor or irrelevant polygon over total impressions served in the target geo.

The fix is twofold: draw a polygon tight to the building instead of a radius, and apply a minimum dwell-time filter so a car idling at a red light or a pedestrian passing on the sidewalk is not counted as a visit. Burger King's Whopper Detour proved the inverse is also operationally feasible at national scale, geo-fencing within 600 feet of roughly 14,000 McDonald's locations to conquest a rival, so the same precision that excludes a competitor can deliberately target one when the brief calls for it.

:::predict
prompt: Of 50,000 impressions served inside a 1-mile store radius, 9,000 fell inside the competitor's polygon directly across the street. What is the bleed rate?
answer: 18
tolerance: 0.5
unit: %
hint: Bleed rate is competitor-polygon impressions divided by total impressions in the target geo.
explain: 9,000 / 50,000 = 0.18, an 18 percent bleed rate. Nearly one in five impressions paid the geo premium to reach the rival's lot, and any visits attributed there inflate the wrong story unless the radius is tightened to a polygon.
:::

:::figure geoHoldout
caption: Geo geometry is the unit of work in QSR. A radius circle spills across roads and property lines and catches neighbors, while a polygon hugged to the building isolates the brand's own door for both targeting and downstream footfall measurement.
:::

# How bleed corrupts the visit count and the CPIV

Bleed is not just wasted spend, it poisons the signature QSR KPI: CPIV, the cost per incremental visit. If attribution counts visits inside a loose radius, some of those visits belong to the rival's customers or to drive-by traffic, so the reported visit count is inflated and the CPIV looks artificially cheap. When you later tighten the polygon and exclude neighbors, the visit count drops to the real catchment, the catchment match rate, attributed visits inside the brand polygon over all attributed visits in the radius, climbs toward 100 percent, and the CPIV corrects upward to the honest number.

The trader's job is to report the honest CPIV, not the flattering one. A cheap CPIV driven by loose geo is a measurement artifact, exactly the kind of number that gets challenged in a QBR when a second vendor measures the same flight with tighter polygons and returns fewer, more defensible visits.

:::predict
prompt: A flight reports 10,000 attributed visits inside a 1-mile radius, but a polygon-and-dwell QA shows 18 percent of those visits actually fell in the competitor's lot or were drive-by traffic. On $54,000 of spend, what CPIV should you report after removing the bleed?
answer: 6.59
tolerance: 0.05
unit: USD
hint: First strip the 18 percent bleed from the 10,000 visits, then divide spend by the corrected visit count.
explain: Real visits = 10,000 x (1 - 0.18) = 8,200. CPIV = 54,000 / 8,200 = 6.59 dollars. That is the honest number, up from the flattering 54,000 / 10,000 = 5.40 dollars the loose radius implied, so cleaning the geo raised the reported CPIV by removing visits that were never the brand's.
:::

:::callout key
The geometry you target on is the geometry you are measured on. A radius that bleeds into the competitor's lot does not just waste impressions, it injects the rival's visits into your footfall report and makes your CPIV look cheaper than it is. Tighten the polygon and the visit count, and the CPIV, become defensible.
:::

# Lat/long QA: decimals, swaps, and silent bulk-sheet failures

Before any shape is trusted, the trader has to QA the coordinates feeding it, because the bid stream carries a raw lat/long and a small numeric error moves the pin far. Geo precision is unforgiving: 4 decimal places of latitude or longitude resolve to about 11 meters, 3 places to about 111 meters, and 2 places to about 1.1 kilometers, so a bulk sheet that truncates 33.1234 to 33.12 silently relocates the store roughly a kilometer into the wrong neighborhood with no error thrown. A latitude/longitude swap (transposing the two fields) can fling a US store into the wrong hemisphere entirely, which a simple in-country bounding-box check catches immediately.

The most dangerous failures are the silent ones. Bulk uploads (DV360 SDF, TTD bulk sheets) routinely map a malformed row to the centroid of a ZIP code, or to (0,0) off the coast of Africa, and nobody notices until the footfall report comes back nonsensical weeks later. POI databases lag reality too, so a closed or relocated store still in the vendor's list quietly burns spend on a building the brand no longer operates.

:::predict
prompt: A bulk store sheet truncated every lat/long from 4 decimal places to 2. Roughly how far, in meters, can that truncation move a store pin?
answer: 1100
tolerance: 50
unit: meters
hint: 4 places resolves to about 11 meters and 3 places to about 111 meters, so each dropped decimal multiplies the error by about ten.
explain: 4 places is about 11 m, 3 places about 111 m, and 2 places about 1,100 m (1.1 km). Dropping from 4 to 2 decimals can move the pin roughly 1.1 kilometers, easily into the next neighborhood, with no error message to flag it.
:::

:::quiz
question: A national bulk upload comes back showing several stores plotted in the ocean off West Africa at coordinates near (0,0). What most likely happened?
- The polygons were drawn too tight to the building
- Malformed rows defaulted their lat/long to (0,0) and were never caught pre-flight
- The dwell-time filter was set too high
- The competitor exclusion was applied twice
answer: 1
hint: (0,0) is the Gulf of Guinea, a classic null-coordinate default, not a targeting-tightness problem.
explain: Empty or malformed coordinate fields commonly default to (0,0), which sits off the African coast. A pre-flight bounding-box check (is every pin inside the US, or inside the expected DMA?) catches this before budget is wasted. Tight polygons, dwell thresholds, and exclusions are unrelated to a null-coordinate failure.
:::

# Sizing the shape: how much area each geometry really covers

Choosing radius versus polygon is partly a math decision about how much irrelevant area you are buying. Because area grows with the square of the radius, widening a circle is expensive fast: a 0.5-mile radius covers about 0.79 square miles, a 1-mile radius about 3.14, and a 2-mile radius about 12.57, while a polygon hugged to a building and its lot is on the order of a few hundredths of a square mile. Doubling the radius from 1 mile to 2 quadruples the targeted area, which means roughly four times the neighbors, four times the drive-by traffic, and four times the bleed risk.

In dense urban blocks the problem compounds: two of the brand's own stores plus three competitors can sit inside a single 1-mile radius, so the circle double-serves and mis-attributes, and only polygons drawn per store can disambiguate which door a visit belongs to. In thin rural DMAs the trade-off flips, because open-exchange local inventory is scarce, sometimes forcing a wider radius just to find impressions, which is exactly where geo precision and dwell filters matter most to keep the loose shape from inflating visits.

:::widget barChart
title: Targeted area by geometry (square miles)
labels: Radius 0.5mi, Radius 1mi, Radius 2mi, Polygon
data: 0.79, 3.14, 12.57, 0.05
unit: sq mi
:::

:::predict
prompt: A store's geo is widened from a 1-mile radius to a 2-mile radius. By what factor does the targeted area increase (area is pi times r squared)?
answer: 4
tolerance: 0.1
unit: x
hint: Area scales with the square of the radius, so compare 2 squared to 1 squared.
explain: Area at 2 miles is pi x 2^2 = 12.57 sq mi; at 1 mile it is pi x 1^2 = 3.14 sq mi. 12.57 / 3.14 = 4.0, so doubling the radius quadruples the area, and roughly quadruples the neighbors and bleed risk along with it.
:::

# The QA checklist before a flight goes live

A disciplined trader runs a fixed geo-QA pass before any QSR flight launches, because every error in this module is silent and compounds across thousands of rows. The checklist: confirm the bid-stream lat/long resolves to the intended store (drop the pin on a map, not a spreadsheet), run a bounding-box sanity check for in-country and in-DMA coordinates to catch swaps and (0,0) defaults, prefer polygons over radius circles wherever the store list size allows, set a minimum dwell threshold so transient traffic is not counted, explicitly exclude neighboring businesses and the competitor across the street, and refresh the POI list to drop closed or relocated stores. These are the named best-practice controls, polygon mapping, minimum visit durations, and neighbor exclusion, that keep both delivery and measurement clean.

The operator pain here is real and worth internalizing. Traders on r/adops report bulk geo uploads that looked fine in the sheet but mapped stores to a ZIP centroid or to (0,0), with nobody catching it until the footfall report came back nonsensical, and r/programmatic traders complain that radius targeting in suburban strips constantly catches the competitor next door, so clients challenge the visit numbers as conquesting a rival's traffic. A two-minute map check per cluster prevents weeks of corrupted attribution.

:::quiz
question: A trader is finalizing the pre-flight geo-QA pass for a 1,200-store QSR LTO. Which step most directly prevents the campaign from later crediting a rival's customers as brand visits?
- Raising every line item's bid to win more impressions
- Widening each radius to 2 miles to guarantee delivery
- Drawing polygons tight to the building and excluding the neighboring competitor
- Removing the minimum dwell-time filter to capture more visits
answer: 2
hint: The goal is to keep the rival's lot and drive-by traffic out of both targeting and measurement.
explain: Polygon mapping tight to the building plus explicit neighbor exclusion is the named best-practice control that keeps the competitor's lot out of the buy and the footfall report. Raising bids does nothing for geo accuracy, widening the radius increases bleed, and removing the dwell filter lets transient traffic inflate false visits.
:::

:::callout warning
From r/adops and r/programmatic: bulk store-sheet uploads that "looked fine" silently mapped stores to a ZIP centroid or to (0,0), and the error surfaced only when the footfall report came back nonsensical weeks later. Separately, suburban radius targeting routinely catches the competitor across the street, so clients reject the visit numbers as crediting a rival's traffic. Always drop the pins on a real map and bounding-box-check coordinates before a flight goes live, because nothing throws an error when geo is wrong, it just quietly wastes budget and poisons attribution.
:::

:::sources
- aidigital, Foot Traffic Attribution: polygon mapping, dwell, neighbor exclusion | https://www.aidigital.com/blog/footfall-attribution
- Cuebiq, Footfall Attribution Benchmarks (CPIV, visit rate, uplift by vertical) | https://cuebiq.com/benchmarks/
- KORTX, Restaurant Marketing Strategy: The 2026 QSR Playbook (store-radius, audience-first) | https://kortx.io/news/restaurant-marketing-strategy-qsr/
- Eskimi, Daypart and geo targeting for QSR | https://www.eskimi.com/blog/daypart-targeting
- Cooley, Maryland's MODPA: 1,750-ft precise geolocation as sensitive data | https://www.cooley.com/news/insight/2025/2025-09-09-marylands-unique-state-privacy-law-takes-effect-october-1--what-you-should-know
- Restaurant Dive, Drive-thru share of US fast-food sales and digital order growth | https://www.restaurantdive.com/news/drive-thru-sales-qsr/
:::
