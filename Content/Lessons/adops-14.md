---
id: adops-14
track: adops
module: 14
title: Server-side and app conversions, CAPI, postbacks, and SKAN
summary: When the browser pixel is not enough. Stand up the Conversions API, deduplicate browser and server by a shared event id, wire app conversions through an MMP and SKAdNetwork, and QA the whole signal.
---
# Why the browser pixel leaks

The adops-13 lesson built a clean web conversion pixel and proved it fires. This lesson is about the conversions that pixel never sees, and how a trader recovers them. The browser pixel is a client-side tag, and the client is exactly where measurement is being squeezed.

Three forces drain it. Ad blockers and browser tracking protection strip the tag for a meaningful share of users before it ever fires. Safari's Intelligent Tracking Prevention caps script-set first-party cookies to seven days, or twenty-four hours when the landing URL carries tracking parameters, so returning users go unrecognized. And users simply bounce, closing the tab before a client tag on a slow confirmation page gets to run. None of this is a bug you can fix in the tag. It is structural loss, and on many advertisers it runs from ten to thirty percent of conversions.

The fix is to stop relying only on the browser. With a server-side feed, your own server reports the conversion in a first-party context, where blockers and cookie caps do not reach.

:::callout key
The browser pixel and the server feed are not either-or. The pixel captures rich client context (the page, the dataLayer, the click id), and the server recovers what the client drops. Run both, then deduplicate. That pairing is the modern standard.
:::

:::quiz
question: Why does a trader add server-side measurement on top of a working browser pixel?
- It makes the confirmation page load faster
- Browser pixels are stripped by ad blockers and capped by cookie limits, so they undercount
- It removes the need to collect consent
- OpenRTB requires a server-side conversion feed
answer: 1
hint: Think about where the client tag fails, and who never sees it.
explain: The client pixel is blocked, cookie-capped, and lost to bounces for a meaningful share of users. A server-side feed reports the conversion first-party, recovering conversions the browser never logged.
:::

# Step 1: Stand up the Conversions API (or server-side GTM)

The server feed goes by different names, Meta's Conversions API (CAPI), server-side Google Tag Manager, the platform's offline or S2S conversion import, but the shape is the same. When your back-end confirms an order (the checkout completes, the payment clears), your server posts the event straight to the platform's endpoint instead of trusting the browser to do it.

The payload carries the same facts the pixel sends, plus hashed identifiers the platform uses to match the event to a user. You hash personal data (email, phone) with SHA-256 before it leaves your server, so the platform matches on the hash without receiving the raw value.

```
POST https://graph.facebook.com/v21.0/<DATASET_ID>/events
{
  "data": [{
    "event_name": "Purchase",
    "event_time": 1718900000,
    "event_id": "ORDER-10231",          // the SAME id the browser pixel sends
    "action_source": "website",
    "user_data": {
      "em": "<sha256 of lowercased email>",
      "ph": "<sha256 of E.164 phone>"
    },
    "custom_data": { "value": 49.90, "currency": "USD" }
  }]
}
```

The match quality of those identifiers has a score. Meta calls it Event Match Quality (EMQ), a 1 to 10 rating of how well your `user_data` lets it resolve the event to a person. More good parameters (hashed email, phone, name, location, an external id, the `fbp` and `fbc` cookies) lift EMQ, and a hashing or formatting mistake silently tanks it. The trader's bar is EMQ of 7 or higher on the key event.

:::quiz
question: Why are the email and phone in the Conversions API payload sent as SHA-256 hashes rather than raw values?
- To make the request body smaller
- So the platform can match the event to a user on the hash, without ever receiving the raw personal data
- To encrypt the order value against interception
- Because SKAdNetwork mandates hashing
answer: 1
hint: Think about matching a known user while handing over as little personal data as possible.
explain: Hashing lets the platform match the conversion to a user by comparing hashes, without you transmitting the raw email or phone. It is privacy and data minimization, not compression or value encryption, and the quality of those hashed parameters is exactly what drives EMQ.
:::

# Step 2: Deduplicate browser and server

Run the pixel and the server feed in parallel and, without deduplication, every conversion reports twice. The platform collapses the duplicate using a shared key: the browser pixel and the server event carry the identical `event_id` (the order id is the natural choice), and when the platform sees the same id from both channels inside the dedup window (Meta uses about forty-eight hours), it counts the conversion once.

When the ids do not match, dedup fails open, and the unmatched pair counts twice. The usual cause is the browser sending one id (say a random event id) while the server sends another (the order id). Pick one key, the order id, and send it from both.

$$ \text{reported} = \text{true} + (\text{unmatched share}) \times \text{true} $$

:::predict
prompt: The browser pixel and CAPI each send the same 1,000 purchases with a shared event id, but 20% of the ids fail to match between the two channels. After deduplication, how many conversions does the platform report?
answer: 1200
tolerance: 0
unit:
hint: The matched ones count once. The unmatched ones count twice.
explain: 80 percent (800) match and dedupe to 800. The other 20 percent (200) fail to match, so each is counted on both channels: 200 becomes 400. Total reported is 800 plus 400, or 1,200 against a true 1,000, a 20 percent inflation born entirely from mismatched ids.
:::

:::callout warning
A broken dedup key is worse than no server feed. It does not just add noise, it inflates ROAS, and an inflated ROAS tells the bidder to spend more on whatever produced the phantom conversions. Verify dedup in the platform's reporting before you trust a single number from the parallel setup.
:::

