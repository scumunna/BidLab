---
id: vertical-finance-05
track: vertical-finance
module: 5
title: The Leaky Cascade: From Impression to KYC-Approved to Funded
summary: Instrument the long finance conversion funnel, locate the stage where spend evaporates, wire and QA web and mobile funded-account postbacks, and bid against funded-per-impression rather than clicks.
---
# The cascade is long and it leaks at every joint

In finance the path from a paid impression to a funded account is the longest of any vertical, and money drips out of every joint along the way. The full sequence runs impression to click to landing to application start to application complete to KYC submitted to KYC approved to funded (first deposit or first transaction). A campaign can post a strong click-through rate and a cheap cost per application and still produce almost no funded accounts, because the survivors collapse stage after stage. The signature KPI, cost per funded account (CPFA), is defined this deep on purpose: it is media spend divided only by accounts that opened AND put money in.

Each stage has its own conversion rate, and the rate the trader actually cares about is the product of all of them. If you index the survivors at each step, the shape is brutal: a million impressions can become eight thousand clicks, then twelve hundred application starts, then six hundred KYC submissions, then three hundred sixty approvals, then a hundred forty-four funded. That is the cascade you are buying against, not the top of the funnel.

:::figure funnel
caption: The finance acquisition cascade. Survivors fall at every stage, and the largest single leak sits between KYC approval and the first deposit, which is exactly where the funded KPI is defined.
:::

# The killer leak lives between KYC and first deposit

The defining measurement problem of finance acquisition is WHERE the funnel leaks, not just that it does. Average fintech onboarding drop-off runs about 63 percent, KYC abandonment alone can reach about 40 percent, and a KYC case left in pending review beyond roughly ten minutes sees the odds of ever funding fall off a cliff. The two formulas the trader watches are KYC drop-off, $1 - (\text{KYC approved} / \text{KYC submitted})$, and the funding leak, $1 - (\text{funded} / \text{KYC approved})$. Speed of KYC is a funded-rate lever, even though the trader rarely owns the KYC UX itself.

The job is three steps: instrument every stage so the drop-off is visible, diagnose which joint is bleeding (creative and landing versus application UX versus KYC friction versus the funding step), then feed the deepest reliable event back to the bidding system. A line that looks efficient at application complete can be quietly worthless if the KYC-to-funded leak is severe.

:::predict
prompt: A line drives 8,000 KYC submissions and 5,200 of them are approved. What is the KYC drop-off rate, in percent?
answer: 35
tolerance: 0.5
unit: %
hint: Drop-off is one minus the share approved.
explain: 5,200 / 8,000 = 0.65 approved, so drop-off = 1 - 0.65 = 0.35, a 35 percent KYC drop-off. More than a third of submitted applicants never clear verification, before a single dollar is deposited.
:::

:::predict
prompt: 5,000 users are KYC-approved but only 1,750 make a first deposit. What is the funding leak, the share of approved users who never fund, in percent?
answer: 65
tolerance: 0.5
unit: %
hint: The leak is one minus funded over approved.
explain: 1,750 / 5,000 = 0.35 fund, so the funding leak = 1 - 0.35 = 0.65, a 65 percent leak. Nearly two thirds of fully approved accounts still walk away before depositing, which is the gap the funded KPI is built to expose.
:::

# Cascade funded rate is the number that sets the bid

Multiply every stage rate together and you get the cascade funded rate, $\text{funded} / \text{impressions}$, which is the bridge from this lesson to the bid ceiling. It is a tiny number. A clean way to write the whole chain is the product of the stage conversions:

$$ \text{cascade funded rate} = \frac{\text{clicks}}{\text{impr}} \cdot \frac{\text{app start}}{\text{clicks}} \cdot \frac{\text{KYC sub}}{\text{app start}} \cdot \frac{\text{KYC appr}}{\text{KYC sub}} \cdot \frac{\text{funded}}{\text{KYC appr}} $$

This is why a leaky cascade forces bids DOWN. The maximum bid is the CPFA ceiling times funded-per-impression: $\text{target CPM} = \text{CPFA ceiling} \times (\text{funded} / \text{impr}) \times 1000$. Halve the funded rate through a KYC spike and the same ceiling implies half the affordable CPM. The trader who keeps bidding to a CPM computed on healthy-funnel assumptions overspends the moment drop-off worsens.

