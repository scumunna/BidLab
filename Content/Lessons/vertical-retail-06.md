---
id: vertical-retail-06
track: vertical-retail
module: 6
title: "Campaign Structure and Account Taxonomy: Auto vs Manual, Branded/Category/Conquest, Keyword Harvesting and the Negative-Keyword Bridge"
summary: Architect a clean retail-media account that separates discovery from conversion and intent from intent, then run the harvest-and-negate loop that keeps campaigns from cannibalizing each other.
---
# Why structure comes before bidding

Before a trader can bid well they must architect or inherit a clean account, because every downstream skill (bid sizing, pacing, search-term mining, performance diagnosis) reads off the structure. A messy account is one giant auto campaign where every term is tangled together, the search-term report is unreadable, and you cannot tell which query is winning or losing. The canonical retail-media structure does two things at once: it separates DISCOVERY from CONVERSION (auto versus manual) and it separates one strategic INTENT from another (branded, category, conquest). Get this wrong and no amount of clever bidding saves you, because the same term will be live in several of your own campaigns, splitting impressions and attribution so badly that no campaign accumulates enough clean data to judge.

A point worth nailing down up front, because the rest of the lesson depends on it: when the same keyword sits in two of your own Sponsored Products campaigns, Amazon does not auction them against each other. It picks one of your keywords to enter the auction (steering more impressions toward the higher bid) and your average CPC does not change. So self-overlap never costs you extra per click. What it costs you is signal: clicks and conversions for one query scatter across multiple campaigns and the search-term report turns to noise.

The structural test is simple: every search term should live in exactly one place where it can win, and be blocked everywhere else. That single rule is what the rest of this lesson operationalizes.

:::quiz
question: Discovery and conversion campaigns both target the same query with no negative between them. On Amazon Sponsored Products, what actually goes wrong?
- You pay twice for the same shopper because both campaigns win the auction
- Amazon charges the higher of the two bids as a self-competition penalty
- Amazon enters only one of your keywords, so your CPC is unchanged, but impressions and conversions split across campaigns and the search-term report becomes unreadable
- Nothing goes wrong; running a term in two campaigns is a recommended hedge
answer: 2
hint: Amazon will not auction two of your own campaigns against each other, so think about what is actually lost.
explain: Amazon picks one of your keywords to enter the auction and your average CPC does not change, so there is no double charge and no penalty fee. The real damage is split impressions and split attribution: one query's data is scattered across campaigns, so no campaign gathers enough clean signal and the search-term report stops being trustworthy. That is why the structure (one home per term, negated everywhere else) matters.
:::

:::callout key
Structure is the substrate. A bid is only as good as the campaign it sits in. If discovery and conversion campaigns both target the same query with no negative between them, Amazon still enters only one of your keywords, so you do not pay twice and your CPC does not move. The harm is that the shopper's clicks and conversions split across campaigns, your search-term report becomes unreadable, and your ACoS target becomes hard to enforce because no single campaign holds the full picture.
:::

# Auto versus manual: the discovery engine and the conversion engine

AUTO campaigns let the retailer's engine match your product to queries and ASINs automatically. They are research departments: cheap, broad, and the source of net-new search terms you would never have guessed. MANUAL campaigns use keyword targets (exact, phrase, broad) or product/ASIN targets that you choose, and they convert proven terms under tight bid control. The 2026 standard is to run an auto AND a manual campaign for every product simultaneously, connected by negatives, so discovery feeds conversion without the two splitting one query's data.

The division of labor is the whole point: auto finds the query, manual exact closes it at the bid you want. A common starting allocation across campaign types is roughly 50% to manual exact (highest converting, most controlled), 20% to auto discovery, 20% to broad and phrase, and 10% to Sponsored Brands and Sponsored Display. These are starting weights, not laws; you reweight toward whatever posts incremental return once data arrives.

:::widget donutChart
title: Suggested 2026 budget split across campaign types
labels: Manual exact, Auto discovery, Broad/phrase, Sponsored Brands/Display
data: 50, 20, 20, 10
unit: %
:::

:::predict
prompt: Following the suggested split, how many dollars of a $12,000 per month budget go to manual exact campaigns?
answer: 6000
tolerance: 1
unit: USD
hint: Manual exact is 50% of the total budget.
explain: Manual exact takes 50% of the budget, so $12,000 \times 0.50 = \$6{,}000$. The remaining $6,000 splits across auto (20% = \$2,400), broad/phrase (20% = \$2,400), and Sponsored Brands/Display (10% = \$1,200).
:::

# The taxonomy by intent: branded, category, conquest

Within the auto-and-manual frame, the account splits again by strategic role, and each role is isolated so budgets and ACoS targets do not bleed into one another. BRANDED campaigns defend your own brand name, where shoppers already want you, so closed-loop ROAS looks elite (often 8x to 15x) but incremental value can be thin. CATEGORY (non-brand) campaigns chase generic share-of-shelf on terms like "running shoes," where you fight for new demand at a lower ROAS but higher incrementality. CONQUEST campaigns target competitor brand and ASIN terms to steal their shoppers, which is the most aggressive and the most policy-sensitive bucket.

