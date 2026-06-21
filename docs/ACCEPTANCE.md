# BidLab — Acceptance Evidence

A reproducible, deterministic acceptance pass over every major capability of the BidLab engine and product. Every number below is produced by a committed test you can re-run in one command.

## Quality bar & method

- **Method:** automated pass/fail. Each scenario is a single assertion of one of three kinds:
  - **Golden** — pinned to the native Swift engine's known-answer output (proves the web TypeScript engine is bit-faithful to the macOS app).
  - **Invariant** — a property that must always hold (bounds, monotonicity, sums-to-one, symmetry, accounting identities).
  - **Edge** — robustness at the boundaries (zero / empty / clamping / divide-by-zero / saturation / over-count).
- **Conditions:** identical for every run — same production build, seeded (deterministic), executed by `vitest` in Node and by the native known-answer harness.
- **Bar:** 100% pass. Any miss → fix the underlying cause → rerun the affected scenarios → rerun the complete set → repeat until green.

## Result

| Layer | What it proves | Scenarios | Result |
|---|---|---|---|
| **Engine acceptance suite** (`web/src/eval/acceptance.test.ts`) | Every engine capability: golden + invariant + edge | **100** | ✅ 100 / 100 |
| Web unit suite (`web/src/engine/*.test.ts`) | Golden parity vs the compiled Swift engine | 47 | ✅ 47 / 47 |
| Live UI run (Playwright, headless) | Entry, routing, the hero in 3 modes, onboarding, all explorables, the pixel widget, responsiveness @375px | 20 | ✅ 20 / 20 |
| Native known-answer suite (`./Scripts/test.sh`) | Swift engine + all lessons/exams/widgets | 5,127 | ✅ 5,127 / 5,127 |

**The complete set passed on the first run and again on rerun (stable).** No failures occurred, so the fix-and-rerun loop completed with no changes required — the product already cleared the bar.

## The 100 acceptance scenarios, by capability

Each row is a numbered, named `it(...)` in `web/src/eval/acceptance.test.ts`; that file is the line-by-line evidence.

| # | Capability (product surface) | Scenarios | Examples |
|---|---|---|---|
| A | Seeded RNG & determinism (every simulation) | S001–S003 | RNG stream matches native; same seed → identical sequence; draws in [0,1) |
| B | Auction mechanics (Trading Floor) | S004–S010 | first vs second-price pricing; optimal bid maximizes the profit curve; bid shading |
| C | Market simulation (Trading Floor) | S011–S022 | win-prob bounds & monotonicity; floor reserve; 50k run = native exactly; accounting identity; budget binding |
| D | Scoring (Trading Floor) | S023–S027 | optimal→100, break-even→0, loss→0; percentile rank |
| E | Pricing CPM/CPC/CPA/ROAS (Pricing) | S028–S037 | derivations; inverse round-trips; divide-by-zero → ∞; LTV:CAC |
| F | Reach & frequency (Reach & Frequency) | S038–S045 | reach ≤ population & monotonic; effective-reach nesting; native golden |
| G | Probability (Distribution, A/B Power) | S046–S053 | normal CDF symmetry; inverse-CDF round-trip; Poisson sums to 1; log-gamma |
| H | Experiment design (A/B Power) | S054–S061 | smaller MDE → bigger n; power↑ with n; native golden sample size; OLS exact; adstock; Hill |
| I | DSP systems & latency (Latency) | S062–S069 | p99 > p50; timeout-loss law; M/M/1 saturation → ∞; native golden quantiles |
| J | Budget allocation (Budget Allocator) | S070–S076 | sums to budget; equimarginal beats even split; diminishing marginal; native golden |
| K | Attribution (Attribution) | S077–S083 | last/first/linear/position credit vectors all sum to 1; U-shape |
| L | Yield & floors (Yield) | S084–S089 | fill-rate law; revenue peaks at floor = mean demand; native golden |
| M | Conversion tracking / pixels (Pixel Setup) | S090–S097 | capture rate; dedup inflation; reference-based discrepancy; over-count negative; normal-drift band |
| N | Pacing & paced flight (Trading Floor paced) | S098–S100 | on-pace target clamping; throttle direction; 12-interval flight = native + budget-bounded |

## Reproduce

```sh
# Engine acceptance + web unit (100 + 47), deterministic:
cd web && npm test            # -> 147 passed

# Native engine + all curriculum (lessons, exams, widgets):
./Scripts/test.sh             # -> all 5,127 checks passed
```

The web demo's numbers are not illustrative — they are the *same* engine, asserted equal to the native macOS app. That parity is the whole point: what a CEO clicks in the browser is the production math.
