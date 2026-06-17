---
track: vertical-dtc
title: DTC Growth Certification
pass: 0.7
draw: 12
---
:::q Landscape and the Mandate
question: A DTC brand runs $1.2M in Shopify revenue on $300K of total media spend in a month and carries a 30% contribution margin. What is its MER and does it clear breakeven?
- MER is 4.0x, comfortably above the 3.3x breakeven floor
- MER is 0.25x, which is below breakeven
- MER is 4.0x, but it sits below the 4.5x breakeven floor
- MER is 3.0x, exactly at breakeven
answer: 0
explain: MER is 1,200,000 / 300,000 = 4.0x, and breakeven MER is 1 / 0.30 = 3.3x, so the brand clears the floor with real headroom.
:::

:::q Landscape and the Mandate
question: A brand posts a healthy 4.0x blended MER on $300K of spend and $1.2M of revenue, but only $600K of that revenue came from first-time buyers. With breakeven near 2.5x, what is the right read?
- nMER is 2.0x, so the acquisition engine is underwater while returning revenue hides it
- nMER is 4.0x, so acquisition is just as efficient as the blended number
- nMER is 6.0x, so the brand should cut spend immediately
- nMER cannot be computed without the AOV
answer: 0
explain: nMER is 600,000 / 300,000 = 2.0x, below the 2.5x breakeven, so net-new acquisition loses money first-order even though the 4.0x blended figure looks fine.
:::

:::q Landscape and the Mandate
question: You inherit a $50,000 per month account that puts 96% of acquisition spend through Meta. The founder wants to know the single biggest structural risk before you scale. What do you flag?
- Programmatic share will drop below the 90% benchmark
- The brand cannot produce enough creative for one platform
- A CPM spike or account restriction has no fallback and no leverage, a single point of failure
- TikTok CPMs will rise to match Meta
answer: 2
explain: Heavy Meta concentration is a single point of failure, so a CPM spike or an account restriction leaves the brand with nowhere to redeploy and no negotiating leverage, which is the risk the diversification ratio exists to reduce.
:::

:::q Landscape and the Mandate
question: A subscription brand deliberately runs a 2.0x blended MER while its first-order contribution margin is 50%. A junior buyer wants to cut spend because the MER looks low. What is the correct interpretation?
- The brand is losing money first-order and should cut spend now
- A 2.0x MER is always elite regardless of margin
- MER cannot be compared to breakeven for subscription brands
- The brand is exactly at first-order breakeven and is funded by subscription LTV over later cycles
answer: 3
explain: Breakeven MER at a 50% margin is 1 / 0.50 = 2.0x, so the brand runs exactly at first-order breakeven on purpose because recurring LTV cohorts backfill the aggressive front-end spend.
:::

:::q Measurement and Signal
question: Shopify recorded 1,000 Purchases for a window in which Meta's pixel claims 1,950. Site CVR is unchanged. What is the gap and the correct action?
- A 95% gap is inside the normal band, so trust Meta and move on
- A 49% gap is normal iOS noise, so no action is needed
- A 95% gap is far beyond the 20% to 40% band, so hunt a tracking break such as a CAPI dedup failure doubling the event
- A 95% gap proves Shopify is undercounting, so use 1,950 as truth
answer: 2
explain: The over-report is (1,950 - 1,000) / 1,000 = 95%, roughly double Shopify and the classic fingerprint of Pixel and CAPI firing the same Purchase without a matching event_id, a tracking break to fix in Events Manager.
:::

:::q Measurement and Signal
question: A teammate insists Apple now strips all UTMs in 2026 and wants to abandon UTM-based reporting. Auditing how clicks actually arrive today, which statement is correct?
- Click IDs like fbclid and gclid are stripped only in Private Browsing, Mail, and Messages, while standard UTMs still pass in every context
- Standard UTMs are stripped everywhere, so stop tagging links
- Click IDs and UTMs are both stripped in normal non-private Safari as the current default
- Nothing is stripped anywhere, so the concern is pure myth
answer: 0
explain: Link Tracking Protection drops user-level click identifiers only in Private Browsing, Apple Mail, and Messages, while aggregate UTMs survive in all contexts, so keep UTM discipline and treat all-mode stripping as a roadmap risk.
:::

