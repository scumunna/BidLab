import BidLabCore
import SwiftUI

/// An interactive knowledge check. Pick an option to lock in an answer and
/// reveal the correct choice plus the explanation.
struct QuizView: View {
    let quiz: QuizQuestion
    var onResult: ((Bool) -> Void)? = nil
    @Local private var selected: Int?
    @Local private var hintsShown = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "checklist").font(.system(size: 13, weight: .bold)).foregroundStyle(Brand.violet)
                Text("Check yourself").font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.violet)
            }
            Text(quiz.question).font(.brandRounded(16, .semibold)).foregroundStyle(Brand.ink)
                .fixedSize(horizontal: false, vertical: true)

            if selected == nil, !quiz.hints.isEmpty { hintArea }

            ForEach(quiz.options.indices, id: \.self) { idx in
                Button {
                    if selected == nil {
                        selected = idx
                        let correct = idx == quiz.answerIndex
                        if correct { Sound.correct() }
                        onResult?(correct)
                    }
                } label: {
                    optionRow(idx)
                }
                .buttonStyle(.plain)
                .disabled(selected != nil)
            }

            if let selected {
                let correct = selected == quiz.answerIndex
                HStack(spacing: 7) {
                    Image(systemName: correct ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(correct ? Brand.up : Brand.down)
                    Text(correct ? "Correct" : "Not quite")
                        .font(.brandRounded(13, .bold))
                        .foregroundStyle(correct ? Brand.up : Brand.down)
                }
                Text(quiz.explanation)
                    .font(.brandRounded(13, .regular))
                    .foregroundStyle(Brand.muted)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.violet.opacity(0.05), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.violet.opacity(0.18), lineWidth: 1))
    }

    private var hintArea: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(Array(quiz.hints.prefix(hintsShown).enumerated()), id: \.offset) { _, hint in
                HStack(alignment: .top, spacing: 7) {
                    Image(systemName: "lightbulb.fill").font(.system(size: 12)).foregroundStyle(Brand.planning)
                    Text(hint).font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            if hintsShown < quiz.hints.count {
                Button {
                    withAnimation(.easeOut(duration: 0.2)) { hintsShown += 1 }
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "lightbulb").font(.system(size: 11))
                        Text(hintsShown == 0 ? "Need a hint?" : "Another hint").font(.brandRounded(12.5, .semibold))
                    }
                    .foregroundStyle(Brand.planning)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func optionRow(_ idx: Int) -> some View {
        let isAnswer = idx == quiz.answerIndex
        let isPicked = selected == idx
        let revealed = selected != nil
        let tint: Color = revealed ? (isAnswer ? Brand.up : (isPicked ? Brand.down : Brand.muted)) : Brand.ink

        return HStack(spacing: 10) {
            Image(systemName: revealed && isAnswer ? "checkmark.circle.fill" : (revealed && isPicked ? "xmark.circle.fill" : "circle"))
                .font(.system(size: 15))
                .foregroundStyle(revealed ? (isAnswer ? Brand.up : (isPicked ? Brand.down : Brand.faint)) : Brand.faint)
            Text(quiz.options[idx]).font(.brandRounded(13.5, .medium)).foregroundStyle(tint)
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            (revealed && isAnswer ? Brand.up.opacity(0.08) : (isPicked ? Brand.down.opacity(0.06) : Brand.ink.opacity(0.02))),
            in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous)
                .strokeBorder(revealed && isAnswer ? Brand.up.opacity(0.4) : Brand.hairline, lineWidth: 1)
        )
    }
}
