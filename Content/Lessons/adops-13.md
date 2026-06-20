---
id: adops-13
track: adops
module: 13
title: Conversion pixels, step by step
summary: The trader's playbook for a web conversion pixel. Create it, place it on the confirmation page, set the attribution windows, QA that it fires, and troubleshoot the silent failures.
---
# From "the pixel exists" to "you built it"

A core-08 lesson covered the mechanics: what an image, a JavaScript tag, and an iframe can each see and do. An adops-03 lesson covered the delivery tags you traffic into a placement, the click and cachebuster macros that make impressions and clicks count. This lesson is the third piece, the one a trader owns from day one of a campaign: the conversion pixel on the advertiser's own site, the tag that tells the platform a click or a view turned into a sale.

A conversion pixel is not a delivery tracker. Impression and click tags count what the media did. The conversion pixel counts the outcome. It lives on the advertiser's site, not the publisher's page, and it fires when a user reaches a success state, a purchase, a signup, a completed lead form. Every number downstream of it, CPA, ROAS, and the bidder's own optimization model, is built on whether it fires correctly.

:::callout key
The conversion pixel is the one tag a trader cannot set and forget. A delivery tag failing costs you reporting. The conversion pixel failing costs you the optimization itself, because the bidder learns from conversions, so a broken pixel quietly trains the model on noise.
:::

:::quiz
question: What does a conversion pixel count that an impression tag and a click tracker do not?
- That the ad was served into the slot
- That the user clicked the creative
- That the user reached a success state, like a purchase or a signup
- That the ad was viewable for one second
answer: 2
hint: Delivery tags count what the media did. This one counts what the user did afterward.
explain: Impression and click tags measure delivery. The conversion pixel measures the outcome on the advertiser's site, a purchase, lead, or signup, which is what CPA, ROAS, and the optimization model are built on.
:::

# Step 1: Create the pixel and decide what it counts

You first create the pixel or activity in your platform, then choose its counting rule, and that second choice is the one that bites later.

In Campaign Manager 360 and DV360 you create a Floodlight activity and pick a counting method. A Counter counts events; a Sales activity counts events plus a revenue value and a quantity. The Counter has sub-modes: standard counts every fire, unique counts once per user per day, per-session counts once per session.

In The Trade Desk you create one Universal Pixel, then define Conversion events on top of it (Purchase, Lead, and so on), each with its own revenue and counting rule. In Meta you create a dataset in Events Manager, then define standard events such as Purchase, Lead, or CompleteRegistration, each carrying a value and a currency.

The rule of thumb: a lead is usually a Counter set to unique, because you do not want one person refreshing the thank-you page to log five leads. A purchase is a Sales activity that carries the order value and a unique order id, so revenue and deduplication both work. In a classic Floodlight tag this is the single most important field, the `ord=` value: for a Sales activity you set it to the order id (which deduplicates reloads), and for a Counter you set it to a random number (a cachebuster, so every genuine fire counts).

```
<!-- CM360 Floodlight sales tag: ord is the ORDER ID, so reloads dedupe -->
<img src="https://ad.doubleclick.net/ddm/activity/src=1234567;type=purch;cat=order;qty=1;cost=49.90;ord=ORDER-10231?" width="1" height="1" alt="">
```

:::predict
prompt: A Sales activity uses the order id as its ord value. 500 orders are placed, and 12% of buyers reload the confirmation page once. With the order id as the dedup key, how many conversions does the activity log?
answer: 500
tolerance: 0
unit:
hint: The order id is the deduplication key. Ask what a reload with the same order id does.
explain: Each order carries one unique order id, so a reload re-fires the tag with an id the platform has already seen and discards it. All 500 orders count once and the reloads add nothing. Swap the order id for a random number and those reloads would inflate the count.
:::

# Step 2: Place it, the sitewide tag plus the event on the success page

Deployment is two pieces in two places. The global site tag (the library) goes sitewide, in the `<head>` of every page, so it can set first-party cookies and stand ready to fire. The event snippet goes on exactly one page, the confirmation or thank-you page that loads after the success state.

