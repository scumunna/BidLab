---
id: adops-07
track: adops
module: 7
title: Consent and Privacy Operations
summary: How a consent string rides the bid request, what TCF v2.2 and GPP encode, how GPC and US state opt-outs are honored, and what breaks when consent is missing.
---
# Consent rides the bid request

Privacy in programmatic is not a policy slide, it is a signal that travels with every auction. On a page or in an app, a consent management platform (CMP) shows the user a choice screen, records what they allow, and encodes that into a compact string. That string is then attached to the bid request and carried downstream to the SSP, the exchange, and every DSP that sees the impression. Each downstream system reads the string and decides what it is allowed to do: target with an audience, set or read an identifier, fire measurement, or none of the above.

The transport is standardized. In OpenRTB 2.6 the consent payload lives in the regs object as `regs.gpp` (the encoded string) and `regs.gpp_sid` (the list of section ids that apply), with the legacy `regs.ext.gdpr` and `user.ext.consent` fields still seen on older 2.5 traffic. The CMP produces the string, the publisher's ad server or wrapper injects it, and the buy side honors it. If the field is absent or malformed, a compliant buyer treats the user as not consented, which is the safe default and also the expensive one.

:::figure rtbFlow
caption: The CMP encodes the user's choices once, and that string is attached to the bid request and read by every downstream SSP and DSP in the chain.
:::

# TCF v2.2: the consent string for GDPR

In Europe the rules come from the IAB Europe Transparency and Consent Framework (TCF). The current operational version is v2.2, launched in May 2023. The CMP encodes a TC string that records, for each of the framework's purposes and each registered vendor, whether the user gave consent or objected, plus the special features and the publisher restrictions. A DSP that receives the bid request decodes that string and checks: is my vendor id permitted, and for which purposes.

TCF v2.2 defines 11 purposes. The structural change that matters most for ops: legitimate interest was removed as a legal basis for Purposes 3 to 6, the personalization purposes (create and use an ads profile, create and use a content profile). Those now require explicit consent. Vendors may still rely on legitimate interest for Purpose 2 (select basic ads), Purpose 7 (measure ad performance), Purpose 8 (measure content performance), Purpose 9 (audience insights), and Purpose 10 (develop and improve services). When the signal is missing or negative for the personalization purposes, a compliant buyer must suppress personalized targeting and any measurement that relied on consent, and fall back to contextual, non-personalized delivery.

The framework keeps moving. TCF v2.3, released in June 2025, makes the disclosedVendors segment mandatory in TC strings generated on or after roughly 1 March 2026, with a participant adoption deadline of 28 February 2026. It does not change the purposes or the legal bases, so the v2.2 mental model still holds.

:::callout key
A TC string is not a yes or no. It is a per purpose, per vendor map of consent and objection, and your vendor id has to be on the right side of it for each purpose you want to use.
:::

:::quiz
question: Under TCF v2.2, a DSP receives a bid request whose TC string shows no consent for Purpose 4 (select personalized ads). What is the compliant action?
- Serve the personalized ad anyway, since the bid request still arrived
- Suppress personalized targeting and fall back to contextual, non-personalized delivery
- Treat Purpose 4 as legitimate interest and proceed
- Drop the impression entirely and return no bid
answer: 1
hint: v2.2 removed legitimate interest for the personalization purposes, so consent is the only basis.
explain: Purpose 4 is a personalization purpose, and v2.2 removed legitimate interest as a legal basis for Purposes 3 to 6. Without consent the buyer must not personalize, but it can still bid contextually. Dropping the impression is not required, only the personalized use of data is.
:::

# GPP: the unifying transport, and the fall of the USP string

