---
id: vertical-healthcare-01
track: vertical-healthcare
module: 1
title: The Money Map, Healthcare and Pharma's Programmatic Landscape
summary: Orient in the US healthcare and pharma digital ad market, separate the DTC and HCP buying motions, and understand why HCP promotion needs a purpose-built NPI stack that no generalist DSP can replace.
---
# Two budgets sitting on one identity spine

Before you traffic a single line item in healthcare, you have to know which of two games you are playing. Pharma runs two parallel buying motions on top of each other: DTC (direct-to-consumer, reaching patients) and HCP (reaching licensed prescribers at the level of an individual NPI, the National Provider Identifier). They have different DSPs, different inventory, different KPIs, and different compliance regimes, and the single most common rookie error is co-mingling them in one campaign or one report. The NPI is the spine the entire HCP motion hangs on, and it is the one concept that makes this vertical unlike retail, travel, or commerce.

The reason this matters operationally is that an NPI is a license number, not a cookie or a device ID. A generalist DSP can buy an impression against a browser, but it cannot tell you that the browser belongs to Dr. Smith, NPI 1234567890, a high-volume cardiologist. That single limitation is what forces the entire healthcare-specific stack you are about to learn.

:::callout key
DTC and HCP are two budgets, one stack: separate DSPs, inventory, KPIs, and compliance. Never co-mingle line items or reporting. Mixing a patient-facing CTV buy with an NPI-targeted endemic buy in one report is how you lose the trust of a brand team on day one.
:::

:::quiz
question: A brand wants to reach individual licensed prescribers and tie delivery back to each one's NPI. Which motion is this, and what does it require?
- The DTC motion, runnable on any generalist DSP with contextual targeting
- The HCP motion, which requires a purpose-built healthcare DSP and an NPI graph
- The DTC motion, which requires a HIPAA clean room before launch
- The HCP motion, runnable on open RTB with third-party cookies
answer: 1
hint: Reaching prescribers at the NPI level is the defining feature of one of the two motions.
explain: Targeting and reconciling delivery at the level of an individual prescriber's NPI is the HCP motion, and it requires a purpose-built healthcare DSP with a deterministic NPI graph. The DTC motion reaches patients and can run on open programmatic with condition-contextual targeting and compliance guardrails.
:::

# How big the market is and where the money sits

US healthcare and pharma digital ad spend reached roughly $24.8B in 2025, up about 13 percent year over year, and is forecast to hit about $26.2B in 2026. Digital is now the dominant share of the total mix: against roughly $7.9B in traditional spend, digital is about 75.8 percent of the pie. Digital overtaking linear TV is old news, that happened years ago, but 2025 marked a genuinely new milestone you should be able to state precisely.

The 2025 milestone is that social media (about $6B, up 18.1 percent) outpaced linear TV in this vertical for the first time, while linear TV fell about 11 percent. Notice the distinction the brief is careful about: "digital overtook linear" and "social overtook linear" are two different claims about two different years, and only the social claim is a 2025 first.

:::widget barChart
title: US healthcare and pharma ad spend, digital vs traditional
labels: Digital 2025, Traditional 2025, Digital 2026, Traditional 2026
data: 24.8, 7.9, 26.2, 6.9
unit: US$B
:::

:::predict
prompt: If 2025 US healthcare and pharma digital spend is $24.8B and traditional is $7.9B, what is digital's share of the total?
answer: 75.8
tolerance: 0.3
unit: %
hint: Divide digital by the sum of digital plus traditional.
explain: $24.8B / ($24.8B + $7.9B) = 24.8 / 32.7 = 0.758, so digital is about 75.8 percent of the combined mix. That is why a media plan that still leans on traditional TV is fighting the tape in this vertical.
:::

# Why a generalist DSP cannot do the HCP job

