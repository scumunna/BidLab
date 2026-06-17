---
id: vertical-telecom-02
track: vertical-telecom
module: 2
title: The Buyer and the Mandate, Who Buys and the LTV:SAC North Star
summary: Identify who hands you a telecom brief, translate net subscriber growth into the LTV:SAC gate, compute SAC and CAC payback correctly, and avoid the ARPA-versus-ARPU trap that silently breaks per-subscriber economics.
---
# Who hands you the brief

The person who briefs a telecom programmatic trader is almost never a brand manager. It is a carrier's performance or growth-marketing team, or the agency trading desk that team retains, and their mandate is net subscriber growth: gross adds minus churn, won at a loaded cost the subscriber's lifetime value can cover. They do not care about clicks or click-through rate, because in a subscription business the only event that pays rent is a profitable gross add. Your job is to wire that business goal into campaign architecture, so the first thing to internalize is the single number the whole account is judged on.

That number is LTV:SAC, the telecom framing of LTV:CAC, where SAC is subscriber acquisition cost (often reported as cost-per-gross-add, or CPGA). Everything downstream, bid ceilings, pacing, footprint, identity, measurement, exists to keep that ratio healthy.

:::callout key
The signature KPI is LTV:SAC (lifetime value to subscriber acquisition cost). The trader's optimization target is therefore CPGA or SAC, never CPC or CTR. A campaign with a beautiful click-through rate that adds-churns prepaid lines at a loss has failed the only test that matters.
:::

:::quiz
question: A carrier's growth team hands you a brief. Which outcome are they actually paying you to produce?
- The lowest possible cost-per-click on the open exchange
- Profitable net subscriber growth measured against LTV:SAC
- The highest click-through rate across CTV and display
- The largest raw impression count inside the flight budget
answer: 1
hint: Telecom is a subscription business with ARPU, churn, and subsidies.
explain: The mandate is net subscriber growth (gross adds minus churn) at a loaded cost LTV can cover, judged by LTV:SAC. Clicks, CTR, and raw impressions are vanity metrics that can move while the unit economics quietly break.
:::

# What good looks like: the LTV:SAC gate

A healthy telecom LTV:SAC is at least 3:1, and many subscription operators target 4:1 to 5:1; a CAC payback under twelve months is the companion gate, with six months considered excellent. LTV:SAC of exactly 1:1 means you spend a dollar of lifetime value to acquire a dollar of lifetime value, which funds nothing and ignores operating cost. So when you set a bid ceiling or read a campaign, you are really asking one question: does the lifetime value of the subscribers this media wins clear roughly three times the loaded cost to win them?

The ratio itself is simple division: net lifetime value per subscriber divided by SAC. The discipline is making sure both inputs are the right unit, which is where most telecom mistakes live.

$$ \text{LTV:SAC} = \frac{\text{Net LTV per subscriber}}{\text{SAC}} $$

:::predict
prompt: A postpaid subscriber has a Net LTV of $1,600 and the loaded SAC is $400. What is the LTV:SAC ratio?
answer: 4
tolerance: 0.05
unit: ratio (x to 1)
hint: Divide Net LTV by SAC.
explain: 1,600 / 400 = 4.0, so LTV:SAC is 4:1. That clears the 3:1 gate comfortably and sits in the 4:1 to 5:1 band strong subscription businesses aim for.
:::

:::quiz
question: An acquisition campaign returns an LTV:SAC of 1.2:1. How should the trader read it?
- Excellent, anything above 1:1 is profitable
- Marginal and below the 3:1 gate, the unit economics do not clear
- Irrelevant, because LTV:SAC does not apply to programmatic media
- Healthy, because payback is automatically under twelve months
answer: 1
hint: Compare it to the 3:1 benchmark, not to 1:1.
explain: 1.2:1 is far under the 3:1 telecom gate. Above 1:1 only means lifetime value exceeds acquisition cost before operating expense; it leaves nothing for the rest of the business, so the campaign needs a lower SAC or a higher-LTV audience.
:::

# Building SAC the right way: load everything

SAC is not media cost. By definition it loads sales and marketing spend plus handset subsidies plus dealer and channel commissions, all divided by gross adds. A media-only CAC understates the true cost of acquisition and will pass an LTV:SAC gate that the loaded number fails, which is how a trader "wins" cheap impressions and still loses money on every line activated. Industry CPGA for a wireless phone customer runs roughly $350 to $400 across carriers, and that figure already includes the subsidy and commission layers, not just working media.

