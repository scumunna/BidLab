import BidLabCore

/// Tests for the cohort roll-up: parsing exported transcripts and aggregating
/// them into a manager roster, entirely offline.
func cohortTests(_ h: Harness) {
    let csv = """
    learner,Ada Lovelace
    track,role,lessons_completed,lessons_total,certified,exam_score_pct,exam_date
    foundations,Foundations,12,12,yes,90,2026-06-15

    summary,value
    lessons_completed_total,40
    lessons_total,113
    certifications_earned,2
    best_trading_score,88
    xp,500
    day_streak,5
    """

    guard let r = Cohort.parseTranscript(csv) else {
        h.check("transcript parses", false); return
    }
    h.check("transcript parses", true)
    h.check("parsed learner name", r.name == "Ada Lovelace")
    h.check("parsed lessons completed", r.lessonsCompleted == 40)
    h.check("parsed lessons total", r.lessonsTotal == 113)
    h.check("parsed certifications", r.certificationsEarned == 2)
    h.check("parsed best score", r.bestTradingScore == 88)
    h.check("parsed xp", r.xp == 500)
    h.check("parsed day streak", r.dayStreak == 5)
    h.close("completion fraction", r.completionFraction, 40.0 / 113.0, tol: 1e-9)

    // Tolerant of a missing learner line: still parses the summary block.
    let noName = "summary,value\nlessons_completed_total,5\nlessons_total,10\ncertifications_earned,0\nbest_trading_score,0\nxp,50\nday_streak,1"
    let r2 = Cohort.parseTranscript(noName)
    h.check("parses without a learner line", r2 != nil)
    h.check("default name when learner line is missing", r2?.name == "Unnamed learner")
    h.close("completion without a name", r2?.completionFraction ?? -1, 0.5, tol: 1e-9)

    // Non-transcript text has no summary block and returns nil.
    h.check("non-transcript text returns nil", Cohort.parseTranscript("hello,world\nfoo,bar") == nil)

    // Aggregate across a cohort.
    let a = LearnerRecord(name: "A", lessonsCompleted: 113, lessonsTotal: 113, certificationsEarned: 3, bestTradingScore: 90, xp: 100, dayStreak: 2)
    let b = LearnerRecord(name: "B", lessonsCompleted: 0, lessonsTotal: 113, certificationsEarned: 0, bestTradingScore: 0, xp: 0, dayStreak: 0)
    let s = Cohort.summarize([a, b])
    h.check("learner count", s.learnerCount == 2)
    h.close("avg completion is (1 + 0) / 2", s.avgCompletion, 0.5, tol: 1e-9)
    h.check("total certifications", s.totalCertifications == 3)
    h.check("certified-learner count", s.certifiedLearners == 1)
    h.close("avg best score counts only learners who scored", s.avgBestScore, 90, tol: 1e-9)

    // Empty cohort summarize is zeroed, not a divide-by-zero.
    let empty = Cohort.summarize([])
    h.check("empty cohort count is zero", empty.learnerCount == 0)
    h.close("empty cohort avg completion is zero", empty.avgCompletion, 0, tol: 1e-9)

    // parseAll drops files that do not parse.
    let all = Cohort.parseAll([csv, "junk text", noName])
    h.check("parseAll keeps only the parseable files", all.count == 2)

    // reportCSV has a header plus one row per learner.
    let report = Cohort.reportCSV([a, b])
    let rows = report.components(separatedBy: "\n")
    h.check("report has a header and two rows", rows.count == 3)
    h.check("report header is correct", rows[0].hasPrefix("learner,lessons_completed,lessons_total,completion_pct"))
    h.check("report row A shows 100 percent completion", rows[1].contains("\"A\",113,113,100,"))
}
