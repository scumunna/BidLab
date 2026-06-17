---
id: vertical-travel-06
track: vertical-travel
module: 6
title: Data and Identity, Booking Pixels, Server-Side Conversions, MMP Attribution, and Suppression
summary: Wire travel's measurement spine across the web booking pixel, server-side or offline conversion imports, and the app MMP, then keep cross-surface suppression tight so the desk stops paying to chase already-booked travelers.
---
# Two sources of truth, not one

In travel the booking lives in two places that never fully agree. On the web surface the booking-confirmation pixel and a server-side feed credit a confirmed, paid booking back to the click. On the app surface a Mobile Measurement Partner (AppsFlyer, Adjust, or Branch) reconciles installs and in-app booking events to the click, and it does not use the web booking engine at all. The trader's job is not to force these into one number, it is to wire both correctly and explain the gap between them.

The reason this matters more here than in retail is the lag. A traveler researches for roughly 45 days before booking, so a conversion that completes 30 or more days after the first impression must still land inside an extended attribution window, or the channel that drove it looks falsely unprofitable.

:::predict
prompt: In 2025 roughly 63% of online travel bookings complete on mobile, the bulk of that inside native apps that no web page-load pixel can see. If the web booking pixel and the server-side web import together only ever observe bookings that touch the web booking engine, what share of all bookings is the web spine alone structurally blind to?
answer: 63
tolerance: 1
unit: %
hint: The app surface is the part the web spine never sees. Read it straight off the mobile share.
explain: About 63 percent of bookings happen on mobile, overwhelmingly inside native apps, and a web confirmation pixel plus server-side web import only fire for the roughly 37 percent that touch the web booking engine. So the web spine is blind to about 63 percent of bookings unless an app MMP is wired as a second, separate book. That gap is the whole reason travel needs two sources of truth, not one.
:::

:::callout key
The deliverable of this lesson is two reconciled sources of truth: a web booking pixel plus server-side import, and an app MMP. You report both, you reconcile both, and you suppress across both. Anyone who reports a single blended number without the web-vs-app split is hiding which surface is carrying the plan.
:::

# The web spine, client pixel plus server-side import

The client-side booking pixel fires in the browser at the confirmation page, but it is the weakest link in travel because the conversion often arrives late, by phone, or by a call center, none of which fire a page-load pixel. The fix is a server-to-server (or offline CSV) conversion import: the booking engine or the property management system posts the confirmed booking back to the ad platform inside an import window that runs up to 90 days on the major platforms, comfortably longer than travel's ~45-day consideration cycle. That is how a $1,400 booking confirmed five weeks after the first impression still gets credited.

The trap is double counting. If the same booking fires the client pixel and also arrives through the server-side import, you book it twice unless you dedupe on a shared booking or transaction ID. Travel bookings carry a clean confirmation number, so deduplication is mechanical, but it is mandatory before anyone trusts the CPB.

:::figure attributionPaths
caption: The web spine. A confirmed booking is credited either by the client-side confirmation pixel or by a server-side or offline import that posts back inside a window long enough to cover travel's ~45-day lag. Dedupe on the booking ID so the two paths never count the same booking twice.
:::

:::predict
prompt: A travel program reports 600 bookings from the client-side confirmation pixel and recovers an additional 240 late or call-center bookings only through the server-side import, for 840 true bookings. What share of true bookings did the client pixel alone capture?
answer: 71.43
tolerance: 0.5
unit: %
hint: Divide the client-only count by the true total.
explain: 600 / 840 = 0.7143, about 71.4 percent. The server-side import recovered the remaining 28.6 percent (240 bookings) that completed late or off the web confirmation page, which is exactly why the import is not optional in travel.
:::

# The app surface, why the MMP is a separate book

A native app has no page and no web pixel, so an in-app booking is attributed by an MMP, not the booking engine. The MMP reconciles the ad click to the install and then to the in-app booking event, and on iOS it blends deterministic signal with probabilistic and AdAttributionKit data to recover conversions that a SKAdNetwork-only setup would lose. MMP benchmarks in 2025 report roughly 70% more attributed conversions than SKAN alone on iOS 14.5 and later. This is why mobile, at about 63% of online travel bookings in 2025, cannot be measured off the web spine.

Because the MMP and the booking engine count different events with different windows on different surfaces, they will never reconcile to the unit. The trader maintains a reconciliation gap, reports it, and investigates only when it moves outside its normal band, rather than pretending one number is the truth.

:::quiz
question: A booking completes inside the OTA's iOS app 40 days after the install. Which system is positioned to credit it back to the ad?
- The web booking-confirmation pixel
- The MMP, ideally with AdAttributionKit re-engagement signal
- A third-party cookie set at first impression
- The server-side web conversion import
answer: 1
hint: There is no web page inside a native app, and SKAN alone truncates the window.
explain: In-app bookings are the MMP's job. The web pixel and the server-side web import never see an in-app event, and a SKAN-only setup would likely miss a booking 40 days out because the postback already fired. AdAttributionKit restores configurable re-engagement windows that let the MMP keep crediting late in-app bookings.
:::

:::predict
prompt: The web booking engine reports 1,000 bookings for a flight client. The app MMP independently attributes 1,150 in-app bookings to ads over the same period. Using the booking-engine count of 1,000 as the base, what is the web-vs-app reconciliation gap?
answer: 15
tolerance: 0.5
unit: %
hint: Take the absolute difference over the base count.
explain: |1,000 - 1,150| / 1,000 = 150 / 1,000 = 0.15, a 15 percent gap. This is normal in travel because the two systems measure different surfaces, events, and windows. You report 1,000 web and 1,150 app, you do not average them into one fictional number.
:::

