---
id: vertical-auto-01
track: vertical-auto
module: 1
title: The Money Map, Auto's Three-Tier Programmatic Landscape
summary: Place yourself in the correct dealer tier and read the auto ad-spend map so you know which KPI, supply, and co-op rules govern your buy before you build a single line item.
---
# The first question, which tier am I trading for

Before you touch a DSP, you have to know which of three tiers you are buying for, because the KPI, the supply, and the co-op rules all change by tier. Tier 1 is the OEM national brand (think a Toyota or Ford corporate buy running CTV, video, and display at scale through The Trade Desk, Amazon DSP, or DV360). Tier 2 is the regional dealer-association co-op, a group of stores in a metro pooling money to drive traffic to local dealers. Tier 3 is the individual rooftop, one dealership running inventory-level campaigns, and it is the most common entry point for a new trader. Getting this wrong is not a style choice. A Tier 1 awareness mandate graded on reach and a Tier 3 mandate graded on net cost per sale are different jobs that happen to share a DSP login.

The tiers are not interchangeable, and that is the trap most new hires fall into. You cannot lift a polished Tier 1 OEM brand creative and drop it into a Tier 3 rooftop campaign without re-clearing co-op compliance, because the disclaimers, pricing rules, and tier alignment differ, and a mismatch gets the dealer's reimbursement claim denied. Your orientation step on day one is to answer, in one sentence, who the buyer is and which tier funds this budget.

:::figure dealerTiers
caption: The three tiers of auto programmatic. Tier 1 is OEM national brand at scale, Tier 2 is the regional dealer-association co-op, and Tier 3 is the single-rooftop inventory buy where most traders start. KPI, supply, and co-op rules all change as you move down the stack.
:::

:::callout key
The single most useful sentence you can say in your first week is "I am trading Tier 3 for this rooftop, so I am graded on net cost per sale and I have to keep every creative co-op-compliant." Tier defines everything downstream. If you cannot name your tier, you do not yet know your job.
:::

# Reading the money map, size and the digital majority

US dealer ad spend hit $9.96B in 2025, and 74.9% of it was digital versus 25.1% traditional, per NADA's 2025 data surfaced through DealershipGuy and Inside Radio. That digital majority is the whole reason a programmatic trader has a seat at this table. The math is simply the digital share times the total: $9.96\text{B} \times 0.749 \approx \$7.46\text{B}$ flowing through digital channels in a single year. The rest, about a quarter, still lives in TV, radio, and direct mail, which matters because the dealer principal grew up on those channels and will compare your numbers to them.

Knowing the headline figure is not enough. You have to attribute it to the right house, because citing NADA's $9.96B as if it came from Borrell (who publishes a separate, differently scoped auto outlook) is a credibility failure in front of a dealer principal who has heard both. Sourcing precision is part of the job, not a footnote.

:::predict
prompt: US dealer ad spend is $9.96B and 74.9% of it is digital. How many dollars are digital?
answer: 7460040000
tolerance: 5000000
unit: USD
hint: Multiply total spend by the digital share.
explain: 9,960,000,000 times 0.749 = 7,460,040,000, about $7.46 billion. The other 25.1% (roughly $2.50 billion) is still traditional TV, radio, and direct mail.
:::

:::widget donutChart
title: 2025 dealer digital ad-spend mix (share of total dealer spend)
labels: SEM, Social, Television, Radio, Direct Mail, Other
data: 20, 14.2, 10.5, 6.9, 5.6, 42.8
unit: %
:::

# Where the digital dollars sit, the channel mix

Inside that digital majority, search and social lead. SEM is roughly 20% of total dealer spend (one in five dollars), social is 14.2% (up from 12.7% in 2024), TV is 10.5% (about $1B), and radio is 6.9% ($687.2M), per NADA via Inside Radio. As a programmatic trader you live mostly in the display, video, and CTV slices that sit alongside SEM and social, but you must know the whole board because budget gets shifted across these lines mid-quarter and you will be asked to defend why your slice deserves its share. The dollar figure for any line is just its share times the $9.96B base: SEM at 20% is $9.96\text{B} \times 0.20 = \$1.992\text{B}$.

