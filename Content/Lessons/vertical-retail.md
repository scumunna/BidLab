---
id: vertical-retail
track: retail
module: 1
title: Retail media: when the best ROAS is a lie
summary: Why closed-loop ROAS overstates value, and how iROAS, ACoS, and TACoS reveal the incremental truth.
---
# Retail media is its own auction

Retail media networks let brands buy ads inside the place where the purchase actually happens, the retailer's own site and app. Amazon, Walmart Connect, and dozens of others sell sponsored placements against their first-party transaction data. US retail media ad spend reached $60.32B in 2025 and is forecast at $71.09B in 2026, roughly 18% growth (eMarketer, Dec 2025). Globally the market hit $174.9B in 2025 and is projected at $196.7B in 2026, about 16% of all ad spend (WARC).

The market is concentrated. Amazon alone captures around 79.7% of US retail media, and Amazon plus Walmart together take close to 89% of net-new 2026 spend (eMarketer). For a buyer, this means most of your budget flows through a search-like keyword auction.

The two flavors matter. On-site placements, like Sponsored Products, sit at the bottom of the funnel and carry the highest reported ROAS. Off-site uses the retailer's first-party data to target the open web, social, and CTV for demand generation. The math you use to judge them is not the same.

:::widget donutChart
title: US retail media spend by network (illustrative shares)
labels: Amazon, Walmart Connect, All other networks
data: 79.7, 9.3, 11.0
:::

# Closed-loop attribution and why it flatters you

The selling point of retail media is closed-loop attribution. The retailer sees the ad and the purchase in its own deterministic first-party data, so it can tie a specific click to a specific checkout. That is far cleaner than the modeled attribution of the open web.

The trap is that sponsored placements intercept shoppers who were already going to buy. A high-intent shopper searching for your brand would often have converted anyway. So attributed ROAS counts revenue that was not actually caused by the ad. Incrementality is the antidote, and the industry agrees: in one ANA survey around 71% of advertisers ranked incrementality as their top measurement KPI, while a Coresight figure often cited puts the share of advertisers who do not fully trust retailer-reported metrics near 94%. Treat those two as directional signals of the trust gap, not precise constants.

$$ ROAS = \frac{Attributed\ Revenue}{Ad\ Spend} $$

$$ iROAS = \frac{Incremental\ Revenue}{Ad\ Spend} $$

Incremental revenue is the lift over a baseline: test-group sales minus control-group sales, measured with a geo holdout or PSA or ghost-bid control.

:::callout key
ROAS equals iROAS only when baseline organic sales are zero. Whenever shoppers would have bought without the ad, ROAS is greater than iROAS. The gap is the cannibalized organic sales you paid to claim.
:::

:::predict
prompt: A brand spends $500,000 on Sponsored Products and the platform reports a 5.0x ROAS. A geo holdout shows the true incremental ROAS is 2.3x. How much incremental revenue did the spend actually generate?
answer: 1150000
unit: $
hint: Incremental revenue is iROAS times ad spend, not the reported ROAS times ad spend.
explain: Incremental revenue = iROAS x spend = 2.3 x $500,000 = $1,150,000. The reported figure implied $2,500,000, so over half of the credited revenue was not caused by the ads.
:::

# ACoS and TACoS: the operating dials

Because sponsored placements run as a keyword CPC auction, the operative metrics look like search, not display. Advertising Cost of Sale (ACoS) is the inverse of ROAS expressed as a percent of attributed sales. Total Advertising Cost of Sale (TACoS) divides the same ad spend by total sales, including organic, which makes it a brand-health gauge rather than a campaign dial.

$$ ACoS = \frac{Ad\ Spend}{Attributed\ Sales} \times 100 $$

$$ TACoS = \frac{Ad\ Spend}{Total\ Sales} \times 100 $$

The rule of thumb is to keep ACoS below your product margin so each advertised sale stays profitable. For an established product a healthy TACoS often sits in the 5 to 10% range (Perpetua), but treat that as a guidepost, not a hard target.

:::predict
prompt: A campaign spends $30,000 and drives $150,000 in attributed sales. What is the ACoS?
answer: 20
unit: %
hint: ACoS is ad spend divided by attributed sales, times 100.
explain: ACoS = $30,000 / $150,000 x 100 = 20%. If the product margin is above 20%, the advertised sales are still profitable.
:::

:::predict
prompt: That same $30,000 in ad spend sits alongside $400,000 in total sales across all channels. What is the TACoS?
answer: 7.5
unit: %
hint: TACoS uses total sales, not just the ad-attributed portion.
explain: TACoS = $30,000 / $400,000 x 100 = 7.5%, comfortably inside the 5 to 10% healthy band for an established product.
:::

# Reading ROAS against iROAS

Put the two together and the cannibalization shows up as a number. Suppose a sponsored campaign spends $50,000 and is credited with $250,000 in attributed revenue, a clean 5.0x ROAS. But a holdout shows that $150,000 of that revenue would have happened organically. The incremental revenue is only $100,000, so the iROAS is 2.0x. Same campaign, very different verdict.

:::predict
prompt: A campaign spends $50,000 and is credited with $250,000 in attributed revenue. A holdout shows $150,000 of that revenue is organic baseline that would have happened anyway. What is the iROAS?
answer: 2.0
unit: x
tolerance: 0.05
hint: Incremental revenue is attributed revenue minus the organic baseline. iROAS divides that by spend.
explain: Incremental = $250,000 - $150,000 = $100,000. iROAS = $100,000 / $50,000 = 2.0x, far below the 5.0x reported ROAS.
:::

This is why incrementality testing reallocates budget. The best-ROAS channel is frequently the one cannibalizing the most organic demand, while upper-funnel off-site placements that look weak on attributed ROAS can carry the real incremental load and a higher new-to-brand share.

:::quiz
question: A retailer reports a 6.0x ROAS on a branded-keyword campaign, but a geo holdout shows iROAS of 1.4x. What is the most likely explanation?
- The ads mostly reached shoppers who would have purchased anyway, so attributed revenue overstates the lift
- The holdout test was run incorrectly and should be ignored
- ROAS and iROAS should always be equal, so one number is a typo
- Branded keywords always produce the highest incremental return
hint: Think about who searches a brand name, and whether the ad caused or merely captured the purchase.
answer: 0
explain: Branded-keyword shoppers are high intent and often convert without the ad. Closed-loop ROAS credits that organic revenue, so iROAS comes in far lower than reported ROAS.
:::

:::sources
- FAQ on Retail Media Networks, eMarketer | https://www.emarketer.com/content/faq-on-retail-media-networks-how-marketers-should-allocate-budgets-2026
- WARC Global Retail Media Ad Market 2025, via MediaBrief | https://mediabrief.com/warc-global-retail-media-ad-market-2025/
- ROAS Benchmarks by Platform and Ad Format 2026, Osmos | https://www.osmos.ai/blog/roas-benchmarks-platform-ad-format-2026
- Closed-Loop Attribution, Osmos | https://www.osmos.ai/blog/closed-loop-attribution-the-key-to-unlocking-higher-roas
- Quarterly Trends Report Q4 2025, Skai | https://skai.io/press-releases/quarterly-trends-report-q4-2025/
:::
