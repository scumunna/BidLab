---
id: vertical-telecom-07
track: vertical-telecom
module: 7
title: Frequency and Reach Across Fragmented CTV Supply
summary: Control household frequency and grow unique reach across fragmented CTV supply by deduping paths, enforcing cross-publisher caps, and reading the frequency distribution instead of the average.
---
# Why CTV is the carrier's frequency problem

For a high-budget carrier, connected TV is where the frequency problem becomes structural rather than cosmetic. The same household is reachable through multiple SSPs, multiple apps, direct publisher buys, and the carrier's own retail media network, and a frequency cap set inside one DSP does nothing to stop another path from re-hitting that home. The result is brutal over-exposure concentrated on a few households while reach stalls, so a carrier can spend a fortune annoying the same families and never reach the incremental switchers the whole campaign is meant to win.

The trader's job here is reach and dedup, not raw impressions. You are optimizing toward unique households reached at a controlled frequency, because in a subscription business the only home worth an impression is one that can switch, and a home you have already shown the ad nine times is not the marginal gross add. Everything in this lesson serves that single reframing.

:::predict
prompt: A carrier CTV flight serves 9,000,000 impressions but reaches only 1,000,000 unique in-footprint households. What is the average frequency per household?
answer: 9
tolerance: 0
unit:
hint: Divide total impressions by unique households reached.
explain: 9,000,000 / 1,000,000 = 9. The average home has already seen the ad nine times, so the next impression mostly re-hits a saturated household instead of reaching a new switcher. That is why the desk optimizes unique reach at a controlled frequency, not raw impressions.
:::

:::callout key
On a carrier CTV buy, impressions are not the deliverable. Unique in-footprint households reached at a controlled frequency are the deliverable. Average frequency is a comfort metric. The frequency distribution is the truth, and the overexposed tail is where budget quietly dies.
:::

# Average frequency and the overexposed tail

Average frequency is the headline number, and it is the one most likely to lie to you. Average frequency is total impressions divided by unique households reached, so a campaign serving 30,000,000 impressions to 5,000,000 unique households reports an average of $6.0$ exposures per home. That single number says nothing about how the impressions are spread, and on fragmented CTV they are spread very unevenly.

The reality is a long tail: research on CTV frequency finds that roughly 8 to 15 percent of households exceed their intended cap yet absorb 42 to 60 percent of all impressions. A healthy-looking average sits on top of a distribution where a sliver of homes sees the ad twenty-plus times while a large share of the target is never reached at all. You watch the distribution and the over-cap share, not the mean.

$$ \text{average frequency} = \frac{\text{total impressions}}{\text{unique households reached}} $$

:::predict
prompt: A campaign serves 30,000,000 impressions to 5,000,000 unique households. What is the average frequency?
answer: 6
tolerance: 0.1
unit: impressions per household
hint: Divide total impressions by unique households reached.
explain: 30,000,000 / 5,000,000 = 6.0 impressions per household. That tidy average hides the tail, where a small share of homes can be seeing the ad twenty-plus times while much of the target is never reached.
:::

:::predict
prompt: 12% of households are over-capped and absorb 50% of 30,000,000 impressions. How many impressions hit over-capped households?
answer: 15000000
tolerance: 1000
unit: impressions
hint: Take 50% of the total impression pool.
explain: 0.50 x 30,000,000 = 15,000,000 impressions land on the 12% of homes that are already over-capped. Half the budget is reinforcing fatigue instead of buying incremental reach, which is exactly what the average frequency of 6.0 conceals.
:::

# The fragmented supply path is the root cause

The over-exposure is not bad luck, it is the architecture. The same CTV household is offered to you through several SSPs and resellers, through direct publisher deals, through the app's own inventory, and through the carrier's RMN, and each of those is a separate frequency surface. Set a per-path cap of three on five paths and you have authorized fifteen exposures to one home without breaking a single cap. A true universal cap across all of CTV remains a work in progress in 2025, and DSP caps do not reach across to another DSP or a direct buy.

This is why supply-path optimization and curation matter for frequency, not just for cost. Consolidating onto fewer, more direct paths shrinks the number of independent surfaces hitting each home, which is the precondition for any cap to actually hold. The figure below traces how one impression opportunity can reach a buyer through multiple intermediaries, each one a place where the same household slips through.

:::figure supplyChain
caption: One CTV household reaches the buyer through several SSPs, resellers, direct deals, and the carrier RMN. Each path is an independent frequency surface, so a per-path cap on each still stacks into heavy total exposure on the same home. Consolidating paths is what lets a cap hold.
:::

:::quiz
question: Why does a frequency cap set in one DSP fail to control a household's total CTV exposure?
- The DSP cap is ignored by its own bidder
- Each SSP, direct buy, and RMN path is a separate frequency surface the DSP cap cannot see
- CTV impressions are never capped by any system
- Average frequency automatically corrects for it
answer: 1
hint: Think about how many independent paths can reach the same home.
explain: The cap only governs the path the DSP controls. The same household is reachable through other SSPs, direct deals, the app's own inventory, and the carrier RMN, and none of those see the DSP's cap, so total exposure stacks across surfaces.
:::

# Cross-publisher capping and household identity

The fix is to move the cap up a level so it spans paths, and to dedupe households across screens using identity rather than per-path cookies or IPs. Cross-publisher, cross-device frequency capping is the lever: DV360 cross-publisher capping has shown 51 percent higher reach versus siloed per-publisher capping, because the budget that was reinforcing the tail gets redirected to homes the campaign had not yet reached. CTV identity is fragmented across IP, device ID, and login, so without household resolution the same home is counted as several users and the cap fails before it starts.

