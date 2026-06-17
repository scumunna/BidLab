---
id: vertical-retail-08
track: vertical-retail
module: 8
title: Fees, Take-Rates, Margin and Financial Reconciliation, Working vs Gross Media and Spend-vs-Invoice
summary: Split gross media into working media and the ad-tech tax, reconcile console spend against the invoice, and prove on which dollar (gross or working) your ROAS and iROAS are actually being measured.
---
# Gross media, working media, and the dollar that buys an impression

Gross media is what the brand pays. Working media is what is left after every fee strips out, the portion that actually buys impressions in front of a shopper. On on-site sponsored search the gap is small because the retailer's auction takes a single integrated cut, but the moment you push an RMN audience off-site through a DSP the stack is brutal: a DSP take-rate, an exchange or SSP fee, a data or audience fee, then any agency margin on top. The buy-side operator owns this math end-to-end because the brand's commerce P&L is charged on gross while the campaign only performs on working.

$$ \text{working media} = \text{gross media} - (\text{DSP fee} + \text{exchange fee} + \text{data fee} + \text{agency margin}) $$

The single number that summarizes the leak is the working-media ratio, the share of every gross dollar that survives as qualified, impression-buying media. Its complement is the ad-tech tax. A trader who cannot state the working-media ratio for an off-site line cannot tell the CFO where the money went.

:::figure discrepancyWaterfall
caption: Gross media enters at the top and each intermediary (DSP, exchange, data, agency) takes a slice, leaving working media at the bottom. The slices removed are the ad-tech tax.
:::

:::predict
prompt: Gross media is $100,000 and total fees plus agency margin come to 40% of gross. How much working media actually reaches impressions?
answer: 60000
tolerance: 0
unit: USD
hint: Working media is the share of gross that survives after the fee load.
explain: Fees plus margin take 40% of $100,000, which is $40,000. Working media is $100,000 minus $40,000 = $60,000, a working-media ratio of 0.60.
:::

# The ad-tech tax, and why productivity is the bigger leak

The ad-tech tax is one minus the working-media ratio, the cumulative cut taken before a single impression is served. Five studies since 2015 put it between 30% and 60% of programmatic spend, and one US and Canada study found 48 cents of every dollar disappears into tech and fees. But transaction fees are only half the story. The ANA's Q1 2026 Programmatic Transparency Benchmark found the top cohort of advertisers converted 54.0% of programmatic spend into qualified impressions while the bottom cohort converted just 32.1%, a record 21.9 point gap, and the ANA's own framing is blunt: it is a quality gap, not a transaction cost gap.

$$ \text{ad-tech tax} = 1 - \frac{\text{working media}}{\text{gross media}} $$

That distinction reframes reconciliation for the trader. You are not only chasing the percentage skimmed by intermediaries, you are chasing media productivity, the non-viewable, non-measurable, and made-for-advertising inventory that quietly burns working media even after the fees are paid. The largest single move you can make on cost is not negotiating a lower DSP fee, it is cutting the low-quality supply that wastes the working media you already paid for.

:::widget donutChart
title: ANA Q1 2026 top-cohort working media vs ad-tech tax
labels: Working media reaching qualified impressions, DSP/exchange/data fees and lost productivity
data: 54, 46
unit: %
:::

:::predict
prompt: An off-site line posts a working-media ratio of 0.54. What is the ad-tech tax, rounded to the nearest percent?
answer: 46
tolerance: 0
unit: percent
hint: The tax is everything that does not survive as working media.
explain: Ad-tech tax is one minus the working-media ratio: 1 minus 0.54 = 0.46, which is 46%. Of every gross dollar on that line, 46 cents never reaches a qualified impression.
:::

# The reconciliation gap, console spend vs the invoice

The recurring operational job is reconciliation, because the number in the RMN console almost never equals the invoice. On Amazon, off-site and DSP spend, fees, make-goods, and timing or accrual differences historically lived outside Campaign Manager and surfaced only on the advertising invoice, so the console undercounted true spend. The reconciliation gap is simply the invoice minus what the console reported, and the operator's job is to attribute every dollar of that gap to a cause (off-site media, layered fees, or accrual timing) rather than letting it sit as an unexplained variance the brand's finance team will distrust.

