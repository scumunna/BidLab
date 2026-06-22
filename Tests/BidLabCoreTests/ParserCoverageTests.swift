import BidLabCore

/// Coverage for the parsers and roll-ups: transcript parsing, exam parsing and
/// grading, and the lesson parser's full directive grammar. These drive the
/// error-tolerant branches (non-numeric cells, missing keys, empty domains,
/// unknown directives, sources without URLs) that the golden suites do not reach.
func parserCoverageTests(_ h: Harness) {
    // MARK: Cohort completion-fraction guards
    h.close("track progress completion guards zero total",
            TrackProgress(trackID: "dsp", role: "Trader", lessonsCompleted: 3, lessonsTotal: 0, certified: false).completionFraction, 0)
    h.close("learner completion guards zero total",
            LearnerRecord(name: "X", lessonsCompleted: 3, lessonsTotal: 0, certificationsEarned: 0,
                          bestTradingScore: 0, xp: 0, dayStreak: 0).completionFraction, 0)

    // MARK: Cohort transcript parsing (non-numeric cells, a 5-column row, missing keys)
    let transcript = """
    learner,Test User
    track,role,completed,total,certified,examScore
    dsp,DSP Trader,x,y,no
    planning,Planner,5,10,yes,85
    summary,value
    lessons_completed_total,5
    """
    if let rec = Cohort.parseTranscript(transcript) {
        h.check("non-numeric track cells fall back to zero",
                rec.tracks.first?.lessonsCompleted == 0 && rec.tracks.first?.lessonsTotal == 0)
        h.check("a five-column track row has no exam score", rec.tracks.first?.examScorePct == nil)
        h.check("a six-column track row keeps its exam score", rec.tracks.last?.examScorePct == 85)
        h.check("missing summary keys fall back to zero", rec.lessonsTotal == 0 && rec.xp == 0)
        h.check("present summary keys are read", rec.lessonsCompleted == 5)
    } else {
        h.check("the transcript parses", false)
    }

    // MARK: Cohort summarize with no scorers, byPath with an uncertified path
    let noScorer = LearnerRecord(
        name: "A", lessonsCompleted: 1, lessonsTotal: 10, certificationsEarned: 0,
        bestTradingScore: 0, xp: 10, dayStreak: 1,
        tracks: [TrackProgress(trackID: "dsp", role: "Trader", lessonsCompleted: 1, lessonsTotal: 10, certified: false)])
    h.close("average best score is 0 when nobody has run the simulator", Cohort.summarize([noScorer]).avgBestScore, 0)
    let scorer = LearnerRecord(
        name: "B", lessonsCompleted: 8, lessonsTotal: 10, certificationsEarned: 1,
        bestTradingScore: 90, xp: 50, dayStreak: 5,
        tracks: [TrackProgress(trackID: "dsp", role: "Trader", lessonsCompleted: 8, lessonsTotal: 10, certified: true)])
    let rollup = Cohort.byPath([noScorer, scorer]) // two records share the dsp path
    h.check("byPath rolls up the path", rollup.first?.trackID == "dsp")
    h.check("byPath aggregates learners across records", rollup.first?.learnerCount == 2)
    h.check("byPath counts only the certified learner", rollup.first?.certifiedCount == 1)

    // MARK: Exam presented count, domain de-duplication, grading guards
    let q1 = ExamQuestion(id: "t-q0", domain: "A", question: "Q1?", options: ["x", "y"], answerIndex: 0, explanation: "")
    let q2 = ExamQuestion(id: "t-q1", domain: "A", question: "Q2?", options: ["x", "y"], answerIndex: 1, explanation: "")
    let q3 = ExamQuestion(id: "t-q2", domain: "B", question: "Q3?", options: ["x", "y"], answerIndex: 0, explanation: "")
    let fullExam = Exam(track: "t", title: "T", passMark: 0.7, questions: [q1, q2, q3])
    h.check("presented count with no draw is the full bank", fullExam.presentedCount == 3)
    h.check("presented count with a draw caps the bank",
            Exam(track: "t", title: "T", passMark: 0.7, questions: [q1, q2, q3], draw: 2).presentedCount == 2)
    h.check("domains de-duplicate in first-seen order", fullExam.domains == ["A", "B"])

    let result = ExamScoring.score(fullExam, answers: [0]) // only Q1 answered (correct); Q2, Q3 missing
    h.check("a short answer array counts the rest wrong", result.correct == 1)
    h.close("overall exam fraction", result.fraction, 1.0 / 3.0, tol: 1e-12)
    h.close("per-domain fraction (1 of 2)", result.byDomain["A"]?.fraction ?? -1, 0.5, tol: 1e-12)
    h.close("empty exam result fraction is 0", ExamResult(correct: 0, total: 0, byDomain: [:]).fraction, 0)
    h.close("empty domain score fraction is 0", ExamResult.DomainScore(correct: 0, total: 0).fraction, 0)

    // MARK: ExamParser edge cases
    h.check("an exam without a track is nil", ExamParser.parse("---\ntitle: No Track\n---\n") == nil)
    let exDoc = """
    ---
    track: planning
    ---
    :::q
    question: What anchors a plan?
    - A timeline
    - A business objective
    answer: zzz
    explain: Objectives anchor decisions.
    :::
    """
    if let parsed = ExamParser.parse(exDoc) {
        h.close("a missing pass mark defaults to 0.7", parsed.passMark, 0.7)
        h.check("an empty domain becomes General", parsed.questions.first?.domain == "General")
        h.check("a non-numeric answer index falls back to 0", parsed.questions.first?.answerIndex == 0)
    } else {
        h.check("the exam document parses", false)
    }
    h.check("a question with fewer than two options is skipped",
            ExamParser.parse("---\ntrack: planning\n---\n:::q Briefs\nquestion: Only one?\n- Just one\nanswer: 0\n:::")?.questions.isEmpty == true)

    // MARK: LessonParser full directive grammar
    h.check("a lesson without an id is nil", LessonParser.parse("# No frontmatter") == nil)
    let lessonDoc = """
    ---
    id: test-99
    justjunk
    : orphanvalue
    ---
    # Heading

    Some prose.

    ```inlinecode```

    $$
    E = mc^2
    second line
    $$

    :::callout
    A callout with no kind argument.
    :::

    :::widget auctionSimulator
    mechanism: second-price
    nocolonparam
    :::

    :::quiz
    question: Pick one?
    - A
    - B
    answer: notanumber
    explain: Because.
    :::

    :::predict
    prompt: Estimate?
    answer: notanumber
    tolerance: alsonotanumber
    unit: $
    :::

    :::figure rtbFlow
    notacaption line
    :::

    :::mystery
    unknown directive body
    :::

    :::
    bare directive body
    :::

    :::sources
    - Title Only No URL
    not a dash line
    - Real Source | https://example.com
    :::
    """
    if let lesson = LessonParser.parse(lessonDoc) {
        h.check("lesson id is read", lesson.id == "test-99")
        h.check("missing track/title/summary fall back to empty", lesson.track == "" && lesson.title == "" && lesson.summary == "")
        h.check("missing module falls back to 0", lesson.module == 0)
        let blocks = lesson.blocks
        h.check("a single-line code fence parses", blocks.contains { if case .code = $0 { return true }; return false })
        h.check("a multi-line math block parses", blocks.contains { if case .math = $0 { return true }; return false })
        h.check("a callout without an arg defaults to note", blocks.contains { if case .callout(let kind, _) = $0 { return kind == "note" }; return false })
        h.check("a figure without a caption has an empty caption", blocks.contains { if case .figure(_, let cap) = $0 { return cap.isEmpty }; return false })
        h.check("an unknown directive degrades to prose", blocks.contains { if case .prose(let t) = $0 { return t == "unknown directive body" }; return false })
        h.check("a non-numeric quiz answer falls back to 0", lesson.quizzes.first?.answerIndex == 0)
        h.check("a non-numeric prediction answer falls back to 0", lesson.predictions.first?.answer == 0)
        h.check("a non-numeric prediction tolerance falls back to 0", lesson.predictions.first?.tolerance == 0)
        h.check("a source without a URL is kept with an empty URL", lesson.sources.contains { $0.url.isEmpty && !$0.title.isEmpty })
        h.check("a source with a URL is parsed", lesson.sources.contains { $0.url == "https://example.com" })
    } else {
        h.check("the lesson parses", false)
    }
}
