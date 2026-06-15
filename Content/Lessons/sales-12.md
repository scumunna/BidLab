---
id: sales-12
track: sales
module: 12
title: "Capstone: price and defend a deal"
summary: Put the whole track together by pricing a package, modeling its margin, forecasting delivery, and presenting the ROI case to a buyer.
---
# One deal, end to end

This is the capstone. A buyer wants a programmatic display package, and you have to do four things at once: price it, protect its margin, forecast that it will deliver, and prove it pays back. Each skill in this track maps to one of those steps. Now you run them together.

Work the deal as a chain. Price sets the revenue, cost sets the margin, delivery risk sets the make-good exposure, and the customer economics set the ROI story. Get any link wrong and the buyer's finance team will find it.

:::predict
prompt: The buyer wants 4,000,000 impressions and you price the package at a $12 CPM. What is the deal revenue, the first link in the chain?
answer: 48000
unit: $
hint: Revenue equals impressions divided by 1000, times the CPM.
explain: Revenue = 4,000,000 / 1000 x $12 = 4,000 x $12 = $48,000. Price sets revenue, and every later link in the chain, margin, make-good exposure, and the ROI story, is built on top of this number.
:::

# Price the package and model the margin

Begin with the package. Suppose the buyer wants 4,000,000 impressions and you price at a $12 CPM, for $48,000 in revenue. Your media and serving cost runs $8 per thousand, an $8 CPM. Gross margin is revenue minus cost over revenue.

$$ margin = (CPM_{sell} - CPM_{cost}) / CPM_{sell} $$

At a $12 sell and $8 cost, margin is 33 percent, or $16,000 of gross profit. Now stress it. If the buyer negotiates a 10 percent discount to a $10.80 CPM with cost fixed, margin falls to about 26 percent. Model that before you concede, not after.

:::predict
prompt: After the 10 percent discount the sell CPM is $10.80 and the cost CPM holds at $8. What is the gross margin on this stressed deal?
answer: 25.9
unit: %
tolerance: 0.3
hint: Gross margin is (sell CPM minus cost CPM) divided by sell CPM, times 100.
explain: Margin = ($10.80 - $8.00) / $10.80 x 100 = $2.80 / $10.80 x 100 = 25.9%. A 10 percent price cut dropped the margin from 33 percent to about 26 percent, because the whole cut came off the thin slice above cost.
:::

:::callout warning
Build a make-good buffer into the price. If your delivery forecast says there is real risk of falling short of guaranteed impressions, the bonus delivery you will owe comes out of this margin. Price the risk in, or it eats the deal.
:::

# Forecast delivery and present the ROI case

Next, forecast that the campaign can actually serve 4,000,000 impressions in the flight. Check available inventory at the targeting and frequency caps, then pace evenly across the days so you neither underdeliver nor burn the budget early. A delivery you cannot hit is a make-good you will owe.

Finally, build the buyer's case in their language. Translate the $48,000 into customers and lifetime value: if the package drives 480 customers at a $100 CAC, each worth $300 in lifetime margin, that is a 3:1 LTV to CAC ratio with payback inside a quarter. That sentence, backed by the margin and delivery math, is what gets the deal signed and defended.

:::callout key
A defensible deal stands on four numbers: the price, the margin after concessions, the delivery you can guarantee, and the buyer's LTV to CAC. Walk in with all four computed and you control the room. Walk in with only the price and you will negotiate from weakness.
:::

:::widget marginModeler
:::

:::quiz
question: You sell at a $15 CPM with a $9 CPM cost. The buyer wins a 20 percent discount and cost stays fixed. What is the new gross margin?
- 25 percent
- 40 percent
- 20 percent
- 33 percent
answer: 0
explain: A 20 percent discount takes the sell CPM from $15 to $12. Margin is (12 minus 9) divided by 12, which is 3 / 12 = 0.25, or 25 percent. The original 40 percent margin lost most of its cushion because the discount comes off the top line while cost held firm.
:::

:::sources
- Margin After Discount Formula and Calculator, Keka | https://www.keka.com/free-tools/calculators/margin-after-discount-calculator
- LTV/CAC Ratio: SaaS Formula and Calculator, Wall Street Prep | https://www.wallstreetprep.com/knowledge/ltv-cac-ratio/
:::
