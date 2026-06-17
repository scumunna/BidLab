---
id: vertical-healthcare-04
track: vertical-healthcare
module: 4
title: NPI-to-Device Match Rate, the core daily-ops competency
summary: Connect a prescriber's NPI to the devices they browse on, set a match-rate floor in the IO, monitor it daily, diagnose the six failure modes, and quantify the spend you waste when the match breaks.
---
# Why an NPI is not a cookie

An NPI (National Provider Identifier) is a ten-digit license number issued to a prescriber, not a browsing identifier. Nothing about an NPI tells a DSP which laptop, phone, or connected-TV that doctor actually opens, so a healthcare DSP has to bridge the gap with an identity graph that links each NPI to the cookies, mobile ad IDs (MAIDs), and CTV IDs the prescriber uses. That bridge is the entire reason a generalist DSP cannot run HCP promotion: DV360 can buy a device, but it has no map from a device back to a licensed NPI. This lesson is about the quality of that bridge, because per the buy-side lens it is the single biggest source of waste in the vertical.

The metric that scores the bridge is the match rate: the share of your target NPI list the DSP can actually address with live ad opportunities. Everything downstream (reach, frequency, cost per script) rides on it, so the operator treats match rate as a daily-monitored number, not a one-time setup value.

:::figure npiTargeting
caption: An NPI is a license number. The identity graph links it to the cookies, MAIDs, and CTV IDs the prescriber browses on, and the match rate is the share of your target list that resolves to live, addressable devices.
:::

# Defining and reading the match rate

Match rate is simple to state and easy to misread. It is the matched (addressable) NPIs divided by the total NPIs on your target list.

$$ \text{match rate} = \frac{\text{matched (addressable) NPIs}}{\text{total target NPIs}} $$

The number you care about for delivery planning is effective reach, because a matched NPI still has to show up with an in-market ad opportunity during your flight. So you stack three factors: the universe size, the match rate, and in-market availability.

$$ \text{effective reach} = \text{target universe} \times \text{match rate} \times \text{in-market availability} $$

:::predict
prompt: You target 40,000 NPIs and the DSP can address 30,000 of them with live ad opportunities. What is the match rate?
answer: 75
tolerance: 0.5
unit: %
hint: Matched addressable NPIs divided by the total target list.
explain: 30,000 / 40,000 = 0.75, a 75 percent match rate. The other 10,000 NPIs are on your list but unaddressable through this DSP, so no budget can reach them no matter how much you spend.
:::

:::predict
prompt: A 40,000-NPI universe runs at a 75% match rate, and during the flight only 60% of matched prescribers are in-market with a live opportunity. What is the effective reach in NPIs?
answer: 18000
tolerance: 50
unit: NPIs
hint: Multiply the universe by the match rate, then by in-market availability.
explain: 40,000 times 0.75 equals 30,000 matched, and 30,000 times 0.60 equals 18,000 actually reachable in the flight. The headline universe of 40,000 overstates real reach by more than half once match rate and availability compound.
:::

# What "good" looks like by environment

Match rate is not one number, it is a property of where you buy. A best-in-class deterministic, opted-in graph resolves almost the whole list in seconds: DeepIntent reports 95 percent or better NPI match in under 10 seconds, linking roughly 7 digital identifiers to each NPI, where the industry norm without that graph is 30 to 70 percent over 3 to 7 business days. Endemic physician environments sit in a middle band, and open programmatic display sits lowest, so the operator plans the supply mix knowing that scale and match quality pull against each other.

The practical defaults from the field: Doximity runs about 70 to 85 percent, Epocrates about 65 to 80 percent, Medscape about 60 to 75 percent, and open programmatic display often only 50 to 70 percent. You write a match-rate floor into the IO (commonly around 70 percent addressable), check the vendor's match guarantee, and reconcile delivered matched impressions against that floor.

:::widget barChart
title: NPI match rate by environment (midpoints, %)
labels: DeepIntent deterministic, Doximity, Epocrates, Medscape, Open display
data: 95, 78, 73, 68, 60
unit: %
:::

:::quiz
question: A vendor pitches a 92% blended match rate, but most of the links are probabilistic. Why is that not automatically as good as a 78% deterministic rate?
- A higher percentage always means less wasted spend
- Probabilistic links can resolve to the wrong device, so a high blended rate can still misdeliver
- Probabilistic matching is illegal under HIPAA
- Deterministic and probabilistic rates measure different list sizes
answer: 1
hint: Ask what each kind of link is actually claiming about the NPI-to-device connection.
explain: A deterministic link is an observed, consented NPI-to-identifier pairing, while a probabilistic link is an inference that can be wrong. A high blended rate built mostly on inference can still serve to the wrong device, so you ask the vendor for the deterministic share, not just the headline total.
:::

# Deterministic versus probabilistic, and the quality signal

The headline match rate hides a composition question that decides whether the rate is trustworthy. Deterministic matching pairs an NPI to an identifier through an observed, consented event (a verified login, a registration), so the link is known. Probabilistic matching infers the link from signals like IP, device, and behavior, which scales reach but introduces error, because an inference can resolve to the doctor's spouse, a colleague on the same network, or the wrong person entirely. The quality signal you ask for is the deterministic share of the matched pool.

$$ \text{deterministic share} = \frac{\text{deterministically matched NPIs}}{\text{total matched NPIs}} $$

