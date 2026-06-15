---
id: adops-12
track: adops
module: 12
title: Audience and Segment Operations
summary: How a list of customers becomes an addressable segment through onboarding and match rates, why a clean taxonomy keeps segments usable, how first-party beats third-party, how lookalikes extend a seed, and why suppression is as operational as targeting.
---
# From a customer list to an addressable segment

An advertiser has a spreadsheet of customer emails. A DSP cannot target an email. The gap between those two facts is the entire discipline of audience operations. Onboarding is the process that closes it: take offline or first-party identifiers (emails, phone numbers, postal addresses), hash them so the raw personal data never travels, and resolve those hashes to the pseudonymous IDs that ad platforms can actually act on (a RampID, a UID, a mobile ad ID, a cookie where they still exist).

That resolution step is run by an identity vendor, LiveRamp being the canonical one, that maintains a graph linking hashed identifiers to its own people-based ID and then to downstream device and platform IDs. You upload a file, the onboarder matches what it can, and on the far side a segment appears inside the DSP or platform ready to target or suppress.

The number that governs how much of your list survives this trip is the match rate, and it is the first thing an ops person checks on any onboarded audience. A beautiful 2,000,000-record list that matches at 30 percent is a 600,000-record segment in practice. Onboarding is plumbing, and match rate is the pressure gauge on it.

:::figure pixelFire
caption: First-party identifiers are hashed and resolved through an identity graph into the pseudonymous IDs a platform can target.
:::

:::quiz
question: Why can a DSP not simply target the email addresses in an advertiser's customer file directly?
- Emails are too long to store
- A DSP acts on pseudonymous platform and device IDs, so the emails must be hashed and resolved to those IDs through onboarding
- Email targeting is illegal in every market
- DSPs only accept phone numbers
answer: 1
hint: Think about what identifier the bidding infrastructure actually sees in a bid request.
explain: Bidding infrastructure acts on pseudonymous IDs (cookies, mobile ad IDs, people-based IDs), not raw emails. Onboarding hashes the emails and resolves them through an identity graph to those IDs, which is what makes the list addressable. The raw personal data never enters the bidstream.
:::

# Match rate is the pressure gauge

Match rate is the share of your uploaded records that the onboarder could resolve to at least one usable ID. LiveRamp defines it plainly:

$$ \text{match rate} = \frac{\text{matched records}}{\text{total unique records}} \times 100 $$

So 80,000 matches on a 100,000-record file is an 80 percent match rate, and your addressable segment is 80,000, not 100,000. Match rate is driven by data quality (are the emails current and well formatted?), identifier richness (a record with email plus name plus address matches far better than email alone), and the destination (each platform has its own reach, so the same file matches differently to different platforms).

A subtlety that trips people up: match rate is not the same as reach or sync rate. Match rate says how many records resolved to a people-based ID. Whether that person can then be reached on a given device or in a given browser is a further step, and cookie loss and device coverage erode it. So a 90 percent match rate does not mean 90 percent of your customers will see the ad; it means 90 percent entered the addressable pool, and reach narrows from there.

The operational habit is to read match rate per destination and never assume the headline number carries. The same audience onboarded to two platforms can land at very different sizes.

:::callout key
Match rate is matched records over total records. It is the ceiling on a segment's size, not a guarantee of reach. Sync, device coverage, and cookie loss all shrink it further downstream.
:::

:::predict
prompt: You onboard a file of 100,000 unique customer records to a platform and 80,000 resolve to a usable ID. What is the match rate?
answer: 80
tolerance: 0
unit: %
hint: Match rate is matched records divided by total unique records, times 100.
explain: 80,000 / 100,000 = 0.80, so an 80 percent match rate. The addressable segment is the 80,000 matched records, not the full 100,000, and actual reach will be somewhat lower again after device and cookie coverage.
:::

:::predict
prompt: You onboard the same 100,000-record file to a second platform, where it matches at only 55 percent. How many records are addressable on that second platform?
answer: 55000
tolerance: 0
unit:
hint: Apply the second platform's match rate to the same 100,000 records.
explain: 100,000 x 0.55 = 55,000 addressable records on the second platform, versus 80,000 on the first. Same file, different destination, different match rate, which is exactly why you read match rate per platform instead of trusting one headline number.
:::

