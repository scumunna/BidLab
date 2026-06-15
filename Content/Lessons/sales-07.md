---
id: sales-07
track: sales
module: 7
title: ROI storytelling
summary: Translate a media plan into the financial metrics a buyer's CFO actually cares about: ROAS, MER, payback period, and LTV:CAC.
---
# The buyer answers to a CFO

A media plan does not get approved because the targeting is clever. It gets approved because someone on the client side can defend it to a finance team. Your job in the room is to hand them that defense, already built.

That means speaking in the metrics finance uses. Four of them carry most of the weight: ROAS, MER, payback period, and the LTV to CAC ratio. Learn to compute each one cold and you can build the business case for any deal.

:::predict
prompt: A media plan asks for $40,000 in spend and the model projects $160,000 in revenue. What ROAS would you put in front of the CFO?
answer: 4
unit: x
tolerance: 0.05
hint: ROAS is revenue divided by the spend that drove it.
explain: ROAS = $160,000 / $40,000 = 4.0x, meaning four dollars of revenue for every dollar of media. That single number is the headline finance wants before they look at the targeting.
:::

# ROAS and MER: two views of the same spend

ROAS, return on ad spend, is revenue divided by the spend that drove it. A ROAS of 4 means four dollars of revenue for every dollar of media. It is the campaign-level number, attributed to specific channels.

MER, the marketing efficiency ratio, is total company revenue divided by total marketing spend over a period. It ignores attribution entirely, so it cannot double-count or be gamed by last-touch credit. Buyers call it honest ROAS, and it is the number a CFO trusts when channel attribution gets messy.

$$ ROAS = revenue / spend \qquad MER = revenue_{total} / spend_{total} $$

:::callout insight
A channel can show a 6x attributed ROAS while blended MER stays flat. That gap usually means the channel is taking credit for sales that would have happened anyway. Lead with MER when you want to be believed.
:::

:::predict
prompt: A company books $2,000,000 in total revenue over a quarter and spends $500,000 on all marketing combined. What is the MER?
answer: 4
unit: x
tolerance: 0.05
hint: MER is total company revenue divided by total marketing spend, with no attribution.
explain: MER = $2,000,000 / $500,000 = 4.0x. Because it uses total revenue over total spend, MER cannot be inflated by last-touch credit, which is why a CFO trusts it when channel attribution gets messy.
:::

# Payback and LTV:CAC: the durable case

ROAS is a snapshot. The stronger story is about the customer you acquired. Customer acquisition cost (CAC) is spend divided by new customers. Lifetime value (LTV) is the gross profit that customer delivers before they churn.

Payback period is CAC divided by monthly margin per customer, the number of months to earn back the acquisition cost. The LTV to CAC ratio compares lifetime value to acquisition cost, and finance teams generally want 3 to 1 or better. A 3:1 ratio with a payback under 12 months turns a media buy into an investment, not an expense.

:::callout key
Reframe the ask. You are not selling impressions for $40,000. You are selling 400 customers at a $100 CAC, each worth $300 in lifetime margin, paid back in 4 months. That is the sentence that gets signed.
:::

:::widget marginModeler
:::

:::quiz
question: A channel reports 5x attributed ROAS, but the company's blended MER has not moved since the campaign launched. What is the most likely explanation?
- The channel is claiming credit for conversions that would have happened anyway
- MER is calculated incorrectly and should be ignored
- The campaign is genuinely incremental and finance should expand it
- ROAS and MER always move together, so the data is broken
answer: 0
explain: Attributed ROAS can look strong while blended MER stays flat when a channel takes last-touch credit for non-incremental sales. The gap between the two is the signal worth investigating.
:::

:::sources
- Marketing Efficiency Ratio (MER), Marketing Professional Glossary | https://rcstrat.com/glossary/marketing-efficiency-ratio-mer
- MER vs ROAS: Which Should You Focus On?, Single Grain | https://www.singlegrain.com/blog/mer-vs-roas/
:::
