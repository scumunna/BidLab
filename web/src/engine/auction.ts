// Port of BidLabCore/Auction.swift — auction mechanics and bid optimization.
// Every formula is explicit so the transparency panel can show the exact math.

export interface AuctionOutcome {
  won: boolean
  pricePaid: number
  profit: number
}

export const LOST: AuctionOutcome = { won: false, pricePaid: 0, profit: 0 }

/** The clearing price you face: the highest competing bid. */
export function clearingPrice(competingBids: number[]): number {
  return competingBids.length ? Math.max(...competingBids) : 0
}

/**
 * Second-price (Vickrey) auction. You win when your bid beats every competing bid
 * and pay the highest competing bid. Truthful bidding (`bid == value`) is optimal.
 */
export function secondPrice(
  bid: number,
  value: number,
  competingBids: number[],
): AuctionOutcome {
  const market = clearingPrice(competingBids)
  if (!(bid > market)) return LOST
  return { won: true, pricePaid: market, profit: value - market }
}

/**
 * First-price auction. You win when your bid beats every competing bid and pay
 * your own bid. Surplus is `value - bid`, so optimal play shades below value.
 */
export function firstPrice(
  bid: number,
  value: number,
  competingBids: number[],
): AuctionOutcome {
  const market = clearingPrice(competingBids)
  if (!(bid > market)) return LOST
  return { won: true, pricePaid: bid, profit: value - bid }
}

/** Expected profit of a first-price bid: `P_win(bid) * (value - bid)`. */
export function expectedProfit(
  bid: number,
  value: number,
  winProbability: (b: number) => number,
): number {
  return winProbability(bid) * (value - bid)
}

/**
 * The profit-maximizing first-price bid for a win-probability curve, found by a
 * dense scan over `0...value`.
 */
export function optimalFirstPriceBid(
  value: number,
  winProbability: (b: number) => number,
  steps = 1000,
): { bid: number; expectedProfit: number } {
  if (!(value > 0) || steps <= 0) return { bid: 0, expectedProfit: 0 }
  let bestBid = 0
  let bestProfit = -Number.MAX_VALUE
  for (let i = 0; i <= steps; i++) {
    const bid = (value * i) / steps
    const profit = expectedProfit(bid, value, winProbability)
    if (profit > bestProfit) {
      bestProfit = profit
      bestBid = bid
    }
  }
  return { bid: bestBid, expectedProfit: bestProfit }
}

/** Bid shading factor: how far below value the optimal bid sits, in `0...1`. */
export function shadeFactor(optimalBid: number, value: number): number {
  return value > 0 ? Math.max(0, Math.min(1, (value - optimalBid) / value)) : 0
}
