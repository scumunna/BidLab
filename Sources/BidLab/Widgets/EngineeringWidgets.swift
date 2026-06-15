import BidLabCore
import Foundation
import SwiftUI

/// Latency tail and timeout loss for an exponential service time.
struct LatencySimulator: View {
    let params: [String: String]
    @Local private var mean = 40.0
    @Local private var timeout = 100.0

    private var points: [CGPoint] {
        stride(from: 0.0, through: 300.0, by: 3).map { x in CGPoint(x: x, y: (1 / mean) * exp(-x / mean)) }
    }

    var body: some View {
        WidgetShell("Latency simulator", icon: "timer", accent: Brand.engineering, note: "exponential service") {
            LabeledSlider(label: "Mean latency", value: Fmt.num(mean, 0) + " ms", binding: $mean, range: 5...120, accent: Brand.engineering)
            LabeledSlider(label: "Timeout", value: Fmt.num(timeout, 0) + " ms", binding: $timeout, range: 30...300, accent: Brand.engineering)
            CurveChart(
                series: [ChartSeries(color: Brand.engineering, points: points)],
                xDomain: 0...300,
                yDomain: 0...(1 / mean * 1.05),
                markers: [.vertical(x: timeout, color: Brand.down.opacity(0.8))],
                gridColor: Brand.ink.opacity(0.06)
            )
            .frame(height: 130)
            StatLine(label: "p50", value: Fmt.num(Systems.latencyQuantile(meanMs: mean, p: 0.5), 0) + " ms", color: Brand.engineering)
            StatLine(label: "p99", value: Fmt.num(Systems.latencyQuantile(meanMs: mean, p: 0.99), 0) + " ms", color: Brand.planning)
            StatLine(label: "Lost to timeout", value: Fmt.pct(Systems.timeoutLossRate(meanMs: mean, timeoutMs: timeout), 2), color: Brand.down)
        }
    }
}

/// Throughput capacity, utilization, and queueing response time.
struct ThroughputSimulator: View {
    let params: [String: String]
    @Local private var workers = 20.0
    @Local private var serviceMs = 5.0
    @Local private var offered = 2000.0

    private var capacity: Double { Systems.capacityQPS(workers: Int(workers), serviceMeanMs: serviceMs) }
    private var utilization: Double { Systems.utilization(offeredQPS: offered, capacityQPS: capacity) }
    private var responseMs: Double {
        capacity > 0 ? Systems.mm1ResponseTimeMs(arrivalQPS: offered, serviceMeanMs: 1000 / capacity) : .infinity
    }

    var body: some View {
        WidgetShell("Throughput simulator", icon: "arrow.left.arrow.right", accent: Brand.engineering, note: "M/M/1 queue") {
            LabeledSlider(label: "Workers", value: Fmt.int(Int(workers)), binding: $workers, range: 1...100, accent: Brand.engineering)
            LabeledSlider(label: "Service time", value: Fmt.num(serviceMs, 1) + " ms", binding: $serviceMs, range: 1...20, accent: Brand.engineering)
            LabeledSlider(label: "Offered load", value: Fmt.int(Int(offered)) + " qps", binding: $offered, range: 100...30_000, accent: Brand.engineering)
            Divider().overlay(Brand.hairline)
            StatLine(label: "Capacity", value: Fmt.int(Int(capacity)) + " qps", color: Brand.engineering)
            StatLine(label: "Utilization", value: Fmt.pct(min(utilization, 9.99)), color: utilization > 0.8 ? Brand.down : Brand.up)
            StatLine(label: "Response time", value: responseMs.isFinite ? Fmt.num(responseMs, 1) + " ms" : "saturated", color: responseMs.isFinite ? Brand.planning : Brand.down)
        }
    }
}

/// Even-pacing feedback: target vs actual spend, and the throttle response.
struct PacingControllerWidget: View {
    let params: [String: String]
    @Local private var elapsed = 0.5
    @Local private var actual = 400.0
    private let budget = 1000.0