:::predict
prompt: A campaign runs 2,000,000 impressions and ends with 600 funded accounts. What is the cascade funded rate, funded per impression, in percent?
answer: 0.03
tolerance: 0.005
unit: %
hint: Divide funded by impressions, then convert to a percent.
explain: 600 / 2,000,000 = 0.0003 = 0.03 percent. At a $150 CPFA ceiling, the affordable CPM is 150 x 0.0003 x 1000 = $45.00. The squeeze shows up when you compare funnels rather than against any single price. A healthier cascade that funded twice as many, 1,200 of the same 2,000,000 impressions (0.06 percent), would justify 150 x 0.0006 x 1000 = $90.00 at the identical ceiling. The leak does not just lower the funded count, it halves the CPM the same ceiling can pay, so as drop-off worsens the affordable bid is forced down toward and then below the going rate for premium finance inventory, and a trader still bidding on healthy-funnel assumptions blows the CPFA cap.
:::

:::quiz
question: A finance DSP line is optimizing to "application complete" and shows a low cost per application. Why is this dangerous?
- It rewards the stages before the biggest leak, so it can scale junk that never funds
- Application complete is always more expensive than a funded account
- DSPs cannot optimize to application complete at all
- It double-counts every application as a funded account
answer: 0
hint: Think about where in the cascade the largest drop-off sits relative to the optimization event.
explain: The biggest leak is between KYC approval and first deposit, downstream of application complete. Optimizing to application complete rewards everything before that leak, so the model can happily scale cheap applications that never become funded accounts. Always reconcile a mid-funnel proxy back to funded.
:::

# Wiring the funded event: web pixel plus CAPI, mobile MMP plus SKAN

Event and postback QA is the operational core of the role. On WEB, the funded event fires server-side through a Conversions API (CAPI) so it survives ad-blockers and Safari ITP, deduplicated against the browser pixel by a shared event ID. On MOBILE, a mobile measurement partner (AppsFlyer, Adjust, Branch, Singular, or Kochava) attributes the install and the in-app funded event and sends a postback to each network. On iOS after ATT the deterministic ID is gone, so SKAdNetwork encodes the funded outcome into a coarse, delayed conversion value, and deferred deep links land the paid click on the correct onboarding step.

QA means firing a real test funded event end to end and confirming it lands in the DSP or MMP with the right value and the right event name, not assuming the tag works. Practitioners lose days hunting a funded postback that never arrived because the MMP event name did not match what the DSP expected. The dedup formula to keep in mind is $\text{postback dedup rate} = \text{deduplicated conversions} / (\text{web pixel} + \text{CAPI} + \text{MMP raw conversions})$.

:::figure pixelFire
caption: A funded conversion is wired twice on web, the browser pixel and the server CAPI, then deduplicated by a shared event ID so the same deposit is not counted as two funded accounts.
:::

:::quiz
question: On iOS after ATT, why can a trader not expect real-time, user-level funded attribution the way web allows?
- iOS apps are not allowed to track funded accounts at all
- SKAdNetwork collapses the funded signal into a coarse, delayed, aggregated conversion value
- MMPs do not support iOS
- The funded event must be entered manually by the user
answer: 1
hint: Apple, not the advertiser, controls the attribution and adds a delay.
explain: SKAdNetwork encodes post-install behavior into a small conversion value and fires privacy-preserving postbacks after delayed windows, so a funded signal on iOS arrives late and aggregated. Web keeps a deterministic pixel-plus-CAPI funnel, but iOS forces you to plan for coarse, delayed funded data.
:::

# CPFA is what the wired funnel actually buys

Once the funded event is trustworthy, CPFA is just $\text{total media spend} / \text{funded accounts}$, and every leak upstream pushes it up. The point of instrumenting the cascade is to make CPFA honest and to see, in advance, how a mid-funnel drop translates into a worse cost per funded account. Reconcile the deep event weekly, because finance funded signals are sparse and delayed and a daily read is noise.

A useful operator habit is to compute CPFA from a mid-funnel proxy and its conversion rate, so you can forecast the funded cost before the slow funded events finish landing. If you know KYC-approved volume and the historical approved-to-funded rate, you can project funded accounts and therefore CPFA without waiting days for every postback.

