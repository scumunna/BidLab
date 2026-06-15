import Foundation

/// Attribution credit allocation across an ordered set of touchpoints. Each
/// function returns a credit vector that sums to 1, so a single conversion is
/// distributed without inflating or losing credit.
public enum Attribution {
    /// All credit to the last touch.
    public static func lastTouch(_ n: Int) -> [Double] {
        guard n > 0 else { return [] }
        var v = Array(repeating: 0.0, count: n)
        v[n - 1] = 1
        return v
    }

    /// All credit to the first touch.
    public static func firstTouch(_ n: Int) -> [Double] {
        guard n > 0 else { return [] }
        var v = Array(repeating: 0.0, count: n)
        v[0] = 1
        return v
    }

    /// Equal credit across every touch.
    public static func linear(_ n: Int) -> [Double] {
        guard n > 0 else { return [] }
        return Array(repeating: 1.0 / Double(n), count: n)
    }

    /// U-shaped: the first and last touch each get `endsWeight`, the rest split
    /// the remainder evenly.
    public static func positionBased(_ n: Int, endsWeight: Double = 0.4) -> [Double] {
        guard n > 0 else { return [] }
        if n == 1 { return [1] }
        if n == 2 { return [0.5, 0.5] }
        var v = Array(repeating: 0.0, count: n)
        v[0] = endsWeight
        v[n - 1] = endsWeight
        let middle = (1 - 2 * endsWeight) / Double(n - 2)
        for i in 1..<(n - 1) { v[i] = middle }
        return v
    }
}
