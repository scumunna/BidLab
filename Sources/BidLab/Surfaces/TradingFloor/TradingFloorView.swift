import BidLabCore
import Foundation
import SwiftUI

/// The hero Trading Floor: a real, interactive, math-true bidding simulator
/// (first-price or second-price). Drag your bid, watch the analytic win rate and expected-profit
/// curve respond, then run tens of thousands of auctions against a simulated
/// market and score your strategy against the mathematical optimum.
struct TradingFloorView: View {
    private struct Scenario {
        let name: String
        let marketMean: Double
        let marketSigma: Double
        let floor: Double          // publisher reserve: a bid under it never wins
        let ctr: Double
        let cvr: Double
        let revenuePerConversion: Double
    }

    // Mean clearing price sits below value per impression so there is a real
    // profitable bidding region, the way a desk actually faces it. Each scenario
    // carries a publisher floor, the reserve a bid must clear to even compete.
    private let scenarios = [
        Scenario(name: "Retail prospecting", marketMean: 0.45, marketSigma: 0.50, floor: 0.20, ctr: 0.02, cvr: 0.10, revenuePerConversion: 500),     // value 1.00
        Scenario(name: "Brand awareness", marketMean: 0.06, marketSigma: 0.50, floor: 0.03, ctr: 0.004, cvr: 0.02, revenuePerConversion: 1500),      // value 0.12
        Scenario(name: "Competitive retargeting", marketMean: 0.70, marketSigma: 0.50, floor: 0.35, ctr: 0.06, cvr: 0.20, revenuePerConversion: 120), // value 1.44
    ]
    private let opportunities = 50_000
    private let budgetCap = 1_000_000.0
    private let seed: UInt64 = 20_260_613

    @EnvironmentObject var progress: ProgressStore
    @Local private var scenarioIndex = 0
    @Local private var bid: Double = 0.30
    @Local private var floor: Double = 0.20
    @Local private var secondPrice = false
    @Local private var paced = false
    @Local private var flightBudget: Double = 7_500
    @Local private var pacedResult: PacedFlight.Result?
    private let flightIntervals = 12

    private var scenario: Scenario { scenarios[scenarioIndex] }
    private var marketMean: Double { scenario.marketMean }
    private var marketSigma: Double { scenario.marketSigma }
    private var ctr: Double { scenario.ctr }
    private var cvr: Double { scenario.cvr }
    private var revenuePerConversion: Double { scenario.revenuePerConversion }
    @Local private var result: MarketSimulation.Result?
    @Local private var score: Double?

    private var auctionType: MarketSimulation.AuctionType { secondPrice ? .secondPrice : .firstPrice }
    private func config(bid b: Double) -> MarketSimulation.Config {
        MarketSimulation.Config(
            opportunities: opportunities, bid: b, budget: budgetCap,
            marketMean: marketMean, floor: floor, ctr: ctr, cvr: cvr,
            revenuePerConversion: revenuePerConversion,
            model: .logNormal(sigma: marketSigma), auction: auctionType
        )
    }

    private var value: Double { ctr * cvr * revenuePerConversion }
    // A flight budget that meaningfully binds for the scenario, so pacing matters.
    private var maxFlightBudget: Double { max(value * Double(opportunities) * 0.5, 100) }
    private var defaultFlightBudget: Double { value * Double(opportunities) * 0.15 }
    private var winRate: Double { config(bid: bid).winProbability(at: bid) }
    private var expectedProfitPerOpp: Double { config(bid: bid).expectedProfitPerOpportunity(at: bid) }
    private var optimal: (bid: Double, expectedProfit: Double) { config(bid: bid).optimal() }

    private var profitCurve: [CGPoint] {
        let n = 120
        let c = config(bid: bid)
        return (0...n).map { i in
            let b = value * Double(i) / Double(n)
            return CGPoint(x: b, y: c.expectedProfitPerOpportunity(at: b))
        }
    }

