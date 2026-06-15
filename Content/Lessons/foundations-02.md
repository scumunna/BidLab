---
id: foundations-02
track: foundations
module: 2
title: Algebra you actually use
summary: Use variables, solve for an unknown quantity, and rearrange the CPM, CPC, and CPA relationships to find whatever you are missing.
---
# A variable is just a name for a number you do not know yet

Algebra sounds intimidating, but at its core a variable is only a placeholder, a name we give to a number before we know its value. We might call the cost of an impression c, the number of impressions n, and the total spend S. Once we name them, we can write the relationship between them as a short sentence in symbols.

Total spend is the cost per impression times the number of impressions, which we write S = c times n, or more compactly S = c n. This is an equation: a claim that the thing on the left equals the thing on the right. Equations are useful because if you know any two of the three quantities, you can find the third.

:::predict
prompt: Using S = c n, if the cost per impression c is 0.006 dollars and you buy 2,000,000 impressions, what is the total spend S?
answer: 12000
unit: $
hint: Total spend is the cost per impression times the number of impressions.
explain: S = c n = 0.006 x 2,000,000 = 12,000 dollars. Knowing any two of the three quantities lets you solve for the third directly from the equation.
:::

:::callout key
An equation is a balance scale. Whatever you do to one side you must do to the other, and the two sides stay equal. That single rule is all of the algebra you need here.
:::

# Solving for the quantity you are missing

Suppose you spent 4,000 dollars (S) and the cost per impression (c) was 0.005 dollars, and you want the number of impressions (n). Start from S = c n and isolate n by doing the same operation to both sides. Divide both sides by c, and the c on the right cancels, leaving n = S / c.

Now plug in numbers: n = 4,000 / 0.005 = 800,000 impressions. The skill here is mechanical and reliable. To isolate a variable, undo what is attached to it using the opposite operation, and do that operation to both sides so the scale stays balanced. Multiplication is undone by division, addition by subtraction.

:::predict
prompt: You spent 6,000 dollars at a cost per impression of 0.004 dollars. Using n = S / c, how many impressions did you buy?
answer: 1500000
unit: impressions
hint: Isolate n by dividing total spend by the cost of one impression.
explain: n = S / c = 6,000 / 0.004 = 1,500,000 impressions. You undo the multiplication in S = c n by dividing both sides by c, which leaves n alone.
:::

# The CPM, CPC, and CPA family

Three prices run programmatic buying, and they are all the same kind of equation. CPM is cost per thousand impressions, so spend equals CPM times impressions divided by 1,000. CPC is cost per click, so spend equals CPC times clicks. CPA is cost per acquisition, so spend equals CPA times conversions. Each one is total cost equals a unit price times a count.

$$ CPC = CPM / (1000 \times CTR) $$

That formula comes straight from rearranging definitions. CPM divided by 1,000 is the cost of one impression. Each click costs that many impressions, and the number of impressions per click is 1 / CTR. Multiply them and the impression unit cancels, leaving cost per click. The same chaining links CPC to CPA through CVR: CPA = CPC / CVR, because each conversion takes 1 / CVR clicks.

:::predict
prompt: Your CPC is 2 dollars and your CVR is 4%. Using CPA = CPC / CVR, what is the implied CPA?
answer: 50
unit: $
hint: Each conversion takes 1 / CVR clicks, so divide the CPC by the conversion rate.
explain: CPA = CPC / CVR = 2 / 0.04 = 50 dollars. It takes 25 clicks to make one conversion at a 4% CVR, and 25 clicks at 2 dollars each is 50 dollars per conversion.
:::

:::callout insight
You almost never memorize these formulas. You rederive them on the spot by chaining unit prices and rates so that the units cancel. If your units do not cancel to dollars per conversion, you rearranged something wrong.
:::

# Try rearranging

Enter a CPM and a CTR and read off the implied CPC, then add a CVR and watch the CPA fall out. Change one input and trace which outputs move. This is algebra you can feel.

:::widget pricingCalculator
:::

:::quiz
question: Your CPM is 10 dollars and your CTR is 0.5%. What is the implied CPC?
- 2 dollars
- 0.05 dollars
- 20 dollars
- 5 dollars
answer: 0
explain: CPC = CPM / (1000 times CTR) = 10 / (1000 times 0.005) = 10 / 5 = 2 dollars. One thousand impressions cost 10 dollars and yield 5 clicks, so each click costs 2 dollars.
:::

:::sources
- Google Ads Help, average cost-per-click (CPC) | https://support.google.com/google-ads/answer/116495
- Khan Academy, solving equations with one unknown | https://www.khanacademy.org/math/algebra/one-variable-linear-equations
:::
