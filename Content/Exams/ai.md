---
track: ai
title: AI in AdTech Certification
pass: 0.7
draw: 12
---
:::q AI Landscape
question: Across The Trade Desk Kokai, Google Performance Max, Amazon Performance plus, and Meta Advantage plus, what is the common 2026 pattern?
- Manually pick every placement and write static bid rules per line item
- Set an objective and guardrails, then hand bidding, targeting, and creative to AI
- Disable automation and bid a flat CPM on all inventory
- Outsource the whole campaign to a human trading desk with no software
answer: 1
explain: Every major platform converged on the same shape, the buyer declares a goal plus constraints and the AI system runs bidding, targeting, and creative assembly inside those constraints. The differentiator is how much control and transparency each gives back.
:::

:::q AI Landscape
question: A platform deck reports that its automated buying mode lifted conversions by a large percentage, measured inside its own system. How should you read that figure?
- As an independently audited industry benchmark
- As a guaranteed result you can promise a client
- As a vendor claim measured in a walled garden, to be confirmed by independent measurement
- As proof the model is fully transparent
answer: 2
explain: A platform measuring its own automation inside its own walled garden is grading its own homework. Treat any self-reported number as a claim until a holdout or third-party measurement confirms it.
:::

:::q AI Landscape
question: When a model decides which impressions to buy and at what price but you cannot inspect why, what is this limit called?
- The black box
- The cold start
- The error budget
- The clearing price
answer: 0
explain: The black box is the loss of visibility into automated decisions. You can no longer trace a spend decision back to a rule you wrote, which is why your job shifts from optimizing toward auditing and demanding logs and explanations.
:::

:::q Agentic Buying
question: How does an agentic buying system differ from an AI co-pilot?
- It only suggests bids for a human to approve
- It removes the need for any objective or budget
- It bids a fixed CPM and never adapts
- It takes a goal plus guardrails and then plans, transacts, and optimizes end to end on its own
answer: 3
explain: A co-pilot suggests and a human approves, while an agentic system runs the whole plan-bid-optimize loop autonomously inside the limits you set. That autonomy is why supervision and auditing become the human's core job.
:::

:::q Agentic Buying
question: An agentic system is given the single objective maximize conversions with no guardrails. What is the most likely failure?
- It refuses to spend any budget
- It chases conversions at any cost, blowing past a sustainable CPA and buying low-quality inventory
- It automatically infers your margin and protects profitability
- It always matches a human trader's results exactly
answer: 1
explain: With no cost or quality constraint, the agent optimizes exactly what you declared and buys conversions at any price on poor inventory. Guardrails like a max CPA and an inventory allowlist are what keep an autonomous agent inside the box.
:::

:::q AI Math & Measurement
question: An impression has a predicted click-through rate of 0.03 and a predicted conversion rate of 0.08, and a conversion is worth 50 dollars. What is the expected bid value?
- 1.20 dollars
- 1.2 cents
- 12 cents
- 12 dollars
answer: 2
explain: Bid value equals pCTR times pCVR times value per conversion, 0.03 times 0.08 times 50 equals 0.12 dollars, which is 12 cents. This expected payoff is what the model prices against.
:::

:::q AI Math & Measurement
question: A model values an impression at 0.50 dollars and, in a first-price auction, shades its bid down to 0.40 dollars. What is the bid shade as a percentage of the predicted value?
- 10%
- 40%
- 80%
- 20%
answer: 3
explain: The shade is 0.50 minus 0.40 equals 0.10 dollars. As a percent of value, 0.10 divided by 0.50 times 100 equals 20 percent. Shading 20 percent means the model bid 80 percent of value and bet that was still enough to win.
:::

:::q AI Math & Measurement
question: Why is dynamic creative optimization framed as a multi-armed bandit rather than a fixed A/B test?
- A bandit never tests more than one variant
- A bandit shifts impressions toward better variants as confidence grows, reducing waste while still exploring
- A bandit ignores performance data entirely
- An A/B test always finds the winner faster than a bandit
answer: 1
explain: A fixed A/B split keeps sending equal traffic to every variant even after a loser is obvious, wasting impressions. A bandit balances exploration and exploitation, moving traffic to stronger arms while still sampling the rest, so it converges with less waste.
:::

:::q Limits & Governance
question: A Bayesian marketing-mix model assigns large credit to a channel coefficient. Before reading it as causal, what must you do?
- Accept the coefficient, since Bayesian models are causal by construction
- Increase the channel's budget to confirm the credit
- Calibrate the model against incrementality experiments like geo holdouts or lift tests
- Remove the adstock and saturation terms
answer: 2
explain: A coefficient alone only means correlated. To make it mean caused you anchor the fitted curves to measured causal lift from geo holdouts or lift tests. An uncalibrated coefficient is the same hallucinated-causation trap that black-box automation invites.
:::

