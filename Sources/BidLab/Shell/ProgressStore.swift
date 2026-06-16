import BidLabCore
import Foundation
import SwiftUI

/// One scheduled spaced-repetition item: a graded question the learner has met,
/// with its mastery stage and the next time it is due for review.
struct ReviewRecord: Codable, Identifiable, Equatable {
    var key: String
    var lessonID: String
    var stage: Int
    var nextDueEpoch: Double
    var lastCorrect: Bool
    var id: String { key }
}

/// A passed certification, with the best score and the date it was earned.
struct ExamRecord: Codable, Equatable {
    var fraction: Double   // 0...1
    var dateISO: String    // yyyy-MM-dd
}

/// Tracks and persists learner progress: completed lessons, best Trading Floor
/// score, XP, a daily streak, and a spaced-repetition review schedule. Saved as
/// JSON in Application Support behind a simple API, so a future SwiftData or
/// iCloud backend can replace storage without touching the views.
final class ProgressStore: ObservableObject {
    @Published private(set) var completedLessons: Set<String> = []
    @Published private(set) var bestTradingScore: Double = 0
    @Published private(set) var xp: Int = 0
    @Published private(set) var weekXP: Int = 0
    @Published private(set) var bestWeekXP: Int = 0
    @Published private(set) var learnerName: String = ""

    /// The name shown on a certificate. Falls back to a neutral default until set.
    var displayName: String { learnerName.isEmpty ? "BidLab Learner" : learnerName }
    @Published private(set) var streak: Int = 0
    @Published private(set) var streakFreezes: Int = 0
    @Published private(set) var dailyGoal: Int = 3
    @Published private(set) var itemsToday: Int = 0
    @Published var pendingStreakMilestone: Int?
    @Published private(set) var reviews: [String: ReviewRecord] = [:]
    @Published private(set) var passedExams: Set<String> = []
    @Published private(set) var examResults: [String: ExamRecord] = [:]
    private var lastActiveDay: Date?
    private var weekAnchor: Date?
    private var dailyGoalDay: Date?
    private var celebratedMilestones: Set<Int> = []

    private static let xpPerLesson = 20
    private static let freezeCap = 2
    static let freezeCost = 200
    private static let streakMilestones: Set<Int> = [7, 30, 100, 365]

    private struct Snapshot: Codable {
        var completedLessons: [String]
        var bestTradingScore: Double
        var xp: Int?
        var streak: Int?
        var lastActive: Double?
        var reviews: [ReviewRecord]?
        var streakFreezes: Int?
        var dailyGoal: Int?
        var itemsToday: Int?
        var dailyGoalDay: Double?
        var celebratedMilestones: [Int]?
        var passedExams: [String]?
        var examResults: [String: ExamRecord]?
        var weekXP: Int?
        var bestWeekXP: Int?
        var weekAnchor: Double?
        var learnerName: String?
    }

