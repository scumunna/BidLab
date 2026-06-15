---
id: adops-11
track: adops
module: 11
title: CTV, Audio, and DOOH Operations
summary: How streaming ads get stitched in server side, why pods and competitive separation matter, how frequency runs wild across apps, how digital audio rides the same VAST plumbing as video, and how DOOH turns one ad play into many counted impressions.
---
# Streaming is not one screen, it is many doors into the same living room

Connected TV (CTV) looks like television, but operationally it is a stack of separate apps, each its own little walled garden. A household streams through a smart TV operating system, a couple of free ad-supported apps, and a subscription tier with ads. Each of those apps sells its own inventory, runs its own ad decisioning, and counts its own impressions. None of them sees what the others served. So the same person can be hit by the same spot in three different apps in one evening, and each app honestly reports a clean, capped delivery on its side.

That fragmentation is the root of the two problems an ops person fights in CTV: frequency that no single app can see across, and ad breaks (pods) that have to be filled and ordered without two competing brands landing back to back. Both problems exist because the decisioning happens per app, often on a server the viewer never touches, not in one place that sees the whole household.

The job in CTV operations is to make a medium that is sold like TV (guaranteed, premium, pod-based) behave under programmatic plumbing that was built for the open web. The seams show up exactly where those two worlds meet.

:::figure ctvAd
caption: A CTV impression is decided per app, so one household reached through several apps looks like several unrelated deliveries.
:::

:::quiz
question: Why is cross-app frequency so hard to control in CTV?
- Players refuse to fire frequency beacons on smart TVs
- Each app decisions and counts its own impressions and cannot see what other apps served the same household
- CTV does not support frequency caps at all
- The viewer clears cookies between apps
answer: 1
hint: Think about where the ad decision happens and who can see across it.
explain: Each streaming app is its own walled garden that decisions and counts independently. No single app sees the household's exposure in the other apps, so a per-app cap of 3 can still add up to 9 across three apps. Caps work fine inside one app; the gap is between apps.
:::

# Pods and competitive separation

A CTV ad break is a pod, a sequence of slots filled in one break the way a linear TV commercial break holds several spots. A two-minute break at four fifteen-second slots is a four-slot pod. Filling a pod is not just stacking whatever bids highest. The pod has rules that come straight from the linear TV playbook, and the SSAI server or ad server that assembles the pod has to enforce them.

The big one is competitive separation, also called category exclusivity. Two ads from competing brands in the same category, two car insurers, two fast food chains, must not run adjacent or sometimes not in the same pod at all. A viewer who sees a burger ad immediately followed by a competing burger ad notices, and the advertiser who paid for the break does not want to hand attention to a rival one slot later. The pod builder reads each candidate ad's category and refuses to place two of the same category side by side.

The other pod controls mirror linear too: first-slot ownership (a brand can buy the first, most-watched position in the break), buy-side frequency management (do not show the same creative twice in one pod), and dedup so the same advertiser does not appear three times in a four-slot break. All of this runs in the pod assembly step, which is why where that step happens, client or server, matters so much.

:::callout key
Competitive separation is a pod-assembly rule, not a bidding rule. The auction can return two car-insurer ads as the top two bids; the pod builder is what keeps them from landing in adjacent slots.
:::

:::quiz
question: A four-slot CTV pod returns top bids from two competing pizza chains for slots one and two. What should the pod builder do?
- Place both, highest bid first, since the auction decided
- Apply competitive separation so the two same-category ads are not adjacent
- Drop the entire pod and go unfilled
- Show both pizza ads back to back to maximize revenue
answer: 1
hint: The auction ranks by price; pod assembly enforces a different rule on top of it.
explain: Competitive separation (category exclusivity) is enforced at pod assembly, after the auction ranks bids. The builder keeps the two same-category ads out of adjacent slots, usually by sliding one to a non-adjacent slot or swapping in the next eligible bid, not by going unfilled or stacking them.
:::

# SSAI stitches the ad into the stream

Server-side ad insertion (SSAI), sometimes called ad stitching, is the dominant way CTV serves ads. Instead of the player calling out for an ad and dropping it into a slot (client-side insertion), a server splices the ad content directly into the video stream before it reaches the device. The viewer gets one continuous stream where content and ads are the same kind of segments, frame-accurate, no buffering gap at the break, and much harder for an ad blocker to strip out. That seamless, broadcast-like experience is the main reason CTV leans on SSAI.

The tradeoff is measurement. Because the server fetched and stitched the ad, the server is now between the player and the tracking beacons. Client-side VAST counts on the player to fire impression and quartile beacons; under SSAI, the server often proxies or fires those events, and the player may not run third-party verification code the way a browser would. To keep counts honest, the industry leans on standards: VAST 4.x specifies which HTTP headers (like the real user agent and client IP) the SSAI server must forward so the ad server can attribute the impression to the actual device, and ads.cert and OpenRTB 2.6 work to authenticate that a stitched impression is genuine and not spoofed.

