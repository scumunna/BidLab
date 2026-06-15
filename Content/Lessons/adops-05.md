---
id: adops-05
track: adops
module: 5
title: VAST and Video Delivery
summary: How a VAST XML response tells a player where the video lives and which tracking URLs to fire, the quartile beacons that drive completion math, wrappers versus inline, VMAP pods, and the move from VPAID to OM SDK.
---
# The XML that hands a player an ad

VAST stands for Video Ad Serving Template. It is an IAB Tech Lab standard, and at its core it is a single XML response that an ad server returns to a video player. That XML does two jobs. First, it tells the player where the actual video file lives, the MediaFile URL the player will fetch and play. Second, it lists a set of tracking URLs the player must fire at specific moments, so the seller, the buyer, and any verification vendor can each count what happened.

The player is the thing that runs the show. The ad server does not stream the video and does not watch playback. It only ships an instruction sheet. The player parses the XML, downloads the creative, plays it, and along the way calls the tracking URLs at the right milestones. Nothing is reported back over a session; every event is just a separate fire-and-forget HTTP request to a URL the VAST document handed over.

A VAST response is either an InLine ad, which carries the full creative and all its tracking, or a Wrapper, which carries no creative of its own and instead points at another VAST URL to resolve. Current production uses VAST 4.x, with VAST 4.3 (December 2022) the latest from IAB Tech Lab.

:::quiz
question: In the VAST model, which component actually fires the tracking URLs during playback?
- The ad server that returned the VAST XML
- The video player parsing and playing the response
- The DSP that won the auction
- The verification vendor's servers
answer: 1
hint: The ad server only ships an instruction sheet; something else watches playback.
explain: The video player parses the VAST XML, fetches the MediaFile, and fires each tracking URL at the right milestone. The ad server never sees playback; it only returns the document that lists where the video is and which URLs to call.
:::

# Quartile beacons, one URL per milestone

Once the player starts the creative, it fires a tracking call at each playback milestone listed in the VAST. The impression beacon fires when the ad renders. Then start fires as playback begins, firstQuartile at 25 percent watched, midpoint at 50 percent, thirdQuartile at 75 percent, and complete at 100 percent. Each of these is a separate URL call, an ordinary HTTP GET to its own endpoint. There is no single "report" payload; the player walks the timeline and pings a different URL as it crosses each mark.

That granularity is the point. Because every milestone is its own beacon, a buyer can see exactly where viewers drop off. If start fires 100,000 times but thirdQuartile only fires 60,000 times, 40 percent of viewers bailed before the three-quarter mark, and you learn that without any guesswork. VAST 4.1 later added events like loaded and closeLinear, but the six core milestones above are what every completion and drop-off calculation is built on.

:::figure vastFlow
caption: The player fetches the VAST XML, downloads the MediaFile, then fires a separate tracking URL at the impression and at each quartile through complete.
:::

:::predict
prompt: A campaign fires 100,000 start beacons and 72,000 thirdQuartile beacons. What share of viewers dropped off before reaching the 75 percent mark?
answer: 28
tolerance: 0.5
unit: %
hint: Drop-off is the share that did not reach thirdQuartile, relative to start.
explain: 72,000 / 100,000 = 0.72 reached the 75 percent mark, so 1 - 0.72 = 0.28, a 28 percent drop-off before thirdQuartile. Each beacon is its own URL fire, which is exactly why you can measure the gap between milestones.
:::

# Wrapper versus inline, and the chain it builds

An InLine VAST is self-contained. It holds the MediaFile, the tracking events, the companion ads, everything the player needs to render and measure the ad with no further calls. A Wrapper holds none of that. It is a pointer: a small VAST document whose job is to redirect the player to another VAST URL, often at a different ad server, which the player then fetches and resolves. The wrapper still carries its own tracking URLs, so each hop in the chain gets to count the impression and the quartiles too.

This chaining is how the supply chain stacks measurement. A typical path goes publisher ad server, then SSP, then DSP, then the creative ad server, each returning a wrapper that adds its tracking and redirects onward, until one server finally returns an InLine response with the real video. The cost is latency and fragility: every redirect is another round trip that can time out or break. VAST caps the chain with a wrapper limit and a redirect timeout precisely because long wrapper chains are a common failure point.

Two related pieces ride on the same XML. Companion ads are the banner units a VAST response can declare to show alongside or after the video, for example a 300x250 next to the player. And VMAP (Video Multiple Ad Playlist) is a separate IAB template that sits above VAST: it schedules ad breaks (pre-roll, mid-roll, post-roll) and ad pods (several ads in sequence in one break) by timeOffset, then points each break at a VAST tag the player executes at that cue point.

:::quiz
question: A VAST response contains no MediaFile and instead points the player to another VAST URL at a different ad server. What is it?
- An InLine ad
- A Wrapper ad
- A VMAP playlist
- A companion ad
answer: 1
hint: It carries no creative of its own, only a redirect plus its own tracking.
explain: That is a Wrapper. It holds no video itself; it redirects the player to another VAST URL to resolve, while still carrying its own tracking beacons. An InLine response is the one that finally carries the actual MediaFile.
:::

# When VAST breaks, the error code says where

When a player cannot use a VAST response, it fires the Error URL with a numeric code, and those codes tell you where in the chain it failed. They cluster by category. The 100s are document problems: 100 is a malformed or invalid XML parse error (or a redirect URL that will not resolve), 101 is schema validation failure, 102 is an unsupported VAST version. The 300s are wrapper problems: 301 is a redirect that did not return a valid VAST within the timeout (default 5 seconds), 302 is the wrapper limit reached on a redirect loop, and 303 is the common one, an empty VAST response with no ads after the wrappers resolve. The 400s are linear creative problems: 402 is a MediaFile that failed to download or timed out, 401 is a MediaFile not found, and 403 is all MediaFiles having unsupported MIME types for the device.

