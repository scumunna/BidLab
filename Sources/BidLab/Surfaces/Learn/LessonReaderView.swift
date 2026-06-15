import BidLabCore
import Foundation
import SwiftUI

/// A guided, paginated lesson player. One section per screen with a progress
/// bar, a Continue button, and a completion screen that flows straight into the
/// next lesson. This is the Brilliant/Duolingo-style step experience rather than
/// one long scroll.
struct LessonReaderView: View {
    let lesson: Lesson
    let accent: Color
    let onBack: () -> Void
    let onOpenLesson: (String) -> Void
    @EnvironmentObject var progress: ProgressStore
    @EnvironmentObject var app: AppState
    @Local private var step = 0
    @Local private var celebrate = false
    @Local private var awardedXP = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var steps: [[ContentBlock]] { LessonReaderView.makeSteps(lesson.blocks) }
    private var totalSteps: Int { max(steps.count, 1) }
    private var onCompletion: Bool { step >= totalSteps }
    private var nextLessonID: String? { Curriculum.nextLessonID(track: lesson.track, afterModule: lesson.module) }

    var body: some View {
        VStack(spacing: 0) {
            progressHeader
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            if !onCompletion { actionBar }
        }
    }

    // MARK: Header

    private var progressHeader: some View {
        HStack(spacing: 14) {
            Button(action: onBack) {
                Image(systemName: "xmark").font(.system(size: 13, weight: .bold)).foregroundStyle(Brand.muted)
                    .frame(width: 30, height: 30)
                    .background(Brand.ink.opacity(0.04), in: Circle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Close lesson")

            GeometryReader { geo in
                Capsule().fill(accent.opacity(0.14)).overlay(alignment: .leading) {
                    Capsule().fill(accent)
                        .frame(width: max(6, geo.size.width * progressFraction))
                }
            }
            .frame(height: 7)

            Text("\(min(step + 1, totalSteps)) / \(totalSteps)")
                .font(.brandMono(12, .semibold)).foregroundStyle(Brand.muted)
                .frame(width: 44, alignment: .trailing)
        }
        .padding(.horizontal, 28)
        .padding(.top, 26)
        .padding(.bottom, 16)
    }

    private var progressFraction: Double {
        Double(min(step, totalSteps)) / Double(totalSteps)
    }

    // MARK: Content

    @ViewBuilder
    private var content: some View {
        if onCompletion {
            completionView
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    if step == 0 {
                        Pill(text: "\(lesson.track.uppercased()) · module \(lesson.module)", color: accent)
                        Text(lesson.title)
                            .font(.brandDisplay(28, .heavy)).foregroundStyle(Brand.ink)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(lesson.summary)
                            .font(.brandRounded(15, .regular)).foregroundStyle(Brand.muted)
                            .fixedSize(horizontal: false, vertical: true)
                        Rectangle().fill(Brand.hairline).frame(height: 1).padding(.vertical, 2)
                    }
                    ForEach(steps[step].indices, id: \.self) { i in
                        BlockView(block: steps[step][i], accent: accent, lessonID: lesson.id) { key, correct in
                            progress.recordAttempt(key: key, lessonID: lesson.id, correct: correct)
                        }
                    }
                }
                .padding(.horizontal, 40)
                .padding(.top, 8)
                .padding(.bottom, 28)
                .frame(maxWidth: 780, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .id(step)
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
        }
    }

    private var completionView: some View {
        VStack(spacing: 18) {
            ZStack {
                Circle().stroke(accent.opacity(0.5), lineWidth: 3)
                    .frame(width: 96, height: 96)
                    .scaleEffect(celebrate ? 1.7 : 0.7)
                    .opacity(celebrate ? 0 : 0.7)
                Circle().fill(accent.opacity(0.14)).frame(width: 92, height: 92)
                Image(systemName: "checkmark.seal.fill").font(.system(size: 44, weight: .bold)).foregroundStyle(accent)
                    .scaleEffect(celebrate ? 1 : 0.4)
            }
            .onAppear {
                if reduceMotion {
                    celebrate = true
                } else {
                    withAnimation(.spring(response: 0.55, dampingFraction: 0.58)) { celebrate = true }
                }
            }
            Text("Lesson complete").font(.brandMono(12, .semibold)).foregroundStyle(accent).tracking(1)
            Text(lesson.title).font(.brandDisplay(26, .heavy)).foregroundStyle(Brand.ink)
                .multilineTextAlignment(.center)
            if awardedXP {
                Text("+20 XP")
                    .font(.brandMono(13, .bold)).foregroundStyle(Brand.violet)
                    .padding(.horizontal, 12).padding(.vertical, 6)
                    .background(Brand.violet.opacity(0.12), in: Capsule())
                    .scaleEffect(celebrate ? 1 : 0.4)
                    .opacity(celebrate ? 1 : 0)
            }
            takeItFurther
            VStack(spacing: 10) {
                if let next = nextLessonID, let nextLesson = LessonLibrary.lesson(id: next) {
                    PrimaryButton("Next: \(nextLesson.title)", icon: "arrow.right", color: accent) {
                        onOpenLesson(next)
                    }
                }
                Button(action: onBack) {
                    Text("Back to paths").font(.brandRounded(14, .semibold)).foregroundStyle(Brand.muted)
                }
                .buttonStyle(.plain)
            }
            .padding(.top, 6)
        }
        .padding(40)
        .frame(maxWidth: 520)
        .transition(.scale(scale: 0.92).combined(with: .opacity))
    }

    // MARK: Action bar

    private var actionBar: some View {
        HStack(spacing: 12) {
            if step > 0 {
                Button(action: goBack) {
                    Image(systemName: "chevron.left").font(.system(size: 14, weight: .bold)).foregroundStyle(Brand.muted)
                        .frame(width: 44, height: 44)
                        .background(Brand.ink.opacity(0.04), in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Previous step")
            }
            Button(action: advance) {
                Text(step >= totalSteps - 1 ? "Finish lesson" : "Continue")
                    .font(.brandRounded(15, .bold)).foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(accent, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 16)
        .frame(maxWidth: 780)
        .frame(maxWidth: .infinity)
        .overlay(alignment: .top) { Rectangle().fill(Brand.hairline).frame(height: 1) }
    }

    private var tradingRelevant: Bool { ["core", "dsp", "sales", "planning"].contains(lesson.track) }
    private var roleName: String { Track.all.first { $0.id == lesson.track }?.role ?? "this path" }

    /// Connective tissue: from a finished lesson, jump straight to where you
    /// practice it (the Tools, the Trading Floor) or prove it (the exam).
    @ViewBuilder
    private var takeItFurther: some View {
        VStack(spacing: 8) {
            Text("TAKE IT FURTHER").font(.brandMono(10, .semibold)).foregroundStyle(Brand.faint).tracking(0.8)
            HStack(spacing: 8) {
                practiceChip("Tools", "slider.horizontal.3") { app.surface = .tools }
                if tradingRelevant {
                    practiceChip("Trading Floor", "bolt.horizontal.fill") { app.surface = .tradingFloor }
                }
                if ExamLibrary.exam(track: lesson.track) != nil {
                    practiceChip("\(roleName) exam", "graduationcap.fill") {
                        app.pendingExamTrack = lesson.track
                        app.surface = .exams
                    }
                }
            }
        }
        .padding(.top, 4)
    }

    private func practiceChip(_ label: String, _ icon: String, _ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: icon).font(.system(size: 11, weight: .bold))
                Text(label).font(.brandRounded(12.5, .semibold))
            }
            .foregroundStyle(accent)
            .padding(.horizontal, 12).padding(.vertical, 8)
            .background(accent.opacity(0.10), in: Capsule())
        }
        .buttonStyle(.plain)
    }

    private func advance() {
        if step < totalSteps - 1 {
            withAnimation(.easeInOut(duration: 0.28)) { step += 1 }
        } else {
            awardedXP = !progress.isComplete(lesson.id)
            progress.complete(lesson.id)
            Sound.complete()
            withAnimation(.easeInOut(duration: 0.28)) { step = totalSteps }
        }
    }

    private func goBack() {
        withAnimation(.easeInOut(duration: 0.28)) {
            if step > 0 { step -= 1 }
        }
    }

    /// Split a lesson's blocks into steps, one per heading-led section.
    static func makeSteps(_ blocks: [ContentBlock]) -> [[ContentBlock]] {
        var groups: [[ContentBlock]] = []
        var current: [ContentBlock] = []
        for block in blocks {
            if case .heading = block {
                if !current.isEmpty { groups.append(current) }
                current = [block]
            } else {
                current.append(block)
            }
        }
        if !current.isEmpty { groups.append(current) }
        return groups.isEmpty ? [blocks] : groups
    }
}

/// Renders one content block.
private struct BlockView: View {
    let block: ContentBlock
    let accent: Color
    var lessonID: String = ""
    var record: ((String, Bool) -> Void)? = nil

    var body: some View {
        switch block {
        case let .heading(text):
            Text(text).font(.brandRounded(22, .bold)).foregroundStyle(Brand.ink).padding(.top, 4)
        case let .prose(text):
            Text(cleanProse(text))
                .font(.brandRounded(16, .regular)).foregroundStyle(Brand.ink)
                .lineSpacing(5).fixedSize(horizontal: false, vertical: true)
        case let .math(latex):
            mathCard(latex)
        case let .code(code):
            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(.brandMono(13, .regular))
                    .foregroundStyle(Color.white.opacity(0.92))
                    .padding(14)
            }
            .background(Brand.console, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
        case let .callout(kind, text):
            calloutView(kind: kind, text: text)
        case let .widget(type, params):
            WidgetRegistry.view(type: type, params: params)
        case let .quiz(quiz):
            QuizView(quiz: quiz, onResult: { record?(quiz.reviewKey(lessonID: lessonID), $0) })
        case let .predict(prediction):
            PredictView(prediction: prediction, accent: accent,
                        onResult: { record?(prediction.reviewKey(lessonID: lessonID), $0) })
        case let .figure(name, caption):
            FigureView(name: name, caption: caption)
        case let .sources(sources):
            sourcesView(sources)
        }
    }

    private func mathCard(_ latex: String) -> some View {
        HStack {
            Spacer()
            MathView(latex: latex, color: Brand.ink, size: 20)
            Spacer()
        }
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity)
        .background(Brand.ink.opacity(0.03), in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
    }

    private func calloutView(kind: String, text: String) -> some View {
        let style = calloutStyle(kind)
        return HStack(alignment: .top, spacing: 11) {
            Image(systemName: style.icon).font(.system(size: 15, weight: .bold)).foregroundStyle(style.color)
            Text(cleanProse(text))
                .font(.brandRounded(14.5, .medium)).foregroundStyle(Brand.ink)
                .lineSpacing(3).fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(style.color.opacity(0.08), in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous).strokeBorder(style.color.opacity(0.25), lineWidth: 1))
    }

    private func sourcesView(_ sources: [Source]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sources").font(.brandMono(11, .semibold)).foregroundStyle(Brand.muted).tracking(0.5)
            ForEach(Array(sources.enumerated()), id: \.offset) { _, source in
                if let url = URL(string: source.url), !source.url.isEmpty {
                    Link(destination: url) {
                        HStack(spacing: 6) {
                            Image(systemName: "link").font(.system(size: 11)).foregroundStyle(accent)
                            Text(source.title).font(.brandRounded(13, .regular)).foregroundStyle(accent).underline()
                        }
                    }
                } else {
                    Text(source.title).font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted)
                }
            }
        }
        .padding(.top, 6)
    }

    private func calloutStyle(_ kind: String) -> (color: Color, icon: String) {
        switch kind.lowercased() {
        case "insight": return (Brand.violet, "lightbulb.fill")
        case "warning": return (Brand.planning, "exclamationmark.triangle.fill")
        case "key", "important": return (Brand.dsp, "star.fill")
        default: return (Brand.analytics, "info.circle.fill")
        }
    }

    private func cleanProse(_ text: String) -> String {
        // Protect an escaped dollar (\$) so the inline-math delimiter strip below
        // does not eat it, then restore it as a literal "$".
        let dollar = "\u{E001}"
        return MathView.prettify(text.replacingOccurrences(of: "\\$", with: dollar))
            .replacingOccurrences(of: "$", with: "")
            .replacingOccurrences(of: "*", with: "")
            .replacingOccurrences(of: "`", with: "")
            .replacingOccurrences(of: dollar, with: "$")
            .replacingOccurrences(of: MathView.literalUnderscore, with: "_")
    }
}