Here is the first lesson that separates a healthcare trader from a generalist: a DSP like DV360 or The Trade Desk cannot map an impression back to an NPI. It can target a contextual segment or a third-party audience, but it has no deterministic, consented graph that says "this device belongs to this licensed prescriber." HCP promotion therefore requires a purpose-built healthcare DSP, while DTC can run on open programmatic with condition-contextual targeting and strict compliance guardrails.

The healthcare-specific stack is a short, named list you should memorize: DeepIntent, PulsePoint, Doceree, and OptimizeRx are the purpose-built DSPs, used alongside generalist DSPs for open-web and CTV reach. They are fed by endemic SSPs and physician-only publishers (Doximity, Medscape, Epocrates) plus EHR and point-of-care networks. Doximity counts over 85 percent of US doctors and about 65 percent of all NPs and PAs as verified members, PulsePoint reaches 700K+ prescribers through EHR integrations, and Doceree spans 2,000+ physician-only platforms covering 6M+ HCPs.

:::figure supplyChain
caption: The healthcare supply chain runs through purpose-built DSPs (DeepIntent, PulsePoint, Doceree, OptimizeRx) feeding off endemic physician publishers and EHR or point-of-care networks, with generalist DSPs added for open-web and CTV scale. The NPI graph is what a generalist stack cannot replicate.
:::

:::quiz
question: Why can a generalist DSP like DV360 not execute HCP promotion on its own?
- It is too expensive for pharma budgets
- It cannot map an ad impression to an individual prescriber's NPI
- It does not support CTV inventory
- It cannot run frequency caps
answer: 1
hint: Think about what an NPI is versus what a generalist DSP can actually address.
explain: A generalist DSP addresses cookies, devices, and contextual segments, but it has no deterministic consented graph linking those to a licensed prescriber's NPI. That is the exact gap a healthcare DSP fills, so HCP promotion requires a purpose-built stack.
:::

# The growth edge and the channel mix

The market is not just large, it is shifting shape, and knowing the direction tells you where to plan inventory. Social passing linear TV in 2025 is the headline, but the durable growth edges are CTV displacing linear TV and EHR or point-of-care scaling fast, with DeepIntent having launched the first CTV marketplace built for pharma and PulsePoint multiplying point-of-care reach through EHR deals. As a new trader, you plan around these growth channels rather than defaulting to the legacy mix.

A useful sanity check is to size social as a share of the digital pie. At about $6B of social inside roughly $24.8B of digital, social is a meaningful and growing slice, and its 18.1 percent growth rate is outrunning the overall market's growth.

:::predict
prompt: Social spend is about $6B inside roughly $24.8B of total healthcare and pharma digital spend in 2025. What is social's share of digital?
answer: 24.2
tolerance: 0.5
unit: %
hint: Divide social spend by total digital spend.
explain: $6B / $24.8B = 0.242, so social is about 24.2 percent of digital. That is a large enough slice that ignoring social, or treating it casually on compliance, is no longer an option in this vertical.
:::

:::predict
prompt: Digital spend grows from $24.8B in 2025 to $26.2B in 2026. What is the year-over-year growth rate?
answer: 5.6
tolerance: 0.3
unit: %
hint: Subtract the two values, then divide by the 2025 figure.
explain: ($26.2B - $24.8B) / $24.8B = 1.4 / 24.8 = 0.056, about 5.6 percent growth. Steady single-digit topline growth with a fast internal shift toward social, CTV, and point-of-care is the shape of this market.
:::

# The only number that funds renewal

It is worth saying on day one what actually grades a pharma campaign, because it reframes everything else you will learn. The signature deliverable in healthcare is not CTR or even CPM efficiency, it is cost per incremental script, the cost per incremental NBRx (new-to-brand) or TRx (total prescriptions) proven through a lift study in a HIPAA clean room. Everything in the stack, the NPI match, the endemic deals, the frequency caps, exists to move that one downstream number.

Build the muscle now with a clean cost-per-script calculation. If a flight spends a known budget and a clean-room lift study attributes a known count of incremental scripts, the cost per script is simply the spend divided by those scripts. This is the metric a brand team uses to decide whether to renew the budget.

