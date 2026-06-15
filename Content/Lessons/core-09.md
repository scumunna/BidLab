---
id: core-09
track: core
module: 9
title: Supply path optimization and the ad-tech tax
summary: The hops between a buyer and a publisher, the multiplicative take-rate tax, working media, supply path optimization from the buy side, and the transparency standards that make the chain visible.
---
# The chain between a buyer and a publisher

When a trader buys an impression, the money does not go straight from the DSP to the publisher. It passes through a chain of intermediaries, and every one of them takes a cut. A typical open-web path runs buyer to DSP to exchange or SSP to publisher, but in practice there can be resellers in the middle, and the same impression is often offered to the buyer through several different paths at once.

Each hop charges a fee, and the fees stack. The money that survives the chain and actually pays for media in front of a person is called working media. Everything the intermediaries keep is the ad-tech tax. The whole point of supply path optimization (SPO) is to shorten the chain, cut the duplicate paths, and push more of each dollar into working media.

:::figure supplyChain
caption: A bid request can reach a buyer through many paths, and each intermediary in a path takes a fee before the money reaches the publisher.
:::

# The take-rate tax is multiplicative

The trap in the supply chain is that take rates do not add, they compound. Each intermediary takes its percentage of what is left after the previous one took its cut, so you multiply the survival rates rather than subtracting the fees.

If a buyer spends one dollar and the DSP keeps 12 percent, the SSP keeps 15 percent, and the exchange keeps 8 percent, the working media is not one dollar minus 35 percent. It is the dollar multiplied by each survival rate in turn.

$$ \text{working media} = 1.00 \times (1 - 0.12) \times (1 - 0.15) \times (1 - 0.08) $$

That distinction matters because adding the fees would understate the real tax. Multiplying three survival rates always leaves less than subtracting the three fees, and the more hops you add, the wider the gap grows.

:::predict
prompt: A buyer spends $1.00. The DSP keeps 12%, the SSP keeps 15%, and the exchange keeps 8%, each taking its cut of what remains. How many cents of working media reach the publisher?
answer: 68.8
tolerance: 0.3
unit: $
hint: Multiply the survival rates, do not add the fees. 0.88 times 0.85 times 0.92.
explain: 1.00 times 0.88 times 0.85 times 0.92 = 0.688, so about 68.8 cents reach the publisher and the ad-tech tax is 31.2 cents. Note this is more than the 35 cents you would get by naively adding 12, 15, and 8, because the cuts compound on a shrinking base.
:::

# What the ANA found

The Association of National Advertisers ran a large open-web programmatic study to measure where the money actually goes. The first benchmark, published in late 2023, found that only about 36 cents of every dollar entering a DSP reached the consumer as working media. The rest split into roughly 29 cents of ad-tech fees and roughly 35 cents lost to low-quality media such as invalid traffic and made-for-advertising inventory.

The follow-up benchmark, published in December 2024, showed real progress. For every dollar entering a DSP, 43.9 percent reached the consumer, an improvement of 7.9 percentage points. The ANA framed the combined gain as about 22 percent more ad spend productivity, worth roughly $8.2 billion across a $104 billion open-web marketplace. Participating marketers also cut their made-for-advertising spend from 15 percent to 6.2 percent and shrank their domain lists from about 44,000 to 22,634.

:::widget barChart
title: Where each $1.00 entering a DSP went (ANA 2023 benchmark, illustrative)
labels: Working media, Ad-tech fees, Low-quality media
data: 36, 29, 35
unit: $
:::

# SPO from the buy side

Supply path optimization is the buyer choosing the cleanest, most direct route to each impression instead of bidding into every path on offer. The problem it solves is real: Jounce Media reported that an average RTB-enabled publisher integrates with around 24.5 sell-side platforms, and the number of distinct paths to a single impression can run as high as 600. Bidding into all of them wastes queries per second, duplicates the same inventory, and stacks extra fees with no benefit.

The buy-side move is to consolidate. Traders rank paths by fee level, directness, and clean metadata, then concentrate spend on a short list of preferred SSPs and direct routes such as The Trade Desk OpenPath. Jounce calls the routes that publishers control directly durable supply chains, and in early 2025 those paths carried about 64 percent of RTB bid requests while capturing roughly 69 percent of DSP gross ad spend. A word of caution from the buy side: cutting paths too aggressively can starve the optimization engine of supply, so SPO is about pruning duplicates, not collapsing to a single road.

