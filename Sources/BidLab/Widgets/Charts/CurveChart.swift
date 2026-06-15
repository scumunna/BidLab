import SwiftUI

/// An original, lightweight curve chart drawn with SwiftUI `Canvas`. Plots one or
/// more series in data space with optional vertical and point markers. Used by
/// the Trading Floor and, later, the formula playgrounds. No external charting
/// dependency, so it builds cleanly with the swiftc toolchain and stays fully
/// under our control.
struct ChartSeries {
    let color: Color
    let width: CGFloat
    let points: [CGPoint] // data-space (x, y)

    init(color: Color, width: CGFloat = 2.5, points: [CGPoint]) {
        self.color = color
        self.width = width
        self.points = points
    }
}

struct ChartMarker {
    enum Kind { case vertical, point }
    let kind: Kind
    let x: Double
    let y: Double
    let color: Color

    static func vertical(x: Double, color: Color) -> ChartMarker {
        ChartMarker(kind: .vertical, x: x, y: 0, color: color)
    }

    static func point(x: Double, y: Double, color: Color) -> ChartMarker {
        ChartMarker(kind: .point, x: x, y: y, color: color)
    }
}

struct CurveChart: View {
    let series: [ChartSeries]
    let xDomain: ClosedRange<Double>
    let yDomain: ClosedRange<Double>
    var markers: [ChartMarker] = []
    var gridColor: Color = Color.white.opacity(0.08)
    var yFormat: (Double) -> String = { v in
        if abs(v) >= 1000 { return String(format: "%.0f", v) }
        if abs(v) >= 1 { return String(format: "%.1f", v) }
        return String(format: "%.2f", v)
    }

    var body: some View {
        Canvas { ctx, size in
            let xLo = xDomain.lowerBound
            let xHi = xDomain.upperBound
            let yLo = yDomain.lowerBound
            let yHi = yDomain.upperBound
            let xSpan = max(xHi - xLo, 1e-9)
            let ySpan = max(yHi - yLo, 1e-9)

            func px(_ x: Double) -> CGFloat { CGFloat((x - xLo) / xSpan) * size.width }
            func py(_ y: Double) -> CGFloat { size.height - CGFloat((y - yLo) / ySpan) * size.height }

            for i in 0...4 {
                let yy = size.height * CGFloat(i) / 4
                var line = Path()
                line.move(to: CGPoint(x: 0, y: yy))
                line.addLine(to: CGPoint(x: size.width, y: yy))
                ctx.stroke(line, with: .color(gridColor), lineWidth: 1)
            }

            for s in series where s.points.count > 1 {
                var path = Path()
                for (i, pt) in s.points.enumerated() {
                    let c = CGPoint(x: px(pt.x), y: py(pt.y))
                    if i == 0 { path.move(to: c) } else { path.addLine(to: c) }
                }
                ctx.stroke(path, with: .color(s.color), style: StrokeStyle(lineWidth: s.width, lineJoin: .round))
            }

            for m in markers {
                switch m.kind {
                case .vertical:
                    let x = px(m.x)
                    var line = Path()
                    line.move(to: CGPoint(x: x, y: 0))
                    line.addLine(to: CGPoint(x: x, y: size.height))
                    ctx.stroke(line, with: .color(m.color), style: StrokeStyle(lineWidth: 1.5, dash: [4, 3]))
                case .point:
                    let c = CGPoint(x: px(m.x), y: py(m.y))
                    let r: CGFloat = 5
                    ctx.fill(Path(ellipseIn: CGRect(x: c.x - r, y: c.y - r, width: 2 * r, height: 2 * r)), with: .color(m.color))
                    ctx.stroke(
                        Path(ellipseIn: CGRect(x: c.x - r - 3, y: c.y - r - 3, width: 2 * r + 6, height: 2 * r + 6)),
                        with: .color(m.color.opacity(0.4)),
                        lineWidth: 1.5
                    )
                }
            }

            ctx.draw(
                Text(yFormat(yHi)).font(.system(size: 9)).foregroundColor(.gray),
                at: CGPoint(x: 3, y: 2), anchor: .topLeading
            )
            ctx.draw(
                Text(yFormat(yLo)).font(.system(size: 9)).foregroundColor(.gray),
                at: CGPoint(x: 3, y: size.height - 2), anchor: .bottomLeading
            )
        }
    }
}
