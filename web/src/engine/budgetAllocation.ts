// Port of BidLabCore/BudgetAllocation.swift. A diminishing-returns response curve
// per channel, and greedy equimarginal allocation: hand each small increment of
// budget to whichever channel currently has the highest marginal response. Since
// every marginal curve strictly decreases, this converges to the equimarginal
// optimum where all funded channels share the same marginal return.

export class ResponseCurve {
  readonly saturation: number
  readonly scale: number

  constructor(saturation: number, scale: number) {
    this.saturation = saturation
    this.scale = Math.max(scale, 1e-9)
  }

  /** `response(spend) = saturation * (1 - e^(-spend/scale))`. */
  response(spend: number): number {
    return this.saturation * (1 - Math.exp(-Math.max(0, spend) / this.scale))
  }

  /** Marginal response per extra dollar at the current spend. */
  marginal(spend: number): number {
    return (this.saturation / this.scale) * Math.exp(-Math.max(0, spend) / this.scale)
  }
}

/** Greedy marginal allocation across channels under diminishing returns. */
export function allocate(budget: number, channels: ResponseCurve[], steps = 2000): number[] {
  const allocation = new Array<number>(channels.length).fill(0)
  if (!(budget > 0) || channels.length === 0 || steps <= 0) return allocation
  const increment = budget / steps
  for (let step = 0; step < steps; step++) {
    let bestIndex = 0
    let bestMarginal = -Number.MAX_VALUE
    for (let i = 0; i < channels.length; i++) {
      const m = channels[i].marginal(allocation[i])
      if (m > bestMarginal) {
        bestMarginal = m
        bestIndex = i
      }
    }
    allocation[bestIndex] += increment
  }
  return allocation
}

/** Total response produced by an allocation. */
export function totalResponse(allocation: number[], channels: ResponseCurve[]): number {
  return allocation.reduce((acc, a, i) => acc + channels[i].response(a), 0)
}