    private var target: Double { Pacing.targetSpend(totalBudget: budget, fractionElapsed: elapsed) }
    private var throttle: Double { Pacing.throttle(targetSpend: target, actualSpend: actual) }

    var body: some View {
        WidgetShell("Pacing controller", icon: "speedometer", accent: Brand.engineering, note: "even pacing") {
            LabeledSlider(label: "Flight elapsed", value: Fmt.pct(elapsed), binding: $elapsed, range: 0...1, accent: Brand.engineering, kind: .pct(1))
            LabeledSlider(label: "Actual spend", value: Fmt.money(actual, 0), binding: $actual, range: 0...budget, accent: Brand.engineering, kind: .money(0))
            CurveChart(
                series: [ChartSeries(color: Brand.muted, points: [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: budget)])],
                xDomain: 0...1,
                yDomain: 0...budget,
                markers: [
                    .point(x: elapsed, y: target, color: Brand.engineering),
                    .point(x: elapsed, y: actual, color: actual > target ? Brand.down : Brand.up),
                ],
                gridColor: Brand.ink.opacity(0.06)
            )
            .frame(height: 120)
            StatLine(label: "On-pace target", value: Fmt.money(target, 0), color: Brand.engineering)
            StatLine(label: "Throttle", value: Fmt.num(throttle, 2) + "x", color: throttle > 1 ? Brand.up : Brand.down)
        }
    }
}

/// The code lab: read the real algorithm behind a system. A browsable set of
/// honest pseudocode snippets, shown in the console treatment. No black boxes.
struct CodeLab: View {
    let params: [String: String]
    @Local private var selected = 0

    private let snippets: [(name: String, code: String)] = [
        ("Bidder hot path", CodeLab.bidderSnippet),
        ("Pacing controller", CodeLab.pacingSnippet),
        ("Budget guard", CodeLab.budgetSnippet),
    ]

    var body: some View {
        WidgetShell("Algorithm", icon: "curlybraces", accent: Brand.engineering, note: "read the code") {
            Picker("", selection: $selected) {
                ForEach(snippets.indices, id: \.self) { i in
                    Text(snippets[i].name).tag(i)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            ScrollView(.horizontal, showsIndicators: false) {
                Text(snippets[selected].code)
                    .font(.brandMono(12, .regular))
                    .foregroundStyle(Color.white.opacity(0.9))
                    .padding(14)
            }
            .background(Brand.console, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
        }
    }

    static let bidderSnippet = """
    // One bid request, under a ~10 ms deadline
    func handleBid(_ req: BidRequest) -> BidResponse? {
        let candidates = index.match(req)          // eligible campaigns
        var best: Bid? = nil
        for c in candidates where pacing.allows(c) {
            let pCTR  = model.predictCTR(c, req)    // calibrated
            let pCVR  = model.predictCVR(c, req)
            let value = pCTR * pCVR * c.valuePerConversion
            let bid   = shade(value, market: c.landscape)  // first-price
            if best == nil || bid > best!.price {
                best = Bid(campaign: c, price: bid)
            }
        }
        return best.map { BidResponse(price: $0.price) }
    }
    """

    static let pacingSnippet = """
    // PID pacing: nudge delivery toward the on-pace target
    func throttle(spent: Double, target: Double) -> Double {
        let error = target - spent
        integral += error * dt
        let derivative = (error - lastError) / dt
        lastError = error
        let signal = kP * error + kI * integral + kD * derivative
        return clamp(base + signal / max(target, 1), low: 0, high: 2)
    }
    """

    static let budgetSnippet = """
    // Distributed budget: prevent overspend under concurrency
    func tryCharge(_ amount: Double) -> Bool {
        while true {
            let current = remaining.load()
            if current < amount { return false }   // hard stop
            // atomic compare-and-swap on the shared budget
            if remaining.compareAndSwap(expected: current, new: current - amount) {
                return true
            }
            // lost the race, retry with the fresh value
        }
    }
    """
}
