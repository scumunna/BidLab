---
track: vertical-healthcare
title: Healthcare and Pharma Programmatic Certification
pass: 0.7
draw: 12
---
:::q Market and Money Map
question: A brand director cites two milestones from the 2025 US healthcare and pharma market: "digital overtook linear TV" and "social overtook linear TV." Which framing should you correct before it lands in a deck?
- Digital overtook linear years ago; only social passing linear TV is the 2025 first
- Both happened in 2025 for the first time
- Neither has happened; linear TV still leads the mix
- Social overtook linear years ago; digital passing linear is the 2025 first
answer: 0
explain: Digital surpassed linear TV years ago, while 2025 is specifically the first year social (about $6B) outpaced linear TV in this vertical. Conflating the two overstates the digital milestone.
:::

:::q Market and Money Map
question: A client insists you run HCP promotion on DV360 because it is already on the seat. Why does that not work, and what must replace it?
- DV360 is too expensive for pharma, so use a cheaper generalist DSP
- DV360 does not support CTV, so use a CTV-only platform
- DV360 cannot map an impression to an individual prescriber's NPI, so HCP promotion needs a purpose-built healthcare DSP
- DV360 cannot run frequency caps, so use a publisher direct buy
answer: 2
explain: A generalist DSP can address cookies, devices, and contextual segments but has no deterministic consented graph linking a device to a licensed NPI. HCP promotion therefore requires a purpose-built healthcare DSP such as DeepIntent or PulsePoint.
:::

:::q Market and Money Map
question: In 2025, US healthcare and pharma digital spend is $24.8B against $7.9B traditional. What share of the combined mix is digital?
- About 90 percent
- About 68 percent
- About 24 percent
- About 76 percent
answer: 3
explain: 24.8 / (24.8 + 7.9) = 24.8 / 32.7 = 0.758, about 76 percent. Digital is the dominant share, which is why a plan leaning on traditional TV is fighting the tape.
:::

:::q Market and Money Map
question: A new trader wants to plan a DTC patient buy and an NPI-targeted HCP buy together in one campaign and one report to simplify reconciliation. What is the right call?
- Combine them, since both ultimately drive the same brand
- Keep them fully separate, since DTC and HCP use different DSPs, inventory, KPIs, and compliance regimes
- Combine the reporting but split the DSPs
- Combine the DSPs but split the reporting
answer: 1
explain: DTC and HCP are two budgets on one identity spine with different DSPs, inventory, KPIs, and compliance. Co-mingling line items or reporting is the classic rookie error that loses a brand team's trust.
:::

:::q NPI Identity and Match Rate
question: You target 40,000 NPIs and the healthcare DSP can address 30,000 with live ad opportunities. The IO carries a 70 percent addressable match-rate floor. Where do you stand?
- 60 percent match, below the floor
- 75 percent match, above the floor
- 75 percent match, below the floor
- 133 percent match, above the floor
answer: 1
explain: Match rate is 30,000 / 40,000 = 75 percent, which clears the 70 percent IO floor. The other 10,000 NPIs are unaddressable through this DSP no matter the spend.
:::

:::q NPI Identity and Match Rate
question: A vendor pitches a 92 percent blended match rate, but most links are probabilistic. Why is that not automatically better than a 78 percent deterministic rate?
- Probabilistic links can resolve to the wrong device, so a high blended rate can still misdeliver
- A higher percentage always means less wasted spend
- Probabilistic matching is illegal under HIPAA
- Deterministic and probabilistic rates are measured on different list sizes
answer: 0
explain: A deterministic link is an observed, consented NPI-to-identifier pairing, while a probabilistic link is an inference that can resolve to a spouse, colleague, or the wrong person. Always ask for the deterministic share, not just the headline total.
:::

:::q NPI Identity and Match Rate
question: A $500,000 open-web line runs at a 60 percent match rate. Roughly how much spend is exposed to unmatched or mismatched delivery?
- $300,000
- $40,000
- $200,000
- $60,000
answer: 2
explain: Wasted-spend exposure is spend times (1 minus match rate): 500,000 times 0.40 = $200,000 addressing NPIs the graph cannot reach, before accounting for probabilistic misdelivery inside the matched 60 percent.
:::

:::q NPI Identity and Match Rate
question: An audit finds match failure of retired NPIs 7 percent, hospital IP blocks 6 percent, missing taxonomy 5 percent, and email-domain collisions 4 percent. What does the rule require?
- Nothing; 22 percent failure is within tolerance
- Raise the IO match floor to 22 percent and continue
- Drop only the retired NPIs and keep serving
- Rebuild the identity graph before relaunch, since total failure of 22 percent exceeds the 20 percent threshold
answer: 3
explain: The four modes sum to 22 percent total match failure, which is over the 20 percent rebuild threshold. The rule is to rebuild the identity graph before relaunching rather than spend into a broken bridge.
:::

