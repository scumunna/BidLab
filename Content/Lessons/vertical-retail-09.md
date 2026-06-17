---
id: vertical-retail-09
track: vertical-retail
module: 9
title: "Measurement, incrementality and clean rooms: lift testing, AMC, MMM vs MTA, and cross-RMN de-duplication"
summary: Run a holdout to separate caused sales from credited sales, compute iROAS and lift, de-duplicate conversions claimed by multiple RMNs in a clean room, and triangulate MMM against MTA instead of summing them.
---
# Credited is not caused

Closed-loop ROAS answers one question only: what got credited inside one RMN's attribution window. It cannot tell you what the ad actually caused, because the console has no counterfactual. A shopper who was going to buy your brand anyway, sees a Sponsored Products ad on the way, clicks, and converts shows up as attributed sales at a glamorous ROAS, yet nothing changed in the world. Incrementality is the discipline of measuring the sales that would NOT have happened without the spend, and iROAS (incremental ROAS) is the only spend-efficiency number that survives a holdout.

This is the operational resolution of the attribution-overlap problem from module 3. There the trader learned that overlapping windows let the same purchase get claimed by Amazon, Walmart, and Instacart at once. Here the trader learns the three tools that fix it: lift tests, clean-room de-duplication, and MMM-versus-MTA triangulation.

:::callout key
Closed-loop ROAS measures correlation between spend and credited sales. iROAS measures causation. A campaign can have an elite ROAS and a near-zero iROAS at the same time, and only a control group can tell the difference.
:::

:::predict
prompt: A campaign reports $50,000 in closed-loop attributed sales on $5,000 of spend, so the console prints a 10x ROAS. A later lift test finds only 20% of those sales were incremental. What is the iROAS the holdout actually proves?
answer: 2
tolerance: 0.05
unit: x
hint: Keep only the incremental share of the attributed sales, then divide by spend.
explain: Incremental sales = 0.20 x $50,000 = $10,000. iROAS = $10,000 / $5,000 = 2.0x. The console's 10x credited demand it already owned, and the holdout shows the spend was only one-fifth as efficient as the dashboard claimed, which is exactly why credited is not caused.
:::

# The holdout: exposed minus control

A lift test withholds the ad from a matched control group and compares it to an exposed group. The three field designs the trader runs are GEO HOLDOUTS (matched markets, ads on in one set, off in the other), GHOST ADS or PSA tests (the control is served a placebo impression so exposure is symmetric), and platform CONVERSION-LIFT studies (the RMN randomizes who is eligible and compares exposed versus unexposed). The math, once you scale the two groups to equal population, is simple subtraction.

$$ \text{Incremental sales} = \text{exposed sales} - \text{control sales} $$

$$ \text{Lift }\% = \frac{\text{exposed conv rate} - \text{control conv rate}}{\text{control conv rate}} $$

The lift percentage is the share of the exposed result that the ad genuinely added on top of the baseline the control already proves.

:::predict
prompt: A conversion-lift study shows the exposed group converting at 6.0% and the matched control converting at 4.0%. What is the lift percentage?
answer: 50
tolerance: 0.5
unit: %
hint: Take the difference in conversion rates and divide by the control rate.
explain: (6.0% - 4.0%) / 4.0% = 2.0 / 4.0 = 0.50, a 50% lift. The control proves 4 points of the conversions would have happened anyway, so the ad caused only the extra 2 points, which is half of the control's 4-point baseline (the 50% lift is measured over the control, not over the exposed group's 6 points).
:::

:::figure incrementalityHoldout
caption: A holdout splits a matched population into an exposed cell and a control cell. The control converts on its own (the baseline), the exposed cell converts more, and the gap scaled to equal population is the incremental sales the ad caused.
:::

# iROAS is the number that survives

Once the holdout returns incremental sales, iROAS falls straight out: incremental sales divided by ad spend. This is the figure the trader defends to a CFO, because it is the only one that would still be there if you turned the campaign off. The signature trap of the retail-media vertical is the gap between closed-loop ROAS and iROAS on branded-defense keywords, where AMC lift studies routinely show only roughly 22% to 38% incremental conversion lift, meaning 62% to 78% of those clicks would have converted with no ad at all.

$$ \text{iROAS} = \frac{\text{incremental sales}}{\text{ad spend}} $$

A defensive campaign printing 12x closed-loop ROAS at 25% lift is mostly harvesting demand you already owned. The same logic flips the other way for conquest and new-to-brand: a 2.5x closed-loop ROAS with high lift can be worth far more per dollar than the 12x branded print.

:::predict
prompt: A geo holdout runs across 200 stores. The 100 exposed stores post $500,000 in category sales over the test, the 100 matched control stores post $420,000, and the campaign spent $25,000. What is the iROAS?
answer: 3.2
tolerance: 0.05
unit: x
hint: Incremental sales is exposed minus control, then divide by spend.
explain: Incremental sales = $500,000 - $420,000 = $80,000. iROAS = $80,000 / $25,000 = 3.2x. Note the closed-loop ROAS the console would report could be the full $500,000 over a fraction of the spend, far higher than the real 3.2x the holdout proves.
:::