The clean way to deploy both is a tag manager such as Google Tag Manager. You add the global tag as a tag that fires on All Pages, then add the conversion event as a tag whose trigger is scoped to the confirmation page, or better, to a `dataLayer` event the site pushes only when the order is truly confirmed.

```
// the site pushes this ONLY after the order is confirmed (ideally server-confirmed)
dataLayer.push({
  event: 'purchase',
  value: 49.90,
  currency: 'USD',
  transaction_id: 'ORDER-10231'   // the dedup key the conversion tag reads
});
```

The conversion tag in GTM then fires on a Custom Event trigger matching `purchase`, reading `value` and `transaction_id` from dataLayer variables. The order id rides along as the deduplication key, exactly as in Step 1.

:::callout warning
Fire on the success event, not the button click. A "Place order" click is not a sale: the payment can still fail, and the user can double-click. Bind the conversion to the confirmation-page load or a server-confirmed dataLayer event. Bind it to the button and you inflate conversions and train the bidder toward clicks that never pay.
:::

:::quiz
question: Where does the conversion event snippet belong?
- In the head of every page, sitewide
- On the confirmation page that loads after the success state
- On the click handler of the "Place order" button
- On the product detail page
answer: 1
hint: One piece is sitewide and one fires once. This is the one that fires once.
explain: The global tag is the sitewide library; the event snippet fires on the confirmation page, the proven success state. Putting it sitewide double-counts, and putting it on the button counts orders that may never complete payment.
:::

# Step 3: Set the attribution windows

A conversion pixel does not credit in a vacuum. The platform credits a conversion back to a prior ad event only if it falls inside the lookback window, and the window has two flavors.

The click-through window credits a conversion to a click within some span, often 30 days. This is the strong signal: the user clicked, then converted. The view-through window credits a conversion to an impression the user saw but did not click, and it is set much shorter, with one day a common default (Meta moved view-through to one day; CM360 lets you set both independently).

Wider windows credit more conversions to your media, which flatters CPA and ROAS, but they also claim sales the ad may not have caused. The trader sets the window to match the sales cycle and the measurement philosophy, then holds it constant so trends stay comparable.

$$ \text{reported conversions} = \text{click-through (within } W_c) + \text{view-through (within } W_v) $$

:::predict
prompt: A campaign drives 1,000 conversions inside its 30-day click-through window. Turning on a 1-day view-through window books an extra 250 view-through conversions. By what percent does reported conversions rise?
answer: 25
tolerance: 0.5
unit: %
hint: The view-through additions over the click-through base.
explain: 250 / 1,000 = 0.25, a 25 percent rise. None of the underlying sales changed; widening the window simply credited more of them to this campaign, which is why two traders on different windows are not comparing the same CPA.
:::

:::callout insight
A longer window is not free accuracy. It books later, weaker conversions to the campaign, so a CPA measured on a 30-day click plus 1-day view is not the same metric as one on a 7-day click. Lock the window before you judge performance.
:::

# Step 4: QA, fire a test and prove it fires

Never release budget on an unproven pixel. The QA pass is a fixed routine, and you do all of it before spend goes live.

