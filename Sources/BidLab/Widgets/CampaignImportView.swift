import BidLabCore
import SwiftUI

/// Bring your own campaign: import a real campaign-export CSV and see your line
/// items and blended metrics computed by the same engine the lessons use, so
/// the Tools run on your numbers instead of demo data.
struct CampaignImportView: View {
    @Local private var lines: [CampaignLine] = []

    var body: some View {
        WidgetShell("Bring your campaign", icon: "tray.and.arrow.down", accent: Brand.dsp,
                    note: lines.isEmpty ? nil : "\(lines.count) line items") {
            VStack(alignment: .leading, spacing: 14) {
                controls
                if lines.isEmpty {
                    emptyState
                } else {
                    summary
                    table
                }
            }
        }
    }

    private var controls: some View {
        HStack(spacing: 10) {
            Button(action: importCampaign) {
                HStack(spacing: 6) {
                    Image(systemName: "tray.and.arrow.down").font(.system(size: 12, weight: .bold))
                    Text("Import campaign CSV").font(.brandRounded(13, .semibold))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 14).padding(.vertical, 9)
                .background(Brand.dsp, in: Capsule())
            }
            .buttonStyle(.plain)
            if !lines.isEmpty {
                Button { lines = [] } label: {
                    Text("Clear").font(.brandRounded(13, .semibold)).foregroundStyle(Brand.muted)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var emptyState: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Load a campaign export to compute CTR, CVR, CPM, CPC, CPA, and ROAS on your real numbers, not demo sliders.")
                .font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted).fixedSize(horizontal: false, vertical: true)
            Text("Columns in any order, common aliases fine: line item, impressions, clicks, conversions, spend, revenue.")
                .font(.brandMono(11, .regular)).foregroundStyle(Brand.faint).fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.dsp.opacity(0.06), in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
    }

    private var summary: some View {
        let s = CampaignData.summarize(lines)
        return VStack(alignment: .leading, spacing: 10) {
            Text("BLENDED").font(.brandMono(10, .semibold)).foregroundStyle(Brand.faint).tracking(0.5)
            HStack(spacing: 10) {
                stat("Spend", money(s.spend, 0))
                stat("Impr", intc(s.impressions))
                stat("CPM", money(s.cpm, 2))
                stat("CTR", pct(s.ctr))
            }
            HStack(spacing: 10) {
                stat("CPC", money(s.cpc, 2))
                stat("CVR", pct(s.cvr))
                stat("CPA", s.conversions > 0 ? money(s.cpa, 2) : "—")
                stat("ROAS", s.revenue > 0 ? String(format: "%.2fx", s.roas) : "—")
            }
        }
    }

    private var table: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                Text("Line item").font(.brandMono(10, .semibold)).foregroundStyle(Brand.faint).frame(maxWidth: .infinity, alignment: .leading)
                Text("CPM").font(.brandMono(10, .semibold)).foregroundStyle(Brand.faint).frame(width: 56, alignment: .trailing)
                Text("CTR").font(.brandMono(10, .semibold)).foregroundStyle(Brand.faint).frame(width: 52, alignment: .trailing)
                Text("CPA").font(.brandMono(10, .semibold)).foregroundStyle(Brand.faint).frame(width: 62, alignment: .trailing)
            }
            .padding(.horizontal, 10)
            ForEach(Array(lines.enumerated()), id: \.offset) { _, line in
                HStack(spacing: 8) {
                    Text(line.name).font(.brandRounded(12.5, .medium)).foregroundStyle(Brand.ink).lineLimit(1).frame(maxWidth: .infinity, alignment: .leading)
                    Text(money(line.cpm, 2)).font(.brandMono(11, .regular)).foregroundStyle(Brand.muted).frame(width: 56, alignment: .trailing)
                    Text(pct(line.ctr)).font(.brandMono(11, .regular)).foregroundStyle(Brand.muted).frame(width: 52, alignment: .trailing)
                    Text(line.conversions > 0 ? money(line.cpa, 2) : "—").font(.brandMono(11, .regular)).foregroundStyle(Brand.muted).frame(width: 62, alignment: .trailing)
                }
                .padding(.vertical, 7).padding(.horizontal, 10)
                .background(Brand.canvas, in: RoundedRectangle(cornerRadius: Metric.radiusSm, style: .continuous))
            }
        }
    }

    private func stat(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label).font(.brandMono(10, .regular)).foregroundStyle(Brand.faint)
            Text(value).font(.brandMono(14, .bold)).foregroundStyle(Brand.ink)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func importCampaign() {
        let files = Importer.openCampaign()
        guard !files.isEmpty else { return }
        lines = files.flatMap { CampaignData.parseCSV($0) }
    }

    private func money(_ x: Double, _ digits: Int) -> String { String(format: "$%.\(digits)f", x) }
    private func pct(_ x: Double) -> String { String(format: "%.2f%%", x * 100) }
    private func intc(_ x: Int) -> String { x.formatted() }
}
