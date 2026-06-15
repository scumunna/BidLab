---
track: engineering
title: Engineering Certification
pass: 0.7
draw: 12
---
:::q Real-time Systems
question: Your bidder's mean response time is 22 milliseconds but its p99 is 96 milliseconds against a 100 millisecond exchange deadline. What is the main problem?
- The average response time is too high
- About 1% of requests are nearly timing out, forfeiting many auctions at high QPS
- The exchange deadline is set too short
- Network latency is irrelevant at this scale
answer: 1
explain: The tail, not the mean, sets your timeout rate. A p99 near the deadline means roughly one request in a hundred is lost, which is enormous at hundreds of thousands of queries per second. You manage the tail, not the average.
:::

:::q Real-time Systems
question: An exchange enforces a 100 millisecond deadline. With a 15 millisecond one-way network path and a 10 millisecond jitter margin, about how much compute budget does the bidder have left?
- About 75 milliseconds
- About 90 milliseconds
- About 60 milliseconds
- About 45 milliseconds
answer: 2
explain: Usable compute equals the deadline minus the round trip minus the margin. The round trip is twice the one-way path, so 100 minus 30 minus 10 equals 60 milliseconds. Placing servers closer to the exchange shrinks the round trip and buys back compute time.
:::

:::q Real-time Systems
question: When its request-scoped timer shows the deadline is close, a well-built bidder should do which of the following?
- Skip the response entirely to save compute
- Run the full model anyway and return slightly late
- Wait for the next request before responding
- Short-circuit to a cheaper heuristic bid and still return something inside the window
answer: 3
explain: A bid computed from a coarse estimate beats a perfect bid that arrives one millisecond late, because a late bid earns exactly zero. The bidder treats the deadline as a first-class input and falls back to a cheaper decision rather than blowing the budget.
:::

:::q Bidder Architecture
question: A DSP runs millions of active line items but must respond within milliseconds. How does the bidder narrow the field for a single impression?
- It scores every campaign in the account on every request
- Inverted indexes on targeting dimensions retrieve only the few campaigns that match
- It picks a random sample of campaigns to score
- It always bids the same single campaign
answer: 1
explain: Candidate selection is a retrieval problem, not a scan. Inverted indexes keyed on geo, device, inventory, and audience intersect to cut millions of campaigns to tens of candidates in microseconds, and only those survivors get expensive scoring.
:::

:::q Bidder Architecture
question: In a first-price auction, why does a bidder shade its bid below the impression's expected value?
- The exchange computes a lower clearing price automatically
- Shading is required by the OpenRTB specification
- The winner pays exactly what they bid, so bidding full value gives up margin
- A second-price auction rewards bidding above value
answer: 2
explain: In a first-price auction your submitted price is your clearing price, so bidding the full value leaves no surplus. The bidder bids the minimum it thinks will still win, and the gap between value and bid is the shade.
:::

:::q Bidder Architecture
question: In a PID pacing controller, what does the integral term contribute?
- It reacts only to the instantaneous spend error
- It accumulates past error to eliminate steady drift from the target spend curve
- It predicts future click-through rates
- It sets the campaign's total budget
answer: 1
explain: The integral term sums error over time, correcting persistent bias that a purely proportional controller would leave as a standing gap. The proportional term handles the current error and the derivative term damps overshoot.
:::

:::q Data & Identity
question: Two bidders both read a shared spend counter at 990 against a 1,000 cap, both bid, both win, and both write back without locking. What goes wrong?
- Nothing, because each server tracks its own budget independently
- The campaign stops immediately because the cap was reached
- The second write overwrites the first, so the system undercounts spend and overspends
- Both bids are rejected because the counter is locked
answer: 2
explain: Without an atomic read-modify-write, concurrent writes clobber each other. The lost update makes the system believe it spent less than it did, so it keeps bidding past the cap. An atomic increment or compare-and-swap serializes the updates.
:::

:::q Data & Identity
question: In an identity graph, what does resolving a single person to their devices correspond to?
- Sorting all identifiers alphabetically
- Finding the connected component of identifier nodes linked by edges
- Picking the identifier with the highest bid
- Deleting every probabilistic edge
answer: 1
explain: Identifiers are nodes and links are edges. One person is the cluster of nodes reachable from each other, the connected component, often maintained with a union-find structure for fast merges.
:::

