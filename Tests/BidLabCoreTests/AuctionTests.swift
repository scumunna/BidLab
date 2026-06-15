import BidLabCore

/// Known-answer tests for auction mechanics and bid optimization.
func auctionTests(_ h: Harness) {
    // Second-price: bid 6 beats competitors [3,5], pay the second price (5), profit 10-5=5.
    let winSP = Auction.secondPrice(bid: 6, value: 10, competingBids: [3, 5])
    h.check("second-price wins", winSP.won)
    h.close("second-price pays clearing", winSP.pricePaid, 5)
    h.close("second-price profit", winSP.profit, 5)

    // Second-price: bid 4 loses to a 5 competitor.
    h.check("second-price loses below market", !Auction.secondPrice(bid: 4, value: 10, competingBids: [3, 5]).won)

    // First-price: bid 7 beats [3,5], pays its own bid, profit 10-7=3.
    let winFP = Auction.firstPrice(bid: 7, value: 10, competingBids: [3, 5])
    h.check("first-price wins", winFP.won)
    h.close("first-price pays own bid", winFP.pricePaid, 7)
    h.close("first-price profit", winFP.profit, 3)

    h.close("clearing price is max competitor", Auction.clearingPrice(competingBids: [3, 5, 1]), 5)

    // Expected profit with a linear win curve P(win)=min(b/20,1):
    // E[profit](b) = (b/20)(10-b), maximized at b=5 with value 1.25.
    let winCurve: (Double) -> Double = { min($0 / 20.0, 1.0) }
    h.close("expected profit at b=5", Auction.expectedProfit(bid: 5, value: 10, winProbability: winCurve), 1.25, tol: 1e-9)
    let opt = Auction.optimalFirstPriceBid(value: 10, steps: 1000, winProbability: winCurve)
    h.close("optimal first-price bid ~ 5", opt.bid, 5, tol: 0.05)
    h.close("optimal expected profit ~ 1.25", opt.expectedProfit, 1.25, tol: 0.01)

    // Shading: optimal bid 5 on value 10 is a 50% shade.
    h.close("shade factor", Auction.shadeFactor(optimalBid: 5, value: 10), 0.5)

    // Edge cases: a tie loses (strictly greater bid required), no competitors wins.
    h.check("tie loses", !Auction.secondPrice(bid: 5, value: 10, competingBids: [5]).won)
    h.check("no competitors wins", Auction.firstPrice(bid: 1, value: 10, competingBids: []).won)
    h.close("clearing price with no competitors", Auction.clearingPrice(competingBids: []), 0)
}