:::predict
prompt: A campaign spends $900,000 and a clean-room lift study attributes 3,000 incremental scripts. What is the cost per script?
answer: 300
tolerance: 1
unit: USD
hint: Cost per script is total media spend divided by incremental scripts.
explain: $900,000 / 3,000 = $300 per incremental script. Notice you cannot compute this from clicks or impressions alone, it requires the lagged, clean-room-proven script number, which is why later lessons spend so much time on measurement.
:::

:::callout warning
A recurring operator complaint from the field: clients fixate on CTR and CPM while the only metric that funds renewal is cost per script, which creates a constant education tax on stakeholders. Practitioners also warn that promotion to non-accessible prescribers (those closed to reps) generates demand the field cannot service and frustrates HCPs. Set expectations on the real KPI early, and coordinate digital targeting with the field team so you do not manufacture unserviceable demand.
:::

# The reach-versus-quality trade you will live with

The last orientation point is a constraint, not a number: endemic physician inventory is largely walled-garden and PMP-only, so it does not offer unlimited open-RTB scale. Doximity, Medscape, and Epocrates are high-quality, NPI-rich environments, but they have hard inventory caps. The everyday tension you will manage is match quality (endemic) versus scale (open web), and you plan around inventory caps rather than assuming reach is infinite.

This trade-off is exactly why the stack mixes healthcare DSPs for endemic NPI-matched supply with generalist DSPs for open-web and CTV extension. Sizing how much of your delivery comes from endemic versus open supply is a real planning decision, and it starts with knowing your matched, addressable universe.

:::predict
prompt: A brand's target universe is 50,000 NPIs and your endemic environment can address 76 percent of them with live ad opportunities. How many NPIs are addressable there?
answer: 38000
tolerance: 50
unit: NPIs
hint: Multiply the target universe by the addressable share.
explain: 50,000 x 0.76 = 38,000 addressable NPIs in that endemic environment. The remaining 12,000 are not reachable there, so you either extend to open web with NPI matching or accept a smaller endemic footprint, the classic quality-versus-scale call.
:::

:::quiz
question: Why does the trader plan HCP campaigns around inventory caps rather than unlimited reach?
- Open programmatic has no available inventory in healthcare
- Endemic physician inventory is largely walled-garden and PMP-only, with limited open-RTB scale
- NPI targeting is illegal in the United States
- CTV cannot be bought programmatically
answer: 1
hint: Think about where the highest-quality HCP impressions actually live and how they are sold.
explain: Endemic publishers like Doximity, Medscape, and Epocrates are mostly PMP or programmatic-direct with hard caps, so the high-match supply is finite. The trader balances that scarce endemic quality against open-web scale, planning around the caps.
:::

:::sources
- FiercePharma, 2026 forecast, pharma ad dollars keep moving away from traditional TV | https://www.fiercepharma.com/marketing/2026-forecast-pharma-ad-dollars-will-continue-shifting-away-traditional-tv
- eMarketer, Healthcare and pharma social media ad spending keeps growing as TV ad spending declines | https://www.emarketer.com/content/healthcare-pharma-social-media-ad-spending-keeps-growing-tv-ad-spending-declines
- Doximity, About and Company (over 85% of US doctors, 65% of NPs and PAs) | https://www.doximity.com/about/company
- DeepIntent, Healthcare Audiences and Provider solutions | https://www.deepintent.com/solutions/healthcare-audiences/
- PulsePoint, Curated Private Marketplaces and Endemic Markets | https://www.pulsepoint.com/blog/curated-private-marketplaces
- Improvado, HCP Targeting and Segmentation in Pharma, the 2026 Practitioner's Guide | https://improvado.io/blog/hcp-targeting-segmentation-pharma
- Digiday, How programmatic firms deal with complex pharmaceutical laws | https://digiday.com/marketing/pharma-programmatic/
:::
