---
id: adops-03
track: adops
module: 3
title: Ad Tags, Macros, and Cachebusters
summary: The four tag types you traffic, the click and cachebuster macros that make them count, and the arithmetic of why an un-cachebustered tag undercounts.
---
# What a tag actually is

A core-08 lesson covered what each fire mechanism can see and do (image versus JavaScript versus iframe). This lesson is the trafficking side: the literal block of code a publisher pastes into a placement, the macros you have to wire into it, and the counting failures that follow when you wire them wrong.

A third-party ad tag is the snippet that hands rendering off to someone else's ad server. The publisher's ad server wins the slot, then calls out to the buyer's server (DCM, Sizmek, Flashtalking, Innovid) to actually fetch and draw the creative. Everything in this lesson is about making that handoff count clicks and impressions correctly, because the publisher's server and the buyer's server are two different counting points and they will disagree if the tag is built wrong.

:::callout key
A tag does two jobs at once: it renders a creative, and it carries the placeholders (macros) that let each server in the chain log its own impression and pass the click forward. Get the macros wrong and the creative still shows, so the failure is silent.
:::

:::quiz
question: A third-party tag has a broken click macro but still renders the creative. Why is this the dangerous case?
- The ad fails to show, so the error is caught immediately
- The ad shows normally, so the miscount is silent until reporting is reconciled
- The publisher server refuses to serve the tag
- The browser blocks the creative for being insecure
answer: 1
hint: Think about who notices the failure, and when.
explain: The creative still draws, so nothing looks wrong on the page. The click or impression simply mislogs, and the gap surfaces only later when the two servers are reconciled. Silent failures are the ones that cost real money.
:::

# The four tag types you traffic

There are four shapes a trafficked tag takes, and the choice is driven by what the creative needs to do and how much the publisher trusts the code.

The JavaScript tag is the default for rich media. It runs `document.write` or injects a script into the page, so it can expand, read screen position, and run HTML5. Most expandable, interstitial, and rich-media units require it because the code needs to reach outside its own box.

The iframe tag loads the buyer's server inside a sandboxed inline frame. It is the publisher-safe option: code inside the frame cannot touch the host page, which protects the publisher but also breaks expandables, because the creative is trapped in the frame's dimensions. Publishers who do not trust a buyer's JavaScript hand them an iframe.

The image tag is the simplest, an `<a href>` wrapped around an `<img src>`. No script runs. It is used for static banners, 1x1 tracking pixels, and any context where script is stripped or untrusted. Lowest capability, lowest risk.

The third-party redirect, also called the daisy-chain or piggyback tag, is not a fourth rendering mode so much as a routing pattern. One tag's response is itself another tag, so the call hops server to server: publisher server, then a verification vendor (IAS, DoubleVerify), then the buyer's server, then maybe a DSP, each logging its own event before redirecting forward to the next link. This is how a single placement can fire a viewability vendor, a brand-safety vendor, and the creative all at once. Every hop adds latency and one more place the chain can break.

:::figure pixelFire
caption: Each hop in a daisy-chained redirect fires its own call and logs its own event before passing the request to the next server in the chain.
:::

:::quiz
question: A buyer needs an expandable creative that pushes down the page when a user hovers. The publisher offers you an iframe tag or a JavaScript tag. Which do you take?
- The iframe tag, because it is safer for the publisher
- The JavaScript tag, because the creative must reach outside its own box
- The image tag, because expandables are static
- Either one works identically for expandables
answer: 1
hint: Expanding past the placement boundary means touching the host page.
explain: An expandable has to draw outside its placement, which an iframe sandbox forbids. Only the JavaScript tag can reach the host page, so rich and expandable units require it. The iframe is safer for the publisher but would clip the expansion.
:::

# The click macro and why it wraps the landing URL

A macro is a placeholder the ad server swaps for a real value at serve time. The format is server-specific: Google Ad Manager and Campaign Manager use `%%CLICK_URL_UNESC%%`, Xandr uses `${CLICK_URL}`, others use `${CLICK_URL_ENC}` when the value rides inside another URL as a parameter.

