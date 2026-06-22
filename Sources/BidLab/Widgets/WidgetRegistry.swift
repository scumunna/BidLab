import SwiftUI

/// Maps a lesson's `:::widget <type>` directive to a live SwiftUI view. Authors
/// reference widgets by type string; this is the one place that resolves them.
enum WidgetRegistry {
    @ViewBuilder
    static func view(type: String, params: [String: String]) -> some View {
        switch type {
        case "auctionSimulator", "auctionPlayground", "bidPlayground":
            AuctionPlayground(params: params)
        case "reachFrequency", "reachPlanner":
            ReachFrequencyPlayground(params: params)
        case "experimentPower", "powerCalculator", "abTest":
            PowerExplorer(params: params)
        case "pricingCalculator":
            PricingCalculator(params: params)
        case "marginModeler":
            MarginModeler(params: params)
        case "yieldExplorer":
            YieldExplorer(params: params)
        case "funnelExplorer":
            FunnelExplorer(params: params)
        case "budgetAllocator":
            BudgetAllocatorWidget(params: params)
        case "responseCurve", "saturationExplorer":
            ResponseCurveWidget(params: params)
        case "adstockExplorer":
            AdstockExplorer(params: params)
        case "distributionExplorer":
            DistributionExplorer(params: params)
        case "barChart":
            BarChartWidget(params: params)
        case "lineChart":
            LineChartWidget(params: params)
        case "donutChart":
            DonutChartWidget(params: params)
        case "didExplorer":
            DiDExplorer(params: params)
        case "attributionComparison":
            AttributionComparison(params: params)
        case "forecastExplorer":
            ForecastExplorer(params: params)
        case "latencySimulator":
            LatencySimulator(params: params)
        case "throughputSimulator":
            ThroughputSimulator(params: params)
        case "pacingController":
            PacingControllerWidget(params: params)
        case "codeLab":
            CodeLab(params: params)
        case "sqlLab":
            SQLLab(params: params)
        case "pixelSetup", "pixelWalkthrough":
            PixelSetupExplorer(params: params)
        case "pixelCalculators", "trackingCalculators":
            PixelMatchCalculators(params: params)
        default:
            UnknownWidget(type: type)
        }
    }
}

/// Shown when a lesson references a widget that has not been built yet.
private struct UnknownWidget: View {
    let type: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "cube.transparent").font(.system(size: 16, weight: .bold)).foregroundStyle(Brand.muted)
            VStack(alignment: .leading, spacing: 2) {
                Text("Widget: \(type)").font(.brandRounded(13, .semibold)).foregroundStyle(Brand.ink)
                Text("This interactive is coming in a later phase.").font(.brandRounded(12, .regular)).foregroundStyle(Brand.muted)
            }
            Spacer()
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.ink.opacity(0.03), in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }
}
