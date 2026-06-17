---
id: vertical-finance-02
track: vertical-finance
module: 2
title: The Buyer and the Mandate: Cost per Funded Account
summary: Identify who the finance trader serves, why the job is judged on cost per funded account rather than cost per signup, and how to reconstruct the fully-loaded cost behind a flattering reported CAC.
---
# Who you actually work for

Your buyer in this vertical is the growth, performance-marketing, or acquisition team at a money product: a neobank (Chime, SoFi, Dave), a lender (mortgage, personal loans, BNPL), a card issuer, a payments app, a robo or wealth platform, or an insurer. They are not buying awareness, and they are not impressed by impressions. They are buying customers who open an account and then actually fund it, deposit, transact, take the loan, bind the policy, because only those customers generate the interchange, net interest margin, fees, and premiums that pay the business back.

That is the whole reason this vertical has its own KPI. In most verticals a trader can survive on cost per click or cost per lead. In finance a lead is almost worthless on its own, because the gap between "someone clicked an account-opening ad" and "someone became a paying customer" is enormous and leaky. The buyer's mandate to you is narrow and unforgiving: bring funded customers at or below a cost the unit economics can bear.

:::callout key
The finance buyer is a growth or acquisition lead at a regulated money product, and their definition of success is a funded account, not a click, a signup, or a lead. Internalize that the funded customer is the only unit that matters before you set up a single line item.
:::

:::quiz
question: You are pitching a neobank's acquisition lead and lead with "we delivered 4 million impressions and a strong click-through rate." Why does this land flat with a finance buyer?
- Impressions and clicks are vanity metrics here; the buyer is paying for customers who open and then fund an account
- Finance buyers are forbidden by regulation from reviewing impression data
- Click-through rate is never measurable on regulated money products
- Neobanks only buy on a cost-per-impression basis, so CTR is irrelevant to billing
answer: 0
hint: Think about which event actually generates interchange, net interest margin, and fees.
explain: The finance buyer is a growth or acquisition lead whose revenue comes from interchange, net interest margin, fees, and premiums, all of which require a customer to open AND fund. Impressions and clicks sit far above that event, so they do not prove you delivered the only unit that pays the business back. The rule is about what the buyer values, not a regulatory ban or a billing model.
:::

# The signature KPI: cost per funded account

Cost per funded account, CPFA, is the number you live and die by. It is total media spend divided by the count of accounts that opened AND funded, meaning deposited, transacted, drew the loan, or paid the first premium. Defining the denominator at the funded event, rather than at signup, is deliberate: it pushes the metric past the tire-kickers and bonus-chasers who inflate signup counts but never become customers.

$$ \text{CPFA} = \frac{\text{total media spend}}{\text{funded accounts}} $$

Read that formula like a buy-side trader, not an analyst. Every dollar of spend that does not end in a funded account is dragging the numerator up, and every signup that stalls before funding is keeping the denominator small. Both forces push CPFA the wrong way, which is exactly why optimizing to a shallow event feels efficient and quietly fails.

:::predict
prompt: A finance acquisition campaign spends $90,000 and produces 600 funded accounts. What is the cost per funded account?
answer: 150
tolerance: 1
unit: USD
hint: Divide media spend by the number of funded accounts.
explain: 90,000 / 600 = 150. The campaign paid $150 in media for each customer who actually funded, which is the only denominator finance cares about.
:::

:::figure funnel
caption: Spend enters at the top as impressions, but CPFA is measured only at the bottom, where a customer opens and funds. Everything between is leakage that raises the effective cost of each funded account.
:::

# Why not cost per signup or cost per lead

It is tempting to optimize the DSP to the event that fires often and early, application complete or signup, because the data is dense and the dashboards look great. That is the classic finance trap. A bonus-chaser cohort can produce thousands of cheap signups, claim the deposit bonus, withdraw, and churn, leaving you with a beautiful cost per signup and almost no funded accounts. The funded-account rate, funded divided by signups, is what exposes that gap.

