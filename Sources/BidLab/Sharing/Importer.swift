import AppKit
import UniformTypeIdentifiers

/// Reads files the learner or manager chooses. Used by the team roll-up to
/// ingest exported transcript CSVs from a folder, entirely on this device.
enum Importer {
    /// Present an open panel for one or more CSV/text transcripts and return
    /// their contents. Returns an empty array if the user cancels.
    static func openTranscripts() -> [String] {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.commaSeparatedText, .plainText]
        panel.message = "Choose one or more learner transcript files (CSV) to build a team roster."
        panel.prompt = "Import"
        guard panel.runModal() == .OK else { return [] }
        return panel.urls.compactMap { try? String(contentsOf: $0, encoding: .utf8) }
    }

    /// Present an open panel for a campaign-export CSV (line items) and return
    /// the file contents, so the Tools models can run on real numbers.
    static func openCampaign() -> [String] {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.commaSeparatedText, .plainText]
        panel.message = "Choose a campaign export (CSV) to load your real numbers into the models."
        panel.prompt = "Import"
        guard panel.runModal() == .OK else { return [] }
        return panel.urls.compactMap { try? String(contentsOf: $0, encoding: .utf8) }
    }
}
