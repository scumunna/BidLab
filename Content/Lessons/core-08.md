---
id: core-08
track: core
module: 8
title: Pixels and tags, how tracking actually works
summary: The 1x1 image, the JavaScript tag, and the iframe, what each one collects, why apps have no pixels, and the move to server-side measurement.
---
# The 1x1 image that started it all

A tracking pixel is a 1x1 transparent image. A page, or an email, embeds it as an image whose source points at a tracking server. When the browser loads that image it issues an ordinary HTTP GET, and the request carries data in the URL query string (campaign id, user id, event name, conversion value) plus the referrer, the user agent, the IP address, and any cookies already set for the tracker's own domain. The server logs all of it, returns the image bytes, and usually attaches a Set-Cookie header that drops or refreshes the tracker's identifier.

The key limit: a pixel cannot read the page or run logic. It can only send what is already in its URL and its cookie. Everything richer is built on top of that one idea.

:::figure pixelFire
caption: A tracking pixel is an ordinary image request. The query string and the cookie ride along, the server logs them, and it can set a cookie of its own in reply.
:::

# Image, JavaScript, and iframe

There are three ways to fire a tag, and the difference is what each one can see and do.

An image pixel needs no JavaScript. It can only transmit what sits in its URL and cookie, which is why it is the standard for email open tracking (email clients strip scripts) and simple impression or conversion logging. Smallest footprint, lowest accuracy.

A JavaScript tag is the modern standard, like Meta's fbq or Google's gtag. It loads a small library that runs inside the page, so it can read the page and the dataLayer, fire on custom events such as add to cart or purchase, attach a conversion value, set and read first-party cookies, and load asynchronously. Richest data and the most accurate, at the cost of more code on the page.

An iframe tag loads the vendor's own page inside a sandbox. It carries the vendor's own cookies and is used to piggyback other tags and to cookie sync, but the same-origin rule means it cannot read the host page. Meta ships an iframe pixel inside a noscript block as the fallback when JavaScript is turned off.

$$ \text{data richness: image} < \text{iframe} < \text{JavaScript} $$

:::quiz
question: Which tag type can read the page's dataLayer and fire a custom purchase event with a value attached?
- The image pixel
- The JavaScript tag
- The iframe tag
- None of them can
answer: 1
hint: Only one of the three actually runs code inside the page.
explain: Only the JavaScript tag runs in the page, so only it can read the dataLayer and send rich custom events with a value. The image and the iframe can transmit just what is in their URL and cookies.
:::

# What a pixel collects

Beyond a plain page view, a pixel can log conversions and their value, custom events, the user or cookie id, the referrer, the page URL, the user agent, the IP, and any custom parameters. That feed builds retargeting audiences and powers cookie syncing: through a chain of redirects an exchange passes its user id to a partner, and each side stores the pairing in a match table, where id X here equals id Y there. Match rates are never one hundred percent, and the whole mechanism fails on browsers that block third-party cookies.

:::predict
prompt: A DSP holds 10,000,000 cookies. After cookie syncing, 6,500,000 of them map to a partner SSP's id. What is the match rate?
answer: 65
tolerance: 0.5
unit: %
hint: Match rate is matched ids divided by total ids.
explain: 6,500,000 / 10,000,000 = 0.65, a 65 percent match rate. The other 35 percent are unaddressable through that partner, before you even subtract cookie-blocking browsers.
:::

# Apps have no pixels

A native app has no page and no web pixel, so tracking works differently. Apps embed an SDK and route attribution through a mobile measurement partner such as AppsFlyer, Adjust, or Branch. On iOS, Apple's SKAdNetwork (now SKAN 4) lets the device, not the advertiser, attribute the install: post-install behavior is encoded into a small conversion value, and a few privacy-preserving postbacks fire after measurement windows ending around day 2, day 7, and day 35, each delayed by a random timer. On Android the Play Install Referrer still returns the original click referrer, while Google's Privacy Sandbox attribution returns aggregated rather than user-level data. In place of a client pixel, the ad network confirms the install with a server to server postback.

