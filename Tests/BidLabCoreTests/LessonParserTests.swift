import BidLabCore

/// Tests for the lesson format parser.
func lessonParserTests(_ h: Harness) {
    let text = """
    ---
    id: dsp-02
    track: dsp
    module: 2
    title: Second-price auctions
    summary: Why truthful bidding wins.
    ---
    # The intuition

    In a second-price auction you pay the second highest bid.

    $$ E[\\pi] = P_{win}(b)(v - price) $$

    :::callout insight
    Truthful bidding is dominant.
    :::

    :::widget auctionSimulator
    mechanism: second-price
    competitors: 5
    :::

    :::quiz
    question: What should you bid?
    - Your true value
    - Half your value
    answer: 0
    explain: Truthful bidding is dominant.
    :::

    :::sources
    - OpenRTB 2.6 Specification | https://iabtechlab.com/standards/openrtb/
    :::
    """

    guard let lesson = LessonParser.parse(text) else {
        h.check("lesson parses", false)
        return
    }
    h.check("lesson parses", true)
    h.check("id", lesson.id == "dsp-02")
    h.check("track", lesson.track == "dsp")
    h.check("module", lesson.module == 2)
    h.check("title", lesson.title == "Second-price auctions")

    // Expect: heading, prose, math, callout, widget, quiz, sources.
    h.check("block count", lesson.blocks.count == 7)
    if case .heading(let t) = lesson.blocks[0] { h.check("heading text", t == "The intuition") } else { h.check("heading text", false) }
    if case .math(let m) = lesson.blocks[2] { h.check("math captured", m.contains("E[\\pi]")) } else { h.check("math captured", false) }
    if case .callout(let kind, let txt) = lesson.blocks[3] {
        h.check("callout kind", kind == "insight")
        h.check("callout text", txt == "Truthful bidding is dominant.")
    } else { h.check("callout parsed", false) }
    if case .widget(let type, let params) = lesson.blocks[4] {
        h.check("widget type", type == "auctionSimulator")
        h.check("widget param mechanism", params["mechanism"] == "second-price")
        h.check("widget param competitors", params["competitors"] == "5")
    } else { h.check("widget parsed", false) }

    h.check("one quiz", lesson.quizzes.count == 1)
    if let q = lesson.quizzes.first {
        h.check("quiz question", q.question == "What should you bid?")
        h.check("quiz options", q.options == ["Your true value", "Half your value"])
        h.check("quiz answer", q.answerIndex == 0)
    }

    h.check("one source", lesson.sources.count == 1)
    h.check("source url", lesson.sources.first?.url == "https://iabtechlab.com/standards/openrtb/")

    // No frontmatter id -> nil.
    h.check("missing id returns nil", LessonParser.parse("# just text") == nil)
}

/// Tests for the graded `:::predict` block and quiz `hint:` lines.
func predictParserTests(_ h: Harness) {
    let text = """
    ---
    id: dsp-99
    track: dsp
    module: 99
    title: Predict test
    summary: x
    ---
    :::predict
    prompt: A second-price auction has bids 8, 6, 5. What does the winner pay?
    answer: 6
    tolerance: 0.01
    unit: $
    hint: The winner does not pay their own bid.
    hint: They pay the second-highest bid.
    explain: In a second-price auction the winner pays the runner-up bid, 6.
    :::

    :::quiz
    question: What should you bid?
    - Your true value
    - Half your value
    answer: 0
    hint: Think about dominant strategies.
    explain: Truthful bidding is dominant.
    :::
    """

    guard let lesson = LessonParser.parse(text) else {
        h.check("predict lesson parses", false); return
    }
    h.check("predict lesson parses", true)

    let preds = lesson.predictions
    h.check("one prediction", preds.count == 1)
    if let p = preds.first {
        h.check("predict prompt", p.prompt.contains("second-price"))
        h.close("predict answer", p.answer, 6)
        h.close("predict tolerance", p.tolerance, 0.01)
        h.check("predict unit", p.unit == "$")
        h.check("predict two hints", p.hints.count == 2)
        h.check("predict correct within tol", p.isCorrect(6.005))
        h.check("predict wrong outside tol", !p.isCorrect(6.5))
        h.check("predict explanation", p.explanation.contains("runner-up"))
    }

    // Default tolerance is a 2% relative band when none is given.
    let relative = Prediction(prompt: "x", answer: 100, explanation: "y")
    h.close("default band is 2pct", relative.band, 2)
    h.check("default band inside", relative.isCorrect(101.9))
    h.check("default band outside", !relative.isCorrect(103))

    // A zero answer still gets a usable (tiny) band rather than dividing trouble.
    let zero = Prediction(prompt: "x", answer: 0, explanation: "y")
    h.check("zero answer exact", zero.isCorrect(0))
    h.check("zero answer rejects 1", !zero.isCorrect(1))

    // Quiz hints parse independently of options.
    if let q = lesson.quizzes.first {
        h.check("quiz hint parsed", q.hints == ["Think about dominant strategies."])
        h.check("quiz options intact", q.options == ["Your true value", "Half your value"])
    }
}

/// Tests for the `:::figure` block.
func figureParserTests(_ h: Harness) {
    let text = """
    ---
    id: x-01
    track: x
    module: 1
    title: Figure test
    summary: y
    ---
    :::figure displayAd
    caption: A 300x250 medium rectangle.
    :::
    """
    guard let lesson = LessonParser.parse(text) else { h.check("figure lesson parses", false); return }
    h.check("one figure block", lesson.blocks.count == 1)
    if case let .figure(name, caption) = lesson.blocks[0] {
        h.check("figure name", name == "displayAd")
        h.check("figure caption", caption == "A 300x250 medium rectangle.")
        h.check("figure name is known", Figures.known.contains(name))
    } else {
        h.check("figure parsed", false)
    }
    h.check("known figures non-empty", !Figures.known.isEmpty)
}