The TC string solves Europe. The rest of the world has its own laws, and stacking a separate string per jurisdiction was unmanageable. The IAB Tech Lab's Global Privacy Platform (GPP) is the answer: one container that carries the right signal for whatever jurisdiction applies. The GPP string has a header plus numbered sections. Section 2 is the EU TCF v2 string (tcfeuv2), Section 7 is the US National string (usnat), and Sections 8 and up are the individual US states, for example usca (California), usva (Virginia), usco (Colorado), usct (Connecticut), and the newer additions like usmd (Maryland), usin (Indiana), usky (Kentucky), and usri (Rhode Island). The `regs.gpp_sid` array tells the buyer which sections are live for this request.

The old US Privacy (USP) string, the "1YNN" style four-character signal, is on its way out. The IAB deprecated it in January 2024 in favor of the GPP US sections, and platforms like Google Ad Manager still read it for backward compatibility while urging everyone to move to GPP. For operations the takeaway is simple: read GPP first, treat a bare USP string as legacy, and make sure your CMP emits the correct GPP sections for the user's state.

Separate from these encoded strings is the Global Privacy Control (GPC), a browser-level opt-out signal sent as an HTTP header (`Sec-GPC: 1`) or a JavaScript property. It is not an IAB string, it is a standing "do not sell or share" preference the user sets once in the browser. Under US state law it must be honored as a valid universal opt-out, and your CMP is expected to detect it and reflect it in the GPP string it generates.

:::quiz
question: A user has Global Privacy Control enabled in their browser. How should the stack treat the GPC signal under US state privacy law?
- Ignore it, because GPC is not an official IAB consent string
- Honor it as a binding universal opt-out of sale and sharing, and reflect it in the GPP signal
- Only honor it if the user also clicks the CMP banner
- Apply it only to first-party data, never to programmatic
answer: 1
hint: GPC is a recognized universal opt-out signal under state laws, not a CMP banner click.
explain: GPC is a recognized universal opt-out preference signal. States that require honoring universal opt-outs treat an enabled GPC header as a binding opt-out of sale and sharing, so the CMP must detect it and encode the opt-out into the GPP string, without the user touching the banner.
:::

# US state laws: honor the opt-out, suppress the sale or share

The United States has no single federal privacy law, so operations face a patchwork. California started it with the CCPA, amended and strengthened by the CPRA, and roughly 20 states now have comprehensive consumer privacy laws on the books. Three more, Indiana, Kentucky, and Rhode Island, took effect on 1 January 2026. The specifics vary, but the consumer rights cluster around the same core: access, delete, correct, and opt out of the sale of personal data and of processing for targeted advertising.

For ad operations the duty is concrete. When a user opts out, whether by clicking the "Do Not Sell or Share My Personal Information" link, by toggling a CMP control, or by sending GPC, the stack must stop treating that user's data as available for sale or share and stop using it for targeted advertising. As of 1 January 2026, twelve states require honoring a universal opt-out signal such as GPC, including California, Colorado, Connecticut, Texas, Oregon, Montana, and New Jersey. Enforcement is real and expensive: California fined Sephora 1.2 million dollars in 2022 for failing to honor opt-out signals, and a 1.55 million dollar action against Healthline in 2025 turned on data still flowing to ad partners after users had opted out.

:::predict
prompt: A publisher sees 1,000,000 monthly users. 18% have an opt-out signal active (GPC or a "do not sell" choice) that suppresses sale and share. How many users remain available for sale or share based targeting?
answer: 820000
tolerance: 1000
unit:
hint: Subtract the opted-out share from the total.
explain: 18 percent of 1,000,000 is 180,000 opted-out users. 1,000,000 minus 180,000 leaves 820,000 users still available for sale or share based targeting. The opted-out 180,000 can still be reached contextually, just not through data sale or sharing.
:::

# Consent as addressable reach

Consent is not just a compliance gate, it directly sizes your addressable audience. Every user who declines personalization, sends GPC, or never sees a working consent prompt is a user you cannot target with audience data or measure with consent-based attribution. The opt-in rate is therefore a reach multiplier, and small movements in it move spend.