The same household-level IDs you built for serviceability and clean-room matching in earlier lessons are what let you dedupe one home across a smart TV, a streaming stick, and a phone. Reach lift is the payoff you measure: incremental reach is the unique households you add once the cap and dedup are working, on the same impression pool.

$$ \text{incremental reach} = \text{unique households after dedup} - \text{unique households before dedup} $$

:::predict
prompt: Cross-publisher capping lifts unique reach from 5,000,000 to 7,550,000 households (a 51% lift). How many incremental households were reached?
answer: 2550000
tolerance: 1000
unit: households
hint: Subtract the before-dedup reach from the after-dedup reach.
explain: 7,550,000 - 5,000,000 = 2,550,000 incremental households, which checks out as 0.51 x 5,000,000. Those are homes the campaign now reaches on the same budget, redirected away from the overexposed tail.
:::

:::quiz
question: Why is household-level identity resolution a precondition for CTV frequency capping to work?
- It lowers the CPM on every impression
- It guarantees a 100% match rate across devices
- Without it, one home shows up as several users across IP, device ID, and login, so the cap never binds
- It replaces the need for any cap at all
answer: 2
hint: Think about how a single home appears to the system across multiple screens.
explain: CTV identity is fragmented across IP, device ID, and login. Without resolving those signals to one household, the system treats a single home as several distinct users, so a per-user cap never actually limits exposure to that home.
:::

# Reach lift versus impressions wasted

The trader's scoreboard on CTV is reach efficiency, and the cleanest way to see it is to put the wasted-impression problem next to the reach-lift fix on the same chart. The over-cap tail absorbs a large share of impressions, and cross-publisher capping recovers a large share of reach, and seeing both at once is how you justify the SPO and dedup work to a client who only asked about CPM.

The bar chart below uses the brief's data: the share of households that are over-cap, the share of impressions those homes absorb, and the reach lift from cross-publisher capping. Read together, they say the same thing the distribution does: a minority of homes is eating the budget, and consolidating paths plus capping across them is how you buy reach instead of fatigue.

:::widget barChart
title: CTV over-exposure versus reach recovered
labels: Households over-cap, Impressions they absorb, Reach lift from cross-pub capping
data: 12, 50, 51
unit: percent
:::

:::predict
prompt: A campaign reaches 5,000,000 unique households and serves 25,000,000 impressions. After cross-publisher capping, average frequency falls to 3.0 on the same 25,000,000 impressions. How many unique households does it now reach?
answer: 8333333
tolerance: 5000
unit: households
hint: Unique households equals total impressions divided by the new average frequency.
explain: 25,000,000 / 3.0 = 8,333,333 unique households, up from 5,000,000. Holding impressions fixed and cutting average frequency from 5.0 to 3.0 converts wasted repetition into roughly 3.3M incremental reached homes.
:::

# Measuring it: log-level data and effective reach

You cannot manage what you cannot see, and on CTV visibility is scarce. An IAB study in late 2025 found that only 21 percent of CTV publishers always provide advertisers log-level data or dashboards, and 36 percent never do, which means cross-path dedup is blind on a meaningful share of your supply. Where you have log-level data you can verify and dedupe; where you do not, frequency control is a best guess, and that gap should steer budget toward transparent paths.

The metric that matters is effective reach, the unique households at or above your minimum effective frequency and below your cap, not the raw unique count and not the average. A home reached once may be under-exposed and a home reached fifteen times is pure waste, so the goal is to maximize the band in between. That reframing, plus log-level proof, is what turns a CTV buy from an impression-spend exercise into a reach-and-frequency discipline.

:::callout warning
Operators on r/programmatic describe CTV frequency as a structural nightmare: a household capped in one DSP gets hit again through another DSP, a direct buy, and the app's own inventory, with no path seeing the others, while a small set of homes eats most of the impressions and reach stalls. The recurring complaint is that without log-level data from key CTV publishers they cannot even measure the overlap, let alone fix it, so the first move on any new CTV partner is to demand log-level access before scaling spend.
:::

:::predict
prompt: Of 6,000,000 unique households reached, 1,200,000 fall below the minimum effective frequency and 600,000 are above the cap. How many households are in the effective-reach band?
answer: 4200000
tolerance: 1000
unit: households
hint: Subtract both the under-exposed and the over-capped homes from total unique reach.
explain: 6,000,000 - 1,200,000 - 600,000 = 4,200,000 households sit in the effective band, at or above the minimum effective frequency and below the cap. Only those 4.2M are truly working reach, which is why raw unique count overstates the result.
:::

:::sources
- IAB, CTV log-level data availability study (2025) | https://www.iab.com/insights/
- Brainlabs, Connected TV cross-publisher frequency capping in DV360 | https://www.brainlabsdigital.com/connected-tv-cross-publisher-frequency-capping-dv360/
- ANA, Q2 2025 Programmatic Transparency Benchmark | https://www.ana.net/content/show/id/pr-2025-08-programmatictrans
- MonetizeMore, Supply path optimization best practices and top SPO partners | https://www.monetizemore.com/blog/supply-path-optimization/
- Front Porch, Programmatic advertising for service providers | https://www.frontporch.com/advertising/
- Google, Display & Video 360 frequency management and cross-publisher capping | https://support.google.com/displayvideo/answer/2696956
:::