:::q Measurement and Clean Rooms
question: A brand finance team needs a defensible, causal cost per NBRx to defend next year's budget. Which measurement design fits, and why?
- Match-back, because it is cheaper and faster to stand up
- A real-time DSP conversion pixel keyed to the pharmacy claim
- Either design, since both produce a cost-per-script number
- Test versus control, because an unexposed hold-out isolates media-driven scripts from baseline writing
answer: 3
explain: Test versus control subtracts an unexposed control's script rate to isolate the incremental effect, supporting a causal claim. Match-back has no control and credits baseline scripts, and no real-time pharmacy-counter pixel exists.
:::

:::q Measurement and Clean Rooms
question: A clean room reads a 9 percent test script rate and a 6 percent control rate across 200,000 exposed HCPs, on $1,500,000 of spend. What is the cost per incremental script?
- $250
- $150
- $500
- $1,000
answer: 0
explain: Incremental scripts are (0.09 minus 0.06) times 200,000 = 6,000. Cost per incremental script is 1,500,000 / 6,000 = $250, the number compared against the brand's target CPS.
:::

:::q Measurement and Clean Rooms
question: A 12-week oncology flight reads flat lift at week 13, and the Rx panel lags about 4 weeks. What is the correct call?
- Kill the flight; flat at week 13 means the creative failed
- Reallocate all remaining budget to a new channel immediately
- Wait until about week 16, since the measurement window has not closed
- Report the week-13 read as the final result
answer: 2
explain: Flight length plus panel lag is 12 plus 4 = 16 weeks, so a week-13 read is inside the lag and pre-conversion noise. Acting on it risks killing a flight whose scripts have not yet adjudicated.
:::

:::q Measurement and Clean Rooms
question: A clean room matches 1,500 incremental scripts on a 50,000-NPI panel, and your full addressable universe is 200,000 NPIs. What is the projected incremental script count, and how should you present it?
- 375 scripts, as a precise figure
- 6,000 scripts, with a confidence interval because it is a 4x scale-up
- 6,000 scripts, as a precise figure
- 1,500 scripts, since panel results do not project
answer: 1
explain: The projection factor is 200,000 / 50,000 = 4, so 1,500 times 4 = 6,000 projected scripts. A 4x scale-up amplifies noise, so disclose the projection factor and a confidence interval rather than a bare number.
:::

:::q Regulatory and Creative Ops
question: A DCO engine machine-generates 500 product-claim variants. To stay compliant on fair balance, how many must carry intact ISI?
- About 480, allowing a small testing margin
- Only the winning variants the algorithm keeps
- All 500, since any served variant without ISI is itself a violation
- A representative sample is sufficient
answer: 2
explain: There is no compliant threshold below 100 percent. A single served product-claim variant without ISI is a fair-balance violation, so all 500 must carry intact ISI.
:::

:::q Regulatory and Creative Ops
question: After about 72 hours of A/B testing, a DCO engine flags the ISI block as a low-engagement element and starts stripping it from winning variants. What is the correct fix?
- Accept it, since the algorithm is optimizing engagement
- Lock the ISI as non-optimizable (for example, compliance_required: true) so every generated variant carries it
- Lower the bid until the algorithm stops testing
- Move the ISI behind a "see more" to keep the main creative clean
answer: 1
explain: DCO silently dropping ISI is a regulatory event, not a creative tweak. Locking the ISI as non-optimizable forces it into every generated variant before the algorithm optimizes it away.
:::

:::q Regulatory and Creative Ops
question: A pharma social ISI block is set to font-size: max(12px, 2.5vw) inside an @media (max-width:480px) rule. On a 320px-wide phone, what minimum size renders, and why does the floor exist?
- 12px, because the max() floor stops a narrow phone from shrinking ISI below legibility
- 8px, because 2.5vw governs on narrow screens
- 16px, because mobile defaults override the rule
- 6px, because the viewport unit halves the value
answer: 0
explain: 2.5vw on a 320px viewport is 8px, but max() takes the larger of 8px and 12px, so 12px renders. The 12px floor is exactly what keeps risk copy legible on a narrow phone.
:::

:::q Regulatory and Creative Ops
question: A DCO system rewrites the headline on an MLR-approved product-claim ad mid-flight to lift engagement. What must the operator do?
- Nothing; DCO output inherits the original MLR approval
- Let it run and note the change in the post-campaign report
- Re-review only if engagement also drops
- Treat it as a new asset and re-trigger MLR review before it keeps serving
answer: 3
explain: MLR approval attaches to the exact approved copy. Any automated change to an approved claim or ISI asset invalidates the approval and re-triggers MLR, which is why a pre-cleared backup asset is kept ready.
:::

