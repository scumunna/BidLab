---
id: core-06
track: core
module: 6
title: Inventory and formats
summary: Compare the major ad formats and see how each one changes the pricing, viewability, and yield math.
---
# The format menu

Programmatic spans many surfaces. Display is the classic banner on a web page or in an app. Video runs in-stream before or during content, or out-stream inside a feed. Native blends into the surrounding content so it reads like part of the page rather than a banner.

Three channels have grown fast. Connected TV (CTV) is video on internet-connected television. Audio is ads in music streaming and podcasts. Digital out-of-home (DOOH) is programmatic screens in physical spaces like transit, retail, and roadside. Each is bought through the same DSPs but behaves differently.

:::figure displayAd
caption: Display, the classic banner on a page or in an app. The unit is one rendered impression on one device.
:::

:::figure videoAd
caption: Video runs in-stream before or during content, or out-stream inside a feed, and is judged on completion rather than just a render.
:::

:::figure nativeAd
caption: Native blends into the surrounding content so it reads like part of the page rather than a banner.
:::

:::figure ctvAd
caption: Connected TV is full-screen, usually unskippable video on an internet-connected television, often counted at the household level.
:::

:::widget barChart
title: Typical CPM by format (illustrative)
labels: Display, Native, Video, CTV
data: 3, 6, 12, 35
unit: $
:::

# How the format changes the economics

Format drives price and how an impression is even defined. CTV commands high CPMs because the inventory is premium, full-screen, and usually unskippable, and over 90 percent of CTV ad spend now transacts programmatically. eMarketer puts US CTV ad spend near 38 billion dollars in 2026, about 17 percent of programmatic display spend, which is why so much buyer attention has moved there.

DOOH breaks the one-to-one impression model entirely. A single screen is seen by many people, so a DOOH impression is an estimate built from a play multiplied by an audience count, not a single browser load.

$$ DOOH_{impressions} = plays \times audience_{per\,play} $$

:::predict
prompt: A DOOH screen plays an ad 4,000 times in a day, and each play is seen by an estimated 35 people on average. How many DOOH impressions is that?
answer: 140000
unit: impressions
hint: DOOH impressions are plays multiplied by the estimated audience per play.
explain: Impressions = 4,000 x 35 = 140,000. Unlike a display impression, which maps to one device load, a DOOH impression is a crowd estimate, so the same play counts as many impressions.
:::

:::callout key
The format defines the unit you are buying. A display impression is one person, a CTV impression is often a household, and a DOOH impression is a crowd estimate. Comparing CPMs across formats without that context is misleading.
:::

# Viewability and completion by format

Viewability rules differ by surface. A display banner can scroll out of view, so the MRC 50 percent for 1 second standard matters most there. Full-screen CTV and most audio are effectively always in view, which is part of why completion rate, not viewability, is the metric that matters for them.

This shifts which pricing model fits. Display leans on CPM and viewable CPM. Video and CTV lean on cost per completed view, since a finished view signals real attention. Audio borrows the same completion logic for podcasts and streaming.

:::widget yieldExplorer
:::

:::callout insight
Match the metric to the medium. Viewability is the right question for scrollable display. Completion is the right question for video, CTV, and audio, where the ad is hard to ignore but easy to abandon.
:::

:::quiz
question: Why does a single DOOH impression differ fundamentally from a single display impression?
- One screen play can be seen by many people, so impressions are an audience estimate
- DOOH never uses programmatic buying
- DOOH impressions are always cheaper than display
- DOOH cannot be measured for viewability
answer: 0
explain: A DOOH screen is viewed by a crowd, so an impression count is plays multiplied by an estimated audience per play. A display impression maps to a single device load, a one-to-one relationship DOOH does not have.
:::

:::sources
- EMARKETER, Programmatic CTV Share of US Digital Display Ad Spending | https://www.emarketer.com/forecasts/584b26021403070290f93a3a/5d950b404945300820949bab/
- IAB, Digital Out-of-Home Measurement Guidelines | https://www.iab.com/guidelines/
:::
