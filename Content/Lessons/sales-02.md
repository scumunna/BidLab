---
id: sales-02
track: sales
module: 2
title: Pricing math
summary: Convert between CPM, CPC, and CPA, separate gross from net, account for agency commission, and read the margin formula behind every deal.
---
# Three ways to price the same media

Media is priced on whatever outcome the buyer agrees to pay for. CPM (cost per mille) is the cost per thousand impressions. CPC (cost per click) is the cost per click. CPA (cost per action) is the cost per conversion. They are not different products, they are different ways to slice the same delivery.

The conversions between them run through performance rates. If you know the click-through rate (CTR) and conversion rate (CVR), you can move between all three. This matters because buyers and sellers often quote in different units, and you need to compare them on common ground.

$$ CPM = CTR \times 1000 \times CPC $$

:::predict
prompt: A buyer pays a $1.50 CPC and the inventory runs a 0.2 percent CTR. What is the equivalent CPM?
answer: 3
unit: $
tolerance: 0.05
hint: CPM = CTR x 1000 x CPC, with CTR as a decimal.
explain: CPM = 0.002 x 1000 x $1.50 = $3.00. A thousand impressions at a 0.2% CTR produce 2 clicks, so 2 x $1.50 = $3.00 of cost per thousand impressions.
:::

# Converting across models

Start from a CPC and a CTR. If clicks happen at rate CTR per impression, then a thousand impressions produce CTR times 1000 clicks, so the CPM is CTR times 1000 times CPC. To go the other way, divide. CPC equals CPM divided by (CTR times 1000).

CPA chains one step further. A conversion costs one click divided by the conversion rate, so CPA equals CPC divided by CVR. With a $2 CPC and a 5 percent CVR, the CPA is $40. Each layer of the funnel dilutes the rate, which is why CPA buys carry the most pricing risk for whoever holds the model.

:::callout insight
CPM, CPC, and CPA are linked by funnel rates. Whoever prices on the deepest metric (CPA) absorbs the most variance if those rates move.
:::

:::predict
prompt: A buyer pays a $3 CPC and converts clicks at a 4 percent CVR. What is the effective CPA?
answer: 75
unit: $
hint: CPA equals CPC divided by the conversion rate, with CVR as a decimal.
explain: CPA = $3 / 0.04 = $75. It takes 25 clicks to land one conversion at a 4% CVR, so 25 x $3 = $75. If the CVR slips, the CPA rises fast, which is the variance the CPA seller absorbs.
:::

# Gross, net, and the agency commission

Gross is the price before fees. Net is what remains for media after fees come out. The classic agency commission is 15 percent of gross, meaning the agency keeps 15 and 85 reaches the media. So net equals gross times (1 minus 0.15), and to gross up a net number you divide by 0.85, not multiply by 1.15.

This distinction causes real money to go missing. A client-facing CPM must include the fees the buyer pays on top of media. If you quote a net CPM as if it were gross, you understate the price the buyer actually pays and misstate everyone's margin.

:::callout warning
Never mix gross and net in the same calculation. To convert a net figure to gross, divide by (1 minus the fee rate). Adding the fee rate back overstates the gross.
:::

:::predict
prompt: A media plan needs $85,000 to reach the publisher as net media after a 15 percent agency commission. What gross budget must the client approve?
answer: 100000
unit: $
hint: Gross up by dividing the net figure by (1 minus the fee rate), not by multiplying by 1 plus the fee.
explain: Gross = $85,000 / (1 - 0.15) = $85,000 / 0.85 = $100,000. Multiplying $85,000 by 1.15 would give $97,750, understating the gross and leaving the media budget short.
:::

# The margin formula

Margin is revenue minus cost, expressed as a share of revenue. If you buy media at a cost and resell at a price, your margin percentage is (price minus cost) divided by price. Note this is margin on revenue, not markup on cost, the two differ and conflating them inflates your reported profit.

Use the calculator below to convert between pricing models and watch margin respond. Adjust the CTR or CVR and you will see how a small change in funnel rate swings the effective CPA and the margin on a performance deal.

:::widget pricingCalculator
:::

:::quiz
question: A media cost of $4 CPM is resold to the client at $5 CPM. What is the margin on revenue?
- 20 percent
- 25 percent
- 80 percent
- 125 percent
answer: 0
explain: Margin on revenue is (price minus cost) divided by price, so (5 minus 4) divided by 5 equals 0.20, or 20 percent. The 25 percent figure would be markup on cost, a different number.
:::

:::sources
- CPC, CPM, CPA: Ad Payment Models Decoded, Epom | https://epom.com/blog/ad-server/cpm-cpc-cpa-complete-guide
- CPM Definition and Formula, Media Drive | https://mediadrive.pro/wiki/media-math/cpm/
:::