:::q Reliability & Cost
question: Why is the most cost-efficient operating point for a bidder usually well below 100% utilization?
- As utilization approaches saturation, queueing makes tail latency explode and breaches the latency SLO
- Machines cannot physically run above 100%
- Lower utilization always means lower total cost
- The average latency rises linearly with utilization
answer: 0
explain: Cost per query falls as utilization rises, but near saturation queue depth and tail latency grow sharply, breaching the deadline and losing auctions. The efficient point is the highest utilization that still meets the latency SLO, which sits below full saturation.
:::

:::q Reliability & Cost
question: A bidder defines an SLO of 99.9% of requests answered within the timeout. What is the error budget this implies?
- 99.9% of requests may miss the timeout
- 0.1% of requests may miss the timeout
- Zero, since an SLO is a promise of perfection
- 1% of requests may miss the timeout
answer: 1
explain: The error budget is one minus the SLO. An SLO of 99.9 percent permits 0.1 percent of requests to miss, and that quota is what you spend on shipping features before you must stop and fix reliability.
:::

:::q Real-time Systems
question: An exchange enforces a 200 millisecond deadline. With a 25 millisecond one-way network path and a 15 millisecond jitter margin, about how much compute budget is left for the bidder?
- About 135 milliseconds
- About 160 milliseconds
- About 145 milliseconds
- About 110 milliseconds
answer: 0
explain: Usable compute equals the deadline minus the round trip minus the margin, and the round trip is twice the one-way path. So 200 minus 50 minus 15 equals 135 milliseconds. The one-way delay is paid in both directions, which is why proximity to the exchange buys back compute time.
:::

:::q Real-time Systems
question: A bidder runs at 600,000 queries per second and its p99 latency sits just above the exchange deadline, so the slowest 1% of requests time out. About how many auctions does it forfeit every second?
- About 600 auctions
- About 60,000 auctions
- About 600,000 auctions
- About 6,000 auctions
answer: 3
explain: A p99 above the deadline means 1% of traffic times out. One percent of 600,000 is 6,000 lost auctions every second. The mean can look perfectly healthy while the tail quietly forfeits thousands of auctions per second, which is why you manage the tail.
:::

:::q Real-time Systems
question: A request-scoped timer shows only 3 milliseconds remain before the deadline, but the full model forward pass usually takes 9 milliseconds. What should a well-built bidder do?
- Run the full model and return roughly 6 milliseconds late
- Fall back to a cheaper heuristic bid and return inside the window
- Drop the request and send no response at all
- Hold the request until the next refill of compute budget
answer: 1
explain: A late bid earns exactly zero, the same as no bid, so returning a coarse but timely estimate beats a perfect bid that misses the deadline. The bidder treats the clock as a first-class input and short-circuits to a cheaper decision when the timer runs low.
:::

:::q Bidder Architecture
question: A DSP must serve 240,000 queries per second. One instance safely handles 4,000 QPS, and the team targets 60% utilization. How many instances does the fleet need?
- 100 instances
- 60 instances
- 80 instances
- 150 instances
answer: 0
explain: The fleet size is total QPS divided by the effective per-instance capacity, which is the instance QPS times the target utilization. N equals 240,000 divided by (4,000 times 0.6), which is 240,000 divided by 2,400, which is 100 instances. Targeting 60% rather than 100% is what raises the count and buys tail-latency headroom.
:::

:::q Bidder Architecture
question: In a first-price auction you value an impression at $12.00 CPM but shade your submitted bid down to $8.00 CPM to preserve margin. You win and pay your bid. What is your margin per thousand impressions?
- $12.00
- $8.00
- $4.00
- $0.00
answer: 2
explain: First price means the winner pays exactly the submitted bid, so you pay $8.00 against a $12.00 value, leaving $4.00 CPM of margin. Bidding the full $12.00 value would still have won but left zero margin, which is why a first-price bidder shades below value.
:::

:::q Bidder Architecture
question: A campaign has a $48,000 daily budget and you pace it evenly across a 24 hour flight. What is the target spend per hour, the setpoint the pacing controller tracks?
- $4,800 per hour
- $1,200 per hour
- $2,400 per hour
- $2,000 per hour
answer: 3
explain: Even pacing divides the budget by the hours in the flight, so $48,000 divided by 24 equals $2,000 per hour. That straight-line setpoint is what the controller compares actual spend against each interval to compute its error.
:::

