---
id: vertical-qsr-07
track: vertical-qsr
module: 7
title: Identity and Signal Loss: The Email to MAID to Household-IP to Geo Chain and MAID Deprecation
summary: Trace the identity chain that QSR targeting and footfall attribution both ride, quantify how each hop and MAID deprecation degrade it, and build resilient measurement that caveats the decay.
---
# The chain every QSR tactic rides

In QSR programmatic, both the targeting and the footfall measurement depend on the same fragile identity chain: a known customer's hashed email maps to a mobile ad ID (MAID), the MAID maps to a household IP, and the household IP anchors to a geo or location. Every tactic you run sits somewhere on that chain, so when you onboard a loyalty file or read a visit report you are really trusting a series of probabilistic hops, not one clean identifier. The trader's first job is to know which link each tactic leans on, because the link that breaks decides whether the audience or the lift number is real.

The chain is directional and lossy. An email that never resolves to a MAID cannot target a phone, and a MAID that never anchors to a geo cannot tie an exposure to a store visit. Treat the chain as a pipeline where the output is only ever a fraction of the input.

:::figure cleanRoomMatch
caption: The identity chain for QSR. A hashed email resolves to a MAID, the MAID to a household IP, the IP to a geo, and the same chain that powers targeting also powers footfall attribution, so any broken hop hurts both.
:::

# Match rate, the metric that governs the chain

A match rate is matched identifiers divided by input identifiers at a single hop, and the whole chain's survival is the product of the per-hop rates. If a loyalty file resolves to MAIDs at 50%, MAIDs to household IPs at 80%, and IPs to geo at 90%, the share of input emails that survive all the way to a geo anchor is the product, not the average. Reading match rates one hop at a time hides how brutal the compounding is.

The formula the trader keeps in their head is the chain product:

$$ \text{chain survival} = r_{\text{email} \to \text{MAID}} \times r_{\text{MAID} \to \text{IP}} \times r_{\text{IP} \to \text{geo}} $$

That is why a CRM file that looks enormous on a slide can deliver a target audience a fraction of its size, and why the same shrinkage quietly shows up later in how many visits you can actually attribute.

:::predict
prompt: An identity chain has hop match rates of 50% (email to MAID), 80% (MAID to household-IP) and 90% (IP to geo). What share of input emails survive all the way to a geo anchor?
answer: 36
tolerance: 0.5
unit: %
hint: Multiply the three rates together, do not average them.
explain: Chain survival is the product of the hops, so 0.50 x 0.80 x 0.90 = 0.36, a 36 percent survival rate. Only 36 of every 100 emails reach a geo anchor, which is why a large CRM file resolves to a much smaller addressable and attributable pool.
:::

:::predict
prompt: A QSR brand onboards a loyalty CRM file of 800,000 emails and the onboarder reports a 45% email-to-MAID match rate. How many addressable MAIDs does that yield?
answer: 360000
tolerance: 1000
unit: MAIDs
hint: Multiply the input emails by the match rate.
explain: 800,000 x 0.45 = 360,000 addressable MAIDs. More than half the file does not resolve at the very first hop, so the "addressable" audience is a fraction of the CRM list before any further attrition down the chain.
:::

# Why the chain is eroding: MAID deprecation

The chain is not stable year over year because the identifiers themselves are disappearing. On iOS, Apple's App Tracking Transparency already cut IDFA availability to roughly 30%, since the device ID is now opt-in only, and Google is moving the Android Advertising ID (GAID) toward the same user-opt-in basis. California's DROP (Delete Request and Opt-out Platform) and similar regimes push consumers to find, reset, and delete their MAID, shrinking the deterministic pool further. As MAIDs thin, the deterministic link between an exposure and a later store visit weakens, so attribution leans harder on noisier household-IP and coarse geo signals.

The practical addressable share is opted-in or identifiable devices over total target devices, and for iOS that ceiling is now around 30%. The trader plans reach against that ceiling, not against the full device universe.

