import BidLabCore
import Foundation
import SwiftUI

/// CPM to CPC to CPA conversions.
struct PricingCalculator: View {
    let params: [String: String]
    @Local private var cpm = 8.0
    @Local private var ctr = 0.008
    @Local private var cvr = 0.05

    private var cpc: Double { Pricing.cpc(cpm: cpm, ctr: ctr) }
    private var cpa: Double { Pricing.cpa(cpc: cpc, cvr: cvr) }

    var body: some View {
        WidgetShell("Pricing calculator", icon: "dollarsign.circle", accent: Brand.sales, note: "CPM to CPC to CPA") {
            LabeledSlider(label: "CPM", value: Fmt.money(cpm), binding: $cpm, range: 1...50, accent: Brand.sales, kind: .money(2))
            LabeledSlider(label: "CTR", value: Fmt.pct(ctr, 2), binding: $ctr, range: 0.001...0.05, accent: Brand.sales, kind: .pct(2))
            LabeledSlider(label: "CVR", value: Fmt.pct(cvr, 1), binding: $cvr, range: 0.005...0.25, accent: Brand.sales, kind: .pct(1))
            Divider().overlay(Brand.hairline)
            StatLine(label: "Effective CPC", value: Fmt.money(cpc, 2), color: Brand.sales)
            StatLine(label: "Effective CPA", value: Fmt.money(cpa, 2), color: Brand.dsp)
            StatLine(label: "Conversions / 1k impressions", value: Fmt.num(ctr * cvr * 1000, 2))
        }
    }
}

/// Gross, net, and the take rate (the ad-tech tax).
struct MarginModeler: View {
    let params: [String: String]
    @Local private var gross = 50_000.0
    @Local private var take = 0.15

    private var margin: Double { gross * take }
    private var net: Double { gross - margin }

    var body: some View {
        WidgetShell("Margin modeler", icon: "chart.pie", accent: Brand.sales, note: "the ad-tech tax") {
            LabeledSlider(label: "Gross spend", value: Fmt.money(gross, 0), binding: $gross, range: 1000...200_000, accent: Brand.sales, kind: .money(0))
            LabeledSlider(label: "Take rate", value: Fmt.pct(take), binding: $take, range: 0.02...0.45, accent: Brand.sales, kind: .pct(1))
            GeometryReader { geo in
                HStack(spacing: 2) {
                    Rectangle().fill(Brand.up).frame(width: max(2, geo.size.width * CGFloat(net / gross)))
                    Rectangle().fill(Brand.sales)
                }
                .frame(height: 14)
                .clipShape(Capsule())
            }
            .frame(height: 14)
            StatLine(label: "To working media (net)", value: Fmt.money(net, 0), color: Brand.up)
            StatLine(label: "Your margin", value: Fmt.money(margin, 0), color: Brand.sales)
        }
    }
}

/// Fill rate and yield on available inventory. Fill is NOT independent of the
/// floor: raising the floor prices out demand, so fill falls. With demand whose
/// clearing prices average `m` (an exponential pool), fill = e^(-floor/m) and
/// each filled impression earns the floor, so revenue(floor) = avails ·
/// e^(-floor/m) · floor / 1000. That peaks at floor = m, the yield-maximizing
/// floor: below it you leave price on the table, above it fill collapses faster
/// than price rises. This is the tradeoff the sell-side lesson teaches.
struct YieldExplorer: View {
    let params: [String: String]
    @Local private var avails = 20_000_000.0
    @Local private var demand = 4.0   // mean clearing CPM of the demand pool
    @Local private var floor = 2.0

    private var fill: Double { exp(-floor / max(demand, 0.1)) }
    private var filled: Double { avails * fill }
    private var revenue: Double { filled / 1000 * floor }
    private var optimalFloor: Double { demand }   // argmax of floor · e^(-floor/m)

    var body: some View {
        WidgetShell("Yield explorer", icon: "chart.bar", accent: Brand.sales, note: "the floor / fill tradeoff") {
            LabeledSlider(label: "Avails", value: Fmt.millions(avails), binding: $avails, range: 1_000_000...100_000_000, accent: Brand.sales, kind: .millions)
            LabeledSlider(label: "Demand strength (mean CPM)", value: Fmt.money(demand), binding: $demand, range: 1...12, accent: Brand.sales, kind: .money(2))
            LabeledSlider(label: "Floor CPM", value: Fmt.money(floor), binding: $floor, range: 0.5...15, accent: Brand.sales, kind: .money(2))
            Divider().overlay(Brand.hairline)
            StatLine(label: "Fill rate (priced by floor)", value: Fmt.pct(fill), color: Brand.sales)
            StatLine(label: "Filled impressions", value: Fmt.millions(filled), color: Brand.sales)
            StatLine(label: "Revenue", value: Fmt.money(revenue, 0), color: Brand.up)
            StatLine(label: "Yield-maximizing floor", value: Fmt.money(optimalFloor), color: Brand.violet)
        }
    }
}

/// Impressions to clicks to conversions funnel.
struct FunnelExplorer: View {
    let params: [String: String]
    @Local private var ctr = 0.01
    @Local private var cvr = 0.08
    private let impressions = 1_000_000.0

    private var clicks: Double { impressions * ctr }
    private var conversions: Double { clicks * cvr }

    var body: some View {
        WidgetShell("Funnel explorer", icon: "line.3.horizontal.decrease", accent: Brand.sales, note: "impressions to conversions") {
            LabeledSlider(label: "CTR", value: Fmt.pct(ctr, 2), binding: $ctr, range: 0.001...0.05, accent: Brand.sales, kind: .pct(2))
            LabeledSlider(label: "CVR", value: Fmt.pct(cvr, 1), binding: $cvr, range: 0.01...0.30, accent: Brand.sales, kind: .pct(1))
            bar("Impressions", impressions, Brand.dsp)
            bar("Clicks", clicks, Brand.sales)
            bar("Conversions", conversions, Brand.up)
        }
    }

    private func bar(_ label: String, _ value: Double, _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(label).font(.brandRounded(12, .regular)).foregroundStyle(Brand.muted)
                Spacer()
                Text(Fmt.int(Int(value))).font(.brandMono(12, .bold)).foregroundStyle(color)
            }
            GeometryReader { geo in
                Capsule().fill(color.opacity(0.2)).overlay(alignment: .leading) {
                    Capsule().fill(color).frame(width: max(6, geo.size.width * CGFloat(sqrt(value / impressions))))
                }
            }
            .frame(height: 10)
        }
    }
}
