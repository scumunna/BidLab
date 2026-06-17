---
track: vertical-finance
title: Financial Services Programmatic Certification
pass: 0.7
draw: 12
---
:::q The Mandate & CPFA
question: A neobank's acquisition lead asks you to recommend the optimization event for a new DV360 prospecting line. Application-complete fires densely and cheaply, signups look great, but past cohorts barely fund. Which event should the line optimize toward?
- Application complete, because dense events train the bidder fastest
- Cost per signup, because it is the cheapest reliable conversion
- Funded account (opened and deposited), even though it is sparse and slow to fire
- Click-through rate, because it shows creative resonance
answer: 2
explain: Finance optimizes to the deepest reliable event because signups and applications are padded with bonus-chasers and KYC failures that never fund. Optimizing above the biggest leak scales junk that looks cheap but never becomes a paying customer.
:::

:::q The Mandate & CPFA
question: A campaign spends $120,000 and produces 800 funded accounts. What is the cost per funded account?
- $150
- $96
- $1.50
- $240
answer: 0
explain: CPFA is media spend divided by funded accounts: 120,000 / 800 = $150. The funded denominator, not signups, is the only base finance reports against.
:::

:::q The Mandate & CPFA
question: A neobank reports a $50 CAC from its dashboard. Reconciliation later adds $25 KYC, $12 sign-up bonus, and $8 card issuance per funded customer. What is the fully-loaded CAC you should report up the chain?
- $50
- $75
- $95
- $45
answer: 2
explain: Fully-loaded CAC adds the per-customer onboarding costs the media number omits: 50 + 25 + 12 + 8 = $95. Reporting media-only CAC gets the trader blamed when finance reconciles the loaded number.
:::

:::q The Mandate & CPFA
question: In a budget review a planner quotes the ~$1.17T total global ad spend figure (2026) as the addressable market for a programmatic finance plan. Why is that the canonical rookie error?
- The figure is last year's number and is already outdated
- That figure is all advertising across every medium; the programmatic slice you actually bid into is the ~$716B subset
- Total ad spend excludes finance, so it understates the real market
- Programmatic spend is larger than total ad spend, so the planner is too conservative
answer: 1
explain: The trillion-dollar headline is total advertising across TV, print, OOH, and direct-sold inventory. The trader only transacts the ~$716B programmatic subset, so quoting the total sets scale targets compliance-restricted finance supply can never fill.
:::

:::q Compliance Rails
question: You are launching a personal-loan campaign on Meta and want to seed it with a 1% lookalike of the bank's highest-balance customers. Under the Financial Products & Services Special Ad Category, what actually happens?
- Lookalikes are blocked in the category; your compliant prospecting path is to upload the bank's first-party Custom Audience and let broad targeting and on-platform lead gen do the prospecting
- The lookalike runs normally because lending is exempt from the category
- The lookalike runs but is automatically capped at a 15-mile radius
- The lookalike is allowed once APR disclosures are uploaded
answer: 0
explain: A personal loan is a financial product, so the campaign runs in the Special Ad Category, which blocks lookalike audiences. The compliant substitute is the bank's own first-party Custom Audience plus broad targeting and on-platform lead gen, since Special Ad Audiences were retired in 2022 and no longer exist.
:::

:::q Compliance Rails
question: An affiliate marketer wants to run Google Search ads for a partner bank's credit card. Under Google's G2 financial-services verification, who completes the verification before the campaign can serve?
- The affiliate self-verifies as an Authorized Advertiser
- No verification is required for affiliates, only for the brand's owned account
- Google auto-verifies any account that uploads a registration number
- The affiliate is an Approved Third Party and cannot self-verify; the bank as First Party must verify on its behalf
answer: 3
explain: An affiliate or agency is an Approved Third Party under G2 and cannot self-verify. The directly-authorized First Party advertiser, the bank, must complete verification on the third party's behalf or the campaign is blocked from in-scope finance inventory.
:::

:::q Compliance Rails
question: A bank wants to drive funded accounts within a 5-mile zone around one branch, but Meta's Special Ad Category forces a 15-mile minimum radius. Treating reach as proportional to area, what share of the served area falls outside the true 5-mile target?
- About 33%
- About 67%
- About 89%
- About 11%
answer: 2
explain: Geo-floor dilution is 1 minus (target radius / floor radius) squared: 1 minus (5/15) squared = 1 minus 0.111 = 0.889, about 89%. The 15-mile floor quietly defeats tight single-branch local strategies.
:::

:::q Compliance Rails
question: A trader wants to build a credit-screened prescreen audience and activate it inside a data clean room so no raw PII is exported. Why might this targeting still be non-compliant?
- Clean rooms are banned under Meta's Special Ad Category
- FCRA still applies, so a prescreen/credit-screened segment is permissible only with a firm offer of credit, regardless of how it was matched
- The audience must achieve at least a 50% overlap rate to be lawful
- RampID cannot be used inside a clean room
answer: 1
explain: A clean room solves the privacy problem but does not touch FCRA, which governs any audience built from a consumer report or prescreen and requires a firm offer of credit. Matching privately is not a workaround for the statute.
:::

