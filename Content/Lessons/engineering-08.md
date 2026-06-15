---
id: engineering-08
track: engineering
module: 8
title: Budget management systems
summary: How a distributed bidder spends a campaign budget exactly once without overspending, despite running on hundreds of independent machines.
---
# One budget, many machines

A campaign has one daily budget. The bidder that spends it runs on hundreds of servers, each handling its own slice of traffic at a million queries per second across the fleet. Every machine must decide, in under a millisecond, whether spending on the impression in front of it would breach the budget. There is no time to ask a central authority on every bid.

This is the core tension of budget systems. A single shared counter is correct but too slow. Fully independent counters are fast but overspend, because each server only sees its own spend and never the global total. Real systems sit in between: each server holds a local allowance and reconciles with the global truth on a short interval.

:::predict
prompt: A campaign's remaining budget is $50,000 and the pacing service divides it evenly across 100 bidder servers for the next interval. What local allowance does each server get?
answer: 500
unit: $
hint: Divide the remaining budget by the number of servers.
explain: Each server gets $50,000 / 100 = $500 to spend locally without checking the central counter. Smaller per-server allowances bound overspend more tightly but require more frequent reconciliation.
:::

# The race condition that costs money

Imagine two servers each read a shared spend counter at 990 dollars against a 1000 dollar cap. Both see headroom, both bid, both win, and both write back. The counter should read beyond the cap, but if the writes are not atomic the second write clobbers the first and the system believes it spent less than it did. The campaign overspends silently.

The fix is to make the read-modify-write atomic. A compare-and-swap loop or an atomic increment on a shared store (Redis `INCRBY`, a database `UPDATE ... SET spend = spend + x`) guarantees that concurrent updates serialize. The cost is a network round trip per update, which is why you batch many local spends into one atomic increment rather than calling the store on every win.

:::callout warning
The dangerous pattern is read, decide, then write back without locking. Under concurrency two bidders both pass the check and both spend. Always use an atomic increment or compare-and-swap so updates serialize instead of overwriting each other.
:::

:::predict
prompt: Two servers both read a spend counter at $990 against a $1,000 cap, each sees headroom, and each wins an impression costing $20. After both actually spend, how many dollars over the cap is the true total spend?
answer: 30
unit: $
hint: Add both $20 spends to the $990 starting point, then compare to the $1,000 cap.
explain: True spend = $990 + $20 + $20 = $1,030, which is $30 over the $1,000 cap. Without an atomic increment the counter may even read $1,010, hiding $20 of the overspend entirely.
:::

# The token-bucket allowance

A practical design gives each bidder a token bucket. A central pacing service forecasts traffic, divides the remaining budget into the remaining time, and hands each server a small allowance of spend tokens valid for a short window, say one second. The server bids freely until its tokens run out, then it throttles by lowering its bid or skipping auctions until the next refill.

Tokens leak back to the global pool when unspent, so a quiet server returns budget that a busy server can claim. The window is short enough that overspend is bounded: the worst case is one window of allowance across the fleet spent right at the cap, which you size to be a small fraction of the total.

$$ overspend \le N \times tokens_{window} $$

:::callout key
Bound the blast radius. With N servers each holding a per-window allowance, maximum overspend is the number of servers times the allowance. Shrink the window or the allowance to tighten the bound, at the cost of more frequent reconciliation traffic.
:::

:::predict
prompt: 200 bidder servers each hold a per-window allowance of $5 in spend tokens. Using overspend <= N x tokens_window, what is the worst-case overspend in dollars?
answer: 1000
unit: $
hint: Multiply the number of servers by the per-server window allowance.
explain: Worst case = 200 x $5 = $1,000 of overspend if every server spends its full allowance right at the cap. Halving the allowance to $2.50 would halve the bound to $500, at the cost of twice the reconciliation traffic.
:::

# Reading the algorithm

The widget below walks through a distributed budget controller: how it splits a global cap into per-server allowances, increments an atomic counter on each win, and applies a hard stop when the global spend crosses the cap. Trace how a delayed reconciliation lets a brief overspend slip through, and how the hard stop caps the damage.

:::widget codeLab
:::

The hard stop is your last line of defense. Pacing keeps spend smooth, the token bucket keeps it bounded, but a hard stop at the global counter guarantees the campaign halts the moment true spend crosses the cap, even if pacing misjudged the traffic.

:::quiz
question: Two bidders both read a shared spend counter at 990 against a 1000 cap, both bid, both win, and both write back without locking. What goes wrong?
- The second write overwrites the first, so the system undercounts spend and overspends
- Nothing, because each server tracks its own budget independently
- The campaign stops immediately because the cap was reached
- Both bids are rejected because the counter is locked
answer: 0
explain: Without an atomic read-modify-write, concurrent writes clobber each other. The lost update makes the system believe it spent less than it did, so it keeps bidding past the cap.
:::

:::sources
- A Practical Guide to Budget Pacing Algorithms in Digital Advertising | https://arxiv.org/pdf/2503.06942
- Real-Time Bidding with Smooth Budget Delivery in Online Advertising | https://arxiv.org/pdf/1305.3011
:::
