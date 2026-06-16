import Foundation

/// A single reference entry: a programmatic term, its plain-language definition,
/// and the formula when there is one. This backs a searchable desk lookup, so a
/// trader or ad ops analyst can answer a 30-second question without walking
/// through a lesson.
public struct GlossaryTerm: Equatable {
    public let term: String        // headword, e.g. "CPM"
    public let name: String        // expansion, e.g. "Cost per mille"
    public let category: String    // grouping, e.g. "Pricing"
    public let definition: String
    public let formula: String?    // plain-text formula, or nil when there is none

    public init(term: String, name: String, category: String, definition: String, formula: String? = nil) {
        self.term = term
        self.name = name
        self.category = category
        self.definition = definition
        self.formula = formula
    }
}

public enum Glossary {
    /// The curated reference set. Definitions are written to be read at a glance,
    /// not to replace the lessons.
    public static let all: [GlossaryTerm] = [
        // Pricing
        GlossaryTerm(term: "CPM", name: "Cost per mille", category: "Pricing",
                     definition: "Cost for one thousand impressions. The base unit most display and video media is priced in.",
                     formula: "CPM = spend / impressions x 1000"),
        GlossaryTerm(term: "CPC", name: "Cost per click", category: "Pricing",
                     definition: "Average cost paid for each click.",
                     formula: "CPC = spend / clicks"),
        GlossaryTerm(term: "CPA", name: "Cost per acquisition", category: "Pricing",
                     definition: "Average cost paid for each conversion. The number most performance buyers optimize to.",
                     formula: "CPA = spend / conversions"),
        GlossaryTerm(term: "CPCV", name: "Cost per completed view", category: "Pricing",
                     definition: "Cost for each fully completed video view. Common in CTV and online video.",
                     formula: "CPCV = spend / completed views"),
        GlossaryTerm(term: "eCPM", name: "Effective CPM", category: "Pricing",
                     definition: "Realized revenue or cost per thousand impressions after the fact, used to compare buys priced on different models.",
                     formula: "eCPM = total cost / impressions x 1000"),
        GlossaryTerm(term: "Take rate", name: "Take rate", category: "Pricing",
                     definition: "The share of spend a platform or exchange keeps as its fee. Stacked take rates are the ad-tech tax.",
                     formula: "working media = spend x (1 - sum of take rates)"),
        GlossaryTerm(term: "Margin", name: "Margin", category: "Pricing",
                     definition: "The share of revenue kept as profit after media and fees.",
                     formula: "margin = (revenue - cost) / revenue"),

        // Performance
        GlossaryTerm(term: "CTR", name: "Click-through rate", category: "Performance",
                     definition: "Share of impressions that result in a click.",
                     formula: "CTR = clicks / impressions"),
        GlossaryTerm(term: "CVR", name: "Conversion rate", category: "Performance",
                     definition: "Share of clicks (or sometimes impressions) that result in a conversion. Check the denominator before comparing.",
                     formula: "CVR = conversions / clicks"),
        GlossaryTerm(term: "ROAS", name: "Return on ad spend", category: "Performance",
                     definition: "Revenue produced per dollar of ad spend. A ratio, not a rate.",
                     formula: "ROAS = revenue / spend"),
        GlossaryTerm(term: "ROI", name: "Return on investment", category: "Performance",
                     definition: "Profit produced per dollar invested, unlike ROAS which uses revenue.",
                     formula: "ROI = (profit) / spend"),
        GlossaryTerm(term: "Lift", name: "Incremental lift", category: "Measurement",
                     definition: "The increase in outcomes caused by the ad, measured against a control group that did not see it.",
                     formula: "lift = (test rate - control rate) / control rate"),

        // Auction
        GlossaryTerm(term: "First-price", name: "First-price auction", category: "Auction",
                     definition: "The winner pays exactly what it bid. The dominant model since around 2019, which makes bid shading necessary.",
                     formula: "you pay = your bid"),
        GlossaryTerm(term: "Second-price", name: "Second-price auction", category: "Auction",
                     definition: "The winner pays the next-highest bid (the clearing price). Bidding true value is optimal here.",
                     formula: "you pay = max(clearing price, floor)"),
        GlossaryTerm(term: "Bid shading", name: "Bid shading", category: "Auction",
                     definition: "Bidding below true value in a first-price auction to preserve margin while still winning enough.",
                     formula: "E[profit] = P_win(bid) x (value - bid)"),
        GlossaryTerm(term: "Floor", name: "Price floor (reserve)", category: "Auction",
                     definition: "The minimum a publisher will accept. A bid below the floor never clears, and in second-price the winner pays at least the floor.",
                     formula: nil),
        GlossaryTerm(term: "Win rate", name: "Win rate", category: "Auction",
                     definition: "Share of auctions entered that you win. Rises with your bid and falls with competition and floors.",
                     formula: "win rate = auctions won / auctions entered"),
        GlossaryTerm(term: "Timeout", name: "Bid timeout", category: "Auction",
                     definition: "The fixed window (often about 100ms) to respond to a bid request. A late response is discarded before the price is read.",
                     formula: nil),

        // Supply
        GlossaryTerm(term: "RTB", name: "Real-time bidding", category: "Supply",
                     definition: "Buying each impression in a live per-impression auction, milliseconds before the ad renders.",
                     formula: nil),
        GlossaryTerm(term: "DSP", name: "Demand-side platform", category: "Supply",
                     definition: "The buyer's system: it evaluates bid requests and bids on impressions on behalf of advertisers.",
                     formula: nil),
        GlossaryTerm(term: "SSP", name: "Supply-side platform", category: "Supply",
                     definition: "The seller's system: it offers a publisher's inventory into exchanges and runs the auction.",
                     formula: nil),
        GlossaryTerm(term: "SPO", name: "Supply path optimization", category: "Supply",
                     definition: "Choosing the shortest, cleanest route to inventory to cut duplicate paths and reduce fees.",
                     formula: nil),
        GlossaryTerm(term: "Header bidding", name: "Header bidding", category: "Supply",
                     definition: "A technique letting multiple exchanges bid on inventory at once before the ad server is called, which broke the old second-price logic.",
                     formula: nil),

        // Measurement and audience
        GlossaryTerm(term: "Viewability", name: "Viewability", category: "Measurement",
                     definition: "Whether an ad had a real chance to be seen. The MRC standard is 50 percent of pixels in view for at least 1 second (2 seconds for video).",
                     formula: nil),
        GlossaryTerm(term: "Frequency", name: "Frequency", category: "Audience",
                     definition: "Average number of times one person sees the ad. Past the first few exposures, extra frequency mostly wastes budget.",
                     formula: "frequency = impressions / reach"),
        GlossaryTerm(term: "Reach", name: "Reach", category: "Audience",
                     definition: "The count of unique people exposed at least once.",
                     formula: "reach = impressions / frequency"),
        GlossaryTerm(term: "MMM", name: "Marketing mix modeling", category: "Measurement",
                     definition: "Regressing total business outcomes against media spend and controls. Needs no user identifier, so it survives privacy loss.",
                     formula: nil),
        GlossaryTerm(term: "Attribution", name: "Attribution", category: "Measurement",
                     definition: "Assigning credit for a conversion across the touchpoints that preceded it, by a chosen rule (last-click, linear, and so on).",
                     formula: nil),
        GlossaryTerm(term: "Adstock", name: "Adstock (carryover)", category: "Measurement",
                     definition: "The idea that advertising effect carries into later periods rather than landing entirely on the day it ran.",
                     formula: nil),
    ]

    /// Distinct categories, in first-seen order, for grouping the lookup.
    public static var categories: [String] {
        var seen = Set<String>()
        var ordered: [String] = []
        for t in all where !seen.contains(t.category) {
            seen.insert(t.category)
            ordered.append(t.category)
        }
        return ordered
    }

    /// Case-insensitive search across the headword, full name, and definition.
    /// An empty query returns every term. Entries whose headword or name match
    /// are ranked ahead of entries that only match in the definition.
    public static func search(_ query: String) -> [GlossaryTerm] {
        let q = query.trimmingCharacters(in: .whitespaces).lowercased()
        guard !q.isEmpty else { return all }
        func headMatch(_ t: GlossaryTerm) -> Bool {
            t.term.lowercased().contains(q) || t.name.lowercased().contains(q)
        }
        func bodyMatch(_ t: GlossaryTerm) -> Bool {
            t.definition.lowercased().contains(q)
        }
        let head = all.filter(headMatch)
        let body = all.filter { !headMatch($0) && bodyMatch($0) }
        return head + body
    }
}