$$ \text{funded-account rate} = \frac{\text{funded accounts}}{\text{total signups}} $$

The discipline is to optimize to the deepest reliable event you can feed back to the bidder, even though funded events are sparse and slow to fire (KYC and first deposit can take hours or days). A trader who reports a cheap signup CPA up the chain while product complains the cohorts never fund is on the losing side of a recurring fintech fight.

:::predict
prompt: A campaign drives 10,000 signups but only 3,200 of them fund their account. What is the funded-account rate?
answer: 32
tolerance: 0.5
unit: %
hint: Divide funded accounts by total signups.
explain: 3,200 / 10,000 = 0.32, a 32 percent funded-account rate. The other 68 percent signed up but never became customers, which is invisible if you optimize to signups alone.
:::

:::quiz
question: Why does the finance vertical optimize to cost per funded account instead of cost per signup?
- Funded events fire more frequently and are cheaper to track
- Signups include bonus-chasers and KYC failures that never become paying customers
- Regulators require funded-account reporting under FCRA
- Signup data is unavailable in most DSPs
answer: 1
hint: Think about what a cheap signup cohort can hide.
explain: Signups are padded with tire-kickers and bonus-chasers who never fund, so a cheap cost per signup can mask a campaign that produces almost no real customers. Funded is the event that filters them out. It is not about frequency, and FCRA governs targeting, not KPI choice.
:::

# Reported CAC versus fully-loaded CAC

When a stakeholder quotes you a CAC, ask what is inside it. Reported CAC is usually media spend divided by new customers, and it is almost always understated because it omits the costs that ride along with every acquisition. Fully-loaded CAC adds KYC and identity verification, sign-up bonuses, card issuance, and onboarding drop-off, and it is the number finance will eventually reconcile against you.

$$ \text{fully-loaded CAC} = \frac{\text{media} + \text{bonuses} + \text{KYC/onboarding} + \text{issuance}}{\text{new funded customers}} $$

Industry teardowns show the gap is large: a neobank reporting a $50 CAC is often spending $85 to $105 once KYC ($20 to $30), the sign-up bonus ($10 to $15), and card issuance ($5 to $10) are loaded in. KYC alone can add $20 to $30 per customer. If you report media-only CAC up the chain and stay quiet about the rest, you will be blamed later when the fully-loaded math surfaces.

:::predict
prompt: A neobank reports a $50 CAC, but fully-loaded cost adds $25 for KYC, $12 for the sign-up bonus, and $8 for card issuance. What is the fully-loaded CAC?
answer: 95
tolerance: 1
unit: USD
hint: Add the loaded costs to the reported media CAC.
explain: 50 + 25 + 12 + 8 = 95. The real cost to acquire a funded customer is $95, nearly double the $50 the dashboard reports, which is why you always ask what is inside a quoted CAC.
:::

:::quiz
question: A reported $50 neobank CAC understates the true cost. Which set of costs is typically missing from it?
- Server hosting, app store fees, and SDK licensing
- KYC verification, sign-up bonuses, and card issuance
- DSP seat fees, data costs, and agency commission
- Brand-safety tooling, viewability vendors, and ad-server fees
answer: 1
hint: Think about what it costs to onboard a funded customer, not what it costs to run the media.
explain: Fully-loaded CAC adds the per-customer onboarding costs the media number ignores: KYC, the deposit bonus, and card issuance, which together push a $50 reported CAC to roughly $85 to $105. The other options are media or ad-tech line items, not onboarding costs.
:::

# What good looks like

"Good" is anchored to product economics, not to a vanity benchmark. Marketwide target CAC for a new checking account runs around $175, and consumer fintech CAC by product sits roughly at Banking $258, Lending $175, Investing and Trading $166, and Crypto $188. These are useful goalposts, but the right ceiling for any specific advertiser comes from its own LTV and allowable CAC, which the next lesson builds in full.

:::widget barChart
title: Consumer fintech CAC by product (USD)
labels: Banking, Lending, Investing, Crypto, Checking target
data: 258, 175, 166, 188, 175
unit: USD
:::