The handset subsidy is the telecom-specific twist: a postpaid phone deal often ships a discounted or installment device, and that subsidy is a real acquisition cost even though it never touches your DSP. Leave it out and your bid ceiling is built on a fiction.

$$ \text{SAC (CPGA)} = \frac{\text{Sales and marketing} + \text{handset subsidy} + \text{commissions}}{\text{Gross adds}} $$

:::predict
prompt: A quarter's loaded acquisition costs are $200M in sales and marketing, $120M in handset subsidies, and $40M in dealer commissions, producing 1,000,000 gross adds. What is the SAC (CPGA)?
answer: 360
tolerance: 1
unit: USD
hint: Add the three cost components, then divide by gross adds.
explain: (200,000,000 + 120,000,000 + 40,000,000) / 1,000,000 = 360,000,000 / 1,000,000 = $360 per gross add, right inside the $350 to $400 industry band. A media-only view would have shown $200, understating true SAC by $160 and breaking the LTV:SAC gate.
:::

:::widget barChart
title: What loads into SAC (illustrative $360 CPGA build)
labels: Sales and Marketing, Handset Subsidy, Dealer Commissions
data: 200, 120, 40
unit: USD per gross add (millions of cost over 1M adds)
:::

# CAC payback: how fast the subscriber repays the cost

The companion gate to the ratio is time: how many months of margin it takes to earn the SAC back. CAC payback is SAC divided by the monthly gross-margin contribution per subscriber, which is per-line revenue times gross margin. Under twelve months is the bar; six is excellent. A long payback is dangerous in telecom because a subscriber who churns before repaying SAC is a net loss no matter how good the headline LTV:SAC looked, since LTV assumes the subscriber stays long enough to realize it.

This is why payback and the ratio are read together. A 4:1 LTV:SAC with a thirty-month payback can still bleed cash if churn arrives early; a 3:1 ratio that repays in five months is far safer.

$$ \text{CAC payback (months)} = \frac{\text{SAC}}{\text{per-line ARPU} \times \text{gross margin}} $$

:::predict
prompt: SAC is $400. Per-line monthly revenue is $56 at a 75% gross margin. What is the CAC-payback period, rounded to the nearest whole month?
answer: 10
tolerance: 0.5
unit: months
hint: Compute monthly margin per line first, then divide SAC by it.
explain: Monthly margin is 56 x 0.75 = $42. Payback is 400 / 42 = 9.52, which rounds to 10 months. That clears the under-twelve-month gate, though it is well short of the six-month "excellent" mark.
:::

:::figure subscriptionLtv
caption: Subscriber LTV builds month over month as retained ARPU margin accumulates, while SAC is paid up front. CAC payback is the month the cumulative margin curve crosses the SAC line; everything after that is profit, and early churn cuts the curve short before it gets there.
:::

# The ARPA-versus-ARPU trap

Here is the classic telecom mistake that silently breaks every LTV:SAC gate downstream. Carriers report ARPA, average revenue per account, but an account holds multiple lines, so ARPA is not what you feed a per-subscriber LTV. Verizon Consumer reported postpaid ARPA of $147.91 in Q3 2025; that is per account, not per line. Per-line postpaid phone ARPU across AT&T, T-Mobile, and Verizon was about $56.37 in early 2026 (roughly $52.76 on core connectivity once perks are stripped out), and prepaid ARPU was about $32.70 per line. Putting account-level ARPA head-to-head with prepaid ARPU as if they were the same unit, or feeding ARPA into a per-subscriber LTV, inflates lifetime value about 2.6x and corrupts the gate.

The rule is mechanical: ARPA equals total account revenue divided by accounts; ARPU equals total revenue divided by lines. LTV is built per subscriber, so LTV uses ARPU, never ARPA.

$$ \text{ARPA} = \frac{\text{Total account revenue}}{\text{Accounts}} \neq \text{ARPU} = \frac{\text{Total revenue}}{\text{Lines}} $$

:::predict
prompt: A trader mistakenly builds per-subscriber LTV on account-level ARPA of $148 instead of per-line ARPU of $56. By what factor does that overstate the per-subscriber revenue input? Round to one decimal.
answer: 2.6
tolerance: 0.1
unit: x (factor)
hint: Divide the wrong input by the right input.
explain: 148 / 56 = 2.64, about 2.6x. Every per-subscriber LTV built on ARPA is inflated ~2.6x, so an LTV:SAC that looks like a healthy 4:1 might really be roughly 1.5:1, failing the 3:1 gate the whole campaign exists to satisfy.
:::

