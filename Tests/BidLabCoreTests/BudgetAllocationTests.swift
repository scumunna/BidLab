import BidLabCore

/// Known-answer tests for response curves and budget allocation.
func budgetAllocationTests(_ h: Harness) {
    let curve = ResponseCurve(saturation: 100, scale: 50)
    // response(0) = 0, response(50) = 100*(1-e^-1) = 63.212
    h.close("response at 0", curve.response(0), 0)
    h.close("response at scale", curve.response(50), 63.21205588, tol: 1e-5)
    // marginal(0) = saturation/scale = 2
    h.close("marginal at 0", curve.marginal(0), 2.0)

    // Two identical channels should split a budget roughly evenly.
    let identical = [ResponseCurve(saturation: 100, scale: 50), ResponseCurve(saturation: 100, scale: 50)]
    let split = BudgetAllocation.allocate(budget: 100, channels: identical, steps: 2000)
    h.close("identical channels split evenly (ch0)", split[0], 50, tol: 0.2)
    h.close("identical channels split evenly (ch1)", split[1], 50, tol: 0.2)

    // A higher-saturation channel should receive more of the budget.
    let mixed = [ResponseCurve(saturation: 200, scale: 50), ResponseCurve(saturation: 100, scale: 50)]
    let mixedAlloc = BudgetAllocation.allocate(budget: 100, channels: mixed, steps: 2000)
    h.check("higher-saturation channel gets more", mixedAlloc[0] > mixedAlloc[1])

    // Equimarginal allocation beats an even split for the mixed case.
    let optimal = BudgetAllocation.totalResponse(allocation: mixedAlloc, channels: mixed)
    let even = BudgetAllocation.totalResponse(allocation: [50, 50], channels: mixed)
    h.check("optimal allocation beats even split", optimal >= even)
}