:::q Measurement and Signal
question: A store raises Purchase EMQ from below 6.0 to above 8.0 and picks up the documented lower-bound lift on a 1,000-conversion base. What likely drove the gain and roughly how many more conversions get attributed at +15%?
- Buying a new measurement vendor; about 850 more
- Sending more hashed identifiers like phone, name, and location; about 150 more
- Renaming the Purchase event; about 15 more
- Raising the budget; about 1,150 more
answer: 1
explain: EMQ rises by sending more strong customer parameters (hashed phone, name, location), and 1,000 x 0.15 = 150 additional attributed conversions at the same spend, a free performance lever before touching budget.
:::

:::q Measurement and Signal
question: After a Shopify theme update, the Meta-versus-Shopify gap jumps from 30% to 70% overnight while site CVR holds steady. The pixel's event_id format changed but CAPI's did not. What is the most likely cause?
- The funnel got more efficient and CVR should be celebrated
- iOS started stripping all UTMs that night
- Customers suddenly stopped adding to cart
- The dedup pair broke, so Pixel and CAPI now double-count Purchases
answer: 3
explain: A theme change commonly breaks the shared event_id between Pixel and CAPI, so the same Purchase is counted twice and the gap balloons past the normal band while real behavior, and therefore CVR, is unchanged.
:::

:::q Execution Core
question: Your target CPA is $35 and an ad set needs about 50 conversions in 7 days to exit learning. What minimum daily budget does that imply?
- About $143 per day
- About $175 per day
- About $250 per day
- About $1,750 per day
answer: 2
explain: Minimum daily budget is (50 x $35) / 7 = $1,750 / 7 = $250 per day, the pacing floor below which the ad set cannot buy 50 conversions a week and stays learning-limited.
:::

:::q Execution Core
question: You have $5,000 per week to test at a $20 target CPA, and each ad set needs about 50 conversions in 7 days to clear learning. What is the most ad sets you can run and still give each one enough budget?
- 10 ad sets
- 5 ad sets
- 7 ad sets
- 25 ad sets
answer: 1
explain: One ad set needs 50 x $20 = $1,000 per week, so $5,000 / $1,000 = 5 ad sets, and splitting the same budget across more cells starves each below 50 conversions and locks the campaign in learning limited.
:::

:::q Execution Core
question: A cost-cap campaign in an otherwise healthy account suddenly stops spending. An operator keeps lowering the cap and it gets worse. What is actually happening?
- The target CPA cap is set below the auction-clearing CPA, so delivery throttles
- The creative library is too large to deliver
- ASC always pauses after 50 conversions
- Meta only permits ROAS-goal bidding for DTC accounts
answer: 0
explain: Cost-cap only delivers when the target CPA is at or above the market-clearing CPA, so setting it below that throttles delivery to near zero, and lowering the cap further starves the campaign instead of fixing it.
:::

:::q Execution Core
question: An ASC campaign runs $40,000 per month and is drifting toward warm buyers and cannibalizing retargeting credit. You set the existing-customer allocation to 5%. How many dollars are reserved for prior purchasers, and what does the rest do?
- $20,000 reserved, leaving $20,000 for net-new
- $38,000 reserved, leaving $2,000 for net-new
- $4,000 reserved, leaving $36,000 for net-new
- $2,000 reserved, leaving $38,000 to hunt net-new customers
answer: 3
explain: $40,000 x 0.05 = $2,000 reserved for existing customers, leaving $38,000 (95%) to chase net-new buyers, which is how the trader keeps ASC honest as an acquisition engine rather than an expensive retargeting layer.
:::

:::q Creative-Testing Engine
question: A new video gets 100,000 impressions and 24,000 3-second views. How do you judge its hook rate against benchmark?
- 0.24%, a broken opener well below the floor
- 24%, inside the healthy 20% to 30% band, so move the diagnosis to hold rate
- 76%, an unrealistically high hook that signals a tracking error
- 24%, below the 15% Feed floor, so the first frame needs a rebuild
answer: 1
explain: Hook rate is 24,000 / 100,000 = 24%, which sits inside the 20% to 30% benchmark, so the opener is working and the next step is to read hold rate.
:::