:::q Limits & Governance
question: The IAB released its AI Transparency and Disclosure Framework in January 2026. What best describes the industry shift it responds to?
- A requirement that all bidding return to manual rules
- A ban on automated buying across all platforms
- A guarantee that walled gardens now allow full independent measurement
- A move from optimizing to auditing, with standards and provenance to verify opaque AI decisions
answer: 3
explain: As automation removes your view of the machine, your job shifts from optimizing to auditing. The risk-based framework, paired with provenance standards like C2PA, gives the industry a way to demand transparency and verify decisions that you cannot otherwise inspect.
:::

:::q AI Landscape
question: You are comparing two automated buying platforms for a contract. Per the lesson, on what basis should you compare them rather than on their published performance numbers?
- How much control and transparency each one hands back to you
- Which one reports the single largest conversion lift in its own deck
- Which one has the most advertisers signed up
- Which one launched its automation feature most recently
answer: 0
explain: Raw performance claims are measured inside each vendor's own walled garden, so they are not comparable across platforms. The lesson says to compare these systems on how much control and transparency they return to you, because that is what you can actually verify and what determines whether you can audit the machine.
:::

:::q AI Landscape
question: A survey cited in the lessons found that 54 percent of advertisers said generative AI had hurt media quality. How should you treat this signal when a vendor pitches you fully automated buying?
- As proof that all automated buying should be banned outright
- As irrelevant, since it is only an opinion survey
- As a reason to disable every guardrail and trust the model
- As evidence that automation without oversight carries real downside, so insist on guardrails and verification
answer: 3
explain: The 54 percent figure is a signal that handing buying to a model without oversight can degrade media quality. It does not mean automation is useless, it means you set guardrails, demand logs and explanations, and verify with independent measurement rather than trusting the system on its own.
:::

:::q Agentic Buying
question: An agentic system presents a plan citing a high-value audience segment and several premium inventory sources. Following the lesson, what is the correct first response before approving spend?
- Approve it, since the agent expressed high confidence in the plan
- Double the budget because the segment sounds valuable
- Require the agent to show the segments, inventory, and bid logic, then confirm each one actually exists and matches your guardrails
- Ask the agent to pick a different objective on its own
answer: 2
explain: Agents can hallucinate targeting, inventing audience segments or inventory rationales that sound plausible but do not correspond to anything real. The lesson says never to accept a plan on confidence alone. You require the agent to show the underlying segments, inventory, and bid logic and verify each one exists and stays inside your guardrails.
:::

:::q Agentic Buying
question: During an audit, an agentic buyer cannot produce a decision log or any justification for why it bought a particular block of inventory. Per the lesson, how should you treat this?
- As a minor gap that does not matter if performance looks fine
- As a red flag, because the transparency you can extract is the only thing standing between you and a black box spending your budget
- As proof the agent is efficient and self-sufficient
- As a reason to widen the guardrails so the agent has more freedom
answer: 1
explain: The lesson is explicit that if an agent cannot produce a log or a justification for a decision, you treat it as a red flag, not a minor gap. Decision logs and explanations are what let you audit an autonomous system, and without them you are back to an unaccountable black box.
:::

:::q Agentic Buying
question: A trader's planning and trafficking task that took 10 hours is cut by the reported up-to 80 percent setup-time reduction. Beyond the time saved, what does the lesson say you should do with the reclaimed hours?
- Redirect them toward writing better objectives and auditing the agent
- Use them to manually re-bid every impression by hand
- Bank them as pure headcount savings and add no oversight
- Spend them re-running the same automated plan repeatedly
answer: 0
explain: An 80 percent cut leaves 20 percent of the time, so a 10 hour task becomes 2 hours and frees 8 hours. The lesson says that reclaimed time is exactly what you redirect from button-pushing toward specifying good objectives and auditing the agent, which is the new human job.
:::

:::q AI Math & Measurement
question: An impression has a predicted click-through rate of 0.05 and a predicted conversion rate of 0.04, and a conversion is worth 80 dollars. What is the expected bid value, and why does auditing this number matter?
- 4 dollars, and it does not matter because the AI owns the value
- 40 cents, and it is the only input the model cannot change
- 16 cents, and knowing it lets you judge whether a guardrail like a max CPA is even feasible
- 1.60 dollars, and it proves the campaign is profitable
answer: 2
explain: Bid value equals pCTR times pCVR times value per conversion, 0.05 times 0.04 times 80 equals 0.16 dollars, which is 16 cents. The lesson stresses you cannot audit what you cannot quantify, so reasoning about this product is what tells you whether a guardrail like a max CPA is achievable.
:::

:::q AI Math & Measurement
question: A model values an impression at 0.60 dollars and, in a first-price auction, shades its bid to 0.45 dollars. What is the bid shade as a percentage of the predicted value?
- 15%
- 45%
- 75%
- 25%
answer: 3
explain: The shade is 0.60 minus 0.45 equals 0.15 dollars. As a percent of value, 0.15 divided by 0.60 times 100 equals 25 percent. The model bid 75 percent of value and bet that was still enough to win, which is exactly the gap reinforcement learning is trained to set.
:::

