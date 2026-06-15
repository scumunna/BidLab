import BidLabCore

/// Tests for attribution credit allocation. Every model must distribute exactly
/// one conversion's worth of credit.
func attributionTests(_ h: Harness) {
    h.check("last touch", Attribution.lastTouch(4) == [0, 0, 0, 1])
    h.check("first touch", Attribution.firstTouch(4) == [1, 0, 0, 0])

    let linear = Attribution.linear(4)
    h.close("linear each", linear[0], 0.25)
    h.close("linear sums to 1", linear.reduce(0, +), 1.0, tol: 1e-9)

    let u = Attribution.positionBased(4, endsWeight: 0.4)
    h.close("position-based first", u[0], 0.4)
    h.close("position-based last", u[3], 0.4)
    h.close("position-based middle 1", u[1], 0.1)
    h.close("position-based middle 2", u[2], 0.1)
    h.close("position-based sums to 1", u.reduce(0, +), 1.0, tol: 1e-9)

    // Every model sums to 1 for a range of path lengths.
    for n in 1...8 {
        h.close("lastTouch sums to 1 (n=\(n))", Attribution.lastTouch(n).reduce(0, +), 1.0, tol: 1e-9)
        h.close("linear sums to 1 (n=\(n))", Attribution.linear(n).reduce(0, +), 1.0, tol: 1e-9)
        h.close("positionBased sums to 1 (n=\(n))", Attribution.positionBased(n).reduce(0, +), 1.0, tol: 1e-9)
    }
}
