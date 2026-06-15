import Foundation

/// Stable, launch-independent identifiers. Swift's `String.hashValue` is salted
/// per process, so it cannot key data that must persist across launches. FNV-1a
/// gives a small deterministic hash that does.
public enum StableID {
    public static func hash(_ s: String) -> UInt64 {
        var h: UInt64 = 1469598103934665603
        for byte in s.utf8 { h = (h ^ UInt64(byte)) &* 1099511628211 }
        return h
    }

    public static func key(_ s: String) -> String { String(hash(s), radix: 36) }
}

/// Spaced-repetition scheduling. A graded item climbs through mastery stages on
/// correct answers (each with a longer review interval) and resets to stage 0 on
/// a miss, which also keeps it in the mistakes queue. Expanding intervals beat
/// massed review for long-term retention, which is the return loop the course
/// otherwise lacks.
public enum SpacedRepetition {
    /// Days until the next review at each mastery stage. Correct answers climb.
    public static let intervalDays = [1, 3, 7, 16, 35]

    /// The final, graduated stage.
    public static var maxStage: Int { intervalDays.count - 1 }

    /// The next stage after answering: correct climbs one (capped), a miss resets.
    public static func advance(stage: Int, correct: Bool) -> Int {
        guard correct else { return 0 }
        return min(stage + 1, maxStage)
    }

    /// Days to wait before reviewing an item now sitting at `stage` (clamped).
    public static func days(forStage stage: Int) -> Int {
        intervalDays[min(max(stage, 0), maxStage)]
    }

    /// An item is graduated (mastered) once it reaches the final stage.
    public static func isGraduated(stage: Int) -> Bool { stage >= maxStage }
}

public extension QuizQuestion {
    /// A stable key identifying this question within a lesson, for scheduling.
    func reviewKey(lessonID: String) -> String { "quiz:\(lessonID):\(StableID.key(question))" }
}

public extension Prediction {
    /// A stable key identifying this prediction within a lesson, for scheduling.
    func reviewKey(lessonID: String) -> String { "predict:\(lessonID):\(StableID.key(prompt))" }
}
