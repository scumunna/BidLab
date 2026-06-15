import SwiftUI

/// One labeled parameter row in the transparency panel.
struct TransparencyRow: Identifiable {
    let label: String
    let value: String
    var id: String { label }
}

/// The "open the hood" panel: an expandable disclosure that shows the exact
/// formula, the assumptions, and the live parameter values behind a simulator.
/// No black boxes. This is the credibility move that lets analysts and engineers
/// trust the math. Works on both the dark console and light reading surfaces.
struct TransparencyPanel: View {
    let formula: String
    let assumptions: [String]
    let parameters: [TransparencyRow]
    var tint: Color = Brand.analytics
    var onDark: Bool = false
    @Local private var open = false

    private var textPrimary: Color { onDark ? Color.white.opacity(0.85) : Brand.ink }
    private var textMuted: Color { onDark ? Color.white.opacity(0.5) : Brand.muted }
    private var surface: Color { onDark ? Color.white.opacity(0.04) : Brand.ink.opacity(0.03) }
    private var border: Color { onDark ? Color.white.opacity(0.08) : Brand.hairline }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button { open.toggle() } label: {
                HStack(spacing: 8) {
                    Image(systemName: "eye").font(.system(size: 12, weight: .bold)).foregroundStyle(tint)
                    Text("Open the hood").font(.brandMono(12, .semibold)).foregroundStyle(textPrimary)
                    Spacer()
                    Image(systemName: open ? "chevron.up" : "chevron.down").font(.system(size: 11, weight: .bold)).foregroundStyle(textMuted)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 11)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            if open {
                VStack(alignment: .leading, spacing: 14) {
                    MathView(latex: formula, color: textPrimary, size: 16)

                    if !assumptions.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("ASSUMPTIONS").font(.brandMono(10, .semibold)).foregroundStyle(textMuted)
                            ForEach(assumptions, id: \.self) { item in
                                HStack(alignment: .top, spacing: 7) {
                                    Text("•").foregroundStyle(tint)
                                    Text(item).font(.brandRounded(12.5, .regular)).foregroundStyle(textMuted)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    }

                    if !parameters.isEmpty {
                        VStack(spacing: 5) {
                            ForEach(parameters) { row in
                                HStack {
                                    Text(row.label).font(.brandMono(11.5, .regular)).foregroundStyle(textMuted)
                                    Spacer()
                                    Text(row.value).font(.brandMono(12, .bold)).foregroundStyle(textPrimary)
                                }
                            }
                        }
                    }
                }
                .padding(14)
                .padding(.top, 0)
            }
        }
        .background(surface, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous).strokeBorder(border, lineWidth: 1))
    }
}
