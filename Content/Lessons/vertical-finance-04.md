---
id: vertical-finance-04
track: vertical-finance
module: 4
title: Building the Ceiling, LTV, Allowable CAC and the CPFA Cap
summary: Derive the maximum cost per funded account the business can pay, from LTV and payback, and translate it into the bid every line item must respect.
---
# The one number every bid respects

Every bid strategy, pacing rule, and deal floor you set in a finance account answers to a single ceiling: the maximum cost per funded account (CPFA) the business can afford. Lesson 2 named CPFA as the signature KPI; this lesson teaches you to compute the cap it must stay under. Get this wrong and you either overspend into unprofitable cohorts or bid so timidly you starve the funded volume the business needs. The ceiling is not handed to you by finance as a clean target; you build it from lifetime value, a required return ratio, and the loaded costs that sit between media and a funded customer.

The chain is short and you will run it constantly: LTV gives you allowable CAC, allowable CAC minus non-media loaded cost gives you the media-only CPFA ceiling, and that ceiling times your funded-per-impression rate gives you a max CPM. Each link is one division or one subtraction, and each is somewhere a rookie inflates the number and blows the budget.

:::figure costPerFundedCascade
caption: The ceiling cascade. LTV sets allowable CAC at the required ratio, loaded non-media costs are subtracted to get the media-only CPFA cap, and the cap converts to a max CPM through the funded-per-impression rate.
:::

# LTV is margin times lifetime, never revenue

For a money product, lifetime value is annual revenue per account (ARPA: interchange plus net interest margin plus fees plus any subscription) multiplied by the gross margin, multiplied by the average customer lifetime. Lifetime is the reciprocal of annual churn, so a 20 percent annual churn rate implies a five-year average lifetime. The formula is compact:

$$ \text{LTV} = \text{ARPA} \times \text{gross margin} \times \frac{1}{\text{annual churn}} $$

The trap, and the most common way a finance LTV gets inflated, is using gross revenue in place of gross margin. A neobank earning 120 dollars of ARPA at a 50 percent margin and 20 percent churn has an LTV of $120 \times 0.5 \times 5 = 300$ dollars, not the 600 you would get by skipping the margin term. Build the ceiling off the inflated number and you will authorize bids the unit economics cannot pay back.

:::predict
prompt: An account earns $120 ARPA at a 50% gross margin, with 20% annual churn (so a 5-year lifetime). What is the LTV, in dollars?
answer: 300
tolerance: 1
unit: $
hint: LTV = ARPA x margin x (1 / churn). Lifetime is 1 / 0.20 = 5 years.
explain: Lifetime = 1 / 0.20 = 5 years. LTV = 120 x 0.50 x 5 = 300. Skipping the margin term would wrongly give 120 x 5 = 600, double the real value.
:::

:::callout key
Always use gross margin, never gross revenue, in the LTV formula. Revenue-based LTV is the single fastest way to set a CPFA ceiling the business cannot actually afford, and it is invisible until finance reconciles real contribution months later.
:::

# From LTV to allowable CAC at 3 to 1

Allowable CAC comes from the return the business demands on each acquired customer, expressed as an LTV to CAC ratio. The long-standing default is 3 to 1, meaning lifetime value should be at least three times what you paid to acquire, so allowable CAC is LTV divided by the target ratio. Many finance operators target richer ratios (4 to 1 up to 7 to 1) when capital is tight or churn is uncertain, which lowers allowable CAC and tightens every bid.

$$ \text{allowable CAC} = \frac{\text{LTV}}{\text{target LTV:CAC ratio}} $$

At a 3 to 1 ratio, an LTV of 600 dollars permits an allowable CAC of 200 dollars. Push the requirement to 4 to 1 and the same LTV permits only 150. The ratio is a lever leadership controls, so know which one your business uses before you defend a bid.

:::predict
prompt: A funded account has an LTV of $600 and the business requires a 3:1 LTV:CAC ratio. What is the allowable CAC, in dollars?
answer: 200
tolerance: 1
unit: $
hint: Allowable CAC = LTV / target ratio.
explain: 600 / 3 = 200. If the business tightened the requirement to 4:1, allowable CAC would fall to 600 / 4 = 150, shrinking your headroom to bid.
:::