The practical read: a flood of 303s usually means no-fill upstream, not a bug in your tag. A spike in 402s points at a slow or broken CDN serving the video. And 100s mean the XML itself is bad, often a mangled macro or an ad server returning an error page instead of VAST.

:::quiz
question: Your CTV channel suddenly logs a wave of VAST error 303 across multiple demand partners. What does that most likely indicate?
- The video CDN is down and creatives will not load
- An empty VAST response, meaning no ads were returned after the wrappers resolved
- The player cannot parse the XML at all
- The MediaFile MIME types are unsupported on the device
answer: 1
hint: 303 is about whether any ad came back, not about the creative itself.
explain: Error 303 is an empty VAST response, no ads after the wrappers resolve, which points to no-fill upstream rather than a creative or parsing fault. A CDN failure shows up as 402 (download or timeout), an unreadable document as 100, and bad MIME types as 403.
:::

# Verification moved off VPAID

For years, interactive and measurable video ran on VPAID, an executable creative that ran its own code inside the player. It worked, but it was a security and performance liability: arbitrary code in the player meant latency, breakage, and an attack surface, and many CTV and in-app environments never supported it well. IAB Tech Lab deprecated VPAID and split its two jobs into safer, purpose-built standards. Interactivity moved to SIMID (Secure Interactive Media Interface Definition), which sandboxes the interactive layer away from the media. Measurement moved to OMID, the Open Measurement Interface Definition, implemented through the OM SDK.

For a trader, the practical effect is what carries viewability and verification now. VAST 4.x declares verification vendors in an AdVerifications node, and the OM SDK collects viewability and verification signals through one unified API across web, app, and CTV, no executable creative required. The modern stack publishers run is VAST plus SIMID plus OMID, which lets them turn VPAID off and shed its latency.

:::callout key
On a clean VAST 4.x video buy, viewability and third-party verification come from the OM SDK (OMID), not VPAID. If a partner still requires VPAID creative, expect higher latency, more breakage, and weak or no support in CTV and in-app.
:::

:::quiz
question: On a clean VAST 4.x video buy, what carries viewability and third-party verification now that VPAID is deprecated?
- VPAID, still the standard for measurement
- The OM SDK (OMID), declared in the VAST AdVerifications node
- A 1x1 image pixel in the companion slot
- The video player's own analytics only
answer: 1
hint: IAB split VPAID's two jobs into SIMID for interactivity and one standard for measurement.
explain: Measurement moved to OMID, the Open Measurement Interface Definition, run through the OM SDK and declared in VAST 4.x AdVerifications. It collects viewability and verification across web, app, and CTV with no executable creative, which is why publishers can turn VPAID off.
:::

# Video completion rate, the headline number

Video completion rate (VCR) is the share of started, or rendered, video ads that played all the way to the end. Because every milestone is its own beacon, the math is just one beacon count divided by another. VCR is the complete beacons over the impression beacons.

$$ \text{VCR} = \frac{\text{complete beacons}}{\text{impression beacons}} $$

Read it against the quartile curve, not in isolation. A high VCR on a skippable in-stream unit means something different from the near-100 percent VCR you see on non-skippable CTV, where the spot cannot be skipped and almost every impression completes. The quartile beacons between impression and complete are what tell you whether a low VCR is gradual fatigue or a cliff at one specific point.

:::predict
prompt: A video line item fires 100,000 impression beacons and 55,000 complete beacons. What is the video completion rate?
answer: 55
tolerance: 0.5
unit: %
hint: VCR is complete beacons divided by impression beacons.
explain: 55,000 / 100,000 = 0.55, a 55 percent VCR. Both numbers are just separate tracking URLs the player fired, complete divided by impression.
:::

:::predict
prompt: On a non-skippable CTV buy, the player fires 200,000 impression beacons and 196,000 complete beacons. What is the VCR?
answer: 98
tolerance: 0.5
unit: %
hint: Same formula: complete over impression.
explain: 196,000 / 200,000 = 0.98, a 98 percent VCR. Non-skippable CTV completes almost every impression, which is why a 98 percent VCR there is normal while the same number on skippable in-stream would be remarkable.
:::

:::sources
- IAB Tech Lab, Video Ad Serving Template (VAST) 4.3 spec | https://iabtechlab.com/wp-content/uploads/2022/09/VAST_4.3.pdf
- IAB Tech Lab, Digital Video Ad Serving Template (VAST) guidelines | https://www.iab.com/guidelines/vast/
- IAB Tech Lab, VAST 4.1 and Open Measurement video verification | https://iabtechlab.com/vast-4-1-open-measurement-the-long-awaited-video-verification-solution/
- IAB, Video Multiple Ad Playlist (VMAP) | https://www.iab.com/guidelines/vmap/
- Google Ad Manager Help, Understand VAST error codes | https://support.google.com/admanager/answer/4442429?hl=en
- AdExchanger, VPAID Is Out, And The IAB Tech Lab Says It Has Its Replacement | https://www.adexchanger.com/ad-exchange-news/vpaid-iab-tech-lab-says-replacement/
- Google for Developers, Enable Open Measurement (OM SDK) for IMA | https://developers.google.com/interactive-media-ads/docs/sdks/android/client-side/omsdk
- Publift, All VAST Error Codes and Ways to Resolve Them | https://www.publift.com/blog/vast-errors
:::