:::predict
prompt: A branded-defense campaign reports $120,000 in closed-loop attributed sales on $10,000 spend, but an AMC lift study finds only 30% of those sales are incremental. What is the true iROAS once you keep only the incremental portion?
answer: 3.6
tolerance: 0.1
unit: x
hint: First take 30% of the attributed sales, then divide by spend.
explain: Incremental sales = 0.30 x $120,000 = $36,000. iROAS = $36,000 / $10,000 = 3.6x. The dashboard ROAS was 12x ($120,000 / $10,000), so the lift study cut the real efficiency to less than a third of the credited figure.
:::

# Clean rooms do the de-duplication

A data clean room lets the trader query event-level pseudonymized exposure plus conversion data without ever seeing a raw user identifier, which is what makes both lift computation and de-duplication possible at scale. Amazon Marketing Cloud (AMC) is the workhorse, and the single most consequential 2025 measurement change was Amazon making AMC FREE for all Sponsored Ads advertisers on September 18, 2025, removing the DSP-contract gate that, as practitioner write-ups document, had carried a roughly $60,000-a-year minimum and limited clean rooms to large brands. Retailer clean rooms at Walmart, Kroger, and others do the same job per network.

De-duplication is the operation that stops finance distrust. When you sum each RMN's self-reported sales you double-count every purchase that more than one network claimed inside overlapping windows, so the de-duplicated figure subtracts that overlap back out.

$$ \text{De-duplicated sales} = \sum \text{RMN-reported sales} - \text{overlap claimed by} > 1 \text{ network} $$

:::predict
prompt: Amazon reports $40,000, Walmart reports $30,000, and Instacart reports $20,000 in attributed sales, but a clean-room match finds $15,000 of those conversions were claimed by more than one network. What is the de-duplicated total?
answer: 75000
tolerance: 100
unit: USD
hint: Sum the three reported figures, then subtract the overlap once.
explain: Sum = $40,000 + $30,000 + $20,000 = $90,000. De-duplicated = $90,000 - $15,000 overlap = $75,000. If finance had simply added the three consoles they would have booked $90,000 against a reality of $75,000, a 20% overstatement nobody owns without the clean room.
:::

:::quiz
question: What is the primary reason a brand's summed closed-loop sales across Amazon, Walmart, and Instacart can exceed its actual total sales?
- The RMNs are inflating their numbers on purpose
- Overlapping attribution windows let multiple networks claim the same purchase
- Organic sales are being counted as ad-attributed
- The clean room is double-counting impressions
answer: 1
hint: Think back to module 3 and what happens when two windows cover the same conversion.
explain: When a shopper's single purchase falls inside the attribution windows of two or more networks, each one credits it independently, so the sum exceeds reality. The fix is clean-room de-duplication that matches the conversion once across networks, not an accusation of fraud or an organic-sales mistake.
:::

# MMM and MTA: triangulate, never sum

The trader works with two modeling families that almost never agree, and the job is to triangulate them, not to pick a winner or add them together. MMM (marketing-mix modeling) is top-down and econometric: it regresses total sales against spend by channel, is privacy-durable because it needs no user-level data, but is slow and coarse. MTA (multi-touch attribution) is bottom-up: it traces individual paths and is granular, but it is cookie-fragile and blind to channels it cannot tag. The IAB and IAB Europe codified this in the Guidelines for Incremental Measurement in Commerce Media (released November 3, 2025), which name four methods: experiments, model-based counterfactuals, econometrics, and hybrid proxies.

$$ \text{Triangulated contribution} = \text{blend}(\text{MMM}_{\text{top-down}}, \text{MTA}_{\text{bottom-up}}, \text{experiment}) $$

The experiment (the holdout) is the tiebreaker that anchors both models to ground truth. When MMM says a channel contributed 18% and MTA says 26%, the deliverable is a triangulated range with the holdout as the calibration point, not a single false-precision number.

:::quiz
question: A client wants one definitive contribution number and asks you to just use MTA because it is more granular. What is the correct practitioner response?
- Agree, MTA is user-level so it is the most accurate
- Use MMM instead because it is privacy-durable and therefore always right
- Present a triangulated range anchored by a holdout, explaining MMM and MTA measure different things and rarely agree
- Average the two numbers and report the midpoint as fact
answer: 2
hint: One model is granular but cookie-fragile, the other is durable but coarse, and an experiment is the only ground truth.
explain: MMM and MTA answer different questions on different data, so neither is "the truth" alone and a blind average is false precision. The correct deliverable is a triangulated range with an incrementality experiment as the calibration anchor, which is exactly the hybrid approach the IAB 2025 commerce-media guidelines endorse.
:::

# The lift data and the profit lever

