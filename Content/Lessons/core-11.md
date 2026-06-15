---
id: core-11
track: core
module: 11
title: The Cookieless Future and the Identity Stack
summary: Where third-party cookies actually stand in 2026, the alternative IDs and on-device APIs that replace them, clean rooms and first-party data, and the match-rate math that decides how many people you can still reach.
---
# The cookie is not dead, but it is cornered

For years the plan was simple to state: Chrome would turn off third-party cookies and the open web would need a replacement. That plan is over. In October 2025 Google retired the Privacy Sandbox effort and the APIs built under it (Topics, Protected Audience, Attribution Reporting, and the rest), and confirmed it would keep its existing approach of letting users choose third-party cookies in Chrome. So in 2026 third-party cookies still work in Chrome, which is most of the desktop and Android market.

The catch is that Safari has blocked third-party cookies by default since 2020, and Firefox blocks them too. Together those browsers are a large slice of traffic, especially on iOS, and none of it is addressable through a third-party cookie. That is the gap the identity stack exists to fill. The cookie did not die, but it stopped being a complete answer, and the durable plan is first-party data plus an identity layer that survives outside Chrome.

:::quiz
question: What is the actual status of third-party cookies in 2026?
- Chrome blocks them, but Safari and Firefox still allow them
- They work in Chrome, but Safari and Firefox block them by default
- All major browsers block them as of October 2025
- Only mobile browsers block them
answer: 1
hint: Google reversed course and shut down Privacy Sandbox in October 2025.
explain: Google retired Privacy Sandbox in October 2025 and kept third-party cookie choice in Chrome, so cookies still work there. Safari and Firefox have blocked third-party cookies by default for years, so that traffic stays unaddressable through cookies.
:::

# The math the gap forces

Before reaching for any solution, you need to size the problem, and the problem is a chain of multiplications, not a single number. Start with your total audience, remove the share of traffic on browsers that block third-party cookies, then apply the cookie match rate with whatever partner you are syncing to. Each step shrinks the pool.

$$ \text{addressable reach} = \text{users} \times (1 - \text{blocked share}) \times \text{match rate} $$

The blocked share is the part of your traffic on Safari and Firefox, where a third-party cookie never sets. The match rate is the fraction of the remaining cookies that actually map to your partner's id after a cookie sync, and that sync is never perfect. Two leaks, multiplied, are what turn a big top-line audience into a much smaller usable one.

:::predict
prompt: A publisher has 12,000,000 monthly users. 35% of them browse on Safari or Firefox, where third-party cookies do not set. Of the remaining cookie-eligible users, 70% match to the buyer's id after a cookie sync. How many users are addressable through third-party cookies?
answer: 5460000
tolerance: 10000
unit:
hint: First remove the blocked share, then multiply the rest by the match rate.
explain: Cookie-eligible users are 12,000,000 times (1 - 0.35) = 7,800,000. Apply the 70% match rate: 7,800,000 times 0.70 = 5,460,000 addressable users. The other 6,540,000 are lost to browser blocking and sync failure combined.
:::

# Deterministic IDs: UID2 and RampID

The first family of replacements ties a stable id to something the user actually gave you, usually a logged-in email or phone number. This is deterministic identity, and it works in Safari because it does not depend on a third-party cookie at all.

Unified ID 2.0 (UID2), the open framework promoted by The Trade Desk, takes a normalized email or phone number, hashes it with SHA-256, adds a secret salt, and hashes again to produce a raw UID2 that cannot be reversed back to the email. Salts rotate over roughly a year (about 1/365th of buckets per day), and tokens refresh on a short cycle, so the same email does not produce a permanently fixed identifier. LiveRamp's RampID does the conceptual equivalent through its identity graph, resolving emails, devices, and offline records to one pseudonymous people-based id, distributed on live inventory through its Authenticated Traffic Solution. LiveRamp reports RampID inventory carrying meaningfully higher CPMs in cookieless browsers like Safari than non-RampID inventory, which is the whole point: it monetizes the traffic the cookie cannot.

The limit on deterministic IDs is authentication. They only exist for users who logged in and consented, so reach is capped by your logged-in share, not your total traffic.

:::predict
prompt: A media company has 50,000,000 monthly users. 30% are logged in and consented, so they carry a deterministic email-based id. The buyer's UID2 graph matches 90% of those logged-in users. How many users are addressable through the deterministic id?
answer: 13500000
tolerance: 50000
unit:
hint: Apply the logged-in share first, then the match rate on that subset.
explain: Logged-in, addressable users are 50,000,000 times 0.30 = 15,000,000. The graph matches 90% of them: 15,000,000 times 0.90 = 13,500,000. Deterministic reach is bounded by the authenticated share, which is why first-party login is the real asset.
:::

# Cohorts without an ID: Topics and seller-defined audiences

The second family avoids per-user IDs entirely and targets groups. These survive even where there is no email and no cookie, at the cost of precision.