The click macro exists so the publisher's server can log the click before the user leaves. When the ad server fills it, the macro becomes a tracking redirect URL that points back at the ad server. You place it immediately in front of the landing page so the rendered link reads tracker-then-destination:

`%%CLICK_URL_UNESC%%https://www.advertiser.com/landing`

Click that and the browser hits the ad server first, which records the click and then 302-redirects the user on to the advertiser. The wrapping order is the whole point. If the click macro sits after the landing URL, or is left out, the browser goes straight to the advertiser and the click is never counted by that server. In a daisy chain you stack them, so the click hops publisher tracker, then buyer tracker, then destination, each logging on the way through.

Use the unescaped variant (`%%CLICK_URL_UNESC%%`, `${CLICK_URL}`) at the start of an href. Use the escaped variant (`%%CLICK_URL_ESC%%`, `${CLICK_URL_ENC}`) when the tracker is itself a query-string parameter of another URL and its special characters have to survive being passed along.

:::predict
prompt: A line item delivers 2,000,000 impressions at a 0.30% click-through rate. The buyer's click macro was placed after the landing URL instead of in front of it, so the buyer's server logs zero of those clicks. How many clicks does the buyer's server fail to record?
answer: 6000
tolerance: 0
unit:
hint: First find the true click count, then subtract what got logged (zero).
explain: 2,000,000 times 0.0030 equals 6,000 true clicks. With the macro in the wrong position the buyer's server logs none of them, so all 6,000 are lost from that report. The creative still rendered and clicked through fine, which is why this kind of trafficking error hides until reconciliation.
:::

# The cachebuster and the timestamp

The cachebuster solves a different problem: the browser cache. The macro is `%%CACHEBUSTER%%` in Google systems, `${CACHEBUSTER}` in Xandr, and you will see older tags use a literal `[timestamp]` token or an `ord=` ("ordinal") parameter set to a random value. Whatever the spelling, the ad server substitutes a fresh random number every single time the tag serves.

