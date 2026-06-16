import BidLabCore

/// Tests for campaign-export parsing: alias-mapped headers, tolerant number
/// parsing, quoted fields, and blended summary metrics.
func campaignDataTests(_ h: Harness) {
    let csv = """
    Line Item,Imps,Clicks,Conv,Cost,Revenue
    "Prospecting, broad",100000,2000,100,"$1,500.00",5000
    Retargeting,50000,1500,150,900,4500
    """
    let lines = CampaignData.parseCSV(csv)
    h.check("parses two line items", lines.count == 2)
    guard lines.count == 2 else { return }

    let a = lines[0]
    h.check("a quoted name with a comma is preserved", a.name == "Prospecting, broad")
    h.check("alias header 'Imps' maps to impressions", a.impressions == 100000)
    h.close("currency and thousands separators are parsed", a.spend, 1500.0, tol: 1e-6)
    h.close("CTR", a.ctr, 0.02, tol: 1e-9)
    h.close("CVR", a.cvr, 0.05, tol: 1e-9)
    h.close("CPM", a.cpm, 15.0, tol: 1e-9)
    h.close("CPC", a.cpc, 0.75, tol: 1e-9)
    h.close("CPA", a.cpa, 15.0, tol: 1e-9)
    h.close("ROAS", a.roas, 5000.0 / 1500.0, tol: 1e-9)

    let s = CampaignData.summarize(lines)
    h.check("summary counts both lines", s.lineCount == 2)
    h.check("summary sums impressions", s.impressions == 150000)
    h.close("summary sums spend", s.spend, 2400.0, tol: 1e-6)
    h.close("blended CPM", s.cpm, 16.0, tol: 1e-9)
    h.close("blended CPA", s.cpa, 9.6, tol: 1e-9)
    h.close("blended ROAS", s.roas, 9500.0 / 2400.0, tol: 1e-9)

    // Tolerant of a missing revenue column and an extra unknown column.
    let noRev = "name,impressions,clicks,conversions,spend,channel\nA,1000,10,1,50,CTV"
    let nr = CampaignData.parseCSV(noRev)
    h.check("parses without a revenue column", nr.count == 1)
    h.close("missing revenue defaults to zero", nr.first?.revenue ?? -1, 0, tol: 1e-9)
    h.close("CPA without revenue", nr.first?.cpa ?? -1, 50.0, tol: 1e-9)

    // Rows with neither impressions nor spend are skipped.
    let withBlank = "name,impressions,spend\nReal,1000,50\nEmpty,0,0\nAlsoReal,,25"
    h.check("skips rows with no impressions or spend", CampaignData.parseCSV(withBlank).count == 2)

    // Header-only or empty input yields nothing, not a crash.
    h.check("header-only input yields no lines", CampaignData.parseCSV("name,impressions,spend").isEmpty)
    h.check("empty input yields no lines", CampaignData.parseCSV("").isEmpty)

    // Per-line verdicts judge cost efficiency against the campaign blend.
    let efficientLine = CampaignLine(name: "A", impressions: 100_000, clicks: 2_000, conversions: 200, spend: 2_000)  // CPA 10
    let costlyLine = CampaignLine(name: "B", impressions: 100_000, clicks: 1_000, conversions: 20, spend: 2_000)       // CPA 100
    let noConvLine = CampaignLine(name: "C", impressions: 100_000, clicks: 1_000, conversions: 0, spend: 1_000)        // no conversions
    let typicalLine = CampaignLine(name: "D", impressions: 100_000, clicks: 1_000, conversions: 90, spend: 2_000)      // CPA ~22.2
    let blendedCPA = CampaignData.summarize([efficientLine, costlyLine, noConvLine, typicalLine]).cpa
    h.check("a low-CPA line is efficient", CampaignData.verdict(line: efficientLine, blendedCPA: blendedCPA) == .efficient)
    h.check("a high-CPA line is costly", CampaignData.verdict(line: costlyLine, blendedCPA: blendedCPA) == .costly)
    h.check("a near-blend line is typical", CampaignData.verdict(line: typicalLine, blendedCPA: blendedCPA) == .typical)
    h.check("a line with no conversions is flagged", CampaignData.verdict(line: noConvLine, blendedCPA: blendedCPA) == .noConversions)
}
