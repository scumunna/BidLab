---
id: vertical-cpg-01
track: vertical-cpg
module: 1
title: The Money Map, CPG's Retail-Media-Led Programmatic Landscape
summary: Map where CPG ad dollars actually flow across onsite retail media, offsite programmatic, and the open exchange, learn the fee stack and the marginal-ROI lens, and see why fragmentation drives every downstream operational headache.
---
# Why CPG is the engine room of retail media

Consumer packaged goods is the demand that built the retail media boom, so before you touch a bid you need to know how big the pool is and who fills it. Per EMARKETER's December 2025 forecast (the single vintage this lesson anchors to), US retail media ad spend reaches $71.09B in 2026, up from $60.32B in 2025, and that growth outpaces both search and social. US CPG advertisers alone spend roughly $59B across channels, which is why a CPG trading desk is, in practice, a retail media trading desk. The first job is to stop treating "retail media" as one thing and start seeing the layers underneath it.

:::predict
prompt: US retail media ad spend is forecast at $71.09B in 2026, up from $60.32B in 2025 (EMARKETER, Dec 2025). What is the year over year growth rate, to one decimal?
answer: 17.9
tolerance: 0.2
unit: %
hint: Take the change over the base year, then divide by the base.
explain: The increase is $71.09B minus $60.32B, which is $10.77B. Divide by the 2025 base of $60.32B to get $10.77 / $60.32 = 0.17855$, or 17.855 percent, which rounds to 17.9 percent to one decimal. Note this is a growth rate, not an offsite share, and confusing the two is a classic briefing error.
:::

# The three-layer stack you will log into

A CPG "retail media plan" is never one buy. Layer one is ONSITE retail media: sponsored products, sponsored brands, and onsite display on Amazon, Walmart.com, Kroger, Target Roundel, and Instacart, bought inside each retailer's own ad console or API. Layer two is OFFSITE programmatic: the retailer's first-party shopper audiences activated on the open web, CTV, and audio through a DSP (Amazon DSP, Walmart DSP now opened beyond The Trade Desk, with Yahoo and Magnite as the first offsite partners (Vizio CTV via Magnite), Criteo Commerce Max and the Criteo grid, DV360, TTD). Layer three is open programmatic on the broad exchange, with no retailer audience attached. Onsite is endemic and console-driven, offsite is where genuine DSP, SSP, and PMP trading skill lives, and the two are bought in completely separate systems with different fees, auctions, and reporting.

:::figure retailMediaFlow
caption: The three-layer CPG stack. Onsite lives in each retailer's console, offsite activates retailer first-party audiences through a DSP onto the open web and CTV, and open programmatic buys the broad exchange with no retailer data attached. Three layers, three systems, three fee stacks.
:::

:::quiz
question: You need to activate a retailer's first-party shopper audience against premium CTV supply on the open web. Which layer of the stack are you working in?
- Onsite retail media, in the retailer's ad console
- Offsite programmatic, in a DSP
- Open programmatic, with no retailer audience attached
- None of these, CTV is never part of retail media
answer: 1
hint: First-party audiences belong to the retailer, but CTV supply lives outside the retailer's own site.
explain: Activating a retailer's first-party audience on supply outside the retailer's own properties (CTV, open web, audio) is the definition of offsite programmatic, bought in a DSP. Onsite is confined to the retailer's own site, and open programmatic carries no retailer audience at all.
:::

# Offsite is the growth edge

Offsite is the part of the stack that behaves like classic programmatic, and it is growing fastest. EMARKETER directly reports US offsite retail media at roughly $17.05B in 2026, up 29.5 percent year over year. Over a five-year horizon BCG puts offsite growth at about 35 percent per year against onsite at about 22 percent per year, so the trading-heavy layer is compounding faster than the console layer. A trader who can stand up and reconcile offsite lines is buying into the part of the market that is expanding, not the part that is maturing.

:::predict
prompt: EMARKETER directly reports US offsite retail media at $17.05B in 2026, up 29.5 percent year over year. What was the 2025 offsite figure, rounded to one decimal?
answer: 13.2
tolerance: 0.2
unit: billion USD
hint: This year equals last year times one plus the growth rate, so divide to invert it.
explain: If 2026 is 29.5 percent above 2025, then 2026 equals 2025 times 1.295. Invert it: $17.05 / 1.295 = 13.17$, which rounds to $13.2B. Do not back into this by multiplying a share percent against the $71.09B headline, because that mixes vintages and bases.
:::

:::callout key
Vintage discipline is a CPG trading habit, not a footnote. Always quote the directly reported offsite figure (around $17B) rather than deriving it from a share percent of the headline total. Some EMARKETER report updates cite 18.7 percent as a year over year growth rate against a slightly different total, and pinning that growth number to the wrong base is the classic briefing error a reviewer will catch.
:::

# Onsite and offsite are different businesses, not one budget

The two layers do not just live in different UIs, they have different economics, and that shapes where you push spend. BCG pegs onsite margins at 70 to 90 percent for the retailer, versus 20 to 40 percent offsite after media and fees, because offsite buys real inventory on the open web rather than selling the retailer's own shelf. On the buy side that fee stack is yours to manage: an open-web DSP buy carries roughly a 10 to 20 percent take rate, and Amazon DSP self-serve typically adds about 15 to 20 percent on top of the media cost. Every offsite dollar you traffic is therefore part working media and part fee, and you have to know the split to read true cost.

:::widget barChart
title: US retail and CPG-relevant ad spend by layer, 2026 estimate
labels: Onsite RMN, Offsite programmatic, Search, Social, Open display
data: 54, 17, 12, 11, 8
unit: USD billions (EMARKETER Dec 2025, offsite directly reported)
:::