Two cautions keep you honest about benchmarks. Best-in-class outliers like Dave's reported roughly $19 CAC are usually driven by referral or viral loops, not paid media, so you cannot set a paid target off a blended outlier. And paid-channel CAC rose 40 to 60 percent between 2023 and 2025 as keyword competition and privacy changes bit, so last year's "good" number may already be unaffordable this year.

:::predict
prompt: A campaign spends $360,000 and produces 1,800 funded accounts. What is the CPFA, and does it clear a $258 banking benchmark?
answer: 200
tolerance: 1
unit: USD
hint: Divide spend by funded accounts, then compare to 258.
explain: 360,000 / 1,800 = 200. At $200 CPFA the campaign is below the $258 banking benchmark, so it clears that goalpost, though the binding test is the advertiser's own LTV-derived ceiling, not the benchmark.
:::

# Why a cheap CAC can still lose money

A low CAC is not the same as a profitable one. Annual churn in digital banking runs around 19 percent, and consumer fintech often sits in the high teens to mid-twenties, so a customer acquired cheaply who leaves inside a year may never repay even a modest acquisition cost. This is why the mandate is CPFA against an LTV-derived ceiling, not CPFA in the abstract: the ceiling encodes how much lifetime value each funded customer is actually worth, and lifetime value collapses when the cohort churns before it pays back.

:::predict
prompt: A funded customer is acquired at a fully-loaded $95 CAC and contributes $7 in net margin per month. Ignoring discounting, how many months must the customer stay before the acquisition cost is repaid (round up to a whole month)?
answer: 14
tolerance: 0
unit: months
hint: Divide the loaded acquisition cost by the monthly contribution, then round up to a whole month.
explain: 95 / 7 = 13.57 months, which rounds up to 14 months to break even. With annual churn near 19 percent and often higher in fintech, a meaningful share of the cohort leaves before month 14 and never repays the $95, which is exactly why a cheap CAC can still lose money and why the LTV-derived ceiling (a healthy 3-to-1 LTV-to-CAC), not CAC alone, governs the buy.
:::

:::callout warning
A recurring operator complaint: leadership benchmarks the trader on signup CPA while product reports that the cohorts never fund, and meanwhile "bonus-chaser" cohorts open an account, claim the deposit bonus, withdraw, and churn, torching LTV-to-CAC while topline signups look healthy. If your reporting stops at signups, you are measuring the exact behavior the funded-account KPI exists to filter out.
:::

The closing discipline for this lesson: every number you report should be defensible at the funded event and honest about loaded cost. Reported CAC is a starting point, fully-loaded CAC is the truth finance reconciles to, and CPFA against the LTV-derived ceiling (built in Lesson 4) is the standard you are actually held to.

:::sources
- First Page Sage, Fintech CAC Benchmarks Report (Banking $258, Lending $175, Investing $166, Crypto $188) | https://firstpagesage.com/seo-blog/fintech-cac-benchmarks-report/
- GonzoBanker, The Real Cost of Acquiring a Banking Customer | https://gonzobanker.com/2025/03/the-real-cost-of-acquiring-a-banking-customer/
- eightx, LTV:CAC Ratio: Why 3:1 Matters and CAC Payback Benchmarks | https://eightx.co/blog/ltv-cac-ratio-guide
- Shno, Customer Churn Statistics: 19% Annual Banking Churn and Fintech Benchmarks | https://www.shno.co/marketing-statistics/customer-churn-statistics
- Veridas, KYC Funnel Loss and Customer Drop-off | https://veridas.com/en/kyc-funnel-loss-customer-drop-off/
- Pushwoosh, Fintech App Retention and Engagement Benchmarks | https://www.pushwoosh.com/blog/fintech-app-retention/
- Data Axle, Meta Special Ad Categories Rules for Financial Services | https://www.data-axle.com/resources/blog/meta-special-ad-categories-rules/
:::
