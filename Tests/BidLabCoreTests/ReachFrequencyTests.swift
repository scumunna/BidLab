import BidLabCore

/// Known-answer tests for the reach and frequency model.
func reachFrequencyTests(_ h: Harness) {
    // population 1,000, impressions 1,000 -> lambda = 1.
    // reach = 1000 * (1 - e^-1) = 632.1206
    h.close("reach at lambda=1", ReachFrequency.reach(population: 1000, impressions: 1000), 632.1205588, tol: 1e-4)
    h.close("reach fraction", ReachFrequency.reachFraction(population: 1000, impressions: 1000), 0.6321205588, tol: 1e-7)

    // average frequency = impressions / reach = 1000 / 632.12 = 1.58198
    h.close("average frequency", ReachFrequency.averageFrequency(population: 1000, impressions: 1000), 1.581976707, tol: 1e-5)

    // effective reach at 1+ equals plain reach.
    h.close("effective reach 1+ equals reach",
            ReachFrequency.effectiveReach(population: 1000, impressions: 1000, minFrequency: 1),
            ReachFrequency.reach(population: 1000, impressions: 1000), tol: 1e-6)

    // effective reach at 2+ = 1000 * (1 - 2e^-1) = 264.2411
    h.close("effective reach 2+", ReachFrequency.effectiveReach(population: 1000, impressions: 1000, minFrequency: 2), 264.2411177, tol: 1e-4)

    // Edge cases.
    h.close("zero impressions reach zero", ReachFrequency.reach(population: 1000, impressions: 0), 0)
    h.close("zero population reach zero", ReachFrequency.reach(population: 0, impressions: 1000), 0)
    h.close("average frequency with zero reach", ReachFrequency.averageFrequency(population: 1000, impressions: 0), 0)
}