The other number to keep in your pocket is unit economics. NADA reports the average dealer spent $739 per vehicle sold in 2025, up $34 year over year, the largest jump since 2022. That per-vehicle figure is the bridge between the abstract billions and the one rooftop you actually run, because it sets the dealer's gut expectation for what a sale "should" cost in media before co-op.

:::predict
prompt: SEM is about 20% of the $9.96B total dealer ad spend. What is SEM spend in dollars?
answer: 1992000000
tolerance: 5000000
unit: USD
hint: Take 20% of the total spend.
explain: 9,960,000,000 times 0.20 = 1,992,000,000, just under $2 billion. SEM alone is roughly one in five dealer ad dollars, which is why search and programmatic budgets are always fighting over the same line.
:::

:::quiz
question: A dealer principal says "I read that Borrell pegs dealer ad spend near ten billion with three quarters digital." You sourced the $9.96B / 74.9% figure from NADA. What is the correct move?
- Agree and repeat it as a Borrell figure to match the principal
- Politely correct the attribution to NADA, since Borrell publishes a separate, differently scoped outlook
- Drop the number entirely because two sources disagree
- Quote the figure but refuse to name any source
answer: 1
hint: The figure is real, but the house that published it matters.
explain: The $9.96B at 74.9% digital is NADA's 2025 data (via DealershipGuy and Inside Radio). Borrell publishes a separate, differently scoped auto outlook, so attributing NADA's number to Borrell is a sourcing error that costs you credibility. Correct the house, keep the number.
:::

# The headwind, a tariff-driven contraction

