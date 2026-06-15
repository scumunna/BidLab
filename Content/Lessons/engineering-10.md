---
id: engineering-10
track: engineering
module: 10
title: Identity and graphs
summary: How a platform resolves cookies, mobile ad IDs, and UID2 into one person, and the graph data structures that make resolution fast.
---
# Many IDs, one person

A single person shows up under many identifiers: a cookie on their laptop browser, a different cookie on their phone browser, a mobile advertising ID (MAID) inside apps, a connected-TV device id, and a hashed email when they log in. None of these is the person. They are fragments. The job of identity resolution is to decide which fragments belong to the same individual or household.

Why it matters: frequency capping, attribution, and reach measurement all break if you treat one person as five. Without resolution you might show the same user an ad twenty times because each device looked like a fresh user.

:::predict
prompt: One person appears under 5 unresolved identifiers, and you apply a frequency cap of 4 impressions per identifier. With no identity resolution, how many times can that one person see the ad?
answer: 20
hint: Each identifier is treated as a separate person and gets its own cap.
explain: 5 identifiers x 4 impressions each = 20 exposures to one person. Resolving the 5 fragments into one entity collapses the cap back to 4, which is the whole point of an identity graph for frequency control.
:::

# Deterministic versus probabilistic links

A deterministic link joins two identifiers because the same logged-in signal connects them, for example two devices that signed in with the same hashed email. These links are high confidence. UID2, the email-based identifier that replaces third-party cookies, is deterministic: the email is salted, hashed, and encrypted into a token that the same person carries across the open internet and connected TV.

A probabilistic link infers a connection from shared signals, such as the same IP at the same times of day with similar behavior. These links are statistical guesses, useful for scale but lower confidence. Mature graphs lean on deterministic links for the spine and use probabilistic links to extend reach where deterministic data is missing.

:::callout insight
Deterministic links are precise but sparse, because they require a login event. Probabilistic links are abundant but noisy. The art is using deterministic edges as the trusted skeleton and probabilistic edges only to fill gaps, with a confidence score on every edge.
:::

:::widget donutChart
title: Typical identity-graph edge mix (illustrative)
data: 35, 65
labels: Deterministic (login-based), Probabilistic (inferred)
unit: %
:::

# The graph as a data structure

Model identifiers as nodes and links as weighted edges. Resolving a person means finding the connected component, the cluster of nodes reachable from each other, that represents one individual, and grouping those clusters again at the household level. A classic way to maintain these clusters online is a union-find (disjoint-set) structure, which merges two identifiers into the same set in near-constant amortized time.

The number of components is what you care about: each component is one resolved entity. Real graphs hold billions of nodes, so the structure must support fast merges and fast lookups while edges expire (cookies churn in weeks) and new ones arrive constantly.

$$ \alpha(node) \to root_{component} $$

:::predict
prompt: An identity graph holds 12 identifier nodes, and union-find resolves them into 3 connected components. How many distinct resolved people does that represent?
answer: 3
hint: Each connected component is one resolved entity.
explain: One person is one connected component, so 3 components means 3 resolved people across the 12 identifiers. The count of components, not the count of nodes, is the number of real entities you are tracking.
:::

# Edges decay, so must the graph

Identifiers are not stable. Cookies are deleted, MAIDs reset, and IP-based signals drift. An edge added today may be wrong next month. Production graphs therefore age out edges, recompute components on a schedule, and attach a recency and confidence weight to every link so that stale or weak edges contribute less to a match.

:::widget codeLab
:::

The privacy frame matters too. Deterministic identity rests on user consent (UID2 requires the user to provide their email), and resolution must honor opt-outs by removing a person's edges from the graph. A correct graph is one that can also forget.

:::callout key
Identity resolution is connected-components over a decaying, weighted graph. Deterministic edges form a trusted spine, probabilistic edges extend reach, and every edge carries a confidence and a timestamp so the graph can both match and forget.
:::

:::quiz
question: In an identity graph, what does resolving a single person to their devices correspond to?
- Finding the connected component of identifier nodes linked by edges
- Sorting all identifiers alphabetically
- Picking the identifier with the highest bid
- Deleting all probabilistic edges
answer: 0
explain: Identifiers are nodes and links are edges. One person is the cluster of nodes reachable from each other, the connected component, often maintained with a union-find structure for fast merges.
:::

:::sources
- How identity graphs are built, the present and the future, The Trade Desk | https://www.thetradedesk.com/resources/how-identity-graphs-are-built-the-present-and-the-future
- About Unified ID 2.0 | https://unifiedid.com/
:::
