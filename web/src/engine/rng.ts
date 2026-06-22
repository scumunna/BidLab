// Faithful TypeScript port of BidLabCore/SeededRandom.swift (SplitMix64).
//
// Swift implements this with UInt64 wrapping arithmetic. JavaScript numbers can't
// hold 64-bit integers exactly, so we reproduce it with BigInt masked to 64 bits.
// This makes runs reproducible for a given seed — and bit-identical to the native
// app's RNG stream (verified by the golden-master test).

const MASK64 = (1n << 64n) - 1n
const MASK53 = (1n << 53n) - 1n
const GAMMA = 0x9e3779b97f4a7c15n
const MIX1 = 0xbf58476d1ce4e5b9n
const MIX2 = 0x94d049bb133111ebn
const TWO_53 = 9007199254740992 // 2^53

export class SeededRandom {
  private state: bigint

  constructor(seed: bigint) {
    this.state = seed & MASK64
  }

  /** One 64-bit draw (SplitMix64), matching Swift's `next()`. */
  next(): bigint {
    this.state = (this.state + GAMMA) & MASK64
    let z = this.state
    z = ((z ^ (z >> 30n)) * MIX1) & MASK64
    z = ((z ^ (z >> 27n)) * MIX2) & MASK64
    return (z ^ (z >> 31n)) & MASK64
  }

  /**
   * Reproduces Swift's `Double.random(in: 0..<1, using:)`: one draw, scaled into
   * [0, 1) by its low 53 significand bits — `Double(next() & (2^53 - 1)) / 2^53`.
   * (Verified bit-for-bit against the native engine's stream in the golden-master
   * test; Swift's stdlib uses the low significand bits, not the high word.)
   */
  unitDouble(): number {
    return Number(this.next() & MASK53) / TWO_53
  }
}
