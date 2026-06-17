// The BidLab auction engine — faithful TypeScript ports of the pure BidLabCore
// math. No UI, no DOM, no dependencies; the same logic that powers the native
// macOS Trading Floor.

export { SeededRandom } from './rng'
export { erf, normalCDF } from './mathx'
export * as Auction from './auction'
export * as Scoring from './scoring'
export * as Pricing from './pricing'
export {
  MarketConfig,
  MarketResult,
  runMarket,
  type MarketModel,
  type AuctionType,
  type MarketConfigParams,
} from './market'
export {
  SCENARIOS,
  OPPORTUNITIES,
  BUDGET_CAP,
  SEED,
  scenarioValue,
  type Scenario,
} from './scenarios'
