# Research: AI in Programmatic (2026) + Cloud AI for a native macOS app

Sources inline. Vendor/secondary performance stats flagged [VERIFY] (teach as "reported/claimed", not independent results). A phishing lookalike domain (docs.anthropic.com.dns.asdtaeta.xyz) appeared in search and was ignored; only legitimate Anthropic/Claude docs used.

## Part 1 — What AI is doing in programmatic (for cited teaching content)

1. **Agentic / autonomous media buying.** AI agents take a goal + guardrails and plan/transact/optimize end to end. PubMatic AgenticOS (CES Jan 2026, 20+ agents); TTD Koa "Adaptive Trading Modes" (Performance Mode co-pilot). Validated case: PubMatic/Havas for Telefonica/Movistar hit CPM 18% below target, impressions 23% above, setup time cut up to 80%. Still mostly human-supervised. Source: https://pubmatic.com/news/pubmatics-agenticos-accelerates-globally-as-agentic-campaigns-unlock-efficiency-and-performance/ , https://www.marketingdive.com/news/pubmatic-debuts-agentic-platform-to-solve-programmatics-ai-headaches/808709/
   Teach: agentic buying replaces the manual plan->bid->optimize loop; the new skill is writing good objectives and guardrails, not pushing buttons.

2. **ML in bidding (bid shading, value/win-rate prediction, RL pacing).** ML prices each impression: predict win prob + conversion value, shade the bid to the minimum to win. "Generative Bid Shading" (arXiv Aug 2025) https://arxiv.org/html/2508.06550 ; RL for budget/bid https://eajournals.org/ejcsit/wp-content/uploads/sites/21/2025/06/Reinforcement-Learning.pdf . [VERIFY] exact figures (RL +23.4%, CPA -32%, conv +27%) are secondary.
   Teach: in a first-price auction the bid shade (predicted value minus actual bid) is where the math lives; RL learns that gap per impression from your own conversion data.

3. **Generative AI in creative (DCO, variants, scaling).** Generate headline/image/video variants, auto-pick winners, refresh fatigued ads; CTV DCO does real-time variations. Source: https://www.inbeat.co/articles/generative-ai-in-advertising/ , https://starti.ai/blog/how-does-generative-ai-power-ctv-dco/ . [VERIFY] "22-34% higher ROAS vs static" is vendor.
   Teach: DCO turns one creative into a combinatorial space; allocating impressions to find the winning variant fastest is a multi-armed-bandit problem.

4. **AI in measurement (Bayesian MMM, incrementality).** Google Meridian (open-sourced Feb 2025) and Meta Robyn rebuild measurement for a post-cookie world; estimate incrementality, calibrate with geo/lift experiments. Source: https://business.google.com/us/think/measurement/meridian-marketing-mix-model/ , https://www.emarketer.com/content/google-meridian-makes-mmm-accessible
   Teach: MMM decomposes sales into channel contributions with adstock and diminishing-returns curves; incrementality experiments calibrate it so coefficients mean "caused", not "correlated".

5. **AI in optimization (pCTR/pCVR, lookalikes, fraud).** Predictive scores feed the bid; fraud classifiers flag invalid traffic. Source: https://arxiv.org/html/2401.15246 , https://basis.com/blog/7-programmatic-advertising-trends-shaping-2026 . [VERIFY] "~20% IVT / >$100B fraud" is secondary.
   Teach: bid value = pCTR x pCVR x value-per-conversion, so the optimization stack is a chain of probability estimates; a fraud filter is a classifier protecting that equation's inputs.

6. **Platform AI products.** TTD Kokai/Koa (Adaptive Trading Modes, AI data scoring) https://ppc.land/the-trade-desks-q2-kokai-updates-ai-controls-ctv-pause-ads-deal-desk/ ; Google AI Max / Performance Max (AI Max exiting beta ~Apr 2026; PMax ~4M advertisers) https://www.adexchanger.com/ai/google-touts-its-ai-ad-tech-adoption-and-new-ai-max-features/ ; Amazon Performance+ / DSP https://www.marketingdive.com/news/amazon-dsp-now-fully-featured-ad-sales-boom-continues/804365/ ; Meta Advantage+ (11 new AI tools at Cannes 2025) https://www.adtaxi.com/blog/metas-ai-advertising-plans-what-to-expect-in-2026-and-how-to-prepare/ . [VERIFY] all platform performance % are vendor claims.
   Teach: every major platform now ships the same pattern (set objective + guardrails, hand bidding/targeting/creative to AI); compare them on how much control and transparency they give back.

7. **Risks and limits.** Black-box buying reduces control; walled gardens limit independent measurement; 54% of advertisers say genAI hurt media quality. IAB AI Transparency and Disclosure Framework (Jan 15, 2026), risk-based, with C2PA machine-readable provenance. Source: https://www.iab.com/news/iab-releases-industrys-first-ai-transparency-and-disclosure-framework-to-guide-responsible-advertising-in-a-generative-ai-landscape/
   Teach: when you hand bidding and targeting to a model you cannot fully inspect, your job shifts from optimizing to auditing. Set guardrails, demand logs/explanations, verify with independent measurement.

## Part 2 — Cloud AI for the app (no local models)

### Claude Messages API (confirmed against official docs)
- Base URL `https://api.anthropic.com`; endpoint `POST /v1/messages`.
- Headers: `x-api-key: <KEY>`, `anthropic-version: 2023-06-01`, `content-type: application/json`.
- Body: `model`, `max_tokens`, `messages: [{role, content}]` required; optional `system`, `temperature`, `stream`.
- Response: `content` array of blocks (`{type:"text", text}`), `stop_reason`, `usage`.
- Model IDs: `claude-opus-4-8` (1M ctx, top), `claude-sonnet-4-6` (1M, balanced, DEFAULT for a tutor), `claude-haiku-4-5-20251001` (fast/cheap), `claude-fable-5` (GA Jun 2026).
- Streaming: `"stream": true`, SSE; text arrives in `content_block_delta` with `delta.type == "text_delta"`.
- Swift: no official Swift SDK; use URLSession (`data(for:)` or `bytes(for:)` for SSE) with Codable structs.
- Docs: https://platform.claude.com/docs/en/api/messages , https://platform.claude.com/docs/en/api/streaming , https://platform.claude.com/docs/en/docs/about-claude/models/overview

### Bring-your-own-key (BYOK)
- Never hardcode (extractable from the binary). Read order: macOS Keychain (user-entered), then `ANTHROPIC_API_KEY` env var (the SDK convention). Degrade gracefully with no key: disable AI routes, show "Add your Anthropic API key to enable the AI tutor", link https://platform.claude.com/settings/keys . Never log the key. Surface 401/413/429 as actionable errors.

### A trustworthy AI tutor (grounded in Anthropic's reduce-hallucinations guidance)
https://docs.claude.com/en/docs/test-and-evaluate/strengthen-guardrails/reduce-hallucinations
- Ground answers ONLY in the current lesson text/formulas passed as context.
- Allow "I don't know" / decline rather than fabricate.
- Require it to quote the relevant lesson passage and cite the section.
- Chain-of-thought then self-check (find a supporting quote per claim; retract if none).
- Socratic: hints and guiding questions first, final answers on request; verify the learner's arithmetic against an in-app computed answer rather than the model's mental math.
- Teach: a trustworthy AI tutor is grounded, citable, hint-first; it quotes the lesson, admits uncertainty, and verifies each claim.
