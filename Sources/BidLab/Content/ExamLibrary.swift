import BidLabCore
import Foundation

/// Loads certification exams from `Exams/*.md` bundled in the app's Resources.
/// One file per track (for example `Exams/core.md`); an exam appears the moment
/// its file ships, no code change required.
enum ExamLibrary {
    static let all: [Exam] = loadAll()

    private static let byTrack: [String: Exam] = all.reduce(into: [:]) { $0[$1.track] = $1 }

    static func exam(track: String) -> Exam? { byTrack[track] }

    private static func loadAll() -> [Exam] {
        guard let resourceURL = Bundle.main.resourceURL else { return [] }
        let dir = resourceURL.appendingPathComponent("Exams", isDirectory: true)
        guard let files = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil) else {
            return []
        }
        return files
            .filter { $0.pathExtension == "md" }
            .compactMap { try? String(contentsOf: $0, encoding: .utf8) }
            .compactMap { ExamParser.parse($0) }
    }
}
