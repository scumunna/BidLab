---
id: vertical-b2b-06
track: vertical-b2b
module: 6
title: Inventory, Curation, and the Waste War
summary: Source brand-safe, on-target B2B inventory through curated PMP deals, defend the budget against MFA and invalid traffic, and reconcile DSP-to-SSP impression discrepancies so a matched account audience actually pays back in pipeline.
---
# Why open-exchange B2B is a trap

B2B is a tiny slice of programmatic, so the open exchange runs thin and dirty: once you layer firmographic, intent, and account-list filters onto raw open-market supply, what is left is a small pool padded with low-quality, ad-cluttered junk. The buy-side fix is to stop buying the open auction blind and instead route spend through private marketplace (PMP) and curated deals, where a curator has already assembled vetted B2B publishers and audience segments into a deal ID you bid on. The numbers tell the story: curated and PMP supply has surged toward roughly 88% of programmatic spend, and the ANA found about $26.8 billion in wasted programmatic spend in its Q2 2025 transparency benchmark. For the trader, inventory sourcing is not a procurement chore, it is the step that decides whether the Lesson 4 audience ever renders somewhere worth paying for.

:::quiz
question: Why does the B2B trader lean on PMP and curated deals instead of buying the open exchange directly?
- Open-exchange CPMs are always higher than PMP CPMs
- Open-exchange B2B supply is thin and padded with low-quality junk once account and intent filters are stacked
- PMP deals are the only inventory that supports frequency capping
- The open exchange does not allow firmographic targeting at all
answer: 1
hint: Think about what is left of open-market supply after you stack account list plus intent plus seniority filters.
explain: Open-exchange B2B is a small pool to begin with, and stacking firmographic, intent, and account-list filters shrinks it further while leaving ad-cluttered junk in the mix. Curated and PMP deals pre-assemble vetted B2B publishers and segments, which is why curated supply has climbed toward about 88% of programmatic spend. Open-market CPMs are actually lower than PMP, and the open exchange does support targeting, so the other options are wrong.
:::

# The PMP premium and what it buys

PMP inventory costs more per thousand than open-market: PMP CPMs run around $7.15 against roughly $4.41 on the open market. That premium is not a tax, it is the price of cleaner, more targetable, more brand-safe supply, so the right way to read it is per real, on-target impression rather than per gross impression. The premium itself is a simple calculation the trader should be able to do on sight, because finance will ask why you are paying up.

$$ \text{PMP premium} = \frac{\text{PMP CPM} - \text{open-market CPM}}{\text{open-market CPM}} $$

:::predict
prompt: PMP inventory clears at a $7.15 CPM and the open market clears at $4.41. What is the PMP premium over open-market (to one decimal)?
answer: 62.1
tolerance: 0.5
unit: %
hint: Subtract the open-market CPM from the PMP CPM, then divide by the open-market CPM.
explain: (7.15 - 4.41) / 4.41 = 2.74 / 4.41 = 0.621, about a 62.1% premium. The trader pays roughly 62% more per thousand, and the case for it is that far less of that spend leaks to MFA, invalid traffic, and off-target pages, so the cost per real on-target impression can actually be lower.
:::

:::callout key
The open-market CPM is a sticker price on raw inventory, not a cost per useful impression. Always normalize to cost per real, on-target, brand-safe impression before declaring open-exchange "cheaper," because a low CPM that lands 20% of spend on junk is not a bargain.
:::

# The first waste front: made-for-advertising sites

Made-for-advertising (MFA) sites are ad-cluttered clickbait pages built to harvest impressions, and roughly 15% of open-exchange display impressions still flow to them despite years of cleanup. For a B2B trader this is doubly corrosive: it drains attention and it pollutes account targeting, because a perfectly matched account impression that renders on an MFA page is wasted reach you still paid for. The defenses are concrete and live in the DSP and the deal setup: MFA blocklists, inclusion lists that name the publishers you will buy, and supply-path optimization (SPO) that cuts reseller hops to transparent sellers. The dispersion is wide, the ANA found the median marketer pushed MFA spend down toward about 0.8% while top-quartile marketers still spent up to about 28.7% on MFA domains, so this is a controllable problem, not an unavoidable tax.

