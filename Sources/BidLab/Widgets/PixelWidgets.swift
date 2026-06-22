import BidLabCore
import Foundation
import SwiftUI

/// The conversion-pixel playbook as an interactive stepper: pick a step, read the
/// concrete action and code, and check off the tasks. The native companion to the
/// adops-13 / adops-14 lessons (and the web Pixel Setup walkthrough).
struct PixelSetupExplorer: View {
    let params: [String: String]

    private struct PixelStep {
        let key: String
        let title: String
        let blurb: String
        let code: String?
        let checklist: [String]
    }

    private let steps: [PixelStep] = [
        PixelStep(
            key: "Create",
            title: "Create the pixel and choose what it counts",
            blurb: "A lead is usually a Counter (unique per user); a purchase is a Sales activity carrying the order value and a unique order id.",
            code: "<img src=\"https://ad.doubleclick.net/ddm/activity/src=1234567;type=purch;cost=49.90;ord=ORDER-10231?\" width=\"1\" height=\"1\">",
            checklist: ["Counter vs Sales (unique vs every)", "Sales carries value + a unique order id", "ord = order id (the dedup key), not a random number"]
        ),
        PixelStep(
            key: "Place",
            title: "Place it: global tag sitewide, event on the success page",
            blurb: "The global tag goes in the head on every page. The event fires on one page only, the confirmation page, ideally on a dataLayer event the site pushes once the order is confirmed.",
            code: "dataLayer.push({ event: 'purchase', value: 49.90, currency: 'USD', transaction_id: 'ORDER-10231' });",
            checklist: ["Global tag in the head on All Pages", "Event fires on the confirmation page", "Fire on the success event, not the button click"]
        ),
        PixelStep(
            key: "Windows",
            title: "Set the attribution windows",
            blurb: "Credit only counts inside the lookback window. Match the click-through window to the sales cycle (often 30 days) and keep the view-through window short (often 1 day).",
            code: nil,
            checklist: ["Click-through window matches the sales cycle", "View-through window kept short", "Lock the window before comparing CPA / ROAS"]
        ),
        PixelStep(
            key: "QA",
            title: "QA: fire a test and prove it fires",
            blurb: "Never release budget on an unproven pixel. Fire a real test conversion end to end and verify every link before spend goes live.",
            code: nil,
            checklist: ["Fire a real test conversion end to end", "value + order id populated, not 0 or undefined", "Fires once (the dedup key holds)", "Consent Mode v2: fires after accept, suppressed before it (EEA)", "Appears in reporting with the right value"]
        ),
        PixelStep(
            key: "Server-side",
            title: "Recover what the browser drops (CAPI)",
            blurb: "Blockers, cookie caps, and bounces drop a meaningful share of client conversions. Send the event from your server too, with the same event id, so the platform deduplicates instead of double-counting.",
            code: "POST /<DATASET_ID>/events { event_name:'Purchase', event_id:'ORDER-10231', user_data:{ em:sha256(email) }, custom_data:{ value:49.90 } }",
            checklist: ["Server posts first-party (CAPI / sGTM)", "Same event_id as the browser pixel", "EMQ at 7 or higher on the key event", "Hash user_data (SHA-256 email / phone)"]
        ),
        PixelStep(
            key: "Strengthen",
            title: "Strengthen the match: click ids + Enhanced Conversions",
            blurb: "Capture the click id (gclid / fbclid) on landing and store it first-party, and send hashed first-party data. Normalize before hashing or the match silently collapses.",
            code: "const gclid = new URL(location.href).searchParams.get('gclid'); // store first-party, send with the conversion",
            checklist: ["Capture gclid / fbclid into a first-party cookie", "Send hashed email / phone (Enhanced Conversions)", "Normalize before hashing: lowercase + trim, E.164", "Import offline sales by click id within its window"]
        ),
        PixelStep(
            key: "Troubleshoot",
            title: "Troubleshoot the silent failures",
            blurb: "The page looks fine and spend continues; only the numbers are wrong. When the pixel disagrees with the back-end by more than about 10%, suspect the implementation before the media.",
            code: nil,
            checklist: ["Not firing: wrong page / JS error / Consent Mode v2 denied", "SPA: bind to the route change, not page load", "Double-count: tag off the confirmation page / no dedup key", "Zero value: dataLayer not populated when the tag read it"]
        ),
    ]

    @Local private var selected = 0
    @Local private var checked: Set<String> = []

    private var step: PixelStep { steps[selected] }

