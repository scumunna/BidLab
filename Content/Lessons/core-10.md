---
id: core-10
track: core
module: 10
title: Fraud, viewability, and ad quality
summary: Invalid traffic and its two tiers, the MRC viewability standard, third-party verification, repricing on valid and viewable impressions, and the made-for-advertising trap.
---
# Not every impression is worth the same

A served impression is not the same as a useful one. An impression can be fired by a bot, rendered below the fold where no human ever sees it, or stuffed onto a junk page built only to carry ads. The job of ad quality measurement is to separate the impressions you should pay for from the ones you should not, and then to reprice your buy around what is left.

Three filters do most of the work. Invalid traffic detection removes the impressions that are not real human views. Viewability measurement keeps only the impressions a person actually had a chance to see. Brand suitability and made-for-advertising checks remove the impressions that technically rendered but sit in worthless or unsafe context. This lesson walks each filter and the math that connects them.

:::quiz
question: Why is a raw served-impression count a poor basis for judging a campaign?
- Served impressions cost nothing, so the count is meaningless
- An impression can be a bot, non-viewable, or on a junk page and still count as served
- Served impressions are always counted twice by the SSP
- The DSP hides the served count from the buyer
answer: 1
hint: Served only means the ad was delivered, not that a real person had a chance to see it.
explain: A served impression only confirms delivery. It says nothing about whether a human saw it, whether it was on screen, or whether the page was legitimate, which is exactly why IVT, viewability, and quality filters exist on top of the raw count.
:::

# Two tiers of invalid traffic

The Media Rating Council splits invalid traffic (IVT) into two tiers, and the distinction drives how it gets caught. General invalid traffic (GIVT) is the easy tier: it is caught by routine, list-based checks. Known bot user agents like Googlebot, data-center IP ranges, pre-fetch and pre-render activity, and clearly non-human patterns such as a click exactly every second all fall under GIVT. Any vendor can filter it with published lists and simple rules.

Sophisticated invalid traffic (SIVT) is the hard tier. It is built to look human and requires advanced analytics, multi-point corroboration, and often human investigation to catch. Hijacked devices, adware and malware-driven traffic, cookie stuffing, domain spoofing, human click farms, and bots that mimic real browsing all count as SIVT. Because it is harder to detect, MRC SIVT accreditation includes GIVT accreditation: if a vendor can catch the sophisticated kind, it can catch the routine kind too.

:::quiz
question: Which of these is sophisticated invalid traffic (SIVT) rather than general invalid traffic (GIVT)?
- A request from a known data-center IP range
- Traffic from the Googlebot user agent
- Domain spoofing that disguises a junk site as a premium one
- A browser pre-fetch that loads a page before the user clicks
answer: 2
hint: SIVT is the kind built to deceive, not the kind caught by a published list.
explain: Domain spoofing is SIVT because it actively disguises the inventory and takes advanced analytics to unmask. Data-center IPs, Googlebot, and pre-fetch are all GIVT, caught by routine list-based filtration.
:::

# The MRC viewability standard

Viewability has a precise, accredited definition, and the numbers are worth memorizing because they show up in every plan. For a standard display ad, the impression counts as viewable when at least 50 percent of its pixels are on screen for at least one continuous second. For video, the bar is the same 50 percent of pixels but for at least two continuous seconds of play.

$$ \text{display viewable} = 50\% \text{ pixels for } 1\text{s}, \quad \text{video viewable} = 50\% \text{ pixels for } 2\text{s} $$

There is one carve-out worth knowing: a large display ad, defined as 242,500 pixels or more, only needs 30 percent of its pixels on screen for one second, because a big unit is hard to fit fully in a viewport. A viewable rate well below the market is a signal to check ad placement and page layout, not just to renegotiate price. As a global reference point, DoubleVerify reported an authentic viewable rate of about 70 percent in its 2025 Global Insights Report.

:::quiz
question: Under the MRC standard, when does a standard video ad count as viewable?
- 100% of pixels on screen for 1 second
- 50% of pixels on screen for 1 second
- 50% of pixels on screen for 2 seconds
- 30% of pixels on screen for 2 seconds
answer: 2
hint: Video keeps the same pixel threshold as display but doubles the time.
explain: Standard video viewability is 50 percent of pixels on screen for at least 2 continuous seconds of play. Display uses 50 percent for 1 second, and the 30 percent threshold applies only to large display units of 242,500 pixels or more.
:::

# Repricing on valid and viewable impressions

The reason these filters matter to a trader is that they change the real price you pay. A CPM is quoted against served impressions, but the impressions you actually want are the valid, viewable ones. To find your true cost, divide the quoted CPM by the fraction that survives the filters.

$$ \text{effective CPM} = \frac{\text{quoted CPM}}{\text{valid rate} \times \text{viewable rate}} $$

This is why a cheap CPM on poor inventory can cost more per useful impression than a higher CPM on clean inventory. A $10 CPM at 70 percent viewable and 98 percent valid is really $10 divided by 0.686, or about $14.58 per valid and viewable thousand. The fix is to set valid and viewable as the buying currency, target placements that clear the standard, and let the cheap-but-wasted paths fall away.

