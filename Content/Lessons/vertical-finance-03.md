---
id: vertical-finance-03
track: vertical-finance
module: 3
title: Compliance Rails, the targeting levers finance loses
summary: Internalize the three rails that reshape every finance buy, Meta's Special Ad Category, Google's G2 verification, and FCRA on credit-screened audiences, and model what each one costs you in reach, precision, and cost per funded account.
---
# Three rails reshape every finance buy

In every other vertical the trader's job starts with targeting. In finance it starts with what targeting you are no longer allowed to use. Three regimes sit on top of the auction, two platform policies and one federal statute, and together they strip the levers you would normally pull, force a coarse geo and age, and gate which inventory you can even bid on. A buy-side hire who does not internalize Meta's Special Ad Category, Google's G2 verification, and the Fair Credit Reporting Act will get campaigns disapproved, accounts restricted, or the advertiser into regulatory trouble before a single funded account lands.

The through-line for this lesson is that compliance is not a legal footnote you hand off, it is an input to your media math. Every banned lever widens the audience and dilutes funded-per-impression, and a wider, looser audience pushes your cost per funded account (CPFA) up against the LTV-derived ceiling. Treat the rails as economics, not paperwork.

:::callout key
The signature KPI of this vertical is cost per funded account, media spend divided by accounts that opened and deposited. Every rail in this lesson makes that number harder to hit, because each one removes precision you would otherwise use to reach prospects who actually fund. Read this lesson as "what compliance costs my CPFA," not "what compliance forbids."
:::

:::quiz
question: The lesson frames the three finance rails as two platform policies and one federal statute. Which one is the federal statute, enforceable in law rather than set by an ad platform's own rules?
- Meta's Financial Products and Services Special Ad Category
- Google's G2 financial-services verification requirement
- The Fair Credit Reporting Act governing credit-screened audiences
- All three are platform policies; none is a statute
answer: 2
hint: Two are rules a single ad platform can change on its own; only one is an act of Congress that binds every advertiser on any channel.
explain: Meta's Special Ad Category and Google's G2 verification are platform policies, rules each company sets and can revise for its own inventory. The Fair Credit Reporting Act is a US federal statute that governs any audience built from a consumer report or prescreen on any channel, so violating it is a legal exposure, not just a disapproved campaign. Knowing which rail is law and which is policy tells you which mistakes risk a blocked ad versus a regulatory problem for the advertiser.
:::

# Meta's Special Ad Category strips the levers

Effective January 21, 2025 for US advertisers, any ad for a financial product or service on Meta, banking, loans, BNPL, investing, insurance, even financial education, must be declared in the Financial Products and Services Special Ad Category (SAC). Declaring it is not optional, and it disables your sharpest tools. Under SAC you lose custom-audience lookalikes and Advantage+ audience expansion, age is locked to 18 to 65+, gender targeting is removed, detailed-demographic, ZIP, and income gating are gone, and a 15-mile minimum location radius is forced. The compliant prospecting path is the bank's own first-party Custom Audience plus broad, automated delivery and on-platform lead generation, since Meta retired Special Ad Audiences in 2022 and no lookalike-style substitute exists.

The practical effect is a much broader, blunter audience than you would build for a non-regulated product. Where a clean lookalike might address a few percent of a base, SAC pushes you toward broad-with-no-lookalike delivery and a coarse geo, so a larger share of impressions land on people who will never fund. That is the mechanism by which a policy rule becomes a CPFA problem.

:::figure costPerFundedCascade
caption: Each SAC restriction widens the audience, lookalikes off, age locked 18 to 65+, ZIP and income gone, a 15-mile floor, so more impressions land on non-prospects. That thins funded-per-impression at every stage of the cascade and pushes cost per funded account up against the LTV-derived ceiling.
:::

:::quiz
question: A trader is launching a personal-loan campaign on Meta and wants to seed it with a 1% lookalike of the bank's best customers. Under the Financial Products and Services Special Ad Category, what actually happens?
- The lookalike runs normally because lending is exempt from SAC
- Custom-audience lookalikes are banned in SAC; the compliant path is a first-party Custom Audience plus broad targeting and on-platform lead gen
- The lookalike runs but is capped at a 15-mile radius
- Lookalikes are allowed only if the advertiser uploads APR disclosures
answer: 1
hint: SAC removes the lookalike lever; the fallback is your own data plus broad delivery.
explain: A personal loan is a financial product, so the campaign must run in SAC, and SAC bans custom-audience lookalikes outright. The compliant prospecting path is the bank's own first-party Custom Audience plus broad targeting and on-platform lead gen, since Meta retired Special Ad Audiences in 2022. The 15-mile floor and disclosure rules are real but separate constraints.
:::

# The 15-mile geo floor quietly dilutes local strategies