$$ \text{reconciliation gap} = \text{invoice spend} - \text{console-reported spend} $$

A 2025 to 2026 change matters here: at unBoxed in November 2025 Amazon launched a unified Campaign Manager that merges Sponsored Ads and DSP into one console with consolidated invoices, which narrows the reporting split that caused much of the manual reconciliation pain. It does not erase the work. Amazon's own announcement does not address pricing or cost-structure implications, so the gross-vs-working split, accruals, and off-site fee layers still have to be reconstructed by the operator, just with fewer separate logins.

:::predict
prompt: Your console reports $80,000 of spend for the month, but the invoice (which folds in off-site media and stacked fees) comes to $92,000. What is the reconciliation gap?
answer: 12000
tolerance: 0
unit: USD
hint: The gap is what the invoice charges over what the console showed.
explain: Reconciliation gap is invoice minus console: $92,000 minus $80,000 = $12,000. That $12,000 is the off-site media and fee layer the on-site console never displayed, and it must be explained line by line.
:::

:::quiz
question: On Amazon, why does the advertising invoice frequently exceed what Campaign Manager reported as spend?
- The invoice double-bills sponsored search impressions
- Off-site/DSP spend and layered fees surface on the invoice but were not fully shown in the on-site console
- The console always overstates spend to flatter ROAS
- Invoices are denominated in a different currency than the console
answer: 1
hint: Think about which spend lives outside the on-site sponsored-search console.
explain: Off-site/DSP media plus DSP, exchange, and data fees historically appeared on the invoice rather than in Campaign Manager, so the invoice ran higher. The unified console narrows but does not fully close this; accruals and fee layers still need manual reconciliation.
:::

# Accruals, co-op funds, and where the trade P&L hides spend

Reconciliation is not just matching two final numbers, it is timing. An accrual is spend committed in a period but not yet invoiced in that period, and the operator books it so the brand's monthly close reflects committed media rather than only billed media. Miss the accrual and a heavy end-of-month flight looks like it cost nothing until the invoice lands weeks later, distorting both pacing and the P&L.

$$ \text{accrual} = \text{committed spend in period} - \text{amount invoiced in period} $$

A second hidden layer is funding source. Co-op, MDF (market development funds), and trade-fund dollars subsidize media from the brand's trade or shopper-marketing P&L rather than its media P&L, so the figure in the console can understate the true investment standing behind a SKU. A trader who reports only console media spend, ignoring the trade-funded portion, will hand the brand an efficiency picture that looks better than the real cash committed.

:::callout key
Two numbers must always tie out at close: committed spend (what you ran, captured as accruals) and billed spend (what the invoice charged). The reconciliation gap is the bridge between them, and every dollar of it should be labeled off-site media, fee layer, or timing, never left unexplained.
:::

:::predict
prompt: In March you commit $50,000 of media, but only $38,000 has been invoiced by month-end close. What accrual do you book for the period?
answer: 12000
tolerance: 0
unit: USD
hint: The accrual is committed spend that has not yet been invoiced.
explain: Accrual is committed minus invoiced: $50,000 minus $38,000 = $12,000. Without booking that $12,000, March's P&L understates media cost and the bill arrives as a surprise in April.
:::

# ROAS on working vs ROAS on gross, and the same trap for iROAS

The fee stack is not just an accounting nuisance, it silently changes every efficiency number you report, and which denominator you use decides whether the brand sees flattering math or honest math. ROAS computed on working media (attributed sales over working dollars) always looks better than ROAS on gross media (attributed sales over what the brand actually paid), because working media is the smaller denominator. The brand's CFO cares about gross, since gross is the cash that left the building, yet the off-site console often shows neither denominator cleanly.

$$ \text{ROAS}_{\text{gross}} = \frac{\text{attributed sales}}{\text{gross media}} \le \text{ROAS}_{\text{working}} = \frac{\text{attributed sales}}{\text{working media}} $$

