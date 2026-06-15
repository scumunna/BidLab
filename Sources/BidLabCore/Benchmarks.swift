import Foundation

/// A citation backing a benchmark figure. `verified` is false for numbers that
/// come from aggregators or vary by methodology, so the UI can label them as
/// directional rather than asserting them as fact.
public struct Citation: Equatable, Codable, Hashable {
    public let source: String
    public let url: String
    public let year: Int
    public let verified: Bool
    public let note: String?

    public init(source: String, url: String, year: Int, verified: Bool = true, note: String? = nil) {
        self.source = source
        self.url = url
        self.year = year
        self.verified = verified
        self.note = note
    }
}

/// One real-world benchmark figure with its source. Display value is pre-formatted.
public struct Benchmark: Equatable, Identifiable {
    public let key: String
    public let category: String
    public let label: String
    public let value: String
    public let detail: String
    public let citation: Citation

    public var id: String { key }

    public init(key: String, category: String, label: String, value: String, detail: String, citation: Citation) {
        self.key = key
        self.category = category
        self.label = label
        self.value = value
        self.detail = detail
        self.citation = citation
    }
}

/// A small catalog of current, cited programmatic benchmarks. These ground the
/// simulators' defaults and the course's claims in named sources rather than
/// invented numbers. The strongest, most-citable figures are marked verified;
/// soft aggregator ranges (CPMs and the like) are marked directional.
public enum Benchmarks {
    public static let catalog: [Benchmark] = [
        // Viewability and quality (MRC standard, measured by DV and IAS).
        Benchmark(key: "view_display", category: "Viewability & quality",
                  label: "Display viewability", value: "71%",
                  detail: "North American authentic viewability, up about 3 points year over year.",
                  citation: Citation(source: "DoubleVerify Global Insights", url: "https://doubleverify.com/global-insights-2025-reports/", year: 2025)),
        Benchmark(key: "view_video", category: "Viewability & quality",
                  label: "Video viewability", value: "78.6%",
                  detail: "In-stream runs higher (about 83%) than out-stream (about 68%).",
                  citation: Citation(source: "DoubleVerify Global Insights", url: "https://doubleverify.com/global-insights-2025-reports/", year: 2025)),
        Benchmark(key: "view_ctv", category: "Viewability & quality",
                  label: "CTV viewability", value: "93%",
                  detail: "Near total, by the full-screen nature of the format.",
                  citation: Citation(source: "Integral Ad Science", url: "https://www.integralads.com/", year: 2025)),
        Benchmark(key: "fraud_yoy", category: "Viewability & quality",
                  label: "Bot fraud growth", value: "+101%",
                  detail: "Year-over-year rise in sophisticated invalid traffic in North America.",
                  citation: Citation(source: "DoubleVerify Global Insights", url: "https://doubleverify.com/global-insights-2025-reports/", year: 2025)),

        // The supply chain (the ad-tech tax).
        Benchmark(key: "tax_publisher", category: "Supply chain",
                  label: "Reaches the publisher", value: "65%",
                  detail: "Share of advertiser spend that reached media owners, up from 51% in 2020.",
                  citation: Citation(source: "ISBA / PwC Programmatic Supply Chain study", url: "https://www.isba.org.uk/", year: 2022)),
        Benchmark(key: "tax_working", category: "Supply chain",
                  label: "Working media", value: "~36¢",
                  detail: "Of every open-programmatic dollar, the share reaching the consumer as media.",
                  citation: Citation(source: "ANA Programmatic Media Supply Chain study", url: "https://www.ana.net/", year: 2023, verified: true, note: "2023 is the latest published figure.")),
        Benchmark(key: "bid_shading", category: "Supply chain",
                  label: "Bid-shading savings", value: "~20%",
                  detail: "Typical reduction in winning CPM, at under a 1% win-rate trade-off.",
                  citation: Citation(source: "Magnite / AdExchanger", url: "https://www.adexchanger.com/", year: 2024)),

        // Market size and shape.
        Benchmark(key: "mkt_global", category: "Market",
                  label: "Global ad revenue", value: "$1.14T",
                  detail: "Total worldwide advertising revenue, grew about 9%.",
                  citation: Citation(source: "WPP Media (This Year Next Year)", url: "https://www.wpp.com/", year: 2025)),
        Benchmark(key: "mkt_retail", category: "Market",
                  label: "US retail media", value: "$71.1B",
                  detail: "2026 forecast, up about 18% and one of the fastest-growing channels.",
                  citation: Citation(source: "EMARKETER", url: "https://www.emarketer.com/", year: 2026)),
        Benchmark(key: "mkt_ctv", category: "Market",
                  label: "US CTV ad spend", value: "$38B",
                  detail: "2026 forecast, growing in the mid-teens annually.",
                  citation: Citation(source: "EMARKETER", url: "https://www.emarketer.com/", year: 2026)),
        Benchmark(key: "mkt_prog_share", category: "Market",
                  label: "Programmatic share of display", value: "~88%",
                  detail: "Most digital display now transacts programmatically.",
                  citation: Citation(source: "GroupM / WARC", url: "https://www.warc.com/", year: 2025, verified: false, note: "Definitions vary; use as a range of roughly 85 to 90%.")),
        Benchmark(key: "mkt_ctv_gap", category: "Market",
                  label: "CTV time vs spend", value: "20% / 8%",
                  detail: "CTV is about 20% of media time but under 8% of ad spend. A pricing gap.",
                  citation: Citation(source: "EMARKETER", url: "https://www.emarketer.com/", year: 2025)),

        // Measurement.
        Benchmark(key: "meas_mmm", category: "Measurement",
                  label: "MMM adoption", value: "53.5%",
                  detail: "Share of US marketers using marketing mix modeling, rising because it is privacy-safe.",
                  citation: Citation(source: "EMARKETER x Snap", url: "https://www.emarketer.com/", year: 2024)),
        Benchmark(key: "meas_dissat", category: "Measurement",
                  label: "Measurement gap", value: "75%",
                  detail: "Share of buy-side leaders who say core measurement underperforms.",
                  citation: Citation(source: "IAB State of Data", url: "https://www.iab.com/", year: 2026)),

        // Privacy (the 2026 reality).
        Benchmark(key: "priv_cookies", category: "Privacy",
                  label: "Third-party cookies in Chrome", value: "Still on",
                  detail: "Google cancelled deprecation in 2025 and shut down Privacy Sandbox in October 2025.",
                  citation: Citation(source: "Google Privacy Sandbox", url: "https://privacysandbox.google.com/", year: 2025)),
        Benchmark(key: "priv_att", category: "Privacy",
                  label: "iOS tracking consent", value: "~50%",
                  detail: "Global App Tracking Transparency opt-in. ATT, not cookies, is the real signal-loss driver.",
                  citation: Citation(source: "AppsFlyer", url: "https://www.appsflyer.com/", year: 2025, verified: false, note: "Opt-in varies widely by app category and methodology.")),

        // Soft, editable defaults (directional ranges, not facts).
        Benchmark(key: "cpm_display", category: "Typical CPMs (directional)",
                  label: "Display CPM", value: "$1.50 to $4",
                  detail: "Open-web ranges vary by quality and deal type. Treat as an editable default.",
                  citation: Citation(source: "Aggregated benchmark reports", url: "", year: 2025, verified: false)),
        Benchmark(key: "cpm_ctv", category: "Typical CPMs (directional)",
                  label: "CTV CPM", value: "$25 to $45",
                  detail: "Premium streaming inventory. Treat as an editable default.",
                  citation: Citation(source: "Aggregated benchmark reports", url: "", year: 2025, verified: false)),
    ]

    /// Categories in catalog order, de-duplicated.
    public static var categories: [String] {
        var seen = Set<String>()
        return catalog.compactMap { seen.insert($0.category).inserted ? $0.category : nil }
    }

    public static func inCategory(_ name: String) -> [Benchmark] {
        catalog.filter { $0.category == name }
    }
}
