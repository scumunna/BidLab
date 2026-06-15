import BidLabCore

/// Tests for the daily-streak state machine.
func streakTests(_ h: Harness) {
    let cap = 2

    let same = StreakEngine.advance(gapDays: 0, streak: 5, freezes: 1, freezeCap: cap)
    h.check("same day no change", same.streak == 5 && same.freezes == 1 && !same.increased)

    let next = StreakEngine.advance(gapDays: 1, streak: 5, freezes: 1, freezeCap: cap)
    h.check("next day climbs", next.streak == 6 && next.increased)

    let bridged = StreakEngine.advance(gapDays: 2, streak: 5, freezes: 1, freezeCap: cap)
    h.check("freeze bridges a missed day", bridged.streak == 6 && bridged.freezes == 0)

    let broke = StreakEngine.advance(gapDays: 2, streak: 5, freezes: 0, freezeCap: cap)
    h.check("missed day without freeze resets", broke.streak == 1 && broke.freezes == 0)

    let bigGap = StreakEngine.advance(gapDays: 5, streak: 9, freezes: 2, freezeCap: cap)
    h.check("big gap resets, freezes kept", bigGap.streak == 1 && bigGap.freezes == 2)

    let week = StreakEngine.advance(gapDays: 1, streak: 6, freezes: 0, freezeCap: cap)
    h.check("completing a week earns a freeze", week.streak == 7 && week.freezes == 1)

    let capped = StreakEngine.advance(gapDays: 1, streak: 13, freezes: cap, freezeCap: cap)
    h.check("freeze earning is capped", capped.streak == 14 && capped.freezes == cap)
}
