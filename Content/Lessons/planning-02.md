---
id: planning-02
track: planning
module: 2
title: Audience sizing
summary: Estimating how many real people a target definition reaches, and why overlap means channel audiences do not simply add up.
---
# From market to addressable universe

Before you spend, you size the audience. The standard frame nests three numbers. The total addressable market (TAM) is everyone who could plausibly want the product. The serviceable addressable market (SAM) applies real filters, geography, age, language, and product fit, to cut TAM down to who you can actually reach. The share you expect to win inside the SAM is your realistic target.

Each filter you add to the definition shrinks the universe, and it does so multiplicatively. If 40 percent of TAM is in your region and 30 percent of those are in the right age band, you keep 0.40 times 0.30, which is 12 percent. Stack four or five filters and a large market becomes a small one fast.

$$ SAM = TAM \times f_1 \times f_2 \times f_3 $$

:::callout key
Every targeting filter multiplies, it does not subtract. Layering "in-market" on top of "homeowner" on top of "high income" can leave a universe far smaller than any single filter suggests. Tight definitions can be too tight to deliver the budget.
:::

:::predict
prompt: A TAM of 50 million people passes through three filters: 40 percent are in region, 30 percent of those are in the right age band, and 50 percent of those are a product fit. What is the SAM?
answer: 3000000
unit: people
hint: Multiply TAM by each filter fraction in turn, because filters compound rather than add.
explain: SAM = 50,000,000 x 0.40 x 0.30 x 0.50 = 3,000,000 people. Three modest filters cut a 50 million market to 3 million, which is the multiplicative shrink in action.
:::

# Audiences do not add up

Run the same target on two channels and you cannot add the two reach numbers, because some people appear in both. The fix is inclusion-exclusion: $reach = A + B - (A \cap B)$. Add the two audiences, then subtract the overlap you double counted.

For three channels you add the three singles, subtract the three pairwise overlaps, then add back the triple overlap. Ignoring overlap inflates your reach estimate and makes a campaign look broader than it is. Cross-platform overlap in large campaigns commonly runs from 20 to 40 percent of the smaller audience.

:::callout insight
Deduplicated reach is always less than the sum of channel reaches. Two channels each claiming 5 million unique people do not give you 10 million unless their audiences never overlap, which essentially never happens.
:::

:::predict
prompt: Channel A reaches 7 million people, channel B reaches 5 million, and 2 million appear on both. What is the deduplicated reach?
answer: 10000000
unit: people
hint: Add the two channel reaches, then subtract the overlap once with inclusion-exclusion.
explain: Deduplicated reach = 7,000,000 + 5,000,000 - 2,000,000 = 10,000,000. The 2 million shared people were counted in both totals, so you subtract them once.
:::

# Sanity-check against the universe

Estimates drift, so anchor them. If a channel claims it can deliver more impressions to your target than there are people in your SAM at a sane frequency, the number is wrong or the target is broader than stated. Dividing promised impressions by your audience size gives an implied frequency, and an absurd frequency flags a bad estimate.

:::widget reachFrequency
population: 5000000
:::

:::quiz
question: Channel A reaches 6 million in your target, channel B reaches 4 million, and their overlap is 1.5 million. What is the deduplicated reach?
- 8.5 million
- 10 million
- 11.5 million
- 5.5 million
answer: 0
explain: Inclusion-exclusion gives 6 + 4 - 1.5 = 8.5 million. You subtract the overlap once because those people were counted in both channel totals.
:::

:::sources
- HubSpot, TAM, SAM and SOM: what they mean and how to calculate them | https://blog.hubspot.com/marketing/tam-sam-som
- Nielsen, Total Audience measurement | https://www.nielsen.com/solutions/media-planning/
:::