Isolation matters because each bucket carries a different efficiency target. A blended ACoS goal smeared across all three hides the truth: branded defense props up the average while category and conquest do the real incremental work. Separate campaigns let you set a tight ACoS on branded, a looser one on conquest, and judge each on its own iROAS rather than a flattering blended ROAS.

:::quiz
question: A campaign on your own brand name posts 12x closed-loop ROAS, while a conquest campaign on a competitor's term posts 2.5x. Why might the conquest campaign be more valuable to the business?
- The conquest campaign has lower ad spend in absolute dollars
- Branded ROAS is mostly harvesting demand you already owned, so its incremental ROAS is near zero
- Conquest campaigns are always cheaper per click than branded campaigns
- Closed-loop ROAS is the only number that matters for budget allocation
answer: 1
hint: Think about which campaign caused a sale that would not have happened otherwise.
explain: A high branded ROAS often reflects shoppers who would have bought anyway, so its iROAS (incremental ROAS) can be near zero. The conquest campaign at 2.5x is winning shoppers from a competitor, so more of that return is genuinely incremental, which is what the commerce P&L cares about.
:::

# Keyword harvesting and the negative-keyword bridge

Harvesting is the engine that keeps the structure clean over time. You read the search-term report, and any query that has accumulated about three or more conversions AT OR BELOW your target ACoS graduates into a controlled manual exact-match campaign. At the same moment you add that exact term as a NEGATIVE exact in the auto or broad source campaign, so the two never split that query's impressions again. That paired move (promote downstream, block upstream) is the negative-keyword bridge, and skipping it is the single most common self-inflicted wound in retail media.

The de-dupe rule that falls out of this: every term lives in exactly one campaign, added as a negative everywhere else. Run the harvest loop on a regular cadence (commonly every one to two weeks), and a disciplined operator typically claws back a meaningful share of wasted spend within the first couple of months purely by consolidating each term into one campaign and starving non-converting terms.

:::figure lineItemTree
caption: The harvest loop as a campaign tree. Auto and broad campaigns discover queries at the top; proven winners graduate down into manual exact, and the same term is added as a negative exact upstream so discovery and conversion never split one query's impressions and attribution.
:::

:::predict
prompt: A search term has accumulated 4 conversions at an 18% ACoS, and your target ACoS is 25%. Does it meet the harvest trigger (3 or more conversions AND term ACoS at or below target)? Enter 1 for yes, 0 for no.
answer: 1
tolerance: 0
unit: boolean
hint: Check both conditions: conversions and ACoS versus target.
explain: Both conditions hold: conversions $= 4 \ge 3$, and term ACoS $= 18\% \le 25\%$ target. The term graduates to manual exact and is simultaneously negated in the source campaign, so the answer is 1.
:::

:::predict
prompt: An auto campaign spends $400 on a converting query and $600 on non-converting junk in a week. If harvesting graduates the converting query and you negate the junk that hit your 20-click no-sale rule, what percentage of that auto spend was being wasted on the junk?
answer: 60
tolerance: 1
unit: %
hint: Wasted spend divided by total auto spend.
explain: Total auto spend is $400 + 600 = \$1{,}000$, and the junk is $600. So $600 / 1{,}000 = 0.60$, meaning 60% of the auto spend was waste that negatives now block, while the $400 converter graduates to a controlled manual exact campaign.
:::

# Single-keyword ad groups, grouping, and budget portfolios

Not every term deserves its own campaign. Single-keyword ad groups (SKAGs) give surgical bid control but explode the account into thousands of unmanageable units if overused, so they are reserved for roughly the top 5 to 10 highest-volume, highest-converting keywords where granular control actually pays off. The long tail is grouped thematically, about 10 to 20 related keywords per ad group, which is far more practical to manage and still gives each keyword enough impressions to generate data. Above the campaigns sit PORTFOLIOS (budget groups) that cap spend across whole sets of campaigns, so the account-level budget equals the sum of portfolio caps and each cap covers its in-scope campaigns.

The trade-off is control versus scale. SKAGs maximize control and minimize scale; broad thematic grouping maximizes scale and dilutes control. The art is knowing which handful of terms earn the SKAG treatment and letting everything else ride in grouped ad groups.

:::widget barChart
title: Where keywords live (top SKAG terms vs grouped long tail)
labels: SKAG (top terms), Grouped ad groups (long tail)
data: 8, 72
unit: keywords
:::