The same trap applies to the signature retail-media KPI, iROAS (incremental ROAS), the return on only the sales the ad actually caused. An off-site line can post a respectable iROAS on working media and a much weaker one on gross, and the gap between the two is exactly the ad-tech tax you are paying for that incrementality. When a vendor quotes iROAS, the first operator question is always which dollar it sits on.

:::predict
prompt: An off-site campaign drives $45,000 of incremental sales (measured against a holdout) on $30,000 of gross media, and its working-media ratio is 0.60. What is the iROAS measured on gross media?
answer: 1.5
tolerance: 0.01
unit: x
hint: iROAS on gross divides incremental sales by the full gross spend.
explain: iROAS on gross is incremental sales over gross media: $45,000 divided by $30,000 = 1.5x. On working media of $30,000 times 0.60 = $18,000, the same incremental sales would read 45,000 / 18,000 = 2.5x, which is why the denominator you choose changes the story the vendor gets to tell.
:::

# Where the working-media ratio becomes unknowable

The cleanest reconciliation depends on a transparent fee structure, and not all DSPs give you one. The Trade Desk exposes its take-rate as a line-item fee, so the operator can split working from gross precisely and prove where the leak is. DV360's take-rate is bundled into the media cost and opaque, and it restricts log-level data far more than TTD, so the working-media ratio on a DV360 line can be genuinely unknowable. That is not a rounding problem, it is a structural blind spot the trader must flag rather than paper over with an assumed fee.

:::quiz
question: A buyer needs to prove the exact working-media ratio on an off-site line to a skeptical CFO. Which setup makes that hardest?
- The Trade Desk, where the take-rate is a visible line-item fee
- A DSP that exposes log-level data and an itemized fee
- DV360, where the take-rate is bundled into media cost and log-level access is restricted
- Any DSP, because working media can never be calculated
answer: 2
hint: One of these hides the fee inside the media cost and limits the underlying data.
explain: DV360 bundles its take-rate into the media cost and restricts log-level data, so the working-vs-gross split cannot be cleanly derived. TTD's line-item fee makes the same calculation straightforward, which is why fee transparency is a reconciliation requirement, not a nicety.
:::

:::callout warning
A recurring operator complaint: spend-vs-invoice numbers never tie out once off-site and fees are layered in, and on Amazon the pain sharpened when ad costs began auto-deducting from seller disbursements (ppc.land, 2026), forcing operators to rebuild ad spend by hand from monthly reports because the deduction scrambles the accounting. If you inherit an account, reconcile console against invoice against the API pull before you trust any ROAS print, and treat an unexplained gap as a red flag, not a rounding error.
:::

:::sources
- ANA, Q1 2026 Programmatic Transparency Benchmark (54.0% vs 32.1% qualified-impression gap; quality gap not cost gap) | https://www.ana.net/content/show/id/pr-2026-05-programmatic
- AdNews, Programmatic 'tech tax' costs 48 cents of every dollar (ANA study) | https://www.adnews.com.au/news/programmatic-tech-tax-costs-48-cents-of-every-dollar-ana-study
- ppc.land, Amazon ad costs to auto-deduct from seller proceeds; off-site spend invoice-only (reconciliation pain) | https://ppc.land/amazons-payment-grab-ad-costs-to-auto-deduct-from-seller-proceeds-april-15/
- ppc.land, Amazon unifies DSP and sponsored ads in single Campaign Manager platform (Nov 10, 2025) | https://ppc.land/amazon-unifies-dsp-and-sponsored-ads-in-single-campaign-manager-platform/
- Amazon Ads, Streamline campaign analysis with the new unified reporting (unBoxed 2025) | https://advertising.amazon.com/resources/whats-new/unboxed-2025-campaign-analysis-with-unified-reporting
- improvado, DV360 vs The Trade Desk (TTD fee itemized and passed through vs DV360 fee bundled/opaque; TTD provides log-level data) | https://improvado.io/blog/dv360-vs-the-trade-desk
- EMARKETER, US Retail Media 2026 Forecast (off-site growth, RMN structure) | https://www.emarketer.com/content/us-retail-media-advertising-forecast-2026
:::
