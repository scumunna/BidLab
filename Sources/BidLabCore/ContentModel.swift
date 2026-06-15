import Foundation

/// A cited source backing a lesson claim or benchmark number.
public struct Source: Equatable {
    public let title: String
    public let url: String
    public init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}

/// A multiple-choice knowledge check.
public struct QuizQuestion: Equatable {
    public let question: String
    public let options: [String]
    public let answerIndex: Int
    public let explanation: String
    public let hints: [String]

    public init(question: String, options: [String], answerIndex: Int, explanation: String, hints: [String] = []) {
        self.question = question
        self.options = options
        self.answerIndex = answerIndex
        self.explanation = explanation
        self.hints = hints
    }
}

/// A graded numeric estimation. The learner predicts a value, then sees whether
/// the guess landed within tolerance, the exact answer, and the reasoning. This
/// is the active-problem-solving core: commit an answer before the reveal.
public struct Prediction: Equatable {
    public let prompt: String
    public let answer: Double
    public let tolerance: Double   // absolute band; if <= 0, a 2% relative band is used
    public let unit: String        // "$", "%", "x", or ""
    public let hints: [String]
    public let explanation: String

    public init(prompt: String, answer: Double, tolerance: Double = 0, unit: String = "", hints: [String] = [], explanation: String) {
        self.prompt = prompt
        self.answer = answer
        self.tolerance = tolerance
        self.unit = unit
        self.hints = hints
        self.explanation = explanation
    }

    /// The effective tolerance: the absolute band if provided, otherwise 2% of
    /// the answer (with a tiny floor so an answer of 0 still has a usable band).
    public var band: Double {
        tolerance > 0 ? tolerance : max(abs(answer) * 0.02, 1e-6)
    }

    /// Whether a guess lands within the tolerance band of the answer.
    public func isCorrect(_ guess: Double) -> Bool {
        abs(guess - answer) <= band + 1e-9
    }
}

/// One renderable unit of a lesson. Lessons are authored as data (see
/// `LessonParser`) and decode into an ordered list of these blocks, which the
/// SwiftUI renderer walks. This is the native analog of MDX: prose, math, and
/// inline interactive widgets in one stream.
public enum ContentBlock: Equatable {
    case heading(String)
    case prose(String)
    case math(String)                              // display LaTeX
    case code(String)                              // fenced code block
    case callout(kind: String, text: String)       // kind: insight | warning | note
    case widget(type: String, params: [String: String])
    case quiz(QuizQuestion)
    case predict(Prediction)
    case figure(name: String, caption: String)
    case sources([Source])
}

/// A single lesson: metadata plus an ordered list of content blocks.
public struct Lesson: Equatable {
    public let id: String
    public let track: String
    public let module: Int
    public let title: String
    public let summary: String
    public let blocks: [ContentBlock]

    public init(id: String, track: String, module: Int, title: String, summary: String, blocks: [ContentBlock]) {
        self.id = id
        self.track = track
        self.module = module
        self.title = title
        self.summary = summary
        self.blocks = blocks
    }

    /// All sources cited anywhere in the lesson.
    public var sources: [Source] {
        blocks.flatMap { block -> [Source] in
            if case let .sources(list) = block { return list }
            return []
        }
    }

    /// All quiz questions in the lesson.
    public var quizzes: [QuizQuestion] {
        blocks.compactMap { block in
            if case let .quiz(question) = block { return question }
            return nil
        }
    }

    /// All numeric predictions in the lesson.
    public var predictions: [Prediction] {
        blocks.compactMap { block in
            if case let .predict(prediction) = block { return prediction }
            return nil
        }
    }
}