:::figure supplyChain
caption: The path from DSP to rendered impression passes through SSPs and resellers. Each hop is a place where spend can leak to MFA inventory or vanish into opaque fees, which is why fewer hops and named inclusion lists matter to the buy-side trader.
:::

:::quiz
question: A trader confirms a target account matched and the impression served, but it rendered on a made-for-advertising clickbait page. What is the correct read?
- The impression counts as a win because the account matched
- The reach is wasted even though the account matched, because the placement was junk
- MFA only affects B2C campaigns, so it is irrelevant here
- The discrepancy threshold was exceeded
answer: 1
hint: Audience quality and supply quality are two separate gates that both have to pass.
explain: A match means the right account was reached, but if the placement is an MFA page the attention and brand-safety value is near zero, so the spend is wasted reach. Audience quality and supply quality are independent gates and both must hold. MFA absolutely affects B2B, and this scenario is about placement quality, not a discrepancy figure.
:::

# The second waste front: invalid traffic and the working-media math

Beyond MFA, invalid traffic (IVT) such as bots and non-human activity siphons off another slice of the buy, and the two together set how much of the budget is actually working. The trader models this directly so the waste shows up as inflated effective CAC rather than hiding inside a healthy-looking CPM.

$$ \text{working media} = \text{spend} \times (1 - \text{MFA}\% - \text{IVT}\% - \text{discrepancy loss}\%) $$

When 20% of a buy is lost to junk, every real impression has to carry the cost of the wasted 20% too, which is why waste inflates the effective cost of acquisition and quietly breaks the LTV:CAC math the role is measured on.

:::predict
prompt: You spend $100,000 and 15% goes to MFA while another 5% is invalid traffic, with no discrepancy loss. What is your working media reaching legitimate inventory?
answer: 80000
tolerance: 100
unit: USD
hint: Add the two waste percentages, subtract from 100%, then apply to spend.
explain: MFA 15% plus IVT 5% is 20% wasted, so working media is $100,000 x (1 - 0.20) = $100,000 x 0.80 = $80,000. The other $20,000 bought nothing useful.
:::

:::predict
prompt: Using that same buy, $20,000 was wasted and $80,000 was working. By what percent does the waste inflate your effective cost per real, working dollar of media?
answer: 25
tolerance: 0.5
unit: %
hint: Divide the wasted spend by the working spend, not by the total.
explain: $20,000 wasted / $80,000 working = 0.25, a 25% inflation. To buy a real dollar of working media you actually spent $1.25, so a CAC target computed on gross spend is understated by 25% and the LTV:CAC ratio you report to finance is wrong unless you net out the waste first.
:::

# Reconciling DSP-to-SSP discrepancies

The trader buys impressions in the DSP, but the SSP and publisher logs count them too, and the two numbers never agree perfectly. A gap up to about 10% is considered normal, driven by counting points, latency, and filtering, and anything well beyond that signals a tracking misconfiguration or fraud to investigate rather than accept. The calculation is the trader's daily reconciliation check.

$$ \text{impression discrepancy}\% = \frac{\text{DSP impressions} - \text{SSP impressions}}{\text{DSP impressions}} \times 100 $$

:::predict
prompt: Your DSP logs 1,200,000 impressions and the SSP logs 1,104,000 for the same line. What is the impression discrepancy percentage?
answer: 8
tolerance: 0.2
unit: %
hint: Subtract the SSP count from the DSP count, divide by the DSP count, then multiply by 100.
explain: (1,200,000 - 1,104,000) / 1,200,000 = 96,000 / 1,200,000 = 0.08, an 8% discrepancy. That sits inside the roughly 10% normal band, so it is routine variance to log, not an escalation.
:::

