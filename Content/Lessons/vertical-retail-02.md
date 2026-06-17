---
id: vertical-retail-02
track: vertical-retail
module: 2
title: The Buyer and the Mandate, Endemic Brands, the iROAS Mandate, and What "Good" Looks Like
summary: Tell apart the buyer who funds retail media from the dials they hand you, compute ROAS, ACoS, TACoS, iROAS and new-to-brand, and judge when a high closed-loop ROAS is actually weak.
---
# Who actually writes the check

The buyer behind almost every retail-media campaign is an endemic brand, a manufacturer whose products physically sell on the retailer, or the agency commerce team that runs the account for them. The budget is usually split across two profit-and-loss lines that do not talk to each other: a media P&L (advertising dollars) and a trade or shopper-marketing P&L (co-op, slotting, promotions). Increasingly the money is governed by a joint business plan (JBP), a yearly commitment where the retailer asks the brand to grow spend by a fixed percentage, and the trader inherits that mandate whether or not it is efficient.

Knowing which pocket funds a campaign tells you who you answer to and what "good" means: the media team wants efficiency, the shopper-marketing team wants shelf presence, and finance wants gross-margin dollars. The trader sits in the middle and translates all three into bids.

:::quiz
question: A campaign is funded out of the brand's trade / shopper-marketing P&L rather than its media P&L. What does that most directly change for the trader?
- Nothing, the auction mechanics are identical so funding source is irrelevant
- The success definition and stakeholder, since trade dollars chase shelf presence and merchandising goals more than pure media efficiency
- It forces the campaign onto off-site DSP inventory only
- It removes the requirement to report ROAS entirely
answer: 1
hint: The auction does not care which P&L paid, but the person grading you does.
explain: Funding source does not change the auction, but it changes who grades the work and how. Trade and shopper-marketing dollars are judged on shelf presence, distribution, and merchandising support, so the same ROAS print can be a pass for one stakeholder and a fail for another.
:::

# The dial set, ROAS, ACoS, and TACoS

The trader is handed three operational dials, and all three are about credited sales, not caused sales. ROAS is attributed sales divided by ad spend. ACoS (advertising cost of sale) is the exact inverse, ad spend divided by ad-attributed sales, so a 5x ROAS is a 20% ACoS and the two carry identical information. TACoS (total advertising cost of sale) widens the denominator to all brand sales, ad-driven plus organic, and is the one number that reveals whether advertising is building the brand or just renting demand.

$$ \text{ROAS} = \frac{\text{attributed sales}}{\text{ad spend}}, \quad \text{ACoS} = \frac{\text{ad spend}}{\text{attributed sales}} = \frac{1}{\text{ROAS}} $$

$$ \text{TACoS} = \frac{\text{ad spend}}{\text{total brand sales (ad} + \text{organic)}} $$

A falling TACoS over time is the real win, because it means organic sales are growing faster than the ad spend feeding them. A single high ROAS print says nothing about that trajectory.

:::predict
prompt: A campaign drives $50,000 in attributed sales on $5,000 of ad spend. What is the ACoS?
answer: 10
tolerance: 0.5
unit: %
hint: ACoS is ad spend divided by attributed sales.
explain: ACoS = 5,000 / 50,000 = 0.10, which is 10 percent. The equivalent ROAS is 50,000 / 5,000 = 10x, and 1 / 10 = 0.10 confirms the inverse relationship.
:::

:::predict
prompt: Ad-attributed sales are $20,000 and organic sales are $80,000, on $8,000 of ad spend. What is the TACoS?
answer: 8
tolerance: 0.5
unit: %
hint: Put ad spend over total brand sales, which is ad-attributed plus organic.
explain: Total brand sales = 20,000 + 80,000 = 100,000. TACoS = 8,000 / 100,000 = 0.08, which is 8 percent, comfortably inside the under-10-percent target cited for established products.
:::

# The signature KPI, iROAS

The metric that actually decides whether spend created value is iROAS (incremental ROAS), the return on only the sales the ad caused, measured against a control that never saw the ad. Closed-loop ROAS answers "what got credited"; iROAS answers "what would not have happened otherwise." Across advertisers, measured iROAS ranges from 253% to 1,609% (2.53x to 16.09x), and the practitioner read is blunt: an iROAS above 2.0 signals real incremental performance, while a value below 1.0 means you are mostly harvesting demand you already owned.

$$ \text{iROAS} = \frac{\text{incremental sales}}{\text{ad spend}} = \frac{\text{exposed sales} - \text{control sales}}{\text{ad spend}} $$

The gap between ROAS and iROAS is the whole lesson. A defensive branded-search campaign can post a gaudy closed-loop ROAS while its iROAS sits near zero, because most of those buyers were going to convert regardless. AMC lift studies put branded-search defense at only roughly 22% to 38% incremental conversion lift, which means 62% to 78% of those clicks would have purchased anyway.

