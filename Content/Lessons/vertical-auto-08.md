---
id: vertical-auto-08
track: vertical-auto
module: 8
title: Attribution and VIN Matchback, Proving the Sale in the DMS/CRM
summary: Measure the net cost per sale KPI by running VIN matchback against ad exposure, choosing the right attribution window, and weighting view-through so good auto programmatic survives the dealer principal's scrutiny.
---
# Why VIN matchback is the only proof that counts

The dealer principal does not care about impressions, clicks, or even leads. They care about titled units sold and gross profit, which means the trader has to connect ad exposure to a specific VIN that left the lot. VIN matchback is the mechanic: you pull the list of sold VINs (with the buyer's hashed email or phone) from the dealer's DMS/CRM (VinSolutions, DealerSocket, CDK, Reynolds and Reynolds) and match those buyers back against the audiences your media exposed or clicked. The output is a defensible answer to the only question that matters, which is how do you know my media did that.

This is how you actually compute the net cost per sale KPI from Lesson 2, because matchback gives you the denominator (VIN-matched units) that a click or lead report never can. Lead-source fields in the DMS are typed by busy salespeople and are unreliable, so matchback on exposure data is the trustworthy path, not the rep-entered source.

:::figure attributionPaths
caption: VIN matchback joins the dealer's sold VINs (and hashed buyer identity) from the DMS/CRM against the IDs your media exposed or clicked, tracing which exposure and click paths led to each titled sale.
:::

:::predict
prompt: The DMS reports 120 VINs sold this month, and 78 of those buyers match to IDs your media exposed or clicked. What is the VIN match rate?
answer: 65
tolerance: 0.5
unit: %
hint: Match rate is matched VINs divided by total VINs sold.
explain: 78 / 120 = 0.65, a 65 percent VIN match rate. The other 35 percent are buyers your media never reached, or buyers who could not be matched because they were cookieless or had no consented hashed ID.
:::

# Doing the match privacy-safely

You cannot ship raw buyer PII to a platform, so matchback runs through the identity layer from Lesson 6. The dealer's sold records are hashed (email and phone) and either resolved to a durable ID like UID2 or matched inside a data clean room, where the dealer's records and the platform's exposure logs are joined without either side exposing raw PII. Attribution platforms integrate with CDK, Reynolds and Reynolds, DealerSocket, and VinSolutions over API or scheduled data export to pull the sold-VIN file on a cadence.

The consequence is that only matched, consented sold records can be attributed. Buyers who were cookieless, opted out, or had a typo'd email in the CRM silently drop out of the match, so the reported cost per sale always looks slightly worse than the true number. A trader states that caveat up front rather than letting the dealer discover an invisible tail of unmatched sales later.

:::quiz
question: Why does running VIN matchback through a clean room or hashed-ID match understate true campaign performance?
- Clean rooms add a tax that inflates the cost per sale
- Only matched, consented sold records can be credited, so unmatched sales are invisible
- View-through sales are double counted inside the clean room
- The DMS export drops the VIN field during hashing
answer: 1
hint: Think about which sold records can even enter the join.
explain: Only sold buyers who match to a consented, hashable ID can be attributed. Cookieless or opted-out buyers drop out of the join, so their sales never get credited and the reported cost per sale reads worse than reality. The clean room itself is not the tax, the match coverage is.
:::

# The attribution window: short windows lie

Over half of auto buyers take more than 90 days to decide, so the attribution window you choose decides how many sales you even see. A 7-day or 30-day window, borrowed from e-commerce habits, drops the long-consideration sales that are exactly the ones proving programmatic worked, badly undercounting ROI. Auto traders therefore run 30 to 90 day windows, and most defensible reporting leans to the 90-day end because that matches the real purchase cycle.

The window is not a cosmetic setting. The same campaign can look like a failure at 30 days and a clear winner at 90 days, purely because of where you draw the line. Match the window to the consideration length, then hold it constant so month-over-month comparisons stay honest.

:::predict
prompt: Over a 90-day window, matchback credits 50 sales to a CTV line. Run the same data on a 30-day window and only 34 of those sales fall inside it. What share of the true sales does the 30-day window capture?
answer: 68
tolerance: 0.5
unit: %
hint: Divide the short-window sales by the full-window sales.
explain: 34 / 50 = 0.68, so the 30-day window captures only 68 percent of the sales the 90-day window finds. The missing 32 percent are long-consideration buyers who saw the ad early and bought after day 30, exactly the sales that prove auto programmatic works.
:::

:::widget barChart
title: VIN-matched sales credited by attribution model
labels: Last-Click, Click + 30d View, Click + 60d View, Click + 90d View
data: 18, 34, 44, 50
unit: sales
:::

# View-through versus last-click

Nobody clicks a display or CTV ad and then buys a $40,000 vehicle in the same session. Auto influence is overwhelmingly view-through: the buyer sees the ad over weeks, then arrives at the VDP or the showroom later through a branded search or direct visit. A last-click-only model hands all the credit to that final touch and makes the upper-funnel display and CTV that built consideration look worthless, which is how good programmatic gets defunded. The fix is to weight view-through, not ignore it, while still distinguishing it from a direct click.

View-through share is simply the view-credited sales divided by total attributed sales, and in auto it is usually the majority of the credit. Reporting that number explicitly stops the dealer from collapsing a 90-day, multi-touch journey into a single last click.

:::predict
prompt: Matchback credits 50 sales total. Of those, 9 had a click before purchase and the other 41 were view-through only. What is the view-through share?
answer: 82
tolerance: 0.5
unit: %
hint: View-through share is view-credited sales divided by total attributed sales.
explain: 41 / 50 = 0.82, an 82 percent view-through share. In auto this is normal because buyers rarely click an ad then purchase in-session, so a last-click-only mandate would erase 82 percent of the sales your media actually influenced.
:::

:::callout warning
A recurring DealerRefresh pain point: salespeople log influenced deals as walk-in or to the wrong source in the DMS, so the trader's programmatic-influenced sales vanish from the report, and dealers then demand last-click proof for a 90-day multi-touch purchase. When the rep-entered source field is unreliable, matchback on exposure data is the only way to reclaim those miscredited sales, so never let a salesperson's dropdown be your attribution system of record.
:::

# Turning matched sales into the net-cost-per-sale story

Once you have VIN-matched units, the headline KPI falls out. Net cost per matched sale is media spend minus co-op reimbursement, divided by VIN-matched units, which ties this lesson back to the co-op compliance work in Lesson 9 because a denied reimbursement claim silently doubles this number. The formula is the deliverable the dealer principal actually reads.

$$ \text{Net cost per matched sale} = \frac{\text{media spend} - \text{co-op reimbursement}}{\text{VIN-matched units}} $$

Because a single rooftop sells tens of units a month, not thousands, this number is statistically noisy month to month, so you defend it with the higher-volume proxy ladder (cost per VDP view, cost per lead) underneath it rather than overreacting to one bad month.

:::predict
prompt: Media spend is $40,000, co-op reimburses $20,000, and matchback credits 80 VIN-matched sales. What is the net cost per matched sale?
answer: 250
tolerance: 1
unit: USD
hint: Subtract co-op from spend, then divide by matched units.
explain: (40,000 - 20,000) / 80 = 20,000 / 80 = $250 net cost per matched sale. Note the co-op halved the effective cost: at gross spend the cost per sale would have been 40,000 / 80 = $500, so quoting gross versus net materially changes the story.
:::

:::quiz
question: A trader reports a net cost per sale of $300 on a Vehicle Listing Ads line and $9,000 on a third-party portal line. What is the correct read?
- The portal is fine because it drives more total volume
- Shift budget from the high-CPS portal toward the efficient owned VLA line
- Both numbers are noise and should be ignored
- The VLA number must be wrong because it is too low
answer: 1
hint: The mandate is to drive blended net cost per sale down.
explain: VLA cost per sale runs roughly $150 to $450 while portals like Cars.com and AutoTrader run $8,000 to $12,000, so a $300 VLA line versus a $9,000 portal line is the expected gap. The trader's job is to shift budget from expensive lead-portal supply toward efficient owned-channel programmatic, then prove the improvement with matchback.
:::

# Diagnosing a spike: media, measurement, money, or the store

When net cost per sale jumps, a strong hire diagnoses the cause instead of just raising a bid. The cause sits in one of four buckets. Media: drift, audience fatigue, or a disapproved feed cutting eligible inventory. Measurement: a too-short window or DMS source mislogging hiding sales. Money: a denied co-op claim that doubled the net. Store: a slow BDC torching close rate on good leads, where sub-60-second response closes around 24 percent versus around 6 percent at 90-plus minutes.

The deliverable is routing each fix to the right owner with evidence. A measurement problem (window or matchback) is the trader's to fix, a money problem goes to co-op compliance, and a store problem (speed-to-lead, close rate) goes back to the GM, so the trader stops absorbing blame for leaks they do not own.

:::widget barChart
title: Net cost per sale by suspected cause vs baseline
labels: Baseline, Media Drift, Window Too Short, Denied Co-op, Slow BDC
data: 300, 420, 480, 600, 540
unit: USD
:::

:::quiz
question: Net cost per sale doubled this month, but VDP views, leads, and feed health all look normal and the OEM denied last month's co-op claim. Where does the fix belong?
- Raise bids across every line item immediately
- Cut the CTV line for poor view-through
- Shorten the attribution window to find more sales
- Route it to co-op compliance, because a denied claim doubled the net
answer: 3
hint: Walk the four buckets: media looks fine, so which one changed?
explain: With media proxies healthy and the feed clean, the spike is not a media problem. A denied co-op claim removes the reimbursement that halves the net cost per sale, so the gross effectively became the net. That is a compliance failure (Lesson 9) to route to the co-op owner, not a reason to raise bids or cut a working CTV line.
:::

:::sources
- Demand Local, How AI is Revolutionizing Attribution in Automotive Marketing (VIN matchback) | https://www.demandlocal.com/blog/ai-revolutionizing-attribution-automotive-marketing/
- Strolid, Lead Response Time: Why Speed Matters, Data Benchmarks | https://strolid.com/learn/lead-response-time-why-speed-matters-data-benchmarks
- Foundry CRO, Automotive Marketing Benchmarks 2026: CPC to Cost per Sale | https://foundrycro.com/blog/automotive-marketing-benchmarks-2026/
- Tealium, Sweeping Away Third Party Cookies with Data Clean Rooms | https://tealium.com/blog/data-strategy/sweeping-away-third-party-cookies-with-data-clean-rooms/
- Adtelligent, Top 10 ID Solutions For Ads In 2026 (UID2 explained) | https://adtelligent.com/blog/top-10-id-solutions/
- Dealer Spike, Maximizing Your OEM Co-Op Funds: A Comprehensive Guide for Dealerships | https://www.dealerspike.com/blog/maximizing-your-oem-co-op-funds-a-comprehensive-guide-for-dealerships/
- DealerRefresh, Why are third parties running Google VLA ads on MY vehicles? Shut it down! | https://forum.dealerrefresh.com/threads/why-are-third-parties-running-google-vla-ads-on-my-vehicles-shut-it-down.9894/
:::
