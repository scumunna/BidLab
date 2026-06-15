import BidLabCore

/// Tests that the benchmark catalog is well-formed and cited.
func benchmarksTests(_ h: Harness) {
    let catalog = Benchmarks.catalog
    h.check("catalog non-empty", catalog.count >= 12)
    h.check("keys unique", Set(catalog.map(\.key)).count == catalog.count)
    h.check("all have labels", catalog.allSatisfy { !$0.label.isEmpty })
    h.check("all have values", catalog.allSatisfy { !$0.value.isEmpty })
    h.check("all have a source", catalog.allSatisfy { !$0.citation.source.isEmpty })

    // Verified figures must carry a real URL; directional ones may omit it.
    h.check("verified figures carry URLs", catalog.allSatisfy { !$0.citation.verified || !$0.citation.url.isEmpty })

    // Categories cover the catalog with no orphans.
    h.check("categories non-empty", !Benchmarks.categories.isEmpty)
    h.check("every figure in a listed category", catalog.allSatisfy { Benchmarks.categories.contains($0.category) })
    h.check("inCategory matches", Benchmarks.inCategory(Benchmarks.categories[0]).allSatisfy { $0.category == Benchmarks.categories[0] })

    // Spot-check anchors that the course leans on.
    h.check("CTV viewability is 93%", catalog.contains { $0.key == "view_ctv" && $0.value == "93%" })
    h.check("cookies still on in Chrome", catalog.contains { $0.key == "priv_cookies" })
    h.check("soft CPM marked directional", catalog.first { $0.key == "cpm_display" }?.citation.verified == false)

    // No em dashes in user-facing benchmark strings.
    let strings = catalog.flatMap { [$0.label, $0.value, $0.detail, $0.citation.note ?? ""] }
    h.check("no em dashes in figures", strings.allSatisfy { !$0.contains("\u{2014}") })
}
