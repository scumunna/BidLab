---
id: vertical-ecommerce-06
track: vertical-ecommerce
module: 6
title: Incrementality and MER, proving the media actually caused the sales
summary: Use MER and geo holdouts to separate media that truly causes sales from platform ROAS that merely claims credit, then re-base bid targets on incremental CAC.
---
# Why platform ROAS overstates your impact

Every platform reports a ROAS that flatters itself because it claims conversions it only observed. Retargeting and brand-term campaigns recapture demand that would have converted anyway, and post-ATT modeled conversions estimate rather than measure, so the number you read in the dashboard is an upper bound on real impact, not the truth. The buy-side job is to treat platform ROAS as a claim to verify, not a result to bank. The two tools that do the verifying are MER (a blended top-line check) and incrementality testing (a causal measurement), and the rest of this lesson builds both.

The scale of the gap is not subtle. The ANA's Q2 2025 Programmatic Transparency Benchmark found that only about 36.5% of programmatic spend met standard quality metrics, which means a large slice of "delivered" impressions never had a fair chance to drive the sales a platform later took credit for.

:::predict
prompt: The ANA's Q2 2025 benchmark found about 36.5% of programmatic spend met standard quality metrics. On a $200,000 programmatic budget, how many dollars cleared that quality bar?
answer: 73000
tolerance: 500
unit: USD
hint: Take 36.5% of the budget.
explain: 200,000 times 0.365 equals 73,000. Only about 73,000 dollars of the 200,000 cleared the quality bar, so the rest is impressions a platform can still claim ROAS credit for without ever having a fair chance to drive a sale. That gap is exactly why platform ROAS is a claim to verify, not a result to bank.
:::

:::callout key
Platform ROAS is an input you manage and a claim you verify. MER and incrementality are the scoreboard. If a campaign posts a 6:1 platform ROAS but a holdout shows it barely lifts sales, the 6:1 is noise dressed as signal.
:::

# MER, the number attribution cannot inflate

MER (Marketing Efficiency Ratio) is total revenue divided by total ad spend across every channel, so it ignores who claimed each sale and cannot be gamed by attribution windows or double-counting. Where summed platform-claimed revenue can exceed your actual revenue (Meta, Google, and Amazon all booking the same purchase), MER is anchored to one honest denominator: the money that actually landed in the bank. It is blunt, it does not tell you which channel worked, but it is the one figure a CFO can trust without an attribution argument.

$$ \text{MER} = \frac{\text{Total revenue (all channels)}}{\text{Total ad spend (all channels)}} $$

:::predict
prompt: Total revenue across all channels is $500,000 and total ad spend is $125,000. What is MER (to one decimal place)?
answer: 4
tolerance: 0.05
unit: x
hint: Divide total revenue by total ad spend.
explain: MER = 500,000 / 125,000 = 4.0x. Every $1 of ad spend is associated with $4 of total revenue. Note this is a top-line ratio, not a profit measure, and it makes no claim about causation, it just cannot be inflated by attribution.
:::

# The incrementality test: holdouts and lift

Incrementality measures the sales the media actually caused by comparing a test group that saw the ads against a matched control group that did not. The cleanest buy-side method is a geo holdout: turn media off in a set of matched markets, leave it on in comparable markets, and the difference in conversions is your causal lift. PSA or ghost-bid tests (serving a placebo to the control) and platform conversion-lift studies do the same thing at the user level. The output is an incrementality percentage: of the conversions the platform reported, what share would not have happened without the ad.

$$ \text{Incrementality \%} = \frac{\text{Exposed conversions} - \text{Control conversions}}{\text{Exposed conversions}} $$

:::figure incrementalityHoldout
caption: A geo holdout splits matched markets into exposed and control. The control conversions are the baseline that would have happened anyway, and only the gap above it is the lift the media truly caused.
:::

:::predict
prompt: A geo holdout shows 10,000 conversions in exposed markets and 8,300 in matched control markets. What share of exposed conversions is incremental (to the nearest whole percent)?
answer: 17
tolerance: 0.5
unit: %
hint: Subtract control from exposed, then divide by exposed.
explain: Incrementality = (10,000 - 8,300) / 10,000 = 1,700 / 10,000 = 0.17, so about 17% of reported conversions are truly incremental. The other 8,300 would have converted with no media at all. This 17% figure matches a real apparel-brand test on Meta Advantage+ Shopping.
:::

# From incrementality to incremental CAC

Once you know the incremental share, you re-base CAC on the customers the media actually caused, not the ones the platform claimed. Platform-reported CAC divides spend by all attributed conversions and looks great; incremental CAC divides the same spend by only the truly caused conversions and tells you what acquisition really cost. The gap between the two is the single most important correction a trader makes, because bid targets set on platform CAC will overpay for demand you already had.

$$ \text{Incremental CAC} = \frac{\text{Ad spend}}{\text{Incremental new customers}} $$

:::predict
prompt: Only 17% of 10,000 reported conversions are incremental and the spend was $85,000. What is the incremental CAC (to the nearest dollar)?
answer: 50
tolerance: 1
unit: USD
hint: First find incremental conversions (17% of 10,000), then divide spend by that.
explain: Incremental conversions = 0.17 x 10,000 = 1,700. Incremental CAC = 85,000 / 1,700 = $50. The platform would report CAC = 85,000 / 10,000 = $8.50, understating true acquisition cost by nearly 6x. Bidding to the $8.50 number would torch margin.
:::

