import Foundation

/// One certification-exam question. Single best answer, scenario style, tagged
/// with the domain it assesses so results can be broken down per domain (the way
/// the IAB DBPC reports a diagnostic). Questions are original to BidLab.
public struct ExamQuestion: Equatable, Identifiable {
    public let id: String
    public let domain: String
    public let question: String
    public let options: [String]
    public let answerIndex: Int
    public let explanation: String

    public init(id: String, domain: String, question: String, options: [String], answerIndex: Int, explanation: String) {
        self.id = id
        self.domain = domain
        self.question = question
        self.options = options
        self.answerIndex = answerIndex
        self.explanation = explanation
    }
}

/// A per-track certification exam: a bank of questions plus the pass threshold.
public struct Exam: Equatable {
    public let track: String
    public let title: String
    public let passMark: Double   // fraction, e.g. 0.7
    public let questions: [ExamQuestion]   // the full bank
    public let draw: Int          // questions to present per attempt; 0 means all

    public init(track: String, title: String, passMark: Double, questions: [ExamQuestion], draw: Int = 0) {
        self.track = track
        self.title = title
        self.passMark = passMark
        self.questions = questions
        self.draw = draw
    }

    /// How many questions an attempt presents: the draw if set and smaller than
    /// the bank, otherwise the whole bank.
    public var presentedCount: Int {
        draw > 0 ? min(draw, questions.count) : questions.count
    }

    /// Domains in first-seen order.
    public var domains: [String] {
        var seen = Set<String>()
        return questions.compactMap { seen.insert($0.domain).inserted ? $0.domain : nil }
    }
}

/// The outcome of grading an attempt.
public struct ExamResult: Equatable {
    public let correct: Int
    public let total: Int
    public let byDomain: [String: DomainScore]

    public init(correct: Int, total: Int, byDomain: [String: DomainScore]) {
        self.correct = correct
        self.total = total
        self.byDomain = byDomain
    }

    public struct DomainScore: Equatable {
        public let correct: Int
        public let total: Int
        public init(correct: Int, total: Int) { self.correct = correct; self.total = total }
        public var fraction: Double { total > 0 ? Double(correct) / Double(total) : 0 }
    }

    public var fraction: Double { total > 0 ? Double(correct) / Double(total) : 0 }
    public func passed(_ passMark: Double) -> Bool { fraction >= passMark }
}

public enum ExamScoring {
    /// Grade an attempt. `answers[i]` is the selected option index for question i,
    /// or nil if unanswered (counted wrong). Produces an overall score and a
    /// per-domain breakdown for the diagnostic.
    public static func score(_ exam: Exam, answers: [Int?]) -> ExamResult {
        var correct = 0
        var domainCorrect: [String: Int] = [:]
        var domainTotal: [String: Int] = [:]
        for (i, q) in exam.questions.enumerated() {
            let chosen = i < answers.count ? answers[i] : nil
            let isRight = chosen == q.answerIndex
            if isRight { correct += 1 }
            domainTotal[q.domain, default: 0] += 1
            if isRight { domainCorrect[q.domain, default: 0] += 1 }
        }
        var byDomain: [String: ExamResult.DomainScore] = [:]
        for (domain, total) in domainTotal {
            byDomain[domain] = ExamResult.DomainScore(correct: domainCorrect[domain] ?? 0, total: total)
        }
        return ExamResult(correct: correct, total: exam.questions.count, byDomain: byDomain)
    }
}

/// Parser for the exam format: YAML-style frontmatter plus `:::q <domain>` blocks.
///
/// ```
/// ---
/// track: planning
/// title: Planning Certification
/// pass: 0.7
/// ---
/// :::q Campaign Briefs
/// question: What MUST a brief contain before planning begins?
/// - A timeline
/// - A business objective
/// - Creative specs
/// - A vendor list
/// answer: 1
/// explain: Objectives anchor every later decision.
/// :::
/// ```
public enum ExamParser {
    public static func parse(_ text: String) -> Exam? {
        var lines = text.components(separatedBy: "\n")
        let meta = extractFrontmatter(&lines)
        guard let track = meta["track"] else { return nil }
        let title = meta["title"] ?? ""
        let passMark = Double(meta["pass"] ?? "") ?? 0.7
        let draw = Int(meta["draw"] ?? "") ?? 0

        var questions: [ExamQuestion] = []
        var i = 0
        while i < lines.count {
            let line = lines[i].trimmingCharacters(in: .whitespaces)
            if line.hasPrefix(":::q") {
                let domain = String(line.dropFirst(4)).trimmingCharacters(in: .whitespaces)
                var body: [String] = []
                i += 1
                while i < lines.count, lines[i].trimmingCharacters(in: .whitespaces) != ":::" {
                    body.append(lines[i])
                    i += 1
                }
                i += 1 // consume closing :::
                if let q = parseQuestion(domain: domain, body: body, index: questions.count, track: track) {
                    questions.append(q)
                }
            } else {
                i += 1
            }
        }
        return Exam(track: track, title: title, passMark: passMark, questions: questions, draw: draw)
    }

    private static func parseQuestion(domain: String, body: [String], index: Int, track: String) -> ExamQuestion? {
        var question = ""
        var options: [String] = []
        var answerIndex = 0
        var explanation = ""
        for line in body {
            let t = line.trimmingCharacters(in: .whitespaces)
            if t.hasPrefix("question:") {
                question = String(t.dropFirst("question:".count)).trimmingCharacters(in: .whitespaces)
            } else if t.hasPrefix("answer:") {
                answerIndex = Int(String(t.dropFirst("answer:".count)).trimmingCharacters(in: .whitespaces)) ?? 0
            } else if t.hasPrefix("explain:") {
                explanation = String(t.dropFirst("explain:".count)).trimmingCharacters(in: .whitespaces)
            } else if t.hasPrefix("- ") {
                options.append(String(t.dropFirst(2)).trimmingCharacters(in: .whitespaces))
            }
        }
        guard !question.isEmpty, options.count >= 2 else { return nil }
        return ExamQuestion(
            id: "\(track)-q\(index)",
            domain: domain.isEmpty ? "General" : domain,
            question: question, options: options,
            answerIndex: min(max(answerIndex, 0), options.count - 1),
            explanation: explanation
        )
    }

    private static func extractFrontmatter(_ lines: inout [String]) -> [String: String] {
        var meta: [String: String] = [:]
        guard lines.first?.trimmingCharacters(in: .whitespaces) == "---" else { return meta }
        lines.removeFirst()
        while let first = lines.first, first.trimmingCharacters(in: .whitespaces) != "---" {
            lines.removeFirst()
            if let idx = first.firstIndex(of: ":") {
                let key = String(first[..<idx]).trimmingCharacters(in: .whitespaces)
                let value = String(first[first.index(after: idx)...]).trimmingCharacters(in: .whitespaces)
                if !key.isEmpty { meta[key] = value }
            }
        }
        if !lines.isEmpty { lines.removeFirst() }
        return meta
    }
}
