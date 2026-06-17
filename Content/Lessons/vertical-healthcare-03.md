---
id: vertical-healthcare-03
track: vertical-healthcare
module: 3
title: The Conversion and the Funnel, From Impression to Prescription
summary: Map the pharma conversion funnel from impression to filled prescription, optimize on proxy actions in-flight, and grade the campaign on the lagging clean-room script number.
---
# What actually converts in pharma

In retail you fire a pixel on a purchase and read the conversion in seconds. In pharma the terminal conversion is a filled prescription, a script, and there is no pixel on the pharmacy counter. The script is written by a licensed prescriber, adjudicated by a pharmacy benefit manager, and dispensed days later, all of it de-identified for HIPAA, so the trader never sees the conversion at impression time. Every measurement, matching, and troubleshooting lesson that follows is built on this one structural fact: the real-time signal and the lagging truth are two different numbers.

Because the script is invisible in-flight, the operator optimizes against proxy conversions and grades the flight on a downstream match-back. The proxy is what you can see today (an engagement, a savings-card view, an in-EHR interaction), and the script is what funds renewal weeks later. Confusing the two is the single most common reporting failure in the vertical.

:::figure funnel
caption: The pharma funnel runs impression to engagement to qualified action (the optimizable proxy) to a filled script reconciled later in a clean room. The trader optimizes on the proxy and is graded on the lagging script.
:::

# The two funnels, HCP and DTC

The vertical runs two parallel funnels on one identity spine. The HCP funnel goes impression to engagement (an endemic content read, an NPI verified) to a Qualified Action such as a site visit, a savings-card view, a sample request, or an in-EHR interaction, then to an NBRx or TRx weeks later in the Rx panel. The DTC funnel goes reach to condition-relevant engagement to a patient action such as a find-a-doctor click, a doctor-discussion guide, or a copay-card download, then to a self-reported or panel-matched script.

The key difference from a commerce funnel is that neither funnel ends at a click. A find-a-doctor click is not a script, and a savings-card view is not a script. These are mid-funnel proxies whose only value is how reliably they predict the downstream prescription, which is exactly what the proxy-to-script ratio measures.

:::quiz
question: In the HCP funnel, which of these is the terminal conversion the campaign is ultimately graded on?
- A savings-card view
- An in-EHR interaction
- A filled NBRx or TRx script
- An endemic content read
answer: 2
hint: Proxies are mid-funnel; the grade is the thing that funds renewal.
explain: The savings-card view, in-EHR interaction, and content read are all optimizable proxies that sit mid-funnel. The terminal conversion, and the only number that grades the campaign, is the filled NBRx/TRx script reconciled later against the Rx panel.
:::

# Qualified actions and CPQA, the optimizable proxy

Since the script is invisible until match-back, the trader optimizes on a Qualified Action: an event predictive of a prescription start. Cost per Qualified Action is the in-flight efficiency metric, defined as media spend over qualified actions.

$$ \text{CPQA} = \frac{\text{media spend}}{\text{qualified actions}} $$

A good proxy is one an HCP only takes when they are genuinely considering the brand, like a sample request or an in-EHR interaction, not a low-intent click that any visitor fires. The operator picks the proxy that correlates with scripts and ignores vanity engagement, because optimizing toward an action that does not move scripts inflates the dashboard while cost per script worsens.

:::predict
prompt: A flight spends $720,000 and drives 48,000 qualified actions. What is the cost per qualified action (CPQA)?
answer: 15
tolerance: 0.5
unit: USD
hint: Divide spend by qualified actions.
explain: $720,000 / 48,000 = $15.00 per qualified action. This is an in-flight efficiency read only; it is not cost per script, which is graded later against the Rx panel.
:::

# Calibrating the proxy with the proxy-to-script ratio

A proxy is only useful if it predicts scripts. The proxy-to-script ratio is incremental scripts divided by qualified actions, and it tells you how many of your optimizable actions actually convert to a prescription downstream. The trader computes it after the first match-back and uses it to decide which proxy to optimize toward in the next flight.

$$ \text{proxy-to-script ratio} = \frac{\text{incremental scripts}}{\text{qualified actions}} $$

If the ratio is high and stable, the proxy is trustworthy and you can optimize against it with confidence in-flight. If the ratio is near zero, the proxy is decorative: you are buying actions that never become scripts, and the in-flight dashboard is lying to you. This is why you validate the ratio before you trust any proxy, especially a tempting one like CTR.

:::predict
prompt: A campaign drives 50,000 qualified actions and a clean-room study attributes 5,000 incremental scripts. What is the proxy-to-script ratio?
answer: 0.1
tolerance: 0.005
unit: ratio
hint: Divide incremental scripts by qualified actions.
explain: 5,000 / 50,000 = 0.10. One in ten qualified actions converts to an incremental script, so the proxy is a usable optimization target; a ratio near zero would mean the proxy does not predict scripts at all.
:::

:::predict
prompt: A flight exposes 200,000 HCPs and a lift study attributes 6,000 incremental scripts. What is the script conversion rate on exposed reach?
answer: 3
tolerance: 0.1
unit: percent
hint: Incremental scripts divided by exposed population, as a percent.
explain: 6,000 / 200,000 = 0.03 = 3%. Script conversion rates are low and lagged by design, which is exactly why the trader needs a higher-frequency proxy like CPQA to steer the flight in real time.
:::

# The data lag, why the grade lands after the flight ends

