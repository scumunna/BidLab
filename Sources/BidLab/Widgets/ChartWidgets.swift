import BidLabCore
import SwiftUI

/// Data-driven charts a lesson can drop into any section, reading their numbers
/// from widget params (data, labels, title, unit). These make a real chart
/// available on any slide without bespoke code per topic.

private func parseDoubles(_ s: String?) -> [Double] {
    (s ?? "").split(separator: ",").compactMap { Double($0.trimmingCharacters(in: .whitespaces)) }
}

private func parseLabels(_ s: String?) -> [String] {
    (s ?? "").split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
}

private func formatValue(_ v: Double, unit: String) -> String {
    let n = (v == v.rounded() && abs(v) < 10000) ? String(format: "%.0f", v) : String(format: "%.1f", v)
    switch unit {
    case "$": return "$" + n
    case "%": return n + "%"
    case "x": return n + "x"
    default: return n
    }
}

private func chartAccessibilityLabel(_ title: String, labels: [String], values: [Double], unit: String) -> String {
    let pairs = zip(labels, values).map { "\($0) \(formatValue($1, unit: unit))" }.joined(separator: ", ")
    let head = title.isEmpty ? "Chart" : title
    return pairs.isEmpty ? head : "\(head). \(pairs)"
}

private func chartCard<Content: View>(_ title: String, @ViewBuilder _ content: () -> Content) -> some View {
    VStack(alignment: .leading, spacing: 12) {
        if !title.isEmpty {
            Text(title).font(.brandRounded(13, .semibold)).foregroundStyle(Brand.ink)
        }
        content()
    }
    .padding(16).frame(maxWidth: .infinity, alignment: .leading)
    .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
    .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
}

/// Vertical bar chart.
struct BarChartWidget: View {
    let params: [String: String]
    private var values: [Double] { parseDoubles(params["data"]) }
    private var labels: [String] { parseLabels(params["labels"]) }
    private var unit: String { params["unit"] ?? "" }
    private var accent: Color { Brand.dsp }

    var body: some View {
        chartCard(params["title"] ?? "") {
            GeometryReader { geo in
                let maxV = max(values.max() ?? 1, 0.0001)
                HStack(alignment: .bottom, spacing: 10) {
                    ForEach(values.indices, id: \.self) { i in
                        VStack(spacing: 4) {
                            Text(formatValue(values[i], unit: unit)).font(.brandMono(9.5, .bold)).foregroundStyle(Brand.muted)
                            RoundedRectangle(cornerRadius: 4, style: .continuous).fill(accent.opacity(0.85))
                                .frame(height: max(3, CGFloat(values[i] / maxV) * (geo.size.height - 36)))
                            Text(i < labels.count ? labels[i] : "").font(.brandRounded(9.5, .medium))
                                .foregroundStyle(Brand.muted).lineLimit(1).minimumScaleFactor(0.7)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .frame(height: 156)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(chartAccessibilityLabel(params["title"] ?? "", labels: labels, values: values, unit: unit))
    }
}

/// Line chart over an ordered series.
struct LineChartWidget: View {
    let params: [String: String]
    private var values: [Double] { parseDoubles(params["data"]) }
    private var labels: [String] { parseLabels(params["labels"]) }
    private var accent: Color { Brand.analytics }

    private var points: [CGPoint] {
        values.enumerated().map { CGPoint(x: Double($0.offset), y: $0.element) }
    }

    var body: some View {
        chartCard(params["title"] ?? "") {
            CurveChart(
                series: [ChartSeries(color: accent, points: points)],
                xDomain: 0 ... max(Double(values.count - 1), 1),
                yDomain: 0 ... max((values.max() ?? 1) * 1.12, 0.0001),
                markers: points.map { .point(x: $0.x, y: $0.y, color: accent) },
                gridColor: Brand.ink.opacity(0.06)
            )
            .frame(height: 150)
            if !labels.isEmpty {
                HStack(spacing: 0) {
                    ForEach(labels.indices, id: \.self) { i in
                        Text(labels[i]).font(.brandRounded(9.5, .medium)).foregroundStyle(Brand.muted)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(chartAccessibilityLabel(params["title"] ?? "", labels: labels, values: values, unit: ""))
    }
}

/// Donut chart showing shares of a whole.
struct DonutChartWidget: View {
    let params: [String: String]
    private var values: [Double] { parseDoubles(params["data"]) }
    private var labels: [String] { parseLabels(params["labels"]) }
    private let palette: [Color] = [Brand.dsp, Brand.planning, Brand.sales, Brand.analytics, Brand.up, Brand.violet]

    var body: some View {
        let total = max(values.reduce(0, +), 0.0001)
        return chartCard(params["title"] ?? "") {
            HStack(spacing: 18) {
                Canvas { context, size in
                    let inset = 9.0
                    let radius = (min(size.width, size.height) - inset * 2) / 2
                    let center = CGPoint(x: size.width / 2, y: size.height / 2)
                    var start = -90.0
                    for (i, v) in values.enumerated() {
                        let sweep = v / total * 360
                        var path = Path()
                        path.addArc(center: center, radius: radius, startAngle: .degrees(start),
                                    endAngle: .degrees(start + sweep), clockwise: false)
                        context.stroke(path, with: .color(palette[i % palette.count]),
                                       style: StrokeStyle(lineWidth: 18, lineCap: .butt))
                        start += sweep
                    }
                }
                .frame(width: 112, height: 112)
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(values.indices, id: \.self) { i in
                        HStack(spacing: 6) {
                            Circle().fill(palette[i % palette.count]).frame(width: 9, height: 9)
                            Text(i < labels.count ? labels[i] : "").font(.brandRounded(11.5, .medium)).foregroundStyle(Brand.ink)
                            Spacer()
                            Text("\(Int((values[i] / total * 100).rounded()))%").font(.brandMono(11, .semibold)).foregroundStyle(Brand.muted)
                        }
                    }
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(chartAccessibilityLabel(params["title"] ?? "", labels: labels, values: values, unit: ""))
    }
}
