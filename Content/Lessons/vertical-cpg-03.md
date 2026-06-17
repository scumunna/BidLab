---
id: vertical-cpg-03
track: vertical-cpg
module: 3
title: What Counts as a Conversion, Attribution Windows, Match Rates, and Signal Reconciliation
summary: You will learn what a conversion operationally is in each CPG system, how to set attribution windows and read match rates, and how to reconcile onsite, clean-room, and proxy signals that never agree.
---
# The purchase happens off-platform, days later

In most verticals a conversion is a pixel firing on a thank-you page seconds after the click. In CPG it almost never is. The shopper sees your impression on Tuesday, walks into a Kroger on Saturday, and buys a box of crackers with cash, and no pixel ever fires. Because the purchase happens off-platform and on a delay, the trader does not get one clean conversion signal, they get three different signals that were built by three different systems and that will not agree.

Those three are onsite retailer-attributed sales (inside one walled garden, on a fixed lookback window), offsite clean-room matched sales (gated by a match rate), and open-web proxy outcomes (store-visit lift or panel and MMM estimates, which are directional only). Your job is not to pick a favorite. It is to know exactly which window, which match key, and which methodology produced each number before you compare them or roll them up.

:::predict
prompt: One real basket of crackers is bought once at Walmart. Under last-touch-inside-its-own-walls logic, an Amazon offsite line claims it, a Walmart line claims it, and the brand's MMM claims it. If you naively sum the three platform credits, how many MORE baskets do you report than were actually sold?
answer: 2
tolerance: 0
unit: baskets
hint: Sum the three platform credits, then subtract the one real basket that was actually purchased.
explain: Each system credits the same single basket once, so the naive sum is 1 plus 1 plus 1 equals 3 credited baskets against 1 real basket, an overcount of 2. This triple-count is the central reconciliation problem of the whole lesson, three systems each claiming the same off-platform sale.
:::

:::callout key
A CPG conversion is not one event, it is three non-comparable signals: onsite window-bound attributed sales, offsite match-rate-gated matched sales, and open-web proxy lift. The skill is reconciliation, not collection.
:::

# Onsite attribution is window-bound, and the window moved in 2026

Onsite, the retailer attributes the sale inside its own walls on a fixed lookback, and you mostly accept logic you cannot fully see. Amazon's offsite DSP delivery still runs the traditional 14-day click and 14-day view lookback, and Walmart Connect Sponsored Search defaults to a 14-day click window, with shorter 3-day and longer 30-day windows selectable in the Attribution dropdown (the 3-day option is often chosen for quick-decision grocery and household items on the fast CPG purchase cycle). Change the lookback and the same impressions report a different number of sales, which is why the window is a footnote on every report you send.

This is live, not theoretical. On January 1, 2026 Amazon changed its view-through attribution for Amazon Store ads (Sponsored Brands and Sponsored Display campaigns billed on a viewable-impression vCPM basis, plus Amazon DSP), retiring the old blind 14-day view-through approach in favor of a shopping-signal-enhanced last-touch model with a shorter view window that asks whether the ad actually influenced the purchase. Click-based attribution was left unchanged, and Sponsored Products, a click-attributed ad type, was not affected. Many advertisers saw double-digit declines in attributed DSP revenue in 2026 reporting even though real sales did not move. A trader who reads that drop as a media failure, rather than an attribution change, will cut a line that is performing fine.

:::predict
prompt: A campaign drove 10,000 onsite-attributed sales on a 14-day click window. Re-pulled on a 7-day window it shows 6,500. By how many sales does the shorter window reduce the reported count?
answer: 3500
tolerance: 0
unit: sales
hint: Subtract the shorter-window count from the longer-window count.
explain: 10,000 minus 6,500 equals 3,500. The same impressions drove the same real sales, the shorter lookback simply credits fewer of them. This is why you never compare a 14-day pull to a 7-day pull as if they were the same metric.
:::

# Offsite conversions are gated by the match rate

Offsite, the retailer verifies sales by matching your exposed audience back to its purchase data through a closed loop or clean room (Amazon Marketing Cloud, Walmart Luminate, or a neutral room like LiveRamp). The headline matched-conversion count is capped by the match rate, the share of records that actually resolve across the two identity schemas. In 2025 measurement, authenticated open-web match rates clustered in roughly the high-30s to high-40s percent by identifier (UID2 near 47 percent, RampID near 44 percent, ID5 near 39 percent), with the strongest authenticated open-web traffic stabilizing around 47 percent, well below the cookie-era benchmark of roughly 68 percent.