:::predict
prompt: A new-to-brand campaign drives $24,000 in incremental sales (measured against a matched holdout) on $10,000 of ad spend. What is the iROAS?
answer: 2.4
tolerance: 0.05
unit: x
hint: iROAS is incremental sales divided by ad spend.
explain: iROAS = 24,000 / 10,000 = 2.4x. That clears the 2.0 bar for strong incremental performance, so even though the closed-loop ROAS of a conquesting campaign looks modest, the caused-sales return is real.
:::

:::callout key
ROAS and iROAS measure different things, and the gap is the job. Run both lines through iROAS = lift x ROAS: a 6x closed-loop ROAS on branded defense at 25% lift caves to 0.25 x 6 = 1.5x incremental, while a humbler 3x ROAS on conquesting at 80% lift holds up at 0.80 x 3 = 2.4x incremental. The dashboard-darling defense line has the higher closed-loop ROAS yet the lower caused-sales return, because most of it is demand you already owned. iROAS is a return, not a share, so judge the spend on 2.4x beating 1.5x, not on the raw ROAS leaderboard.
:::

# Reading the gap, when high ROAS is actually weak

To make the gap concrete, take a branded-defense campaign that reports $90,000 of attributed sales on $6,000 of spend, a 15x closed-loop ROAS that looks elite on any dashboard. Now apply a measured 25% incremental lift: only $22,500 of those sales were actually caused, so the iROAS is $22,500 / $6,000 = 3.75x. The dashboard number was four times the number that survives a holdout.

$$ \text{iROAS} = \frac{\text{lift} \times \text{attributed sales}}{\text{ad spend}} = \frac{0.25 \times 90{,}000}{6{,}000} = 3.75\text{x} $$

This is why a trader cannot judge a campaign on closed-loop ROAS alone. The same dollar of branded-defense spend and a dollar of new-to-brand conquest spend can show wildly different incremental returns, which is exactly what cross-platform iROAS measurement reveals.

:::widget barChart
title: Closed-loop ROAS vs measured iROAS, branded defense
labels: Closed-loop ROAS, Incremental-only iROAS
data: 15, 3.75
unit: x
:::

:::predict
prompt: A branded-defense campaign reports $90,000 attributed sales on $6,000 spend (a 15x closed-loop ROAS), but an AMC holdout shows only 30% of those sales were incremental. What is the iROAS?
answer: 4.5
tolerance: 0.1
unit: x
hint: First find incremental sales as 30 percent of attributed sales, then divide by ad spend.
explain: Incremental sales = 0.30 x 90,000 = 27,000. iROAS = 27,000 / 6,000 = 4.5x. Even at the higher end of the branded-defense lift band, the caused-sales return is a fraction of the 15x closed-loop print.
:::

# New-to-brand, the cleanest acquisition signal

New-to-brand (NTB) measures the share of orders from shoppers who have not bought the brand in the lookback window, and it is the closest operational proxy for real acquisition because it strips out the customers you already had. A high NTB percentage on a conquesting or upper-funnel campaign is strong evidence the spend is incremental, even when its raw ROAS looks worse than a branded-defense line.

$$ \text{New-to-brand \%} = \frac{\text{NTB orders}}{\text{total attributed orders}} $$

NTB has limits worth stating: it only counts first purchases within that one retailer, not first purchases of the brand across all of life, so a loyal Amazon buyer's first Walmart order can read as "new." Used with iROAS, though, it separates campaigns that grow the franchise from campaigns that re-bill existing demand.

:::figure tradeVsMedia
caption: The buyer's money splits across a media P&L and a trade / shopper-marketing P&L, and the same campaign is graded differently depending on which pocket funded it and whether the goal is efficiency or incremental acquisition.
:::

:::predict
prompt: A campaign posts 120 new-to-brand orders out of 400 total attributed orders. What is the new-to-brand percentage?
answer: 30
tolerance: 0.5
unit: %
hint: Divide NTB orders by total attributed orders.
explain: NTB% = 120 / 400 = 0.30, which is 30 percent. On a conquesting campaign that 30 percent NTB share is a strong incrementality signal even if the closed-loop ROAS trails a branded-defense line.
:::

# Benchmarks and what "good" really means

Retail media has held a roughly 6.1x ROAS benchmark for five-plus consecutive quarters, with branded-keyword campaigns reaching 5x to 8x or higher and non-brand campaigns running lower. For established products the target TACoS sits under 10% (often quoted as an 8% to 15% healthy band), while a new launch intentionally runs a much higher TACoS because you are buying share before organic demand exists. So "good" is contextual: it depends on the campaign's strategic role and the funnel stage, not one universal number.

The chart below is the trap in a single picture. Closed-loop ROAS climbs as you move toward branded defense, but iROAS moves the opposite way, so the campaign that looks best on the dashboard is often the weakest on caused sales.

:::widget barChart
title: Closed-loop ROAS vs iROAS by campaign role
labels: Branded defense, Category / non-brand, Conquesting, New-to-brand
data: 12, 4, 2.5, 2
unit: x
:::