The script does not appear the moment it is written. It must be dispensed, adjudicated by the PBM, and then surfaced in the Rx panel (IQVIA, Veeva Crossix, PurpleLab), which adds a panel lag on top of the response window. A roughly 12-week flight typically needs about a 4-week lag for scripts to land in the panel, giving a total measurement window near 16 weeks, so the final grade arrives after the flight has already ended. A match-back window beyond about 20 weeks signals the category is too slow-moving or the data lag is excessive.

This lag is the source of the recurring stakeholder fight: leadership wants a real-time ROAS-style dashboard, but pharma's conversion is de-identified and lagged. The operator sets that expectation up front, reports proxies as leading indicators in-flight, and reserves the word "result" for the clean-room readout.

:::predict
prompt: A flight runs 12 weeks and the Rx panel lags 4 weeks before scripts appear. What is the total measurement window?
answer: 16
tolerance: 0.1
unit: weeks
hint: Add the flight length and the panel lag.
explain: 12 + 4 = 16 weeks. The script number does not exist until roughly week 16, so a "flat" read at week 10 or 12 is pre-lag noise, not a final grade.
:::

:::widget lineChart
title: Cumulative incremental scripts surfacing over the measurement window
labels: wk2, wk4, wk6, wk8, wk10, wk12, wk14, wk16
data: 2, 8, 20, 45, 80, 100, 100, 100
unit: % of final scripts surfaced
:::

# Reading the funnel mix and the NBRx:TRx health signal

Once scripts surface, the trader reads two things: where volume fell out of the funnel, and the quality of the scripts that converted. The NBRx:TRx ratio, new-to-brand scripts over total scripts, is the new-patient acquisition health signal. A ratio below 0.10 flags an access barrier: the brand is refilling existing patients but failing to acquire new ones, which usually points to formulary, prior-authorization, or copay friction rather than a media problem.

This matters for the trader because a low NBRx:TRx is not fixed by buying more impressions. If new patients cannot get the drug, more reach to prescribers just generates demand the system cannot fill, so the operator flags it to the brand team instead of spending into it.

:::predict
prompt: A flight attributes 1,800 incremental NBRx and 20,000 incremental TRx. What is the NBRx:TRx ratio, and does it clear the 0.10 access-barrier flag?
answer: 0.09
tolerance: 0.005
unit: ratio
hint: New-to-brand scripts divided by total scripts.
explain: 1,800 / 20,000 = 0.09, which is below the 0.10 threshold, so it flags a likely access barrier (formulary, prior-auth, or copay friction). More media will not fix that; it is escalated to the brand team.
:::

:::quiz
question: An in-flight dashboard shows strong CTR and a low CPQA, but the lagged clean-room read shows almost no incremental scripts. What is the most likely explanation?
- The Rx panel is broken and undercounting
- The proxy being optimized does not correlate with scripts
- The frequency cap was set too low
- The NBRx:TRx ratio is above 0.10
answer: 1
hint: A great proxy number with no scripts points at the proxy itself.
explain: A strong proxy with no scripts means the proxy-to-script ratio is near zero: the campaign optimized toward an action that does not predict a prescription. The fix is to re-pick a higher-intent qualified action, not to assume the panel is wrong.
:::

# Compliance and edge cases for the funnel

The funnel split creates specific traps. DTC self-reported scripts are weaker evidence than panel-matched scripts, so a find-a-doctor click must never be equated with a filled prescription in reporting. Optimizing hard to a proxy that does not correlate with scripts (classically CTR) inflates apparent performance while cost per script quietly worsens, which is why the proxy-to-script ratio is validated before any proxy is trusted. And because the script arrives weeks after the flight ends, "final" grades land post-campaign, so the lag is set with stakeholders up front, not discovered at the end.

The hardest part of the job is operating against the lag without flinching. The discipline is to steer on the proxy in-flight, hold the line on the data-lag window before declaring anything, and grade only on the clean-room script number.

:::quiz
question: A 12-week flight reads flat on incremental scripts at week 10. With a 4-week panel lag, what is the correct call?
- Kill the flight, it is underperforming
- Wait, the measurement window does not close until about week 16
- Switch all budget to a new channel immediately
- Report the week-10 read as the final result
answer: 1
hint: When does the script number actually become valid?
explain: A 12-week flight plus a 4-week panel lag means scripts are not fully surfaced until about week 16, so a week-10 read is pre-lag noise. Killing the flight or reporting it as final would both misread the data lag; the correct call is to wait for the window to close.
:::

:::callout warning
A recurring operator complaint from the field: leadership expects real-time, ROAS-style dashboards, but pharma's conversion is de-identified and lagged by weeks, so traders get pushed to optimize a live campaign on proxies while the only metric leadership actually cares about (scripts) will not exist for roughly two months. Set the lag expectation in writing before launch, label every in-flight number a leading indicator, and never present a pre-lag read as the final result.
:::

:::sources
- Improvado, HCP Targeting and Segmentation in Pharma: The 2026 Practitioner's Guide | https://improvado.io/blog/hcp-targeting-segmentation-pharma
- Veeva Crossix, Data Platform and Methodology White Paper | https://www.veeva.com/wp-content/uploads/2023/08/Crossix-Data-and-Methodology-White-Paper.pdf
- DeepIntent, Healthcare Audiences and Provider Match | https://www.deepintent.com/solutions/healthcare-audiences/
- PulsePoint, Curated Private Marketplaces and Point-of-Care | https://www.pulsepoint.com/blog/curated-private-marketplaces
- Digiday, How programmatic firms deal with complex pharmaceutical laws | https://digiday.com/marketing/pharma-programmatic/
- FiercePharma, 2026 forecast: Pharma ad dollars keep moving away from traditional TV | https://www.fiercepharma.com/marketing/2026-forecast-pharma-ad-dollars-will-continue-shifting-away-traditional-tv
:::
