import BidLabCore
import SwiftUI

/// A reference card of current, cited programmatic benchmarks. Each figure shows
/// its source on hover, and the strongest figures are visually distinguished
/// from soft, directional ranges. Grounding numbers in named sources is what
/// makes the math feel real rather than invented.
struct BenchmarksReference: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.seal.fill").font(.system(size: 14, weight: .bold)).foregroundStyle(Brand.up)
                    Text("Live benchmarks").font(.brandRounded(14, .semibold)).foregroundStyle(Brand.ink)
                }
                Text("Real, current figures behind the simulators. Hover any row for its source.")
                    .font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted)
                    .fixedSize(horizontal: false, vertical: true)
            }
            ForEach(Benchmarks.categories, id: \.self) { category in
                VStack(alignment: .leading, spacing: 8) {
                    Text(category.uppercased())
                        .font(.brandMono(10.5, .semibold)).foregroundStyle(Brand.faint).tracking(0.6)
                    ForEach(Benchmarks.inCategory(category)) { benchmark in
                        row(benchmark)
                    }
                }
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    private func row(_ benchmark: Benchmark) -> some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 7) {
                    Text(benchmark.label).font(.brandRounded(13.5, .semibold)).foregroundStyle(Brand.ink)
                    if !benchmark.citation.verified {
                        Text("directional").font(.brandMono(9, .semibold)).foregroundStyle(Brand.planning)
                            .padding(.horizontal, 5).padding(.vertical, 1)
                            .background(Brand.planning.opacity(0.12), in: Capsule())
                    }
                }
                Text(benchmark.detail).font(.brandRounded(12, .regular)).foregroundStyle(Brand.muted)
                    .fixedSize(horizontal: false, vertical: true)
                sourceLine(benchmark.citation)
            }
            Spacer(minLength: 8)
            Text(benchmark.value).font(.brandMono(15, .bold))
                .foregroundStyle(benchmark.citation.verified ? Brand.up : Brand.muted)
        }
        .padding(.vertical, 8)
        .overlay(alignment: .bottom) { Rectangle().fill(Brand.hairline).frame(height: 1) }
        .help(tooltip(benchmark.citation))
    }

    @ViewBuilder
    private func sourceLine(_ citation: Citation) -> some View {
        if let url = URL(string: citation.url), !citation.url.isEmpty {
            Link(destination: url) {
                HStack(spacing: 4) {
                    Image(systemName: "link").font(.system(size: 9))
                    Text("\(citation.source), \(String(citation.year))").font(.brandRounded(11, .medium))
                }
                .foregroundStyle(Brand.violet)
            }
        } else {
            Text("\(citation.source), \(String(citation.year))")
                .font(.brandRounded(11, .medium)).foregroundStyle(Brand.faint)
        }
    }

    private func tooltip(_ citation: Citation) -> String {
        var text = "Source: \(citation.source) (\(citation.year))"
        if !citation.verified { text += " (directional)" }
        if let note = citation.note { text += ". \(note)" }
        return text
    }
}