:::predict
prompt: You have 80 keywords total and reserve SKAGs for the top 8. What percentage of your keywords sit in grouped (non-SKAG) ad groups?
answer: 90
tolerance: 1
unit: %
hint: Grouped keywords are the total minus the SKAG keywords, divided by the total.
explain: Grouped keywords $= 80 - 8 = 72$, so $72 / 80 = 0.90 = 90\%$. Only 10% get the SKAG treatment, which is exactly why SKAGs must be rationed to the highest-control terms or the account becomes unmanageable.
:::

:::quiz
question: Why is the negative-keyword bridge a structural requirement and not an optional cleanup step?
- Without it, the retailer charges a flat penalty fee per duplicate keyword
- Without it, the same term lives in multiple campaigns, so impressions and conversions split across them and the search-term report becomes too noisy to optimize
- Without it, Sponsored Brands campaigns cannot run at all
- Without it, the search-term report stops generating
answer: 1
hint: Amazon will not auction two of your own campaigns against each other, so think about data quality rather than price.
explain: Amazon enters only one of your keywords into the auction and your average CPC does not change, so there is no penalty fee and no CPC inflation. What breaks is the data: one query's clicks and conversions scatter across the auto and manual campaigns, so neither accumulates enough clean signal and the search-term report stops being trustworthy. The bridge (negate upstream when you promote downstream) consolidates each term into one home so the report stays readable.
:::

# Edge cases, compliance, and the messy-account rebuild

The traps cluster around skipping structure and around the conquest bucket. Skip the negative-keyword bridge and the same term runs in several of your campaigns, but it is worth being precise about why that hurts: Amazon enters only one of your keywords into the auction and your average CPC does not change, so self-overlap is not a hidden surcharge. The cost is that one query's impressions, clicks, and conversions split across campaigns, so the data is too thin and too scattered to optimize, and budget leaks into duplicate non-converting placements. Conquest campaigns that name or target competitor brands can trip trademark and creative-policy flags, which is exactly why they must be isolated, so a policy strike or a budget overrun is contained to one campaign rather than poisoning the whole account. And inheriting an account with no taxonomy (one giant auto campaign, no negatives) makes the search-term report noise rather than signal, so the first job on a messy account is almost always a structural rebuild before any bid is touched.

A brand-new product is its own edge case: it has no conversion history, so you cannot yet harvest from it and cannot size a confident bid. You seed it with category benchmarks, let the auto campaign run a week or two to gather search terms, then begin the harvest loop once real data exists.

:::predict
prompt: The same keyword is live in two of your own Sponsored Products campaigns with no negative between them. By how many extra dollars does Amazon raise your average CPC for that keyword purely because of the self-overlap? Enter the dollar amount.
answer: 0
tolerance: 0
unit: USD
hint: Recall whether Amazon auctions two of your own campaigns against each other.
explain: Amazon does not put your own bids against one another; it picks one of your keywords to enter the auction and steers more impressions to the higher bid, and your average CPC does not change. So the self-overlap adds $0 to your CPC. The damage is not price, it is split impressions and attribution that wreck your data, which is the real reason to negate the term in every campaign but one.
:::

:::callout warning
A recurring operator complaint on r/PPC and r/AmazonSeller is "my auto and manual campaigns are fighting each other." Traders inherit accounts and find the same winning term live in multiple campaigns with no negatives. The instinct is to say the seller is bidding against themselves and inflating their own CPC, but that mechanic is wrong: Amazon enters only one of your keywords and your average CPC does not change. The real, costly problem is that the term's impressions and conversions split across campaigns, so the data is unreadable and budget leaks into duplicates. The fix is unglamorous but mandatory: audit for duplicate terms, pick the one campaign each term should win in, and negate it everywhere else before optimizing a single bid.
:::

:::sources
- ecombrainly, How to Structure Amazon PPC Campaigns (Updated 2026) | https://ecombrainly.com/amazon-ppc-campaign-structure/
- Pilothouse Digital, Amazon Keyword Harvesting: The Complete Guide to Search Term Graduation | https://www.pilothouse.co/post/amazon-keyword-harvesting-the-complete-guide-to-search-term-graduation
- Sermondo, Amazon PPC Keyword Cannibalization: Am I Bidding Against Me? | https://sermondo.com/amazon-ppc-keyword-cannibalization/
- Ad Badger, Keyword Cannibalization in Amazon PPC | https://www.adbadger.com/blog/keyword-cannibalization-and-placement-in-amazon-ppc/
- CaptenAMZ, Amazon Negative Keywords: The 2026 Strategy Guide for Smarter PPC | https://captenamz.com/blog/amazon-negative-keywords/
- Feedvisor, Amazon Sponsored Products Manual Campaigns: 2026 Guide | https://feedvisor.com/university/amazon-sponsored-products-manual-campaigns/
- SellerApp, Auto vs. Manual Amazon PPC Campaigns: How to Choose and Optimize Both | https://www.sellerapp.com/help/article/how-sellerapp-helps-in-choosing-amazon-auto-vs-manual-ppc-campaigns/
:::