:::q Unit Economics & CPFA Ceiling
question: A neobank account earns $120 ARPA at a 50% gross margin with 20% annual churn (a 5-year lifetime). What is the LTV you should use to build the bid ceiling?
- $600
- $300
- $1,200
- $240
answer: 1
explain: LTV is ARPA times gross margin times lifetime (1 / churn): 120 x 0.50 x 5 = $300. Skipping the margin term and using revenue would wrongly give $600 and set a ceiling the business cannot afford.
:::

:::q Unit Economics & CPFA Ceiling
question: A funded account has an LTV of $600, the business requires a 3:1 LTV:CAC ratio, and loaded non-media costs (KYC, bonus, issuance) total $50 per funded account. What is the media-only CPFA ceiling your bids must respect?
- $150
- $200
- $250
- $50
answer: 0
explain: Allowable CAC is LTV / ratio = 600 / 3 = $200. The media-only CPFA ceiling subtracts the non-media loaded cost: 200 minus 50 = $150. The DSP only spends the media portion, so $150, not $200, feeds the bid.
:::

:::q Unit Economics & CPFA Ceiling
question: Your media-only CPFA ceiling is $150 and the cascade delivers 80 funded accounts per 1,000,000 impressions (0.00008 funded per impression). A KYC outage then halves the funded-per-impression rate to 0.00004. What happens to the max CPM the same ceiling can justify?
- It stays at $12 because the ceiling did not change
- It rises from $6 to $12 because scarcer funded accounts are worth more
- It falls from $12 to $6 because the bid scales with funded-per-impression
- It falls from $12 to $9 because the rate dropped one quarter
answer: 2
explain: Max CPM is the CPFA ceiling times funded-per-impression times 1000. At 0.00008 it is 150 x 0.00008 x 1000 = $12; halving the rate to 0.00004 halves the affordable bid to $6. A leaky cascade forces the bid down even when the ceiling is unchanged.
:::

:::q Unit Economics & CPFA Ceiling
question: Two products both have a $150 media-only CPFA ceiling. Product A returns $25 of gross margin per month; Product B returns $10 per month. On a CAC payback basis, which is the safer buy?
- Product B, because a lower monthly margin carries less risk
- They are identical because the CPFA ceiling is the same
- Product A, because it pays back in 6 months versus 15 for Product B
- Product B, because it pays back in 6 months
answer: 2
explain: CAC payback is the ceiling divided by monthly margin. Product A pays back in 150 / 25 = 6 months; Product B in 150 / 10 = 15 months. The same ceiling can hide very different cash-flow risk, which is why payback is the cross-check.
:::

:::q Conversion Cascade & Event QA
question: A finance line shows a strong CTR and a cheap cost per application-complete, yet almost no funded accounts. The funnel runs impression to click to application to KYC-submitted to KYC-approved to funded. Where does most finance spend evaporate?
- Between impression and click, where creative is weakest
- Between click and application start, where the landing page loads
- Between impression and viewable impression, lost to ad-blockers
- Between KYC approval and first deposit, the largest single leak
answer: 3
explain: The defining finance leak sits between KYC approval and first deposit, downstream of application-complete. That is exactly why optimizing to application-complete rewards stages before the biggest leak and scales accounts that never fund.
:::

:::q Conversion Cascade & Event QA
question: A line drives 8,000 KYC submissions and 5,200 are approved. What is the KYC drop-off rate?
- 35%
- 65%
- 40%
- 53%
answer: 0
explain: KYC drop-off is 1 minus approved over submitted: 1 minus (5,200 / 8,000) = 1 minus 0.65 = 0.35, a 35% drop-off. More than a third never clear verification before a single dollar is deposited.
:::

:::q Conversion Cascade & Event QA
question: You add a server-side Conversions API alongside your existing web pixel, and reported funded accounts jump the next day. Before calling it incremental lift, what should you check first?
- Whether the SKAdNetwork postback window expanded overnight
- Whether risk and compliance changed the KYC flow
- Whether pixel and CAPI events are deduplicated by a shared event ID, since the same funded event sent by both can double-count
- Whether the funded-event value tolerance was loosened
answer: 2
explain: A web pixel and CAPI often report the same funded event, so without deduplication by a shared event ID the platform counts it twice. A funded count that jumps right after CAPI goes live is usually duplicates, not lift.
:::

:::q Conversion Cascade & Event QA
question: On iOS after App Tracking Transparency, why can a finance trader not expect real-time, user-level funded attribution the way the web funnel allows?
- iOS apps are forbidden from tracking funded accounts entirely
- Mobile measurement partners do not support iOS
- The funded event must be entered manually by each user
- SKAdNetwork collapses the funded signal into a coarse, delayed, aggregated conversion value controlled by Apple
answer: 3
explain: SKAdNetwork encodes post-install behavior into a small conversion value and fires privacy-preserving postbacks after delayed windows, so a funded signal on iOS arrives late and aggregated. Web keeps a deterministic pixel-plus-CAPI funnel; iOS forces planning around coarse, delayed data.
:::

