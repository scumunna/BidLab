import BidLabCore

/// Tests for stable identifiers and the spaced-repetition ladder.
func reviewTests(_ h: Harness) {
    // StableID is deterministic across calls and distinguishes different strings.
    h.check("stable key deterministic", StableID.key("abc") == StableID.key("abc"))
    h.check("stable key distinct", StableID.key("abc") != StableID.key("abd"))
    h.check("stable key nonempty", !StableID.key("anything").isEmpty)

    // The mastery ladder climbs on correct and resets on a miss.
    h.check("correct climbs from 0", SpacedRepetition.advance(stage: 0, correct: true) == 1)
    h.check("correct climbs from 1", SpacedRepetition.advance(stage: 1, correct: true) == 2)
    h.check("miss resets to 0", SpacedRepetition.advance(stage: 3, correct: false) == 0)
    h.check("caps at max stage",
            SpacedRepetition.advance(stage: SpacedRepetition.maxStage, correct: true) == SpacedRepetition.maxStage)

    // Intervals grow with stage and clamp out-of-range stages instead of crashing.
    h.check("stage 0 is 1 day", SpacedRepetition.days(forStage: 0) == 1)
    h.check("stage 1 is 3 days", SpacedRepetition.days(forStage: 1) == 3)
    h.check("stage 2 is 7 days", SpacedRepetition.days(forStage: 2) == 7)
    h.check("clamp high stage", SpacedRepetition.days(forStage: 99) == SpacedRepetition.intervalDays.last!)
    h.check("clamp low stage", SpacedRepetition.days(forStage: -5) == SpacedRepetition.intervalDays.first!)

    // Graduation only at the final stage.
    h.check("graduated at max", SpacedRepetition.isGraduated(stage: SpacedRepetition.maxStage))
    h.check("not graduated below max", !SpacedRepetition.isGraduated(stage: 0))

    // Review keys are stable, typed, and prompt-specific.
    let quiz = QuizQuestion(question: "What pays?", options: ["a", "b"], answerIndex: 0, explanation: "x")
    let pred = Prediction(prompt: "Estimate the CPM", answer: 5, explanation: "y")
    h.check("quiz key stable", quiz.reviewKey(lessonID: "dsp-02") == quiz.reviewKey(lessonID: "dsp-02"))
    h.check("quiz key namespaced", quiz.reviewKey(lessonID: "dsp-02").hasPrefix("quiz:dsp-02:"))
    h.check("predict key namespaced", pred.reviewKey(lessonID: "dsp-02").hasPrefix("predict:dsp-02:"))
    h.check("quiz and predict keys differ", quiz.reviewKey(lessonID: "x") != pred.reviewKey(lessonID: "x"))
}
