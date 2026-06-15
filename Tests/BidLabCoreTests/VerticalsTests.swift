import BidLabCore

/// Tests that the vertical catalog is complete, cited, and well-formed.
func verticalsTests(_ h: Harness) {
    let all = Verticals.all
    h.check("eleven verticals", all.count == 11)
    h.check("ids unique", Set(all.map(\.id)).count == 11)
    h.check("all named", all.allSatisfy { !$0.name.isEmpty })
    h.check("all have a blurb", all.allSatisfy { !$0.blurb.isEmpty })
    h.check("all have a signature KPI and formula", all.allSatisfy { !$0.signatureKPI.isEmpty && !$0.signatureFormula.isEmpty })
    h.check("all have a cited anchor", all.allSatisfy { !$0.anchorLabel.isEmpty && !$0.anchorValue.isEmpty })
    h.check("all have a scenario", all.allSatisfy { !$0.scenario.isEmpty })
    h.check("all cited", all.allSatisfy { !$0.citation.source.isEmpty })
    h.check("verified verticals carry URLs", all.allSatisfy { !$0.citation.verified || !$0.citation.url.isEmpty })

    h.check("byID resolves retail", Verticals.byID("retail")?.name == "Retail")
    h.check("byID nil for unknown", Verticals.byID("nope") == nil)

    let ids = Set(all.map(\.id))
    h.check("covers all named industries",
            ids.isSuperset(of: ["retail", "cpg", "ecommerce", "dtc", "auto", "finance", "travel", "telecom", "healthcare", "qsr", "b2b"]))

    // No em dashes in user-facing vertical strings.
    let strings = all.flatMap { [$0.name, $0.blurb, $0.signatureFormula, $0.anchorLabel, $0.anchorValue, $0.scenario] }
    h.check("no em dashes in verticals", strings.allSatisfy { !$0.contains("\u{2014}") })
}