Why it matters: a browser caches a URL it has already fetched. If the impression-counting call is the same URL on every serve, the second time that tag runs the browser can answer from cache and never touch the ad server, so the impression is never logged. Appending a random value makes every call a unique URL, which forces a live request to the server and a recorded impression. That is exactly what the IAB Desktop Display Impression Measurement Guidelines require: cache-busting (a random number or date/timestamp with sufficient granularity, plus Expires and Cache-Control headers) so that impressions are not undercounted from cached responses. The new server-filled tags (for example DCM's `ins` tag) inject the cachebuster automatically, but any hand-trafficked tag you touch you have to check yourself.

In the classic DoubleClick tag the cachebuster lives in `ord=%%CACHEBUSTER%%`; in Sizmek it is `ord=${CACHEBUSTER}`; in Flashtalking it is a `cachebuster=` value seeded from `Math.random()`. Same job in every one: make the URL unique so the cache is forced to miss.

:::predict
prompt: A placement truly serves 1,000,000 impressions, but the tag has no cachebuster, so 30% of the calls are answered from the browser cache and never reach the ad server. How many impressions does the ad server actually measure?
answer: 700000
tolerance: 0
unit:
hint: Only the calls that miss the cache get logged.
explain: 30% of 1,000,000, or 300,000 calls, are served from cache and never logged, leaving 1,000,000 minus 300,000 equals 700,000 measured impressions. The measured count is 70% of the true count, a 30% undercount, purely from a missing macro.
:::

:::callout insight
The cache undercount runs the opposite direction from most discrepancies. Here the buyer's server is the one that loses count, so the buyer under-reports delivery and may look like it underdelivered a guaranteed campaign that actually served in full.
:::

# Putting the math together

Cache undercounting scales with how cacheable the creative is and how often the same user reloads. The relationship is linear and worth carrying in your head: if a fraction c of calls are served from cache, the measured impressions are (1 minus c) of the truth.

$$ \text{measured} = \text{true} \times (1 - c) $$

Run it backward when you suspect a cache problem. If your server logged 850,000 impressions and you believe the cache rate is 15%, the implied true delivery is 850,000 divided by 0.85, which is 1,000,000. The gap is not lost ad serving, it is lost counting, and the fix is a macro, not more budget.

:::predict
prompt: Using measured equals true times (1 minus c): a tag has a 20% cache rate and no cachebuster. The buyer's server measures 1,600,000 impressions. What was the true number of impressions served?
answer: 2000000
tolerance: 0
unit:
hint: Divide the measured count by (1 minus 0.20).
explain: Measured equals true times (1 minus 0.20), so true equals 1,600,000 divided by 0.80, which is 2,000,000. The 400,000 difference was served to users but answered from cache, so it never reached the counting server.
:::

:::quiz
question: What does a cachebuster macro actually do at serve time?
- It blocks the browser from rendering a cached creative image
- It inserts a fresh random value so each call is a unique URL the cache cannot answer
- It encrypts the click URL so competitors cannot read the destination
- It compresses the tag so it loads faster on repeat views
answer: 1
hint: The goal is to force a live request to the counting server on every serve.
explain: The ad server substitutes a unique random value (a number or timestamp) on every serve, so the impression-counting URL is never identical twice. The browser cache has nothing to match, so it must make a live request and the impression gets logged. It is about counting, not rendering, encryption, or speed.
:::

# Trafficking gaps you will actually hit

The two macros fail in opposite ways and both are silent because the creative still renders. A missing or misplaced click macro means the ad shows and clicks through, but a server in the chain logs zero clicks, so click-through and downstream conversion attribution collapse for that server while delivery looks fine. A missing cachebuster means the creative shows every time but the impression call gets cached, so the counting server under-reports delivery and the campaign looks light.

These compound in a daisy chain. If a verification vendor's hop sits between the publisher and the buyer and its cachebuster is missing, the vendor under-measures, and every party downstream that reconciles against the vendor inherits the gap. When two servers disagree by more than the roughly 10% that is treated as normal counting drift, a missing or misplaced macro is the first thing to check, before anyone blames the auction or the inventory.

:::predict
prompt: A buyer's server reports 1,000,000 impressions. A verification vendor one hop earlier in the daisy chain reports 1,200,000 because the buyer's tag is missing its cachebuster. Treating the vendor's number as the truth, what is the discrepancy percentage?
answer: 16.67
tolerance: 0.15
unit: %
hint: Subtract the two counts, then divide by the larger (vendor) count.
explain: (1,200,000 minus 1,000,000) divided by 1,200,000 equals 0.1667, about 16.67%. That is well past the roughly 10% normal drift, which points straight at a trafficking defect (here the missing cachebuster on the buyer's tag) rather than ordinary counting-point differences.
:::

:::sources
- Google, Ad Manager macros (CLICK_URL and CACHEBUSTER) | https://support.google.com/admanager/answer/2376981?hl=en
- Google, Campaign Manager 360 placement tag types | https://support.google.com/campaignmanager/answer/2826636?hl=en
- Google, Use click macros for accurate click tracking | https://support.google.com/authorizedbuyers/answer/3187721?hl=en
- Microsoft Xandr, Click Tracking and Cache-Busting Examples for Top Ad Servers | https://learn.microsoft.com/en-us/xandr/bidders/click-tracking-and-cache-busting-examples
- IAB, Desktop Display Impression Measurement Guidelines | https://www.iab.com/wp-content/uploads/2016/12/Desktop-Display-Impression-Measurement-Guidelines-US-MMTF-Public-Comment-Final.pdf
- AdPushup, What Are Macros in Google Ad Manager | https://www.adpushup.com/blog/what-are-macros-in-google-ad-manager/
- ExactDrive, What Is a Third-Party Ad Tag | https://www.exactdrive.com/news/what-is-a-third-party-ad-tag
:::
