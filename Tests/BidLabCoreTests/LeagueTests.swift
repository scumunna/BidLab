import BidLabCore

/// Tests for the weekly XP league.
func leagueTests(_ h: Harness) {
    let league = League.weekly(userXP: 200, size: 10)
    h.check("league has requested size", league.count == 10)
    h.check("league includes you", league.contains { $0.isYou })
    h.check("your xp is preserved", league.first { $0.isYou }?.xp == 200)
    h.check("sorted descending by xp", zip(league, league.dropFirst()).allSatisfy { $0.xp >= $1.xp })
    h.check("deterministic for the same xp", League.weekly(userXP: 200) == League.weekly(userXP: 200))

    let small = League.weekly(userXP: 0, size: 5)
    h.check("respects a smaller size", small.count == 5)
    h.check("no negative xp", small.allSatisfy { $0.xp >= 0 })
    h.check("you still present at zero xp", small.contains { $0.isYou })

    // A higher-XP learner ranks at least as well as a lower-XP one.
    let lowRank = (League.weekly(userXP: 50).firstIndex { $0.isYou } ?? 99)
    let highRank = (League.weekly(userXP: 5000).firstIndex { $0.isYou } ?? 99)
    h.check("more xp ranks higher", highRank <= lowRank)

    // Identifiable conformance: a league entry's id is its name.
    h.check("league entry id is its name", LeagueEntry(name: "Ava", xp: 100, isYou: false).id == "Ava")
}
