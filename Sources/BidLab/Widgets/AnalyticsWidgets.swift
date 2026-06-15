import BidLabCore
import Foundation
import SwiftUI

/// The standard normal distribution with a movable z and its tail probabilities.
struct DistributionExplorer: View {
    let params: [String: String]
    @Local private var z = 0.0

    private var points: [CGPoint] {
        stride(from: -4.0, through: 4.0, by: 0.1).map { x in CGPoint(x: x, y: Probability.normalPDF(x)) }
    }

    var body: some View {
        WidgetShell("Normal distribution", icon: "chart.bar", accent: Brand.analytics, note: "standard normal") {
            LabeledSlider(label: "z", value: Fmt.num(z, 2), binding: $z, range: -3...3, accent: Brand.analytics, kind: .number(2))
            CurveChart(
                series: [ChartSeries(color: Brand.analytics, points: points)],
                xDomain: -4...4,
                yDomain: 0...0.45,
                markers: [.vertical(x: z, color: Brand.analytics.opacity(0.8))],
                gridColor: Brand.ink.opacity(0.06)
            )
            .frame(height: 140)
            StatLine(label: "P(X <= z)", value: Fmt.pct(Probability.normalCDF(z)), color: Brand.analytics)
            StatLine(label: "Two-sided tail", value: Fmt.pct(2 * (1 - Probability.normalCDF(abs(z)))), color: Brand.muted)
        }
    }
}

/// Difference-in-differences: isolate the treatment lift from a shared trend.
struct DiDExplorer: View {
    let params: [String: String]
    @Local private var treatPost = 18.0
    @Local private var controlPost = 12.0
    private let pre = 10.0

    private var lift: Double {
        Analytics.differenceInDifferences(treatmentPre: pre, treatmentPost: treatPost, controlPre: pre, controlPost: controlPost)
    }

    var body: some View {
        WidgetShell("Difference-in-differences", icon: "arrow.triangle.branch", accent: Brand.analytics, note: "isolate the lift") {
            LabeledSlider(label: "Treatment after", value: Fmt.num(treatPost, 1), binding: $treatPost, range: 8...25, accent: Brand.analytics, kind: .number(1))
            LabeledSlider(label: "Control after", value: Fmt.num(controlPost, 1), binding: $controlPost, range: 8...25, accent: Brand.muted, kind: .number(1))
            CurveChart(
                series: [
                    ChartSeries(color: Brand.analytics, points: [CGPoint(x: 0, y: pre), CGPoint(x: 1, y: treatPost)]),
                    ChartSeries(color: Brand.muted, points: [CGPoint(x: 0, y: pre), CGPoint(x: 1, y: controlPost)]),
                ],
                xDomain: 0...1,
                yDomain: 0...26,
                gridColor: Brand.ink.opacity(0.06)
            )
            .frame(height: 120)
            StatLine(label: "Treatment change", value: "+" + Fmt.num(treatPost - pre, 1), color: Brand.analytics)
            StatLine(label: "Control change", value: "+" + Fmt.num(controlPost - pre, 1), color: Brand.muted)
            StatLine(label: "Incremental lift", value: Fmt.num(lift, 1), color: lift >= 0 ? Brand.up : Brand.down)
        }
    }
}

/// How attribution models split credit for one conversion across touchpoints.
struct AttributionComparison: View {
    let params: [String: String]
    @Local private var model = 0
    private let touches = ["Display", "Search", "Social", "Email"]

    private var credit: [Double] {
        switch model {
        case 0: return Attribution.lastTouch(4)
        case 1: return Attribution.linear(4)
        default: return Attribution.positionBased(4)
        }
    }

    var body: some View {
        WidgetShell("Attribution", icon: "arrow.triangle.merge", accent: Brand.dsp, note: "who gets credit") {
            Picker("", selection: $model) {
                Text("Last touch").tag(0)
                Text("Linear").tag(1)
                Text("Position").tag(2)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            ForEach(touches.indices, id: \.self) { i in
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text(touches[i]).font(.brandRounded(12, .regular)).foregroundStyle(Brand.ink)
                        Spacer()
                        Text(Fmt.pct(credit[i], 0)).font(.brandMono(12, .bold)).foregroundStyle(Brand.dsp)
                    }
                    GeometryReader { geo in
                        Capsule().fill(Brand.dsp.opacity(0.18)).overlay(alignment: .leading) {
                            Capsule().fill(Brand.dsp).frame(width: max(2, geo.size.width * CGFloat(credit[i])))
                        }
                    }
                    .frame(height: 8)
                }
            }
        }
    }
}

/// A linear-trend forecast over a fixed history, projected forward.
struct ForecastExplorer: View {
    let params: [String: String]
    @Local private var horizon = 4.0
    private let history: [Double] = [10, 12, 11, 14, 16, 15, 18, 20]

    private var xs: [Double] { (0..<history.count).map(Double.init) }
    private var fit: (slope: Double, intercept: Double, r2: Double) { Analytics.linearFit(xs: xs, ys: history) }
    private var lastX: Double { Double(history.count - 1) + horizon }
    private var projected: Double { fit.intercept + fit.slope * lastX }

    private var historyPoints: [CGPoint] { zip(xs, history).map { CGPoint(x: $0, y: $1) } }
    private var linePoints: [CGPoint] { [CGPoint(x: 0, y: fit.intercept), CGPoint(x: lastX, y: projected)] }

    var body: some View {
        WidgetShell("Forecast", icon: "chart.line.uptrend.xyaxis", accent: Brand.analytics, note: "linear trend") {
            LabeledSlider(label: "Forecast horizon", value: Fmt.int(Int(horizon)) + " wk", binding: $horizon, range: 1...12, accent: Brand.analytics)
            CurveChart(
                series: [
                    ChartSeries(color: Brand.muted, width: 2, points: historyPoints),
                    ChartSeries(color: Brand.analytics, points: linePoints),
                ],
                xDomain: 0...lastX,
                yDomain: 0...30,
                markers: [.point(x: lastX, y: projected, color: Brand.up)],
                gridColor: Brand.ink.opacity(0.06)
            )
            .frame(height: 140)
            StatLine(label: "Trend per week", value: "+" + Fmt.num(fit.slope, 2), color: Brand.analytics)
            StatLine(label: "Fit quality (R squared)", value: Fmt.num(fit.r2, 2), color: Brand.up)
            StatLine(label: "Projected", value: Fmt.num(projected, 1), color: Brand.up)
        }
    }
}
