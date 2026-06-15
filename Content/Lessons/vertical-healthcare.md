---
id: vertical-healthcare
track: healthcare
module: 1
title: Healthcare and pharma: the conversion you can never see directly
summary: How script lift, cost per incremental script, HCP audience quality, and a no-PII targeting rule define pharma media math.
---
# Pharma measures a conversion it is not allowed to observe

Every other vertical can watch the conversion happen. Pharma cannot. The conversion is a prescription written in a doctor's office, and privacy law forbids tying an ad exposure to an individual patient's health record. So pharma measures conversions indirectly, through script-lift studies that compare an exposed group against a matched control on de-identified claims data. That indirect measurement is the single biggest math difference between pharma and every other vertical in this course.

The category is large and digital. US healthcare and pharma digital ad spend reached about $24.77B in 2025 (+13.3%) and is forecast at about $26.15B in 2026 (eMarketer), with digital now roughly 80% of the mix, up from 64% in 2022. National TV drug advertising hit $5.96B in 2025. In 2025, social outspent linear TV in healthcare and pharma for the first time.

:::widget donutChart
title: Healthcare and pharma ad mix, 2025 (digital share, illustrative)
labels: Digital, Non-digital
data: 80, 20
:::

# Two buyers, one hard privacy rule

Pharma has two distinct buyers. The HCP side targets healthcare professionals at the NPI (National Provider Identifier) level, a small and high-value prescriber universe. The DTC side reaches mass consumer audiences. Neither is allowed to use individual health data to target.

The rule is structural, not optional. Under HIPAA and the HHS Office for Civil Rights online-tracking guidance, covered entities cannot share protected health information, including an IP address tied to a visit to a health-condition page, with ad-tech without a business associate agreement or authorization. A 2024 federal court partially vacated the IP-on-public-pages portion, so the rule is contested and evolving, a gray zone to teach as such. The practical workaround is contextual or condition targeting against content, and NPI-list targeting for HCPs, never behavioral health targeting of individuals.

:::callout key
There is no patient-level health targeting in pharma media. You target the content a patient is reading (contextual) or the verified prescriber (NPI), never the individual's health status. The script-lift study is what lets you measure outcomes without ever touching patient PII.
:::

:::quiz
question: A pharma DTC team wants to reach likely patients for a specific condition. Which targeting approach is compliant under HIPAA and the sensitive-category rules?
- Contextual targeting against the condition-related content a reader is viewing, with no individual health data
- Building a behavioral audience of people who visited health-condition pages
- Matching ad exposure to individual patients' prescription records
- Targeting users by an IP address tied to a specific diagnosis page visit
hint: The rule forbids tying an exposure to an individual's health status; it does not forbid targeting the content itself.
answer: 0
explain: Pharma may target the content a person is reading (contextual) or the verified prescriber (NPI), but never the individual's health status. Behavioral health audiences, patient-level record matching, and IP tied to a condition-page visit all cross the PII line.
:::

# Script lift: the indirect conversion

Script lift is the percentage increase in prescription rate of the exposed group over the matched control. It is the heart of pharma measurement.

$$ Script\ lift = \frac{Rx\ rate_{exposed} - Rx\ rate_{control}}{Rx\ rate_{control}} $$

Suppose the exposed group fills at 6.2% and the matched control at 5.0%. Script lift = (6.2 - 5.0) / 5.0 = 1.2 / 5.0 = 0.24, a 24% lift. The lift, not a click, is the outcome that matters, expressed for HCPs as NBRx (new-to-brand) and TRx (total) scripts.

:::predict
prompt: A script-lift study finds the exposed group fills prescriptions at 6.2% and the matched control fills at 5.0%. What is the script lift?
answer: 24
unit: %
hint: Subtract the control rate from the exposed rate, then divide by the control rate.
explain: Script lift = (6.2 - 5.0) / 5.0 = 1.2 / 5.0 = 0.24 = 24%.
:::

:::widget didExplorer
:::

# Cost per incremental script

The efficiency dial is cost per incremental script (CPRx), spend divided by the incremental scripts the campaign caused, where incremental scripts come from the lift over baseline.

$$ Incremental\ scripts = (Rx\ rate_{exposed} - Rx\ rate_{control}) \times Exposed\ audience $$

$$ CPRx = \frac{Spend}{Incremental\ scripts} $$

Take an exposed audience of 500,000, an exposed fill rate of 6.2%, and a control rate of 5.0%. The incremental fill rate is 1.2 percentage points, so incremental scripts = 0.012 x 500,000 = 6,000. If the campaign spent $1,200,000, then CPRx = $1,200,000 / 6,000 = $200 per incremental script. Compare that to the revenue per script to judge return.

:::predict
prompt: An exposed audience of 500,000 fills at 6.2% versus a 5.0% control. How many incremental scripts did the campaign cause?
answer: 6000
hint: The incremental fill rate is the exposed rate minus the control rate, applied to the exposed audience.
explain: Incremental rate = 6.2% - 5.0% = 1.2 points = 0.012. Incremental scripts = 0.012 x 500,000 = 6,000.
:::

:::predict
prompt: A campaign spends $1,200,000 and drives 6,000 incremental scripts. What is the cost per incremental script?
answer: 200
unit: $
hint: Divide spend by incremental scripts.
explain: CPRx = $1,200,000 / 6,000 = $200 per incremental script.
:::

# HCP audience quality and vendor ROI claims

On the HCP side, audience quality (AQ) is the share of impressions delivered to the correct NPI target list. A high AQ means you are paying to reach actual target prescribers rather than waste. Vendors report reaching about 95% of the HCP universe (DeepIntent, DMD), a defensible anchor. Treat the splashier numbers with care. Point-of-care ROI of about 28:1 and an average engagement lift of 8.3x are vendor best-cases from sponsored studies, useful as ceilings, not as planning assumptions. The FDA enforcement surge of September 2025, with 100-plus warning and untitled letters concentrated in oncology and weight-loss (GLP-1) drugs, is a reminder that fair-balance and Important Safety Information requirements constrain creative as hard as privacy constrains targeting.

:::predict
prompt: An HCP campaign delivers 800,000 impressions, of which 760,000 land on NPIs from the target prescriber list. What is the audience quality?
answer: 95
unit: %
hint: Audience quality is on-target impressions divided by total impressions.
explain: AQ = 760,000 / 800,000 = 0.95 = 95%, matching the reachable HCP-universe anchor.
:::

:::quiz
question: Why does pharma rely on matched test-versus-control script-lift studies instead of click-to-conversion tracking like retail?
- Privacy law forbids tying an ad exposure to an individual patient's prescription, so lift over a matched control is the only compliant way to measure incremental scripts
- Script-lift studies are cheaper than click tracking
- Doctors refuse to click on ads
- Prescription data updates too slowly for click attribution
hint: Think about what HIPAA and the sensitive-category rules prohibit at the individual level.
answer: 0
explain: HIPAA and sensitive-category rules block individual-level health targeting and tracking, so pharma measures outcomes as a lift over a matched de-identified control rather than per-patient clicks.
:::

:::sources
- US Healthcare and Pharma Ad Spending 2025, eMarketer | https://www.emarketer.com/content/us-healthcare-pharma-ad-spending-2025
- HIPAA Online Tracking Guidance, HHS Office for Civil Rights | https://www.hhs.gov/hipaa/for-professionals/privacy/guidance/hipaa-online-tracking/
:::