For an ops person, the practical read is this: SSAI gives the clean viewer experience but moves the burden of accurate counting and forwarded signals onto the stitching server. When CTV verification or viewability looks thin, the SSAI configuration (are the right headers and beacons being forwarded?) is the first place to look.

:::figure vastFlow
caption: Under SSAI the stitching server fetches the VAST ad and splices it into the stream before it reaches the device, so the server, not the player, sits between playback and the tracking beacons.
:::

:::quiz
question: What is the main measurement tradeoff of SSAI versus client-side insertion?
- SSAI cannot serve VAST at all
- SSAI gives a seamless stream but puts the server between the player and the tracking beacons, so headers and events must be forwarded carefully
- SSAI doubles every impression count automatically
- SSAI only works on mobile web, not CTV
answer: 1
hint: The benefit is the seamless stitched stream; the cost shows up in who fires the beacons.
explain: SSAI stitches ad and content into one stream for a seamless, block-resistant experience, but the stitching server now sits between the player and the beacons. VAST 4.x defines which headers the server must forward (user agent, client IP) so impressions attribute to the real device. Misconfigured forwarding is where CTV counts and verification go wrong.
:::

# Digital audio rides the same plumbing as video

Digital audio ads, streaming music, and podcasts use the exact same serving template as video. The old separate audio spec, DAAST, was folded into VAST starting with VAST 4.1, which added audio support directly, so today an audio ad server returns a VAST response with an audio MediaFile instead of a video one. Same wrapper and inline model, same start and quartile and complete tracking events, same error codes. If you can read a VAST tag for video, you can read one for audio.

Podcasts add one wrinkle that streaming audio does not have: the download versus impression distinction. The IAB Podcast Measurement Technical Guidelines (version 2.x) define a counted download as a request where the listener pulled enough of the file to credibly start it, with rules to filter bots and partial range requests. But a download is not proof the ad was heard. Dynamically inserted ads (DAI), stitched into the episode at request time much like SSAI on the video side, let the host count the ad delivery as an impression rather than relying on the raw file download, which is why dynamic insertion is now standard for monetized shows. The guidelines deliberately push toward confirming the ad was delivered, not just that a file was requested.

So the audio ops mental model is two layered standards: VAST for how the ad is served and tracked, and the IAB podcast guidelines for how a legitimate download or impression is counted and filtered.

:::figure audioAd
caption: A digital audio ad is a VAST response with an audio MediaFile, firing the same start, quartile, and complete events as video.
:::

:::quiz
question: After DAAST was folded into VAST, how is a digital audio ad served today?
- Through a proprietary audio-only protocol unrelated to VAST
- As a VAST response with an audio MediaFile, using the same wrapper, inline, and quartile tracking model as video
- As a raw MP3 with no tracking at all
- Only as a host-read live spot with no ad server involved
answer: 1
hint: VAST 4.1 added audio support and the separate audio template was deprecated.
explain: DAAST was merged into VAST starting with VAST 4.1, so audio ads now use the same template as video: a VAST response carrying an audio MediaFile, the same wrapper and inline structure, and the same start, quartile, and complete events. The separate audio spec was deprecated to unify the plumbing.
:::

# DOOH turns one play into many impressions

Programmatic digital out-of-home (pDOOH) buys screens, billboards, mall panels, gym displays, taxi toppers, but it counts people. That gap is the whole operational story. A single ad play on one screen can be seen by a crowd, so DOOH is a one-to-many medium and you cannot equate a play with an impression the way you do on a phone.

The bridge is the impression multiplier. A screen at a given time and place has an estimated audience per play, drawn from foot traffic, dwell time, and audience data. Multiply ad plays by that multiplier to get audience impressions:

$$ \text{impressions} = \text{plays} \times \text{multiplier} $$

If a screen plays a spot 10,000 times and the multiplier for that hour and location is 4, the buy counts $10{,}000 \times 4 = 40{,}000$ impressions. The IAB DOOH Measurement Guide (2025) and the MRC out-of-home standards define how those multipliers and impressions should be built, so buyer and seller count the same way. This also reframes the buy: you are not buying a screen for a flat day rate, you are buying impressions at moments, the high-multiplier hours when the crowd is there, which is what makes DOOH trade programmatically alongside other digital channels.

For ops, two numbers must never be confused. Plays are what the screen physically did, the count the player or CMS reports. Impressions are the modeled audience, plays times multiplier. Discrepancies in DOOH almost always come from someone comparing a play count on one side to an impression count on the other.

:::figure displayAd
caption: One DOOH ad play reaches a crowd, so plays times an audience multiplier give the counted impressions.
:::

