---
id: vertical-auto-06
track: vertical-auto
module: 6
title: "Identity and First-Party Data: DMS/CRM Onboarding, Clean Rooms, and UID2"
summary: Onboard a dealer's DMS/CRM owner list into a durable ID or clean room, compute match and consent rates, and reason about how identity loss bends the net cost per sale you are graded on.
---
# Why first-party data is the durable asset

As third-party cookies keep getting blocked across Safari and Firefox, the dealer's own first-party data becomes the trader's most durable targeting and measurement asset. That data lives in the DMS/CRM stack, the sold and service records in VinSolutions, DealerSocket, CDK, or Reynolds and Reynolds, plus prior leads the store already paid to generate. The whole identity job is taking that owned data, which is just rows of email and phone, and turning it into something a DSP or publisher can actually target and measure against without either side handing over raw personal information.

This matters because everything downstream rides on it. The conquest, loyalty, and lease-end audiences from the targeting lesson get sharper when you can layer the dealer's real owner list on top, and the VIN matchback that proves your net cost per sale only stays privacy-compliant because it runs through this same identity plumbing.

:::callout key
First-party data is the one signal a competitor cannot buy and a browser cannot block. The trader's edge in a cookieless 2026 is not a better third-party segment, it is a clean, consented owner list onboarded to a durable ID.
:::

The durability is not abstract. Safari and Firefox block third-party cookies by default, and together they account for roughly 35 percent of US browsing sessions, so a cookie-based audience is blind to better than a third of your owners before you even bid. A durable first-party ID reaches that same owner whether or not their browser allows a cookie, which is why the trader anchors reach to the onboarded list rather than to a cookie pool that keeps shrinking.

:::predict
prompt: Your addressable consented owner base is 5,200 IDs. A cookie-based approach can only reach the roughly 65 percent of those owners whose browsers still allow third-party cookies, but a durable first-party ID reaches all 5,200. How many owners does the durable ID reach that the cookie-based approach cannot?
answer: 1820
tolerance: 0
unit: IDs
hint: Find the cookie-reachable count first, then subtract it from the full base.
explain: Cookie-based reach is 5,200 x 0.65 = 3,380 owners. The durable ID reaches all 5,200, so the gap it recovers is 5,200 - 3,380 = 1,820 owners (equivalently 5,200 x 0.35 = 1,820). Those are real, consented customers a cookie-only buy would simply never serve, which is why first-party identity is the durable asset.
:::

# Onboarding: turning emails into addressable IDs

Onboarding is the mechanical step of matching the dealer's hashed customer records (email and phone, hashed so raw PII never travels) against a platform's graph so the records become addressable. The two mainstream destinations are a durable, open ID like UID2 (Unified ID 2.0, a pseudonymous identifier built by hashing and salting a consented email or phone) and a data clean room where the dealer's records match a platform's or publisher's data without either party exposing raw PII. CRM onboarding, such as The Trade Desk's offering, is the standard on-ramp for activating that first-party list without cookies or device IDs.

The number a trader lives and dies by here is the match rate: the share of submitted records that successfully resolve to an addressable ID. A list only onboards the portion of records that carry a valid, hashable, consented identifier, so a dirty file with duplicates, typos, and missing consent shrinks dramatically on the way in.

$$ \text{match rate} = \frac{\text{onboarded / matched IDs}}{\text{total CRM records submitted}} $$

:::predict
prompt: You submit 10,000 DMS/CRM records and 6,500 onboard to a durable ID. What is the match rate?
answer: 65
tolerance: 0.5
unit: %
hint: Match rate is matched IDs divided by total records submitted.
explain: 6,500 / 10,000 = 0.65, a 65 percent match rate. The other 35 percent are records that lacked a valid, hashable, or consented identifier and silently dropped out before the audience was even built.
:::

# Match rate is not the addressable audience

A match is necessary but not sufficient, because a matched ID still has to carry active consent before you may target it. The addressable owner base is the matched pool filtered down to the records that are legally usable, which is why traders quote two numbers, not one: how many matched, and of those how many you can actually serve.

$$ \text{addressable owner base} = \text{matched IDs} \times \text{share with active consent} $$

This compounding is the heart of the "sloppy CRM in, weak audience out" reality. A 10,000-row list that matches at 65 percent and then carries consent on 80 percent of those matches yields an addressable base far smaller than the dealer assumes when they hand you a "50,000 customer" database.

:::predict
prompt: Of 6,500 matched IDs, 80% carry active consent. How many IDs are addressable?
answer: 5200
tolerance: 0
unit: IDs
hint: Multiply matched IDs by the consented share.
explain: 6,500 x 0.80 = 5,200 addressable IDs. So a 10,000-record list collapses to 5,200 usable IDs, a 52 percent end-to-end yield, which is why you scope reach off the addressable base and not the raw row count.
:::

:::widget barChart
title: First-party list attrition from raw records to addressable IDs
labels: Submitted, Matched, Consented (Addressable)
data: 10000, 6500, 5200
unit: IDs
:::

# Clean rooms and durable IDs in practice

A clean room is a neutral, privacy-safe environment where two or more parties match first-party data and run measurement without either side seeing the other's raw PII. Adoption has gone mainstream, with 66 percent of US data and advertising professionals now using clean rooms in response to privacy legislation and signal loss. For the auto trader the clean room does three jobs the cookie world is losing: addressable retargeting of known shoppers, suppression of existing owners out of prospecting, and privacy-safe matchback of sold VINs to ad exposure.

UID2 sits alongside the clean room as the activation-side counterpart: an open, pseudonymous ID you can pass through the bidstream where cookies no longer flow. The trader rarely picks one or the other in isolation, you onboard the consented list, activate against a durable ID, and reconcile sales inside the clean room.

