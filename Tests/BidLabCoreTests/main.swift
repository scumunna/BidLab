import Foundation

// Entry point for the manual test runner. Each `*Tests(_:)` function registers
// its known-answer checks against the shared harness. Add new suites here.
let harness = Harness()

pricingTests(harness)
auctionTests(harness)
probabilityTests(harness)
statisticsTests(harness)
reachFrequencyTests(harness)
budgetAllocationTests(harness)
pacingTests(harness)
simulationTests(harness)
scoringTests(harness)
lessonParserTests(harness)
predictParserTests(harness)
figureParserTests(harness)
reviewTests(harness)
streakTests(harness)
leagueTests(harness)
credentialTests(harness)
benchmarksTests(harness)
verticalsTests(harness)
examTests(harness)
examValidationTests(harness)
analyticsTests(harness)
systemsTests(harness)
attributionTests(harness)
contentValidationTests(harness)

exit(harness.summary())
