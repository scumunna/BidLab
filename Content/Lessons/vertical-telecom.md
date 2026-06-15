---
id: vertical-telecom
track: telecom
module: 1
title: Telecom: you are buying a subscription, not a sale
summary: How CPGA, ARPU, churn, CLV, LTV:CAC, and payback turn handset subsidies into a retention math problem.
---
# Telecom acquisition is subscription math

Telecom does not buy one-off sales. It buys subscriptions that pay month after month, so the unit economics are acquisition cost against customer lifetime value, not CPA against AOV. A handset subsidy and a dealer commission get folded into the cost of landing a subscriber, which is unusual, and churn, the rate at which subscribers leave, dominates everything downstream.

The category is hot. Telecom led all US industries in digital ad growth in 2025 at about +16.3% (versus +11.5% for total ad spend), outspending auto in digital for the first time since 2016, with social ad spend up about 20.5% (Inside Radio). Telecom B2B digital spend alone tops $2B in 2026. The growth and ranking facts are the anchors here.

:::predict
prompt: A subscriber pays $50 per month and stays for 60 months. What is the total revenue that one subscription delivers over its life?
answer: 3000
unit: $
tolerance: 10
hint: Multiply the monthly payment by the number of months the subscriber stays.
explain: Lifetime revenue = $50 x 60 = $3,000. Because a subscription pays month after month, telecom can spend hundreds of dollars to land one subscriber, which is exactly why the math is acquisition cost against lifetime value, not CPA against AOV.
:::

# CPGA: cost per gross add

The acquisition metric is CPGA, cost per gross add, the telecom name for SAC or CAC. It nets equipment costs and sales and marketing against equipment revenue, divided by gross new subscribers.

$$ CPGA = \frac{Equipment\ costs + Sales\ \&\ Marketing - Equipment\ revenue}{Gross\ new\ subscribers} $$

A handset subsidy is a big part of that numerator. Offer a $400 phone subsidy plus dealer commission plus a media push, and CPGA climbs fast, often into the $350 to $420 range. The question is always whether the lifetime value of that subscriber clears the acquisition cost by a healthy margin.

:::predict
prompt: A carrier spends $4,200,000 on equipment, marketing, and commissions net of equipment revenue, and lands 10,000 gross new subscribers. What is CPGA?
answer: 420
unit: $
hint: Divide total net acquisition cost by gross new subscribers.
explain: CPGA = $4,200,000 / 10,000 = $420 per gross add.
:::

# ARPU and churn drive lifetime

Two numbers set lifetime value. ARPU, average revenue per user, is monthly service revenue per subscriber. Monthly churn is the share of subscribers lost each month, and its inverse is average lifetime in months.

$$ Average\ lifetime\ (months) = \frac{1}{churn} $$

T-Mobile is the primary-source anchor: postpaid phone churn of about 0.90% in 2025 and postpaid phone ARPU of about $50.62 (T-Mobile SEC filings). A subscriber churning at 0.90% per month has an expected lifetime of 1 / 0.009, about 111 months. A weaker carrier churning at 1.4% per month keeps subscribers only 1 / 0.014, about 71 months, a huge difference in lifetime from a 0.5 point gap.

:::predict
prompt: A carrier has a monthly churn rate of 1.4%. What is the average subscriber lifetime in months?
answer: 71.4
tolerance: 1
hint: Average lifetime is 1 divided by the monthly churn rate.
explain: Average lifetime = 1 / 0.014 = about 71.4 months.
:::

# CLV, LTV:CAC, and payback

Put ARPU, margin, and churn together and you get customer lifetime value: monthly margin times expected lifetime.

$$ CLV = ARPU \times GM\% \times \frac{1}{churn} $$

Take ARPU $50, gross margin 55%, monthly churn 1.4%. CLV = $50 x 0.55 x (1 / 0.014) = $27.50 x 71.4 = about $1,964. Set that against a CPGA of $420 and the ratio LTV:CAC is about 4.7:1, comfortably above the 3:1 health bar. Payback in months is CPGA divided by monthly margin: $420 / ($50 x 0.55) = $420 / $27.50 = about 15.3 months.

$$ LTV\!:\!CAC = \frac{CLV}{CPGA} \qquad Payback = \frac{CPGA}{ARPU \times GM\%} $$

:::callout insight
A 0.5 point change in monthly churn moves CLV more than almost any media lever. Cutting churn from 1.4% to 0.9% raises lifetime from about 71 to about 111 months and lifts CLV by more than half, all without spending another dollar on acquisition. In telecom, the retention budget is an acquisition decision.
:::

:::predict
prompt: A carrier has ARPU of $50, a 55% gross margin, and 1.4% monthly churn. What is the customer lifetime value?
answer: 1964
unit: $
tolerance: 10
hint: CLV is ARPU times margin times one over churn.
explain: CLV = $50 x 0.55 x (1 / 0.014) = $27.50 x 71.4 = about $1,964.
:::

:::predict
prompt: With a CPGA of $420, ARPU of $50, and a 55% gross margin, how many months until acquisition cost is paid back?
answer: 15.3
unit: x
tolerance: 0.3
hint: Payback is CPGA divided by monthly gross margin, which is ARPU times margin.
explain: Payback = $420 / ($50 x 0.55) = $420 / $27.50 = about 15.3 months.
:::

# The regulation that almost happened

Telecom leans on SMS and outbound calling, so TCPA governs telemarketing, and the National Do Not Call Registry now explicitly covers texts to wireless. There was nearly a much stricter regime. The FCC adopted a "one-to-one consent" rule in December 2023, but the 11th Circuit vacated it in January 2025, and the FCC formally eliminated it in September 2025. The tighter rule never took effect, a useful lesson in pricing regulatory risk you do not yet have to comply with.

:::quiz
question: A regional carrier wants to improve its LTV:CAC ratio from a near break-even position. Which lever most powerfully raises customer lifetime value without spending more on media?
- Reducing monthly churn, because lifetime is one over churn and small churn cuts compound
- Raising the handset subsidy to win more gross adds
- Increasing the dealer commission per activation
- Shifting all spend to national brand campaigns
hint: Look at which input sits in the denominator of the lifetime formula.
answer: 0
explain: Lifetime is 1 / churn, so cutting churn compounds directly into CLV. Subsidies and commissions raise CPGA, which lowers the ratio.
:::

:::sources
- T-Mobile US Q2 2025 SEC Filing, EDGAR | https://www.sec.gov/Archives/edgar/data/0001283699/000128369925000116/
- Telecom and Financial Services Lead US Ad Spending Growth 2025, Inside Radio | https://www.insideradio.com/free/telecom-financial-services-lead-u-s-ad-spending-growth-in-2025/
- FCC One-to-One Consent Rule, Federal Communications Commission | https://www.fcc.gov/
:::
