# BidLab — Native Code Coverage

Line-, function-, and region-level code coverage for **`BidLabCore`**, the pure
Swift engine behind the app. Every number below is produced by a committed script
you can re-run in one command.

## Method

SwiftPM is broken on the build machine (see `Scripts/lib.sh`), so
`swift test --enable-code-coverage` does not run. Instead, `Scripts/coverage.sh`
instruments the *same* `swiftc` build the test runner already uses
(`-profile-generate -profile-coverage-mapping`), runs the full known-answer
suite, and emits an `llvm-cov` report scoped to `Sources/BidLabCore`. The archive
is force-loaded so every object's coverage map is included, even files no test
references directly.

```sh
./Scripts/coverage.sh                 # build, run, print the per-file report
./Scripts/coverage.sh show Exam.swift # annotate uncovered lines in one file
```

## Result

The suite is **5,271 known-answer checks**. Every `BidLabCore` source file is at
**100%** line, function, and region coverage, except for a small, documented set
of **unreachable defensive branches** (see below).

| Metric | Coverage | Reachable |
|---|---|---|
| Lines | 1628 / 1630 (99.88%) | **100%** |
| Functions | 284 / 286 (99.30%) | **100%** |
| Regions | 802 / 806 (99.50%) | **100%** |

25 of 27 source files are at a clean 100% on all three metrics.

## The 4 intentionally-uncovered regions

These are defensive guards and `nil`-coalescing fallbacks that cannot execute
given the code that precedes them. They are kept (defensive code is good
practice) and documented here rather than removed, force-unwrapped, or papered
over with a contrived test.

| File | Branch | Why it is unreachable |
|---|---|---|
| `Analytics.swift` | `guard se > 0 else { return 0 }` in `power(...)` | The earlier `guard baselineRate > 0, baselineRate < 1` makes `p(1-p) > 0`, so the pooled `se` is always `> 0`. |
| `CampaignData.swift` | `guard let names = aliases[field]` in `columnIndex(...)` | The nested helper is only ever called with the six field names that are all keys in `aliases`. |
| `Credential.swift` | `components.url?.absoluteString ?? <fallback>` | `URLComponents` built from a valid base and query items always yields a non-`nil` `url`. |
| `Credential.swift` | `s.addingPercentEncoding(...) ?? s` | `.urlQueryAllowed` percent-encoding returns `nil` only for malformed Unicode (lone surrogates), which the inputs never contain. |

## Scope

- **`BidLabCore`** (the pure engine) is the unit-coverable layer and is covered to
  100% of reachable code, as above.
- **The SwiftUI app layer** (`Sources/BidLab`) is not unit-coverable with the
  `swiftc`/broken-SwiftPM toolchain (no XCTest UI runner); it is exercised by
  building and running the app. The engine is where the logic, and the coverage
  bar, live.
- **The web engine** (`web/src/engine`) is a faithful TypeScript port with its own
  `vitest` suite and the 100-scenario acceptance pass; see
  [ACCEPTANCE.md](ACCEPTANCE.md).
