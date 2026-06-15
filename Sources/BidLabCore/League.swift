import Foundation

/// One row in the weekly league.
public struct LeagueEntry: Equatable, Identifiable {
    public let name: String
    public let xp: Int
    public let isYou: Bool
    public var id: String { name }

    public init(name: String, xp: Int, isYou: Bool) {
        self.name = name
        self.xp = xp
        self.isYou = isYou
    }
}

/// A deterministic weekly XP league: the learner ranked among a synthetic
/// cohort. A ladder with a visible rank drives completion through loss aversion;
/// a solo ghost cohort captures most of that without a backend. The cohort is a
/// deterministic spread around the learner's XP, so the rank is stable per XP.
public enum League {
    private static let names = ["Ava", "Liam", "Noah", "Maya", "Kai", "Zoe", "Ivan", "Priya", "Diego", "Sana", "Omar", "Lena", "Reed", "Tara"]
    private static let factors = [1.9, 1.55, 1.3, 1.12, 0.95, 0.82, 0.68, 0.55, 0.4, 0.28, 0.18]

    public static func weekly(userXP: Int, size: Int = 10) -> [LeagueEntry] {
        var entries = [LeagueEntry(name: "You", xp: max(userXP, 0), isYou: true)]
        let base = Double(max(userXP, 60))
        for i in 0 ..< max(size - 1, 0) {
            let xp = max(20, Int((base * factors[i % factors.count]).rounded()) + i * 7)
            entries.append(LeagueEntry(name: names[i % names.count], xp: xp, isYou: false))
        }
        return entries.sorted { $0.xp > $1.xp }
    }
}