:::q Supply, Brand Safety and Suppression
question: Why does HCP promotion lean on NPI-scoped private deal IDs rather than open RTB?
- Endemic physician and EHR inventory is largely sold programmatic-direct, and a private deal scopes delivery to verified NPI-matched audiences
- Open RTB is always cheaper, so deals exist only to mark up inventory
- The FDA mandates deal IDs for all pharma advertising
- Open RTB cannot serve video, so CTV forces a PMP
answer: 0
explain: Endemic environments (Doximity, Medscape, Epocrates) and EHR/point-of-care networks are overwhelmingly PMP/programmatic-direct, and a private deal lets the publisher scope delivery to your verified NPI list. Open RTB cannot map a bid request to an NPI.
:::

:::q Supply, Brand Safety and Suppression
question: A flight is planned for 8,000,000 impressions, with 4,400,000 committed to endemic PMP deals and the rest on open-web NPI extension. What is the endemic share, and what does the rest trade away?
- 45 percent endemic; the extension improves match quality
- 55 percent endemic; the extension carries the cleanest medical context
- 36 percent endemic; the extension has hard inventory caps
- 55 percent endemic; the open-web extension scales reach but dilutes match quality and brand-safety control
answer: 3
explain: 4,400,000 / 8,000,000 = 55 percent endemic. The remaining 45 percent runs on open-web/CTV extension, which scales reach but trades away the match quality and medical context endemic deals provide.
:::

:::q Supply, Brand Safety and Suppression
question: An aggressive keyword blocklist false-positives 1,200,000 otherwise-eligible medical-content impressions off a buy running at a $32 CPM. Roughly how much reach value is lost to over-blocking?
- $384
- $3,840
- $38,400
- $384,000
answer: 2
explain: Over-block cost is blocked impressions times CPM/1000: 1,200,000 times (32 / 1000) = $38,400 of eligible inventory removed. Over-blocking starves pacing as surely as under-blocking wastes spend.
:::

:::q Supply, Brand Safety and Suppression
question: A deal resolves to 30,000 matched NPIs. You suppress 6,000 that are low-decile or non-accessible. What count should pacing and forecasting use?
- 24,000 net addressable NPIs
- 36,000, the matched plus suppressed total
- 30,000, the full matched count
- 6,000, the suppressed count
answer: 0
explain: Net addressable supply is matched minus suppressed: 30,000 minus 6,000 = 24,000. Pace against 24,000, since spend aimed at the suppressed 6,000 burns on non-writers or generates unserviceable demand.
:::

:::q Pacing, Frequency and Troubleshooting
question: An NPI is capped at 3 per week on each of three channels (endemic, open web, CTV) with no cross-channel dedup. Against a unified cap of 3 per week, what is the weekly overdelivery on that NPI?
- 0, because each channel respects the cap
- 9 exposures per week
- 3 exposures per week
- 6 exposures per week
answer: 3
explain: Three channels at 3 each stack to 9 weekly impressions, minus the unified cap of 3 leaves 6 overdelivered. A per-channel cap is not a global cap, which is why cross-channel dedup is the core pacing competency.
:::

:::q Pacing, Frequency and Troubleshooting
question: A healthcare campaign is underperforming. Following the fixed diagnostic order, which stage do you check first?
- The lift study's statistical power
- The NPI-to-device match rate
- The creative engagement rate
- The end-of-flight cost per script
answer: 1
explain: Match rate is first because if the DSP cannot connect target NPIs to live opportunities, every downstream metric is reading a broken foundation. Power and cost per script are last; engagement is a proxy checked after delivery.
:::

:::q Pacing, Frequency and Troubleshooting
question: A flight is under-pacing and reach looks thin, but match rate is healthy. Before raising bids, which two MLR-gated causes do you rule out first?
- A small control group and a high CPM
- A silently paused MLR-expired creative and brand-safety over-blocking starving supply
- A low NBRx:TRx ratio and a stale decile universe
- An unclosed Rx-lag window and a thin panel
answer: 1
explain: In pharma, pacing failures hide behind regulatory and supply causes. Confirm the creative is still MLR-approved and not auto-paused, then check that keyword blocklists are not over-blocking eligible medical inventory, before re-pacing.
:::

:::q Pacing, Frequency and Troubleshooting
question: After the lift window closes, lift is genuinely weak and only 53 percent of spend reached deciles 6 to 10. What does that signal and what is the fix?
- Strong concentration; raise frequency on the same NPIs
- A measurement artifact; rerun the same flight unchanged
- Budget leaked to low-volume prescribers; suppress deciles 1 to 4 and re-concentrate before relaunch
- An access barrier; buy more impressions to the same list
answer: 2
explain: Decile 6 to 10 concentration below 60 percent flags over-investment in low-volume HCPs who were never going to move scripts. The fix is to suppress deciles 1 to 4 and re-concentrate budget on writable volume before relaunch.
:::
