---
id: vertical-dtc
track: dtc
module: 1
title: DTC: when the unit economics are the campaign
summary: How direct-to-consumer brands bid on contribution margin and lifetime value instead of reach, using blended CAC, MER, and gross-margin LTV.
---
# The math is the moat

In direct-to-consumer (DTC) ecommerce the campaign is not really about reach. It is about whether each new customer pays back more than they cost. US DTC ecommerce sales were around $239.75B in 2025 by one aggregator estimate, but the number that matters to an operator is not the market size. It is the gap between what a customer is worth and what you paid to acquire them.

That makes DTC the most quantitative vertical of all. You do not optimize impressions. You optimize contribution margin, payback period, and the ratio of lifetime value to acquisition cost. Get those right and you can scale. Get them wrong and you scale straight into a loss.

:::predict
prompt: A new customer is worth $180 in gross-margin lifetime value and costs $60 to acquire. How much value, per customer, does the business net above acquisition cost?
answer: 120
unit: $
tolerance: 1
hint: Subtract the acquisition cost from the gross-margin lifetime value.
explain: Net value = $180 - $60 = $120 per customer. This gap, not impressions or reach, is the number a DTC operator scales against. Widen it and you can buy growth profitably; close it and every new customer is a loss.
:::

# Blended CAC versus paid CAC

After Apple's App Tracking Transparency, in-platform attribution became unreliable. Estimates put iOS signal loss in a roughly 20 to 30 percent range, so the return on ad spend a platform reports tends to over-claim. Operators respond by tracking two numbers at once.

Paid customer acquisition cost (CAC) counts only customers a channel claims it drove. Blended CAC divides total marketing spend by every new customer, no matter the source. The platform number flatters you. The blended number is honest.

$$ CAC_{blended} = \frac{Total\ marketing\ spend}{Total\ new\ customers} $$

:::callout insight
Platform-attributed ROAS is a sales pitch the platform makes to itself. Blended CAC and marketing efficiency ratio are the numbers you can actually take to the bank.
:::

:::predict
prompt: You spend $40,000 across all channels in a month and acquire 800 new customers total. Meta claims credit for 500 of them. What is your blended CAC?
answer: 50
tolerance: 1
unit: $
hint: Blended CAC uses total spend divided by total new customers, ignoring which channel claims credit.
explain: Blended CAC = $40,000 / 800 = $50. The 500 Meta-attributed customers are irrelevant to the blended figure, which deliberately counts every new customer.
:::

# MER: the honest efficiency number

Marketing efficiency ratio (MER) is total revenue divided by total ad spend. Unlike platform ROAS it cannot be inflated by attribution games, because both numbers come straight from your own books. A MER of 3.0 is a common rule-of-thumb floor for healthy DTC economics.

$$ MER = \frac{Total\ revenue}{Total\ ad\ spend} $$

:::predict
prompt: In a month you generate $180,000 in revenue on $45,000 of total ad spend. What is your MER?
answer: 4
tolerance: 0.05
unit: x
hint: MER is just total revenue divided by total ad spend.
explain: MER = $180,000 / $45,000 = 4.0. That is comfortably above the 3.0 floor many operators treat as the line between healthy and stretched.
:::

# Gross-margin LTV and the ratio that must not lie

The single most common DTC modeling error is comparing revenue lifetime value to acquisition cost. Revenue does not pay for ads. Margin does. You must use gross-margin LTV, sometimes written LTGP:CAC, or the ratio overstates how much you can really afford to spend.

For a one-time purchase brand, lifetime value on a gross-margin basis is average order value times purchase frequency times lifespan times gross margin percent. Then you compare it to CAC. A ratio at or above 3 to 1 is generally considered good and 5 to 1 elite.

$$ LTV_{GM} = AOV \times Frequency \times Lifespan \times GM\% $$

:::predict
prompt: AOV is $58, a customer buys 3 times over their lifetime, and gross margin is 70%. On a gross-margin basis, what is the lifetime value of one customer?
answer: 121.8
tolerance: 1
unit: $
hint: Multiply AOV by purchases, then take 70 percent of that for the margin.
explain: LTV_GM = $58 x 3 x 0.70 = $121.80. Note the gross-margin step: revenue LTV would be $174, which is the number that makes the LTV:CAC ratio lie.
:::

:::predict
prompt: Using that $121.80 gross-margin LTV, if your blended CAC is $42, what is your LTV:CAC ratio?
answer: 2.9
tolerance: 0.05
unit: x
hint: Divide gross-margin LTV by CAC.
explain: $121.80 / $42 = 2.9. That sits just under the 3:1 line, which is exactly why operators watch the ratio so closely while scaling.
:::

# Payback and contribution margin

Even a strong ratio can sink you if the money comes back too slowly. CAC payback in months is acquisition cost divided by the monthly contribution margin per customer, where contribution margin is what is left from an order after cost of goods and variable costs like shipping, payment processing, fulfillment, and returns. Under twelve months is broadly considered good, with top-quartile operators recovering CAC in around eight months.

:::callout key
Scale on three constraints at once: LTV:CAC at or above 3, MER at or above 3, and payback under your cash-cycle limit. Subscription products can multiply LTV roughly 3 to 5x by extending lifespan, which is often the cleanest way to fix a borderline ratio without simply cutting spend.
:::

:::widget marginModeler
:::

:::quiz
question: Why should a DTC operator use gross-margin LTV rather than revenue LTV when computing LTV:CAC?
- Because revenue is harder to measure than margin
- Because only margin, not revenue, is available to pay back acquisition cost
- Because platforms require gross-margin reporting
- Because gross-margin LTV is always a larger, more flattering number
answer: 1
hint: Think about which dollars are actually free to spend on acquiring the next customer.
explain: Revenue includes cost of goods and variable costs that must be paid before any money is left over. Only gross margin can fund acquisition, so a revenue-based ratio overstates what you can afford and the ratio lies.
:::

:::sources
- US DTC Brand Statistics 2025, SQ Magazine | https://sqmagazine.co.uk/direct-to-consumer-brand-statistics/
- Digital ad spending outlook dims as tariff impact intensifies, Marketing Dive / eMarketer | https://www.marketingdive.com/news/digital-ad-spending-outlook-dims-as-tariff-impact-intensifies-emarketer/760858/
:::