:::widget barChart
title: Where the budget leaks (open-exchange waste fronts)
labels: Working media, MFA share, IVT share
data: 80, 15, 5
unit: % of $100K buy
:::

# Grossing up the buy to hit a working-impression target

Because a known fraction of every open-market buy leaks, the trader cannot plan reach off gross impressions. To land a target number of real, working impressions against the account list, you gross the buy up by dividing by the working fraction, otherwise the campaign silently underpaces against the Lesson 5 reach-per-account plan.

$$ \text{gross impressions needed} = \frac{\text{target working impressions}}{1 - \text{waste}\%} $$

:::predict
prompt: You need 8,000,000 real working impressions against your target accounts, but 20% of any open-market buy is lost to MFA and IVT. How many gross impressions must you purchase?
answer: 10000000
tolerance: 1000
unit: impressions
hint: Divide the working target by the working fraction (1 minus the waste rate).
explain: 8,000,000 / (1 - 0.20) = 8,000,000 / 0.80 = 10,000,000 gross impressions. Planning to the 8,000,000 figure instead would deliver only 6,400,000 working impressions, under-reaching the committee and stalling the pipeline you committed to.
:::

# Curation is not a guarantee, vet the deal

A "curated" or "premium" label is a claim, not a control, and the trader must vet the actual deal rather than trust the wrapper. Curated deals can still surface MFA if the curator's inclusion list is loose, supply paths can still carry opaque reseller hops via sellers.json that inflate cost without adding value, and a clean account match still buys nothing if it renders on a junk page. The discipline is to confirm the publisher inclusion list, apply pre-bid brand-safety and IVT filters, and treat supply-path transparency as a lever on both cost and quality, then keep reconciling once the line is live.

:::quiz
question: A line item shows a DSP-to-SSP impression discrepancy of 25%. What is the right buy-side action?
- Ignore it, since all discrepancy is normal variance
- Immediately pause every campaign in the seat
- Investigate it as a tracking misconfiguration or fraud signal, because it is well beyond the roughly 10% normal band
- Switch the entire budget back to open-exchange to lower the gap
answer: 2
hint: Recall the threshold that separates routine variance from a problem worth escalating.
explain: A gap up to about 10% is routine and not worth escalating, but 25% is well beyond that band and signals a tracking misconfiguration or fraud to investigate. Ignoring it hides a real problem, pausing the whole seat over one line is an overreaction, and moving budget to open-exchange would raise MFA and IVT waste, not fix a counting discrepancy.
:::

:::callout warning
A recurring operator complaint on r/programmatic and r/PPC is that "premium" PMP deals still surface MFA and low-quality domains, and that opaque reseller hops inflate CPMs without adding value, while teams argue over whether a DSP-to-SSP discrepancy is acceptable or alarming. The takeaway from the field: never trust the "curated" label by itself. Pull the deal's inclusion list, check sellers.json for the seller path, run pre-bid IVT and brand-safety filters, and escalate a discrepancy only when it clears the roughly 10% normal band, so you neither waste ops time on routine variance nor ignore a 25% gap that hides fraud.
:::

:::sources
- ANA, Q2 2025 Programmatic Media Supply Chain Transparency Benchmark ($26.8B waste, MFA, curation) | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
- eMarketer, US B2B Digital Ad Spending 2026 | https://www.emarketer.com/content/b2b-digital-ad-spending
- Improvado, B2B Marketing Attribution in 2026 (supply quality, measurement) | https://improvado.io/blog/b2b-marketing-attribution
- Epom, How to reduce ad discrepancy (DSP vs SSP counting) | https://epom.com/blog/metrics/how-to-reduce-ad-discrepancy
- The Trade Desk, A Marketer's Guide to Testing Unified ID 2.0 (durable identity for curated supply) | https://www.thetradedesk.com/resources/marketers-guide-to-testing-unified-id-2-0
- Optifai, B2B Sales Cycle Length Benchmarks by Deal Size & Segment | https://optif.ai/learn/questions/sales-cycle-length-benchmark/
:::
