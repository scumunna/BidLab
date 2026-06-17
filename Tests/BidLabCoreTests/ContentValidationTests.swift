import BidLabCore
import Foundation

/// Validates every authored lesson file under Content/Lessons. The directory is
/// passed in via the BIDLAB_CONTENT environment variable (set by test.sh). This
/// catches malformed frontmatter, id/filename drift, and unknown widget types
/// across every authored lesson as the corpus grows.
func contentValidationTests(_ h: Harness) {
    let knownWidgets: Set<String> = [
        "auctionSimulator", "auctionPlayground", "bidPlayground",
        "reachFrequency", "reachPlanner",
        "experimentPower", "powerCalculator", "abTest",
        "budgetAllocator", "marginModeler", "pricingCalculator",
        "latencySimulator", "throughputSimulator", "pacingController",
        "distributionExplorer", "adstockExplorer", "saturationExplorer",
        "attributionComparison", "funnelExplorer", "responseCurve",
        "monteCarlo", "forecastExplorer", "sqlLab", "codeLab",
        "didExplorer", "yieldExplorer",
        "barChart", "lineChart", "donutChart",
    ]

    guard let dirPath = ProcessInfo.processInfo.environment["BIDLAB_CONTENT"] else {
        h.check("BIDLAB_CONTENT env set", false)
        return
    }
    let dir = URL(fileURLWithPath: dirPath)
    guard let files = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil) else {
        h.check("content directory readable", false)
        return
    }
    let mdFiles = files.filter { $0.pathExtension == "md" }.sorted { $0.lastPathComponent < $1.lastPathComponent }
    h.check("at least 3 lessons authored", mdFiles.count >= 3)

    for file in mdFiles {
        let name = file.lastPathComponent
        guard let text = try? String(contentsOf: file, encoding: .utf8) else {
            h.check("\(name): readable", false); continue
        }
        guard let lesson = LessonParser.parse(text) else {
            h.check("\(name): parses", false); continue
        }
        h.check("\(name): id matches filename", file.deletingPathExtension().lastPathComponent == lesson.id)
        h.check("\(name): has title", !lesson.title.isEmpty)
        h.check("\(name): has track", !lesson.track.isEmpty)
        h.check("\(name): module > 0", lesson.module > 0)
        h.check("\(name): has content blocks", !lesson.blocks.isEmpty)
        for block in lesson.blocks {
            if case let .widget(type, _) = block {
                h.check("\(name): widget '\(type)' is known", knownWidgets.contains(type))
            }
            if case let .figure(figureName, _) = block {
                h.check("\(name): figure '\(figureName)' is known", Figures.known.contains(figureName))
            }
        }

        // Every heading-led section must carry an interactive or visual block,
        // so no slide is plain text.
        var groups: [[ContentBlock]] = []
        var current: [ContentBlock] = []
        for block in lesson.blocks {
            if case .heading = block {
                if !current.isEmpty { groups.append(current) }
                current = [block]
            } else {
                current.append(block)
            }
        }
        if !current.isEmpty { groups.append(current) }
        for group in groups {
            let heading: String = {
                if case let .heading(text)? = group.first { return text }
                return "intro"
            }()
            let interactive = group.contains { block in
                switch block {
                case .widget, .quiz, .predict, .figure: return true
                default: return false
                }
            }
            h.check("\(name): section '\(heading)' is interactive", interactive)
        }
    }
}
