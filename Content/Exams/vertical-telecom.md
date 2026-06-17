---
track: vertical-telecom
title: Telecom Programmatic Certification
pass: 0.7
draw: 12
---
:::q Landscape and Channels
question: A carrier client asks why they keep seeing their own brand's first-party audience segments for sale to other advertisers. What structural shift explains this in 2025 telecom?
- The carrier has stood up a retail media network (like T-Mobile Advertising Solutions) that monetizes its first-party subscriber data and inventory even while running acquisition campaigns
- The DSP is reselling the carrier's bid logs without consent
- Open exchanges now require all advertisers to share audiences
- The carrier's agency leaked the CRM to competitors
answer: 0
explain: Carriers such as T-Mobile (via the Vistar and Blis acquisitions), Verizon, and Comcast built RMNs that sell their first-party data and inventory to other categories, so the same carrier whose campaign you run is also a media owner and competitor, creating real data-leakage concerns.
:::

:::q Landscape and Channels
question: Roughly 92% of US digital display ad spend (about $180B in 2025) transacts programmatically. What does this fact mean for how a new telecom trader should view the programmatic stack?
- It is one niche channel among many, so deep DSP fluency is optional
- It applies only to CTV, not to display
- It means open RTB is the only path that matters
- It is essentially how display is bought, so programmatic fluency is the entire job rather than a specialty
answer: 3
explain: At about 92% of all US digital display, programmatic is no longer a niche slice; it is how display is bought, which is why mastering the DSP, deals, pacing, and targeting mechanics is the whole job rather than one channel among many.
:::

:::q Landscape and Channels
question: Telecom led all US verticals in digital ad spend growth at about 16% in 2024 to 2025. On a $500,000,000 carrier digital budget, what dollar increase does that 16% growth represent?
- $8,000,000
- $16,000,000
- $80,000,000
- $800,000,000
answer: 2
explain: $500,000,000 times 0.16 equals $80,000,000. A single carrier adding 16% to a half-billion-dollar digital budget pours another $80M into the same auctions you bid in, which is why competition for each switcher is so direct.
:::

:::q Landscape and Channels
question: A trader frames campaign success to a carrier's growth team as a 0.45% CTR and 40,000,000 impressions delivered. Why is this the wrong scoreboard for the telecom mandate?
- CTR and impressions are the only metrics carriers fund
- Impressions matter more than reach in every subscription business
- CTR directly determines handset subsidy levels
- The signature KPI is LTV:SAC measured by cost-per-gross-add, so clicks and raw impressions are vanity metrics that can move while unit economics break
answer: 3
explain: In a subscription business the only event that pays rent is a profitable gross add, so the trader optimizes to LTV:SAC and CPGA. A strong CTR can sit on top of a base of low-value, high-churn adds that quietly fail the only test that matters.
:::

:::q The Mandate and KPI
question: A postpaid segment shows a Net LTV of $1,470 per subscriber and a loaded SAC of $420. What is the LTV:SAC ratio, and does it clear the healthy 3:1 telecom gate?
- 2.8:1, fails the gate
- 3.5:1, clears the gate
- 4.2:1, clears the gate
- 3.0:1, exactly at the gate
answer: 1
explain: $1,470 divided by $420 equals 3.5, an LTV:SAC of 3.5:1 that clears the 3:1 gate. The ratio is the question every bid and deal ultimately answers: does lifetime value clear roughly three times the loaded cost to win the subscriber.
:::

:::q The Mandate and KPI
question: A trader builds a per-subscriber LTV using Verizon's reported postpaid ARPA of about $148 instead of per-line postpaid ARPU of about $56. What happens to the LTV:SAC gate?
- Per-subscriber revenue is overstated by roughly 2.6x, inflating LTV and silently breaking the gate (a true 1.5:1 can look like 4:1)
- Nothing, ARPA and ARPU are interchangeable units
- The gate becomes more conservative and safer
- It understates LTV and wastes budget on cheap leads
answer: 0
explain: ARPA is revenue per account and an account holds multiple lines, so feeding $148 instead of the $56 per-line ARPU overstates per-subscriber revenue about 2.6x (148 / 56). Every downstream LTV:SAC built on ARPA is inflated, so a campaign that looks like 4:1 may really be near 1.5:1.
:::