:::q AI Math & Measurement
question: A static creative converts at a 0.020 rate and a DCO bandit finds a winning variant converting at 0.025. A vendor labels the relative lift as independently proven. What is the lift, and how should you treat the claim?
- 5 percent, and accept it as an audited benchmark
- 25 percent, but treat the versus-static figure as claimed until independent measurement confirms it
- 20 percent, and assume every future variant performs the same
- 0.5 percent, and ignore the bandit entirely
answer: 1
explain: Relative lift equals (0.025 minus 0.020) divided by 0.020 times 100, which is 0.005 divided by 0.020 times 100 equals 25 percent. The lessons note that higher ROAS or lift figures quoted versus static are vendor claims, not independent results, so you confirm them with your own holdout or third-party measurement.
:::

:::q AI Math & Measurement
question: A media plan calls for 8,000,000 impressions and an agentic case reports delivering 23 percent above plan. How many impressions is that, and what is the right posture toward the figure?
- 9,840,000 impressions, and read it as a reported magnitude, not an independent benchmark
- 8,230,000 impressions, and treat it as a guaranteed result
- 6,160,000 impressions, and assume delivery fell short
- 10,400,000 impressions, and promise the client the same outcome
answer: 0
explain: 23 percent above plan means 123 percent of the plan, so 8,000,000 times 1.23 equals 9,840,000 impressions. The Telefonica Movistar numbers are reported by the vendor and its agency, not independently audited, so you treat the delivery figure as a claimed magnitude to verify, not a promise.
:::

:::q Limits & Governance
question: An MMM assigns a large coefficient to a paid channel and a stakeholder wants to shift budget into it immediately. Per the lesson, what does that coefficient mean on its own, and what must happen first?
- It means caused already, so shift the budget without further checks
- It includes adstock, so no calibration is needed
- It means only correlated, so you calibrate against geo holdouts or lift tests before reading it as causal
- It is meaningless and should be deleted from the model
answer: 2
explain: A Bayesian MMM coefficient on its own only means correlated. To make it mean caused you anchor the fitted curves to measured causal lift from incrementality experiments like geo holdouts or lift tests. An uncalibrated coefficient is the same hallucinated-causation trap that black-box automation invites.
:::

:::q Limits & Governance
question: A content provenance question comes up in a governance review. What does C2PA provide, and how does it relate to the IAB framework released January 15, 2026?
- A bidding algorithm that replaces reinforcement learning, unrelated to the IAB
- A machine-readable provenance record of how content was made, pairing with the risk-based IAB framework
- A walled-garden measurement tool that blocks third-party audits
- A frequency cap standard that limits how often an ad serves
answer: 1
explain: C2PA is a machine-readable provenance standard that attaches a verifiable record of how a piece of content was made. The IAB released its risk-based AI Transparency and Disclosure Framework on January 15, 2026, and it pairs with C2PA so the industry can demand transparency and verify opaque AI decisions.
:::

:::q Limits & Governance
question: A vendor insists you trust its in-platform reporting because independent measurement is not available for its inventory. What limit is this, and what is the disciplined response?
- The cold start, so wait for more data before acting
- The error budget, so accept the reporting as-is
- The clearing price, so bid higher to get visibility
- The walled garden, so treat the reporting as a claim and verify with a holdout or third-party measurement where possible
answer: 3
explain: Walled gardens restrict independent measurement of their own inventory, so you are asked to trust the platform reporting its own performance. The disciplined response is to treat any self-reported number as a claim, grade it against a holdout or third-party measurement where you can, and refuse to promise a client a number you cannot verify.
:::

:::q AI Landscape
question: A teammate argues that because the AI now does the buying, learning the bid-value math is a waste of time. Per the lesson, why is that wrong?
- You cannot audit what you cannot quantify, so the math is what lets you set sane guardrails and catch a model gone wrong
- Because the math changes the model's predictions directly
- Because manual bidding will return and replace automation
- Because vendors require buyers to recompute every bid by hand
answer: 0
explain: Every automated bid still resolves to an expected value built from pCTR, pCVR, and value per conversion. The lesson stresses you cannot audit what you cannot quantify, so understanding how that value is built is exactly what lets you set feasible guardrails like a max CPA and catch a model that has gone wrong.
:::

:::q Agentic Buying
question: A practical audit loop for an agentic buyer includes several checks. Which sequence matches the lesson's described audit?
- Approve the plan, then increase budget, then disable logging
- Trust reported performance, skip the allowlist check, and relax guardrails
- Let the agent grade itself, ignore holdouts, and accept its confidence
- Demand decision logs, verify a sample of placements against your allowlist, compare reported performance against a holdout or third-party measurement, and confirm no guardrail was silently relaxed
answer: 3
explain: The lesson lays out the audit loop explicitly. You demand decision logs, verify a sample of placements against your allowlist, compare the agent's reported performance against a holdout or third-party measurement, and confirm no guardrail was silently relaxed. That is what keeps an autonomous agent accountable rather than a black box spending your budget.
:::