# Step 3: App conversions, the MMP and SKAdNetwork

A native app has no page and no web pixel, so app conversions take a different path entirely, and a trader buying app inventory has to know it. The app embeds a software development kit and routes attribution through a mobile measurement partner (MMP) such as AppsFlyer, Adjust, or Branch, which is the neutral referee between the ad networks and the app.

On iOS, Apple's SKAdNetwork (now SKAN 4) puts attribution on the device, not in the advertiser's hands. Post-install behavior is compressed into a small conversion value, and a few privacy-preserving postbacks fire after measurement windows ending around day 2, day 7, and day 35, each delayed by a random timer so the timing itself cannot identify a user. Crucially, when a cohort is too small to be anonymous, Apple suppresses the conversion value entirely (the crowd-anonymity threshold), so low-volume campaigns get coarse or null signal. In place of a client pixel confirming the install, the ad network receives a server-to-server postback.

This is why app campaigns feel blunt compared to web. You are optimizing on delayed, aggregated, sometimes-suppressed signal, and the MMP plus SKAN postbacks are the only conversion truth you get.

:::predict
prompt: An iOS campaign drives 5,000 installs, but 18% of them land in cohorts below Apple's crowd-anonymity threshold, so their conversion value is suppressed. How many installs return only a null or coarse conversion value?
answer: 900
tolerance: 0
unit:
hint: Apply the suppressed share to the install count.
explain: 18 percent of 5,000 is 900 installs whose detailed post-install signal Apple withholds to preserve anonymity. You still get the install, but the conversion value that would tell you what those users did is gone, which is why SKAN campaigns need volume to measure well.
:::

:::quiz
question: A native iOS app has no web pixel. How does it attribute an install in a privacy-safe way?
- A 1x1 image pixel placed inside the app
- An SDK plus SKAdNetwork postbacks carrying an encoded conversion value
- A third-party cookie set by the App Store
- The click macro from the delivery tag
answer: 1
hint: Apps have no page, and Apple decides attribution on the device.
explain: Apps use an MMP's SDK together with Apple's SKAdNetwork, which encodes post-install behavior into a small conversion value and returns it through privacy-preserving postbacks. There is no page, no pixel, and no cookie inside a native app.
:::

# Step 4: QA the server path

The web QA from adops-13 proves the client pixel. The server path needs its own pass, because its failures are even quieter (there is no page to watch).

First, fire a test event through the server, an actual back-end order or the platform's test tool, and confirm it arrives in Events Manager, the DSP, or the MMP with the right event name, value, and id.

Then check EMQ on the key event and confirm it is 7 or higher; a low score means your hashed identifiers are malformed and matching is quietly failing.

Then verify deduplication: send the same event from both the pixel and the server and confirm the platform reports one conversion, not two.

Finally, reconcile capture against the back-end. Compare the deduplicated platform total to the advertiser's own system of record (the checkout database, the CRM), and confirm the gap sits inside the normal band rather than the wide gap a broken dedup or a dead pixel would open.

:::predict
prompt: Before CAPI, the browser pixel captured 780 of the 1,000 purchases the back-end recorded. After adding the server feed, the deduplicated platform total reaches 970. How many percentage points of capture did the server feed recover?
answer: 19
tolerance: 0.5
unit: pp
hint: Compare the two capture rates, before and after.
explain: Capture went from 780/1,000 (78 percent) to 970/1,000 (97 percent), a recovery of 19 percentage points. That gap was real conversions the blocked or bounced client pixel missed, now reported first-party through the server.
:::

# The trader's standing pixel checklist

Across web, server, and app, the pre-launch gate is one list, and budget does not go live until every line is green.

The web pixel fires on the confirmation page with the value and order id populated, once. The server feed (CAPI or server-side GTM) is live and sending the same `event_id`. Deduplication is verified in the platform's reporting. EMQ is 7 or higher on the key event. App campaigns have their MMP and SKAN postbacks confirming installs. And the deduplicated platform total reconciles to the advertiser's back-end inside the normal counting band.

:::callout key
A trader who can recite this checklist from memory, and refuses to spend until it passes, is worth more than one who can quote bid theory. The math only matters if the conversions feeding it are real, and this list is what makes them real.
:::

:::quiz
question: What is the single shared key that lets the platform avoid double-counting a conversion sent by both the browser pixel and the server feed?
- The order value
- A shared event id present on both the pixel and the server event
- The campaign id
- A cachebuster on the pixel
answer: 1
hint: It has to be identical on both channels and unique per conversion.
explain: Deduplication keys on a shared, per-conversion event id (the order id is the natural choice) sent identically by the pixel and the server. The value, campaign id, and cachebuster cannot identify the same conversion across both channels.
:::

:::sources
- Meta, Conversions API overview | https://developers.facebook.com/docs/marketing-api/conversions-api/
- Meta, Deduplicate pixel and server events | https://developers.facebook.com/docs/marketing-api/conversions-api/deduplicate-pixel-and-server-events/
- Google, Server-side tagging fundamentals | https://developers.google.com/tag-platform/learn/sst-fundamentals
- Apple, SKAdNetwork developer documentation | https://developer.apple.com/documentation/storekit/skadnetwork
- AppsFlyer, The SKAdNetwork guide | https://www.appsflyer.com/resources/guides/skadnetwork/
:::
