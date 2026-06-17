---
id: vertical-travel-10
track: vertical-travel
module: 10
title: The Capstone, Wiring a Full-Funnel Travel Booking Campaign Across Web and App
summary: Assemble the end-to-end travel booking plan a trader actually runs, from CMO mandate to a defensible Cost per booking reported separately for web and app and proven with a geo holdout.
---
# From mandate to a Cost per booking target and a bid ceiling

A capstone travel plan starts the way every prior lesson said it must, by turning a CMO sentence like "drive direct bookings" into one number the desk can bid against. You take the allowable (the most the client will pay to acquire a booking) and set that as the Cost per booking ceiling, then translate it into a per-impression bid through the funnel math. If the allowable is $160 per booking and you expect a recovered abandoned-search session to book at a 5% retargeting recovery rate, every retargeted session is worth $8.00 of media before you lose money. That single chain, allowable to CPB to bid, is the spine the whole plan hangs on.

The signature KPI is Cost per booking, $\text{CPB} = \text{media spend} / \text{net confirmed bookings}$, and its mirror is booking-value ROAS. The capstone discipline is that you set the ceiling once, then never optimize to a cheaper proxy (CPM, CPC, install) that quietly betrays it.

:::predict
prompt: A travel plan spends $600,000 and drives 3,750 net confirmed bookings across web and app. What is the plan-level Cost per booking?
answer: 160
tolerance: 1
unit: USD per booking
hint: Cost per booking is total spend divided by net confirmed bookings.
explain: 600,000 / 3,750 = 160. The plan-level Cost per booking is $160, which is the number you compare to the client's allowable. If the allowable was $160, you are exactly at the ceiling and any further inefficiency pushes the plan into a loss.
:::

:::callout key
The capstone rule of travel: you set the Cost per booking ceiling first, derive the bid from it, and refuse to optimize to CPM, CPC, or cost per install. A great proxy metric with a blown CPB is a failed plan.
:::

# Defining the conversion and setting the 45-day window on both surfaces

Before a single line item goes live you lock the conversion definition: a net confirmed, paid booking after cancellations, not a search, a click, or an added cart. Travel's consideration window averages about 45 days with roughly 303 minutes of content consumed before booking, so a 7-day click window would orphan most of your real conversions and make every channel look falsely unprofitable. You therefore set the attribution window to about 45 days on the web booking pixel and configure the matching re-engagement window on the app side.