:::quiz
question: How does a native iOS app most commonly attribute an install in a privacy-safe way?
- A 1x1 image pixel on the App Store page
- An SDK plus Apple SKAdNetwork postbacks
- A JavaScript tag running inside the app
- A third-party cookie
answer: 1
hint: Apps have no page, and Apple decides the attribution on the device.
explain: Apps use an SDK together with Apple's SKAdNetwork, which sends a small encoded conversion value back through privacy-preserving postbacks. There is no pixel, no page, and no cookie inside a native app.
:::

# Server-side and the Conversions API

Ad blockers drop client pixels, and Safari caps script-set first-party cookies to seven days, or to twenty four hours when the landing URL carries tracking parameters, so measurement is moving to the server. With Meta's Conversions API, or server-side Google Tag Manager, your own server collects the event in a first-party context and forwards it. Many advertisers run the browser pixel and the server API in parallel, which would double count every conversion, so the platform deduplicates using a shared event id inside a 48-hour window. When the ids do not match, the duplicates leak through.

$$ \text{capture rate} = \frac{\text{client conversions}}{\text{server conversions}} $$

:::predict
prompt: Your browser pixel reports 800 purchases. Your server-side Conversions API reports 1,000 for the same window. What share did the client pixel capture?
answer: 80
tolerance: 0.5
unit: %
hint: Divide the client count by the server count.
explain: 800 / 1,000 = 0.80. The client pixel captured 80 percent; the server recovered the 20 percent lost to blockers and cookie limits.
:::

:::predict
prompt: Pixel and Conversions API each report 1,000 of the same conversions. If 30% of the event ids fail to match, by how much is the deduplicated total inflated above the true 1,000?
answer: 30
tolerance: 0.5
unit: %
hint: The unmatched events are the ones that get counted twice.
explain: 30 percent of 1,000 is 300 events that dedup misses, so the reported total becomes 1,300, a 30 percent inflation over the true 1,000.
:::

# Why it matters, and how it breaks

Every conversion number, attribution decision, and retargeting pool depends on pixels firing correctly, so the failure modes are the whole game. A pixel can be blocked, mis-tagged, duplicated, or lost to a race condition when a user bounces before it fires. Email is its own trap: Apple Mail Privacy Protection pre-fetches every image, so the open pixel fires whether or not anyone read the message, and Apple Mail is more than half of all opens. Even a healthy campaign shows a counting-point discrepancy, because a publisher counts at ad request while an advertiser counts at render, and a gap under about ten percent is treated as normal.

$$ \text{discrepancy} = \frac{\text{publisher} - \text{advertiser}}{\text{publisher}} $$

:::predict
prompt: A publisher counts 1,050,000 impressions at ad request. The advertiser counts 1,000,000 at render. What is the discrepancy?
answer: 4.76
tolerance: 0.15
unit: %
hint: Subtract the two counts, then divide by the publisher's count.
explain: (1,050,000 - 1,000,000) / 1,050,000 = 0.0476, about 4.76 percent, comfortably inside the roughly 10 percent that is considered normal.
:::

:::callout insight
Third-party cookies still work in Chrome in 2026, since Google shut down the Privacy Sandbox in October 2025, but Safari and Firefox block them, so the durable path is first-party data and server-side measurement, not a single client pixel.
:::

:::sources
- Swetrix, Pixel tags and web beacons | https://swetrix.com/blog/pixel-tags-and-web-beacons
- Meta Pixel, Get Started | https://developers.facebook.com/docs/meta-pixel/get-started/
- Analytics Mania, Facebook Pixel noscript and iframe fallback | https://www.analyticsmania.com/post/facebook-pixel-noscript/
- Clearcode, Cookie syncing explained | https://clearcode.cc/blog/cookie-syncing/
- Singular, Server-to-server SKAdNetwork 4 guide | https://support.singular.net/hc/en-us/articles/13706627162395-Server-to-Server-SKAdNetwork-4-Implementation-Guide
- Google, Why and when server-side tagging | https://developers.google.com/tag-platform/learn/sst-fundamentals/3-why-and-when-sst
- Stape, Safari ITP and cookie lifetimes | https://stape.io/blog/safari-itp
- Epom, How to reduce ad discrepancy | https://epom.com/blog/metrics/how-to-reduce-ad-discrepancy
:::