:::q Data & Identity
question: A streaming aggregation reads 1,200,000 records from the replayable log, but 80,000 of them are duplicate deliveries of events it already counted. After idempotent deduplication on event id, how many unique events does it count?
- 1,280,000
- 1,120,000
- 80,000
- 1,200,000
answer: 1
explain: Unique events equal the total records read minus the duplicates, so 1,200,000 minus 80,000 equals 1,120,000. Under at-least-once delivery the same event can arrive twice, so without dedup on a unique event id the consumer would inflate every aggregate by counting the repeats.
:::

:::q Data & Identity
question: One person appears under 6 unresolved identifiers, and you apply a frequency cap of 5 impressions per identifier. With no identity resolution, how many times can that single person see the ad?
- 30 times
- 5 times
- 11 times
- 6 times
answer: 0
explain: Each identifier is treated as a separate person and gets its own cap, so 6 identifiers times 5 impressions equals 30 exposures to one real person. Resolving the 6 fragments into one connected component collapses the effective cap back to 5, which is the point of an identity graph for frequency control.
:::

:::q Data & Identity
question: An identity graph holds 15 identifier nodes, and union-find resolves them into 4 connected components. How many distinct resolved people does that represent?
- 15 people
- 11 people
- 4 people
- 1 person
answer: 2
explain: Each connected component is one resolved entity, so 4 components means 4 resolved people across the 15 identifiers. It is the count of components, not the count of nodes, that tells you how many real individuals you are tracking.
:::

:::q Data & Identity
question: Two bidder servers each hold a per-window spend allowance of $4 in tokens, and the fleet has 200 such servers. Using the bound that worst-case overspend is the number of servers times the per-window allowance, what is the maximum overspend?
- $4
- $800
- $200
- $40,000
answer: 1
explain: The blast radius is bounded by N times the per-window allowance, so 200 servers times $4 equals $800 of worst-case overspend if every server spends its full allowance right at the cap. Halving the allowance to $2 would halve the bound to $400, at the cost of twice the reconciliation traffic.
:::

:::q Reliability & Cost
question: A streaming aggregation uses a 90 second window and adds 20 seconds of processing lag. Using the approximation that freshness equals the window plus the processing lag, how stale is the freshest available aggregate?
- 20 seconds
- 70 seconds
- 90 seconds
- 110 seconds
answer: 3
explain: Freshness is the window plus the processing lag, so 90 plus 20 equals 110 seconds. Shrinking the window improves freshness but makes each count noisier, which is the streaming tradeoff against the slower but exact batch path used for billing.
:::

:::q Reliability & Cost
question: A bidder fleet costs $8,000 to run while serving 16,000,000 queries. Expressed per thousand queries to match CPM units, what is the cost per thousand?
- $0.50
- $5.00
- $0.05
- $1.60
answer: 0
explain: Cost per query is total cost divided by queries, so $8,000 divided by 16,000,000 equals $0.0005 per query, and per thousand that is $0.50. If the bidder earns less than $0.50 of margin per thousand queries, it loses money on every auction no matter how clever the bid.
:::

:::q Reliability & Cost
question: A team sets an SLO of 99.99% of bid requests answered within the timeout. Using error budget equals one minus the SLO, what fraction of requests may miss the timeout?
- 99.99% of requests
- 1% of requests
- 0.01% of requests
- Zero, since an SLO promises perfection
answer: 2
explain: The error budget is one minus the SLO, so 100% minus 99.99% leaves 0.01% of requests that may miss the timeout. That small quota is what the team spends shipping features, and burning it quickly is the signal to stop and fix reliability.
:::

:::q Reliability & Cost
question: A bidder runs at 800,000 queries per second and its p99 latency exceeds the timeout, so the slowest 1% of requests fail. About how many requests fall in that p99 tail every second?
- About 800 requests
- About 8,000 requests
- About 80,000 requests
- About 800,000 requests
answer: 1
explain: The p99 tail is 1% of the request rate, so one percent of 800,000 is 8,000 requests every second landing in the tail and timing out. A healthy mean hides this entirely, which is why you alert on p99 and p99.9 rather than the average.
:::