Google's Topics API, while it lived, ran on the device: Chrome inferred a user's interests from the sites they visited, computed five top topics per one-week epoch, and returned at most three (one per recent epoch) to a caller, with a 5% chance any returned topic was random noise for privacy. Topics was retired with the rest of Privacy Sandbox in October 2025, so it is now history, but the cohort idea it embodied lives on. The IAB Tech Lab's Seller-Defined Audiences (SDA) puts that idea in the publisher's hands: the publisher maps its own first-party signals to a standardized Audience Taxonomy (demographic, purchase intent, and interest attributes), then passes the taxonomy IDs inside the OpenRTB bid request so buyers can target the cohort without ever receiving a user id. No identity leaves the publisher, and the segment travels in the bidstream.

:::quiz
question: How does Seller-Defined Audiences let a buyer target a publisher's audience without an identity leak?
- It syncs a third-party cookie between buyer and publisher
- It sends the user's hashed email to the DSP
- It relies on the Topics API running in Chrome
- The publisher passes standardized taxonomy cohort IDs in the OpenRTB request, not a user id
answer: 3
hint: SDA moves a cohort label through the bidstream, not a person.
explain: SDA maps the publisher's first-party signals to a standard IAB Audience Taxonomy and relays the taxonomy IDs in OpenRTB. The buyer targets the cohort without receiving any user-level identifier, so there is no identity to leak.
:::

# Clean rooms and first-party data

The third piece is not an ID at all, it is a place to match data safely. A data clean room is a secure environment where an advertiser and a publisher (or retailer) each load hashed first-party data, the system matches records on a shared key like a hashed email, and only aggregate outputs come back: overlap counts, reach and frequency, attribution. Neither side sees the other's raw rows, and differential privacy adds calibrated noise so individuals cannot be re-identified from the aggregates. This is the engine behind retail media measurement, where a brand proves sales lift against a retailer's purchase data.

All three families share one root requirement: your own first-party data. Logins feed deterministic IDs, on-site behavior feeds SDA cohorts, and your CRM feeds the clean room. Without a first-party foundation, none of the stack has anything to stand on.

:::quiz
question: In a data clean room, what does each party actually get back?
- The other party's raw customer rows
- A third-party cookie sync between the two datasets
- Only aggregate outputs like overlap counts and attribution, with noise added so individuals cannot be re-identified
- The full decrypted email list of the match
answer: 2
hint: The whole point is matching without exposing raw records.
explain: Each side loads hashed first-party data, the room matches on a shared key, and only aggregate outputs come back (overlap, reach, attribution). Differential privacy adds calibrated noise so no individual can be re-identified from the aggregates. Raw rows never cross.
:::

:::callout key
First-party data is the input to the entire identity stack. Deterministic IDs need logins, seller-defined audiences need on-site signals, and clean rooms need your CRM. Collect and consent it well, because everything downstream multiplies off it.
:::

# Stacking the solutions, and counting what is left

No single replacement covers everyone, so real operations layer them: cookies where they still work (Chrome), deterministic IDs for logged-in users (everywhere, including Safari), and cohorts plus clean rooms for the rest. Each addresses a different slice, and the slices overlap, so you cannot simply add the percentages. The honest way to report addressability is per channel, then deduplicate, not as one inflated total.

Match rate is the number that governs all of it. Whether you are syncing cookies, resolving a UID2, or matching a clean-room list, the same definition applies: how many of the records you tried to match actually mapped.

$$ \text{match rate} = \frac{\text{records matched}}{\text{records attempted}} $$

:::predict
prompt: You push 6,500,000 hashed emails into a clean room. The publisher matches 4,000,000 of them to its own logged-in users. What is the match rate?
answer: 61.5
tolerance: 0.5
unit: %
hint: Divide matched records by attempted records.
explain: 4,000,000 / 6,500,000 = 0.6154, about a 61.5% match rate. The 38.5% that did not match are users the publisher cannot tie to your list, so they fall outside any audience or measurement built from that match.
:::

:::callout insight
In 2026 there is no one-to-one cookie replacement, by design. The Privacy Sandbox attempt to build one failed and was shut down. The working answer is a stack: first-party data feeding deterministic IDs, seller-defined cohorts, and clean rooms, with addressability counted honestly per channel after browser blocking and match-rate loss.
:::

:::sources
- Usercentrics, Google Privacy Sandbox officially shuts down | https://usercentrics.com/knowledge-hub/what-is-google-privacy-sandbox/
- Google, Update on plans for Privacy Sandbox technologies | https://privacysandbox.google.com/blog/privacy-sandbox-next-steps
- Google, Topics API for Web | https://privacysandbox.google.com/private-advertising/topics/web
- UnifiedID, UID2 glossary and how UID2 works | https://unifiedid.com/docs/ref-info/glossary-uid
- LiveRamp, RampID | https://liveramp.com/our-platform/rampid
- IAB Tech Lab, Tech Lab releases Seller Defined Audiences | https://iabtechlab.com/tech-lab-releases-seller-defined-audiences/
- eMarketer, FAQ on data clean rooms | https://www.emarketer.com/content/faq-on-data-clean-rooms-how-retail-media-driving-adoption-marketers-demand-proof
- Criteo, Alternative IDs and the post-cookie world | https://www.criteo.com/blog/guide-to-alternative-ids-post-cookie-world/
:::
