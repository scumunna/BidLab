import BidLabCore
import Foundation

/// Tests for the exam parser and scoring.
func examTests(_ h: Harness) {
    let text = """
    ---
    track: planning
    title: Planning Certification
    pass: 0.7
    ---
    :::q Campaign Briefs
    question: What must a brief contain before planning begins?
    - A timeline
    - A business objective
    - Creative specs
    - A vendor list
    answer: 1
    explain: Objectives anchor every later decision.
    :::

    :::q Measurement
    question: In a first-price auction the winner pays what?
    - the second-highest bid
    - their own bid
    answer: 1
    explain: First price means you pay exactly what you bid.
    :::
    """

    guard let exam = ExamParser.parse(text) else { h.check("exam parses", false); return }
    h.check("exam parses", true)
    h.check("exam track", exam.track == "planning")
    h.close("exam pass mark", exam.passMark, 0.7)
    h.check("two questions", exam.questions.count == 2)
    h.check("two domains", exam.domains.count == 2)
    h.check("first domain", exam.questions[0].domain == "Campaign Briefs")
    h.check("first answer index", exam.questions[0].answerIndex == 1)
    h.check("four options", exam.questions[0].options.count == 4)
    h.check("stable question id", exam.questions[0].id == "planning-q0")

    // Half right, fails the bar.
    let half = ExamScoring.score(exam, answers: [1, 0])
    h.check("one correct", half.correct == 1)
    h.check("total two", half.total == 2)
    h.close("fraction 0.5", half.fraction, 0.5)
    h.check("not passed at 0.7", !half.passed(0.7))
    h.check("domain briefs correct", half.byDomain["Campaign Briefs"]?.correct == 1)
    h.check("domain measurement wrong", half.byDomain["Measurement"]?.correct == 0)

    // All correct passes.
    let perfect = ExamScoring.score(exam, answers: [1, 1])
    h.check("all correct", perfect.correct == 2)
    h.check("passes at 0.7", perfect.passed(0.7))

    // Unanswered counts as wrong.
    let blank = ExamScoring.score(exam, answers: [nil, nil])
    h.check("unanswered counts wrong", blank.correct == 0)

    // Missing track yields nil.
    h.check("no track returns nil", ExamParser.parse("question: orphan") == nil)
}

/// Validates every authored exam under Content/Exams (path via BIDLAB_EXAMS).
func examValidationTests(_ h: Harness) {
    guard let dirPath = ProcessInfo.processInfo.environment["BIDLAB_EXAMS"] else { return }
    let dir = URL(fileURLWithPath: dirPath)
    guard let files = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil) else { return }
    let mdFiles = files.filter { $0.pathExtension == "md" }.sorted { $0.lastPathComponent < $1.lastPathComponent }
    for file in mdFiles {
        let name = file.lastPathComponent
        guard let text = try? String(contentsOf: file, encoding: .utf8), let exam = ExamParser.parse(text) else {
            h.check("\(name): exam parses", false); continue
        }
        h.check("\(name): has track", !exam.track.isEmpty)
        h.check("\(name): has questions", exam.questions.count >= 1)
        h.check("\(name): pass mark in range", exam.passMark > 0 && exam.passMark <= 1)
        for q in exam.questions {
            h.check("\(name): \(q.id) has 2+ options", q.options.count >= 2)
            h.check("\(name): \(q.id) answer in range", q.answerIndex >= 0 && q.answerIndex < q.options.count)
            h.check("\(name): \(q.id) has a domain", !q.domain.isEmpty)
            h.check("\(name): \(q.id) no em dash", !q.question.contains("\u{2014}"))
        }
        // Industry certification banks are authored to a fixed 24-question pool
        // (12 drawn per attempt); assert it so a short bank cannot ship unnoticed.
        if exam.track.hasPrefix("vertical-") {
            h.check("\(name): vertical exam bank holds 24 questions", exam.questions.count == 24)
        }
    }
}