    private let fileURL: URL = {
        let base = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let dir = base.appendingPathComponent("BidLab", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("progress.json")
    }()

    init() { load() }

    func complete(_ lessonID: String) {
        guard !completedLessons.contains(lessonID) else { return }
        completedLessons.insert(lessonID)
        addXP(Self.xpPerLesson)
        recordActivity()
        save()
    }

    /// Add XP and attribute it to the current week, rolling the prior week's
    /// total into the personal best when the calendar week turns over.
    private func addXP(_ amount: Int) {
        rolloverWeek()
        xp += amount
        weekXP += amount
    }

    private func rolloverWeek() {
        let cal = Calendar.current
        let thisWeek = cal.dateInterval(of: .weekOfYear, for: Date())?.start
        if let anchor = weekAnchor {
            if let tw = thisWeek, !cal.isDate(anchor, equalTo: tw, toGranularity: .weekOfYear) {
                bestWeekXP = max(bestWeekXP, weekXP)
                weekXP = 0
                weekAnchor = tw
            }
        } else {
            weekAnchor = thisWeek
        }
    }

    func isComplete(_ lessonID: String) -> Bool {
        completedLessons.contains(lessonID)
    }

    func recordTradingScore(_ score: Double) {
        guard score > bestTradingScore else { return }
        bestTradingScore = score
        save()
    }

    /// Record that the learner passed a track's certification exam, keeping the
    /// best score and the date earned for the transcript.
    func recordExamPass(track: String, fraction: Double = 1.0) {
        let firstPass = !passedExams.contains(track)
        passedExams.insert(track)
        if fraction > (examResults[track]?.fraction ?? -1) {
            examResults[track] = ExamRecord(fraction: fraction, dateISO: Self.todayISO())
        }
        if firstPass { recordActivity() }
        save()
    }

    func isExamPassed(_ track: String) -> Bool { passedExams.contains(track) }

    func setName(_ name: String) {
        learnerName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        save()
    }

    func setDailyGoal(_ n: Int) {
        dailyGoal = min(max(n, 1), 30)
        save()
    }

    /// Wipe learning progress (keeps the name and daily goal). For the Settings reset.
    func resetProgress() {
        completedLessons = []
        bestTradingScore = 0
        xp = 0
        streak = 0
        streakFreezes = 0
        itemsToday = 0
        reviews = [:]
        passedExams = []
        examResults = [:]
        weekXP = 0
        bestWeekXP = 0
        celebratedMilestones = []
        pendingStreakMilestone = nil
        save()
    }

    private static func todayISO() -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: Date())
    }

    /// Whether the learner can spend XP on another streak freeze.
    var canBuyFreeze: Bool { xp >= Self.freezeCost && streakFreezes < Self.freezeCap }

    /// Spend XP to buy a streak freeze, giving XP a purpose beyond a number.
    func buyFreeze() {
        guard canBuyFreeze else { return }
        xp -= Self.freezeCost
        streakFreezes += 1
        save()
    }

    /// Record the result of a graded item (quiz or prediction). Schedules the
    /// item on the spaced-repetition ladder and keeps the daily streak alive.
    func recordAttempt(key: String, lessonID: String, correct: Bool) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let priorStage = reviews[key]?.stage ?? 0
        let stage = SpacedRepetition.advance(stage: priorStage, correct: correct)
        let due = calendar.date(byAdding: .day, value: SpacedRepetition.days(forStage: stage), to: today) ?? today
        reviews[key] = ReviewRecord(
            key: key, lessonID: lessonID, stage: stage,
            nextDueEpoch: due.timeIntervalSince1970, lastCorrect: correct
        )
        recordActivity()
        save()
    }

    /// Items due for review now (not yet graduated), soonest first.
    var dueReviewRecords: [ReviewRecord] {
        let now = Date().timeIntervalSince1970
        return reviews.values
            .filter { !SpacedRepetition.isGraduated(stage: $0.stage) && $0.nextDueEpoch <= now }
            .sorted { $0.nextDueEpoch < $1.nextDueEpoch }
    }

    /// Items most recently answered incorrectly, soonest-due first.
    var mistakeRecords: [ReviewRecord] {
        reviews.values.filter { !$0.lastCorrect }.sorted { $0.nextDueEpoch < $1.nextDueEpoch }
    }

    var dueReviewCount: Int { dueReviewRecords.count }

    /// Update the daily streak, freezes, daily-goal counter, and any milestone
    /// based on the last active day.
    private func recordActivity() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let gap: Int
        if let last = lastActiveDay {
            gap = calendar.dateComponents([.day], from: calendar.startOfDay(for: last), to: today).day ?? 0
        } else {
            gap = 99 // first activity ever starts a fresh streak
        }
        let result = StreakEngine.advance(gapDays: gap, streak: streak, freezes: streakFreezes, freezeCap: Self.freezeCap)
        streak = result.streak
        streakFreezes = result.freezes

        // Reset the daily-goal counter on a new day, then count this activity.
        if let day = dailyGoalDay, calendar.isDate(day, inSameDayAs: today) {
            // same day, keep counting
        } else {
            itemsToday = 0
            dailyGoalDay = today
        }
        itemsToday += 1

        // Flag a streak milestone the first time it is crossed in this streak.
        if result.increased {
            if streak == 1 { celebratedMilestones.removeAll() }
            if Self.streakMilestones.contains(streak), !celebratedMilestones.contains(streak) {
                celebratedMilestones.insert(streak)
                pendingStreakMilestone = streak
            }
        }
        lastActiveDay = today
    }

    /// Activities counted toward today's goal (0 if the counter is from a prior day).
    var goalProgressToday: Int {
        guard let day = dailyGoalDay, Calendar.current.isDateInToday(day) else { return 0 }
        return itemsToday
    }

    var dailyGoalMet: Bool { goalProgressToday >= dailyGoal }

    // MARK: Derived

    var totalLiveLessons: Int {
        Track.all.reduce(0) { $0 + liveCount(forTrack: $1.id) }
    }

    var totalCompleted: Int { completedLessons.count }

    func liveCount(forTrack id: String) -> Int {
        Curriculum.modules(for: id).filter { Curriculum.isAvailable($0.lessonID) }.count
    }

    func completedCount(forTrack id: String) -> Int {
        Curriculum.modules(for: id).filter { module in
            Curriculum.isAvailable(module.lessonID) && completedLessons.contains(module.lessonID)
        }.count
    }

    var certificationUnlocked: Bool {
        totalLiveLessons > 0 && totalCompleted >= totalLiveLessons
    }

    // MARK: Transcript export

    /// A CSV transcript of completion and certification, for an LMS or a manager report.
    func transcriptCSV() -> String {
        // A leading learner line makes the file self-describing, so a manager
        // can roll several transcripts up into one cohort roster (see Cohort).
        var lines = ["learner,\(displayName)"]
        lines.append("track,role,lessons_completed,lessons_total,certified,exam_score_pct,exam_date")
        for t in Track.all {
            let score = examResults[t.id].map { String(Int(($0.fraction * 100).rounded())) } ?? ""
            let date = examResults[t.id]?.dateISO ?? ""
            lines.append("\(t.id),\(t.role),\(completedCount(forTrack: t.id)),\(liveCount(forTrack: t.id)),\(isExamPassed(t.id) ? "yes" : "no"),\(score),\(date)")
        }
        lines.append("")
        lines.append("summary,value")
        lines.append("lessons_completed_total,\(totalCompleted)")
        lines.append("lessons_total,\(totalLiveLessons)")
        lines.append("certifications_earned,\(passedExams.count)")
        lines.append("best_trading_score,\(Int(bestTradingScore.rounded()))")
        lines.append("xp,\(xp)")
        lines.append("day_streak,\(streak)")
        // Tamper-evident signature over the summary AND per-track rows, so a
        // manager rolling these up can tell an edited file from a real one,
        // including an edited per-path certification (see Cohort).
        let signature = Cohort.transcriptSignature(
            name: displayName, lessonsCompleted: totalCompleted, lessonsTotal: totalLiveLessons,
            certifications: passedExams.count, bestTradingScore: Int(bestTradingScore.rounded()),
            xp: xp, dayStreak: streak, tracks: transcriptTrackProgress()
        )
        lines.append("signature,\(signature)")
        return lines.joined(separator: "\n")
    }

    /// The per-track rows as `TrackProgress`, matching exactly what `transcriptCSV`
    /// writes, so signing and verification agree.
    private func transcriptTrackProgress() -> [TrackProgress] {
        Track.all.map { t in
            TrackProgress(
                trackID: t.id, role: t.role,
                lessonsCompleted: completedCount(forTrack: t.id), lessonsTotal: liveCount(forTrack: t.id),
                certified: isExamPassed(t.id),
                examScorePct: examResults[t.id].map { Int(($0.fraction * 100).rounded()) },
                examDate: examResults[t.id]?.dateISO
            )
        }
    }

    /// A JSON transcript: the same data structured for ingestion.
    func transcriptJSON() -> String {
        let tracks = Track.all.map { t -> String in
            let r = examResults[t.id]
            let score = r.map { String(Int(($0.fraction * 100).rounded())) } ?? "null"
            let date = r.map { "\"\($0.dateISO)\"" } ?? "null"
            return "{\"track\":\"\(t.id)\",\"role\":\"\(t.role)\",\"lessonsCompleted\":\(completedCount(forTrack: t.id)),\"lessonsTotal\":\(liveCount(forTrack: t.id)),\"certified\":\(isExamPassed(t.id)),\"examScorePct\":\(score),\"examDate\":\(date)}"
        }.joined(separator: ",")
        let safeName = displayName.replacingOccurrences(of: "\"", with: "'")
        let signature = Cohort.transcriptSignature(
            name: displayName, lessonsCompleted: totalCompleted, lessonsTotal: totalLiveLessons,
            certifications: passedExams.count, bestTradingScore: Int(bestTradingScore.rounded()),
            xp: xp, dayStreak: streak, tracks: transcriptTrackProgress()
        )
        return "{\"learner\":\"\(safeName)\",\"lessonsCompletedTotal\":\(totalCompleted),\"lessonsTotal\":\(totalLiveLessons),\"certificationsEarned\":\(passedExams.count),\"bestTradingScore\":\(Int(bestTradingScore.rounded())),\"xp\":\(xp),\"dayStreak\":\(streak),\"signature\":\"\(signature)\",\"tracks\":[\(tracks)]}"
    }

    // MARK: Persistence

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let snap = try? JSONDecoder().decode(Snapshot.self, from: data) else { return }
        completedLessons = Set(snap.completedLessons)
        bestTradingScore = snap.bestTradingScore
        xp = snap.xp ?? 0
        streak = snap.streak ?? 0
        lastActiveDay = snap.lastActive.map { Date(timeIntervalSince1970: $0) }
        reviews = Dictionary(uniqueKeysWithValues: (snap.reviews ?? []).map { ($0.key, $0) })
        streakFreezes = snap.streakFreezes ?? 0
        dailyGoal = snap.dailyGoal ?? 3
        itemsToday = snap.itemsToday ?? 0
        dailyGoalDay = snap.dailyGoalDay.map { Date(timeIntervalSince1970: $0) }
        celebratedMilestones = Set(snap.celebratedMilestones ?? [])
        passedExams = Set(snap.passedExams ?? [])
        examResults = snap.examResults ?? [:]
        weekXP = snap.weekXP ?? 0
        bestWeekXP = snap.bestWeekXP ?? 0
        weekAnchor = snap.weekAnchor.map { Date(timeIntervalSince1970: $0) }
        learnerName = snap.learnerName ?? ""
        rolloverWeek()
        // Backfill for lessons completed before gamification was added.
        if xp == 0, !completedLessons.isEmpty {
            xp = completedLessons.count * Self.xpPerLesson
            if streak == 0 { streak = 1 }
        }
    }

    private func save() {
        let snapshot = Snapshot(
            completedLessons: Array(completedLessons),
            bestTradingScore: bestTradingScore,
            xp: xp,
            streak: streak,
            lastActive: lastActiveDay?.timeIntervalSince1970,
            reviews: Array(reviews.values),
            streakFreezes: streakFreezes,
            dailyGoal: dailyGoal,
            itemsToday: itemsToday,
            dailyGoalDay: dailyGoalDay?.timeIntervalSince1970,
            celebratedMilestones: Array(celebratedMilestones),
            passedExams: Array(passedExams),
            examResults: examResults,
            weekXP: weekXP,
            bestWeekXP: bestWeekXP,
            weekAnchor: weekAnchor?.timeIntervalSince1970,
            learnerName: learnerName
        )
        if let data = try? JSONEncoder().encode(snapshot) {
            try? data.write(to: fileURL)
        }
    }
}