The operational consequence is the trap that catches every new CPG trader: a low matched-conversion number is frequently a match-rate artifact, not weak media. If only 35 percent of your exposed users resolved, your conversion count is mechanically suppressed before media quality even enters the picture. You check the match rate before you touch a bid.

$$ \text{matched conversions} = \text{exposed audience} \times \text{match rate} \times \text{in-window purchase rate} $$

:::predict
prompt: An offsite line exposes 2,000,000 matched-addressable users at a 45% clean-room match rate, and 3% of matched users purchase in-window. How many matched conversions are credited?
answer: 27000
tolerance: 0
unit: conversions
hint: Multiply the audience by the match rate, then by the in-window purchase rate.
explain: 2,000,000 times 0.45 equals 900,000 matched users, and 900,000 times 0.03 equals 27,000 matched conversions. The match rate is doing as much work in that count as the media is, which is exactly why you read it first.
:::

# Why two identical lines report different conversions

To make the match-rate trap concrete, run two lines with identical media and identical true buyer behavior, and change only the ID. Same 1,000,000 exposed users, same 3 percent true in-window purchase rate. One line resolves at a 35 percent match using a declining cookie or device ID, the other at 55 percent using an authenticated UID2 or RampID. The closed loop credits the higher-resolving line with far more conversions, even though not one extra real purchase happened.

That gap is pure measurement, and the lesson is that choosing the highest-resolving ID the supply supports is a conversion-count decision, not just a reach decision. The same logic feeds Lesson 7 on identity, where match rate also caps your addressable audience.

:::predict
prompt: Two lines each expose 1,000,000 users with a true 3% in-window purchase rate. Line A matches at 35%, Line B at 55%. How many MORE matched conversions does Line B report, with identical real buying?
answer: 6000
tolerance: 0
unit: conversions
hint: Compute matched conversions for each line, then take the difference.
explain: Line A is 1,000,000 times 0.35 times 0.03 equals 10,500. Line B is 1,000,000 times 0.55 times 0.03 equals 16,500. The difference is 6,000 conversions, all of it a match-rate artifact and zero of it incremental media.
:::

:::quiz
question: An offsite line shows a disappointingly low matched-conversion count. The clean-room match rate is 35%. What is the trader's first move?
- Lower the bid, the line is clearly underperforming
- Pause the line and reallocate the budget immediately
- Check whether a higher-resolving ID can raise the match rate before judging media
- Raise the frequency cap to force more conversions
answer: 2
hint: A low count at a low match rate may be measurement, not media.
explain: At a 35% match the count is mechanically suppressed, so the count is partly a match-rate artifact. The trader confirms the match rate and tests a higher-resolving ID before touching bids. Cutting the bid or pausing on a match-rate artifact throws away working media.
:::

# Open web has no closed loop, only proxies

On the broad open exchange there is no retailer to close the loop, so there is no matched-sales number at all. The trader falls back to proxy outcomes: detail-page-view lift, store-visit lift from location panels, or panel and MMM-based sales estimates. These are directional. They tell you a line probably moved something, not how many units sold to whom.

The reconciliation error reviewers catch instantly is presenting an open-web proxy next to a retailer-attributed sales number as if they were the same currency. A store-visit-lift estimate and a 14-day clean-room matched-sales count are not addable and not directly comparable, and stacking them in one total quietly fabricates precision the data does not have.

:::figure attributionPaths
caption: The same CPG campaign produces an onsite window-bound attributed-sales count, an offsite match-rate-gated matched-sales count, and an open-web proxy lift estimate. Three paths, three methodologies, one shopper, and they will not line up.
:::

# The same store sale gets claimed three times

The deepest problem is not that the numbers differ, it is that they overlap. Each retailer credits the sale last-touch inside its own walls, so one real box of crackers bought at Walmart can be claimed by an Amazon offsite line, a Walmart line, and the brand's MMM all at once. Add the platform numbers naively and you have triple-counted a single basket. The trader owns explaining that overlap, because nobody else in the chain is incentivized to.