:::predict
prompt: You buy display at an $8.00 CPM. Only 75% of those impressions are viewable. What is your effective CPM per thousand viewable impressions?
answer: 10.67
tolerance: 0.1
unit: $
hint: Divide the quoted CPM by the viewable rate.
explain: 8.00 / 0.75 = 10.67, so the real cost per thousand viewable impressions is about $10.67. The 25 percent that were never viewable still cost money, which is why a low headline CPM on low-viewability inventory can be the more expensive buy.
:::

# Verification and the IVT-adjusted cost

Buyers do not measure quality themselves. They rely on accredited third-party verification vendors, primarily DoubleVerify and Integral Ad Science (IAS), whose tags or server integrations measure viewability, filter invalid traffic, and score brand suitability on the same impression the buyer paid for. Their accreditation is what lets a trader treat the numbers as a buying currency rather than a vendor's marketing claim.

The most direct use is adjusting cost for invalid traffic. Spend is charged on served impressions, but only the valid impressions had any chance of working, so the IVT-adjusted cost spreads the same spend over fewer impressions. The dollars spent on the invalid share are simply wasted, and naming that number is how you justify cutting a bad path.

$$ \text{IVT-adjusted CPM} = \frac{\text{spend}}{\text{valid impressions} / 1000} $$

:::predict
prompt: You spend $6,000 on 1,000,000 served impressions (a $6.00 CPM). Verification flags 4% of them as invalid traffic. What is your effective CPM on the valid impressions only?
answer: 6.25
tolerance: 0.05
unit: $
hint: Find the valid impression count first, then divide the spend by that count in thousands.
explain: 4 percent of 1,000,000 is 40,000 invalid, leaving 960,000 valid. $6,000 / 960 = $6.25 effective CPM on valid impressions. Put another way, 4 percent of the $6,000, or $240, paid for traffic that could never convert.
:::

# Made for advertising and the quality trap

The last filter is context. A made-for-advertising (MFA) site exists only to carry ads: thin or scraped content, heavy ad load, and traffic often bought rather than earned. The impressions can be perfectly valid and even viewable, yet they deliver almost nothing because no real audience is engaged with the page. This is why the ANA benchmark counted MFA alongside invalid traffic as low-quality media, and why participating marketers cutting MFA spend from 15 percent to 6.2 percent was a headline result.

The problem is growing, not shrinking. Verification vendors now flag AI-generated slop sites, low-quality ad-heavy domains spun up at scale. In March 2026 the DoubleVerify Fraud Lab exposed a network it called AutoBait, a 200-plus domain MFA operation generating tens of millions of impressions. The defense is the same playbook as SPO: measure quality with an accredited vendor, blocklist the junk, and concentrate spend on inventory that passes valid, viewable, and suitable all at once.

:::quiz
question: What makes a made-for-advertising (MFA) site a quality problem even when its impressions are valid and viewable?
- The impressions are always bot traffic that verification missed
- The page exists only to carry ads, so a viewable impression still reaches no engaged audience
- MFA sites refuse to host verification tags
- MFA impressions are never counted by the SSP
answer: 1
hint: MFA can pass the IVT and viewability filters and still be worthless.
explain: MFA inventory can be technically valid and on screen, yet the page is built only to serve ads, so there is no real audience to reach. That is why quality measurement has to go beyond IVT and viewability to context and suitability.
:::

:::callout key
Treat valid and viewable as your buying currency, not served impressions. Divide the quoted CPM by the valid rate times the viewable rate to see your true cost, lean on accredited verification to measure it, and blocklist MFA so a clean-looking impression on a junk page never sets your price.
:::

:::sources
- MRC, Invalid Traffic Detection and Filtration Standards Addendum | https://mediaratingcouncil.org/sites/default/files/Standards/IVT%20Addendum%20Update%20062520.pdf
- Pixalate, MRC Definitions for Invalid Traffic SIVT and GIVT | https://www.pixalate.com/blog/mrc-definitions-sivt-givt-invalid-traffic-detection-filtration
- Publift, MRC Viewability Explained for Publishers | https://www.publift.com/blog/mrc-viewability
- DoubleVerify, 2025 Global Insights Report (North America) | https://doubleverify.com/company/newsroom/doubleverifys-2025-global-insights-report-uncovers-north-americas-shifting-digital-ad-landscape
- IAS, AI-generated slop sites as a major ad quality threat | https://ppc.land/ias-identifies-ai-generated-slop-sites-as-major-ad-quality-threat/
- DoubleVerify, Enhances Made for Advertising Measurement with Tiered Brand Suitability Categories | https://doubleverify.com/company/newsroom/doubleverify-enhances-proprietary-made-for-advertising-mfa-measurement-protection-solution-with-tiered-brand-suitability-categories
- ANA, ANA Releases 2024 Programmatic Benchmark Study | https://www.ana.net/content/show/id/pr-2024-12-programmatic
- DoubleVerify, Fraud Lab exposes AutoBait AI slop network | https://ppc.land/doubleverify-exposes-autobait-an-ai-slop-network-costing-advertisers-millions/
:::