Reading lift results changes where the budget goes. The same set of campaigns shrinks dramatically as you move from what was credited, to what was caused, to what survives cross-RMN de-duplication, and that shrinkage is the trader's edge: it identifies the low-incremental spend to cut and the high-incremental spend to grow. A documented AMC-revealed lever is reallocating 10% to 20% of budget out of low-incremental retargeting and into high-LTV new-to-brand segments.

:::widget barChart
title: The same campaigns shrink from credited to caused to de-duplicated
labels: Closed-loop reported, Incremental (holdout), De-duplicated cross-RMN
data: 100, 30, 78
unit: index
:::

The chart indexes a campaign set at 100 on closed-loop reported sales. A holdout reveals only 30 of that 100 was incremental, while cross-RMN de-duplication of the credited figure lands near 78 once overlap is removed. The two corrections answer different questions (causation versus double-counting) and the trader has to run both.

:::predict
prompt: A retargeting line spends $20,000 at a measured 1.4x iROAS, so it produces $28,000 incremental. If you move that same $20,000 to a new-to-brand segment measured at 3.5x iROAS, how many more incremental dollars do you generate versus leaving it in retargeting?
answer: 42000
tolerance: 100
unit: USD
hint: Compute incremental sales for each placement, then take the difference.
explain: New-to-brand incremental = 3.5 x $20,000 = $70,000. Retargeting incremental = 1.4 x $20,000 = $28,000. Reallocating the same budget adds $70,000 - $28,000 = $42,000 in caused sales, the kind of move AMC lift data exists to justify.
:::

# Where it breaks in the field

Incrementality is the highest-value skill and the hardest to fund, because the failure modes are organizational, not mathematical. Clean-room de-duplication needs comparable event-level access in every RMN, so a network without an AMC-equivalent leaves a blind spot the trader must flag rather than paper over with a guessed adjustment. And the deliverable is always a triangulated range, never a single number presented as truth, because MMM and MTA disagreeing is the normal state, not an error to resolve by deleting one.

:::callout warning
A recurring operator complaint on r/PPC and AdExchanger: clients refuse to fund holdout or PSA tests because "turning ads off in a control market looks like lost sales," so true incrementality never gets measured and the brand keeps over-paying for branded-defense demand it already owns. The counter the trader brings is the math from this lesson, that a 30% lift on a 12x dashboard means the real iROAS is a fraction of the credited number, and the holdout is how you find the budget to redeploy.
:::

:::quiz
question: You are de-duplicating conversions across four RMNs, but one of them has no clean room or AMC-equivalent, so you cannot match its conversions at the event level. What is the correct trader move?
- Drop that RMN's sales entirely so nothing is double-counted
- Assume its overlap matches the others and subtract the same percentage you measured elsewhere
- Trust that network's self-reported de-duplicated number because it knows its own data best
- Flag it as an unmeasurable blind spot in the deliverable and report a range, not a single de-duplicated total
answer: 3
hint: The failure mode here is organizational, not mathematical, and a guessed adjustment is still a guess.
explain: Without comparable event-level access you cannot know how much of that network's credited sales overlap the others, so dropping them, guessing a matched percentage, or trusting a self-report all manufacture false precision. The honest deliverable names the blind spot and presents a de-duplicated range, which is the same triangulation discipline the lesson applies to MMM versus MTA.
:::

:::sources
- Amazon Ads, Sponsored ads advertisers can now access Amazon Marketing Cloud | https://advertising.amazon.com/library/news/amc-for-sponsored-ads
- EMARKETER, FAQ on data clean rooms: how retail media is driving adoption | https://www.emarketer.com/content/faq-on-data-clean-rooms-how-retail-media-driving-adoption-marketers-demand-proof
- IAB, Guidelines for Incremental Measurement in Commerce Media | https://www.iab.com/guidelines/guidelines-for-incremental-measurement-in-commerce-media/
- IAB Europe, Commerce (incl. Retail) Media Measurement Standards V2.1 | https://iabeurope.eu/knowledge_hub/iab-europes-commerce-incl-retail-media-measurement-standards-v2/
- Dataslayer, Incrementality becomes the primary KPI for retail media advertisers | https://www.dataslayer.ai/blog/incrementality-becomes-the-primary-kpi-for-retail-media-advertisers
- PPC Land, Amazon makes Marketing Cloud directly accessible to sponsored ads advertisers | https://ppc.land/amazon-makes-marketing-cloud-directly-accessible-to-sponsored-ads-advertisers/
- MediaPost, Amazon giving free cloud cleanroom service to all sponsored campaign advertisers | https://www.mediapost.com/publications/article/409209/amazon-giving-free-cloud-service-to-all-sponsored.html
- Seresa, Amazon Marketing Cloud is now free for Sponsored Products advertisers (no DSP contract, no $60K-a-year minimum) | https://seresa.io/blog/amazon-marketing-cloud/amazon-marketing-cloud-is-now-free-for-sponsored-products-advertisers
:::
