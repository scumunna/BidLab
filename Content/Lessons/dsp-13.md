---
id: dsp-13
track: dsp
module: 13
title: "Capstone: the Trading Floor"
summary: Put every lever together to run a live campaign that hits a CPA goal while spending the budget on pace.
---
# The whole job in one objective

A campaign hands you a goal and a constraint: hit a target CPA (cost per acquisition) while spending the full budget over the flight. Miss the CPA and the campaign is unprofitable. Underspend and you leave reach and conversions on the table. Overspend early and you go dark before the flight ends. Every lever from the earlier modules now serves this one objective.

The trader's core equation ties spend to outcomes. Conversions equal impressions times win rate is already baked into delivery, but the cost side is what the CPA goal governs. Bid sets price and win rate, win rate and pacing set spend, and spend over conversions is your CPA.

$$ CPA = spend / conversions \le CPA_{target} $$

:::callout key
You cannot tune CPA and pacing in isolation. Bid up to spend faster and CPA rises. Bid down to protect CPA and you risk underspending. The art is finding the bid that hits both at once.
:::

:::predict
prompt: A campaign spends its full $45,000 budget and drives 300 conversions over the flight. What CPA did it land?
answer: 150
unit: $
hint: CPA is total spend divided by the number of conversions.
explain: CPA = $45,000 / 300 = $150 per conversion. If the target CPA was $150 or higher, the campaign hit its goal while spending the full budget.
:::

# The levers you carry in

Everything you learned is a dial on this floor. Bid shading (module 2) sets the price that balances win rate against surplus. Bid modifiers and audience signals (module 9) raise the bid where expected value is higher and cut it where it is not. Frequency caps (module 8) stop you from burning budget on over-served users. Supply-path optimization (module 10) keeps spend on clean, viewable, low-IVT inventory so the conversions you pay for are real.

The optimization loop (module 11) ties them together, learning which segments and paths convert and reallocating bid toward them. Incrementality checks (module 12) keep you honest about whether the conversions are caused or merely claimed. On the floor you adjust these continuously as the flight burns down and data accrues.

:::callout insight
Pacing is the clock on every decision. A bid that looks efficient at hour one can leave you with half the budget unspent at hour twenty. Watch spend against the even-pacing line as closely as you watch CPA.
:::

:::predict
prompt: Your budget is $45,000 and the target CPA cap is $150. At that cap, how many conversions can the budget afford?
answer: 300
unit: conversions
hint: Divide the budget by the target CPA to get the most conversions the budget can buy at that cost.
explain: Affordable conversions = $45,000 / $150 = 300. To spend the full budget without breaching the cap, every lever has to combine to deliver at least 300 conversions at or below $150 each.
:::

# Run it

Use the bid as your master dial. Push it up and you win more auctions, spend faster, and lift CPA. Pull it down and you protect CPA but slow delivery. Find the bid where expected profit per opportunity peaks, then nudge it to keep spend on the pacing line without breaking the CPA cap.

:::widget bidPlayground
marketMean: 0.5
value: 1.0
:::

Watch the peak. Bidding past it wins more impressions but each one costs more than it returns, so CPA climbs and profit falls. Bidding below it protects margin but starves delivery. The trading floor is this single trade-off, played out across thousands of auctions a second, under a budget that has to land exactly on zero when the flight ends.

:::quiz
question: Halfway through the flight you are well under your CPA target but pacing badly behind on spend. What is the right move?
- Raise the bid to spend faster, accepting a higher CPA while staying under target
- Lower the bid to protect CPA further
- Hold the bid and let the budget go unspent
- Remove the frequency cap entirely to spend on saturated users
answer: 0
explain: You have CPA headroom, so the binding problem is underspend. Raising the bid speeds delivery and uses the headroom, as long as CPA stays under target. Letting budget go unspent wastes reach and conversions.
:::

:::sources
- Google Ads Help, About Target CPA bidding | https://support.google.com/google-ads/answer/6268632
- OpenRTB 2.6 Specification, IAB Tech Lab | https://iabtechlab.com/standards/openrtb/
:::
