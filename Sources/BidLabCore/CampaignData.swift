import Foundation

/// One line item from an imported campaign export, with the standard derived
/// metrics. This powers "bring your own campaign": the Tools models run on a
/// trader's real numbers instead of demo sliders, which was the single loudest
/// piece of desk feedback.
public struct CampaignLine: Equatable {
    public let name: String
    public let impressions: Int
    public let clicks: Int
    public let conversions: Int
    public let spend: Double
    public let revenue: Double

    public init(name: String, impressions: Int, clicks: Int, conversions: Int,
                spend: Double, revenue: Double = 0) {
        self.name = name
        self.impressions = impressions
        self.clicks = clicks
        self.conversions = conversions
        self.spend = spend
        self.revenue = revenue
    }

    /// Click-through rate: clicks / impressions.
    public var ctr: Double { impressions > 0 ? Double(clicks) / Double(impressions) : 0 }
    /// Conversion rate: conversions / clicks.
    public var cvr: Double { clicks > 0 ? Double(conversions) / Double(clicks) : 0 }
    /// Cost per mille (thousand impressions).
    public var cpm: Double { impressions > 0 ? spend / Double(impressions) * 1000 : 0 }
    /// Cost per click.
    public var cpc: Double { clicks > 0 ? spend / Double(clicks) : 0 }
    /// Cost per acquisition.
    public var cpa: Double { conversions > 0 ? spend / Double(conversions) : 0 }
    /// Return on ad spend: revenue / spend.
    public var roas: Double { spend > 0 ? revenue / spend : 0 }
}

/// Blended totals across an imported campaign, for the summary row and for
/// seeding a tool with realistic numbers.
public struct CampaignSummary: Equatable {
    public let lineCount: Int
    public let impressions: Int
    public let clicks: Int
    public let conversions: Int
    public let spend: Double
    public let revenue: Double

    public init(lineCount: Int, impressions: Int, clicks: Int, conversions: Int, spend: Double, revenue: Double) {
        self.lineCount = lineCount
        self.impressions = impressions
        self.clicks = clicks
        self.conversions = conversions
        self.spend = spend
        self.revenue = revenue
    }

    public var ctr: Double { impressions > 0 ? Double(clicks) / Double(impressions) : 0 }
    public var cvr: Double { clicks > 0 ? Double(conversions) / Double(clicks) : 0 }
    public var cpm: Double { impressions > 0 ? spend / Double(impressions) * 1000 : 0 }
    public var cpc: Double { clicks > 0 ? spend / Double(clicks) : 0 }
    public var cpa: Double { conversions > 0 ? spend / Double(conversions) : 0 }
    public var roas: Double { spend > 0 ? revenue / spend : 0 }
}

public enum CampaignData {
    // Accepted header aliases, lowercased. A real export rarely uses our exact
    // names, so we map common ad-server column labels onto our fields.
    private static let aliases: [String: [String]] = [
        "name":        ["line_item", "line item", "lineitem", "name", "campaign", "placement", "ad_group", "ad group"],
        "impressions": ["impressions", "impression", "imps", "impr", "imp"],
        "clicks":      ["clicks", "click"],
        "conversions": ["conversions", "conversion", "conv", "convs", "actions"],
        "spend":       ["spend", "cost", "media_cost", "media cost", "amount_spent", "amount spent"],
        "revenue":     ["revenue", "rev", "sales", "conversion_value", "conversion value"],
    ]

    /// Parse a campaign-export CSV into line items. The first non-empty row is
    /// the header; columns are matched by alias, so order does not matter and
    /// extra columns are ignored. Rows with neither impressions nor spend are
    /// skipped. Numbers tolerate `$`, thousands commas, and `%`.
    public static func parseCSV(_ csv: String) -> [CampaignLine] {
        let rows = csv
            .components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        guard rows.count >= 2 else { return [] }

        let header = splitRow(rows[0]).map { $0.lowercased().trimmingCharacters(in: .whitespaces) }
        func columnIndex(_ field: String) -> Int? {
            guard let names = aliases[field] else { return nil }
            return header.firstIndex { names.contains($0) }
        }
        let nameCol = columnIndex("name")
        let impCol = columnIndex("impressions")
        let clickCol = columnIndex("clicks")
        let convCol = columnIndex("conversions")
        let spendCol = columnIndex("spend")
        let revCol = columnIndex("revenue")

        var lines: [CampaignLine] = []
        for (i, row) in rows.dropFirst().enumerated() {
            let cells = splitRow(row)
            func cell(_ idx: Int?) -> String { (idx.flatMap { $0 < cells.count ? cells[$0] : nil }) ?? "" }
            let impressions = Int(parseNumber(cell(impCol)).rounded())
            let spend = parseNumber(cell(spendCol))
            // A data row needs at least impressions or spend to be meaningful.
            guard impressions > 0 || spend > 0 else { continue }
            let rawName = cell(nameCol).trimmingCharacters(in: .whitespaces)
            lines.append(CampaignLine(
                name: rawName.isEmpty ? "Line \(i + 1)" : rawName,
                impressions: impressions,
                clicks: Int(parseNumber(cell(clickCol)).rounded()),
                conversions: Int(parseNumber(cell(convCol)).rounded()),
                spend: spend,
                revenue: parseNumber(cell(revCol))
            ))
        }
        return lines
    }

    /// Sum line items into blended totals.
    public static func summarize(_ lines: [CampaignLine]) -> CampaignSummary {
        CampaignSummary(
            lineCount: lines.count,
            impressions: lines.reduce(0) { $0 + $1.impressions },
            clicks: lines.reduce(0) { $0 + $1.clicks },
            conversions: lines.reduce(0) { $0 + $1.conversions },
            spend: lines.reduce(0) { $0 + $1.spend },
            revenue: lines.reduce(0) { $0 + $1.revenue }
        )
    }

    // MARK: Helpers

    /// Split one CSV row, honoring simple double-quoted fields so a quoted name
    /// containing a comma does not split.
    private static func splitRow(_ row: String) -> [String] {
        var fields: [String] = []
        var current = ""
        var inQuotes = false
        for ch in row {
            if ch == "\"" {
                inQuotes.toggle()
            } else if ch == "," && !inQuotes {
                fields.append(current)
                current = ""
            } else {
                current.append(ch)
            }
        }
        fields.append(current)
        return fields.map { $0.trimmingCharacters(in: .whitespaces) }
    }

    /// Parse a numeric cell, stripping `$`, thousands commas, `%`, and spaces.
    private static func parseNumber(_ raw: String) -> Double {
        let cleaned = raw
            .replacingOccurrences(of: "$", with: "")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "%", with: "")
            .replacingOccurrences(of: "\"", with: "")
            .trimmingCharacters(in: .whitespaces)
        return Double(cleaned) ?? 0
    }
}