:::q Creative-Testing Engine
question: An ad shows a 28% hook rate but only an 18% hold rate. What does that localize, and what is the fix?
- The first frame is weak, so rewrite the opener
- The audience is wrong, so narrow the targeting
- The opener works but the middle is weak, so rebuild the body and pacing
- The budget is too low, so raise spend to push past learning
answer: 2
explain: A strong hook with a weak hold means the first frame stops the scroll but the narrative does not hold viewers to ThruPlay, so the fix is the creative body, not targeting or budget, which ASC controls automatically.
:::

:::q Creative-Testing Engine
question: A previously winning ad shows climbing frequency, falling hook rate and CTR, and CPA that rose from $30 to $42. What is the diagnosis and the correct response?
- Creative fatigue (a 40% CPA jump), so replace it with fresh creative and graduate a new proven hook
- A learning-phase glitch, so pause and relaunch the identical creative
- Creative fatigue, so raise the budget to push more volume through it
- A bid-cap problem, so lower the cost cap to force CPA down
answer: 0
explain: Rising frequency with falling hook and CTR and a (42 - 30) / 30 = 40% CPA jump on the same ad is the textbook fatigue signature, and only fresh creative fixes it because more budget just pushes impressions onto a saturated audience.
:::

:::q Creative-Testing Engine
question: You want to scale a concept that cleared the hook and hold benchmarks. Why can you not simply drop that one new ad into an old, saturated ASC and expect it to revive?
- ASC ignores any ad with a hold rate above 40%
- ASC needs a deep, varied creative library continuously refreshed with graduated winners, not a single new asset
- New ads reset the learning phase for the entire ad account
- ASC only serves studio creative, never UGC
answer: 1
explain: Meta needs a deep, varied library to keep ASC fed, so winners are promoted into the library and dedicated scaling ad sets, and one new ad cannot revive an old saturated ASC on its own.
:::

:::q Incrementality and the Margin Ceiling
question: A retargeting line reports a 4.0x platform ROAS, but a conversion-lift holdout shows only 30% of those conversions are incremental. What is the iROAS and the call?
- 1.2x, barely above the 1.0x breakeven line, so it is a candidate to defund toward demand-creation channels
- 4.0x, so keep funding it as a top performer
- 0.3x, so it is clearly fraudulent and should be reported
- 5.2x, so increase its budget
answer: 0
explain: iROAS is 4.0 x 0.30 = 1.2x, only just above breakeven, so most of the headline ROAS was demand the brand would have captured anyway and the budget is better moved to channels that genuinely lift the baseline.
:::

:::q Incrementality and the Margin Ceiling
question: A conversion-lift test shows the exposed group converting at 1.5% and the held-out control at 0.5%. What is the incrementality percentage, and what does the control rate represent?
- 33% incremental, and the control rate is the platform over-reporting error
- 50% incremental, and the control rate is the bot fraction
- 67% incremental, and the 0.5% control rate is baseline demand that would have converted with no ads
- 100% incremental, and the control rate is creative fatigue
answer: 2
explain: Incrementality is (1.5% - 0.5%) / 1.5% = 67%, and the control group never saw the ads, so its 0.5% conversion is the baseline demand that exists without spend.
:::

:::q Incrementality and the Margin Ceiling
question: A brand acquires customers at a blended CAC of $48 with monthly contribution margin per customer of $16. It has an elite 5:1 LTV:CAC but no outside funding. What is the payback, and why can it still get into trouble?
- 3 months payback, and a strong LTV:CAC guarantees it scales smoothly
- 3 months payback, fundable, but a thin margin means the ratio is wrong
- 0.33 months payback, so cash is never a constraint
- 3 months payback, and at this speed the cash cycle can fund scaling, but if payback stretched to 24 months the ratio alone would not stop a cash-out
answer: 3
explain: Payback is $48 / $16 = 3 months, which the cash cycle can fund, but ratio and payback bind independently, so a great 5:1 ratio with a 24-month payback could still drain working capital and bankrupt a self-funded brand.
:::