:::q Incrementality & Budget Defense
question: A retargeting line shows a 9x last-click ROAS, but a clean geo holdout measures its incremental ROAS at 1.2x. What is the most defensible read for budget decisions?
- Retargeting is your best channel; shift more budget into it
- The holdout is wrong because last-click is the platform's official number
- The line is mostly harvesting demand that already existed; most of its credit is not incremental
- An incremental ROAS below the reported number always means the test failed
answer: 2
explain: A high reported number next to a near-1.0 incremental number is the signature of demand harvesting. The honest, smaller number is the point of the test and outranks last-click, which credits whoever was nearest the conversion regardless of causation.
:::

:::q Incrementality & Budget Defense
question: A geo test market produces 1,000 funded accounts with ads on. The matched control, scaled to the same population, produces 700 with ads off. The test spent $66,000 of incremental media. What is the incremental cost per funded account?
- $220
- $94
- $66
- $200
answer: 0
explain: Incremental funded accounts are 1,000 minus 700 = 300. Incremental CPFA is incremental spend over incremental funded: 66,000 / 300 = $220. Compare this to the LTV-derived ceiling, not the flattering last-click CPFA.
:::

:::q Incrementality & Budget Defense
question: A finance geo holdout ran for five days and returned a noisy, non-significant lift. What is the most likely fix?
- Switch from geo holdout to last-click attribution
- Run the test for several weeks so enough sparse, delayed funded events accumulate
- Add national CTV to the test markets to boost volume
- Declare the channel non-incremental and cut it immediately
answer: 1
explain: Finance funded events are sparse and delayed, so a five-day window cannot accumulate enough to reach significance. Extending to weeks fixes it; last-click reintroduces bias, national CTV contaminates the control, and cutting on noise is premature.
:::

:::q Incrementality & Budget Defense
question: A view-through model credits a funded account to your campaign. What is the model actually asserting about that account?
- That the person clicked the ad before funding
- That the ad created demand that would not have existed otherwise
- That the funded account was incremental to organic demand
- That an impression was served before the account funded, regardless of whether anyone saw or acted on it
answer: 3
explain: View-through attribution only requires that an impression was served before the conversion. It needs no click, no viewable impression, and no proof the ad caused funding, which is why it overstates paid impact on warm finance audiences.
:::

:::q Deal Architecture & SPO
question: A bank needs to lock guaranteed share-of-voice in a personal-finance section during tax season and cannot afford to lose the auction. Which deal type fixes both the CPM and a committed impression volume?
- Open auction (RTB)
- Private marketplace (PMP)
- Preferred deal
- Programmatic guaranteed (PG)
answer: 3
explain: Programmatic guaranteed fixes both price and committed volume, the programmatic version of a direct-sold buy. PMP is an invite-only auction with a floor, a preferred deal fixes price but not volume, and the open auction fixes neither.
:::

:::q Deal Architecture & SPO
question: A premium finance publisher's net CPM is $9, and the supply path to reach it carries a combined 40% intermediary take-rate. What effective CPM does the buyer actually pay?
- $15.00
- $12.60
- $9.00
- $22.50
answer: 0
explain: Effective CPM is publisher net CPM divided by (1 minus take-rate): 9 / (1 minus 0.40) = 9 / 0.60 = $15.00. The 40% stacked take-rate means the buyer pays $15 to deliver $9 to the publisher, which is why SPO matters most in high-CPM finance.
:::

:::q Deal Architecture & SPO
question: A trader signs a programmatic-guaranteed deal for 5,000,000 impressions at a fixed $18 CPM, expecting a 0.06% funded-per-impression rate. What is the expected cost per funded account, and what is the risk if the cascade leaks worse than assumed?
- $30, and the risk is none because PG flexes with performance
- $30, and the risk is the buyer still owes the $90,000 even if funded volume falls short
- $18, and the risk is the publisher renegotiates the floor
- $50, and the risk is the Deal ID fails to wire
answer: 1
explain: Funded accounts are 5,000,000 x 0.0006 = 3,000, so CPFA is 90,000 / 3,000 = $30. PG converts auction risk into a balance-sheet commitment: the guarantee does not flex, so a worse cascade still owes the full committed spend.
:::

:::q Deal Architecture & SPO
question: A trader pays a premium CPM on a PMP marketed as premium news but still finds ads appearing next to unsafe content. What is the most likely cause?
- The Deal ID failed to wire into the DSP
- The deal's underlying inventory package was never actually curated
- Programmatic guaranteed always includes unsafe inventory
- Supply-path optimization removed the safe publishers
answer: 1
explain: A Deal ID is only as brand-safe as the publisher list behind it, so an uncurated package can carry unsafe subdomains despite the premium label. A failed Deal ID would not spend at all, and SPO consolidates paths rather than swapping in unsafe supply.
:::
