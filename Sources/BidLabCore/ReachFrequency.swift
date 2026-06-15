import Foundation

/// Reach and frequency math for the Planning and DSP tracks.
///
/// The model treats impressions as randomly distributed across a population, so
/// the number of times any one person is hit follows a Poisson distribution with
/// mean `lambda = impressions / population`. Unique reach is then the share of
/// the population hit at least once.
public enum ReachFrequency {
    /// Expected unique reach: `population * (1 - e^(-impressions/population))`.
    public static func reach(population: Double, impressions: Double) -> Double {
        guard population > 0 else { return 0 }
        return population * (1 - exp(-impressions / population))
    }

    /// Average frequency among reached people: impressions / reach.
    public static func averageFrequency(population: Double, impressions: Double) -> Double {
        let r = reach(population: population, impressions: impressions)
        return r > 0 ? impressions / r : 0
    }

    /// Effective reach: people hit at least `minFrequency` times, via the Poisson
    /// tail `population * P(X >= minFrequency)`.
    public static func effectiveReach(population: Double, impressions: Double, minFrequency: Int) -> Double {
        guard population > 0 else { return 0 }
        guard minFrequency >= 1 else { return reach(population: population, impressions: impressions) }
        let lambda = impressions / population
        var belowCutoff = 0.0
        for k in 0..<minFrequency {
            belowCutoff += Probability.poissonPMF(k: k, lambda: lambda)
        }
        return population * (1 - belowCutoff)
    }

    /// Reach as a fraction (0...1) of the population.
    public static func reachFraction(population: Double, impressions: Double) -> Double {
        guard population > 0 else { return 0 }
        return reach(population: population, impressions: impressions) / population
    }
}