# First-party audiences and the match rate

The measurement spine also feeds the audiences. The trader builds first-party segments from past bookers, abandoners keyed to specific property or route IDs, and loyalty tiers, then uploads hashed identifiers to the DSP or platform to activate them. Not every record finds a match, so match rate is the gate on how much of your owned audience you can actually reach. A low match rate quietly shrinks an addressable pool the client thinks is fully usable.

Match rate is the matched records over the records uploaded:

$$ \text{match rate} = \frac{\text{records matched}}{\text{records uploaded}} $$

:::predict
prompt: The trader uploads 10,000 first-party past-booker records to the DSP and 6,500 match to an addressable identifier. What is the match rate?
answer: 65
tolerance: 0.5
unit: %
hint: Matched records divided by records uploaded.
explain: 6,500 / 10,000 = 0.65, a 65 percent match rate. The other 35 percent are unaddressable through that platform, so a "10,000-person" audience is really a 6,500-person reachable audience, and the bid plan should be sized to the latter.
:::

:::widget barChart
title: Bookings credited as the measurement spine is built up
labels: Client pixel only, Plus server-side import, Plus MMP app events, Cross-surface suppressed
data: 60, 82, 93, 98
unit: % of true bookings represented
:::

# Cross-surface suppression, the waste valve the desk owns

Suppression is the single biggest waste recovery the trader controls, and in travel it has to span surfaces. The moment a user books, they must be removed from retargeting on every surface: an in-app booker pulled out of web retargeting and a web booker pulled out of app retargeting. When suppression is wired on only one surface, which is the common failure because roughly 63% of bookings are mobile while retargeting often still runs web-only, the desk keeps paying to chase travelers who already bought.

Suppression coverage is the share of booked users actually suppressed across both surfaces, and the leakage is its inverse. Closing this loop is pure margin, because every suppressed impression is spend redirected from a guaranteed non-converter to a real prospect.

$$ \text{suppression coverage} = \frac{\text{booked users suppressed across surfaces}}{\text{total booked users}} $$

:::predict
prompt: A campaign confirms 2,000 bookings. Cross-surface suppression removes 1,800 of those users from all retargeting, but 200 keep getting served because they booked in the app and suppression was wired web-only. What is the suppression leakage rate?
answer: 10
tolerance: 0.5
unit: %
hint: Leakage is the un-suppressed booked users over total booked users.
explain: 200 / 2,000 = 0.10, a 10 percent leakage rate (and 90 percent coverage). Those 200 in-app bookers are pure waste: the desk is paying to retarget trips already booked, which is exactly the leak that web-only suppression creates.
:::

:::callout warning
A recurring operator complaint is that nobody owns the web-pixel-versus-MMP reconciliation, so finance and the desk argue for weeks over which booking number is "real," and that server-side or offline conversions arrive late and unevenly, swinging reported CPB after the spend is already done. The fix is ownership, not a magic number: name an owner for the reconciliation, dedupe on booking ID, report web and app separately with the gap stated, and set expectations that late server-side imports will revise CPB upward for days after a flight ends.
:::

# Putting the spine together

A complete travel measurement spine is four wired pieces working at once: a client booking pixel, a server-side or offline import on a long window, an app MMP for in-app bookings, and cross-surface post-booking suppression. Skip any one and the CPB story breaks. Skip the server-side import and late bookings vanish; skip the MMP and every in-app booking is missing; skip cross-surface suppression and the desk burns budget on booked travelers.

The discipline is to treat web-pixel bookings and MMP-attributed app bookings as two separate inputs that you reconcile and report side by side, never a single forced figure. Get this plumbing right and every downstream number, the CPB target, the pacing read, and the incrementality test, finally rests on data that can be trusted.

:::quiz
question: Which combination is the minimum viable travel measurement spine?
- Client booking pixel only, with a 7-day click window
- Client pixel plus server-side import, web surface only
- Client pixel, server-side or offline import, app MMP, and cross-surface suppression
- App MMP only, since most bookings are mobile
answer: 2
hint: Travel has a long lag, two surfaces, and a waste leak that suppression closes.
explain: The minimum spine is all four pieces. A short web-only setup misses late bookings and every in-app booking, and an MMP-only setup misses all web bookings. You need the client pixel, the long-window server-side import, the app MMP, and cross-surface suppression together.
:::

:::sources
- AppsFlyer, Travel and Local App Attribution and Marketing Analytics | https://www.appsflyer.com/solutions/travel-local/
- AppsFlyer, Travel app marketing trends in 2025, retargeting leads the way | https://www.appsflyer.com/blog/mobile-marketing/travel-app-marketing-trends/
- Adjust, AdAttributionKit vs SKAdNetwork, what is the difference | https://www.adjust.com/blog/adattributionkit/
- Condor Ferries, Over 70 Online Travel Booking Statistics 2025 | https://www.condorferries.co.uk/online-travel-booking-statistics
- Google Ads Help, About offline conversion imports and import windows | https://support.google.com/google-ads/answer/2998031
- Hospitality Net, RateGain Consolidates MarTech Capabilities Under Sojern | https://www.hospitalitynet.org/news/4131164/rategain-consolidates-martech-capabilities-under-sojern-creating-the-worlds-largest-source-of-travel-intent-data
- calc4marketers, Average ROAS for Travel Advertising 2026 | https://www.calc4marketers.com/average-roas-travel
:::