:::predict
prompt: Post-ATT, IDFA is available on about 30% of iOS devices. Out of 2,000,000 target iOS devices, how many are addressable by IDFA?
answer: 600000
tolerance: 1000
unit: devices
hint: Take 30 percent of the device universe.
explain: 2,000,000 x 0.30 = 600,000 addressable iOS devices. The other 1.4M opted out of IDFA under ATT, so a deterministic iOS plan must assume roughly two thirds of the audience is unaddressable by device ID.
:::

:::quiz
question: Why are year-over-year footfall comparisons for the same QSR brand suspect even when the media plan is unchanged?
- Because CPMs always rise year over year
- Because store polygons are redrawn every year
- Because the deterministic ID pool shrank between flights, so lower lift may be measurement decay rather than worse media
- Because drive-thru sales are never counted
answer: 2
hint: Think about what happened to the underlying identifiers between the two flights.
explain: As MAIDs deprecate, the deterministic ID pool shrinks between flights, so a lower measured lift can reflect identity decay rather than a worse buy. The trader must caveat YoY footfall comparisons because the denominator changed underneath them.
:::

# Watching the chain decay across the pipeline

It helps to see the attrition as a single curve from input to geo. Start at 100 emails, lose half at the email-to-MAID hop, lose more at MAID-to-IP, and lose a little more at IP-to-geo, and you land near a third of where you started. The shape, not just the endpoint, tells the trader which hop to fix first: here the email-to-MAID step is the cliff.

The signal-loss impact on measurement specifically is attributable visits with an ID over total visits, and that ratio falls as MAIDs deprecate, which is the same erosion expressed on the measurement side rather than the targeting side.

:::widget barChart
title: Identity-chain survival, percent of input emails
labels: Input emails, After email to MAID, After to IP, After to geo
data: 100, 50, 40, 36
unit: %
:::

:::callout key
The email-to-MAID hop is usually the steepest single drop in a QSR loyalty onboard. It loses 50 of every 100 input emails, versus 10 lost at MAID-to-IP and 4 at IP-to-geo, so it is the largest leak and the first place to diagnose. Be honest about the math, though: lifting that first hop from 50% to 60% raises end-to-end survival from 36% to about 43% (0.60 x 0.80 x 0.90 = 0.432), a gain of roughly 7 points, while applying the same 10-point improvement to each of the last two hops (80% to 90% and 90% to 100%) yields 0.50 x 0.90 x 1.00 = 0.45, a gain of 9 points. So you fix the first hop because it is the biggest absolute loss, not because a marginal nudge there beats improving the later hops. The later hops have less room above them, which is precisely why the first hop dominates total attrition.
:::

# Identity loss hits CPIV, not just reach

Signal loss is not only a reach problem; it directly inflates the brand's north-star KPI, cost per incremental visit (CPIV). A smaller addressable and attributable pool means fewer incremental visits you can drive and credit for the same spend, so CPIV rises even when the media is identical. The trader has to forecast that drift, not get blindsided by it in a QBR, because the client reads CPIV as performance and will not automatically credit a shrinking ID pool.

Work a clean case. A QSR LTO spends $90,000 and in last year's flight drove 10,000 incremental visits, for a CPIV of $9.00. This year the deterministic ID pool has thinned, so at the same $90,000 spend the campaign reaches and attributes fewer people and drives 7,500 incremental visits.

:::predict
prompt: A QSR flight spends $90,000 and, after identity decay shrinks the attributable pool, drives 7,500 incremental visits this year versus 10,000 last year. What is this year's CPIV?
answer: 12
tolerance: 0.1
unit: USD
hint: CPIV is media spend divided by incremental visits.
explain: CPIV = 90,000 / 7,500 = 12.00. Last year was 90,000 / 10,000 = 9.00, so the same spend now costs $12.00 per incremental visit purely because the identity pool shrank, not because the buying got worse.
:::

