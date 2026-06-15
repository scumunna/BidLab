import BidLabCore
import Foundation
import SwiftUI

/// Analytics widget: drag the baseline rate, the minimum detectable effect, and
/// the sample size, and watch statistical power respond. The required sample for
/// 80% power is shown, with both your sample and the required sample marked on
/// the power curve.
struct PowerExplorer: View {
    let params: [String: String]
    @Local private var baseline: Double = 0.10
    @Local private var mde: Double = 0.02
    @Local private var nPerArm: Double = 3000

    private let maxN = 20_000.0

    private var power: Double { Analytics.power(baselineRate: baseline, mde: mde, nPerArm: Int(nPerArm)) }
    private var requiredN: Int { Analytics.sampleSizePerArm(baselineRate: baseline, mde: mde, power: 0.80) }

    private var curve: [CGPoint] {
        (1...100).map { i in
            let n = maxN * Double(i) / 100
            return CGPoint(x: n, y: Analytics.power(baselineRate: baseline, mde: mde, nPerArm: Int(n)))
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: "function").font(.system(size: 13, weight: .bold)).foregroundStyle(Brand.analytics)
                Text("Experiment power").font(.brandRounded(13, .semibold)).foregroundStyle(Brand.ink)
                Spacer()
                Text("two-proportion test").font(.brandMono(11, .regular)).foregroundStyle(Brand.muted)
            }

            HStack(alignment: .top, spacing: 18) {
                VStack(alignment: .leading, spacing: 10) {
                    sliderRow("Baseline", String(format: "%.0f%%", baseline * 100), $baseline, 0.01...0.50)
                    sliderRow("MDE", String(format: "%.1f pts", mde * 100), $mde, 0.005...0.10)
                    sliderRow("n / arm", Int(nPerArm).formatted(), $nPerArm, 100...maxN)
                    Divider().overlay(Brand.hairline).padding(.vertical, 2)
                    stat("Power", String(format: "%.0f%%", power * 100), power >= 0.8 ? Brand.up : Brand.planning)
                    stat("Need for 80%", requiredN.formatted() + " / arm", Brand.analytics)
                }
                .frame(width: 170)

                CurveChart(
                    series: [ChartSeries(color: Brand.analytics, points: curve)],
                    xDomain: 0...maxN,
                    yDomain: 0...1,
                    markers: [
                        .vertical(x: nPerArm, color: Brand.analytics.opacity(0.8)),
                        .point(x: Double(min(requiredN, Int(maxN))), y: 0.8, color: Brand.up),
                    ],
                    gridColor: Brand.ink.opacity(0.06)
                )
                .frame(height: 160)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(16)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    private func sliderRow(_ label: String, _ value: String, _ binding: Binding<Double>, _ range: ClosedRange<Double>) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(label).font(.brandRounded(12, .regular)).foregroundStyle(Brand.muted)
                Spacer()
                Text(value).font(.brandMono(12, .bold)).foregroundStyle(Brand.ink)
            }
            Slider(value: binding, in: range).tint(Brand.analytics)
        }
    }

    private func stat(_ label: String, _ value: String, _ color: Color) -> some View {
        HStack {
            Text(label).font(.brandRounded(12, .regular)).foregroundStyle(Brand.muted)
            Spacer()
            Text(value).font(.brandMono(13, .bold)).foregroundStyle(color)
        }
    }
}
