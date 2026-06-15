import BidLabCore

/// Known-answer tests for budget pacing.
func pacingTests(_ h: Harness) {
    h.close("target spend at half flight", Pacing.targetSpend(totalBudget: 1000, fractionElapsed: 0.5), 500)
    h.close("target spend clamps at end", Pacing.targetSpend(totalBudget: 1000, fractionElapsed: 1.4), 1000)

    // On pace -> throttle is the base of 1.0.
    h.close("throttle on pace", Pacing.throttle(targetSpend: 500, actualSpend: 500), 1.0)
    // Behind pace by half the target -> throttle 1 + 0.5 = 1.5.
    h.close("throttle behind pace", Pacing.throttle(targetSpend: 500, actualSpend: 250), 1.5)
    // Far ahead of pace -> clamped at the lower bound of 0.
    h.close("throttle clamps when ahead", Pacing.throttle(targetSpend: 500, actualSpend: 2000), 0.0)

    h.check("ahead of pace detected", Pacing.isAheadOfPace(totalBudget: 1000, actualSpend: 600, fractionElapsed: 0.5))
    h.check("behind pace detected", !Pacing.isAheadOfPace(totalBudget: 1000, actualSpend: 400, fractionElapsed: 0.5))
}