:::quiz
question: A team raises its required LTV:CAC ratio from 3:1 to 5:1 while LTV stays at $500. What happens to allowable CAC?
- It rises from $100 to $167
- It falls from $167 to $100
- It stays at $167 because LTV is unchanged
- It rises from $100 to $250
answer: 1
hint: Allowable CAC is LTV divided by the ratio, so a bigger ratio means a smaller quotient.
explain: At 3:1 allowable CAC is 500 / 3 = 167; at 5:1 it is 500 / 5 = 100. A stricter ratio lowers allowable CAC, so the same LTV now justifies less spend per funded account.
:::

# The media-only CPFA ceiling

You are paid on funded accounts, but allowable CAC covers the whole cost of acquiring one, not just media. Lesson 2 loaded the hidden costs onto a reported neobank CAC: KYC at 20 to 30 dollars, sign-up bonuses at 10 to 15, card issuance at 5 to 10, plus onboarding drop-off. Those non-media costs must be subtracted from allowable CAC before you have a number a bid can chase, because the DSP only spends the media portion.

$$ \text{CPFA ceiling}_{\text{media}} = \text{allowable CAC} - \text{loaded non-media cost} $$

With allowable CAC at 200 dollars and 50 dollars of loaded non-media cost, the media-only CPFA ceiling is 150. That 150, not the 200, is what feeds your bid math. A trader who bids to allowable CAC forgets that 50 dollars per funded account is already spoken for and quietly runs the blended cost over the limit.

:::predict
prompt: Allowable CAC is $200 and loaded non-media cost (KYC + bonus + card issuance) totals $50. What is the media-only CPFA ceiling, in dollars?
answer: 150
tolerance: 1
unit: $
hint: Subtract the non-media loaded cost from allowable CAC.
explain: 200 - 50 = 150. The DSP only spends media, so 150 is the ceiling your bids chase; the other 50 is consumed by KYC, bonus, and issuance regardless of how cheaply you buy.
:::

:::widget barChart
title: Building the media-only CPFA ceiling from allowable CAC
labels: Allowable CAC, KYC, Sign-up bonus, Card issuance, Media-only CPFA ceiling
data: 200, 30, 12, 8, 150
unit: $
:::

# Cross-check with CAC payback

A ceiling that pencils on LTV can still wreck cash flow if the customer takes too long to repay it. CAC payback is the number of months of gross margin needed to recover the cost of acquisition: CAC divided by monthly gross margin per account. Healthy is under 12 months, anything over 24 is a cash-flow warning, and early or B2B fintech often runs 18 to 24. Always cross-check the ceiling you derived against payback before you lock bids.

$$ \text{CAC payback (months)} = \frac{\text{CAC}}{\text{monthly gross margin per account}} $$

A 180 dollar acquisition that returns 15 dollars of margin a month pays back in exactly 12 months, right at the healthy edge. Halve the monthly margin and payback doubles to 24, the warning line, even though nothing about the upfront CAC changed.

:::predict
prompt: A funded customer costs $180 to acquire and contributes $15 of gross margin per month. What is the CAC payback period, in months?
answer: 12
tolerance: 0.5
unit: months
hint: Divide CAC by monthly gross margin.
explain: 180 / 15 = 12 months, right at the healthy threshold. If monthly margin fell to 7.50, payback would stretch to 180 / 7.50 = 24 months, the cash-flow warning line.
:::

:::quiz
question: Two products both have a $150 media-only CPFA ceiling. Product A returns $25/month of margin; Product B returns $10/month. Which is the safer buy on a payback basis?
- Product A, because it pays back in 6 months
- Product B, because a lower monthly margin is less risky
- They are identical because the CPFA ceiling is the same
- Product B, because it pays back in 6 months
answer: 0
hint: Payback is CPFA divided by monthly margin; shorter is safer.
explain: Product A pays back in 150 / 25 = 6 months; Product B in 150 / 10 = 15 months. The same ceiling can hide very different cash-flow risk, so payback is the cross-check that catches it.
:::