:::predict
prompt: A DOOH screen plays a spot 12,000 times during a daypart. The impression multiplier for that screen and hour is 3.5. How many audience impressions does the buy count?
answer: 42000
tolerance: 0
unit:
hint: Impressions equal plays times the multiplier.
explain: Impressions = plays x multiplier = 12,000 x 3.5 = 42,000. Plays are what the screen physically did; the multiplier converts each play into its estimated audience, which is the impression count the buy bills against.
:::

:::predict
prompt: A second DOOH screen plays the same spot 8,000 times at a multiplier of 2.5. Combined with the 42,000 impressions from the first screen, what is the total impression count across both screens?
answer: 62000
tolerance: 0
unit:
hint: Compute the second screen, then add the first screen's 42,000.
explain: Second screen = 8,000 x 2.5 = 20,000 impressions. Total = 42,000 + 20,000 = 62,000. Each screen has its own multiplier, so you convert plays to impressions per screen, then sum, never add raw plays across screens.
:::

# Frequency math across the fragmented stack

Frequency is average impressions per reached person (or household). Across one app it is simple. Across the fragmented CTV stack it is the number that quietly blows up, because each app caps within itself while the household total is the sum.

$$ \text{frequency} = \frac{\text{total impressions}}{\text{deduplicated reach}} $$

The denominator is the trap. If you reach 150,000 unique households and deliver 600,000 impressions, frequency is $600{,}000 / 150{,}000 = 4.0$, fine. But if three apps each report 200,000 impressions against their own reach and you naively add reaches that actually overlap heavily, you undercount the true frequency, because the same households sit in all three apps. Industry estimates put cross-app and cross-platform duplication around 20 to 40 percent or higher at the household level, which is why deduplicated reach (from a cross-app identity or measurement vendor) is the only honest denominator. Without dedup, frequency looks reasonable per app while a slice of households is hammered ten-plus times.

The operational fix is a cap that lives above the apps: a cross-app frequency manager, an SSAI or ad server that the apps share, or a measurement partner that deduplicates households after the fact so the next flight can correct. The headline lesson is that in CTV, frequency is a reach-deduplication problem first and a cap-setting problem second.

:::callout insight
In CTV, frequency lives or dies on the denominator. Per-app caps are easy; the hard part is a deduplicated household reach that sees across the walled gardens.
:::

:::predict
prompt: A CTV campaign delivers 600,000 impressions and a measurement partner reports a deduplicated reach of 150,000 households. What is the average frequency per household?
answer: 4
tolerance: 0
unit:
hint: Frequency is total impressions divided by deduplicated reach.
explain: Frequency = 600,000 / 150,000 = 4.0 impressions per household. The deduplicated reach is what makes this honest; if the three apps' overlapping reaches were added instead, the denominator would be inflated and the true frequency hidden.
:::

:::predict
prompt: Suppose the same 600,000 impressions were instead measured against an inflated reach of 200,000 households because cross-app overlap was not deduplicated. What frequency would that wrongly report?
answer: 3
tolerance: 0
unit:
hint: Use the same formula with the larger, wrong denominator.
explain: 600,000 / 200,000 = 3.0, which understates the real 4.0. Counting overlapping households as if they were distinct inflates the denominator and hides true frequency, the exact failure mode that makes deduplicated reach essential in CTV.
:::

:::sources
- IAB Tech Lab, VAST 4.1: Now With Audio Power (DAAST merged into VAST) | https://iabtechlab.com/vast-4-1-now-with-audio-power/
- IAB Tech Lab, Podcast Measurement Technical Guidelines | https://iabtechlab.com/standards/podcast-measurement-guidelines/
- IAB Tech Lab, CTV Programmatic Guide | https://iabtechlab.com/standards-old/ctv-programmatic-guide/
- IAB, Digital Out-Of-Home (DOOH) Measurement Guide | https://www.iab.com/guidelines/dooh-measurement-guide/
- Broadsign, The Impression Multiplier: What It Is and How It Applies to DOOH | https://broadsign.com/blog/the-impression-multiplier-what-is-it-and-how-does-it-apply-to-dooh/
- AdExchanger, AdExplainer: What Is Server-Side Ad Insertion (SSAI)? | https://www.adexchanger.com/adexplainer/adexplainer-what-is-server-side-ad-insertion-ssai/
- AdExchanger, Fixing CTV Ad Repetition Means Understanding How Ad Tech Enables It | https://www.adexchanger.com/on-tv-and-video/fixing-ctv-ad-repetition-means-understanding-how-ad-tech-enables-it/
- Wowza, Ad Insertion for Streaming Monetization: SSAI vs CSAI vs SGAI | https://www.wowza.com/blog/ad-insertion-sgai-vs-ssai-vs-csai
:::