The SAC location floor deserves its own treatment because it silently breaks tight-ZIP plans. If you are trying to drive funded accounts around a single bank branch or a small in-market footprint, the 15-mile minimum radius spills impressions across a far larger area than your true target, and you pay to reach people outside the intended zone. The right move is to model the dilution before launch rather than assume pinpoint local reach.

The math is just area. A circular target zone of radius $r_t$ inside a forced floor of radius $r_f$ leaves a spill ring, and the share of the served area that sits outside your real target is the geo-floor dilution.

$$ \text{geo-floor dilution} = \frac{\pi r_f^2 - \pi r_t^2}{\pi r_f^2} = 1 - \left(\frac{r_t}{r_f}\right)^2 $$

:::predict
prompt: You want to reach a 5-mile zone around a branch, but Meta's SAC forces a 15-mile minimum radius. Treating reach as proportional to area, what share of the served area falls outside your true 5-mile target?
answer: 88.9
tolerance: 0.5
unit: %
hint: Compare the two circle areas, target over floor, then subtract from 1.
explain: Target area is pi times 5 squared = 78.54, the forced floor area is pi times 15 squared = 706.86. The spill is 706.86 minus 78.54 = 628.32, and 628.32 divided by 706.86 = 0.889. About 88.9 percent of the served area is outside your intended zone, which is why a single-branch strategy bleeds badly under the geo floor.
:::

:::predict
prompt: A precise-ZIP plan would reach 500,000 in-market users, but the 15-mile floor forces delivery across a population of 4,500,000. What share of the reachable audience is actually your intended target?
answer: 11.1
tolerance: 0.3
unit: %
hint: Divide the intended target by the total forced-reach population.
explain: 500,000 divided by 4,500,000 = 0.111, about 11.1 percent. Roughly nine in ten reachable users sit outside your real target, so unless your creative and bid strategy compensate, funded-per-impression drops and CPFA climbs. Model this dilution before you commit budget to a local finance push.
:::

# Google's G2 verification gates the inventory

Google runs a parallel rail through G2 (G2 Risk Solutions). Advertisers of in-scope financial services must verify through G2, proving that a regulator directly authorizes them (or that they are exempt) plus a registration number, then submit the unique G2 code to Google. Until that code is on file, unverified advertisers are blocked from in-scope finance inventory. G2 began processing applications in 2026, so onboarding lead time is now part of campaign planning, not an afterthought.

The detail that trips up agencies is the two-role structure. A directly-authorized brand is a First Party or Authorized Advertiser and can verify itself. An agency or affiliate is an Approved Third Party and cannot self-verify, the directly-authorized First Party must complete verification on its behalf. Plan client onboarding around this, because discovering it mid-launch means the campaign simply will not serve.

:::quiz
question: An affiliate marketer wants to run search ads for a partner bank's credit card on Google. Under G2 financial-services verification, who completes the verification?
- The affiliate self-verifies as an Authorized Advertiser
- The affiliate is an Approved Third Party and cannot self-verify; the bank as First Party must verify on its behalf
- No verification is needed for affiliates, only for the brand's owned account
- Google auto-verifies any account that uploads a registration number
answer: 1
hint: One role can self-verify, the other depends on the licensed brand to do it for them.
explain: An affiliate or agency is an Approved Third Party under G2 and cannot self-verify. The directly-authorized First Party advertiser, the bank, must complete verification on the third party's behalf, or the campaign is blocked from in-scope finance inventory. Build this dependency into client onboarding timelines.
:::

# FCRA governs any credit-screened audience

The third rail is federal law, not platform policy. Any audience built from a consumer report or a prescreen is governed by the Fair Credit Reporting Act (FCRA). Such an audience is permissible only if it results in a firm offer of credit (or insurance). Each name on a prescreen list counts as a consumer report that requires a permissible purpose, and a Prescreened Opt-Out Notice must accompany the offer. "Trigger leads," signals that someone is actively shopping for credit, are a 2025 examiner focus, so treat them as high-scrutiny.

The exposure is not only the advertiser's. If you, the trader, build or activate a credit-screened or prescreen segment without a firm offer of credit behind it, that targeting itself can be non-compliant. Credit-screened lookalikes are not a free workaround, and a clean room does not exempt you, a credit-screened segment matched privately still needs a firm offer to be lawful.

:::callout warning
A real and recurring operator pain point, straight from finance and housing advertisers on Reddit, is that accounts get restricted for running loan or finance creatives in a standard, non-SAC campaign without realizing the category was mandatory. Practitioners describe the same trap on Google, especially affiliates who discover they cannot self-verify and must route through the licensed brand, and who lose days while the campaign sits blocked. The fix is structural, not reactive, build finance campaigns inside SAC and complete G2 verification before you launch, never after a disapproval.
:::

