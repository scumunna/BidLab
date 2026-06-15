import Foundation

/// The daily-streak state machine, kept pure so it can be unit-tested. A streak
/// grows by one each consecutive active day. A single missed day (a two-day gap)
/// is bridged by spending a streak freeze, so one slip does not undo weeks of
/// momentum; this protection is one of the largest retention levers in practice.
/// Larger gaps reset the streak. A freeze is earned on each completed week,
/// capped, so freezes cannot accumulate without bound.
public enum StreakEngine {
    public struct Result: Equatable {
        public var streak: Int
        public var freezes: Int
        public var increased: Bool
        public init(streak: Int, freezes: Int, increased: Bool) {
            self.streak = streak
            self.freezes = freezes
            self.increased = increased
        }
    }

    /// Advance the streak given the day gap since the last active day.
    /// - gapDays 0: same day, nothing changes.
    /// - gapDays 1: consecutive day, streak climbs.
    /// - gapDays 2 with a freeze: bridge the miss, spend a freeze.
    /// - otherwise: reset to 1.
    public static func advance(gapDays: Int, streak: Int, freezes: Int, freezeCap: Int) -> Result {
        if gapDays <= 0 { return Result(streak: streak, freezes: freezes, increased: false) }

        var newStreak = streak
        var newFreezes = freezes
        if gapDays == 1 {
            newStreak += 1
        } else if gapDays == 2, freezes > 0 {
            newFreezes -= 1
            newStreak += 1
        } else {
            newStreak = 1
        }
        // Earn a freeze on each completed week, capped.
        if newStreak % 7 == 0, newFreezes < freezeCap {
            newFreezes += 1
        }
        return Result(streak: newStreak, freezes: newFreezes, increased: true)
    }
}