:::q Incrementality and the Margin Ceiling
question: A one-time-purchase brand has an AOV of $58, a customer buys 3 times over their lifetime, and gross margin is 70%. Against a blended CAC of $48, what is the gross-margin LTV and the LTV:CAC ratio?
- LTV is $174 and the ratio is about 3.6:1, comfortably elite
- LTV is $121.80 and the ratio is about 2.5:1, below the 3:1 healthy floor
- LTV is $121.80 and the ratio is about 5:1, clearly elite
- LTV is $40.60 and the ratio is below 1:1
answer: 1
explain: Gross-margin LTV is $58 x 3 x 0.70 = $121.80, and $121.80 / $48 = 2.5:1, below the 3:1 floor, so using the $174 revenue figure would overstate the affordable CAC ceiling and greenlight unprofitable scaling.
:::

:::q Policy and Diversification
question: A supplement brand's Meta account is classified health and wellness overnight. Beyond losing lower-funnel conversion optimization, which capability is also lost, and does renaming the Purchase event help?
- The ability to run video ads is lost, and renaming Purchase restores optimization
- The ability to use CAPI is lost, and renaming Purchase fixes classification
- The ability to build custom audiences off conversion events is lost, and renaming Purchase does not help because Meta classifies on landing-page content and payload semantics
- The ability to spend above a fixed daily cap is lost, and renaming Purchase is a standard fix
answer: 2
explain: Classified accounts also lose conversion-based custom audiences, which kills purchaser lookalikes and cart-abandoner retargeting, and renaming Purchase changes nothing because Meta reads landing-page content, product meaning, and payload semantics rather than the event name.
:::

:::q Policy and Diversification
question: A restricted account can only optimize to an upper-funnel event. Link Click runs $0.90 with a 3% click-to-purchase rate, while Landing Page View runs $1.50 with a 5% LPV-to-purchase rate. Which should the trader pick and why?
- Link Click, because its $30 effective CAC beats LPV's higher cost per event
- Either one, because both land at a $30 effective CAC, so pick the higher-intent LPV as the safer signal
- Traffic, because it is always the cheapest event
- Neither, because upper-funnel optimization can never produce a measurable CAC
answer: 1
explain: Effective CAC is cost per allowed event divided by its purchase rate, so Link Click is $0.90 / 0.03 = $30 and LPV is $1.50 / 0.05 = $30, equal here, and the discipline is to optimize on the highest-intent allowed event rather than the cheapest click.
:::

:::q Policy and Diversification
question: A brand at Meta saturation considers off-Meta channels. TikTok Spark Ads cost $14.62 per acquisition versus $23.18 non-Spark, while a CTV test shows almost no last-click conversions. How should the trader judge each off-Meta dollar?
- Cut CTV immediately for weak last-click, and credit Spark's $8.56 per-acquisition saving on a last-click basis
- Judge both purely on platform-reported ROAS so the numbers are comparable
- Judge both on incremental ROAS and blended MER, measuring CTV with a geo holdout since it creates demand that converts later through other channels
- Scale whichever channel shows the highest in-platform ROAS regardless of blended MER
answer: 2
explain: Off-Meta dollars are judged on incremental ROAS and blended MER, not platform-reported ROAS, and CTV creates upstream demand that surfaces through branded search or direct, so a geo holdout is the honest way to size it rather than a last-click read it was never built to win.
:::

:::q Policy and Diversification
question: A brand already sells on the Amazon marketplace and is choosing a CTV supply path. Indicative 2026 CPMs are about $22 on Amazon DSP CTV versus $28 on The Trade Desk CTV. For this brand, which is the strongest reason to lead with Amazon DSP?
- TTD cannot serve CTV inventory at all
- Amazon DSP is the only channel that clears the learning phase
- Platform-reported ROAS is the right way to compare the two
- Closed-loop retail-media measurement tied to actual Amazon purchases, plus lower CPMs from direct supply and household frequency caps
answer: 3
explain: For a marketplace seller, Amazon DSP ties an impression to a real Amazon purchase for closed-loop measurement and frequently clears below TTD on CPM thanks to direct supply and household-level frequency caps, while TTD still offers the open internet, so the trader tests both and lets incremental ROAS decide.
:::
