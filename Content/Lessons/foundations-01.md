---
id: foundations-01
track: foundations
module: 1
title: Numbers, percentages, and rates
summary: Read fractions, decimals, percentages, ratios, and rates with confidence, and recognize CTR and CVR as rates.
---
# Three ways to write the same number

A fraction, a decimal, and a percentage are three costumes for one idea: a part of a whole. If 3 people out of 200 click your ad, the fraction is 3 / 200. Divide it out and you get the decimal 0.015. Multiply a decimal by 100 and add a percent sign and you get the percentage, 1.5%.

The conversions never change the underlying number, only how it looks. Going from a decimal to a percentage moves the decimal point two places to the right (0.015 becomes 1.5%), and going back moves it two places left. Getting comfortable switching between these forms is the single most useful arithmetic skill in advertising, because dashboards mix all three freely.

:::predict
prompt: If 9 people out of 1,200 click an ad, what is that as a percentage?
answer: 0.75
unit: %
tolerance: 0.01
hint: Divide to get the decimal, then move the decimal point two places right to make it a percentage.
explain: 9 / 1,200 = 0.0075, and times 100 that is 0.75%. The fraction, the decimal, and the percentage are three costumes for the same number.
:::

:::callout key
A percentage is just a decimal times 100. The number 0.015, the fraction 3 / 200, and the value 1.5% are identical. Train yourself to see them as the same thing.
:::

# Ratios and rates

A ratio compares two quantities of the same kind, like 4 impressions for every 1 click, written 4:1. A rate compares two quantities of different kinds and almost always carries a unit, like 12 dollars per 1,000 impressions or 3 clicks per 100 impressions. The word per is the giveaway that you are looking at a rate.

Rates let you compare things of different sizes on equal footing. One campaign serving 50,000 impressions and another serving 5 million cannot be judged by raw click counts, but both can be judged by clicks per impression. That single move, turning a count into a rate, is what makes two unequal campaigns comparable.

:::predict
prompt: A campaign serves 50,000 impressions and gets 150 clicks. Expressed as a rate, how many clicks does it earn per 1,000 impressions?
answer: 3
unit: per 1,000
tolerance: 0.05
hint: Divide clicks by impressions to get clicks per impression, then multiply by 1,000.
explain: Clicks per impression = 150 / 50,000 = 0.003. Times 1,000 that is 3 clicks per 1,000 impressions. Turning the raw count into a rate is what lets you compare this campaign against one of any other size.
:::

# CTR and CVR are rates

The two rates you will meet first are click-through rate (CTR) and conversion rate (CVR). CTR is clicks divided by impressions: the share of people shown the ad who clicked it. CVR is conversions divided by clicks: the share of clickers who went on to do what you wanted, like buy or sign up.

$$ CTR = clicks / impressions $$

If an ad gets 600 clicks on 200,000 impressions, its CTR is 600 / 200,000 = 0.003 = 0.3%. If 30 of those clicks turn into purchases, the CVR is 30 / 600 = 0.05 = 5%. Notice that each rate divides by a different base. CTR is per impression, CVR is per click. Mixing up the base is the most common beginner mistake, so always ask what the rate is per.

:::predict
prompt: An ad gets 750 clicks on 300,000 impressions. What is the CTR?
answer: 0.25
unit: %
tolerance: 0.01
hint: CTR is clicks divided by impressions, expressed as a percentage.
explain: CTR = 750 / 300,000 = 0.0025 = 0.25%. The base is impressions, since CTR measures the share of people shown the ad who clicked it.
:::

:::callout warning
Always check the denominator. A 5% rate means nothing until you know 5% of what. CTR is per impression, CVR is per click, and confusing the two will quietly corrupt every number downstream.
:::

# Try the conversions

Use the calculator to turn a price between CPM, CPC, and CPA, and watch how a rate in the chain (like CTR or CVR) reshapes the others. Change one rate and see which numbers move and which stay put.

:::widget pricingCalculator
:::

:::quiz
question: An ad has 400 clicks on 100,000 impressions, and 20 of those clicks convert. What are the CTR and CVR?
- CTR 0.4%, CVR 5%
- CTR 5%, CVR 0.4%
- CTR 0.4%, CVR 0.4%
- CTR 4%, CVR 20%
answer: 0
explain: CTR is clicks over impressions, 400 / 100,000 = 0.004 = 0.4%. CVR is conversions over clicks, 20 / 400 = 0.05 = 5%. Each rate divides by its own base.
:::

:::sources
- Google Ads Help, clickthrough rate (CTR) definition | https://support.google.com/google-ads/answer/2615875
- Interactive Advertising Bureau, glossary of terminology | https://www.iab.com/insights/glossary-of-terminology/
:::