:::predict
prompt: A finance campaign is launched in a standard (non-SAC) Meta account and gets restricted on day 20 of a 30-day flight with a $48,000 budget that was pacing evenly. How much of the budget is stranded by the restriction?
answer: 16000
tolerance: 100
unit: USD
hint: Even pacing means $1,600 per day, and the account is down for the last 10 days.
explain: A $48,000 budget over 30 days at even pace is 48,000 divided by 30 = $1,600 per day. A restriction on day 20 kills the final 10 days, so 10 times 1,600 = $16,000 of planned spend is stranded. That is budget you cannot redeploy mid-flight, which is why running outside SAC is a CPFA disaster, not just a policy slap.
:::

# Putting the rails into CPFA math

The reason a trader, not just legal, owns these rails is that each one moves funded-per-impression, and funded-per-impression sets your bid. The compliant reachable audience is your total audience minus the banned-lever exclusions minus the overlap lost to the 15-mile floor. A broader, coarser audience means more impressions on non-prospects, a lower funded rate, and therefore a lower max CPM you can justify against the same CPFA ceiling.

$$ \text{compliant reachable audience} = \text{total audience} - \text{banned-lever exclusions} - \text{geo-floor overlap loss} $$

Work a concrete case. If compliance forces your funded rate down, the same CPFA ceiling implies a lower bid, because max CPM is the CPFA ceiling times funded-per-impression times 1000. The chart below shows which standard levers survive SAC, almost none, which is exactly why finance leans on first-party data, clean rooms, and curated deals (covered later in this path) to claw precision back.

:::widget barChart
title: Standard targeting levers under Meta's Financial Products and Services SAC (1 = available, 0 = banned or forced)
labels: ZIP targeting, Age precision, Gender targeting, Lookalike audiences, Detailed demo/income, 15-mi geo floor
data: 0, 0, 0, 0, 0, 1
unit: available
:::

:::predict
prompt: Before compliance, a finance line funds 80 accounts per 1,000,000 impressions against a $150 CPFA ceiling. SAC's broader audience cuts the funded rate to 50 per 1,000,000. By what percent must your max CPM fall to hold the same CPFA ceiling?
answer: 37.5
tolerance: 0.5
unit: %
hint: Max CPM scales linearly with funded-per-impression, so compare 50 to 80.
explain: Max CPM equals the CPFA ceiling times funded-per-impression times 1000. At 80 per million the ceiling supports 150 times (80 / 1,000,000) times 1000 = $12.00. At 50 per million it supports 150 times (50 / 1,000,000) times 1000 = $7.50. The drop is (12.00 minus 7.50) divided by 12.00 = 0.375, a 37.5 percent lower bid for the same target. That is the compliance tax on your media math.
:::

:::quiz
question: Why does a finance trader, not just the legal team, need to own the SAC, G2, and FCRA rails?
- Because legal teams cannot access ad platforms
- Because each rail widens or gates the audience, which changes funded-per-impression and therefore the bid and CPFA
- Because the rails only affect creative approval, which is a media task
- Because compliance has no effect on auction economics
answer: 1
hint: Think about what a coarser, broader, or blocked audience does to funded-per-impression.
explain: The rails are media inputs. Banned levers and the geo floor broaden and dilute the audience, lowering funded-per-impression, which lowers the max CPM that the CPFA ceiling can justify. G2 can block inventory entirely. A trader who treats compliance as someone else's job will misprice bids and overspend, so the rails belong in the media plan, not just the legal review.
:::

:::sources
- Data Axle, The 2025 Meta Special Ad Categories Rules You Need to Know (SAC rules: 18 to 65+, no lookalike, all genders, ZIP blocked) | https://www.data-axle.com/resources/blog/meta-special-ad-categories-rules/
- Meta Transparency Center, Financial and Insurance Products and Services Ad Standard (platform policy) | https://transparency.meta.com/policies/ad-standards/restricted-goods-services/financial-services/
- Google Ads Policy Help, New Verification Requirements for Certain Financial Services Advertisers (G2) | https://support.google.com/adspolicy/answer/16888296?hl=en
- G2 Risk Solutions, Financial Services Verification (First Party authorized advertisers verify; affiliates and brokers cannot self-verify) | https://g2risksolutions.com/financial-services/
- FDIC, FCRA Compliance: Firm Offers of Credit and Prescreened Solicitations (Consumer Compliance Examination Manual VIII-6) | https://www.fdic.gov/consumer-compliance-examination-manual/viii-6-fair-credit-reporting-act
- ExchangeWire, Navigating Brand Safety in 2025: Insights from the Ad Industry | https://www.exchangewire.com/blog/2025/10/06/navigating-brand-safety-in-2025-insights-from-the-ad-industry/
- eightx, LTV:CAC Ratio: Why 3:1 Matters and CAC Payback Benchmarks | https://eightx.co/blog/ltv-cac-ratio-guide
:::
