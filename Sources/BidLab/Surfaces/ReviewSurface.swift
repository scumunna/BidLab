import BidLabCore
import SwiftUI

/// The spaced-repetition surface. It resurfaces graded questions the learner has
/// already met, on expanding intervals, and gathers recent mistakes into one
/// place. This is the return loop that turns a linear course into durable memory.
struct ReviewSurface: View {
    @EnvironmentObject var app: AppState
    @EnvironmentObject var progress: ProgressStore

    @Local private var queue: [ReviewRecord] = []
    @Local private var index = 0
    @Local private var answered = false
    @Local private var session = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                if session { sessionView } else { overview }
            }
            .padding(40)
            .frame(maxWidth: 820)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: Overview

    private var overview: some View {
        VStack(alignment: .leading, spacing: 22) {
            VStack(alignment: .leading, spacing: 8) {
                Pill(text: "SPACED REPETITION", color: Brand.violet)
                Text("Review").font(.brandDisplay(30, .heavy)).foregroundStyle(Brand.ink)
                Text("Come back to what you have learned, right before you would forget it. Reviewing on expanding intervals is how it sticks.")
                    .font(.brandRounded(15, .regular)).foregroundStyle(Brand.muted)
                    .fixedSize(horizontal: false, vertical: true)
            }

            HStack(spacing: 14) {
                statCard("Due now", "\(progress.dueReviewCount)", Brand.violet)
                statCard("Mistakes", "\(progress.mistakeRecords.count)", Brand.down)
                statCard("Tracked", "\(progress.reviews.count)", Brand.muted)
            }

            if progress.dueReviewCount > 0 {
                PrimaryButton("Start review (\(progress.dueReviewCount))", icon: "arrow.clockwise", color: Brand.violet) {
                    start(with: progress.dueReviewRecords)
                }
            } else if !progress.mistakeRecords.isEmpty {
                PrimaryButton("Practice \(progress.mistakeRecords.count) mistakes", icon: "arrow.uturn.left", color: Brand.down) {
                    start(with: progress.mistakeRecords)
                }
            } else {
                emptyState
            }
        }
    }

    private var emptyState: some View {
        GuidedEmptyState(
            icon: "checkmark.seal.fill",
            title: progress.reviews.isEmpty ? "No reviews yet" : "All caught up",
            message: progress.reviews.isEmpty
                ? "Answer the questions inside lessons and they appear here on a spaced schedule, so what you learn sticks."
                : "Nothing is due right now. The items you got right will return later, spaced further out.",
            accent: Brand.up,
            ctaTitle: progress.reviews.isEmpty ? "Start a lesson" : nil,
            action: progress.reviews.isEmpty ? { app.surface = .learn } : nil
        )
    }

    private func statCard(_ label: String, _ value: String, _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value).font(.brandDisplay(28, .heavy)).foregroundStyle(color)
            Text(label).font(.brandRounded(12.5, .medium)).foregroundStyle(Brand.muted)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    // MARK: Session

    @ViewBuilder
    private var sessionView: some View {
        if index >= queue.count {
            completeView
        } else if let record = queue[safe: index], let block = block(for: record) {
            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    Text("Review").font(.brandMono(12, .semibold)).foregroundStyle(Brand.violet).tracking(1)
                    Spacer()
                    Text("\(index + 1) / \(queue.count)").font(.brandMono(12, .semibold)).foregroundStyle(Brand.muted)
                }
                if let lesson = LessonLibrary.lesson(id: record.lessonID) {
                    Text("From: \(lesson.title)").font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.faint)
                }
                itemView(block, record: record).id(record.key)
                if answered {
                    PrimaryButton(index + 1 >= queue.count ? "Finish" : "Next", icon: "arrow.right", color: Brand.violet) {
                        withAnimation(.easeInOut(duration: 0.2)) { index += 1; answered = false }
                    }
                }
            }
        } else {
            // The lesson was edited and this item no longer resolves; skip it.
            Color.clear.onAppear { withAnimation { index += 1; answered = false } }
        }
    }

    @ViewBuilder
    private func itemView(_ block: ContentBlock, record: ReviewRecord) -> some View {
        switch block {
        case let .quiz(quiz):
            QuizView(quiz: quiz, onResult: { handle(record, $0) })
        case let .predict(prediction):
            PredictView(prediction: prediction, onResult: { handle(record, $0) })
        default:
            EmptyView()
        }
    }

    private var completeView: some View {
        VStack(spacing: 14) {
            Image(systemName: "checkmark.seal.fill").font(.system(size: 44, weight: .bold)).foregroundStyle(Brand.up)
            Text("Review complete").font(.brandDisplay(24, .heavy)).foregroundStyle(Brand.ink)
            Text("Nicely done. The ones you got right will come back later, spaced further out.")
                .font(.brandRounded(14, .regular)).foregroundStyle(Brand.muted).multilineTextAlignment(.center)
            Button("Back to review") { withAnimation { session = false } }
                .buttonStyle(.plain)
                .font(.brandRounded(14, .semibold)).foregroundStyle(Brand.violet)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }

    // MARK: Logic

    private func start(with records: [ReviewRecord]) {
        queue = records.filter { block(for: $0) != nil }
        index = 0
        answered = false
        session = !queue.isEmpty
    }

    private func handle(_ record: ReviewRecord, _ correct: Bool) {
        progress.recordAttempt(key: record.key, lessonID: record.lessonID, correct: correct)
        answered = true
    }

    private func block(for record: ReviewRecord) -> ContentBlock? {
        guard let lesson = LessonLibrary.lesson(id: record.lessonID) else { return nil }
        for block in lesson.blocks {
            switch block {
            case let .quiz(q) where q.reviewKey(lessonID: record.lessonID) == record.key:
                return block
            case let .predict(p) where p.reviewKey(lessonID: record.lessonID) == record.key:
                return block
            default:
                continue
            }
        }
        return nil
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