:::q The Mandate and KPI
question: A quarter's loaded acquisition costs are $200M sales and marketing, $120M handset subsidies, and $40M dealer commissions, producing 1,000,000 gross adds. What is the correctly loaded SAC (CPGA), and why does a media-only view mislead?
- $200 per gross add, and media-only is the correct view
- $360 per gross add, and a media-only $200 view understates true SAC by $160 and breaks the gate
- $320 per gross add, excluding commissions
- $160 per gross add, after netting out subsidies
answer: 1
explain: ($200M + $120M + $40M) / 1,000,000 equals $360 per gross add, inside the $350 to $400 industry band. SAC by definition loads subsidy and commission, so a media-only $200 view understates true acquisition cost by $160 and lets a campaign pass a gate the loaded number fails.
:::

:::q The Mandate and KPI
question: A postpaid line churns at 1.0% per month. What is its expected customer lifetime, and why does a small churn change matter so much?
- 10 months, and churn barely moves LTV
- 50 months, and churn is irrelevant to LTV
- 100 months, and dropping churn to 0.9% would stretch lifetime to about 111 months, a roughly 22% longer revenue tail
- 1,000 months, and churn only affects prepaid
answer: 2
explain: Expected lifetime is 1 divided by monthly churn, so 1 / 0.01 equals 100 months. At 0.9% churn lifetime stretches to about 111 months and at 1.1% it compresses to about 91 months, so a fraction of a churn point materially moves LTV and the allowable SAC built on it.
:::

:::q Targeting and Identity
question: A $1,000,000 fiber line item buys a $9 CPM, beats its CTR target, and converts clicks well, but 30% of impressions land outside the build-out footprint. How should you treat that out-of-footprint 30%?
- $300,000 of absolute waste, because those households cannot order service regardless of CPM or CTR
- Acceptable, because the low CPM and strong CTR prove quality supply
- Partially recoverable, since some out-of-footprint clickers may move into the footprint
- Fine as long as blended CPGA still looks low
answer: 0
explain: An out-of-footprint household fails the serviceability check at the order page and can never become a gross add, so 0.30 times $1,000,000 equals $300,000 of absolute waste. Footprint is a hard inclusion layer, not a CPM question, which is why cheap impressions on unservable addresses are still zeros.
:::

:::q Targeting and Identity
question: A carrier submits 5,000,000 CRM records to a clean room and the match rate is 50%. After matching you must suppress 400,000 records that are current customers. What is the net prospect pool?
- 2,500,000
- 4,600,000
- 2,100,000
- 1,250,000
answer: 2
explain: 5,000,000 times 0.50 equals 2,500,000 matched records, then subtract the 400,000 matched current customers to get 2,100,000 net prospects. Suppression is mandatory because serving acquisition media to your existing base spends SAC on subscribers who produce zero incremental LTV.
:::

:::q Targeting and Identity
question: Your nominal CPM target is $12 but the clean-room match rate is only 50%, so only half the intended audience is reachable. What is the effective CPM on the matched reach you can actually buy?
- $6
- $12
- $18
- $24
answer: 3
explain: Effective CPM on matched reach is nominal CPM divided by match rate, so $12 / 0.50 equals $24. A 50% match does not just halve reach; it doubles the price of reaching the audience you can resolve, which is why a low match rate quietly wrecks the unit economics.
:::

:::q Targeting and Identity
question: A footprint file has 2,000,000 serviceable households, onboards at a 60% match rate, and only 80% of matched households are reachable in the bidstream. How many households can you actually address?
- 1,200,000
- 1,600,000
- 960,000
- 2,000,000
answer: 2
explain: The two haircuts compound: 2,000,000 times 0.60 equals 1,200,000 matched, then times 0.80 equals 960,000 addressable households. Match rate and targetability stack, so the addressable pool is roughly half the raw serviceable count before a dollar is spent.
:::

:::q Deals, Bidding, and Pacing
question: A PG (Programmatic Guaranteed) deal is contracted for 10,000,000 impressions and is 50% through its flight, but has delivered only 4,000,000. What is the delivery pacing ratio, and what risk does it signal?
- 1.25, spending ahead of plan
- 0.80, behind schedule and on track to under-deliver, risking make-goods
- 1.00, exactly on pace
- 0.40, but PG carries no delivery obligation
answer: 1
explain: On-pace delivery is 10,000,000 times 0.50 equals 5,000,000, so pacing is 4,000,000 / 5,000,000 equals 0.80. Because PG locks volume at a fixed price, under-delivery triggers make-goods, so you raise priority, widen supply, or escalate now rather than at flight end.
:::

