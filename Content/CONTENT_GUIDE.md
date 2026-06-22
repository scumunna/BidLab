# BidLab lesson authoring guide

You are authoring lessons for BidLab, a math-centric interactive course on
programmatic advertising. Each lesson is one Markdown file in
`Content/Lessons/` named `{track}-{NN}.md` (zero-padded module number, e.g.
`dsp-03.md`, `engineering-11.md`). The frontmatter `id` MUST equal the filename
without extension.

## File format (strict)

```
---
id: dsp-03
track: dsp
module: 3
title: Win-rate curves and bid landscapes
summary: One sentence on what the learner will be able to do.
---
# A short heading

A paragraph of plain prose. Keep paragraphs to 2 to 4 sentences.

$$ P_{win}(b) = 1 - e^{-b / mean} $$

:::callout insight
A single key idea, one or two sentences.
:::

:::widget bidPlayground
marketMean: 0.5
value: 1.0
:::

:::quiz
question: A clear single question?
- First option
- Second option
- Third option
answer: 0
explain: One or two sentences on why the answer is correct.
:::

:::sources
- Title of a real source | https://real-url.example.com
:::
```

## Rules

- Frontmatter keys: `id`, `track`, `module`, `title`, `summary`. `track` is one
  of: foundations, core, adops, dsp, sales, planning, analytics, engineering, ai,
  or an industry vertical (`vertical-retail`, `vertical-cpg`,
  `vertical-ecommerce`, `vertical-dtc`, `vertical-auto`, `vertical-finance`,
  `vertical-travel`, `vertical-telecom`, `vertical-healthcare`, `vertical-qsr`,
  `vertical-b2b`).
- Structure each lesson as 3 to 5 short sections: a `# heading` then prose.
- Include exactly one display-math block `$$ ... $$` where the concept has a
  formula. Keep LaTeX simple. Supported: greek (`\pi \mu \sigma \lambda \alpha
  \beta \theta \rho \gamma \delta \Sigma \Delta`), operators (`\times \cdot \div
  \le \ge \approx \neq \infty \sum \to \pm \sqrt \Pr`), subscripts `_{...}`,
  superscripts `^{...}`. Do NOT use `\frac`; write ratios inline as `a / b`.
- Include 1 to 2 callouts. Kinds: `insight`, `key`, `warning`.
- Include exactly one `:::widget` where an interactive fits the topic. Choose the
  most relevant type from the catalog below. If none fits, omit the widget.
- Include exactly one `:::quiz` with 3 or 4 options and a 0-based `answer`.
- Include one `:::sources` block with 1 to 2 real, well-known industry or
  academic sources with real URLs (IAB Tech Lab, Google Ads Help, OpenRTB spec,
  The Trade Desk, MRC, peer-reviewed papers, well-known textbooks). Do not invent
  URLs that look fake.
- Writing style: clear, concrete, confident. Concise paragraphs. Define jargon on
  first use. NO EM DASHES anywhere. Use periods, commas, parentheses, or natural
  connectors instead. Avoid hype.
- Be accurate. This is read by people who know programmatic. Numbers and formulas
  must be correct.

## Widget catalog (use a type from this list only)

- `bidPlayground` (params: marketMean, value) — first-price bid vs expected profit
- `reachFrequency` (params: population) — reach and frequency curve
- `experimentPower` — A/B test power and sample size
- `budgetAllocator` — allocate budget across channels (diminishing returns)
- `marginModeler` — gross/net, margin, take rate
- `pricingCalculator` — CPM/CPC/CPA conversions
- `latencySimulator` — latency tail and timeout loss
- `throughputSimulator` — QPS capacity and utilization
- `pacingController` — even pacing throttle over a flight
- `distributionExplorer` — normal/binomial/Poisson
- `adstockExplorer` — adstock carryover
- `saturationExplorer` — Hill saturation curve
- `attributionComparison` — last-touch vs data-driven
- `funnelExplorer` — funnel conversion
- `responseCurve` — spend to outcome response
- `monteCarlo` — Monte Carlo simulation
- `forecastExplorer` — time-series forecast
- `sqlLab` — embedded SQL exercise
- `codeLab` — read the algorithm behind a system
- `didExplorer` — difference-in-differences lift
- `yieldExplorer` — fill rate and yield
- `pixelSetup` / `pixelWalkthrough` — step-by-step conversion-pixel setup walkthrough
- `pixelCalculators` / `trackingCalculators` — capture rate, dedup inflation, and discrepancy calculators

Every type listed above renders as a live, interactive SwiftUI widget today; the
one exception is `monteCarlo`, which still renders as a labeled placeholder. The
registry that resolves a `:::widget <type>` directive to a view is
`Sources/BidLab/Widgets/WidgetRegistry.swift`. Reference whichever is most apt
for the lesson. If you add a new type, register it there and add it to the
`knownWidgets` whitelist in `Tests/BidLabCoreTests/ContentValidationTests.swift`,
or `Scripts/test.sh` will fail.

## Output

Write each assigned lesson as its own file under `Content/Lessons/`. Do not edit
any other file. Do not run builds or git. Return a short list of the files you
created.
