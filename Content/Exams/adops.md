---
track: adops
title: Ad Operations Certification
pass: 0.7
draw: 12
---
:::q Lifecycle & Pacing
question: A $90,000 line item is 6 days into a 30-day flight and has spent $12,000. How is it pacing?
- On track, pacing index 1.0
- Over-pacing, pacing index about 1.5
- Under-pacing, pacing index about 0.67
- On track, pacing index 0.2
answer: 2
explain: Pacing index = (spend/budget) / (days/flight) = (12,000/90,000) / (6/30) = 0.133/0.20 = 0.67. Below 1.0 means it is delivering slower than an even pace and needs a bump.
:::
:::q Trafficking
question: In an ad server, a sponsorship line item at a $5 CPM and a standard line item at a $12 CPM both target the same impression. Which serves?
- The $5 sponsorship, because line-item priority is evaluated before price
- The $12 standard, because the higher CPM always wins
- Neither, the two cancel out
- Whichever line item was trafficked first
answer: 0
explain: The ad server checks line-item priority before price. Sponsorship outranks standard, so the $5 sponsorship serves even though its CPM is lower.
:::
:::q Tags & Macros
question: A third-party image tag is trafficked with no cachebuster, and about 25% of calls are served from browser cache. What share of true impressions does the buyer's server measure?
- 100%
- 25%
- 125%
- 75%
answer: 3
explain: Cached responses reuse a stored copy and skip the impression call, so the server logs only the 75% that were not cached. A cachebuster forces a fresh call every time.
:::
:::q Creative & QA
question: A publisher caps initial load at 150 KB for a 300x250. Which creative passes pre-launch QA?
- A 220 KB initial-load HTML5 unit
- A 140 KB initial-load HTML5 unit over HTTPS with a working click tracker
- A 140 KB unit served over plain HTTP
- A 165 KB static image
answer: 1
explain: It is under the 150 KB initial-load cap, served securely over HTTPS, and its click tracker fires. The others fail on weight or on the SSL requirement.
:::
:::q Video & VAST
question: A non-skippable CTV line item fires 500,000 impression beacons and 490,000 complete beacons. What is the video completion rate?
- 2%
- 49%
- 98%
- 102%
answer: 2
explain: VCR = complete / impression = 490,000/500,000 = 0.98. Non-skippable CTV completes nearly every impression, so a 98% VCR is normal there.
:::
:::q Video & VAST
question: A player receives a VAST response that only redirects to another VAST URL, with no media file. What is it?
- A wrapper VAST ad
- An inline VAST ad
- A VAST 303 no-ads error
- A companion ad
answer: 0
explain: A wrapper points to another VAST document rather than carrying the media. The player follows the chain until it reaches an inline ad with the actual file and tracking.
:::
:::q Brand Safety & Verification
question: What is the difference between pre-bid and post-bid brand safety?
- Pre-bid filters the opportunity before you bid, post-bid measures and can block after the ad could serve
- Pre-bid is for video, post-bid is for display
- They are two names for the same control
- Post-bid always wastes less spend than pre-bid
answer: 0
explain: Pre-bid avoidance filters inventory before you bid, so you do not pay for unsuitable impressions. Post-bid monitors what served and can block rendering, but the impression was already transacted.
:::
:::q Brand Safety & Verification
question: An advertiser applies a very large keyword blocklist and reach drops sharply with little safety gain. What is the most likely problem?
- The blocklist is too small
- Viewability is set too high
- The verification vendor stopped reporting
- Over-blocking from broad or ambiguous keywords is filtering safe inventory
answer: 3
explain: Over-broad keyword blocking catches benign pages (the classic sports-injury example), cutting reach and working media with no matching safety benefit. Blocklists need tuning, not just length.
:::
:::q Consent & Privacy
question: Under the IAB TCF, a user gives no consent for personalized advertising. What should happen downstream?
- The bid request is dropped entirely
- Personalized targeting and measurement are suppressed for that user
- The user is shown twice as many ads
- Nothing changes
answer: 1
explain: A missing or negative TCF signal means vendors must not use personal data for those purposes, so personalized targeting and measurement are suppressed. Contextual delivery may still be allowed.
:::
:::q Discrepancies
question: A publisher's ad server counts 1,200,000 impressions and the buyer's counts 1,080,000. By contract the publisher's server is the system of record. What is the discrepancy, and which number bills?
- 10%, and it bills on the buyer's count
- 11%, and it bills on the buyer's count
- 10%, and it bills on the publisher's count (the system of record)
- 5%, and it bills on the publisher's count
answer: 2
explain: Discrepancy = (1,200,000 - 1,080,000) / 1,200,000 = 10%, right at the threshold treated as normal. With the publisher's ad server as the contractual system of record, billing is on its count.
:::
:::q Lifecycle & Pacing
question: A $60,000 line item runs a 20-day flight. Eight days in it has spent $30,000. How is it pacing?
- On track, pacing index about 1.0
- Over-pacing, pacing index about 1.25
- Under-pacing, pacing index about 0.8
- Over-pacing, pacing index about 2.5
answer: 1
explain: Pacing index = (spend/budget) / (days/flight) = (30,000/60,000) / (8/20) = 0.50/0.40 = 1.25. Above 1.0 means it is spending ahead of schedule and will exhaust the budget early unless throttled.
:::
:::q Lifecycle & Pacing
question: A $120,000 campaign runs a 24-day flight. After 9 days it has spent $36,000. Projecting the current daily rate across the full flight, what is the projected end-of-flight spend?
- $144,000
- $108,000
- $84,000
- $96,000
answer: 3
explain: Daily rate = $36,000 / 9 days = $4,000 per day. Projected end spend = $4,000 x 24 days = $96,000, which is $24,000 (about 20 percent) under the $120,000 budget. The line is under-delivering and needs spend accelerated.
:::
:::q Trafficking
question: In Google Ad Manager, a priority-4 sponsorship line item at a $4 CPM and a priority-12 price-priority line item at an $18 CPM are both eligible for the same impression. Which serves, and at what CPM?
- The sponsorship, at a $4 CPM, because priority is checked before price
- The price-priority line, at an $18 CPM, because the higher CPM wins
- Neither, because the CPMs are too far apart
- Whichever was trafficked first
answer: 0
explain: Priority is the first gate and the lower number wins, so the priority-4 sponsorship beats the priority-12 line outright and serves at its $4 CPM. CPM only breaks ties within the same priority tier, so the $18 bid never gets to compete.
:::
:::q Trafficking
question: A guaranteed line item is booked for 9,000,000 impressions over a 45-day flight, paced evenly. How many impressions per day must it deliver to finish on time?
- 450,000
- 300,000
- 200,000
- 150,000
answer: 2
explain: Impressions per day = goal / flight days = 9,000,000 / 45 = 200,000 per day. Fall behind that daily number and the remaining days must each carry more to catch up, or the line under-delivers and risks a make-good.
:::
:::q Tags & Macros
question: A placement truly serves 2,000,000 impressions, but its third-party tag has no cachebuster, so 35% of the calls are answered from the browser cache and never reach the ad server. How many impressions does the ad server actually measure?
- 2,000,000
- 700,000
- 1,650,000
- 1,300,000
answer: 3
explain: Measured = true x (1 - c) = 2,000,000 x (1 - 0.35) = 2,000,000 x 0.65 = 1,300,000. The 700,000 cached calls render to users but never reach the counting server, so the buyer under-reports delivery on a campaign that actually served in full.
:::
:::q Tags & Macros
question: A buyer's server measures 900,000 impressions on a tag with no cachebuster, and the cache rate is believed to be 25%. Using measured = true x (1 - c), what was the true number of impressions served?
- 1,125,000
- 1,200,000
- 675,000
- 1,000,000
answer: 1
explain: Run the relationship backward: true = measured / (1 - c) = 900,000 / (1 - 0.25) = 900,000 / 0.75 = 1,200,000. The 300,000 gap was served but answered from cache, so the fix is a cachebuster macro, not more budget.
:::
:::q Creative & QA
question: A 300x600 half-page HTML5 creative ships 130 KB of images, a 60 KB JS library, and 45 KB of HTML and CSS on initial load, all gzipped. The IAB initial-load cap for this size is about 250 KB. How much headroom is left before it fails the limit?
- About 15 KB
- About 85 KB
- The creative is already 35 KB over the cap
- About 50 KB
answer: 0
explain: Initial load = 130 + 60 + 45 = 235 KB. The cap is about 250 KB, so 250 minus 235 leaves about 15 KB of headroom. It passes, but barely, so one more asset would push it over.
:::
:::q Creative & QA
question: An HTML5 banner runs a 3-second animation sequence and the IAB allows it to loop a maximum of 3 times before resting on a static frame. What is the maximum total animation time, and is it within the IAB ceiling?
- 9 seconds, but it exceeds the 8-second ceiling
- 6 seconds, within the ceiling
- 9 seconds, within the 15-second ceiling
- 15 seconds, exactly at the ceiling
answer: 2
explain: Total = loop length x max loops = 3 seconds x 3 = 9 seconds, which is within the IAB 15-second animation ceiling. After the third loop the banner must hold on a final static frame.
:::
:::q Video & VAST
question: A skippable in-stream line item fires 250,000 impression beacons and 210,000 complete beacons. What is the video completion rate?
- 19%
- 84%
- 119%
- 40%
answer: 1
explain: VCR = complete / impression = 210,000 / 250,000 = 0.84, an 84 percent completion rate. Each beacon is its own tracking URL the player fired, and 84 percent on a skippable unit is strong because viewers can skip and many did not.
:::
:::q Brand Safety & Verification
question: A campaign can reach 80,000,000 monthly impressions at the floor tier. Moving to the standard tier removes the 15% in high-risk categories, and moving to the high tier removes a further 10% of the original pool for medium-risk. How many impressions remain reachable at the high tier?
- 60,000,000
- 68,000,000
- 56,000,000
- 72,000,000
answer: 0
explain: Both cuts are measured against the original 80,000,000 pool, so the high tier strips 15% plus 10% = 25%. 80,000,000 x (1 - 0.25) = 60,000,000 impressions remain. You subtract 25 percentage points rather than compounding the two cuts.
:::
:::q Consent & Privacy
question: A user has Global Privacy Control enabled in their browser and the page falls under a US state that requires honoring universal opt-outs. What must the stack do with the signal?
- Ignore it, because GPC is not an official IAB consent string
- Honor it only if the user also clicks the CMP banner
- Honor it as a binding opt-out of sale and sharing, and reflect it in the GPP string
- Apply it to first-party data only, never to programmatic
answer: 2
explain: GPC is a recognized universal opt-out preference sent as a browser header. States that require honoring universal opt-outs treat an enabled GPC signal as a binding opt-out of sale and sharing, so the CMP must detect it and encode the opt-out into the GPP string, without the user touching the banner.
:::
:::q Consent & Privacy
question: A market holds 4,000,000 reachable users and the CMP reports a 65% opt-in rate for personalized advertising. How many users are addressable for personalized targeting?
- 1,400,000
- 2,600,000
- 3,350,000
- 4,000,000
answer: 1
explain: Addressable = reachable x opt-in rate = 4,000,000 x 0.65 = 2,600,000 users. The other 1,400,000 declined personalization, so they can only be reached contextually and measured with non-consent methods like aggregated or modeled reporting.
:::
:::q Discrepancies
question: The seller (publisher) ad server reports 1,500,000 impressions at ad request. The buyer's DSP reports 1,275,000 rendered impressions for the same line, and the seller is the system of record. What is the discrepancy?
- 5%
- 18%
- 12%
- 15%
answer: 3
explain: Discrepancy = (seller count - buyer count) / seller count = (1,500,000 - 1,275,000) / 1,500,000 = 225,000 / 1,500,000 = 0.15, a 15 percent discrepancy. That is well above the roughly 10 percent normal band, so it gets investigated rather than absorbed.
:::
:::q Discrepancies
question: A guaranteed buy was sold for 3,000,000 impressions at a $10.00 CPM and delivered 2,600,000. The advertiser still wants the reach and there is time to deliver it. What make-good is owed?
- A $4,000 credit, since make-goods are not allowed here
- 3,000,000 bonus impressions, re-running the whole order
- 400,000 bonus impressions delivered at no charge
- 260,000 bonus impressions delivered at no charge
answer: 2
explain: Shortfall = guaranteed - delivered = 3,000,000 - 2,600,000 = 400,000 impressions. A make-good runs that many bonus impressions at no charge, sized to the shortfall rather than padded. A credit would instead be worth (400,000 / 1000) x $10.00 = $4,000, but the advertiser wants the reach, so the make-good is the right tool.
:::
