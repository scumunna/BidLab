---
id: adops-02
track: adops
module: 2
title: Trafficking a Campaign
summary: How a buy is built from advertiser down to creative, how line-item priority and CPM decide what serves, and how a third-party tag, a click tracker, and a landing URL fit together.
---
# From a signed IO to a live ad

Trafficking is the operational act of turning a signed deal into ads that actually serve. The deal arrives as an insertion order (IO), a contract that names the advertiser, the flight, the budget, the goal, and the targeting. Your job is to translate that paper into objects inside an ad server or a DSP so the right creative reaches the right user at the right pace.

Every platform uses the same nested shape: a top-level company that pays, a container for the deal, the rows that carry targeting and goals, and the assets that render. In Google Ad Manager that chain is Advertiser, then Order, then Line item, then Creative. In a demand-side platform (DSP) such as Display and Video 360 or The Trade Desk it is Advertiser, then Campaign, then Insertion Order, then Line item, then Creative. Different names, same idea: each level inherits and narrows the settings of the one above it.

:::figure lineItemTree
caption: A buy is built top down. The advertiser owns the order or campaign, the line items carry targeting and goals, and each line item holds one or more creatives.
:::

The line item is where the work lives. It is the set of instructions that says where the ad runs, who sees it, when it runs, how fast it spends, and how many times one person sees it. Everything above it is paperwork and grouping; everything below it is the pixels that render.

:::quiz
question: In a DSP like Display and Video 360, which object sits directly between the campaign and the line item?
- The creative
- The insertion order
- The advertiser
- The ad unit
answer: 1
hint: It is the budget-and-flight container that groups line items under a campaign.
explain: The DV360 hierarchy is Advertiser, Campaign, Insertion Order, Line item, Creative. The insertion order groups line items and carries budget and flight, sitting between the campaign and the line items.
:::

# Line-item types and priority

In an ad server, not every line item is equal. Google Ad Manager assigns each a type and a numeric priority, and the rule is simple: the lower the number, the higher the priority. Guaranteed demand sits at the top because you promised those impressions. Sponsorship is priority 4. Standard is priority 6, 8, or 10 (high, normal, low). Non-guaranteed remnant demand sits lower: Network, Bulk, and Price Priority are all priority 12, AdSense and Ad Exchange also compete at 12, and House line items fall to priority 16 so your own promos only fill what nothing else wanted.

Priority is the first gate, but it is not the whole story. When several eligible line items share the same priority, the tie is broken by value: among priority-12 remnant lines, Ad Manager ranks them by their value CPM and the highest-paying one wins. So priority decides the tier, and CPM decides the winner inside that tier. A priority-4 sponsorship at a 3 dollar CPM still beats a priority-12 price-priority line bidding 20 dollars, because priority is checked before price.

:::predict
prompt: Three line items are eligible for one impression: a Standard line item (priority 8) at a 5 dollar CPM, a Price Priority line item (priority 12) at a 14 dollar CPM, and a Network line item (priority 12) at an 11 dollar CPM. What CPM, in dollars, does the impression serve at?
answer: 5
unit: $
hint: Priority is checked first. Lower number wins before price is ever compared.
explain: Priority 8 beats priority 12, so the Standard line item wins the impression outright and serves at its 5 dollar CPM. The two priority-12 lines never get to compete because the higher-priority Standard line takes the impression first. Price only breaks ties within the same priority tier.
:::

:::callout key
Priority sorts the tier, CPM sorts within the tier. A higher-priority line beats a higher-paying line every time.
:::

# Goals, flights, frequency, and pacing

A line item carries a goal and a flight. The flight is the start and end date the line is allowed to serve. The goal is how much it must deliver: a guaranteed line books a fixed impression quantity, while a non-guaranteed line often runs to budget or as much as possible. Pacing decides how that goal is spread across the flight so you do not burn the budget on day one or under-deliver and owe a make-good.

The arithmetic of pacing is the heart of trafficking. To hit a guaranteed quantity evenly, you divide the remaining goal by the remaining days, then by the expected delivery within each day.

$$ \text{impressions per day} = \frac{\text{goal impressions}}{\text{flight days}} $$

A frequency cap then limits how many times one user sees the ad in a window, say three per day. Caps protect the user experience and stretch reach, but they also throttle delivery: a tight cap on thin inventory can starve a line and put it behind pace.

:::predict
prompt: A guaranteed line item is booked for 6,000,000 impressions over a 30-day flight, paced evenly. How many impressions per day must it deliver to finish on time?
answer: 200000
unit:
hint: Divide the total goal by the number of days in the flight.
explain: 6,000,000 / 30 = 200,000 impressions per day. If the line falls behind that daily number on any day, the remaining days must each carry more to catch up, or the line under-delivers and risks a make-good.
:::

:::quiz
question: A line item is pacing well behind its goal late in the flight. Which setting is the most likely throttle to investigate first?
- The advertiser name
- A frequency cap that is too tight for the available inventory
- The order's creation date
- The currency of the budget
answer: 1
hint: Think about what limits how many impressions a single eligible user can absorb.
explain: A frequency cap that is too tight relative to available inventory caps how many impressions each user can take, which starves delivery and leaves the line behind pace. Loosening the cap or widening targeting is the usual fix.
:::

