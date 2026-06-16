import SwiftUI

/// The practitioner tools hub: the interactive models, usable on their own
/// outside any lesson. A course you finish and close, a tool you reopen daily.
struct ToolsSurface: View {
    @Local private var selected = 0

    private let tools: [(name: String, icon: String, accent: Color)] = [
        ("Bring your campaign", "tray.and.arrow.down", Brand.dsp),
        ("Bid playground", "chart.line.uptrend.xyaxis", Brand.dsp),
        ("Reach & frequency", "target", Brand.planning),
        ("Budget allocator", "square.grid.3x1.below.line.grid.1x2", Brand.planning),
        ("Pricing calculator", "dollarsign.circle", Brand.sales),
        ("Margin modeler", "chart.pie", Brand.sales),
        ("Experiment power", "function", Brand.analytics),
        ("Latency & timeout", "timer", Brand.engineering),
        ("Live benchmarks", "checkmark.seal", Brand.up),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Tools").font(.brandDisplay(30, .heavy)).foregroundStyle(Brand.ink)
                    Text("The math-true models, ready to use on your own work.")
                        .font(.brandRounded(15, .regular)).foregroundStyle(Brand.muted)
                }
                HStack(alignment: .top, spacing: 22) {
                    picker.frame(width: 210)
                    selectedTool.frame(maxWidth: 560)
                }
            }
            .padding(.horizontal, 38)
            .padding(.top, 40)
            .padding(.bottom, 48)
            .frame(maxWidth: 1000, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var picker: some View {
        VStack(spacing: 6) {
            ForEach(tools.indices, id: \.self) { i in
                Button { selected = i } label: {
                    HStack(spacing: 10) {
                        Image(systemName: tools[i].icon).font(.system(size: 14, weight: .semibold)).frame(width: 20)
                            .foregroundStyle(selected == i ? tools[i].accent : Brand.muted)
                        Text(tools[i].name).font(.brandRounded(13.5, selected == i ? .semibold : .regular))
                            .foregroundStyle(selected == i ? Brand.ink : Brand.muted)
                        Spacer()
                    }
                    .padding(.horizontal, 12).padding(.vertical, 10)
                    .background(selected == i ? tools[i].accent.opacity(0.12) : .clear, in: RoundedRectangle(cornerRadius: Metric.radiusSm, style: .continuous))
                }
                .buttonStyle(.plain)
            }
        }
    }

    @ViewBuilder
    private var selectedTool: some View {
        switch selected {
        case 0: CampaignImportView()
        case 1: AuctionPlayground(params: [:])
        case 2: ReachFrequencyPlayground(params: [:])
        case 3: BudgetAllocatorWidget(params: [:])
        case 4: PricingCalculator(params: [:])
        case 5: MarginModeler(params: [:])
        case 6: PowerExplorer(params: [:])
        case 7: LatencySimulator(params: [:])
        default: BenchmarksReference()
        }
    }
}