This is why the same campaign produces an onsite 14-day attributed total, an offsite clean-room matched total, and an open-web proxy total that diverge so sharply. The documented mechanism is that platform-reported ROAS over-credits sales that would have happened anyway: one worked industry example runs $1,000,000 of retail-media spend at a reported 4.0x ROAS, or $4,000,000 in attributed sales, where 60 percent of those sales are non-incremental, leaving only $1,600,000 of true lift, a 1.6x incremental ROAS. Read illustratively, that is the gap between an Amazon line that reads around 4.2x, a Walmart line that reads around 3.8x, and an MMM that puts true incremental ROAS closer to 1.6x. Normalizing window, match methodology, and last-touch overlap before rolling anything up is the whole job, and it sets up the full four-system reconciliation in Lesson 8 and the signature CPG KPI, marginal ROI on the next dollar.

:::widget barChart
title: Conversions credited for ONE campaign by signal type (illustrative, non-comparable)
labels: Onsite 14-day attributed, Offsite clean-room matched, Open-web proxy store-visit
data: 10000, 4200, 2600
unit: conversions
:::

:::predict
prompt: An offsite prospecting line has spent $150,000 and the clean room credits 30,000 matched sales at a $9 average order value. The next $50,000 of spend yields only $40,000 of incremental revenue per a lift read. What is the marginal ROI (mROI) on that next dollar, and is it above the 1.0 hurdle?
answer: 0.8
tolerance: 0
unit: ratio
hint: mROI is the incremental revenue from the next spend divided by that next spend, not the blended return.
explain: mROI equals 40,000 divided by 50,000, which is 0.8. The blended line looks healthy, 30,000 times $9 is $270,000 on $150,000 spent for a 1.8x matched return, but the next dollar returns only 0.8, below the 1.0 hurdle. The trader caps the bid on this saturated line rather than scaling it, exactly the mistake the blended number invites.
:::

:::quiz
question: A trader rolls up an Amazon 14-day attributed-sales count, a Walmart Luminate clean-room matched count, and an Instacart short-window count into one "retail media conversions" total for the brand. What is wrong?
- Nothing, summing retailer conversions is standard practice
- The windows and attribution logic differ, so the total mixes non-comparable signals and likely double-counts shoppers
- Only the Instacart number is unreliable and should be dropped
- The total is fine as long as all three use clean rooms
answer: 1
hint: Different windows and last-touch-inside-its-own-walls logic do not add cleanly.
explain: Each retailer uses a different window and credits last-touch inside its own walls, so the same shopper can appear in two totals and the windows are not equivalent. Summing them mixes non-comparable signals and double-counts. You normalize window and match methodology, and account for overlap, before any roll-up.
:::

:::callout warning
Picture the recurring operator complaint as a constructed scenario that mirrors the dynamics above: "Amazon DSP shows 4.2x, Walmart Connect claims 3.8x, but our actual sales numbers don't add up, every platform lives in its own universe." The mechanics behind that frustration are documented in the cited sources: platform-reported ROAS over-credits non-incremental sales, so a low offsite conversion count is often a clean-room match-rate problem rather than a media problem, and each retailer's window and last-touch logic differs enough that apples-to-apples comparison across Amazon, Walmart, and Instacart is effectively impossible without manual normalization. Selling that explanation to brand stakeholders is itself part of the job.
:::

:::sources
- Amazon Ads, View-through attribution updates for Amazon Store ads | https://advertising.amazon.com/resources/whats-new/view-attribution-updates-for-amazon-store-ads
- Code3, Amazon Quietly Tightened Attribution and It's Changing How DSP Performance Is Measured | https://code3.com/resources/amazon-quietly-tightened-attribution-and-its-changing-how-dsp-performance-is-measured/
- Intentwise, Explained, How does Amazon attribute ad sales | https://www.intentwise.com/blog/ad-performance-optimization/explained-how-does-amazon-attribute-ad-sales/
- Osmos, Walmart vs Amazon vs Instacart Attribution 2026 Deep Dive | https://www.osmos.ai/blog/closed-loop-attribution-deep-dive-walmart-amazon-instacart
- DigitalApplied, Programmatic Advertising Statistics 2026 | https://www.digitalapplied.com/blog/programmatic-advertising-statistics-2026-data-points
- EMARKETER, FAQ on data clean rooms, how retail media is driving adoption | https://www.emarketer.com/content/faq-on-data-clean-rooms-how-retail-media-driving-adoption-marketers-demand-proof
- Dataslayer, Incrementality Becomes the Primary KPI for Retail Media Advertisers | https://www.dataslayer.ai/blog/incrementality-becomes-the-primary-kpi-for-retail-media-advertisers
- EMARKETER, FAQ on incrementality, how to prove your ads actually work in 2026 | https://www.emarketer.com/content/faq-on-incrementality-how-prove-your-ads-actually-work-2026
:::