:::quiz
question: Why can summing the revenue each platform claims overstate a brand's actual total revenue?
- Platforms undercount conversions to appear conservative
- Multiple platforms each claim credit for the same purchase
- MER always exceeds the sum of platform ROAS figures
- Returns are added back into platform revenue
answer: 1
hint: Think about a single purchase that a shopper saw on more than one channel before buying.
explain: A shopper often touches Meta, Google, and Amazon before one purchase, and each platform's attribution can claim that same sale, so the claimed revenues sum to more than what actually came in. MER sidesteps this entirely by dividing one real revenue figure by total spend.
:::

# Re-basing the LTV:CAC north star on incremental CAC

The vertical's north star is LTV:CAC, and incrementality is what keeps it honest. A ratio built on platform-reported CAC can look healthy while the business loses money, because the denominator is too small. Recompute the ratio on incremental CAC and the picture often flips, which is exactly the conversation a trader must bring to the QBR rather than letting the platform dashboard tell the story.

$$ \text{LTV:CAC}_{\text{true}} = \frac{\text{Gross-margin LTV}}{\text{Incremental CAC}} $$

:::predict
prompt: Gross-margin LTV is $160 and platform-reported CAC is $40, but a holdout shows only 50% of conversions are incremental. What is the true LTV:CAC ratio?
answer: 2
tolerance: 0.05
unit: ratio (x:1)
hint: Incremental CAC is the platform CAC divided by the incremental share. Then divide LTV by that.
explain: Incremental CAC = 40 / 0.50 = $80. True LTV:CAC = 160 / 80 = 2.0:1. The platform-reported ratio looked like 160 / 40 = 4.0:1, comfortably above the ~3:1 target, but the honest ratio is below it. Scaling that "winner" would have deepened the loss.
:::

# Where this bites: PMax, brand terms, and the cannibalization debate

The classic offenders are the campaigns that post the best platform ROAS precisely because they recapture existing demand. Performance Max is the headline example: an Optmyzr study of 500-plus accounts found PMax cannibalized Search in about 73% of accounts and cost roughly 34% more per conversion on average, meaning much of its "incremental" volume was Search demand re-bought at a premium. The same logic settles the Amazon paid-versus-organic debate from the efficiency lesson: a brand-term holdout reveals how much Sponsored Brands defense is buying sales the listing would have won organically. Even vendor incrementality claims (Meta's own meta-analysis reports about 32% lower cost per incremental conversion when ASC runs alongside manual) need independent geo or holdout validation before you act on them.

:::predict
prompt: A Search campaign acquires conversions at $25 each. PMax is added and cannibalizes Search while costing about 34% more per conversion. What is the approximate PMax cost per conversion (to the nearest dollar)?
answer: 34
tolerance: 1
unit: USD
hint: Increase $25 by 34%.
explain: 25 x 1.34 = $33.50, about $34 per conversion. You are paying roughly $8.50 more per conversion for volume that a geo or brand-term holdout would likely show was largely Search demand you already owned. The cannibalization is invisible in platform ROAS and only surfaces in a holdout.
:::

:::quiz
question: A retargeting campaign posts your highest platform ROAS. What is the most likely reason a trader treats that with suspicion?
- Retargeting CPMs are too low to be trusted
- Retargeting cannot be measured with a geo holdout
- It recaptures demand that would have converted anyway, so its incremental lift is often small
- Platform ROAS is always accurate for retargeting
answer: 2
hint: Who are you showing retargeting ads to, and how close were they to buying already?
explain: Retargeting hits people who already added to cart or viewed the product, so many would convert with no ad at all. That inflates platform ROAS while true incremental lift stays low, which is why stripping retargeting and brand search out is required to see honest incremental CAC.
:::

# The scorecard you bring to the CFO

The buy-side answer to inflated ROAS is a scorecard the finance team trusts: contribution margin, blended CAC, MER, new-customer share, and incrementality results, not platform ROAS in isolation. Run geo holdouts on enough matched markets and over enough duration to clear seasonality and conversion lag, because a too-short test reads noise as lift. Then re-base every bid target on incremental CAC so next quarter's spend chases sales the media actually causes.

:::widget barChart
title: Reported conversions vs truly incremental (apparel ASC holdout)
labels: Platform-claimed, Truly incremental
data: 100, 17
unit: index
:::

:::callout warning
A recurring operator pain point: traders get told to "scale the 4x-ROAS campaigns," then a geo test later shows those campaigns were barely incremental. Founders resist holdouts because "turning off winning media" feels wrong, even when the media is not causing the sales. Run the small holdout first; it is far cheaper than scaling spend into demand you already own.
:::

:::sources
- Optmyzr, Is Performance Max Cannibalizing Your Search Campaigns? | https://www.optmyzr.com/blog/is-pmax-cannibalizing-search/
- AdExchanger, For Meta Marketers, Automation Isn't Always The Advantage | https://www.adexchanger.com/measurement/for-meta-marketers-automation-isnt-always-the-advantage-but-its-complicated/
- ANA, Q2 2025 Programmatic Transparency Benchmark | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
- Stella, How to Conduct an Incrementality Study on Meta's ASC Campaigns | https://www.stellaheystella.com/blog/how-to-conduct-an-incrementality-study-on-metas-asc-campaigns-advantage-shopping-campaigns
- Finsi, LTV:CAC Ratio Explained: What 3:1 Means and When It Lies | https://www.finsi.ai/blog/ltv-cac-ratio-explained/
- EMARKETER, FAQ on Retail Media Networks: How Marketers Should Allocate Budgets in 2026 | https://www.emarketer.com/content/faq-on-retail-media-networks-how-marketers-should-allocate-budgets-2026
:::
