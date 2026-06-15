import Foundation

/// An industry vertical with its distinctive media math. The point is that the
/// economics genuinely differ by vertical: retail runs on closed-loop iROAS,
/// CPG on household penetration and MMM, ecommerce on contribution margin,
/// telecom on churn, pharma on indirect script-lift. Each vertical carries a
/// signature KPI, a cited anchor figure, and a realistic scenario, so the lens
/// adapts examples to the learner's world rather than swapping logos.
public struct Vertical: Equatable, Identifiable {
    public let id: String
    public let name: String
    public let icon: String
    public let blurb: String            // one line: what is different here
    public let signatureKPI: String     // e.g. "iROAS", "LTV:CAC", "CPIV"
    public let signatureFormula: String // the literal formula
    public let anchorLabel: String      // a cited market/benchmark anchor
    public let anchorValue: String
    public let scenario: String         // a realistic capstone problem
    public let citation: Citation

    public init(id: String, name: String, icon: String, blurb: String,
                signatureKPI: String, signatureFormula: String,
                anchorLabel: String, anchorValue: String, scenario: String, citation: Citation) {
        self.id = id
        self.name = name
        self.icon = icon
        self.blurb = blurb
        self.signatureKPI = signatureKPI
        self.signatureFormula = signatureFormula
        self.anchorLabel = anchorLabel
        self.anchorValue = anchorValue
        self.scenario = scenario
        self.citation = citation
    }
}

/// The 11 launch verticals. Every anchor figure is sourced; see Research/verticals
/// for the full citations, formulas, and verification flags behind each one.
public enum Verticals {
    private static func emarketer(_ year: Int) -> Citation {
        Citation(source: "EMARKETER", url: "https://www.emarketer.com/", year: year)
    }

