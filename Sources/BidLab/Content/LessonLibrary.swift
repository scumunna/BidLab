import BidLabCore
import Foundation

/// Loads authored lessons from `Lessons/*.md` bundled in the app's Resources at
/// launch and parses them with `LessonParser`. Lesson ids follow the convention
/// `{track}-{NN}` (for example `dsp-02`), so a module lights up the moment its
/// file ships, with no code change.
enum LessonLibrary {
    static let all: [Lesson] = loadAll()

    private static let byID: [String: Lesson] = all.reduce(into: [:]) { $0[$1.id] = $1 }

    static func lesson(id: String) -> Lesson? { byID[id] }

    static let sampleLessonID = "dsp-02"

    private static func loadAll() -> [Lesson] {
        guard let resourceURL = Bundle.main.resourceURL else { return [] }
        let dir = resourceURL.appendingPathComponent("Lessons", isDirectory: true)
        guard let files = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil) else {
            return []
        }
        let lessons = files
            .filter { $0.pathExtension == "md" }
            .compactMap { try? String(contentsOf: $0, encoding: .utf8) }
            .compactMap { LessonParser.parse($0) }
        return lessons.sorted { $0.track == $1.track ? $0.module < $1.module : $0.track < $1.track }
    }
}
