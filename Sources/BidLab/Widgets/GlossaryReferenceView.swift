import BidLabCore
import SwiftUI

/// A fast, searchable reference of programmatic terms, definitions, and formulas
/// for the question you have mid-task. Backed by the Glossary engine and its
/// ranked, case-insensitive search.
struct GlossaryReferenceView: View {
    @Local private var query = ""
    @FocusState private var focused: Bool

    var body: some View {
        WidgetShell("Glossary", icon: "magnifyingglass", accent: Brand.analytics, note: "\(Glossary.all.count) terms") {
            VStack(alignment: .leading, spacing: 12) {
                searchField
                let results = Glossary.search(query)
                if results.isEmpty {
                    Text("No terms match \"\(query)\".")
                        .font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted)
                        .padding(.vertical, 8)
                } else {
                    VStack(spacing: 8) {
                        ForEach(Array(results.enumerated()), id: \.offset) { _, term in row(term) }
                    }
                }
            }
        }
    }

    private var searchField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass").font(.system(size: 12)).foregroundStyle(Brand.faint)
            TextField("Search terms, metrics, or formulas", text: $query)
                .textFieldStyle(.plain)
                .font(.brandRounded(13.5, .regular)).foregroundStyle(Brand.ink)
                .focused($focused)
            if !query.isEmpty {
                Button { query = "" } label: {
                    Image(systemName: "xmark.circle.fill").font(.system(size: 13)).foregroundStyle(Brand.faint)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12).padding(.vertical, 9)
        .background(Brand.canvas, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
        .onAppear { focused = true }
    }

    private func row(_ term: GlossaryTerm) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Text(term.term).font(.brandRounded(14, .bold)).foregroundStyle(Brand.ink)
                Pill(text: term.category, color: Brand.analytics)
                Spacer()
                Text(term.name).font(.brandMono(11, .regular)).foregroundStyle(Brand.faint).lineLimit(1)
            }
            Text(term.definition)
                .font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted)
                .fixedSize(horizontal: false, vertical: true)
            if let formula = term.formula {
                Text(formula).font(.brandMono(12, .medium)).foregroundStyle(Brand.analytics)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.canvas, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
    }
}