    public static let all: [Vertical] = [
        Vertical(
            id: "retail", name: "Retail", icon: "cart.fill",
            blurb: "Closed-loop, deterministic attribution on the retailer's own purchase data.",
            signatureKPI: "iROAS", signatureFormula: "Incremental Revenue / Ad Spend",
            anchorLabel: "US retail media ad spend, 2026", anchorValue: "$71.1B",
            scenario: "Audit a flattering 5.0x reported ROAS down to a true 2.3x iROAS with a geo holdout, then reallocate to maximize incremental revenue.",
            citation: emarketer(2026)),
        Vertical(
            id: "cpg", name: "CPG", icon: "shippingbox.fill",
            blurb: "Growth comes from household penetration, not loyalty, and MMM is the measurement.",
            signatureKPI: "mROI", signatureFormula: "d(Incremental Sales x margin) / d Spend",
            anchorLabel: "US CPG digital ad spend, 2026", anchorValue: "$56B",
            scenario: "Split a $40M plan across broad reach, retail media, and trade promotion to grow penetration 1.5 points without overspending on saturated channels.",
            citation: emarketer(2026)),
        Vertical(
            id: "ecommerce", name: "Ecommerce", icon: "bag.fill",
            blurb: "Break-even ROAS is one over gross margin, and blended CAC is the honest number.",
            signatureKPI: "LTV:CAC", signatureFormula: "LTV / CAC",
            anchorLabel: "US ecommerce sales, 2025", anchorValue: "$1.19T",
            scenario: "Hit a 40% growth target while keeping contribution margin positive after CAC and LTV:CAC at or above 3:1.",
            citation: Citation(source: "US Census Bureau", url: "https://fred.stlouisfed.org/series/ECOMPCTSA", year: 2025)),
        Vertical(
            id: "dtc", name: "DTC", icon: "person.crop.square.fill",
            blurb: "The unit economics are the campaign; platform ROAS over-claims after iOS ATT.",
            signatureKPI: "MER", signatureFormula: "Total Revenue / Total Ad Spend",
            anchorLabel: "Healthy LTV:CAC target", anchorValue: ">= 3:1",
            scenario: "Scale spend from $50k to $150k a month as CPMs rise, keeping payback under six months by lifting AOV and retention.",
            citation: Citation(source: "Eightx LTV:CAC guide", url: "https://eightx.co/blog/ltv-cac-ratio-guide", year: 2026, verified: false, note: "Industry consensus target, not a single measured figure.")),
        Vertical(
            id: "auto", name: "Auto", icon: "car.fill",
            blurb: "Three tiers (OEM, dealer association, dealer) with co-op reimbursement on compliant spend.",
            signatureKPI: "Net cost per sale", signatureFormula: "Gross spend - OEM co-op reimbursement",
            anchorLabel: "US automotive digital ad spend, 2025", anchorValue: "$22.25B",
            scenario: "Sell 30 incremental units a month on a 50% co-op match, optimizing cost per qualified lead while keeping every creative co-op compliant.",
            citation: emarketer(2025)),
        Vertical(
            id: "finance", name: "Finance", icon: "building.columns.fill",
            blurb: "The highest CPMs in the market; Special Ad Category and FCRA constrain targeting and creative.",
            signatureKPI: "Cost per funded account", signatureFormula: "CPL / (Lead->App rate x App->Fund rate)",
            anchorLabel: "Most expensive Google keyword (insurance) CPC", anchorValue: "$54.91",
            scenario: "Hit a cost per funded account at or below $300 under Meta's Special Ad Category limits (no ZIP targeting, 15-mile minimum, no lookalikes).",
            citation: Citation(source: "WordStream", url: "https://www.wordstream.com/articles/most-expensive-keywords", year: 2025)),
        Vertical(
            id: "travel", name: "Travel", icon: "airplane",
            blurb: "High order values, booking-window sensitivity, and abandonment retargeting drive the math.",
            signatureKPI: "Cost per booking", signatureFormula: "Ad Spend / Bookings",
            anchorLabel: "US travel media network ad spend, 2026", anchorValue: "$2.96B",
            scenario: "Shift budget from peak to shoulder season and add back the saved OTA commission to compute a true margin-adjusted ROAS.",
            citation: emarketer(2026)),
        Vertical(
            id: "telecom", name: "Telecom", icon: "antenna.radiowaves.left.and.right",
            blurb: "Subscription economics: one point of monthly churn moves the whole customer lifetime value.",
            signatureKPI: "LTV:CAC", signatureFormula: "CLV / CPGA",
            anchorLabel: "T-Mobile postpaid phone churn", anchorValue: "0.90%",
            scenario: "Keep LTV:CAC at or above 3 against a $400 handset subsidy and 1.4% monthly churn, trading subsidy against a retention budget.",
            citation: Citation(source: "T-Mobile SEC 8-K", url: "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001283699", year: 2025)),
        Vertical(
            id: "healthcare", name: "Healthcare / Pharma", icon: "cross.case.fill",
            blurb: "Conversion is a prescription, measured indirectly by lift; no individual health targeting.",
            signatureKPI: "Cost per script", signatureFormula: "Ad Spend / Incremental scripts",
            anchorLabel: "US healthcare and pharma digital ad spend, 2026", anchorValue: "$26.15B",
            scenario: "Run a test-versus-control script-lift at 90% HCP audience quality and stay within FDA fair-balance, with zero compliance violations.",
            citation: emarketer(2026)),
        Vertical(
            id: "qsr", name: "QSR / Restaurants", icon: "fork.knife",
            blurb: "Conversion is a physical, incremental store visit measured by location data.",
            signatureKPI: "CPIV", signatureFormula: "Ad Spend / Incremental Visits",
            anchorLabel: "Tracked QSR brand ad spend", anchorValue: "$3.3B",
            scenario: "Hit 40,000 incremental store visits at a cost per incremental visit at or below $5.50, allocating across dayparts and a 3-mile radius per store.",
            citation: Citation(source: "Sensor Tower", url: "https://sensortower.com/blog/qsr-apps-competitive-intel", year: 2025)),
        Vertical(
            id: "b2b", name: "B2B / SaaS", icon: "briefcase.fill",
            blurb: "Revenue is months and roughly 25 stakeholders downstream; you optimize a multi-stage funnel.",
            signatureKPI: "LTV:CAC", signatureFormula: "LTV / CAC (target 3:1 or better)",
            anchorLabel: "US B2B digital ad spend, 2026", anchorValue: "$23.05B",
            scenario: "Drive $3M of marketing-sourced pipeline by engaging 60% of a 250-account target list, keeping payback under twelve months.",
            citation: emarketer(2026)),
    ]

    public static func byID(_ id: String) -> Vertical? { all.first { $0.id == id } }
}