You are walking into this vertical during a squeeze, and that changes how you pace and how you talk to the dealer. eMarketer cut its US automotive digital ad-spend growth forecast to roughly 2.2% for 2025 (about $22.25B), down from an earlier 11%-plus expectation, on tariff pressure. Cox Automotive's January 6, 2026 outlook then forecast 2026 new-vehicle sales at 15.8M, down from 2025's roughly 16.3M result (reported in Cox's separate December 2025 release). Fewer cars sold and slower ad-spend growth mean every dollar is under acute efficiency pressure, which is exactly why the net-cost-per-sale KPI rules this vertical.

The operational consequence is that budgets get cut mid-flight. A pacing plan built on a stable monthly budget breaks the moment a tariff headline lands and the dealer principal pulls 20% of the spend, so you will re-pace more often here than in a growth vertical. Treat every budget as provisional until the month closes.

:::predict
prompt: Cox forecasts 15.8M new-vehicle sales for 2026 against roughly 16.3M in 2025. How many fewer new vehicles is that?
answer: 500000
tolerance: 1000
unit: vehicles
hint: Subtract the 2026 forecast from the 2025 result.
explain: 16,300,000 minus 15,800,000 = 500,000 fewer new vehicles forecast for 2026. A shrinking unit base is the headwind behind the whole vertical's efficiency squeeze, and it is why the dealer principal cares only about cost per sale.
:::

:::widget barChart
title: Auto digital ad-spend growth, forecast revised down on tariffs
labels: Earlier 2025 forecast, Revised 2025 forecast
data: 11, 2.2
unit: % growth
:::

# What good looks like, the KPI you will be graded on

The signature KPI in auto is net cost per sale: total media spend net of co-op reimbursement, divided by VIN-matched units sold. It forces you past clicks and leads to the only number the dealer principal cares about, units on the lot that titled. The formula is

$$ \text{Net cost per sale} = \frac{\text{media spend} - \text{co-op reimbursement}}{\text{VIN-matched units sold}} $$

The "net of co-op" part is load-bearing. OEM co-op typically reimburses 50% of standard digital and up to 75% for approved-vendor programs, so a compliant claim can roughly halve your effective cost per sale, and a denied claim silently doubles it. This is why later lessons on co-op compliance QA (module 9) and VIN matchback (module 8) are not side quests, they directly defend this number.

:::predict
prompt: Media spend is $10,000, co-op reimburses 50% of it, and VIN matchback shows 20 titled sales. What is the net cost per sale?
answer: 250
tolerance: 1
unit: USD
hint: Net the spend down by the co-op share first, then divide by sales.
explain: Co-op covers 50% of $10,000, so net media spend is $5,000. Divide by 20 VIN-matched sales: 5,000 / 20 = $250 net cost per sale. The same gross spend with a denied claim would be 10,000 / 20 = $500, double the number.
:::

:::predict
prompt: An approved-vendor program reimburses 75%. You spend $12,000 gross and VIN matchback confirms 15 sales. What is the net cost per sale?
answer: 200
tolerance: 1
unit: USD
hint: Subtract the 75% co-op, then divide the remaining spend by matched sales.
explain: 75% of $12,000 is $9,000 reimbursed, leaving $3,000 net. Divide by 15 VIN-matched sales: 3,000 / 15 = $200 net cost per sale. The higher approved-vendor co-op rate is why which vendor you run through changes your headline number.
:::

# Why the tier framing is the whole job

Everything you do downstream inherits from the tier you placed yourself in at the top. Tier 1 trades CTV, video, and display at national scale and is judged on reach and brand lift. Tier 2 co-op pools regional money to send shoppers to a group of stores. Tier 3 builds inventory-level line items, targets the rooftop's local market, paces against co-op windows, and is graded on net cost per sale. Confuse the tiers and you grade a campaign on the wrong KPI, buy the wrong supply, and break co-op rules that were never meant for your tier.

The dealer also counts a parallel "spend" line you do not control: third-party listing sites like Cars.com and AutoTrader, whose cost per sale your programmatic numbers get judged against. Knowing where you sit on the money map lets you frame that comparison honestly instead of being blindsided when the principal puts your CPS next to a portal invoice.

:::callout warning
A recurring operator complaint on DealerRefresh is that budgets get set by the dealer principal's gut, not by any tier strategy, so the trader inherits a mixed Tier 2 / Tier 3 bag with conflicting goals (drive group awareness and prove rooftop sales from the same dollars). Worse, "fire your PPC vendor if nothing changed in four years" threads show dealers convinced agencies waste spend on aged, mispriced inventory and competitor-name keywords out of fear. If you cannot articulate the tier and the KPI a budget is funding, you inherit the blame for both halves of a strategy that was never coherent.
:::

:::quiz
question: A new client hands you "the marketing budget" with no tier named, asking for both metro-wide brand awareness and provable units sold at one rooftop from the same pool. What is the right first step?
- Start spending immediately on broad display to show activity
- Split and name the budget by tier and KPI before building, since one pool cannot serve a Tier 2 awareness goal and a Tier 3 sales goal cleanly
- Optimize everything to last-click sales to keep it simple
- Refuse the account because the goals conflict
answer: 1
hint: The pain point is a mixed Tier 2 / Tier 3 bag with conflicting goals.
explain: A single undifferentiated pool graded two ways is the classic mixed-tier trap. The fix is to separate and label the money by tier and KPI up front (Tier 2 graded on consideration and reach, Tier 3 graded on net cost per sale) so each half is judged on the right number. Refusing the account is unnecessary, and spending blind or forcing last-click only deepens the trap.
:::

:::sources
- DealershipGuy, Dealer ad spend nears $10 billion as digital marketing dominates (NADA 2025 data) | https://news.dealershipguy.com/p/dealer-ad-spend-nears-10-billion-as-digital-marketing-dominates
- Inside Radio, Auto Dealer Ad Spend Nears $10B; Radio Still Delivers (NADA figures) | https://www.insideradio.com/free/auto-dealer-ad-spend-nears-10b-radio-still-delivers/article_f4547706-4d28-4128-a34d-549328c32802.html
- Cox Automotive, Cox Automotive Forecasts 2026 New-Vehicle Sales at 15.8 Million (Jan 6, 2026) | https://www.coxautoinc.com/insights/cox-automotive-2026-outlook/
- Cox Automotive, Forecast Dec 2025: New-Vehicle Sales to Reach 16.3 Million in 2025 | https://www.coxautoinc.com/insights/cox-automotive-forecast-dec-2025-u-s-auto-sales-forecast/
- Foundry CRO, Automotive Marketing Benchmarks 2026: CPC to Cost per Sale | https://foundrycro.com/blog/automotive-marketing-benchmarks-2026/
- Demand Local, How to Ensure OEM Compliance in Your Automotive Marketing Campaigns | https://www.demandlocal.com/blog/oem-compliance-automotive-marketing-campaigns/
- DealerRefresh, Why are third parties running Google VLA ads on MY vehicles? Shut it down! | https://forum.dealerrefresh.com/threads/why-are-third-parties-running-google-vla-ads-on-my-vehicles-shut-it-down.9894/
:::
