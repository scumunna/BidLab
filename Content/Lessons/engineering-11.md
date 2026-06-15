---
id: engineering-11
track: engineering
module: 11
title: Fraud and quality systems
summary: How invalid-traffic detection works as a layered signal-processing pipeline, and why the easy fraud and the hard fraud need different defenses.
---
# Not every impression is a person

Invalid traffic (IVT) is any ad event that does not come from a real, interested human: search crawlers, data-center bots, click farms, hijacked devices, and spoofed inventory. The Media Rating Council (MRC) and IAB Tech Lab define and audit how platforms detect and filter it. If you do not filter IVT, you spend real budget on fake humans and report inflated results.

The MRC splits IVT into two tiers. General invalid traffic (GIVT) is the obvious, self-identifying kind: known bots, spiders, and data-center IPs that appear on public lists. Sophisticated invalid traffic (SIVT) hides: residential proxies, malware-driven devices, and bots tuned to mimic human behavior. The two tiers demand different machinery.

:::predict
prompt: A campaign serves 1,000,000 impressions and 6% of them turn out to be invalid traffic. How many impressions were wasted on non-human traffic?
answer: 60000
hint: Take 6% of the total impression count.
explain: 0.06 x 1,000,000 = 60,000 invalid impressions. Every one of those is real budget spent on fake humans and inflated reporting, which is why filtering IVT before billing matters.
:::

# GIVT: filter on known signals

GIVT detection is a lookup. You match each request against published lists, the IAB/ABC International Spiders and Bots List, data-center IP ranges, and known-bot user agents, and drop or flag matches. It is cheap, deterministic, and runs inline on every request because a hash-set membership test is fast.

GIVT filtering catches the background noise of the internet. It is necessary but not sufficient: any adversary willing to spend a little effort will not appear on a public list, which is exactly what SIVT is.

:::callout warning
A clean GIVT filter can give false confidence. It removes traffic that was never trying to hide. The fraud that actually drains budget is SIVT, which is designed to pass list-based filters, so a platform that only does GIVT is exposed where it matters most.
:::

:::predict
prompt: Total invalid traffic on a campaign is 5% of impressions. A list-based GIVT filter catches the self-identifying bots, which are 3% of impressions. What percentage of impressions is residual SIVT that the list lookup cannot catch?
answer: 2
unit: %
hint: Subtract the GIVT share from the total IVT share.
explain: Residual SIVT = 5% - 3% = 2% of impressions. That 2% is engineered to look human and passes the list lookup, so it requires behavioral scoring rather than a membership test.
:::

# SIVT: detection as signal processing

SIVT cannot be matched against a list because it is built to look human. Instead you treat each impression as a vector of dozens of signals (network features like ASN and proxy chains, behavioral features like click timing and mouse entropy, and consistency features like whether the device, timezone, and language agree) and score the likelihood that no genuine user produced this pattern.

The pipeline is layered. A fast inline stage scores cheap signals and blocks the obvious cases in real time, within the bid timeout. A slower offline stage runs heavier models and graph analysis over batches of traffic to catch coordinated patterns no single impression reveals, such as a thousand devices sharing one behavioral fingerprint. Offline findings feed back as new inline rules.

$$ P(invalid) = f(\theta_1 s_1 + \theta_2 s_2 + \cdots + \theta_n s_n) $$

:::callout key
Fraud detection trades latency against depth. Inline filtering must fit the bid timeout, so it uses cheap signals and a fast model. Offline analysis has time to find coordinated fraud across many events, then pushes what it learns back upstream as inline rules.
:::

:::predict
prompt: A fraud score weights three signals: theta1 = 0.5 on s1 = 2, theta2 = 1.0 on s2 = 1, and theta3 = 0.3 on s3 = 4. What is the weighted sum theta1*s1 + theta2*s2 + theta3*s3 that feeds the scoring function f?
answer: 3.2
tolerance: 0.05
hint: Multiply each weight by its signal, then add the three products.
explain: Sum = 0.5*2 + 1.0*1 + 0.3*4 = 1.0 + 1.0 + 1.2 = 3.2. The function f then maps this score to a probability of invalid traffic, which is compared against the operating threshold.
:::

# Tuning the threshold

Every scoring system picks a threshold above which traffic is judged invalid. Set it too low and you let fraud through (false negatives, wasted spend). Set it too high and you block real users (false positives, lost reach and unhappy advertisers). The right operating point depends on the cost of each error and is tuned against labeled traffic, with the threshold revisited as adversaries adapt.

:::widget codeLab
:::

:::quiz
question: Why can GIVT be filtered with a list lookup while SIVT requires behavioral scoring?
- GIVT self-identifies and appears on known lists, while SIVT is built to mimic humans and pass list-based filters
- GIVT is more dangerous than SIVT
- SIVT only occurs in connected TV
- GIVT requires machine learning and SIVT does not
answer: 0
explain: GIVT is non-human traffic that does not hide, so a membership test against known bots and data-center IPs catches it. SIVT is engineered to look human, so it must be scored on behavioral and consistency signals rather than matched to a list.
:::

:::sources
- MRC Invalid Traffic Detection and Filtration Guidelines Addendum, IAB | https://www.iab.com/guidelines/mrc-invalid-traffic-ivt-detection-and-filtration-guidelines-addendum/
- IAB/ABC International Spiders and Bots List, IAB Tech Lab | https://www.iab.com/guidelines/iab-abc-international-spiders-bots-list/
:::