Work an example. A campaign can reach 2,000,000 users in a market. The CMP reports a 55 percent consent opt-in rate for personalized advertising. The addressable, personalizable audience is whatever survives the opt-in.

:::predict
prompt: A market holds 2,000,000 reachable users. The CMP reports a 55% opt-in rate for personalized advertising. How many users are addressable for personalized targeting?
answer: 1100000
tolerance: 5000
unit:
hint: Multiply the reachable users by the opt-in rate.
explain: 2,000,000 times 0.55 equals 1,100,000 addressable users. The other 900,000 declined personalization, so they can only be reached contextually and measured with non-consent methods like aggregated or modeled reporting.
:::

:::widget barChart
title: Addressable users by opt-in rate (2,000,000 reachable, illustrative)
labels: 40%, 55%, 70%, 85%
data: 800000, 1100000, 1400000, 1700000
unit:
:::

# When the CMP misfires

The consent layer is plumbing, and plumbing leaks. A CMP can fail to load before the ad call fires, a wrapper can forget to inject the string, a tag can race ahead of the consent gate, or a geo lookup can apply the wrong jurisdiction. When that happens the bid request goes out with a missing or malformed consent field, and every compliant downstream system reads that as "no consent." The practical result is a quiet degradation: personalized targeting is suppressed, consent-based measurement and attribution drop out, identifiers are not set, and the affected impressions fall back to contextual at lower CPMs. Nothing errors loudly, the money just leaks.

Treat the consent string like any other signal in your discrepancy hygiene. Monitor the share of bid requests that carry a valid GPP or TC string, alert when it dips, and reconcile against your CMP's reported opt-in rate. A sudden gap between "users who consented" and "requests that actually carried the consent string" is almost always a CMP or wrapper bug, not a real change in user behavior.

:::predict
prompt: A site sends 10,000,000 bid requests. The CMP reports a 60% opt-in rate, so about 6,000,000 should carry positive consent. But a wrapper bug strips the string from 8% of all requests, and those are treated as no-consent. How many requests end up carrying valid positive consent?
answer: 5520000
tolerance: 10000
unit:
hint: Apply the 60% opt-in first, then remove the 8% of those that get stripped.
explain: 60 percent of 10,000,000 is 6,000,000 consented requests. The bug strips 8 percent of them, since the stripping hits all requests uniformly: 6,000,000 times 0.08 is 480,000 lost. 6,000,000 minus 480,000 leaves 5,520,000 requests carrying valid positive consent. Those 480,000 silently degrade to contextual.
:::

:::callout insight
Consent failures do not show up as errors, they show up as falling CPMs and shrinking match rates. The ops job is to measure the consent string as a first class signal, not to assume the CMP is fine because the banner renders.
:::

:::sources
- IAB Europe, Transparency and Consent Framework | https://iabeurope.eu/transparency-consent-framework/
- IAB Europe, All You Need to Know About the Transition to TCF v2.3 | https://iabeurope.eu/all-you-need-to-know-about-the-transition-to-tcf-v2-3/
- IAB Tech Lab, Global Privacy Platform (GPP) | https://iabtechlab.com/gpp/
- InteractiveAdvertisingBureau, GPP Section Information | https://github.com/InteractiveAdvertisingBureau/Global-Privacy-Platform/blob/main/Sections/Section%20Information.md
- Prebid, Consent Management GPP module | https://docs.prebid.org/dev-docs/modules/consentManagementGpp.html
- Google Ad Manager Help, Supporting the IAB Global Privacy Platform | https://support.google.com/admanager/answer/14117049
- Didomi, Global Privacy Control (GPC) in 2026 | https://www.didomi.io/blog/global-privacy-control-gpc-2026
- IAPP, US state privacy requirements coming online as 2026 begins | https://iapp.org/news/a/new-year-new-rules-us-state-privacy-requirements-coming-online-as-2026-begins
:::
