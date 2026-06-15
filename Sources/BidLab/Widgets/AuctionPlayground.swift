import BidLabCore
import Foundation
import SwiftUI

/// A compact, embeddable bid playground for lessons. Drag the bid to see the
/// win rate and expected-profit curve, then drop a single live auction and watch
/// competing bids spring in and the winner resolve. Shares the exact BidLabCore
/// math the Trading Floor uses.
struct AuctionPlayground: View {
    let params: [String: String]
    @Local private var bid: Double = 0.30
    @Local private var competing: [Double] = []
    @Local private var revealed = false

    private var value: Double { Double(params["value"] ?? "") ?? 1.0 }
    private var marketMean: Double { Double(params["marketMean"] ?? "") ?? 0.5 }
    private var sigma: Double { Double(params["sigma"] ?? "") ?? 0.5 }

    // A log-normal market, the same model the Trading Floor uses, so the bid
    // math is identical across the app.
    private var config: MarketSimulation.Config {
        MarketSimulation.Config(
            opportunities: 1, bid: bid, budget: .infinity,
            marketMean: marketMean, ctr: 1, cvr: 1, revenuePerConversion: value,
            model: .logNormal(sigma: sigma)
        )
    }

    private var winRate: Double { config.winProbability(at: bid) }
    private var expectedProfit: Double { config.expectedProfitPerOpportunity(at: bid) }
    private var optimal: (bid: Double, expectedProfit: Double) { config.optimal() }
    private var curve: [CGPoint] {
        let c = config
        return (0...100).map { i in
            let b = value * Double(i) / 100
            return CGPoint(x: b, y: c.expectedProfitPerOpportunity(at: b))
        }
    }

    private var marketBest: Double { competing.max() ?? 0 }
    private var youWin: Bool { !competing.isEmpty && bid > marketBest }
    private var stripMax: Double { max((competing + [bid]).max() ?? value, value * 0.6) }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: "slider.horizontal.3").font(.system(size: 13, weight: .bold)).foregroundStyle(Brand.dsp)
                Text("Bid playground").font(.brandRounded(13, .semibold)).foregroundStyle(Brand.ink)
                Spacer()
                Text("first-price").font(.brandMono(11, .regular)).foregroundStyle(Brand.muted)
            }

            HStack(alignment: .top, spacing: 18) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Your bid").font(.brandRounded(12.5, .medium)).foregroundStyle(Brand.muted)
                        Spacer()
                        Text(money(bid)).font(.brandMono(15, .bold)).foregroundStyle(Brand.dsp)
                    }
                    Slider(value: $bid, in: 0.001...value).tint(Brand.dsp)
                        .accessibilityLabel("Your bid")
                        .accessibilityValue(money(bid))
                    stat("Win rate", String(format: "%.1f%%", winRate * 100), Brand.dsp)
                    stat("Exp. profit / 1k", String(format: "$%.2f", expectedProfit * 1000), Brand.up)
                    stat("Optimal bid", money(optimal.bid), Brand.analytics)
                }
                .frame(width: 150)

                CurveChart(
                    series: [ChartSeries(color: Brand.dsp, points: curve)],
                    xDomain: 0...value,
                    yDomain: 0...max(optimal.expectedProfit * 1.2, 1e-4),
                    markers: [
                        .vertical(x: bid, color: Brand.dsp.opacity(0.8)),
                        .point(x: optimal.bid, y: optimal.expectedProfit, color: Brand.analytics),
                    ],
                    gridColor: Brand.ink.opacity(0.06)
                )
                .frame(height: 150)
                .frame(maxWidth: .infinity)
            }

            Rectangle().fill(Brand.hairline).frame(height: 1)
            auctionDrop
        }
        .padding(16)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    private var auctionDrop: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Drop a live auction").font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.ink)
                Spacer()
                Button(action: drop) {
                    HStack(spacing: 5) {
                        Image(systemName: "dice").font(.system(size: 11, weight: .bold))
                        Text("Drop").font(.brandRounded(12.5, .bold))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 13).padding(.vertical, 6)
                    .background(Brand.dsp, in: Capsule())
                }
                .buttonStyle(.plain)
            }

            HStack(alignment: .bottom, spacing: 8) {
                ForEach(Array(competing.enumerated()), id: \.offset) { i, b in
                    bar(fraction: b / stripMax, color: Brand.muted.opacity(0.45), label: "")
                        .opacity(revealed ? 1 : 0)
                        .scaleEffect(x: 1, y: revealed ? 1 : 0.1, anchor: .bottom)
                        .animation(.spring(response: 0.5, dampingFraction: 0.7).delay(Double(i) * 0.07), value: revealed)
                }
                if !competing.isEmpty {
                    bar(fraction: bid / stripMax, color: youWin ? Brand.up : Brand.dsp, label: "you")
                        .scaleEffect(x: 1, y: revealed ? 1 : 0.1, anchor: .bottom)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6).delay(Double(competing.count) * 0.07), value: revealed)
                }
                Spacer(minLength: 0)
            }
            .frame(height: 70)

            if competing.isEmpty {
                Text("Drop an auction to see your bid against the field.")
                    .font(.brandRounded(12, .regular)).foregroundStyle(Brand.muted)
            } else {
                Text(youWin
                    ? "You won. Paid \(money(bid)), profit \(money(value - bid))."
                    : "You lost. The field cleared at \(money(marketBest)).")
                    .font(.brandRounded(12.5, .medium))
                    .foregroundStyle(youWin ? Brand.up : Brand.muted)
            }
        }
    }

    private func bar(fraction: Double, color: Color, label: String) -> some View {
        VStack(spacing: 4) {
            Spacer(minLength: 0)
            RoundedRectangle(cornerRadius: 3).fill(color)
                .frame(width: 18, height: max(4, CGFloat(min(fraction, 1)) * 52))
            Text(label).font(.brandMono(9, .semibold)).foregroundStyle(color).frame(height: 10)
        }
    }

    private func drop() {
        let s = max(sigma, 1e-6)
        let mu = log(max(marketMean, 1e-9)) - s * s / 2
        competing = (0..<6).map { _ in
            let u1 = 1 - Double.random(in: 0..<1)   // in (0, 1], avoids log(0)
            let u2 = Double.random(in: 0..<1)
            let z = (-2 * log(u1)).squareRoot() * cos(2 * .pi * u2)  // Box-Muller
            return exp(mu + s * z)
        }
        revealed = false
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) { revealed = true }
    }

    private func stat(_ label: String, _ value: String, _ color: Color) -> some View {
        HStack {
            Text(label).font(.brandRounded(12, .regular)).foregroundStyle(Brand.muted)
            Spacer()
            Text(value).font(.brandMono(13, .bold)).foregroundStyle(color)
        }
    }

    private func money(_ x: Double) -> String { String(format: "$%.3f", x) }
}
