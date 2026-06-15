---
id: core-03
track: core
module: 3
title: Identity and targeting
summary: Understand how identifiers, contextual signals, and privacy law shape who you can reach and how often.
---
# How a buyer recognizes a person

Targeting depends on recognizing the same person across requests. On the web that job was long done by the third-party cookie, a small identifier dropped by a domain other than the one you are visiting. In apps it is the mobile advertising ID (Apple's IDFA, Google's GAID), a resettable device-level ID.

Both have eroded. Apple's App Tracking Transparency made the IDFA opt-in, which collapsed its availability. Browsers like Safari and Firefox block third-party cookies by default. The result is a fragmented identity layer where no single signal covers the whole audience.

:::predict
prompt: After App Tracking Transparency, only about 25% of iOS users opt in to share their IDFA. Out of 4 million iOS impressions, roughly how many carry a usable IDFA?
answer: 1000000
unit: impressions
hint: Multiply the total impressions by the opt-in share.
explain: Usable IDFA impressions = 0.25 x 4,000,000 = 1,000,000. Three-quarters of the inventory arrives with no device ID, which is exactly the fragmentation that pushes buyers toward alternative IDs and context.
:::

# Alternative IDs and contextual

The industry's main answer is a set of people-based identifiers built on consented, hashed email. Unified ID 2.0 (UID2), stewarded by The Trade Desk and adopted across DSPs, exchanges, and clean rooms, is the most widely used. Through 2026, partners such as Databricks, Hightouch, and MetaRouter expanded UID2 integrations, and a European variant, EUID, addresses the stricter consent rules of the EU and UK.

The other path is contextual targeting: ignore who the user is and match on what the page or stream is about. Contextual needs no personal identifier, so it sidesteps most privacy constraints, though it cannot cap frequency across sites or build precise audiences.

:::widget donutChart
title: A blended 2026 identity strategy (illustrative mix)
labels: Alternative IDs (UID2/EUID), Contextual, Deterministic cookies/MAIDs
data: 45, 35, 20
:::

:::callout insight
Identifiers tell you who the person is. Context tells you what they are looking at right now. Most 2026 strategies blend both rather than betting on either alone.
:::

# The privacy shift

Two laws set the baseline. The EU's GDPR requires a lawful basis (usually consent) to process personal data, with real enforcement and large fines. In the US, California's CPRA gives consumers rights to opt out of sale and sharing, and similar state laws have followed. Compliance now shapes what signals a bid request may legally carry.

A major reversal landed on the browser side. Google's Privacy Sandbox, the proposed cookie replacement, saw low adoption, and in 2025 Google scrapped plans to deprecate third-party cookies in Chrome and wound down most Sandbox APIs. As of 2026, third-party cookies still exist in Chrome but function only for a small consented slice of users, so the move to first-party data and alternative IDs continues regardless.

:::predict
prompt: Suppose third-party cookies now function for only about 15% of Chrome users. Across 20 million Chrome impressions, how many still carry a usable third-party cookie?
answer: 3000000
unit: impressions
hint: Multiply the impressions by the share of users for whom the cookie still works.
explain: Usable-cookie impressions = 0.15 x 20,000,000 = 3,000,000. Even though cookies were not deprecated, the addressable slice is small enough that the shift to first-party data and alternative IDs continues regardless.
:::

# Reach and frequency

Once you can identify users, you manage exposure. Reach is the count of unique people who saw an ad. Frequency is the average number of times each reached person saw it. With a fixed number of impressions, pushing more impressions at the same people raises frequency and lowers incremental reach.

$$ frequency = impressions / reach $$

:::widget reachFrequency
population: 1000000
:::

:::callout warning
Without a durable identifier you cannot cap frequency reliably across sites. Lost identity does not just shrink targeting, it lets the same person get hit far more often than you intended, wasting budget.
:::

:::quiz
question: What is the main appeal of contextual targeting in a privacy-constrained environment?
- It requires no personal identifier to work
- It guarantees a higher click-through rate
- It eliminates the need for an ad exchange
- It caps frequency across every site automatically
answer: 0
explain: Contextual matches on the content of the page or stream rather than the identity of the user, so it functions without cookies or device IDs. It cannot, however, cap cross-site frequency, which needs a shared identifier.
:::

:::sources
- Privacy Sandbox, Next Steps for Tracking Protections in Chrome | https://privacysandbox.google.com/blog/privacy-sandbox-next-steps
- The Trade Desk, Unified ID 2.0 | https://www.thetradedesk.com/us/about-us/industry-initiatives/unified-id-solution-2-0
:::
