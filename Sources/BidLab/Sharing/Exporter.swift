import AppKit
import SwiftUI

/// Renders SwiftUI views to branded PNGs and writes data to CSV/JSON, saved under
/// ~/Downloads/BidLab and revealed in Finder. This powers the shareable
/// certificate (the viral loop) and the data export (the credibility flex).
enum Exporter {
    static var outputDirectory: URL {
        let downloads = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        // "BidLab Exports" (not "BidLab") to avoid colliding with the project
        // directory on case-insensitive filesystems.
        let dir = downloads.appendingPathComponent("BidLab Exports", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }

    @MainActor
    @discardableResult
    static func savePNG(_ view: some View, name: String) -> URL? {
        let renderer = ImageRenderer(content: view)
        renderer.scale = 2
        guard let nsImage = renderer.nsImage,
              let tiff = nsImage.tiffRepresentation,
              let rep = NSBitmapImageRep(data: tiff),
              let png = rep.representation(using: .png, properties: [:]) else { return nil }
        let url = outputDirectory.appendingPathComponent("\(name).png")
        try? png.write(to: url)
        NSWorkspace.shared.activateFileViewerSelecting([url])
        return url
    }

    @discardableResult
    static func saveText(_ text: String, name: String, ext: String) -> URL? {
        let url = outputDirectory.appendingPathComponent("\(name).\(ext)")
        do {
            try text.write(to: url, atomically: true, encoding: .utf8)
            NSWorkspace.shared.activateFileViewerSelecting([url])
            return url
        } catch {
            return nil
        }
    }
}