# Taxonomy is what keeps segments usable

A data marketplace can hold hundreds of thousands of segments from dozens of providers. Without a shared naming scheme, "auto intenders" from one vendor and "in-market: automotive" from another are impossible to compare, and a trader cannot tell whether two segments overlap, contradict, or mean the same thing. A taxonomy is the agreed structure that organizes segments into tiers and consistent names so they can be compared across providers.

The IAB Tech Lab Audience Taxonomy is the industry reference. It sorts segments at the top tier into a few kinds: demographic (who the person is, age, gender, household income), interest (what they like), and purchase intent (what they are in market to buy), then nests more specific labels under each. Paired with the Data Transparency Standard, it pushes providers to declare how a segment was built and labeled, so a buyer can judge a segment instead of trusting a marketing name.

For ops, taxonomy is not bureaucracy, it is what makes segments diff-able and trustworthy. When a campaign is built from twelve segments across four providers, a clean taxonomy is what lets you see that three of them are really the same audience and that one labeled "luxury auto intenders" is actually a broad interest segment, not an in-market one. Mislabeled tiers are a quiet source of wasted spend.

:::quiz
question: At the top tier, the IAB Audience Taxonomy distinguishes segments mainly by what kind of attribute they describe. Which grouping reflects that?
- Cheap, medium, and premium segments
- Demographic, interest, and purchase-intent segments
- First-party, second-party, and third-party segments
- Cookie, mobile, and CTV segments
answer: 1
hint: The taxonomy organizes by what the segment says about a person, not by price or source.
explain: The IAB Audience Taxonomy's top tier separates demographic (who they are), interest (what they like), and purchase intent (what they are in market to buy). Source (first vs third party) and channel are different dimensions; the taxonomy's job is to standardize what the segment describes so segments are comparable across providers.
:::

# First-party beats third-party, and the reasons are operational

Segments come in three flavors by source. First-party data is the advertiser's own: its customers, site visitors, app users, CRM. Second-party data is someone else's first-party data shared directly through a clean room or a deal, the partner's customers used with permission. Third-party data is aggregated and sold by a data provider who collected it across many sites, the open marketplace segments.

The industry has shifted hard toward first-party, and the reasons are concrete, not ideological. First-party data matches better (you hold the freshest, most complete identifiers), it is more accurate (you observed the behavior yourself rather than inferring it), it carries cleaner consent (you have the direct relationship and the opt-in), and it survives the deprecation of third-party cookies and the tightening of mobile identifiers that has eroded third-party segments. Third-party segments still have a role for prospecting and scale, but they are smaller, fuzzier, and on shakier privacy ground than they were.

The operational consequence is that first-party data is the seed for almost everything downstream: it is what you onboard, what you build lookalikes from, and what you suppress against. A team's audience capability is increasingly a function of how well it collects, governs, and activates its own first-party data.

:::figure funnel
caption: First-party data feeds onboarding, lookalike seeds, and suppression, with second and third-party data filling scale around it.
:::

:::quiz
question: A retailer shares its own logged-in customer data directly with one airline partner through a clean room, used only with permission. From the airline's perspective, what kind of data is this?
- First-party data
- Second-party data
- Third-party data
- Contextual data
answer: 1
hint: It is someone else's first-party data, shared directly between two named parties.
explain: This is second-party data: another company's first-party data shared directly and with permission, typically through a clean room or deal. It is not third-party (which is aggregated and sold broadly by a data vendor) and it is not the airline's own first-party data.
:::

# Lookalikes extend a seed, and seed quality beats seed size

A first-party segment is high quality but small. A lookalike (or "audience extension") model fixes the scale problem: feed the platform a seed audience, your best customers or converters, and it finds new users who resemble them across the features it can see, then builds a much larger reachable segment from that resemblance.

Two operational truths matter here. First, seed quality beats seed size. A tight, homogeneous seed of genuine high-value converters models far better than a huge, mixed seed of anyone who ever touched the site, because the model learns a clearer signal. A common mistake is seeding a lookalike on "all purchasers" when you wanted "high lifetime-value purchasers," and getting a bland, broad audience back. Second, there is a size floor: platforms need a minimum seed to model at all (on the order of a hundred matched users at the low end, with a few thousand recommended for a stable model), which loops straight back to match rate, because the seed is your matched first-party records, not your raw file.