    var body: some View {
        ZStack {
            Brand.console.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 18) {
                topBar
                header
                scenarioPicker
                HStack(alignment: .top, spacing: 20) {
                    controlPanel.frame(width: 360)
                    chartPanel.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxHeight: .infinity)
                formulaFooter
            }
            .padding(28)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }

    private var topBar: some View {
        HStack {
            HStack(spacing: 8) {
                Circle().fill(Brand.up).frame(width: 8, height: 8)
                Text("MARKET OPEN").font(.brandMono(11, .semibold)).foregroundStyle(Brand.up)
            }
            Spacer()
            Text("scenario · \(scenario.name.lowercased()) · \(secondPrice ? "second-price" : "first-price")")
                .font(.brandMono(11, .regular)).foregroundStyle(Color.white.opacity(0.4))
        }
        .padding(.top, Metric.titleBarInset - 18)
    }

    private var scenarioPicker: some View {
        HStack(spacing: 14) {
            Picker("", selection: $scenarioIndex) {
                ForEach(scenarios.indices, id: \.self) { i in
                    Text(scenarios[i].name).tag(i)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(maxWidth: 480)
            .onChange(of: scenarioIndex) { _, _ in
                result = nil
                score = nil
                pacedResult = nil
                floor = scenario.floor
                bid = value * 0.3
                flightBudget = defaultFlightBudget
            }
            Picker("", selection: $secondPrice) {
                Text("First price").tag(false)
                Text("Second price").tag(true)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .frame(width: 220)
            .onChange(of: secondPrice) { _, _ in
                result = nil
                score = nil
                pacedResult = nil
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Trading Floor").font(.brandDisplay(30, .heavy)).foregroundStyle(.white)
            Text("Set your bid, then run the market. Score against the optimal strategy.")
                .font(.brandRounded(13.5, .regular)).foregroundStyle(Color.white.opacity(0.6))
        }
    }

    private var controlPanel: some View {
        VStack(alignment: .leading, spacing: 16) {
            scenarioCard
            bidControl
            if paced, let pacedResult {
                pacedResultTiles(pacedResult)
            } else if let result, let score {
                resultTiles(result, score: score)
            } else {
                runHint
            }
        }
    }

    private var scenarioCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SCENARIO").font(.brandMono(10, .semibold)).foregroundStyle(Color.white.opacity(0.4))
            HStack(spacing: 18) {
                miniStat("Value / imp", money(value, 2), Brand.lime)
                miniStat("Market mean", money(marketMean, 2), Brand.analytics)
            }
            HStack(spacing: 18) {
                miniStat("CTR", pct(ctr), Color.white.opacity(0.85))
                miniStat("CVR", pct(cvr), Color.white.opacity(0.85))
                miniStat("Rev / conv", money(revenuePerConversion, 0), Color.white.opacity(0.85))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.04), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).strokeBorder(Color.white.opacity(0.08), lineWidth: 1))
    }

    private var bidControl: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("YOUR BID").font(.brandMono(10, .semibold)).foregroundStyle(Color.white.opacity(0.4))
                Spacer()
                Text(money(bid, 3)).font(.brandMono(18, .bold)).foregroundStyle(Brand.lime)
            }
            Slider(value: $bid, in: 0.001...value).tint(Brand.lime)
                .accessibilityLabel("Your bid")
                .accessibilityValue(money(bid, 3))
            HStack {
                Text("PUBLISHER FLOOR").font(.brandMono(10, .semibold)).foregroundStyle(Color.white.opacity(0.4))
                Spacer()
                Text(money(floor, 3)).font(.brandMono(14, .bold)).foregroundStyle(Brand.down)
            }
            Slider(value: $floor, in: 0...value).tint(Brand.down)
                .accessibilityLabel("Publisher floor")
                .accessibilityValue(money(floor, 3))
            if bid < floor {
                Text("Your bid is under the floor, so it never clears the reserve.")
                    .font(.brandRounded(11.5, .medium)).foregroundStyle(Brand.down)
            }
            HStack(spacing: 18) {
                miniStat("Win rate", pct(winRate), Brand.lime)
                miniStat("Exp. profit / 1k", money(expectedProfitPerOpp * 1000, 2), Brand.up)
            }
            Picker("", selection: $paced) {
                Text("One-shot").tag(false)
                Text("Paced flight").tag(true)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .onChange(of: paced) { _, _ in result = nil; score = nil; pacedResult = nil }
            if paced {
                HStack {
                    Text("FLIGHT BUDGET").font(.brandMono(10, .semibold)).foregroundStyle(Color.white.opacity(0.4))
                    Spacer()
                    Text(money(flightBudget, 0)).font(.brandMono(14, .bold)).foregroundStyle(Brand.analytics)
                }
                Slider(value: $flightBudget, in: (maxFlightBudget * 0.06)...maxFlightBudget).tint(Brand.analytics)
                    .accessibilityLabel("Flight budget")
                    .accessibilityValue(money(flightBudget, 0))
            }
            Button(action: run) {
                HStack(spacing: 8) {
                    Image(systemName: "play.fill").font(.system(size: 12, weight: .bold))
                    Text(paced ? "Run flight · \(flightIntervals) intervals" : "Run \(intc(opportunities)) auctions").font(.brandRounded(14, .bold))
                }
                .foregroundStyle(Brand.console)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
                .background(Brand.lime, in: Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.04), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).strokeBorder(Color.white.opacity(0.08), lineWidth: 1))
    }

    private var runHint: some View {
        Text("Run the market to see realized results and your score.")
            .font(.brandRounded(12.5, .regular))
            .foregroundStyle(Color.white.opacity(0.45))
            .padding(.horizontal, 4)
    }

    private func resultTiles(_ r: MarketSimulation.Result, score: Double) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("YOUR SCORE").font(.brandMono(10, .semibold)).foregroundStyle(Color.white.opacity(0.4))
                Spacer()
                Text("optimal bid \(money(optimal.bid, 3))").font(.brandMono(11, .regular)).foregroundStyle(Brand.analytics)
            }
            Text(String(format: "%.0f", score))
                .font(.brandDisplay(46, .heavy))
                .foregroundStyle(score >= 80 ? Brand.up : (score >= 50 ? Brand.lime : Brand.down))
                .contentTransition(.numericText())
                .accessibilityLabel("Score \(Int(score)) out of 100")
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                miniStat("Impressions", intc(r.impressionsWon), .white)
                miniStat("Spend", money(r.spend, 0), .white)
                miniStat("Conversions", intc(r.conversions), .white)
                miniStat("eff. CPA", r.conversions > 0 ? money(r.effectiveCPA, 2) : "—", .white)
                miniStat("Revenue", money(r.revenue, 0), Brand.up)
                miniStat("Profit", money(r.profit, 0), r.profit >= 0 ? Brand.up : Brand.down)
                miniStat("Below floor", pct(r.lostToFloorRate), Brand.down)
                miniStat("Outbid", pct(r.lostToCompetitionRate), Color.white.opacity(0.7))
            }
            Button { exportRun(r) } label: {
                HStack(spacing: 6) {
                    Image(systemName: "square.and.arrow.down").font(.system(size: 11, weight: .bold))
                    Text("Export run (CSV + JSON)").font(.brandMono(11, .semibold))
                }
                .foregroundStyle(Brand.analytics)
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.04), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).strokeBorder(Color.white.opacity(0.08), lineWidth: 1))
        .transition(.opacity.combined(with: .move(edge: .top)))
    }

    private var chartPanel: some View {
        VStack(alignment: .leading, spacing: 10) {
            if paced, let pacedResult {
                pacingChart(pacedResult)
            } else {
                profitChart
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.white.opacity(0.03), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).strokeBorder(Color.white.opacity(0.08), lineWidth: 1))
    }

    private var profitChart: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 14) {
                legendDot(Brand.lime, "expected profit")
                legendDot(Brand.lime.opacity(0.9), "your bid", dashed: true)
                legendDot(Brand.down.opacity(0.8), "floor")
                legendDot(Brand.analytics, "optimal")
                Spacer()
            }
            CurveChart(
                series: [ChartSeries(color: Brand.lime, points: profitCurve)],
                xDomain: 0...value,
                yDomain: 0...max(optimal.expectedProfit * 1.2, 1e-4),
                markers: [
                    .vertical(x: bid, color: Brand.lime.opacity(0.9)),
                    .vertical(x: floor, color: Brand.down.opacity(0.7)),
                    .point(x: optimal.bid, y: optimal.expectedProfit, color: Brand.analytics),
                ]
            )
            HStack {
                Text("bid →  \(money(0, 0))").font(.brandMono(10, .regular)).foregroundStyle(Color.white.opacity(0.4))
                Spacer()
                Text(money(value, 2)).font(.brandMono(10, .regular)).foregroundStyle(Color.white.opacity(0.4))
            }
        }
    }

    private func pacingChart(_ r: PacedFlight.Result) -> some View {
        // Two cumulative-spend curves over the flight: where pacing aims (target)
        // and where spend actually landed.
        let target: [CGPoint] = [CGPoint(x: 0, y: 0)] + r.points.map { CGPoint(x: $0.fractionElapsed, y: $0.targetCumulativeSpend) }
        let actual: [CGPoint] = [CGPoint(x: 0, y: 0)] + r.points.map { CGPoint(x: $0.fractionElapsed, y: $0.cumulativeSpend) }
        let yMax = max(r.flightBudget, r.totalSpend) * 1.05
        return VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 14) {
                legendDot(Brand.analytics, "on-pace target")
                legendDot(Brand.lime, "actual spend")
                Spacer()
            }
            CurveChart(
                series: [
                    ChartSeries(color: Brand.analytics, points: target),
                    ChartSeries(color: Brand.lime, points: actual),
                ],
                xDomain: 0...1,
                yDomain: 0...max(yMax, 1e-4),
                markers: []
            )
            HStack {
                Text("flight start").font(.brandMono(10, .regular)).foregroundStyle(Color.white.opacity(0.4))
                Spacer()
                Text("flight end").font(.brandMono(10, .regular)).foregroundStyle(Color.white.opacity(0.4))
            }
        }
    }

    private var formulaFooter: some View {
        TransparencyPanel(
            formula: secondPrice
                ? "E[\\pi / opp] = \\int (value - c)\\, f(c)\\, dc"
                : "E[\\pi / opp] = P_{win}(bid)\\,(value - bid)",
            assumptions: [
                "Competing clearing price is log-normal with mean \(money(marketMean, 2)) and log spread \\sigma = \(String(format: "%.2f", marketSigma)), so the win curve P_win is the log-normal CDF, an S-shaped bid landscape.",
                "Value per impression = CTR × CVR × revenue per conversion.",
                secondPrice
                    ? "Second-price clearing: the winner pays max(clearing price, floor), so bidding your true value is optimal."
                    : "First-price clearing: the winner pays its own bid, so the optimal bid shades below value.",
                "Publisher floor \(money(floor, 2)) is the reserve: a bid below it never clears, and a second-price winner pays at least the floor.",
            ],
            parameters: [
                TransparencyRow(label: "your bid", value: money(bid, 3)),
                TransparencyRow(label: "publisher floor", value: money(floor, 3)),
                TransparencyRow(label: "market mean", value: money(marketMean, 2)),
                TransparencyRow(label: "market sigma", value: String(format: "%.2f", marketSigma)),
                TransparencyRow(label: "value / imp", value: money(value, 2)),
                TransparencyRow(label: "analytic win rate", value: pct(winRate)),
                TransparencyRow(label: "optimal bid", value: money(optimal.bid, 3)),
                TransparencyRow(label: "rng seed", value: String(seed)),
            ],
            tint: Brand.analytics,
            onDark: true
        )
    }

    private func run() {
        if paced {
            let r = PacedFlight.run(baseConfig: config(bid: bid), flightBudget: flightBudget, intervals: flightIntervals, seed: seed)
            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                pacedResult = r
                result = nil
                score = nil
            }
            return
        }
        let r = MarketSimulation.run(config(bid: bid), seed: seed)
        let s = Scoring.score(achievedProfit: r.profit / Double(opportunities), optimalProfit: optimal.expectedProfit)
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            result = r
            score = s
            pacedResult = nil
        }
        progress.recordTradingScore(s)
    }

    private func pacedResultTiles(_ r: PacedFlight.Result) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("FLIGHT RESULT").font(.brandMono(10, .semibold)).foregroundStyle(Color.white.opacity(0.4))
                Spacer()
                Text("\(flightIntervals) intervals · proportional pacing").font(.brandMono(11, .regular)).foregroundStyle(Brand.analytics)
            }
            Text(pct(r.budgetUtilization))
                .font(.brandDisplay(46, .heavy))
                .foregroundStyle(r.budgetUtilization >= 0.9 ? Brand.up : (r.budgetUtilization >= 0.6 ? Brand.lime : Brand.down))
                .contentTransition(.numericText())
            Text("of the flight budget delivered").font(.brandMono(10, .regular)).foregroundStyle(Color.white.opacity(0.4))
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                miniStat("Spend", money(r.totalSpend, 0), .white)
                miniStat("Budget", money(r.flightBudget, 0), .white)
                miniStat("Impressions", intc(r.impressionsWon), .white)
                miniStat("Conversions", intc(r.conversions), .white)
                miniStat("Revenue", money(r.revenue, 0), Brand.up)
                miniStat("Profit", money(r.profit, 0), r.profit >= 0 ? Brand.up : Brand.down)
                miniStat("Pacing error", pct(r.pacingError), r.pacingError <= 0.1 ? Brand.up : Brand.down)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.04), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).strokeBorder(Color.white.opacity(0.08), lineWidth: 1))
        .transition(.opacity.combined(with: .move(edge: .top)))
    }

    private func exportRun(_ r: MarketSimulation.Result) {
        let csv = """
        metric,value
        bid,\(bid)
        publisher_floor,\(floor)
        market_mean,\(marketMean)
        value_per_impression,\(value)
        opportunities,\(opportunities)
        impressions_won,\(r.impressionsWon)
        spend,\(r.spend)
        clicks,\(r.clicks)
        conversions,\(r.conversions)
        revenue,\(r.revenue)
        profit,\(r.profit)
        win_rate,\(r.winRate)
        lost_to_floor,\(r.lostToFloor)
        lost_to_competition,\(r.lostToCompetition)
        score,\(score ?? 0)
        """
        Exporter.saveText(csv, name: "bidlab-trading-run", ext: "csv")
        let json = "{\"bid\":\(bid),\"publisherFloor\":\(floor),\"marketMean\":\(marketMean),\"valuePerImpression\":\(value),\"opportunities\":\(opportunities),\"impressionsWon\":\(r.impressionsWon),\"spend\":\(r.spend),\"clicks\":\(r.clicks),\"conversions\":\(r.conversions),\"revenue\":\(r.revenue),\"profit\":\(r.profit),\"winRate\":\(r.winRate),\"lostToFloor\":\(r.lostToFloor),\"lostToCompetition\":\(r.lostToCompetition),\"score\":\(score ?? 0)}"
        Exporter.saveText(json, name: "bidlab-trading-run", ext: "json")
    }

    private func miniStat(_ label: String, _ value: String, _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(label).font(.brandMono(10, .regular)).foregroundStyle(Color.white.opacity(0.4))
            Text(value).font(.brandMono(16, .bold)).foregroundStyle(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func legendDot(_ color: Color, _ label: String, dashed: Bool = false) -> some View {
        HStack(spacing: 5) {
            Circle().fill(color).frame(width: 7, height: 7)
            Text(label).font(.brandMono(10, .regular)).foregroundStyle(Color.white.opacity(0.55))
        }
    }

    private func money(_ x: Double, _ digits: Int = 2) -> String { String(format: "$%.\(digits)f", x) }
    private func pct(_ x: Double) -> String { String(format: "%.1f%%", x * 100) }
    private func intc(_ x: Int) -> String { x.formatted() }
}