First, fire a real test conversion end to end. Click a live ad (or use the platform's test mode), complete the conversion on the site, and reach the confirmation page yourself.

Then watch it fire. Open the browser devtools Network tab and filter for the tag request, or use Google Tag Assistant or the Meta Pixel Helper, and confirm the request goes out and returns a 200.

Next, check the payload. The value and the order id must be present and correct, not `0`, not `undefined`, not an unpopulated template placeholder that shipped to production.

Then confirm it fires once. Reload the confirmation page and check that the dedup key holds, or that a unique counter does not log a second conversion.

Finally, confirm it lands in the platform. The conversion appears in real-time reporting, Events Manager, or Floodlight with the right activity, value, and id. Only when all five pass do you turn on budget.

:::predict
prompt: Your test fires cleanly. On the first day live, the pixel reports 920 purchases while the store's own checkout back-end recorded 1,000. What is the pixel's capture rate?
answer: 92
tolerance: 0.5
unit: %
hint: Divide what the pixel saw by the back-end truth.
explain: 920 / 1,000 = 0.92, a 92 percent capture rate. The missing 8 percent is the everyday leakage from ad blockers, tracking protection, and users who bounce before the tag fires, and it is exactly what the server-side path in the next lesson recovers.
:::

:::quiz
question: During the test fire, which single thing matters most to verify?
- That the activity name is spelled correctly
- That the value and the order id are populated, not zero or undefined
- That the pixel loads on the homepage too
- That the creative rendered above the fold
answer: 1
hint: Reporting and dedup both depend on two fields arriving correctly.
explain: A pixel that fires but sends value 0 or a missing order id breaks revenue, ROAS, and deduplication at once. Confirming the populated value and order id is the heart of the QA, more than the name or where else it loads.
:::

# Step 5: Troubleshoot the silent failures

Like the delivery tags in adops-03, conversion pixels fail silently. The page looks fine, the campaign keeps spending, and only the numbers are wrong. Five failures account for most of what you will hit.

Not firing at all. The snippet is on the wrong page, a JavaScript error earlier on the page halts the script, or a consent gate blocks the tag until the user accepts and that consent never comes. The symptom is near-zero conversions on a campaign that is plainly driving sales.

The single-page-app trap. On an SPA the confirmation "page" is a client-side route change, not a real page load, so a tag bound to page load never fires. You have to bind it to the route change or to a dataLayer event the app pushes on confirmation.

Blocked by the user. Ad blockers and browser tracking protection strip the client pixel for a meaningful share of traffic. This is loss, not a bug, and it is the reason the next lesson moves measurement to the server.

Double counting. The event snippet leaked onto more than the confirmation page, or there is no unique key, so reloads and back-button navigations re-fire it. The symptom is conversions above the back-end truth and a ROAS that looks too good to be true.

Zero or wrong value. The dataLayer was not populated at the moment the tag read it, a race condition, so the value arrives as 0 or undefined. The symptom is conversions that count but revenue and ROAS that come back blank or tiny.

The discipline is the one from adops-03: when the pixel disagrees with the advertiser's own back-end by more than the roughly 10 percent that is normal counting drift, suspect the implementation before you blame the media.

:::predict
prompt: The conversion tag was placed on both the confirmation page and the order-history page, with no unique dedup key. There are 1,000 true purchases, and 40% of buyers open order history once afterward. How many conversions does the tag log?
answer: 1400
tolerance: 0
unit:
hint: Every page with the tag and no dedup key fires another conversion.
explain: The 1,000 confirmation fires are joined by 400 more from the order-history visits (40% of 1,000), for 1,400 logged against 1,000 true. A unique order id as the dedup key would have collapsed the duplicates back to 1,000.
:::

:::callout insight
Every failure here ends the same way: the bidder optimizes toward a lie. A pixel that double-counts teaches the model that bad inventory converts; a pixel that under-fires starves your best audiences of credit. QA is not paperwork, it is protecting the optimization.
:::

:::quiz
question: A single-page-app checkout shows the order confirmation by swapping the view client-side, with no full page reload. A conversion tag bound to page load reports almost no conversions. Why?
- The SPA framework blocks all third-party tags
- The confirmation view is a client-side route change, so a page-load trigger never fires
- The browser cached the pixel from the product page
- The pixel is rate-limited after the first fire
answer: 1
hint: Ask what event the tag is waiting for, and whether it ever happens.
explain: An SPA never reloads the page on confirmation, so a page-load trigger has nothing to fire on. The fix is to bind the tag to the route change or to a dataLayer event the app pushes when the order is confirmed.
:::

:::sources
- Meta, Meta Pixel get started | https://developers.facebook.com/docs/meta-pixel/get-started/
- Google, Create Floodlight activities (Campaign Manager 360) | https://support.google.com/campaignmanager/answer/2823400
- Google, Install the Google tag (gtag.js) | https://developers.google.com/tag-platform/gtagjs/install
- Google Tag Manager, Trigger types | https://support.google.com/tagmanager/answer/7679316
- Google, Verify your tags with Tag Assistant | https://support.google.com/tagassistant/answer/10039345
:::
