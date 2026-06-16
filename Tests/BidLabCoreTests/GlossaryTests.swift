import BidLabCore

/// Tests for the glossary reference and its search.
func glossaryTests(_ h: Harness) {
    h.check("glossary is populated", Glossary.all.count >= 25)
    h.check("an empty query returns every term", Glossary.search("").count == Glossary.all.count)

    // Headword match.
    let cpm = Glossary.search("cpm")
    h.check("search finds CPM by headword", cpm.contains { $0.term == "CPM" })
    h.check("CPM carries a formula", Glossary.all.first { $0.term == "CPM" }?.formula != nil)

    // Case-insensitive.
    h.check("search is case-insensitive", Glossary.search("Roas").contains { $0.term == "ROAS" })

    // Body-only match: "MRC" appears only in the Viewability definition.
    h.check("search matches the definition body", Glossary.search("MRC").contains { $0.term == "Viewability" })

    // Headword matches rank ahead of body-only matches.
    let floor = Glossary.search("floor")
    h.check("a headword match ranks first", floor.first?.term == "Floor")
    h.check("a body match is still included", floor.contains { $0.term == "Win rate" })

    // A term with no formula stays nil.
    h.check("RTB has no formula", Glossary.all.first { $0.term == "RTB" }?.formula == nil)

    // Categories are distinct and non-empty.
    h.check("categories are non-empty", !Glossary.categories.isEmpty)
    h.check("categories are distinct", Glossary.categories.count == Set(Glossary.categories).count)

    // No duplicate headwords.
    let terms = Glossary.all.map { $0.term }
    h.check("no duplicate headwords", terms.count == Set(terms).count)
}
