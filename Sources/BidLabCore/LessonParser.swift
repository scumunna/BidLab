import Foundation

/// Parser for BidLab's original lesson format: a small, deterministic,
/// Markdown-flavored syntax with YAML-style frontmatter and `:::` block
/// directives. Authoring lessons as data keeps all 84 of them fast to write and
/// edit without recompiling, and an original parser avoids any external
/// Markdown dependency (which the swiftc toolchain cannot fetch anyway).
///
/// Format:
/// ```
/// ---
/// id: dsp-02
/// track: dsp
/// module: 2
/// title: Second-price auctions
/// summary: Why truthful bidding wins.
/// ---
/// # A heading
///
/// A paragraph of prose with inline math like $E[X]$.
///
/// $$ E[\pi] = P_{win}(b)(v - price) $$
///
/// :::callout insight
/// Truthful bidding is dominant in a second-price auction.
/// :::
///
/// :::widget auctionSimulator
/// mechanism: second-price
/// :::
///
/// :::quiz
/// question: What should you bid?
/// - Your true value
/// - Half your value
/// answer: 0
/// explain: Truthful bidding is dominant.
/// :::
///
/// :::sources
/// - OpenRTB 2.6 Specification | https://iabtechlab.com/standards/openrtb/
/// :::
/// ```
public enum LessonParser {
    /// Parse lesson text. Returns nil only when there is no frontmatter `id`.
    public static func parse(_ text: String) -> Lesson? {
        var lines = text.components(separatedBy: "\n")
        let meta = extractFrontmatter(&lines)
        guard let id = meta["id"] else { return nil }

        var blocks: [ContentBlock] = []
        var prose: [String] = []

        func flushProse() {
            let joined = prose.joined(separator: " ").trimmingCharacters(in: .whitespaces)
            if !joined.isEmpty { blocks.append(.prose(joined)) }
            prose.removeAll()
        }

        var i = 0
        while i < lines.count {
            let line = lines[i].trimmingCharacters(in: .whitespaces)

            if line.isEmpty {
                flushProse()
                i += 1
            } else if line.hasPrefix("# ") {
                flushProse()
                blocks.append(.heading(String(line.dropFirst(2)).trimmingCharacters(in: .whitespaces)))
                i += 1
            } else if line.hasPrefix("$$"), line.hasSuffix("$$"), line.count > 4 {
                flushProse()
                blocks.append(.math(String(line.dropFirst(2).dropLast(2)).trimmingCharacters(in: .whitespaces)))
                i += 1
            } else if line.hasPrefix("```") {
                flushProse()
                if line.count > 6, line.hasSuffix("```") {
                    // single-line fence: ```code```
                    blocks.append(.code(String(line.dropFirst(3).dropLast(3)).trimmingCharacters(in: .whitespaces)))
                    i += 1
                } else {
                    // multi-line fence (with optional language hint on the opening line)
                    var codeLines: [String] = []
                    i += 1
                    while i < lines.count, !lines[i].trimmingCharacters(in: .whitespaces).hasPrefix("```") {
                        codeLines.append(lines[i])
                        i += 1
                    }
                    if i < lines.count { i += 1 } // consume closing fence
                    blocks.append(.code(codeLines.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)))
                }
            } else if line == "$$" {
                flushProse()
                var math: [String] = []
                i += 1
                while i < lines.count, lines[i].trimmingCharacters(in: .whitespaces) != "$$" {
                    math.append(lines[i])
                    i += 1
                }
                i += 1 // consume closing $$
                blocks.append(.math(math.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)))
            } else if line.hasPrefix(":::") {
                flushProse()
                let header = String(line.dropFirst(3)).trimmingCharacters(in: .whitespaces)
                let parts = header.split(separator: " ", maxSplits: 1).map(String.init)
                let directive = parts.first ?? ""
                let arg = parts.count > 1 ? parts[1] : ""
                var body: [String] = []
                i += 1
                while i < lines.count, lines[i].trimmingCharacters(in: .whitespaces) != ":::" {
                    body.append(lines[i])
                    i += 1
                }
                i += 1 // consume closing :::
                blocks.append(makeDirectiveBlock(directive: directive, arg: arg, body: body))
            } else {
                prose.append(line)
                i += 1
            }
        }
        flushProse()

        return Lesson(
            id: id,
            track: meta["track"] ?? "",
            module: Int(meta["module"] ?? "") ?? 0,
            title: meta["title"] ?? "",
            summary: meta["summary"] ?? "",
            blocks: blocks
        )
    }

    // MARK: - Helpers

    private static func extractFrontmatter(_ lines: inout [String]) -> [String: String] {
        var meta: [String: String] = [:]
        guard lines.first?.trimmingCharacters(in: .whitespaces) == "---" else { return meta }
        lines.removeFirst()
        while let first = lines.first, first.trimmingCharacters(in: .whitespaces) != "---" {
            lines.removeFirst()
            if let pair = keyValue(first) { meta[pair.0] = pair.1 }
        }
        if !lines.isEmpty { lines.removeFirst() } // consume closing ---
        return meta
    }

    private static func keyValue(_ line: String) -> (String, String)? {
        guard let idx = line.firstIndex(of: ":") else { return nil }
        let key = String(line[..<idx]).trimmingCharacters(in: .whitespaces)
        let value = String(line[line.index(after: idx)...]).trimmingCharacters(in: .whitespaces)
        return key.isEmpty ? nil : (key, value)
    }

    private static func makeDirectiveBlock(directive: String, arg: String, body: [String]) -> ContentBlock {
        switch directive {
        case "callout":
            let text = body.map { $0.trimmingCharacters(in: .whitespaces) }
                .joined(separator: " ")
                .trimmingCharacters(in: .whitespaces)
            return .callout(kind: arg.isEmpty ? "note" : arg, text: text)
        case "widget":
            var params: [String: String] = [:]
            for line in body {
                if let pair = keyValue(line) { params[pair.0] = pair.1 }
            }
            return .widget(type: arg, params: params)
        case "quiz":
            return .quiz(parseQuiz(body))
        case "predict":
            return .predict(parsePrediction(body))
        case "figure":
            let caption = body.compactMap { line -> String? in
                let t = line.trimmingCharacters(in: .whitespaces)
                return t.hasPrefix("caption:") ? String(t.dropFirst("caption:".count)).trimmingCharacters(in: .whitespaces) : nil
            }.first ?? ""
            return .figure(name: arg.trimmingCharacters(in: .whitespaces), caption: caption)
        case "sources":
            return .sources(parseSources(body))
        default:
            let text = body.joined(separator: " ").trimmingCharacters(in: .whitespaces)
            return .prose(text)
        }
    }

    private static func parseQuiz(_ body: [String]) -> QuizQuestion {
        var question = ""
        var options: [String] = []
        var answerIndex = 0
        var explanation = ""
        var hints: [String] = []
        for line in body {
            let t = line.trimmingCharacters(in: .whitespaces)
            if t.hasPrefix("question:") {
                question = String(t.dropFirst("question:".count)).trimmingCharacters(in: .whitespaces)
            } else if t.hasPrefix("hint:") {
                let hint = String(t.dropFirst("hint:".count)).trimmingCharacters(in: .whitespaces)
                if !hint.isEmpty { hints.append(hint) }
            } else if t.hasPrefix("- ") {
                options.append(String(t.dropFirst(2)).trimmingCharacters(in: .whitespaces))
            } else if t.hasPrefix("answer:") {
                answerIndex = Int(String(t.dropFirst("answer:".count)).trimmingCharacters(in: .whitespaces)) ?? 0
            } else if t.hasPrefix("explain:") {
                explanation = String(t.dropFirst("explain:".count)).trimmingCharacters(in: .whitespaces)
            }
        }
        return QuizQuestion(question: question, options: options, answerIndex: answerIndex, explanation: explanation, hints: hints)
    }

    private static func parsePrediction(_ body: [String]) -> Prediction {
        var prompt = ""
        var answer = 0.0
        var tolerance = 0.0
        var unit = ""
        var hints: [String] = []
        var explanation = ""
        for line in body {
            let t = line.trimmingCharacters(in: .whitespaces)
            if t.hasPrefix("prompt:") {
                prompt = String(t.dropFirst("prompt:".count)).trimmingCharacters(in: .whitespaces)
            } else if t.hasPrefix("answer:") {
                answer = Double(String(t.dropFirst("answer:".count)).trimmingCharacters(in: .whitespaces)) ?? 0
            } else if t.hasPrefix("tolerance:") {
                tolerance = Double(String(t.dropFirst("tolerance:".count)).trimmingCharacters(in: .whitespaces)) ?? 0
            } else if t.hasPrefix("unit:") {
                unit = String(t.dropFirst("unit:".count)).trimmingCharacters(in: .whitespaces)
            } else if t.hasPrefix("hint:") {
                let hint = String(t.dropFirst("hint:".count)).trimmingCharacters(in: .whitespaces)
                if !hint.isEmpty { hints.append(hint) }
            } else if t.hasPrefix("explain:") {
                explanation = String(t.dropFirst("explain:".count)).trimmingCharacters(in: .whitespaces)
            }
        }
        return Prediction(prompt: prompt, answer: answer, tolerance: tolerance, unit: unit, hints: hints, explanation: explanation)
    }

    private static func parseSources(_ body: [String]) -> [Source] {
        var sources: [Source] = []
        for line in body {
            let t = line.trimmingCharacters(in: .whitespaces)
            guard t.hasPrefix("-") else { continue }
            let rest = String(t.dropFirst()).trimmingCharacters(in: .whitespaces)
            let comps = rest.components(separatedBy: "|").map { $0.trimmingCharacters(in: .whitespaces) }
            if comps.count >= 2 {
                sources.append(Source(title: comps[0], url: comps[1]))
            } else if let only = comps.first, !only.isEmpty {
                sources.append(Source(title: only, url: ""))
            }
        }
        return sources
    }
}
