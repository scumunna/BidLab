---
id: sales-06
track: sales
module: 6
title: Margin and profitability
summary: Trace the ad-tech tax across the supply chain, compute blended margin and take rate, and see why fewer hops mean more working media.
---
# The ad-tech tax

For every dollar an advertiser spends, only part reaches the publisher. The rest is the ad-tech tax, the cumulative cut taken by intermediaries: the DSP, the SSP, exchanges, data vendors, and verification along the way. Each hop takes a slice, and the slices compound.

Typical take rates run around 10 percent each for a DSP and an SSP, but real supply chains chain many more parties. Industry studies have found cases where intermediaries absorb the large majority of spend, leaving a small fraction as working media, the money that actually buys impressions for the advertiser.

:::figure supplyChain
caption: Each hop between advertiser and publisher takes a slice. The DSP, SSP, exchange, data, and verification cuts compound into the ad-tech tax, leaving working media as the fraction that reaches the publisher.
:::

:::widget donutChart
title: Where the advertiser dollar goes (illustrative)
labels: Working media, DSP, SSP, Exchange, Data + verify
data: 36, 15, 18, 12, 19
unit: %
:::

# Take rate and working media

Take rate is the share of the money flowing through a platform that the platform keeps. If a buyer sends $10 through a DSP that keeps $1, the DSP take rate is 10 percent and $9 passes on. Working media is what survives all the take rates and reaches the publisher as real ad spend.

$$ Working = Spend \times \prod (1 - take_i) $$

The product matters more than the sum. Two intermediaries at 15 percent each do not take 30 percent, they take 1 minus (0.85 times 0.85), which is about 28 percent, and the gap widens as you add hops. Multiplicative fees stack into a tax that is hard to see from any single invoice.

:::callout warning
Take rates compound multiplicatively, not additively. Four 15 percent fees in a chain leave roughly 52 percent as working media, not 40 percent. Count the hops, not just the headline rate.
:::

:::predict
prompt: An advertiser spends $100,000 through a chain of a DSP at 10 percent, an SSP at 15 percent, and an exchange at 10 percent take rate. How much reaches the publisher as working media?
answer: 68850
unit: $
tolerance: 50
hint: Working media is spend times the product of the pass-through rates: (1 - 0.10) x (1 - 0.15) x (1 - 0.10).
explain: Working media = $100,000 x 0.90 x 0.85 x 0.90 = $100,000 x 0.6885 = $68,850. Adding the fees would suggest a 35 percent cut, but compounding leaves about 31.15 percent taken, so the multiplicative math is what counts.
:::

# Blended margin

Blended margin is your overall margin across a book of business that mixes deal types, models, and fee structures. A high-margin self-serve fee and a thin managed-service media resale average together into one blended number, which is what actually determines profitability.

Blended margin can hide problems. A few high-margin accounts can mask a portfolio of money-losing ones, and a healthy blended figure can erode quietly as the mix shifts toward lower-margin business. Watch the components, not just the blend, or you will miss the drift until it shows up in the total.

:::callout insight
Blended margin is an average, and averages conceal. A strong blend can hide unprofitable accounts, so monitor the mix that produces it, not the headline number alone.
:::

:::predict
prompt: A book has $600,000 of revenue at a 50 percent margin and $400,000 of revenue at a 10 percent margin. What is the blended margin across the whole book?
answer: 34
unit: %
hint: Blended margin is total gross profit divided by total revenue. Sum the profit from each slice first.
explain: Profit = $600,000 x 0.50 + $400,000 x 0.10 = $300,000 + $40,000 = $340,000. Blended margin = $340,000 / $1,000,000 x 100 = 34%. The thin-margin half drags the blend well below the headline 50 percent of the strong accounts.
:::

# Fewer hops, more value

Supply path optimization (SPO) is the practice of cutting unnecessary intermediaries between buyer and seller. Every hop removed reduces the multiplicative tax, so more of the buyer's dollar becomes working media and more of it reaches the publisher. The same dollar does more work on both sides.

This is why direct paths and curated deals matter for margin. Shortening the chain is one of the few moves that improves the buyer's efficiency and the publisher's yield at the same time. The modeler below lets you set take rates across the chain and watch working media and blended margin respond.

:::widget marginModeler
:::

:::quiz
question: Two intermediaries each take 15 percent of the spend that passes through them. What share reaches the publisher as working media?
- About 72 percent
- 70 percent
- 85 percent
- 30 percent
answer: 0
explain: Fees compound multiplicatively. The survival factor is 0.85 times 0.85, which is about 0.72, so roughly 72 percent reaches the publisher, not the 70 percent an additive 30 percent cut would imply.
:::

:::sources
- The Ad Tech Tax Explained, Gareth Glaser | https://www.garethhatesadtech.com/p/the-ad-tech-tax-explained
- SPO and the Path to Greener Ad Tech, Adweek | https://www.adweek.com/adweek-wire/spo-and-the-path-to-greener-ad-tech/
:::
