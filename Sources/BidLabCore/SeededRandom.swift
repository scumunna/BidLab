/// A deterministic, seedable random number generator (SplitMix64).
///
/// Simulations must be reproducible: the same seed always yields the same run, so
/// lessons, the Trading Floor, and the scoring benchmark are stable and testable.
/// Conforms to `RandomNumberGenerator`, so it plugs into Swift's `random(in:using:)`.
public struct SeededRandom: RandomNumberGenerator {
    private var state: UInt64

    public init(seed: UInt64) {
        state = seed
    }

    public mutating func next() -> UInt64 {
        state = state &+ 0x9E37_79B9_7F4A_7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58_476D_1CE4_E5B9
        z = (z ^ (z >> 27)) &* 0x94D0_49BB_1331_11EB
        return z ^ (z >> 31)
    }
}