    var body: some View {
        WidgetShell("Pixel setup", icon: "checklist", accent: Brand.lime, note: "the trader's playbook") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(steps.indices, id: \.self) { i in
                        Button { selected = i } label: {
                            Text("\(i + 1). \(steps[i].key)")
                                .font(.brandMono(11, .semibold))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(i == selected ? Brand.lime : Brand.ink.opacity(0.06), in: Capsule())
                                .foregroundStyle(i == selected ? Brand.console : Brand.muted)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            stepDetail
        }
    }

    private var stepDetail: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(step.title).font(.brandRounded(13.5, .bold)).foregroundStyle(Brand.ink)
            Text(step.blurb).font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted)
                .fixedSize(horizontal: false, vertical: true)
            if let code = step.code {
                Text(code)
                    .font(.brandMono(11, .regular))
                    .foregroundStyle(Color.white.opacity(0.85))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Brand.console, in: RoundedRectangle(cornerRadius: Metric.radiusSm, style: .continuous))
            }
            VStack(alignment: .leading, spacing: 6) {
                ForEach(step.checklist.indices, id: \.self) { j in
                    checklistRow(j)
                }
            }
        }
    }

    private func checklistRow(_ j: Int) -> some View {
        let keyStr = "\(step.key):\(j)"
        let on = checked.contains(keyStr)
        return Button {
            if on { checked.remove(keyStr) } else { checked.insert(keyStr) }
        } label: {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: on ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 13))
                    .foregroundStyle(on ? Brand.lime : Brand.faint)
                Text(step.checklist[j])
                    .font(.brandRounded(12, .regular))
                    .foregroundStyle(on ? Brand.faint : Brand.ink)
                    .strikethrough(on)
                Spacer(minLength: 0)
            }
        }
        .buttonStyle(.plain)
    }
}

/// The three numbers a trader checks on a pixel: how much the client pixel
/// captured, how much mismatched ids inflate the dedup, and whether a counting
/// gap is normal drift. Math-true, from BidLabCore.Tracking.
struct PixelMatchCalculators: View {
    let params: [String: String]

    @Local private var client = 920.0
    @Local private var backend = 1000.0
    @Local private var trueN = 1000.0
    @Local private var unmatched = 0.2
    @Local private var reference = 1_050_000.0
    @Local private var observed = 1_000_000.0

    private var capture: Double { Tracking.captureRate(client: client, backend: backend) }
    private var leak: Double { Tracking.leakage(client: client, backend: backend) }
    private var reported: Double { Tracking.dedupedTotal(trueCount: trueN, unmatchedShare: unmatched) }
    private var inflation: Double { Tracking.dedupInflation(unmatchedShare: unmatched) }
    private var disc: Double { Tracking.discrepancy(reference: reference, observed: observed) }
    private var discOK: Bool { Tracking.withinNormalBand(disc) }

    var body: some View {
        WidgetShell("Pixel match and discrepancy", icon: "percent", accent: Brand.lime, note: "the numbers a trader checks") {
            captureSection
            Divider().overlay(Brand.hairline)
            dedupSection
            Divider().overlay(Brand.hairline)
            discrepancySection
        }
    }

    private func header(_ text: String) -> some View {
        Text(text).font(.brandMono(10, .semibold)).foregroundStyle(Brand.muted)
    }

    private var captureSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            header("CAPTURE RATE")
            LabeledSlider(label: "Pixel conversions", binding: $client, range: 0...2000, accent: Brand.lime, kind: .number(0))
            LabeledSlider(label: "Back-end (true) conversions", binding: $backend, range: 1...2000, accent: Brand.lime, kind: .number(0))
            StatLine(label: "Capture rate", value: Fmt.pct(capture, 1), color: capture >= 0.9 ? Brand.up : Brand.planning)
            StatLine(label: "Leaked to blockers / bounce", value: Fmt.pct(leak, 1), color: Brand.down)
        }
    }

    private var dedupSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            header("DEDUP INFLATION")
            LabeledSlider(label: "True conversions", binding: $trueN, range: 0...5000, accent: Brand.analytics, kind: .number(0))
            LabeledSlider(label: "Event ids unmatched", binding: $unmatched, range: 0...0.5, accent: Brand.analytics, kind: .pct(0))
            StatLine(label: "Reported after dedup", value: Fmt.num(reported, 0), color: unmatched > 0 ? Brand.down : Brand.up)
            StatLine(label: "Inflation over true", value: Fmt.pct(inflation, 0), color: unmatched > 0 ? Brand.down : Brand.up)
        }
    }

    private var discrepancySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            header("DISCREPANCY QA")
            LabeledSlider(label: "Reference (publisher / back-end)", binding: $reference, range: 0...2_000_000, accent: Brand.sales, kind: .number(0))
            LabeledSlider(label: "Observed (your pixel)", binding: $observed, range: 0...2_000_000, accent: Brand.sales, kind: .number(0))
            StatLine(label: "Discrepancy vs reference", value: Fmt.pct(disc, 2), color: discOK ? Brand.up : Brand.down)
            StatLine(label: "Verdict", value: discOK ? "within ~10% band" : "investigate", color: discOK ? Brand.up : Brand.down)
        }
    }
}
