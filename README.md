# BidLab

The flight simulator for programmatic advertising. A native macOS app that
teaches the math of programmatic by doing it: nine learning paths (Foundations
and Programmatic Core, plus Ad Operations, DSP/Trader, Sales, Planning,
Analytics, Engineering, and AI in AdTech), 124 interactive lessons, 9 role
certification exams, a math-true bidding simulator, and a shareable credential.

Every concept is interactive and every number is real. Train the bid, the plan,
the deal, the experiment, and the bidder itself, without spending a dollar of
media.

## What is in here

- **`BidLabCore`** (built as a SwiftPM-style library): a pure, UI-free Swift
  engine validated by a known-answer test suite (2,500+ checks) covering pricing,
  auctions, probability, statistics, reach and frequency, budget allocation,
  pacing, a seeded market simulation, scoring, analytics (power, difference-in-
  differences, adstock, saturation, OLS), DSP systems (latency, queueing), and
  the lesson parser.
- **The app** (`Sources/BidLab`): a SwiftUI shell with nine surfaces (Learn,
  Review, Industries, Trading Floor, Tools, Exams, Progress, Explorable, and
  Settings), an original design system, interactive widgets, a native math
  renderer, the "open the hood" transparency panel, an embedded SQLite SQL lab,
  branded PNG/CSV/JSON export, and progress with a shareable certificate.
- **Content** (`Content/Lessons/*.md`): 124 authored, cited lessons in an original
  Markdown-flavored format, parsed at launch from the app bundle. See
  `Content/CONTENT_GUIDE.md` for the format.

## Building and running

Requires macOS 14 or later and the Swift toolchain (Command Line Tools for
Xcode). This project builds entirely with `swiftc` (no full Xcode required),
because the Command Line Tools on the original machine shipped a broken SwiftPM.

```sh
./Scripts/test.sh      # build the core and run the test suite (2,500+ checks)
./Scripts/build.sh     # build the app -> build/BidLab.app
open build/BidLab.app  # run it
```

To produce a distributable disk image:

```sh
hdiutil create -volname BidLab -srcfolder build/BidLab.app -ov -format UDZO build/BidLab.dmg
```

### Toolchain notes

- Lessons are data, not code: edit any `Content/Lessons/{track}-{NN}.md` and
  rebuild. `Scripts/test.sh` validates every lesson file.
- `@State` is replaced by a one-line `@Local` `DynamicProperty` shim because the
  `SwiftUIMacros` plugin is absent from the Command Line Tools. Swap back to
  `@State` once a full Xcode toolchain is available.
- The app is ad-hoc signed. Code signing and notarization for public
  distribution require an Apple Developer ID.

## Status

BidLab 1.0. All nine paths are complete (124 lessons), every widget is
interactive, and the product has been verified running in the live environment.

## License

BidLab is released under the MIT License. See [LICENSE](LICENSE).

The bundled Inter typeface is licensed separately under the SIL Open Font
License; see `Resources/Fonts/Inter-LICENSE.txt`.
