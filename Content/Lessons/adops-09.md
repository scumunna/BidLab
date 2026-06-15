---
id: adops-09
track: adops
module: 9
title: Reporting, Dashboards, and the Wrap Report
summary: The reporting cadence, the metrics that matter by objective, the pacing and delivery dashboard, blended versus weighted rates, and how to QA a wrap report before it ships.
---
# What reporting is actually for

Adops-08 settled how two systems disagree and which count bills. This lesson is the job that surrounds that count: turning raw delivery logs into something a planner, a client, or a CFO can act on. Reporting is not a screenshot of the platform. It is the deliberate selection of the few numbers that answer one question, did the campaign do what it was bought to do, and the discipline to ship those numbers clean.

Reporting runs on a cadence. In-flight reporting (daily or every few hours on a large budget) exists to catch problems while you can still fix them: a line pacing behind, a creative disapproved, a deal that stopped spending. End-of-flight reporting, the post-campaign analysis or PCA, also called the wrap report, exists to judge the campaign and feed the next plan. The two have different audiences and different jobs, and confusing them is the first mistake. In-flight is for the operator. The wrap is for the decision maker.

:::quiz
question: A line is pacing 25 percent behind on day 4 of a 30 day flight. Which reporting layer is supposed to surface this, and why does timing matter?
- The wrap report, because that is where pacing lives
- In-flight reporting, because the flight is still open and the problem is still fixable
- Neither, pacing is not a reporting concern
- The final invoice, because billing catches under-delivery
answer: 1
hint: Think about which report exists to let you act while there is still time.
explain: In-flight reporting exists to catch problems during the flight, when you can still widen targeting, raise a bid, or fix a tag. The wrap report is written after the flight closes and is too late to change delivery. Catching pacing on day 4 leaves 26 days to correct it.
:::

# The metrics that matter by objective

The single most common reporting failure is reporting the wrong metric for the goal. An awareness campaign judged on CPA looks like a disaster even when it delivered reach perfectly, and a performance campaign judged on CPM looks cheap even when it converted nothing. Match the metric to the objective, and report two or three headline numbers, not twenty.

The funnel maps cleanly to KPIs:

- Awareness: the goal is efficient reach, so report CPM, impressions, reach and frequency, viewability rate, and for video or audio the completion rate (VCR or ACR). Cost efficiency here is cost per thousand, not cost per action.
- Consideration: the goal is engagement, so report CTR, CPC, cost per completed view (CPCV), and cost per landing page visit (CPLPV).
- Conversion: the goal is an outcome, so report CPA, conversion rate, ROAS, and for retail or location-based goals cost per verified visit.

A clean report leads with the objective's primary KPI, shows pacing and delivery next, then supporting metrics, then anything diagnostic. Lead with the answer, support it underneath.

:::predict
prompt: An awareness video line served 1,100,000 video starts and recorded 880,000 completed views. What is the video completion rate (VCR)?
answer: 80
tolerance: 0.5
unit: %
hint: VCR is completed views divided by video starts.
explain: 880,000 / 1,100,000 = 0.80, an 80 percent VCR. This is the headline metric for an awareness video buy. Reporting CPA on this line instead would answer a question nobody bought.
:::

:::callout key
Report against the objective the campaign was bought on, not the metric that happens to look best. If the IO says awareness, lead with CPM and VCR, even when the CTR is flattering.
:::

# The pacing and delivery dashboard

Pacing is the heartbeat you watch in-flight. It answers one question: is the campaign on track to spend its budget and deliver its impressions evenly across the flight, or is it ahead, behind, or already burned out. The standard tool is the pacing index: actual delivery to date divided by expected delivery to date, where expected is usually a straight line from start to end of flight.

$$ \text{pacing index} = \frac{\text{delivered to date}}{\text{expected to date}} $$

A pacing index of $1.00$ (or 100 percent) is exactly on plan. Below $1.00$ is under-pacing, the line will miss its goal unless you act. Above $1.00$ is over-pacing, the line will exhaust its budget early and go dark before the flight ends. A common operational rule is to investigate any high-budget line that drops below roughly 80 percent of its projected daily delivery, and to check pacing every few hours on large campaigns rather than once a day.

:::figure pacingCurve
caption: The straight expected line is the plan. The actual delivery line riding below it is under-pacing, and the gap widens every day it is not corrected.
:::

:::predict
prompt: A line was projected to have delivered 600,000 impressions by today. It has actually delivered 420,000. What is its pacing index, as a percent?
answer: 70
tolerance: 0.5
unit: %
hint: Divide what actually delivered by what was expected by now.
explain: 420,000 / 600,000 = 0.70, a pacing index of 70 percent. That is below the roughly 80 percent action threshold, so this line gets worked now: check eligible inventory, bid, floor, budget, and creative before more of the flight is lost.
:::

# Blended versus weighted rates

A campaign almost never runs at one CPM. Display, video, CTV, and audio lines each clear at different prices, and the reported program rate has to combine them honestly. The trap is the simple average, which treats a tiny premium line and a huge cheap line as equals. The correct method is the weighted average, also called the blended rate, which weights each line by its impression volume.

$$ \text{blended CPM} = \frac{\text{total cost}}{\text{total impressions}} \times 1000 $$

The simple average and the blended rate can be wildly different. Report the blended rate to the client as the program cost, and keep the individual line CPMs for optimizing and negotiating with each publisher. The blended number is the truth of what the program cost per thousand. The simple average is a number that describes nothing real.