:::predict
prompt: Of 30,000 matched NPIs, 22,000 are matched deterministically and the rest probabilistically. What is the deterministic share of the matched pool?
answer: 73.3
tolerance: 0.5
unit: %
hint: Deterministically matched divided by total matched.
explain: 22,000 / 30,000 = 0.733, about 73.3 percent. The remaining 26.7 percent is inferred and carries more risk of misdelivery, which is why a 95 percent blended rate with a low deterministic share can be worse than a lower rate that is almost entirely deterministic.
:::

:::callout key
A match guarantee in the IO is only worth as much as your enforcement of it. Reconcile delivered matched impressions against the guaranteed floor every cycle and claw back make-goods when the vendor misses, rather than trusting the pitch deck number.
:::

# The six failure modes and the rebuild threshold

When match rate craters mid-flight, it is almost never random, and the operator's job is to name the cause from a known list rather than guess. The documented failure modes and their typical contribution: retired NPIs at 6 to 9 percent, hospital IP blocks at 5 to 8 percent, missing taxonomy at 4 to 7 percent, email-domain collisions at 3 to 6 percent, multi-state license conflicts at 3 to 5 percent, and group-versus-individual NPI mismatches at 2 to 4 percent. Each has a different fix, so diagnosing the source comes before re-trafficking.

The governing rule is a threshold: if total match-failure exceeds 20 percent, rebuild the identity graph before launching rather than spending into a broken bridge. This matters because programmatic HCP campaigns routinely waste 15 to 30 percent of spend when the NPI-to-device match breaks, and that waste is invisible in a CTR or CPM dashboard.

:::predict
prompt: An NPI audit finds retired NPIs at 7%, hospital IP blocks at 6%, missing taxonomy at 5%, and email-domain collisions at 4%. Does the total cross the 20% rebuild threshold, and by how much?
answer: 22
tolerance: 0.5
unit: %
hint: Sum the four failure-mode contributions, then compare to 20%.
explain: 7 + 6 + 5 + 4 = 22 percent total failure, which is 2 points over the 20 percent threshold. The rule says rebuild the identity graph before relaunching, because spending into a 22 percent broken match leaks budget you will never recover.
:::

:::callout warning
Operators on the AdOps subreddits describe "match rates that look great in the pitch and fall apart in delivery," forcing manual reconciliation against the Rx target list, and they complain vendors quote a blended match rate but will not break out deterministic versus probabilistic, which hides exactly where the waste lives. Treat any vendor that refuses to disclose the deterministic share as a red flag, and reconcile delivery against your own NPI list rather than the vendor's report.
:::

# Quantifying the wasted spend

The reason match rate is the core competency is that it converts directly into dollars left on the table. At any match rate below 100 percent, the portion of a line that lands on unmatched or mismatched delivery is roughly the spend times one minus the match rate, and that is your wasted-spend exposure.

$$ \text{wasted-spend exposure} \approx \text{spend} \times (1 - \text{match rate}) $$

This is also why the choice between a high-match endemic deal and a low-match open-web extension is an economic decision, not a preference. A cheaper open-web CPM can be the more expensive buy once you discount it by a 55 percent match rate against an endemic deal at 80 percent.

:::predict
prompt: At a 60% match rate on a $500,000 open-web line, roughly how much spend is exposed to unmatched or mismatched delivery?
answer: 200000
tolerance: 1000
unit: USD
hint: Multiply the spend by one minus the match rate.
explain: 500,000 times (1 minus 0.60) equals 500,000 times 0.40, which is 200,000 dollars exposed to unmatched or mismatched delivery. That 200,000 is the budget you are paying to address NPIs the graph cannot actually reach, before you even account for probabilistic misdelivery inside the matched 60 percent.
:::

:::quiz
question: Your on-premise hospital prescribers suddenly read as unmatched mid-flight. What is the most likely cause, and the right response?
- The NPIs all retired at once, so drop them from the list
- Hospital IP blocks are masking valid prescribers, so weight toward home and mobile IDs or accept lower in-facility match
- The DSP raised its match floor, so lower the IO guarantee
- Probabilistic matching was turned off, so there is nothing to fix
answer: 1
hint: Where do on-premise hospital doctors browse during the workday, and what does that network do to identifiers?
explain: On-premise prescribers browse on shared, firewalled hospital networks that suppress or rotate identifiers, so valid doctors look unmatched even though their NPIs are fine. The fix is to weight toward home and mobile IDs or accept a lower in-facility match, not to purge the NPIs as retired.
:::

:::sources
- DeepIntent, Healthcare Audiences / Provider (95%+ NPI match, ~7 identifiers, under 10s) | https://www.deepintent.com/solutions/healthcare-audiences/
- Improvado, HCP Targeting and Segmentation in Pharma: The 2026 Practitioner's Guide | https://improvado.io/blog/hcp-targeting-segmentation-pharma
- Doximity, About / Company (over 85% of U.S. doctors; 65% of NPs and PAs) | https://www.doximity.com/about/company
- PulsePoint, Curated Private Marketplaces / Endemic Markets (NPI-targetable endemic and EHR supply) | https://www.pulsepoint.com/blog/curated-private-marketplaces
- Veeva Crossix, Data and Methodology White Paper (SafeMine identity linkage, clean-room measurement) | https://www.veeva.com/wp-content/uploads/2023/08/Crossix-Data-and-Methodology-White-Paper.pdf
- Digiday, How programmatic firms deal with complex pharmaceutical laws (contextual targeting, programmatic-direct deals) | https://digiday.com/marketing/pharma-programmatic/
:::