:::quiz
question: From the buy side, what is the core action of supply path optimization?
- Bidding into every available path to maximize win rate
- Concentrating spend on a short list of direct, low-fee, clean paths
- Letting the SSP decide which publishers to buy
- Raising bids until the impression clears at any price
answer: 1
hint: The whole point is to cut duplicate and expensive hops, not to add more.
explain: SPO from the buy side means ranking paths by fee, directness, and data quality, then consolidating spend onto the cleanest direct routes. Bidding into all 600 possible paths is exactly the bidstream bloat that SPO exists to fix.
:::

# Measuring the SPO win

The payoff from SPO shows up as more working media per dollar. The ANA benchmark is the cleanest yardstick: working media rose from about 36 cents to 43.9 cents per dollar entering a DSP. You can read that gain two ways, and traders should know both.

The absolute gain is simply the difference in percentage points. The relative gain, which is what a productivity claim usually means, divides that difference by the starting point.

$$ \text{relative lift} = \frac{43.9 - 36}{36} $$

A relative lift describes how much more efficient the spend became, while the absolute gain describes how much more of each dollar now works. Mixing the two is a common way to overstate or understate a result, so always state which one you mean.

:::predict
prompt: Working media rose from 36 cents to 43.9 cents per dollar entering a DSP. What was the relative lift in working media?
answer: 21.9
tolerance: 0.4
unit: %
hint: Divide the gain in cents by the starting 36 cents.
explain: (43.9 - 36) / 36 = 7.9 / 36 = 0.219, about a 21.9 percent relative lift. The absolute gain is the smaller 7.9 percentage points, which is why the ANA's roughly 22 percent productivity figure is the relative measure, not the absolute one.
:::

# Making the chain visible: sellers.json and schain

SPO only works if you can see the chain, and two IAB Tech Lab standards make it visible. The first is sellers.json, a public file each SSP or exchange hosts that lists every entity it is allowed to sell or resell for, with each one's name, domain, and role (publisher, intermediary, or both). The second is the OpenRTB SupplyChain object, the schain, which travels inside each bid request and records the full ordered path. Every hop adds a node carrying its advertising system id (asi) and seller id (sid), and the nodes chain together in payment order.

Together with ads.txt and app-ads.txt on the publisher side, these standards let a buyer trace a bid request from the media owner all the way to the DSP and flag any hop that does not check out. A path with an unauthorized or unmatched node is exactly the kind of reseller hop that SPO is built to cut, both to save fees and to block spoofing and unauthorized resale.

:::quiz
question: What does the OpenRTB SupplyChain object (schain) carry inside a bid request?
- The advertiser's creative and bid price
- An ordered list of nodes, each with an asi and sid, recording the full path
- The user's third-party cookie and device id
- The publisher's floor price and deal id only
answer: 1
hint: It records the route the bid request traveled, hop by hop.
explain: The schain is an ordered chain of nodes, each holding an advertising system id (asi) and a seller id (sid), so a buyer can reconstruct the exact path from media owner to DSP. sellers.json is the companion lookup that says who each asi and sid actually is.
:::

:::callout key
The ad-tech tax compounds, so working media is a product of survival rates, not a sum of fees. SPO plus sellers.json and schain is how a buyer shortens the chain, cuts duplicate paths, and moves more of every dollar into media a real person can see.
:::

:::sources
- ANA, ANA Releases 2024 Programmatic Benchmark Study | https://www.ana.net/content/show/id/pr-2024-12-programmatic
- ANA, Programmatic Media Supply Chain Transparency Study Complete Report | https://www.ana.net/miccontent/show/id/rr-2023-12-ana-programmatic-media-supply-chain-transparency-study
- WFA, ANA's 2024 programmatic benchmark study, progress but challenges remain | https://wfanet.org/knowledge/item/2025/01/21/ana-s-2024-programmatic-benchmark-study-progress-but-challenges-remain
- IAB Tech Lab, sellers.json Supply Chain Transparency | https://iabtechlab.com/sellers-json/
- AdExchanger, AdExplainer What Is Supply-Path Optimization (SPO) | https://www.adexchanger.com/adexplainer/adexplainer-what-is-supply-path-optimization-spo/
- The Trade Desk, The trader's guide to supply path optimization | https://www.thetradedesk.com/resources/the-traders-guide-to-supply-path-optimization-spo
- Playwire, Key Takeaways from the Jounce Media March 2025 Report | https://www.playwire.com/blog/key-takeaways-from-the-jounce-media-march-2025-report
- AdMonsters, What Are Sellers.json and Supplychain Object | https://www.admonsters.com/sellers-json-supplychain-object/
:::