:::predict
prompt: Using the two CPIV figures above, last year $9.00 and this year $12.00, what is the year-over-year increase in CPIV?
answer: 33.3
tolerance: 0.3
unit: %
hint: Percent change is (new minus old) divided by old.
explain: (12.00 - 9.00) / 9.00 = 0.333, a 33.3 percent rise in CPIV. The trader must attribute that increase to identity decay and not let it be read as a 33 percent drop in trading skill.
:::

:::quiz
question: A QSR brand's reported visit lift is flat year over year, but CPIV rose 30%. The media plan, geos and budget were identical. What is the most defensible explanation to lead with?
- The footfall vendor raised its prices
- The stores got less popular
- The DSP changed its auction to first-price
- The deterministic identity pool shrank, so fewer visits were attributable per dollar at constant media
answer: 3
hint: Identical plan, identical budget, fewer attributable people. What changed underneath the buy?
explain: With the plan and budget held constant, a shrinking deterministic ID pool means fewer incremental visits are attributable per dollar, which raises CPIV. That is the identity-decay explanation, and it is why the trader caveats CPIV trends against signal loss rather than against trading performance.
:::

# Building resilience and caveating the numbers

The defense is to know which signal each tactic depends on and to diversify off the deprecating ones. Lean on consented first-party data (loyalty and app emails) onboarded to MAIDs where they still exist, household-IP and CTV-graph linkage for the living room, contextual and geo signals where IDs are gone, and clean-room or cohort matching for measurement so the answer survives at the aggregate level even when 1:1 IDs do not. Crucially, deterministic-match claims must acknowledge consent and coverage limits, so the trader documents which signal is carrying each result.

The hard part is honesty: identity graphs and onboarders disagree on the same email-to-MAID mapping, so match rates and the resulting audiences differ by vendor with no ground truth, and household IP is shared across apartments, offices and carrier CGNAT, so IP-anchored work can conflate unrelated people. Build resilience, then caveat the output accordingly.

:::callout warning
A common operator pain point from r/adops and r/programmatic: match rates "fall off a cliff" as MAIDs deprecate, so onboarded first-party QSR audiences shrink and reach targets become unrealistic, and footfall or location measurement quietly degrades while clients are not told the numbers are less reliable than last year. The fix is to forecast the shrinkage into reach and CPIV up front and to state the measurement caveat in the report, not to let the decay surface as an unexplained miss.
:::

:::quiz
question: Which resilience tactic best preserves measurement when 1:1 MAID matching is no longer reliable?
- Clean-room or cohort-level matching that answers at the aggregate rather than per-device
- Buying only open-exchange inventory
- Raising the frequency cap to 10x
- Switching all spend to display
answer: 0
hint: If you cannot match one person to one device, match groups of people instead.
explain: Clean-room and cohort-level matching keep measurement working at the aggregate when deterministic 1:1 MAID matching breaks, which is why sophisticated buyers shift footfall measurement toward consented, cohort-based methods as IDs deprecate.
:::

:::sources
- New Digital Age, Google's Android privacy policies starting to look like Apple's on iOS | https://www.adweek.com/programmatic/googles-android-privacy-policies-are-starting-to-look-like-apples-on-ios/
- California Privacy Protection Agency, Understanding Mobile Advertising IDs and DROP | https://privacy.ca.gov/2025/12/understanding-mobile-advertising-ids-and-drop/
- aidigital, Foot Traffic Attribution: polygon mapping, dwell, coverage limits | https://www.aidigital.com/blog/footfall-attribution
- Cuebiq, Footfall Attribution Benchmarks (CPIV by vertical) | https://cuebiq.com/benchmarks/
- Restaurant Dive, Drive-thru share of US fast-food sales and digital order growth | https://www.restaurantdive.com/news/drive-thru-sales-qsr/
- KORTX, Restaurant Marketing Strategy: The 2026 QSR Playbook | https://kortx.io/news/restaurant-marketing-strategy-qsr/
:::