So lookalikes compound earlier steps. A weak match rate gives a thin seed, a thin or impure seed gives a weak model, and a weak model gives an extension audience that performs no better than broad targeting. The leverage is at the seed.

:::callout insight
Lookalike performance is set at the seed. A small, pure seed of true high-value converters beats a large, mixed one, and the seed only exists at all because enough first-party records matched.
:::

:::quiz
question: You want a lookalike of your most valuable customers but seed the model with every site purchaser of any value. What is the most likely result?
- A sharper, higher-performing lookalike
- A broad, diluted lookalike that performs little better than generic targeting
- The model refuses to build
- An audience identical to a third-party in-market segment
answer: 1
hint: The model learns whatever signal the seed contains; a mixed seed carries a mixed signal.
explain: A broad, mixed seed gives the model a blurry signal, so it returns a broad, diluted audience. Seed quality (homogeneity and true value) drives lookalike performance more than raw seed size, which is why you seed on high-value converters, not all purchasers.
:::

# Suppression and exclusion are targeting in reverse

Half of audience operations is deciding who NOT to reach. Suppression is uploading an audience specifically to exclude it from delivery. The classic case is suppressing existing customers from an acquisition campaign: you are paying to find new buyers, so serving the prospecting ad to people who already bought is wasted spend and an annoyance. You onboard the customer list and attach it as an exclusion, not an inclusion.

Suppression and exclusion run on the same onboarding and match-rate machinery as targeting, just pointed the opposite way, which means match rate cuts both ways. If your customer suppression list matches at 70 percent, then 30 percent of your customers were not recognized and can still be served the acquisition ad. Suppression is only as complete as its match rate, so a leaky match means leaked spend on the very people you tried to exclude. Beyond customer suppression, exclusion handles converters mid-campaign (stop spending on someone who already converted), brand-safety and frequency exclusions, and legal or policy exclusions (do not serve a given audience a given creative).

The mental model that ties the whole module together: inclusion and exclusion are the same plumbing. Onboard, match, activate. The only difference is whether the resolved IDs go on the "reach these" list or the "never reach these" list, and in both directions, match rate is the number that decides how much of your intent actually takes effect.

:::predict
prompt: You build an addressable prospecting pool by onboarding a 2,000,000-record list at a 65 percent match rate. How many records are addressable?
answer: 1300000
tolerance: 0
unit:
hint: Multiply the records by the match rate.
explain: 2,000,000 x 0.65 = 1,300,000 addressable records. The other 700,000 did not resolve to a usable ID and are not in the segment, the same arithmetic that governs how complete a suppression list is when you point the process at exclusion instead.
:::

:::predict
prompt: You attach a 500,000-record customer suppression list that matches at 70 percent. How many of those customers are NOT recognized and could still receive the acquisition ad?
answer: 150000
tolerance: 0
unit:
hint: Find the unmatched share of the suppression list.
explain: Matched = 500,000 x 0.70 = 350,000 are suppressed. Unmatched = 500,000 - 350,000 = 150,000 customers were not recognized and can still be served the ad. Suppression is only as complete as its match rate, so a 70 percent match leaves 30 percent of customers exposed to wasted prospecting spend.
:::

:::sources
- LiveRamp, Match Rates (definition and formula) | https://docs.liveramp.com/connect/en/match-rates.html
- LiveRamp, Data Onboarding 101: Match Rates | https://liveramp.uk/blog/data-onboarding-101-match-rates/
- IAB Tech Lab, Audience Taxonomy | https://iabtechlab.com/standards/audience-taxonomy/
- IAB Tech Lab, Data Transparency Standard 1.0 | https://iabtechlab.com/wp-content/uploads/2019/06/Data-Transparency-Standard-1.0-Final-June-2019.pdf
- IAB, Understanding the Language of Data | https://www.iab.com/blog/understanding-the-language-of-data/
- LiveRamp, Interpreting RampID, LiveRamp's People-Based Identifier | https://docs.liveramp.com/identity/en/interpreting-rampid,-liveramp-s-people-based-identifier.html
- Meta Business Help Center, About Lookalike Audiences | https://www.facebook.com/business/help/164749007013531
:::