# Competitive separation and roadblocks

Two controls govern who appears next to whom on a page. A competitive exclusion keeps rival brands apart: you apply the same competitive-exclusion label to two advertisers, and Ad Manager will not let their line items serve together on the same page. A same-advertiser exception lets line items from one advertiser co-serve even when the label would otherwise block them, which matters when one brand books multiple slots on a page.

A roadblock does the opposite. It forces a set of creatives to serve together so one advertiser owns every slot on the page at once, a full-page takeover. You traffic it as a roadblock line item whose creatives are set to deliver as a group rather than rotate, so the leaderboard, the rectangle, and the skin all come from the same buy in the same impression.

:::quiz
question: An advertiser buys every ad slot on the homepage for a single launch-day takeover, all creatives firing together. What are you trafficking?
- A competitive exclusion
- A roadblock
- A frequency cap
- A price-priority line item
answer: 1
hint: One advertiser wants to own every slot on the page in the same impression.
explain: A roadblock forces a set of creatives to serve together so one advertiser owns the whole page at once. A competitive exclusion does the reverse: it keeps rival advertisers from appearing on the same page.
:::

# Creatives: hosted versus third-party tags

A line item is useless until a creative is attached. There are two ways to attach one. A hosted creative is the asset itself (a JPG, GIF, PNG, or HTML5 bundle) uploaded into the ad server, which then hosts and serves the file and wires up click tracking for you. A third-party tag is a snippet of HTML or JavaScript the advertiser hands you that calls a different ad server, so the creative renders from the advertiser's own platform and your ad server only places the tag and counts the impression.

The trade-off is control versus convenience. Hosted creatives are simple and produce fewer discrepancies because one server does everything. Third-party tags let the advertiser swap creatives, rotate, and measure from their own stack without re-trafficking, at the cost of an extra server hop and the discrepancy that hop introduces.

:::quiz
question: An advertiser wants to rotate and optimize creatives from their own ad server without asking you to re-traffic each change. Which should you traffic?
- A hosted JPG uploaded to your ad server
- A third-party tag that calls the advertiser's ad server
- A roadblock creative set
- A house line item
answer: 1
hint: One option keeps the asset and its control on the advertiser's own platform.
explain: A third-party tag calls the advertiser's ad server, so they can rotate and optimize creatives on their side without you re-trafficking. A hosted creative would have to be re-uploaded by you for every change.
:::

# The click tracker versus the landing URL

The single most common trafficking mistake is confusing the two URLs in a click. They are not the same thing. The landing URL (also called the click-through or destination URL) is where the user ends up: the advertiser's page. The click tracker is the ad server's own redirect that sits in front of that landing page, counts the click, and then forwards the browser on. A real click fires the tracker first, logs the event, and only then lands the user.

For a hosted creative the ad server inserts its click tracker for you and you just type the landing URL into the destination field. For a third-party tag you have to insert the macro by hand. In Google Ad Manager the click macro is %%CLICK_URL_UNESC%%, placed immediately before the tag's own click-through URL so the chain becomes tracker, then destination. When the click tracker is itself a parameter inside another URL, you use the escaped form %%CLICK_URL_ESC%% so the redirect survives URL encoding. At serve time the ad server swaps the macro for a real redirect URL that counts the click and then sends the browser to the landing page. Forget the macro and the page still loads, but your click count stays at zero.

:::callout insight
If clicks report as zero on a third-party tag that clearly works when you test it, the click macro is almost always missing or in the wrong spot. The user reaches the page, but the ad server never saw the click because nothing routed through its tracker.
:::

:::predict
prompt: A line item served 2,000,000 impressions and the ad server logged 5,000 clicks through its click tracker. What is the click-through rate, as a percentage?
answer: 0.25
tolerance: 0.01
unit: %
hint: CTR is clicks divided by impressions, times 100.
explain: 5,000 / 2,000,000 = 0.0025, which is 0.25 percent. Those clicks only count because they passed through the ad server's click tracker before reaching the landing page. A missing click macro would have shown 0 clicks despite the same user behavior.
:::

:::sources
- Google Ad Manager Help, Line item types and priorities | https://support.google.com/admanager/answer/177279?hl=en
- Google Ad Manager Help, About orders and their settings | https://support.google.com/admanager/answer/9888302?hl=en
- Google Ad Manager Help, Prevent competitors from serving together | https://support.google.com/admanager/answer/6145371?hl=en
- Google Ad Manager Help, Develop and manage third-party creatives | https://support.google.com/admanager/answer/1746123?hl=en
- Google Ad Manager Help, Macros for click and event tracking | https://support.google.com/admanager/answer/2376981?hl=en
- Google Ad Manager Help, Creative doesn't track clicks | https://support.google.com/admanager/answer/177328?hl=en
- Display and Video 360 Help, Third-party display tags | https://support.google.com/displayvideo/answer/7129061?hl=en
- IAB, Programmatic glossary of terms | https://iniciativas.iabmexico.com/centro-de-recursos/programmatic/pdf/socios/GlossaryonProgrammatic-Google.pdf
:::
