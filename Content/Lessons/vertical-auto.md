---
id: vertical-auto
track: auto
module: 1
title: Auto: three tiers, co-op money, and the real cost of a lead
summary: How automotive media works across OEM, dealer-association, and dealer tiers, why co-op reimbursement changes net cost, and why a quoted CPL hides the true cost per qualified lead.
---
# A market built in three layers

US automotive digital ad spend was around $22.25B in 2025, up roughly 2.2 percent year over year, per eMarketer reporting carried by Adweek and Marketing Dive. That was one of the largest downward revisions in the forecast, driven by tariff uncertainty. Dealer-level (Tier 3) ad spend reached close to $9.96B in 2025, and about 74.9 percent of that dealer spend went to digital.

What makes auto distinctive is not the size. It is the structure. Auto media is bought across three tiers that answer to different goals, different funders, and different success metrics.

:::predict
prompt: Tier 3 dealer ad spend was about $9.96 billion, and 74.9% of it went to digital. How many billions of dollars of dealer spend went to digital?
answer: 7.46
unit: $
tolerance: 0.1
hint: Take 74.9% of the $9.96 billion dealer total.
explain: Digital dealer spend = $9.96B x 0.749 = about $7.46B. The dealer (Tier 3) layer is where most performance dollars sit, and three quarters of them are already digital.
:::

# The OEM, the association, and the dealer

Tier 1 is the national original equipment manufacturer (OEM). It funds brand and awareness work, measured on reach and lift. Tier 2 is the regional dealer association, pooling member funds for regional offers in a hybrid of brand and performance. Tier 3 is the individual dealer, the performance layer, advertising specific inventory and a specific store. Its metrics are concrete: vehicle detail page (VDP) views, leads, calls, and store visits.

The money also flows between tiers. OEM co-op programs reimburse a dealer's eligible Tier 3 spend, flowing from the manufacturer down to the dealer, sometimes up to 100 percent of eligible spend.

:::callout insight
The same dollar means different things at different tiers. A Tier 1 impression is bought for lift. A Tier 3 impression is bought for a VDP view that turns into a lead that turns into a sale. Never judge a Tier 3 campaign by a Tier 1 metric.
:::

:::figure supplyChain
caption: Auto media flows across three tiers. OEM brand budget at Tier 1, pooled regional dollars at Tier 2, and the individual dealer at Tier 3, with OEM co-op money flowing down to reimburse eligible Tier 3 spend.
:::

# Co-op reimbursement and net cost

Because the manufacturer reimburses eligible spend, the number that actually leaves the dealer's pocket is net of co-op. Co-op reimbursement equals eligible spend times the co-op rate. Net Tier 3 cost is gross spend minus that reimbursement.

$$ Net\ cost = Gross\ spend - (Eligible\ spend \times Co\text{-}op\ rate) $$

The catch is compliance. Co-op only pays on spend that follows the rules: approved logos, colors, and messaging, certified vendors, and proof of performance. Mention a competitor or use an unapproved logo and that line item is voided, so it earns no reimbursement.

:::predict
prompt: A dealer spends $40,000 in a month. Of that, $30,000 is co-op-eligible compliant spend, reimbursed at a 50% co-op rate. What is the dealer's net cost?
answer: 25000
tolerance: 50
unit: $
hint: Reimbursement applies only to the eligible $30,000, not the full $40,000. Net cost is gross spend minus reimbursement.
explain: Reimbursement = $30,000 x 0.50 = $15,000. Net cost = $40,000 - $15,000 = $25,000. The $10,000 of non-compliant spend earns nothing back, which is why creative review matters financially.
:::

# Raw CPL versus cost per qualified lead

Dealers love to quote cost per lead (CPL). It is also the most misleading number in the funnel. Auto search CPL on Google was about $38.86 in recent DealerTalk data, but a "lead" includes duplicates and bad-fit submissions. Industry estimates suggest dupes and bad fits strip somewhere in a 30 to 60 percent range, so the real cost per qualified lead runs well above the quoted figure.

$$ Cost\ per\ qualified = \frac{Spend}{De\text{-}duped\ in\text{-}market\ leads} $$

:::predict
prompt: A dealer's raw CPL is $175, but 40% of those leads are duplicates or bad-fit. What is the real cost per qualified lead?
answer: 291.67
tolerance: 2
unit: $
hint: If 40 percent are junk, only 60 percent are qualified. Divide the raw cost by the qualified share.
explain: Qualified share = 60%. Cost per qualified = $175 / 0.60 = $291.67. The dealer thinks leads cost $175, but each usable lead actually costs nearly $292.
:::

# Effective CPL from clicks

You can also build CPL bottom-up from the click. Effective CPL is cost per click divided by the landing-page conversion rate, since it takes one over the conversion rate of clicks to produce a single lead.

:::predict
prompt: Your cost per click is $3.50 and your landing page converts clicks to leads at 5%. What is your effective CPL?
answer: 70
tolerance: 1
unit: $
hint: Divide CPC by the conversion rate expressed as a decimal.
explain: Effective CPL = $3.50 / 0.05 = $70. Doubling the landing-page conversion rate to 10% would halve effective CPL to $35, which is often cheaper than buying more clicks.
:::

:::callout key
Two levers move auto economics more than bidding does: co-op compliance, which can effectively halve net cost, and lead quality, which can quietly double the true cost of every usable lead. Optimize cost per qualified lead and net-of-co-op cost, not the headline CPL.
:::

:::widget funnelExplorer
:::

:::quiz
question: A dealer breaks an OEM co-op creative rule by featuring a competitor's logo on one ad line. What is the direct financial consequence?
- The OEM raises the co-op rate to compensate
- That line item loses its co-op reimbursement, raising the dealer's net cost
- Nothing, since compliance only affects brand campaigns
- The dealer is fined a fixed federal penalty per impression
answer: 1
hint: Co-op only pays on spend that follows the rules.
explain: Co-op reimburses only eligible, compliant spend. A rule-breaking line item is voided for reimbursement, so the dealer pays full freight on it and net Tier 3 cost rises.
:::

:::sources
- Retailers and automakers slash most digital ad spend in 2025, Adweek / eMarketer | https://www.adweek.com/brand-marketing/retailers-automakers-slash-most-digital-ad-spend-2025-emarketer-tariffs/
- Dealer ad spend nears $10 billion as digital marketing dominates, DealershipGuy | https://news.dealershipguy.com/p/dealer-ad-spend-nears-10-billion-as-digital-marketing-dominates
:::
