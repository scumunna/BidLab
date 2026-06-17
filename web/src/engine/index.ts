// The BidLab auction engine — faithful TypeScript ports of the pure BidLabCore
// math. No UI, no DOM, no dependencies; the same logic that powers the native
// macOS Trading Floor.

export { SeededRandom } from './rng'
export { erf, normalCDF } from './mathx'
export * as Auction from './auction'
export * as Scoring from './scoring'
export * as Pricing from './pricing'
export * as Probability from './probability'
export * as ReachFrequency from './reachFrequency'
export * as Analytics from './analytics'
export {
  MarketConfig,
  MarketResult,
  runMarket,
  type MarketModel,
  type AuctionType,
  type MarketConfigParams,
} from './market'
export * as Pacing from './pacing'
export { runPacedFlight, PacedFlightResult, type IntervalPoint } from './pacedFlight'
export {
  SCENARIOS,
  OPPORTUNITIES,
  BUDGET_CAP,
  SEED,
  scenarioValue,
  type Scenario,
} from './scenarios'