:::figure cleanRoomMatch
caption: The dealer's hashed DMS/CRM records and the platform's data meet inside the clean room. Only the overlap is usable for audience build and measurement, and neither side ever sees the other's raw PII.
:::

:::quiz
question: A dealer hands you a 50,000-row owner list but only a fraction is usable after onboarding. What is the single biggest reason the addressable base shrinks?
- The clean room caps every match at 50 percent by policy
- Records without a valid, hashable, or consented identifier silently drop out
- UID2 only accepts phone numbers, never email addresses
- Third-party cookies are required to onboard a first-party list
answer: 1
hint: Think about what each record needs before it can resolve to a durable ID.
explain: Onboarding only resolves records that carry a valid, hashable, and consented email or phone, so duplicates, typos, missing fields, and opt-outs drop out. UID2 accepts both email and phone, there is no blanket 50 percent cap, and the entire point of UID2 and clean rooms is to work without third-party cookies.
:::

# Suppression and the net cost per sale

The most underrated use of the onboarded list is suppression: removing existing owners from prospecting and conquest lines so you stop paying to re-acquire customers you already have. Done right, suppression concentrates the same budget on genuinely new shoppers, which lifts conversions and pulls down the signature KPI, net cost per sale, which is media spend net of co-op reimbursement divided by VIN-matched units sold. This is the bridge from identity work to the only number the dealer principal cares about.

$$ \text{net cost per sale} = \frac{\text{media spend} - \text{co-op reimbursement}}{\text{VIN-matched units sold}} $$

:::predict
prompt: You spend $48,000 on a prospecting line, OEM co-op reimburses 50%, and VIN matchback credits 80 sales. What is the net cost per sale?
answer: 300
tolerance: 0
unit: USD
hint: Subtract the co-op reimbursement first, then divide by VIN-matched units.
explain: Co-op reimburses 50 percent of $48,000, which is $24,000, so net spend is $48,000 - $24,000 = $24,000. Divide by 80 VIN-matched sales: $24,000 / 80 = $300 net cost per sale.
:::

:::predict
prompt: Before suppression you spend $24,000 net and match 60 sales. After suppressing existing owners, the same $24,000 net matches 80 sales. By how many dollars does net cost per sale drop?
answer: 100
tolerance: 0
unit: USD
hint: Compute net cost per sale before and after, then take the difference.
explain: Before: $24,000 / 60 = $400 per sale. After: $24,000 / 80 = $300 per sale. The drop is $400 - $300 = $100 per sale, because the same dollars now land on new shoppers instead of owners you already had.
:::

# Where identity breaks, and who eats the gap

Identity is fragile in ways that quietly distort the report, so a strong hire knows the failure modes cold. Consent state changes over time, an opt-out must propagate to suppression or the dealer keeps serving someone who legally opted out. Match rates differ by platform and onboarder, so the same CRM file produces different audience sizes depending on where you onboard it. And clean-room measurement only counts matched users, so cookieless or no-consent sales are invisible and make reported performance look slightly worse than the truth.

The trader's defense is to set expectations on the addressable base up front, refresh consent and suppression on a cadence, and footnote the measured-vs-true gap so a thin match rate is not mistaken for thin media performance.

:::callout warning
A recurring DealerRefresh operator complaint: "first-party strategy" gets sold to dealers whose DMS/CRM is full of duplicate, stale, and typo'd emails, so onboarding match rates crater and the addressable owner base is a fraction of the row count they were promised. Audit list hygiene before you quote reach, or you will overpromise an audience the data cannot deliver.
:::

:::quiz
question: Your clean-room report shows a lower net cost per sale improvement than you expected from suppression. Which explanation is most consistent with how clean rooms work?
- The clean room double-counts every owner, inflating spend
- Only matched users are measured, so cookieless and no-consent sales are invisible and understate true performance
- Suppression is illegal, so the lift never actually happened
- UID2 deletes sold records after 24 hours
answer: 1
hint: Think about which sales a clean room can and cannot see.
explain: Clean-room measurement can only attribute sales to users it matched, so unmatched cookieless or no-consent buyers never appear, understating the true improvement. Clean rooms do not double-count spend, suppression is a standard privacy-safe practice, and UID2 does not purge sold records on a 24-hour timer.
:::

:::sources
- AdExchanger / Adtelligent, Top 10 ID Solutions For Ads In 2026: Privacy-First Identity (UID2 explained) | https://adtelligent.com/blog/top-10-id-solutions/
- eMarketer, FAQ on data clean rooms: 66% of organizations have adopted data clean rooms | https://www.emarketer.com/content/faq-on-data-clean-rooms-how-retail-media-driving-adoption-marketers-demand-proof
- Tealium, Sweeping Away Third Party Cookies with Data Clean Rooms | https://tealium.com/blog/data-strategy/sweeping-away-third-party-cookies-with-data-clean-rooms/
- The Trade Desk, Maximize the potential of first-party data with CRM onboarding (UID2) | https://www.thetradedesk.com/us/resource-desk/maximize-the-potential-of-first-party-data-with-crm-onboarding
- Backlinko, Web Browser Market Share 2026 (US Safari + Firefox third-party cookie blocking) | https://backlinko.com/browser-market-share
- Demand Local, How AI is Revolutionizing Attribution in Automotive Marketing (DMS/CRM identity and matchback) | https://www.demandlocal.com/blog/ai-revolutionizing-attribution-automotive-marketing/
- Foundry CRO, Automotive Marketing Benchmarks 2026: CPC to Cost per Sale | https://foundrycro.com/blog/automotive-marketing-benchmarks-2026/
- DealerRefresh forum, Operator discussions on DMS/CRM data hygiene and onboarding | https://forum.dealerrefresh.com/
:::