:::quiz
question: A branded-defense campaign shows 12x closed-loop ROAS but an AMC lift test returns only 28% incremental lift. What is the correct read for budget allocation?
- Scale it hard, since 12x ROAS is elite and proves the spend is working
- Treat it as mostly harvesting owned demand and consider cutting or capping it, reallocating toward higher-lift new-to-brand spend
- Switch the attribution window to 30 days to make the iROAS look better
- Leave it untouched because branded terms must always be defended at any cost
answer: 1
hint: A 28% lift means roughly 72% of those clicks would have converted with no ad at all.
explain: At 28% lift, about 72% of those sales were free, so the true iROAS is a small fraction of the 12x print. The documented move is to cut or cap low-lift branded defense and reallocate toward new-to-brand and conquesting, where incremental return is higher.
:::

# The JBP trap and the ROAS lie

Two structural traps sit on top of the math. First, the JBP mandate: Walmart has asked CPG brands to raise retail-media spend by at least 25% year over year (some requests reached 50%) even when the brand's sales are flat, which forces the trader to deploy budget past the efficient frontier and drag blended ROAS down. Second, the "ROAS lie": clients hold traders to closed-loop ROAS while it systematically overstates true contribution, so the dashboard rewards exactly the branded-defense spend that incrementality testing says to cut.

A trader who only optimizes the dial they are handed (ROAS or ACoS) will pour budget into low-iROAS branded defense and call it a win. The job is to hit the blended efficiency target while growing the incremental and new-to-brand share underneath it.

:::predict
prompt: A trader runs $100,000 at an efficient 8x blended ROAS. A JBP mandate forces an extra $25,000 of spend, but that incremental tranche sits past the efficient frontier and clears only 2x. What is the new blended ROAS across all $125,000?
answer: 6.8
tolerance: 0.1
unit: x
hint: Add the attributed sales from both tranches, then divide by total spend of $125,000.
explain: Efficient tranche sales = 100,000 x 8 = 800,000. Mandated tranche sales = 25,000 x 2 = 50,000. Blended ROAS = (800,000 + 50,000) / 125,000 = 850,000 / 125,000 = 6.8x. The mandate dragged blended ROAS from 8x down to 6.8x, which is exactly why the inefficient dollars get ring-fenced and reported on their own iROAS so the deal's drag is not blamed on day-to-day optimization.
:::

:::quiz
question: A JBP forces $25,000 of spend past the point where it stays efficient, dropping blended ROAS from 8x to 6.8x. What is the defensible trader move?
- Spread the mandated dollars evenly across every existing campaign so the drag is invisible in the blended number
- Ring-fence the mandated spend in its own campaigns and report its iROAS separately, so the deal's inefficiency is not blamed on day-to-day optimization
- Refuse to deploy the mandated budget and let the JBP commitment lapse
- Switch all reporting to closed-loop ROAS so the mandated spend looks stronger than it is
answer: 1
hint: You cannot un-sign the JBP, but you can keep its cost from contaminating the numbers you are actually graded on.
explain: The mandate is a contractual commitment, so the budget gets deployed, but burying it in the blended number hides which dollars were efficient and which were forced. Ring-fencing the mandated spend into its own campaigns and reporting that tranche's iROAS separately keeps the deal's drag attributable to the deal, not to the trader's optimization, and gives finance a clean read on the cost of the JBP itself.
:::

:::callout warning
Operators report Walmart pushing 25%-plus JBP spend increases despite stagnant sales, and brands are starting to "call their bluff" and walk away from the deals, with one buyer summarizing the pushback as "my pot hasn't changed." When a JBP forces spend past the efficient frontier, ring-fence the mandated dollars in their own campaigns and report their iROAS separately, so the inefficiency the deal imposed does not get blamed on your day-to-day optimization.
:::

:::sources
- Dataslayer, Incrementality becomes the primary KPI for retail media advertisers | https://www.dataslayer.ai/blog/incrementality-becomes-the-primary-kpi-for-retail-media-advertisers
- Osmos, Best Retail Media ROAS 2026: Platform & Industry Benchmarks | https://www.osmos.ai/blog/roas-benchmarks-platform-ad-format-2026
- Velocity Sellers, Amazon Marketing Cloud (AMC) for Mid-Size Brands in 2026 | https://www.velocitysellers.com/2026/05/18/amazon-marketing-cloud-mid-size-brands-2026/
- Digiday, "We've got to call their bluff": advertisers pull out of retail media negotiations | https://digiday.com/marketing/weve-got-to-call-their-bluff-amidst-retail-media-spend-scrutiny-advertisers-pull-out-of-negotiations/
- Adweek, Walmart asks brands to boost ad spend by at least 25% despite sales stagnation | https://www.adweek.com/media/walmart-asks-brands-to-boost-ad-spend-by-at-least-25-despite-sales-stagnation/
- The Drum, 83% of retail media campaigns can be gamed on iROAS, here's how | https://www.thedrum.com/opinion/83-of-retail-media-campaigns-can-be-gamed-on-iroas-here-s-how
- Skai, What is iROAS and why it matters for retail media performance | https://skai.io/blog/what-is-iroas/
:::
