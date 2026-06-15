import BidLabCore
import Foundation
import SwiftUI

/// Planning widget: drag total impressions and watch unique reach, average
/// frequency, and effective reach at 2+/3+ respond along the bending reach curve.
struct ReachFrequencyPlayground: View {
    let params: [String: String]
    @Local private var impressions: Double = 1_000_000

    private var population: Double { Double(params["population"] ?? "") ?? 1_000_000 }
    private var maxImpressions: Double { population * 3 }

    private var reachPct: Double { ReachFrequency.reachFraction(population: population, impressions: impressions) }
    private var avgFreq: Double { ReachFrequency.averageFrequency(population: population, impressions: impressions) }
    private var reach: Double { ReachFrequency.reach(population: population, impressions: impressions) }
    private var er2: Double { ReachFrequency.effectiveReach(population: population, impressions: impressions, minFrequency: 2) }

    private var curve: [CGPoint] {
        (0...100).map { i in
            let imp = maxImpressions * Double(i) / 100
            return CGPoint(x: imp, y: ReachFrequency.reachFraction(population: population, impressions: imp))
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: "target").font(.system(size: 13, weight: .bold)).foregroundStyle(Brand.planning)
                Text("Reach and frequency").font(.brandRounded(13, .semibold)).foregroundStyle(Brand.ink)
                Spacer()
                Text("\(millions(population)) people").font(.brandMono(11, .regular)).foregroundStyle(Brand.muted)
            }

            HStack(alignment: .top, spacing: 18) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Impressions").font(.brandRounded(12.5, .medium)).foregroundStyle(Brand.muted)
                        Spacer()
                        Text(millions(impressions)).font(.brandMono(15, .bold)).foregroundStyle(Brand.planning)
                    }
                    Slider(value: $impressions, in: 0...maxImpressions).tint(Brand.planning)
                    stat("Reach", String(format: "%.1f%%", reachPct * 100), Brand.planning)
                    stat("Avg frequency", String(format: "%.2f", avgFreq), Brand.ink)
                    stat("Reached 2+", String(format: "%.1f%%", (population > 0 ? er2 / population : 0) * 100), Brand.analytics)
                }
                .frame(width: 160)

                CurveChart(
                    series: [ChartSeries(color: Brand.planning, points: curve)],
                    xDomain: 0...maxImpressions,
                    yDomain: 0...1,
                    markers: [.vertical(x: impressions, color: Brand.planning.opacity(0.8))],
                    gridColor: Brand.ink.opacity(0.06)
                )
                .frame(height: 150)
                .frame(maxWidth: .infinity)
            }

            Rectangle().fill(Brand.hairline).frame(height: 1)
            peopleGrid
        }
        .padding(16)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    private var peopleGrid: some View {
        let total = 100
        let reachedCount = min(total, Int((reachPct * Double(total)).rounded()))
        let reached2 = min(reachedCount, Int(((population > 0 ? er2 / population : 0) * Double(total)).rounded()))
        return VStack(alignment: .leading, spacing: 8) {
            Text("100 people in the audience").font(.brandMono(10, .regular)).foregroundStyle(Brand.muted)
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(10), spacing: 5), count: 20), spacing: 5) {
                ForEach(0..<total, id: \.self) { i in
                    Circle()
                        .fill(i < reached2 ? Brand.planning : (i < reachedCount ? Brand.planning.opacity(0.4) : Brand.ink.opacity(0.10)))
                        .frame(width: 10, height: 10)
                }
            }
            .animation(.easeOut(duration: 0.25), value: reachedCount)
            .animation(.easeOut(duration: 0.25), value: reached2)
            HStack(spacing: 16) {
                legend(Brand.planning.opacity(0.4), "reached once")
                legend(Brand.planning, "reached 2+")
                legend(Brand.ink.opacity(0.10), "not reached")
            }
        }
    }

    private func legend(_ color: Color, _ label: String) -> some View {
        HStack(spacing: 5) {
            Circle().fill(color).frame(width: 9, height: 9)
            Text(label).font(.brandMono(10, .regular)).foregroundStyle(Brand.muted)
        }
    }

    private func stat(_ label: String, _ value: String, _ color: Color) -> some View {
        HStack {
            Text(label).font(.brandRounded(12, .regular)).foregroundStyle(Brand.muted)
            Spacer()
            Text(value).font(.brandMono(13, .bold)).foregroundStyle(color)
        }
    }

    private func millions(_ x: Double) -> String { String(format: "%.2fM", x / 1_000_000) }
}