:::widget barChart
title: Revenue units that are not interchangeable (USD per month)
labels: Postpaid ARPA per Account, Postpaid ARPU per Line, Core-Connectivity ARPU per Line, Prepaid ARPU per Line
data: 147.91, 56.37, 52.76, 32.70
unit: USD per month
:::

:::callout warning
Reddit AdOps pain point: practitioners vent that clients hand over a flat CPA or CPL target with no LTV context, which pushes the algorithm toward cheap, low-intent leads that convert poorly and churn fast, when the real mandate is high-ARPU postpaid gross adds. Worse, leadership often conflates a falling CPA with success even as the acquired base skews to credit-thin prepaid and high-churn segments, so "efficient" media quietly destroys LTV:SAC. Optimizing to CPC or CPL adverse-selects toward prepaid churners (ARPU ~$33) when the brief wanted postpaid (ARPU ~$56). The cheap lead is the expensive mistake.
:::

# Churn, lifetime, and the three sub-businesses

LTV depends on how long a subscriber stays, and lifetime is the inverse of monthly churn. Postpaid phone churn late in 2025 ran roughly 1.02% at T-Mobile (0.93% full-year), 0.98% at AT&T, and 0.95% at Verizon, all close to 1.0% monthly, so a 1.0% monthly churn implies an expected lifetime near 100 months. Small churn differences swing LTV hard: dropping monthly churn from 1.1% to 0.9% lifts expected lifetime from about 91 months to about 111 months, a roughly 22% longer revenue tail on the same ARPU. That is why retention sits right next to acquisition in the mandate.

The three telecom sub-businesses do not share one CAC target. Postpaid wireless is high revenue and low churn but carries handset subsidies that inflate SAC. Prepaid is lower ARPU and higher churn. Broadband and fixed wireless access (FWA) are sticky and act as a bundling lever. One blanket CAC number cannot govern all three, so you set the gate per line of business.

$$ \text{Expected lifetime (months)} = \frac{1}{\text{monthly churn rate}} $$

:::predict
prompt: A postpaid line has a monthly churn rate of 1.0%. What is the expected customer lifetime in months?
answer: 100
tolerance: 1
unit: months
hint: Lifetime is one divided by the monthly churn rate.
explain: 1 / 0.01 = 100 months (about 8.3 years). At 0.9% churn the lifetime stretches to ~111 months, and at 1.1% it compresses to ~91 months, which is why a fraction of a churn point materially moves LTV.
:::

:::quiz
question: Why can a single CAC target not govern a carrier's whole account?
- Because all three sub-businesses have identical ARPU and churn
- Because postpaid, prepaid, and FWA differ sharply in ARPU, churn, and subsidy load
- Because CAC does not vary by product in subscription businesses
- Because only postpaid has a measurable acquisition cost
answer: 1
hint: Think about subsidies, ARPU levels, and churn across the lines of business.
explain: Postpaid is high-ARPU, low-churn, subsidy-heavy; prepaid is low-ARPU and high-churn; FWA and broadband are sticky bundling levers. Their allowable SAC differs, so each line of business needs its own gate rather than one account-wide CAC number.
:::

:::sources
- Umbrex, LTV to CAC Ratio Benchmarks for Subscription Businesses | https://umbrex.com/resources/financial-modeling/customer-metrics/ltv-cac-ratio/
- First Page Sage, Average Customer Acquisition Cost (CAC) by Industry 2025 | https://firstpagesage.com/seo-blog/average-customer-acquisition-cost-cac-by-industry/
- TelecomLead, Verizon Q3 2025 results and postpaid ARPA | https://www.telecomlead.com/telecom-statistics/verizon-q3-2025-results
- Recon Analytics, US wireless ARPU by carrier 2026 | https://www.reconanalytics.com/
- ainvest, US wireless postpaid churn benchmarks 2025 | https://www.ainvest.com/news/
- SuperMoney, Cost Per Gross Addition (CPGA) explained | https://www.supermoney.com/encyclopedia/cost-per-gross-addition
- Investopedia, Cost Per Gross Addition (CPGA) | https://www.investopedia.com/terms/c/cpga.asp
:::
