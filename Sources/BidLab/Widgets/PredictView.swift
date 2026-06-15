import BidLabCore
import SwiftUI

/// A graded numeric estimation. The learner commits a guess, optionally peeking
/// at progressive hints, then sees whether it landed within tolerance plus the
/// exact answer and the reasoning. This is active problem-solving with instant
/// feedback, the core of how Brilliant-style learning sticks: you predict
/// before you are told.
struct PredictView: View {
    let prediction: Prediction
    var accent: Color = Brand.dsp
    var onResult: ((Bool) -> Void)? = nil

    @Local private var guessText = ""
    @Local private var revealed = false
    @Local private var hintsShown = 0
    @Local private var correct = false

    private var guess: Double? {
        Double(guessText.replacingOccurrences(of: ",", with: "").trimmingCharacters(in: .whitespaces))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "function").font(.system(size: 13, weight: .bold)).foregroundStyle(accent)
                Text("Predict it").font(.brandRounded(12.5, .semibold)).foregroundStyle(accent)
            }
            Text(prediction.prompt).font(.brandRounded(16, .semibold)).foregroundStyle(Brand.ink)
                .fixedSize(horizontal: false, vertical: true)

            entryRow

            if !prediction.hints.isEmpty, !revealed { hintArea }
            if revealed { resultArea }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(accent.opacity(0.05), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(accent.opacity(0.18), lineWidth: 1))
    }

    private var entryRow: some View {
        HStack(spacing: 10) {
            HStack(spacing: 4) {
                if prediction.unit == "$" {
                    Text("$").font(.brandMono(15, .bold)).foregroundStyle(Brand.muted)
                }
                TextField("your estimate", text: $guessText)
                    .textFieldStyle(.plain)
                    .font(.brandMono(15, .bold))
                    .foregroundStyle(Brand.ink)
                    .frame(width: 110)
                    .disabled(revealed)
                    .onSubmit(check)
                if prediction.unit == "%" || prediction.unit == "x" {
                    Text(prediction.unit).font(.brandMono(15, .bold)).foregroundStyle(Brand.muted)
                }
            }
            .padding(.horizontal, 12).padding(.vertical, 9)
            .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))

            if !revealed {
                Button(action: check) {
                    Text("Check").font(.brandRounded(14, .bold)).foregroundStyle(.white)
                        .padding(.horizontal, 18).padding(.vertical, 10)
                        .background(guess == nil ? Brand.muted.opacity(0.4) : accent,
                                    in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
                }
                .buttonStyle(.plain)
                .disabled(guess == nil)
            }
            Spacer()
        }
    }

    private var hintArea: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(Array(prediction.hints.prefix(hintsShown).enumerated()), id: \.offset) { _, hint in
                HStack(alignment: .top, spacing: 7) {
                    Image(systemName: "lightbulb.fill").font(.system(size: 12)).foregroundStyle(Brand.planning)
                    Text(hint).font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            if hintsShown < prediction.hints.count {
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

    private var resultArea: some View {
        VStack(alignment: .leading, spacing: 9) {
            HStack(spacing: 7) {
                Image(systemName: correct ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundStyle(correct ? Brand.up : Brand.down)
                Text(correct ? "Within range" : "Not quite")
                    .font(.brandRounded(13, .bold)).foregroundStyle(correct ? Brand.up : Brand.down)
            }
            HStack(spacing: 22) {
                resultStat("You", format(guess ?? 0))
                resultStat("Answer", format(prediction.answer))
            }
            Text(prediction.explanation)
                .font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted)
                .fixedSize(horizontal: false, vertical: true)
        }
        .transition(.opacity)
    }

    private func resultStat(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label).font(.brandMono(10, .semibold)).foregroundStyle(Brand.faint).tracking(0.5)
            Text(value).font(.brandMono(16, .bold)).foregroundStyle(Brand.ink)
        }
    }

    private func check() {
        guard let g = guess, !revealed else { return }
        correct = prediction.isCorrect(g)
        withAnimation(.easeOut(duration: 0.25)) { revealed = true }
        if correct { Sound.correct() }
        onResult?(correct)
    }

    private func format(_ x: Double) -> String {
        let n = abs(x) >= 100 ? String(format: "%.0f", x) : String(format: "%.2f", x)
        switch prediction.unit {
        case "$": return "$" + n
        case "%": return n + "%"
        case "x": return n + "x"
        default: return n
        }
    }
}