The trap unique to the capstone is that there are two clocks, not one. Web bookings credit through a server-side conversion import (windows run up to 90 days on major platforms, comfortably covering travel's lag), while in-app bookings credit through an MMP, and on iOS SKAdNetwork collapses the postback before a 45-day journey finishes. You wire both, and you accept they will never reconcile to the unit.

:::predict
prompt: Of 4,000 net confirmed bookings, 2,520 complete more than 7 days after the first ad impression. If your attribution window is only 7 days, what percent of true bookings go uncredited?
answer: 63
tolerance: 1
unit: percent
hint: Divide the bookings that fall outside the 7-day window by all true bookings.
explain: 2,520 / 4,000 = 0.63, so 63 percent of real bookings land outside a 7-day window and go uncredited. Extending the window to about 45 days is what recovers them; this is why a short retail-style window quietly kills travel channels on paper.
:::

:::figure costPerFundedCascade
caption: The travel capstone cascade. Impressions become searches, searches become abandoned sessions, abandoned sessions become recovered near-buyers, and only net confirmed bookings (web pixel plus app MMP) count toward Cost per booking. Each step has its own leakage the trader must measure.
:::

# Sourcing supply, open auction for reach and travel-intent PMP or PG for measurable demand

With the conversion defined, you assemble supply across the four deal types you learned earlier, mapped to their job in the plan. Open auction buys cheap reach (CPMs roughly $1 to $4) but is blind to booking outcomes, so it carries prospecting. Travel-intent PMP and programmatic-guaranteed inventory via Sojern (now consolidating Adara under the unified brand after RateGain's $250M acquisition) and Travel Media Networks runs $5 to $15 or more, but it is closed-loop and booking-measurable, so it carries the demand you actually need to prove out. The decision rule is scarcity and outcome-measurability: the more you need to tie spend to bookings, the more you lean on deals over the open auction.

A programmatic-guaranteed commitment is a fixed cost you owe regardless of how demand moves, so you size it against the booking curve, not peak-season optimism. The commitment math is simple and unforgiving: a 4,000,000-impression deal at a $12 fixed CPM is $\text{4,000,000} / 1000 \times 12 = \$48{,}000$ you owe whether or not demand shows up, which is exactly why over-committing on PG against travel's uncontrollable demand curve is a pacing risk you carry into the next step.

:::quiz
question: In a capstone travel plan, why do you route measurable demand through travel-intent PMP or PG rather than open auction, despite the higher CPM?
- Open auction is always fraudulent in travel
- Closed-loop PMP/PG inventory lets you measure bookings, while open auction is cheap but blind to booking outcomes
- PMP and PG are always cheaper than open auction
- Open auction cannot serve travel creative
answer: 1
hint: Think about what each deal type can and cannot tell you about a confirmed booking.
explain: The trade is visibility for price. Travel-intent PMP and PG are closed-loop, so you can tie spend to confirmed bookings; open auction is cheaper but blind to the booking outcome. You pay the premium where you must prove CPB and use cheap open-auction reach for prospecting.
:::

# Pacing to the booking-lead curve, not the travel date

The single most common rookie failure in travel is pacing to when people travel instead of when they book. Summer flights are bought in late winter and early spring (flight lead times run 2 to 8 months), hotels fill a 21 to 90 day window, and cruise wave season peaks January to March, so your media flighting must lead the travel date by weeks. A flat daily budget badly under-serves the booking peak; you weight spend to the booking-window weeks and shift toward retargeting when prospecting demand is thin, since retargeting delivers 3 to 4 times the ROAS of prospecting and about 75% of 2025 travel app conversions came from re-engaged users.

Day to day this is two formulas: the daily pacing target, $\text{remaining budget} / \text{remaining days}$ (for example $90{,}000 / 30 = \$3{,}000$ per day as a flat baseline), and the pacing index, $\text{actual spend to date} / \text{planned spend to date}$, where 1.0 means on pace. In travel you weight that flat baseline upward during booking-lead weeks and downward in the trough, because spreading it evenly starves the actual booking surge.

:::widget lineChart
title: Media flighting weighted to the booking-lead curve (summer travel)
labels: Jan, Feb, Mar, Apr, May, Jun, Jul, Aug
data: 40, 70, 95, 85, 60, 45, 35, 30
unit: spend index
:::

# Wiring the measurement spine across web pixel, app MMP, and cross-surface suppression

This is the section where capstones fall apart. The web spine is a booking-confirmation pixel plus a server-side or offline conversion import, so a $1,400 booking that completes 30-plus days later, or by call center, still credits inside the window (dedupe on the booking or transaction ID is mandatory or the server feed and the client pixel double-count). The app spine is entirely separate: in-app bookings are attributed by an MMP (AppsFlyer, Adjust, or Branch), which reconciles installs and booking events to the click and does NOT line up with the web booking engine. You maintain two reconciled sources of truth and report the gap rather than forcing one number.

The highest-leverage wiring is cross-surface, post-booking suppression. A user who books in the app must be removed from web retargeting and vice versa, or the desk pays to chase travelers who already bought. The reconciliation gap is $| \text{booking-engine bookings} - \text{MMP bookings} | / \text{total bookings}$, so a web engine reporting 1,000 bookings against an MMP-attributed 1,150 is a $150 / 1000 = 15\%$ gap. That gap is normal because a web pixel and an MMP measure different surfaces with different rules; the capstone skill is explaining it, not pretending it away.

:::predict
prompt: The web booking engine reports 1,800 bookings and the app MMP reports 2,070 bookings against a total of 1,800 bookings used as the denominator. What is the reconciliation gap, as a percent?
answer: 15
tolerance: 0.5
unit: %
hint: Take the absolute difference between the two sources, then divide by the total booking denominator.
explain: The absolute difference is |1,800 - 2,070| = 270. Divided by the 1,800 total, 270 / 1,800 = 0.15, a 15 percent reconciliation gap. This is expected, not a bug: the web pixel and the MMP measure different surfaces under different attribution rules, so the capstone skill is explaining the gap to finance rather than forcing one number.
:::

:::callout warning
A real operator pain point: traders keep serving ads for hotels people already booked because the booking-confirmation suppression feed is delayed or wired web-only. Practitioners also vent that nobody owns the web-pixel-versus-MMP reconciliation, so finance and the desk argue over which booking number is real. Own both before you certify the plan, or the CPB story collapses the moment app bookings land.
:::

# Building the channel stack with a dedicated app line, then proving true lift

Now you assemble the channels, each with a defined job. Dynamic abandoned-search retargeting keyed to property and route IDs (DCO creative showing the exact hotel or flight with live price) is the highest-leverage line. Metasearch via Koddi runs on a CPC or commission model that needs its own bid logic, prospecting display, CTV, and social cover upper-funnel demand, and a dedicated app line splits into app-install and deep-linked re-engagement. The non-negotiable rule: judge app-install on cost per in-app booking, $\text{app media spend} / \text{in-app bookings}$, never on cost per install, because cheap junk installs that never book will flatter cost per install while CPB rots.

Then you prove lift. Last-click and retargeting wildly overstate ROAS by claiming near-buyers who would have booked anyway, so you run a geo holdout: $\text{incremental bookings} = \text{test-geo bookings} - \text{scaled control-geo bookings}$, and the true number the plan is judged on is incremental CPB, not last-click CPB.

:::predict
prompt: An app-install line spends $30,000 and yields 200 in-app bookings. What is the cost per in-app booking?
answer: 150
tolerance: 1
unit: USD per booking
hint: Divide app media spend by in-app bookings, not by installs.
explain: 30,000 / 200 = 150. The cost per in-app booking is $150. If this same spend bought 6,000 installs, cost per install would look like a cheap $5, but that number is a trap; only the $150 per actual in-app booking is comparable to your web CPB and your allowable.
:::

:::predict
prompt: A plan spends $600,000 and a geo holdout shows 2,930 incremental bookings (test-geo bookings minus scaled control). What is the true incremental Cost per booking?
answer: 204.78
tolerance: 1
unit: USD per booking
hint: Divide total spend by incremental bookings, not by all attributed bookings.
explain: 600,000 / 2,930 = 204.78. The true incremental Cost per booking is about $205, well above the $160 last-click figure, because the holdout strips out the near-buyers who would have booked anyway. This higher, honest number is what you defend to the CMO.
:::

:::quiz
question: Why must app-install lines be judged on cost per in-app booking rather than cost per install in a travel capstone?
- Installs are free in travel
- A low cost per install can be driven by cheap junk installs that never book, so only cost per in-app booking is comparable to web CPB and the allowable
- Cost per install is illegal to report
- Installs always convert to bookings at 100 percent
answer: 1
hint: Think about what a cheap install actually guarantees about a booking.
explain: An install is a mid-funnel proxy that only pays off on the later in-app booking. Optimizing to cost per install rewards cheap installs that never book; tying the line to cost per in-app booking keeps it honest and comparable to web CPB and the client allowable.
:::

# Closing the loop, reporting web and app CPB separately and enforcing compliance throughout

The finished plan is reported as a surface-split CPB (web CPB and app CPB shown separately, then blended) plus the incremental CPB from the holdout, never as a single blended number that hides which surface is carrying or sinking the plan. The classic incomplete capstone wires server-side booking pixels on the website, forgets the app MMP, and then watches every in-app booking show up unattributed. With about 63% of online travel bookings now happening on mobile, a web-only plan is structurally wrong, not merely incomplete.

Compliance runs through all of it, because the trader owns it: all-in price display (no drip-pricing bait fares that violate rules and kill conversion), GDPR and CCPA consent gating audience building on sensitive travel-intent signals, and rate-parity and co-op brand-safety constraints that come attached to brand dollars. Travel commonly leaks 5 to 10% of spend to already-booked and stale audiences, and cross-surface suppression is the single biggest waste-recovery the trader controls.

:::predict
prompt: A finished plan spends $600,000, and 8% leaks to chasing already-booked or out-of-consent users. How many dollars are wasted?
answer: 48000
tolerance: 100
unit: USD
hint: Multiply total spend by the waste rate.
explain: 600,000 times 0.08 = 48,000. That $48,000 is recoverable, and most of it comes from fixing cross-surface, post-booking suppression so an app booker stops burning web retargeting budget. Recovering it directly lowers the plan's Cost per booking.
:::

:::widget barChart
title: Surface-split and incremental Cost per booking for the finished plan
labels: Web CPB, App CPB, Blended CPB, Incremental CPB
data: 150, 175, 160, 205
unit: USD per booking
:::

:::sources
- BusinessWire, Expedia Group Reports Second Quarter 2025 Results (advertising and media revenue $182M, +19%) | https://www.businesswire.com/news/home/20250807749756/en/Expedia-Group-Reports-Second-Quarter-2025-Results
- Skift, RateGain to Buy Sojern in $250 Million Deal, Expanding Its Marketing Reach | https://skift.com/2025/10/02/rategain-to-buy-sojern-in-250-million-deal-expanding-its-marketing-reach/
- Hospitality Net, RateGain Consolidates MarTech Capabilities Under Sojern, Creating the World's Largest Source of Travel Intent Data | https://www.hospitalitynet.org/news/4131164/rategain-consolidates-martech-capabilities-under-sojern-creating-the-worlds-largest-source-of-travel-intent-data
- AppsFlyer, Travel app marketing trends in 2025: Retargeting leads the way | https://www.appsflyer.com/blog/mobile-marketing/travel-app-marketing-trends/
- AppsFlyer, Travel and Local App Attribution and Marketing Analytics | https://www.appsflyer.com/solutions/travel-local/
- Adjust, AdAttributionKit vs. SKAdNetwork: What's the difference | https://www.adjust.com/blog/adattributionkit/
- Condor Ferries, Over 70+ Online Travel Booking Statistics 2025 | https://www.condorferries.co.uk/online-travel-booking-statistics
- calc4marketers, Average ROAS for Travel Advertising 2026 | https://www.calc4marketers.com/average-roas-travel
:::