:::q Deals, Bidding, and Pacing
question: A carrier sets a target Net LTV of $1,200 per postpaid sub and requires a 4:1 LTV:SAC ratio. You expect 1 gross add per 2,000 impressions. What is the allowable SAC and the resulting max CPM bid ceiling?
- Allowable SAC $300, bid ceiling $150 CPM
- Allowable SAC $4,800, bid ceiling $240 CPM
- Allowable SAC $300, bid ceiling $60 CPM
- Allowable SAC $480, bid ceiling $150 CPM
answer: 0
explain: Allowable SAC is target LTV divided by the required ratio, so $1,200 / 4 equals $300. The bid ceiling is allowable CPGA times gross-adds-per-impression times 1000, so $300 times (1/2,000) times 1,000 equals a $150 max CPM. Bidding above that loses money on loaded economics.
:::

:::q Deals, Bidding, and Pacing
question: Allowable SAC is $400 per gross add, but the handset subsidy and dealer commission together already consume $250. If you build the bid ceiling off the full $400 instead of what remains, what goes wrong?
- Nothing, media can use the full $400
- The subsidy is recovered later, so $400 is correct
- The commission should be added, raising the ceiling to $650
- Only $150 per gross add is actually available for media, so a ceiling built on $400 overpays media by $250 per subscriber and breaks the loaded LTV:SAC gate
answer: 3
explain: SAC loads media plus subsidy plus commission, so subtract the $250 of non-media cost first: $400 minus $250 leaves $150 for media per gross add. A ceiling built on the full $400 wins impressions at a media cost that still loses money once the real loaded cost lands.
:::

:::q Deals, Bidding, and Pacing
question: A $6,000,000 flight is 40% through its days but has already spent $3,000,000. What is the pacing index, and what is the specific telecom risk?
- 0.80, underdelivering and at risk of going dark
- 1.25, front-loading that risks exhausting the budget before a high-intent switching window (device launch, back-to-school)
- 1.00, on pace with no action needed
- 2.00, but front-loading is harmless on large budgets
answer: 1
explain: Planned-to-date is 0.40 times $6,000,000 equals $2,400,000, so the pacing index is $3,000,000 / $2,400,000 equals 1.25. Spending 25% ahead is the front-load signature that can leave the highest-converting switching days dark exactly when conversions peak.
:::

:::q CTV Frequency and Inventory Quality
question: A carrier CTV flight serves 30,000,000 impressions, and 12% of households are over-capped while absorbing 50% of those impressions. How many impressions land on over-capped homes, and why does the 6.0 average frequency hide this?
- 15,000,000, and the average frequency conceals a long tail where a sliver of homes sees the ad 20-plus times while much of the target is never reached
- 3,600,000, and the average correctly reflects the spread
- 6,000,000, and capping in one DSP already fixes it
- 1,800,000, and over-exposure is not a real problem on CTV
answer: 0
explain: 0.50 times 30,000,000 equals 15,000,000 impressions on the 12% over-capped homes. The tidy 6.0 average (30M / 5M unique households) says nothing about distribution, so half the budget can reinforce fatigue while the average looks healthy, which is why you read the distribution, not the mean.
:::

:::q CTV Frequency and Inventory Quality
question: You set a frequency cap of 3 inside your DSP, yet the same household is also reachable through four other SSPs, direct buys, and the carrier's RMN. Why does your DSP cap fail to control total exposure?
- The DSP ignores its own cap
- Average frequency automatically corrects across paths
- CTV impressions are never capped by any system
- Each SSP, direct buy, and RMN path is a separate frequency surface the DSP cap cannot see, so per-path caps stack into heavy total exposure
answer: 3
explain: The cap only governs the path the DSP controls. The same home reached through five independent surfaces with a cap of 3 each can take 15 exposures without breaking a single cap, which is why cross-publisher capping and supply-path consolidation are the fix.
:::

