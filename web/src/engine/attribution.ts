// Port of BidLabCore/Attribution.swift. Each function returns a credit vector
// over an ordered set of touchpoints that sums to 1 — one conversion distributed
// without inflating or losing credit.

/** All credit to the last touch. */
export function lastTouch(n: number): number[] {
  if (!(n > 0)) return []
  const v = new Array<number>(n).fill(0)
  v[n - 1] = 1
  return v
}

/** All credit to the first touch. */
export function firstTouch(n: number): number[] {
  if (!(n > 0)) return []
  const v = new Array<number>(n).fill(0)
  v[0] = 1
  return v
}

/** Equal credit across every touch. */
export function linear(n: number): number[] {
  if (!(n > 0)) return []
  return new Array<number>(n).fill(1 / n)
}

/** U-shaped: first and last touch each get `endsWeight`; the rest split the rest. */
export function positionBased(n: number, endsWeight = 0.4): number[] {
  if (!(n > 0)) return []
  if (n === 1) return [1]
  if (n === 2) return [0.5, 0.5]
  const v = new Array<number>(n).fill(0)
  v[0] = endsWeight
  v[n - 1] = endsWeight
  const middle = (1 - 2 * endsWeight) / (n - 2)
  for (let i = 1; i < n - 1; i++) v[i] = middle
  return v
}