# Churn moves the whole ceiling

Because lifetime is the reciprocal of churn, the entire ceiling is hostage to your churn assumption, and finance churn is not small. Digital banking and lending often churn above 25 percent a year, so a modest error in the assumption swings LTV and the ceiling hard. At 120 dollars ARPA and a 50 percent margin, moving from 15 percent to 35 percent annual churn cuts LTV from 400 dollars down to about 171, and the allowable CAC and CPFA ceiling fall with it.

This is why you stress-test churn before committing bids rather than after. A ceiling computed on optimistic 15 percent churn looks generous; the same model at a realistic 30 percent leaves far less room to bid on competitive finance keywords, especially with paid CAC up 40 to 60 percent since 2023.

:::widget lineChart
title: Implied LTV by annual churn ($120 ARPA, 50% margin)
labels: 15%, 20%, 25%, 30%, 35%
data: 400, 300, 240, 200, 171
unit: $
:::

# Turning the ceiling into a bid

The ceiling lives in CPFA dollars, but the DSP bids in CPM, so you convert. Target CPM equals the CPFA ceiling times the funded accounts per impression, times 1000. The funded-per-impression rate is the product of every stage rate in the leaky cascade of Lesson 5, which is exactly why a leaky funnel forces your bid down: the same ceiling buys a lower max CPM when fewer impressions survive to funded.

$$ \text{target CPM} = \text{CPFA ceiling} \times \frac{\text{funded accounts}}{\text{impressions}} \times 1000 $$

Suppose the media-only ceiling is 150 dollars and the cascade delivers 80 funded accounts per 1,000,000 impressions, a funded-per-impression rate of 0.00008. Then target CPM is $150 \times 0.00008 \times 1000 = 12$ dollars. If KYC drop-off spikes and the rate halves to 0.00004, the same 150 dollar ceiling now supports only a 6 dollar CPM, and bidding at 12 would silently double your real CPFA past the cap.

:::predict
prompt: The media-only CPFA ceiling is $150 and the cascade delivers 80 funded accounts per 1,000,000 impressions (0.00008 funded per impression). What is the max target CPM, in dollars?
answer: 12
tolerance: 0.1
unit: $
hint: Target CPM = CPFA ceiling x (funded / impressions) x 1000.
explain: 150 x 0.00008 x 1000 = 12. If the funded-per-impression rate halved to 0.00004 because of KYC leakage, the same ceiling would justify only 150 x 0.00004 x 1000 = 6 dollars, so a leaky cascade forces the bid down.
:::

:::callout warning
A pain point operators raise constantly on r/PPC and r/adops: finance hands the trader a flat target CAC with no LTV model behind it, so you cannot tell whether a 160 dollar CPFA is a win or a loss. Worse, bidding one blended ceiling buries the fact that high-value cohorts (direct deposit, high balances) can justify three to five times the bid of bonus-chasers. Ask for the LTV model, segment the ceiling where data allows, and never set a paid-media cap off a blended outlier like a referral-driven 19 dollar CAC.
:::

:::sources
- eightx, LTV:CAC Ratio: Why 3:1 Matters and CAC Payback Benchmarks | https://eightx.co/blog/ltv-cac-ratio-guide
- GonzoBanker, The Real Cost of Acquiring a Banking Customer | https://gonzobanker.com/2024/05/the-real-cost-of-customer-acquisition/
- First Page Sage, Customer Acquisition Cost by Industry (Fintech) | https://firstpagesage.com/seo-blog/fintech-cac-benchmarks-report/
- Veridas, KYC Funnel Loss and Customer Drop-off | https://veridas.com/en/kyc-funnel-loss-customer-drop-off/
- incrmntal, Understanding Incremental ROAS vs ROAS | https://www.incrmntal.com/resources/understanding-incremental-roas-vs-roas-for-marketers
- Cornerstone Advisors, What Banks Really Spend to Acquire a Customer | https://www.crnrstone.com/insights
:::
