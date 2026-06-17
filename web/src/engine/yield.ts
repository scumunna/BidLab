// Publisher-side yield: the floor / fill tradeoff, ported from the native
// YieldExplorer. Demand whose clearing prices average `meanDemandCPM` forms an
// exponential pool, so a floor of `f` fills the share e^(-f/mean) and each filled
// impression earns the floor. Revenue therefore peaks at floor = mean: below it
// you leave price on the table, above it fill collapses faster than price rises.

/** Fill rate at a given floor: `e^(-floor / mean demand CPM)`. */
export function fillRate(meanDemandCPM: number, floorCPM: number): number {
  return Math.exp(-floorCPM / Math.max(meanDemandCPM, 0.1))
}

/** Filled impressions out of available inventory. */
export function filledImpressions(avails: number, meanDemandCPM: number, floorCPM: number): number {
  return avails * fillRate(meanDemandCPM, floorCPM)
}

/** Revenue: filled impressions priced at the floor CPM. */
export function revenue(avails: number, meanDemandCPM: number, floorCPM: number): number {
  return (filledImpressions(avails, meanDemandCPM, floorCPM) / 1000) * floorCPM
}

/** The yield-maximizing floor — the argmax of `floor · e^(-floor/mean)` is `mean`. */
export function optimalFloor(meanDemandCPM: number): number {
  return meanDemandCPM
}
