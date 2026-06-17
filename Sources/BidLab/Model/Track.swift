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
    var isVertical: Bool = false   // industry deep-dive path, surfaced under Industries, not the Learn grid

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
        // Industry deep-dives: each vertical is a first-class 10-lesson path with its
        // own certification. Surfaced under Industries, filtered out of the Learn grid.
        Track(
            id: "vertical-retail",
            role: "Retail",
            tagline: "Closed-loop iROAS on the retailer's own purchase data, from money map to lift test.",
            icon: "cart.fill",
            accent: Brand.up,
            modules: 10,
            isVertical: true
        ),
        Track(
            id: "vertical-cpg",
            role: "CPG",
            tagline: "Penetration-led growth, trade versus media, and MMM truth over platform ROAS.",
            icon: "shippingbox.fill",
            accent: Brand.planning,
            modules: 10,
            isVertical: true
        ),
        Track(
            id: "vertical-ecommerce",
            role: "Ecommerce",
            tagline: "Break-even ROAS, blended CAC, and contribution margin run the whole buy.",
            icon: "bag.fill",
            accent: Brand.sales,
            modules: 10,
            isVertical: true
        ),
        Track(
            id: "vertical-dtc",
            role: "DTC",
            tagline: "The unit economics are the campaign, after iOS ATT broke platform attribution.",
            icon: "person.crop.square.fill",
            accent: Brand.violet,
            modules: 10,
            isVertical: true
        ),
        Track(
            id: "vertical-auto",
            role: "Auto",
            tagline: "Three tiers, co-op compliance, and VIN matchback to the titled sale.",
            icon: "car.fill",
            accent: Brand.dsp,
            modules: 10,
            isVertical: true
        ),
        Track(
            id: "vertical-finance",
            role: "Finance",
            tagline: "The market's highest CPMs under Special Ad Category and FCRA, priced to a funded account.",
            icon: "building.columns.fill",
            accent: Brand.analytics,
            modules: 10,
            isVertical: true
        ),
        Track(
            id: "vertical-travel",
            role: "Travel",
            tagline: "Look-to-book, a demand curve you don't control, and booking-window pacing.",
            icon: "airplane",
            accent: Brand.core,
            modules: 10,
            isVertical: true
        ),
        Track(
            id: "vertical-telecom",
            role: "Telecom",
            tagline: "Subscription churn economics where one point of churn moves the whole lifetime value.",
            icon: "antenna.radiowaves.left.and.right",
            accent: Brand.adops,
            modules: 10,
            isVertical: true
        ),
        Track(
            id: "vertical-healthcare",
            role: "Healthcare / Pharma",
            tagline: "NPI-level HCP buys, indirect script lift, and MLR-gated creative ops.",
            icon: "cross.case.fill",
            accent: Brand.engineering,
            modules: 10,
            isVertical: true
        ),
        Track(
            id: "vertical-qsr",
            role: "QSR / Restaurants",
            tagline: "Local at scale: footfall, dayparting, and cost per incremental visit.",
            icon: "fork.knife",
            accent: Brand.foundations,
            modules: 10,
            isVertical: true
        ),
        Track(
            id: "vertical-b2b",
            role: "B2B / SaaS",
            tagline: "A months-long, multi-stakeholder funnel and ABM pipeline math.",
            icon: "briefcase.fill",
            accent: Brand.down,
            modules: 10,
            isVertical: true
        ),
    ]
}