:::predict
prompt: Line A delivered 500,000 impressions at a 30.00 dollar CPM. Line B delivered 5,000,000 impressions at a 5.00 dollar CPM. What is the blended (weighted) CPM for the two lines combined?
answer: 7.27
tolerance: 0.05
unit: $
hint: Find each line's cost, total the cost and the impressions, then divide and multiply by 1000.
explain: Line A cost is (500,000 / 1000) times 30.00 = 15,000 dollars. Line B cost is (5,000,000 / 1000) times 5.00 = 25,000 dollars. Total cost is 40,000 dollars over 5,500,000 impressions, so the blended CPM is (40,000 / 5,500,000) times 1000 = 7.27 dollars. The simple average of 30 and 5 would be 17.50 dollars, more than double the truth, because it ignores that Line B carried ten times the volume.
:::

:::callout insight
A simple average of CPMs answers a question nobody asked. The weighted blend is the only program rate that reconciles back to total spend divided by total impressions.
:::

# The wrap report (PCA) structure

The wrap report is the campaign's verdict and the next campaign's brief. A strong PCA follows a fixed shape so the reader can find what they need without reading the whole thing.

- Executive summary first. One short section that states whether the campaign hit its objective and KPI, with the two or three headline numbers. The decision maker should be able to stop here and know the answer.
- Delivery and pacing. Did it deliver the guaranteed impressions and spend the budget, and how did it pace across the flight.
- Performance against KPI. The objective's primary metric versus the goal, broken out by the dimensions that matter (channel, placement, audience, creative, geo, device).
- What worked and what did not. The critical, analytical read: which segments, creatives, and tactics drove the result, and which dragged.
- Recommendations. Concrete changes for the next flight, tied to the evidence above. This is the part planning actually uses.

Keep cognitive load low. Highlight only campaign-relevant, explainable numbers and annotate the why. A wrap that buries the answer in forty tabs of raw logs is not a report, it is a data dump.

:::quiz
question: Where in a wrap report does the statement "the campaign hit its 80 percent VCR goal at a 6.50 dollar blended CPM, 7 percent under plan" belong?
- Buried in the appendix with the raw logs
- In the executive summary, up top
- Only in the recommendations section
- It does not belong in a wrap report
answer: 1
hint: Which section is written so a busy decision maker can stop after reading it?
explain: That sentence is the verdict: objective met, at what efficiency, versus plan. It belongs in the executive summary at the top, where the decision maker reads it first and can stop there if they want. The supporting breakouts live below it.
:::

# QA before it ships

A wrong number in a wrap report is worse than no report, because the reader trusts it and plans against it. QA every report before it leaves your hands. The checklist:

- Reconcile the totals. The numbers in the report must tie back to the billing system of record from adops-08. If the wrap says 2,000,000 impressions and the billing count is 1,850,000, fix it before you send it, do not let the report and the invoice disagree.
- Recompute the rates. Blended CPM must equal total cost divided by total impressions times 1000. CTR must equal clicks divided by impressions. If a rate does not reconcile to its raw counts, a filter or a date range is wrong.
- Check the date range and time zone. A report that closes its day at midnight UTC while the platform closes at midnight Eastern will misstate any single day. Confirm the flight dates match the IO exactly.
- Confirm the metric matches the objective. An awareness wrap led with CPA is the wrong report no matter how clean the math.
- Sanity-check for impossible values. CTR above a few percent on display, a 100 percent viewability rate, or a conversion count above the click count all signal a tracking or join error, not a great campaign.

:::predict
prompt: A wrap report lists 1,250,000 impressions and 3,750 clicks. QA recomputes the click-through rate to confirm it. What CTR should the report show?
answer: 0.3
tolerance: 0.01
unit: %
hint: CTR is clicks divided by impressions, expressed as a percent.
explain: 3,750 / 1,250,000 = 0.003 = 0.30 percent. A plausible display CTR. If the report instead showed 3 percent here, QA would catch that the math is off by a factor of ten and find the error before the client does.
:::

:::callout key
The report ties to the invoice or it does not ship. Reconcile every headline number to the billing system of record, recompute every rate from its raw counts, and confirm the metric matches the objective. A trusted wrong number is the most expensive output AdOps can produce.
:::

:::sources
- Basis Technologies, Programmatic Advertising 101, Setting Campaign Goals and KPIs | https://basis.com/blog/programmatic-101-setting-goals-kpis
- StackAdapt, 8 Essential Programmatic KPIs Explained | https://www.stackadapt.com/resources/blog/programmatic-kpis-explained
- Permutive, Building a PCA Report | https://support.permutive.com/hc/en-us/articles/5955341791260-Building-a-PCA-Report
- Smart Insights, How to review a marketing campaign's effectiveness | https://www.smartinsights.com/traffic-building-strategy/campaign-analytics/how-to-review-a-marketing-campaigns-effectiveness/
- AgencyAnalytics, How to create a budget pacing report to monitor ad spend | https://agencyanalytics.com/blog/budget-pacing
- Media Drive, eCPM Blender, weighted average CPM | https://mediadrive.pro/ecpm-blender/
- NinjaCat, Programmatic Ads Report Template | https://www.ninjacat.io/report-templates/programmatic-ads-report-template
- Camphouse, Campaign Pacing, tips for effective ad budget management | https://camphouse.io/blog/campaign-pacing
:::
