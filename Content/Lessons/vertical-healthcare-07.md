---
id: vertical-healthcare-07
track: vertical-healthcare
module: 7
title: Endemic SSP/PMP Setup, Brand Safety, and Suppression
summary: Assemble HCP supply by trafficking NPI-scoped endemic private deals, tune brand safety so it filters risk without over-blocking legitimate medical inventory, and build a suppression workflow that stops budget from leaking to low-decile and non-accessible prescribers.
---
# Why HCP supply is a deal desk, not an open exchange

In most verticals you point a DSP at the open exchange, set a bid, and scale. In Healthcare the high-value HCP inventory does not live there. Endemic physician environments (Doximity, Medscape, Epocrates) and EHR/point-of-care networks are overwhelmingly PMP and programmatic-direct, sold through private deal IDs scoped to NPI-matched audiences, not open RTB. So the supply step of this job is a deal desk: you negotiate and traffic curated packages (PulsePoint Curated/Endemic Markets, DeepIntent's pharma CTV marketplace) rather than buying a generic open-exchange line.

That structure exists because the publishers verify the prescriber and gate the audience. Open RTB cannot tell you a bid request belongs to a decile-8 cardiologist, but an endemic PMP scoped to your NPI list can. The deliverable of this lesson is a documented deal-and-inventory package, with brand-safety settings and suppression lists attached, that a teammate could traffic and QA without guessing.

:::figure supplyChain
caption: The HCP supply chain runs through purpose-built healthcare DSPs into endemic SSPs and EHR/point-of-care networks via NPI-scoped private deals, with open-web/CTV as a controlled extension layer rather than the primary buy.
:::

# Endemic share: the match-quality versus scale lever

The first real decision is how much of the buy sits in endemic PMP versus open-web NPI extension. Endemic supply carries the highest match quality and the cleanest medical context, but it has hard inventory caps, so it cannot absorb an unlimited budget. Open-web and CTV extension scales reach but dilutes match quality and brand-safety control, so the operator sets a deliberate split rather than letting the DSP default it.

The lever is the endemic share, the fraction of impressions you commit to private endemic deals.

$$ \text{Endemic share} = \frac{\text{endemic (PMP) impressions}}{\text{total impressions}} $$

:::predict
prompt: A flight is planned for 8,000,000 impressions, of which 4,400,000 are committed to endemic PMP deals and the rest run on open-web NPI extension. What is the endemic share?
answer: 55
tolerance: 0.5
unit: %
hint: Divide endemic impressions by total impressions.
explain: 4,400,000 / 8,000,000 = 0.55, a 55 percent endemic share. The remaining 3,600,000 (45 percent) run on open-web/CTV extension, which scales reach but trades away the match quality and medical context the endemic deals provide.
:::

# Trafficking NPI-scoped deal IDs

Once the split is set, the work is mechanical and unforgiving: each deal ID must be scoped to the right NPI audience, the right geo, and the right environment (endemic display, EHR newsletter, point-of-care, curated CTV). A deal ID scoped to the wrong audience or geo does not error. It serves quietly to the wrong prescribers, and you only discover it when scripts come in low or a match-back reconciliation flags the audience. QA the scoping before the deal goes live, not after.

You also track delivery against what the deal promised, because endemic caps mean a deal that looked large in negotiation can under-deliver. The deal fill rate is the basic health check.

$$ \text{Deal fill rate} = \frac{\text{delivered deal impressions}}{\text{available deal impressions}} $$

:::predict
prompt: A PMP deal is forecast at 2,000,000 available impressions and delivers 1,500,000 over the flight. What is the deal fill rate?
answer: 75
tolerance: 0.5
unit: %
hint: Divide delivered impressions by available impressions.
explain: 1,500,000 / 2,000,000 = 0.75, a 75 percent fill rate. The 500,000-impression shortfall is exactly the kind of endemic under-delivery that forces a scramble for compliant open-web scale, which is why you line up backup deals before launch rather than after the gap appears.
:::

:::quiz
question: Why does HCP promotion lean on private deal IDs (PMP/programmatic-direct) rather than open RTB?
- Open RTB is always cheaper, so deals exist only to mark up inventory
- Endemic physician and EHR inventory is largely sold programmatic-direct, and deals scope delivery to verified NPI-matched audiences
- Deal IDs are required by the FDA for all pharma advertising
- Open RTB cannot serve video, so CTV forces a PMP
answer: 1
hint: Think about where verified-prescriber inventory actually lives and how the audience gets scoped.
explain: Endemic environments (Doximity, Medscape, Epocrates) and EHR/point-of-care networks are overwhelmingly PMP/programmatic-direct, and a private deal lets the publisher scope delivery to your verified NPI-matched audience. Open RTB cannot map a bid request to an NPI, so it cannot execute HCP promotion on its own. The FDA does not mandate deal IDs, and PMPs are not a video-only construct.
:::

# Brand safety: filtering risk without strangling reach

On the open-web and CTV extension layer, brand safety is a workflow you own, not a checkbox. Pharma blocklists keep ads off inappropriate or non-accessible content around sensitive medical topics. The trap, and it is a documented and expensive one, is over-blocking: heavy third-party keyword blocklists routinely strip legitimate medical and news publishers, choking spend and reach. The failure is symmetric, over-blocking wastes as surely as under-blocking, because every eligible quality impression a false positive removes is reach you paid a team to plan and then threw away.

You can size that waste directly so it is a number, not a vibe.

$$ \text{Over-block cost} \approx \text{eligible impressions blocked} \times \frac{\text{CPM}}{1000} $$

:::predict
prompt: An aggressive keyword blocklist false-positives 1,200,000 otherwise-eligible medical-content impressions off a buy running at a $32 CPM. Roughly how much reach value is lost to over-blocking?
answer: 38400
tolerance: 100
unit: USD
hint: Multiply blocked impressions by the CPM divided by 1,000.
explain: 1,200,000 x ($32 / 1,000) = 1,200,000 x 0.032 = $38,400 of eligible inventory removed by false positives. This is why you audit the blocklist for false positives instead of trusting a vendor default, the lost reach is invisible in a standard delivery report but it directly starves pacing.
:::

# Suppression: the standalone workflow that protects the script number

Suppression is its own deliverable, separate from targeting. Even inside a correctly matched, brand-safe deal, you actively remove NPIs that should not be spent on: suppress deciles 1 to 4 (low or non-writers), suppress non-target specialties, and suppress non-accessible prescribers whose generated demand cannot be serviced by the field. The net addressable supply is what survives after suppression, and it, not the raw matched count, is what your pacing math should use.

$$ \text{Net addressable supply} = \text{matched NPIs in-deal} - \text{suppressed NPIs} $$

:::predict
prompt: A deal resolves to 30,000 matched NPIs. You suppress 6,000 NPIs that are low-decile or non-accessible. What is the net addressable count?
answer: 24000
tolerance: 0
unit: NPIs
hint: Subtract suppressed NPIs from matched NPIs.
explain: 30,000 - 6,000 = 24,000 net addressable NPIs. Pace and forecast against 24,000, not 30,000, because spend aimed at the suppressed 6,000 either burns on non-writers or, worse, generates demand a rep cannot fill.
:::

:::widget barChart
title: Where the suppression cascade trims a 50,000-NPI target universe
labels: Target universe, Matched in-deal, After decile 1-4 cut, Net addressable
data: 50000, 38000, 28000, 24000
unit: NPIs
:::

:::callout warning
The most-cited operator pain here is reconciliation with the field team. Suppressing non-accessible prescribers (those closed to reps) is correct for digital, but practitioners report that "promotion to non-accessible prescribers generates demand that cannot be filled and creates HCP frustration," while uncoordinated suppression can leave digital and reps double-spending the same accessible HCP. Suppression lists must be reconciled against the field/CRM rep-call plan before launch, or you either strand serviceable demand or pay twice for the same prescriber.
:::

# Putting the package together and QA-ing it live

The output of all of this is a single coherent package: scoped deal IDs (endemic plus EHR plus any curated CTV), a documented endemic-versus-extension split, brand-safety settings audited for false positives, and a suppression list reconciled with the field. Before flipping it live, you QA the deal scoping (audience, geo, environment), confirm the blocklist is not starving eligible supply, and stage backup deals so an endemic under-delivery does not blow the flight.

The recurring failure modes are predictable, so name them in your QA checklist: deals scoped to the wrong audience/geo, endemic caps under-delivering against forecast, blocklists over-blocking legitimate inventory, and suppression that is out of sync with the rep plan. Each one fails silently, which is exactly why a written package beats an open-exchange buy you assume is working.

:::quiz
question: A pharma flight is under-pacing and reach looks thin. Which cause is the over-blocking failure mode specifically?
- The NPI-to-device identity graph dropped stale prescribers, lowering match rate
- Aggressive third-party keyword blocklists are false-positiving legitimate medical and news inventory out of the buy
- The frequency cap is set too low across channels
- The clean-room lift study has not closed its Rx-lag window yet
answer: 1
hint: Which lever directly removes otherwise-eligible quality inventory from delivery?
explain: Over-blocking is keyword blocklists stripping eligible medical/news inventory, which starves pacing and reach even though every removed impression was safe. A dropped identity graph is a match-rate problem, a low frequency cap is a delivery-discipline problem, and an unclosed Rx-lag window is a measurement-timing problem, those are real but they are different failure modes from over-blocking.
:::

:::sources
- Improvado, HCP Targeting and Segmentation in Pharma: The 2026 Practitioner's Guide | https://improvado.io/blog/hcp-targeting-segmentation-pharma
- PulsePoint, Curated Private Marketplaces and Endemic Markets | https://www.pulsepoint.com/blog/curated-private-marketplaces
- DeepIntent, Healthcare Audiences and Provider Solutions | https://www.deepintent.com/solutions/healthcare-audiences/
- Digiday, How programmatic firms deal with complex pharmaceutical laws | https://digiday.com/marketing/pharma-programmatic/
- MM+M, Turning off programmatic ads: Why one pharma took the bold step | https://www.mmm-online.com/news/turning-off-programmatic-ads-why-one-pharma-took-the-bold-step/
- Doximity, About and Company | https://www.doximity.com/about/company
- FiercePharma, 2026 forecast: Pharma ad dollars keep shifting away from traditional TV | https://www.fiercepharma.com/marketing/2026-forecast-pharma-ad-dollars-will-continue-shifting-away-traditional-tv
:::
