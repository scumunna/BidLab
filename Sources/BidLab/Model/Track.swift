import SwiftUI

/// A learning path. Presentation-level for now; the full curriculum (modules,
/// lessons, widgets, citations) is authored as content data in later phases.
struct Track: Identifiable, Hashable {
    let id: String
    let role: String
    let tagline: String
    let icon: String        // SF Symbol name
    let accent: Color
    let modules: Int

    static let all: [Track] = [
        Track(
            id: "foundations",
            role: "Foundations",
            tagline: "From arithmetic to light calculus, the math every path is built on.",
            icon: "x.squareroot",
            accent: Brand.foundations,
            modules: 12
        ),
        Track(
            id: "core",
            role: "Programmatic Core",
            tagline: "The ecosystem, the auction, identity, pricing, and measurement.",
            icon: "point.3.connected.trianglepath.dotted",
            accent: Brand.core,
            modules: 12
        ),
        Track(
            id: "adops",
            role: "Ad Operations",
            tagline: "Traffic, QA, verify, and reconcile a live campaign the way a real ad ops desk runs.",
            icon: "wrench.and.screwdriver.fill",
            accent: Brand.adops,
            modules: 12
        ),
        Track(
            id: "dsp",
            role: "DSP / Trader",
            tagline: "Bid, shade, and pace to win the impression at the right price.",
            icon: "chart.line.uptrend.xyaxis",
            accent: Brand.dsp,
            modules: 13
        ),
        Track(
            id: "sales",
            role: "Sales / Account",
            tagline: "Price the deal, protect the margin, and tell the ROI story.",
            icon: "dollarsign.circle",
            accent: Brand.sales,
            modules: 12
        ),
        Track(
            id: "planning",
            role: "Planning / Strategy",
            tagline: "Size audiences and allocate budget for maximum reach and outcomes.",
            icon: "target",
            accent: Brand.planning,
            modules: 13
        ),
        Track(
            id: "analytics",
            role: "Analytics / Data Science",
            tagline: "Design experiments, measure incrementality, model the mix.",
            icon: "function",
            accent: Brand.analytics,
            modules: 15
        ),
        Track(
            id: "engineering",
            role: "Engineering",
            tagline: "Build the bidder: OpenRTB, latency budgets, pacing, model serving.",
            icon: "cpu",
            accent: Brand.engineering,
            modules: 13
        ),
        Track(
            id: "ai",
            role: "AI in AdTech",
            tagline: "What AI is doing in programmatic, and the new job of guardrails and auditing.",
            icon: "wand.and.stars",
            accent: Brand.violet,
            modules: 11
        ),
    ]
}