:::widget barChart
title: Finance acquisition cascade, survivors by stage (1,000,000 impressions indexed)
labels: Impression, Click, Application start, KYC submitted, KYC approved, Funded
data: 1000000, 8000, 1200, 600, 360, 144
unit: survivors
:::

:::predict
prompt: A line spends $90,000 and reaches 3,000 KYC-approved users, of whom 30 percent fund. What is the cost per funded account, in dollars?
answer: 100
tolerance: 1
unit: USD
hint: First get funded accounts from the approved count and the funding rate, then divide spend by funded.
explain: Funded accounts = 3,000 x 0.30 = 900. CPFA = $90,000 / 900 = $100. If the funding rate fell to 20 percent, funded would be 600 and CPFA would jump to $150, the same spend buying far fewer funded accounts.
:::

:::predict
prompt: A campaign spends $120,000 and produces 750 funded accounts. What is the cost per funded account, in dollars?
answer: 160
tolerance: 1
unit: USD
hint: CPFA is spend divided by funded accounts.
explain: $120,000 / 750 = $160 per funded account. Note the same spend at 600 funded would be $200 CPFA, so a 20 percent funded-rate slip moves CPFA by 25 percent.
:::

# Edge cases, org boundaries, and the QA traps that bite

The traps in this lesson are mostly definitional and organizational. A funded event mis-mapped to account opened, with no deposit, silently reintroduces the tire-kicker cohort the CPFA KPI was designed to eliminate, so verify the event DEFINITION in QA, not just that an event fires. Web pixel plus CAPI double-counts unless deduplicated by event ID, so a funded count that jumps after you add CAPI may be duplicates, not lift. And iOS SKAN postbacks arrive late and aggregated, so build the reporting cadence around delayed funded data rather than expecting a real-time read.

The hardest constraint is not technical. Fintech 30-day retention can sit near 4.5 percent with roughly 14 percent activation, proof that most signups never become durable funded customers, yet the trader who can SEE the funding leak usually cannot FIX it, because KYC is owned by risk and compliance.

:::quiz
question: You add the Conversions API (CAPI) alongside your existing web pixel, and reported funded accounts jump the next day. Before you call it incremental lift, what should you check first?
- Whether the SKAN postback window expanded
- Whether pixel and CAPI events are deduplicated by event ID, since the same funded event sent by both can double-count
- Whether the funded-event tolerance was loosened
- Whether risk and compliance changed the KYC flow overnight
answer: 1
hint: The same event can arrive twice, once from the browser and once from the server.
explain: A web pixel and CAPI often report the same funded event, so without deduplication by a shared event ID the platform counts it twice. A funded count that jumps right after CAPI goes live is usually duplicates, not lift. The other options do not explain a one-day, post-CAPI spike in funded counts.
:::

:::callout warning
Operator pain from the field: in most fintechs KYC is owned by risk and compliance, not growth, so the trader can measure the funding leak precisely and still be unable to touch the KYC UX that causes it. Practitioners also vent that post-ATT iOS reporting makes funded-event optimization feel like flying blind versus the deterministic web funnel. Instrument the cascade, surface the leak with data, and escalate it to the team that owns the step, because owning the dashboard is not the same as owning the fix.
:::

:::sources
- Veridas, KYC Funnel Loss and Customer Drop-off | https://veridas.com/en/kyc-funnel-loss-customer-drop-off/
- AppsFlyer, What is SKAdNetwork (SKAN)? MMP postbacks and deferred deep linking | https://www.appsflyer.com/glossary/skadnetwork/
- Singular, Server-to-Server SKAdNetwork 4 Implementation Guide | https://support.singular.net/hc/en-us/articles/13706627162395-Server-to-Server-SKAdNetwork-4-Implementation-Guide
- Meta, Conversions API and event deduplication | https://developers.facebook.com/docs/marketing-api/conversions-api/deduplicate-pixel-and-server-events/
- Epom, How to Reduce Ad Discrepancy | https://epom.com/blog/metrics/how-to-reduce-ad-discrepancy
- incrmntal, Understanding Incremental ROAS vs ROAS for Marketers | https://www.incrmntal.com/resources/understanding-incremental-roas-vs-roas-for-marketers
:::
