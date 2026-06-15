import BidLabCore
import SwiftUI

/// The industry lens. Pick your vertical and the course speaks your economics:
/// retail's incremental ROAS, telecom's churn, pharma's script lift. This is the
/// deep-dive home; the chosen industry also tunes the hero on Learn.
struct VerticalsSurface: View {
    @EnvironmentObject var app: AppState

    private let columns = [GridItem(.adaptive(minimum: 250, maximum: 360), spacing: 16)]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 26) {
                header
                if let vertical = app.selectedVertical { selectedCard(vertical) }
                grid
            }
            .padding(.horizontal, 38).padding(.top, 40).padding(.bottom, 48)
            .frame(maxWidth: 1120, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Pill(text: "Industry lens", color: Brand.dsp)
            Text("The math is the same. The economics are not.")
                .font(.brandDisplay(30, .heavy)).foregroundStyle(Brand.ink)
                .fixedSize(horizontal: false, vertical: true)
            Text("Pick your industry and every example speaks your world. Retail runs on incremental ROAS, telecom on churn, pharma on script lift. Eleven verticals, each with its own real, cited math.")
                .font(.brandRounded(15, .regular)).foregroundStyle(Brand.muted)
                .frame(maxWidth: 720, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private func selectedCard(_ vertical: Vertical) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 10) {
                Image(systemName: vertical.icon).font(.system(size: 18, weight: .bold)).foregroundStyle(Brand.dsp)
                Text("Tuned for \(vertical.name)").font(.brandRounded(16, .bold)).foregroundStyle(Brand.ink)
                Spacer()
                Button { app.selectedVerticalID = nil } label: {
                    Text("Clear lens").font(.brandRounded(13, .semibold)).foregroundStyle(Brand.muted)
                }
                .buttonStyle(.plain)
            }
            Text(vertical.blurb).font(.brandRounded(14.5, .regular)).foregroundStyle(Brand.muted)
                .fixedSize(horizontal: false, vertical: true)
            HStack(alignment: .top, spacing: 26) {
                miniStat("Signature metric", vertical.signatureKPI)
                miniStat(vertical.anchorLabel, vertical.anchorValue)
            }
            block("Formula", Text(vertical.signatureFormula).font(.brandMono(13.5, .semibold)).foregroundStyle(Brand.dsp))
            block("Try this", Text(vertical.scenario).font(.brandRounded(13.5, .regular)).foregroundStyle(Brand.ink)
                .fixedSize(horizontal: false, vertical: true))
            sourceLine(vertical.citation)
            if LessonLibrary.lesson(id: "vertical-\(vertical.id)") != nil {
                PrimaryButton("Open the \(vertical.name) deep-dive", icon: "arrow.right", color: Brand.dsp) {
                    app.openLessonID = "vertical-\(vertical.id)"
                    app.surface = .learn
                }
                .padding(.top, 4)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.dsp.opacity(0.06), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.dsp.opacity(0.25), lineWidth: 1.5))
    }

    private var grid: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: app.selectedVertical == nil ? "Choose your industry" : "Switch industry")
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Verticals.all) { vertical in card(vertical) }
            }
        }
    }

    private func card(_ vertical: Vertical) -> some View {
        let selected = app.selectedVerticalID == vertical.id
        return Button { app.selectedVerticalID = selected ? nil : vertical.id } label: {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: vertical.icon).font(.system(size: 16, weight: .bold)).foregroundStyle(Brand.dsp)
                        .frame(width: 40, height: 40)
                        .background(Brand.dsp.opacity(0.12), in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
                    Spacer()
                    if selected { Image(systemName: "checkmark.circle.fill").foregroundStyle(Brand.dsp) }
                }
                Text(vertical.name).font(.brandDisplay(18, .heavy)).foregroundStyle(Brand.ink)
                Text(vertical.blurb).font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer(minLength: 2)
                HStack {
                    Text(vertical.signatureKPI).font(.brandMono(12, .bold)).foregroundStyle(Brand.dsp)
                    Spacer()
                    Text(vertical.anchorValue).font(.brandMono(12, .semibold)).foregroundStyle(Brand.muted)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, minHeight: 184, alignment: .topLeading)
            .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous)
                .strokeBorder(selected ? Brand.dsp.opacity(0.5) : Brand.hairline, lineWidth: selected ? 1.5 : 1))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(vertical.name). Signature metric \(vertical.signatureKPI), \(vertical.anchorValue)")
        .accessibilityHint(vertical.blurb)
    }

    private func miniStat(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label).font(.brandMono(10, .semibold)).foregroundStyle(Brand.faint).tracking(0.4)
            Text(value).font(.brandRounded(15, .bold)).foregroundStyle(Brand.ink)
        }
    }

    private func block<Content: View>(_ label: String, _ content: Content) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label.uppercased()).font(.brandMono(10, .semibold)).foregroundStyle(Brand.faint).tracking(0.6)
            content
        }
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
}
