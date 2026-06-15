import BidLabCore
import Foundation
import SwiftUI

/// Allocate a budget across channels under diminishing returns (equimarginal).
struct BudgetAllocatorWidget: View {
    let params: [String: String]
    @Local private var budget = 100_000.0

    private let channels: [(name: String, curve: ResponseCurve)] = [
        ("Search", ResponseCurve(saturation: 1000, scale: 30_000)),
        ("Social", ResponseCurve(saturation: 700, scale: 20_000)),
        ("CTV", ResponseCurve(saturation: 1400, scale: 60_000)),
    ]

    private var curves: [ResponseCurve] { channels.map(\.curve) }
    private var allocation: [Double] { BudgetAllocation.allocate(budget: budget, channels: curves) }
    private var total: Double { BudgetAllocation.totalResponse(allocation: allocation, channels: curves) }
    private var even: Double {
        BudgetAllocation.totalResponse(allocation: Array(repeating: budget / 3, count: 3), channels: curves)
    }

    var body: some View {
        WidgetShell("Budget allocator", icon: "slider.horizontal.below.square.filled.and.square", accent: Brand.planning, note: "equimarginal") {
            LabeledSlider(label: "Total budget", value: Fmt.money(budget, 0), binding: $budget, range: 10_000...500_000, accent: Brand.planning, kind: .money(0))
            ForEach(channels.indices, id: \.self) { i in
                bar(channels[i].name, allocation[i])
            }
            Divider().overlay(Brand.hairline)
            StatLine(label: "Total outcome (optimal)", value: Fmt.num(total, 0), color: Brand.up)
            StatLine(label: "vs even split", value: Fmt.num(even, 0), color: Brand.muted)
        }
    }

    private func bar(_ name: String, _ value: Double) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(name).font(.brandRounded(12, .regular)).foregroundStyle(Brand.ink)
                Spacer()
                Text(Fmt.money(value, 0)).font(.brandMono(12, .bold)).foregroundStyle(Brand.planning)
            }
            GeometryReader { geo in
                Capsule().fill(Brand.planning.opacity(0.18)).overlay(alignment: .leading) {
                    Capsule().fill(Brand.planning)
                        .frame(width: max(4, geo.size.width * CGFloat(value / max(budget, 1))))
                        .animation(.easeOut(duration: 0.25), value: value)
                }
            }
            .frame(height: 9)
        }
    }
}

/// Spend to outcome along a diminishing-returns response curve.
struct ResponseCurveWidget: View {
    let params: [String: String]
    @Local private var spend = 30_000.0
    private let curve = ResponseCurve(saturation: 1000, scale: 40_000)
    private let maxSpend = 120_000.0

    private var points: [CGPoint] {
        (0...100).map { i in
            let s = maxSpend * Double(i) / 100
            return CGPoint(x: s, y: curve.response(s))
        }
    }

    var body: some View {
        WidgetShell("Response curve", icon: "chart.xyaxis.line", accent: Brand.planning, note: "diminishing returns") {
            LabeledSlider(label: "Spend", value: Fmt.money(spend, 0), binding: $spend, range: 0...maxSpend, accent: Brand.planning, kind: .money(0))
            CurveChart(
                series: [ChartSeries(color: Brand.planning, points: points)],
                xDomain: 0...maxSpend,
                yDomain: 0...curve.saturation,
                markers: [
                    .vertical(x: spend, color: Brand.planning.opacity(0.8)),
                    .point(x: spend, y: curve.response(spend), color: Brand.up),
                ],
                gridColor: Brand.ink.opacity(0.06)
            )
            .frame(height: 150)
            StatLine(label: "Outcome", value: Fmt.num(curve.response(spend), 0), color: Brand.planning)
            StatLine(label: "Marginal per $1k", value: Fmt.num(curve.marginal(spend) * 1000, 2), color: Brand.up)
        }
    }
}

/// Advertising adstock: a spend pulse decays into later weeks.
struct AdstockExplorer: View {
    let params: [String: String]
    @Local private var decay = 0.5
    private let pulse: [Double] = [0, 0, 100, 0, 0, 0, 0, 0, 0, 0]

    private var stocked: [Double] { Analytics.adstock(pulse, decay: decay) }

    var body: some View {
        WidgetShell("Adstock explorer", icon: "waveform", accent: Brand.analytics, note: "carryover") {
            LabeledSlider(label: "Decay", value: Fmt.pct(decay), binding: $decay, range: 0...0.9, accent: Brand.analytics, kind: .pct(1))
            GeometryReader { geo in
                HStack(alignment: .bottom, spacing: 4) {
                    ForEach(stocked.indices, id: \.self) { i in
                        Capsule()
                            .fill(i == 2 ? Brand.analytics : Brand.analytics.opacity(0.45))
                            .frame(height: max(2, geo.size.height * CGFloat(stocked[i] / 100)))
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .frame(height: 90)
            StatLine(label: "Peak", value: "week 3", color: Brand.analytics)
            StatLine(label: "Still active in week 6", value: Fmt.num(stocked[5], 1) + " %", color: Brand.muted)
        }
    }
}
