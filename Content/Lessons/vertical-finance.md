---
id: vertical-finance
track: finance
module: 1
title: Finance: the most expensive auction, won on cost per funded
summary: Why financial services pays the highest CPMs in advertising, how the cost-per-funded cascade reveals true acquisition cost, and how Special Ad Category and FCRA rules reshape the auction.
---
# The most expensive clicks in advertising

Financial services runs the most expensive auctions in digital advertising. US financial services media ad spend grew 17.8 percent in the first half of 2025 to $5.9B, and the sector's digital growth is forecast to outpace every other industry. The keywords are punishing: per WordStream's authoritative ranking of the most expensive Google keywords, insurance averages around $54.91, mortgage around $47.12, and loans around $44.28 per click.

Cost-per-thousand impressions (CPM) in finance commonly runs $50 to $100 or more, against an all-industry average closer to $14. Yet the economics still work, because a single funded client can be worth tens of thousands of dollars over their lifetime. A $650 cost per lead is rational when the client behind it is worth $50,000.

:::widget barChart
title: Average cost per click by finance keyword (WordStream)
labels: Insurance, Mortgage, Loans
data: 54.91, 47.12, 44.28
unit: $
:::

# CPM, CPC, and why scope is everything

The base formulas are the same as anywhere. CPM is spend over impressions times one thousand. CPC is spend over clicks. CPL is spend over leads. What changes in finance is the magnitude and the variance: a quoted CPL is meaningless until you name the channel and the product.

$$ CPM = \frac{Spend}{Impressions} \times 1000 $$

:::predict
prompt: You spend $7,500 on a campaign that delivers 100,000 impressions. What is your CPM?
answer: 75
tolerance: 1
unit: $
hint: Divide spend by impressions, then multiply by 1,000.
explain: CPM = ($7,500 / 100,000) x 1,000 = $75. That sits squarely in the normal $50 to $100 finance range and far above the roughly $14 all-industry average.
:::

# The cost-per-funded cascade

In finance a lead is not the goal. A funded account or a bound policy is. Between the lead and the funding sit two conversion gates: lead to application, and application to funded. The true cost of an outcome is the lead cost divided by the product of those two rates. This cascade is the signature calculation of the vertical.

$$ Cost\ per\ funded = \frac{CPL}{(Lead\to App) \times (App\to Fund)} $$

:::predict
prompt: Your CPL is $50, your lead-to-application rate is 30%, and your application-to-funded rate is 40%. What is your cost per funded account?
answer: 416.67
tolerance: 2
unit: $
hint: Multiply the two rates to get the overall lead-to-funded rate, then divide CPL by it.
explain: Cost per funded = $50 / (0.30 x 0.40) = $50 / 0.12 = $416.67. Each cheap-looking $50 lead actually costs over $400 once you account for everyone who drops out along the way, before any fraud or bad leads.
:::

:::predict
prompt: Your CPL rises to $84, lead-to-application is 35%, and application-to-funded is 50%. What is your cost per funded account?
answer: 480
tolerance: 2
unit: $
hint: The combined conversion rate is 0.35 x 0.50.
explain: Combined rate = 0.175. Cost per funded = $84 / 0.175 = $480. Higher conversion rates partly offset the higher lead cost, which is why operators optimize the whole cascade, not just CPL.
:::

:::callout insight
A lead price is meaningless on its own. The cascade is what turns a flattering $50 CPL into a true $417 cost per funded. Always carry the calculation all the way to the funded outcome before you compare channels.
:::

# The bid ceiling: allowable CAC from LTV

Because a funded client is so valuable, finance buyers can pay more than almost anyone. The bid ceiling, or allowable CAC, is lifetime value times the share of that value you are willing to spend to acquire it. That ceiling is what lets a finance advertiser win $50 clicks that no retailer could justify.

:::predict
prompt: A funded client is worth $50,000 in lifetime value, and you are willing to spend up to 1% of that value to acquire one. What is your allowable CAC, the bid ceiling?
answer: 500
tolerance: 5
unit: $
hint: Take one percent of the lifetime value.
explain: Allowable CAC = $50,000 x 0.01 = $500. As long as your cost per funded stays under $500, the campaign is profitable, which is why a $417 cost per funded is comfortably acceptable here.
:::

# Compliance shrinks the auction

Finance also carries the heaviest regulatory load, and the rules directly reshape who you can reach. Meta's Financial Products and Services Special Ad Category, effective January 14, 2025, locks age targeting to 18 to 65 plus, removes gender targeting, eliminates ZIP targeting in favor of a 15-mile minimum radius, and bans Lookalike audiences and detailed-targeting expansion. As of September 2, 2025, Custom Audiences based on income, net worth, or creditworthiness are also prohibited. The framework exists to prevent discrimination.

The Fair Credit Reporting Act (FCRA) adds another layer. Marketing is not a permissible purpose for using credit data, except for prescreening under section 604(c), which requires a genuine firm offer of credit or insurance plus a Regulation V opt-out disclosure. In practice, if you target a prescreened audience, the creative itself must contain a firm offer and an opt-out notice. On top of that, regulated creative carries APR and rate disclosures and fair-lending language, which tends to depress click-through rates.

:::callout key
Every targeting restriction forces you toward broader, less efficient reach, and every disclosure requirement lowers response. Compliance is not a side constraint in finance. It is a direct input to your cost per funded.
:::

:::quiz
question: Under Meta's Financial Products and Services Special Ad Category, which targeting capability is still permitted?
- ZIP-code targeting tighter than a 15-mile radius
- Lookalike audiences
- A broad age range within the 18 to 65 plus band
- Custom Audiences built on creditworthiness
answer: 2
hint: The category removes granular geo, lookalikes, and wealth-based audiences, but advertisers can still reach within the allowed age band.
explain: The Special Ad Category eliminates ZIP targeting (15-mile minimum radius), bans Lookalikes, and as of September 2025 prohibits creditworthiness-based Custom Audiences. Targeting within the permitted 18 to 65 plus age band is still allowed.
:::

:::widget funnelExplorer
:::

:::sources
- US financial services ad spend grew 17.8% in H1 2025, eMarketer | https://www.emarketer.com/chart/c/353711/
- Most Expensive Google Ads Keywords, WordStream | https://www.wordstream.com/articles/most-expensive-keywords
:::