:::q CTV Frequency and Inventory Quality
question: A line item spends $27,000 for 1,000,000 impressions at a 10% IVT rate and 60% viewability. What is the effective working CPM on valid, viewable impressions, versus the $27 nominal CPM?
- $27, the nominal and effective CPM are the same
- $45
- $50
- $33
answer: 2
explain: Valid, viewable impressions are 1,000,000 times (1 minus 0.10) times 0.60 equals 540,000, so effective working CPM is $27,000 / 540,000 times 1,000 equals $50. The real cost is nearly double the $27 nominal once you strip invalid and non-viewable impressions, which is why traders price supply on quality-adjusted impressions.
:::

:::q CTV Frequency and Inventory Quality
question: The ANA/TAG TrustNet benchmark found only about 36 cents of every DSP dollar reaches the consumer as working media. On a $10,000,000 carrier budget, how much reaches the consumer, and what is the consequence for SAC?
- $3,600,000, and because only working media can produce a gross add, the leakage roughly doubles effective CPGA and erodes LTV:SAC
- $6,400,000, and the leakage has no effect on SAC
- $3,600,000, but fees and fraud do not affect the CAC math
- $9,640,000, leaving negligible waste
answer: 0
explain: $10,000,000 times 0.36 equals $3,600,000 of working media; the other $6,400,000 is fees plus invalid, non-viewable, and MFA impressions. Since only working media can produce a gross add, halving the share that reaches a prospect roughly doubles effective CPGA, so supply quality is CAC engineering.
:::

:::q QA, Incrementality, and Capstone
question: The ad server logs 1,000,000 impressions and the publisher logs 850,000 for the same placement. What is the discrepancy percent, and does it exceed the roughly 10% standard tolerance?
- 8.5%, no, it is within tolerance
- 15%, yes, it exceeds tolerance and must be investigated
- 17.6%, yes, it exceeds tolerance
- 15%, no, it is within tolerance
answer: 1
explain: Discrepancy is (sending minus receiving) over sending, so (1,000,000 minus 850,000) / 1,000,000 equals 0.15, a 15% gap. Because 15% is above the roughly 10% standard, it is investigated as a real problem (missing macros, time-zone mismatch, heavy creative, or pixel loss), not written off as noise.
:::

:::q QA, Incrementality, and Capstone
question: A carrier flight is delivering heavily but the gross-add count in reporting reads zero. What is the single most common root cause to check first?
- The bid was set too low to win auctions
- The daily budget was exhausted before measurement began
- An impression pixel that is missing or placed on the wrong event, so no downstream event records
- The creative files were too large to load
answer: 2
explain: A missing or mis-placed impression pixel is the most common total-failure cause: if it does not fire on the real render event, no click or postback records, producing a 100% downstream discrepancy that looks like the campaign simply stopped working even though media delivered.
:::

:::q QA, Incrementality, and Capstone
question: A geo holdout shows treatment markets produced 12,000 gross adds against a control-implied baseline of 9,500, on $1,000,000 of incremental spend. What is the incremental CPGA, and why does it matter against allowable SAC?
- $83, well under any ceiling
- $400, the honest cost per caused gross add that must clear the allowable-SAC ceiling, often far above the flattering observed CPGA
- $1,263, which is below observed CPGA
- $2,500, the same as the incremental adds
answer: 1
explain: Incremental gross adds are 12,000 minus 9,500 equals 2,500, so incremental CPGA is $1,000,000 / 2,500 equals $400. Only the 2,500 are media-caused; the 9,500 baseline would have arrived anyway, so this true incremental cost, not the observed last-click number, is what the LTV:SAC gate must be judged against.
:::

:::q QA, Incrementality, and Capstone
question: You are wiring a fiber-carrier switching brief end to end. Which ordering of the first three steps is correct before you ever construct deals?
- Construct PMP and PG deals, then set the LTV:SAC gate, then onboard the footprint file
- Enforce cross-publisher frequency caps, then QA pixels, then set the allowable-SAC bid ceiling
- Run the geo holdout, then suppress current customers, then derive the bid ceiling
- Set the LTV:SAC gate and allowable-SAC bid ceiling, then onboard the serviceable-footprint file, then clean-room-match the CRM with current-customer suppression
answer: 3
explain: The capstone sequence runs gate to ceiling to targeting to deals: you set the 3:1 LTV:SAC gate and derive the bid ceiling, then onboard the footprint file and clean-room-match the CRM with suppression so you only bid where the carrier can sell and never re-serve the base, all before constructing deals. A miss early (stale footprint, low match) corrupts every downstream metric.
:::