:::predict
prompt: A CPG brand commits $500,000 of working media to an Amazon DSP offsite line, and the self-serve platform fee is 18 percent on top of media. What is the total the brand pays including the fee?
answer: 590000
tolerance: 1000
unit: USD
hint: The fee is charged on top of the media, so add 18 percent of the media to the media.
explain: The fee is 18 percent of $500,000, which is $90,000. Add it to the media: $500,000 plus $90,000 equals $590,000. The fee is real spend that buys no impressions, so the working-media share here is $500,000 / $590,000, about 84.7 percent.
:::

# The signature KPI, marginal ROI not blended ROAS

CPG trading is judged on incremental outcomes, and the number you will live by is mROI, the marginal return on the next dollar. mROI is the change in incremental revenue divided by the change in spend on a specific line, and it answers the only question that matters when you reallocate a flat budget: is the next dollar on this line still worth more than the hurdle. A line can post a gorgeous blended ROAS while its marginal dollar is already underwater, which is exactly how traders pour budget into saturated, non-incremental inventory. Later modules turn mROI into bid ceilings and budget shifts, but the mindset starts here.

$$ \text{mROI} = \frac{\Delta \text{ incremental revenue}}{\Delta \text{ spend}} $$

:::predict
prompt: A trader adds $50,000 of spend to an offsite prospecting line, and a lift read says that increment drove $80,000 of incremental revenue. What is the marginal ROI of that next dollar?
answer: 1.6
tolerance: 0.05
unit: ratio
hint: Divide the incremental revenue by the incremental spend.
explain: mROI is the change in incremental revenue over the change in spend, so $80{,}000 / 50{,}000 = 1.6$. That clears a typical 1.0 incremental hurdle, so the line earns more budget, unlike a saturated line whose marginal dollar would fall below 1.0 even when its blended ROAS still looks high.
:::

:::quiz
question: A stakeholder says "scale the line with the highest ROAS." Why is that instruction dangerous in CPG?
- Higher ROAS always means lower reach, so scaling shrinks the audience
- Blended ROAS can stay high while the line's marginal ROI has already dropped below the hurdle, so scaling pours budget into saturated, non-incremental inventory
- ROAS cannot legally be reported to brands under current privacy rules
- Higher ROAS lines are always offsite, which carry higher fees
answer: 1
hint: Think about the difference between an average over all dollars and the return on the very next dollar.
explain: Blended ROAS averages every dollar already spent, so it can look strong even when the next dollar (the marginal one) returns less than the hurdle. Scaling on blended ROAS is the most common CPG trading mistake because it funds saturated, often loyalty-heavy inventory that adds little incremental volume.
:::

# Fragmentation is the root cause of everything downstream

Here is the structural fact that explains most of the pain in later modules: every retailer is a walled garden with its own console, its own audiences, its own fee, and its own reporting, and almost nothing travels across them. The same household is counted separately by Amazon, Walmart, and Kroger, so a single brand plan fractures into two to five separate builds in two to five separate UIs, each one a chance for a spec, audience, or tracking mismatch. This is not a temporary annoyance, it is the shape of the job, and reconciliation across these systems is closer to a full-time function than a checkbox.

:::callout warning
The operator reality, in their words: a CPG marketing director widely cited in 2025 trade coverage described retail media as fragmented to the point of being a full-time reconciliation job, where "every platform lives in its own universe." The data backs the gripe. In ANA's July 2024 survey, 55 percent of marketers cited lack of standardization across retail media networks as their single biggest challenge, ahead of attribution to sales at 48 percent and data timeliness at 40 percent. Expect to spend real hours normalizing numbers that were never built to agree.
:::

:::quiz
question: Why can you not simply lift a Kroger first-party shopper segment into a Walmart offsite buy?
- Kroger and Walmart use incompatible CPM currencies
- Retailer first-party segments are walled-garden assets that do not port across retailers, so the same household must be rebuilt and re-matched in each retailer's environment
- Walmart only accepts third-party cookie audiences
- A regulation prohibits sharing audiences between grocers
answer: 1
hint: Think about who owns the shopper data and where it is allowed to live.
explain: Each retailer's first-party purchase data is a walled-garden asset that stays inside that retailer's console and clean room. It does not travel cross-retailer, so the same shopper has to be rebuilt and re-matched in every retailer's environment, which is a core reason CPG identity work is so labor-intensive.
:::

:::sources
- EMARKETER, Retail Media Ad Spending Forecast and Trends Report (Dec 2025 cut) | https://www.emarketer.com/content/retail-media-forecast-report-update
- EMARKETER, Offsite retail media ad spending is surging (US offsite ~$17.05B, +29.5% in 2026) | https://www.emarketer.com/content/offsite-programmatic-retail-media-ad-spending-surging
- BCG, How Retail Media Is Reshaping Retail (offsite ~35%/yr vs onsite ~22%/yr; margins 70-90% vs 20-40%) | https://web-assets.bcg.com/pdf-src/prod-live/how-media-is-shaping-retail.pdf
- ANA, Retail Media Networks: Optimism Tempered with Caution (55% cite lack of standardization; July 2024) | https://www.ana.net/miccontent/show/id/rr-2024-07-retail-media-networks-optimism-caution
- Digiday, Media agencies hope to drive down costs as Walmart opens up DSP roster | https://digiday.com/media-buying/media-agencies-hope-to-drive-down-costs-as-walmart-opens-up-dsp-roster/
- Osmos, Closed-Loop Attribution Deep Dive: Walmart vs Amazon vs Instacart | https://www.osmos.ai/blog/closed-loop-attribution-deep-dive-walmart-amazon-instacart
:::
