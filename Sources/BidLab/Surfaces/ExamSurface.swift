import BidLabCore
import SwiftUI

/// The certification surface: each role path has an exam of original,
/// scenario-style questions across the domains a real practitioner is tested on.
/// The learner takes it, gets a pass/fail score with a per-domain diagnostic
/// (the way the IAB DBPC reports one), and can retake.
struct ExamSurface: View {
    @EnvironmentObject var app: AppState
    @EnvironmentObject var progress: ProgressStore

    @Local private var openTrack: String?
    @Local private var answers: [Int?] = []
    @Local private var submitted = false
    // Per-attempt presentation order. `order` maps display position -> original
    // question index; `optOrder[qi]` is the shuffled original option indices for
    // question qi. Both reshuffle on every open and retake, so a learner cannot
    // pass by memorizing answer positions or always picking the same letter.
    @Local private var order: [Int] = []
    @Local private var optOrder: [[Int]] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                if let track = openTrack, let exam = ExamLibrary.exam(track: track) {
                    examView(exam)
                } else {
                    picker
                }
            }
            .padding(.horizontal, 38).padding(.top, 40).padding(.bottom, 48)
            .frame(maxWidth: 860, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            if let track = app.pendingExamTrack, let exam = ExamLibrary.exam(track: track) {
                app.pendingExamTrack = nil
                open(exam)
            }
        }
    }

    // MARK: Picker

    private var picker: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 8) {
                Pill(text: "Certification", color: Brand.lime)
                Text("Earn your role certification").font(.brandDisplay(30, .heavy)).foregroundStyle(Brand.ink)
                Text("Each path has an exam: original, scenario-based questions across the domains a real practitioner is tested on. Pass to prove the skill.")
                    .font(.brandRounded(15, .regular)).foregroundStyle(Brand.muted)
                    .frame(maxWidth: 700, alignment: .leading).fixedSize(horizontal: false, vertical: true)
            }
            ForEach(Track.all) { track in
                if let exam = ExamLibrary.exam(track: track.id) {
                    examRow(track, exam)
                }
            }
            if ExamLibrary.all.isEmpty {
                Text("Exams are being authored.").font(.brandRounded(14, .regular)).foregroundStyle(Brand.muted)
            }
        }
    }

    private func examRow(_ track: Track, _ exam: Exam) -> some View {
        Button { open(exam) } label: {
            HStack(spacing: 14) {
                Image(systemName: track.icon).font(.system(size: 17, weight: .bold)).foregroundStyle(track.accent).frame(width: 26)
                VStack(alignment: .leading, spacing: 3) {
                    Text(exam.title).font(.brandRounded(15, .semibold)).foregroundStyle(Brand.ink)
                    Text(exam.draw > 0 && exam.draw < exam.questions.count
                         ? "\(exam.presentedCount) questions, drawn from \(exam.questions.count) · \(exam.domains.count) domains · pass at \(Int(exam.passMark * 100))%"
                         : "\(exam.questions.count) questions · \(exam.domains.count) domains · pass at \(Int(exam.passMark * 100))%")
                        .font(.brandMono(11.5, .regular)).foregroundStyle(Brand.muted)
                }
                Spacer()
                if progress.isExamPassed(track.id) {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.seal.fill").font(.system(size: 12))
                        Text("Certified").font(.brandRounded(11.5, .bold))
                    }
                    .foregroundStyle(Brand.up)
                    .padding(.horizontal, 9).padding(.vertical, 5)
                    .background(Brand.up.opacity(0.12), in: Capsule())
                }
                Image(systemName: "chevron.right").foregroundStyle(Brand.faint)
            }
            .padding(16).frame(maxWidth: .infinity, alignment: .leading)
            .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
        }
        .buttonStyle(.plain)
    }

    // MARK: Exam

    @ViewBuilder
    private func examView(_ exam: Exam) -> some View {
        HStack {
            Button(action: reset) {
                HStack(spacing: 6) { Image(systemName: "chevron.left"); Text("All exams") }
                    .font(.brandRounded(13, .semibold)).foregroundStyle(Brand.muted)
            }
            .buttonStyle(.plain)
            Spacer()
        }
        Text(exam.title).font(.brandDisplay(26, .heavy)).foregroundStyle(Brand.ink)

        if submitted { resultsView(exam) }

        let ord = order.isEmpty ? Array(exam.questions.indices.prefix(exam.presentedCount)) : order
        let oo = optOrder.count == exam.questions.count ? optOrder : exam.questions.map { Array(0..<$0.options.count) }
        ForEach(ord.indices, id: \.self) { pos in
            questionCard(exam.questions[ord[pos]], number: pos + 1, qIndex: ord[pos], optionsOrder: oo[ord[pos]])
        }

        if !submitted {
            PrimaryButton(answeredCount == order.count ? "Submit exam" : "Submit (\(answeredCount)/\(order.count) answered)",
                          icon: "checkmark.seal", color: Brand.lime) {
                let result = grade(exam)
                if result.passed(exam.passMark) {
                    Sound.complete()
                    progress.recordExamPass(track: exam.track, fraction: result.fraction)
                }
                withAnimation(.easeInOut(duration: 0.25)) { submitted = true }
            }
        }
    }

    private func questionCard(_ q: ExamQuestion, number: Int, qIndex: Int, optionsOrder: [Int]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Text("Q\(number)").font(.brandMono(11, .bold)).foregroundStyle(Brand.violet)
                Text(q.domain.uppercased()).font(.brandMono(9.5, .semibold)).foregroundStyle(Brand.faint).tracking(0.5)
                Spacer()
            }
            Text(q.question).font(.brandRounded(15.5, .semibold)).foregroundStyle(Brand.ink)
                .fixedSize(horizontal: false, vertical: true)
            ForEach(optionsOrder.indices, id: \.self) { slot in
                optionRow(q, index: qIndex, opt: optionsOrder[slot])
            }
            if submitted, !q.explanation.isEmpty {
                Text(q.explanation).font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted)
                    .fixedSize(horizontal: false, vertical: true).padding(.top, 2)
            }
        }
        .padding(16).frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    private func optionRow(_ q: ExamQuestion, index: Int, opt: Int) -> some View {
        let selected = index < answers.count && answers[index] == opt
        let isAnswer = opt == q.answerIndex
        let reveal = submitted
        let tint: Color = reveal ? (isAnswer ? Brand.up : (selected ? Brand.down : Brand.muted)) : (selected ? Brand.ink : Brand.muted)
        return Button {
            if !submitted { setAnswer(index, opt) }
        } label: {
            HStack(spacing: 10) {
                Image(systemName: icon(reveal: reveal, isAnswer: isAnswer, selected: selected))
                    .font(.system(size: 15))
                    .foregroundStyle(reveal ? (isAnswer ? Brand.up : (selected ? Brand.down : Brand.faint)) : (selected ? Brand.violet : Brand.faint))
                Text(q.options[opt]).font(.brandRounded(13.5, .medium)).foregroundStyle(tint)
                Spacer()
            }
            .padding(.horizontal, 12).padding(.vertical, 9)
            .background(optionFill(reveal: reveal, isAnswer: isAnswer, selected: selected),
                        in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous)
                .strokeBorder(optionStroke(reveal: reveal, isAnswer: isAnswer, selected: selected), lineWidth: 1))
        }
        .buttonStyle(.plain)
        .disabled(submitted)
    }

    private func icon(reveal: Bool, isAnswer: Bool, selected: Bool) -> String {
        if reveal && isAnswer { return "checkmark.circle.fill" }
        if reveal && selected { return "xmark.circle.fill" }
        if selected { return "largecircle.fill.circle" }
        return "circle"
    }

    private func optionFill(reveal: Bool, isAnswer: Bool, selected: Bool) -> Color {
        if reveal && isAnswer { return Brand.up.opacity(0.08) }
        if selected { return Brand.violet.opacity(0.06) }
        return Brand.ink.opacity(0.02)
    }

    private func optionStroke(reveal: Bool, isAnswer: Bool, selected: Bool) -> Color {
        if reveal && isAnswer { return Brand.up.opacity(0.4) }
        if selected { return Brand.violet.opacity(0.3) }
        return Brand.hairline
    }

    // MARK: Results

    private func resultsView(_ exam: Exam) -> some View {
        let result = grade(exam)
        let passed = result.passed(exam.passMark)
        return VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                Image(systemName: passed ? "checkmark.seal.fill" : "arrow.clockwise.circle.fill")
                    .font(.system(size: 30, weight: .bold)).foregroundStyle(passed ? Brand.up : Brand.planning)
                VStack(alignment: .leading, spacing: 2) {
                    Text(passed ? "Passed" : "Not yet").font(.brandDisplay(22, .heavy)).foregroundStyle(passed ? Brand.up : Brand.planning)
                    Text("\(result.correct) of \(result.total) correct  ·  \(Int(result.fraction * 100))%, pass at \(Int(exam.passMark * 100))%")
                        .font(.brandMono(12, .regular)).foregroundStyle(Brand.muted)
                }
                Spacer()
                Button { retake(exam) } label: {
                    Text("Retake").font(.brandRounded(13.5, .semibold)).foregroundStyle(.white)
                        .padding(.horizontal, 16).padding(.vertical, 9)
                        .background(Brand.violet, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
                }
                .buttonStyle(.plain)
            }
            .padding(16).frame(maxWidth: .infinity, alignment: .leading)
            .background((passed ? Brand.up : Brand.planning).opacity(0.08), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder((passed ? Brand.up : Brand.planning).opacity(0.3), lineWidth: 1.5))

            Text("By domain").font(.brandRounded(14, .bold)).foregroundStyle(Brand.ink)
            ForEach(exam.domains, id: \.self) { domain in
                if let ds = result.byDomain[domain] { domainBar(domain, ds) }
            }
            remediation(exam, result)
            Text("Your answers are marked below with the correct choice and an explanation.")
                .font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted)
        }
    }

    /// Route a weak diagnostic straight back into the lessons that teach it, so
    /// the per-domain breakdown is an action, not a dead end.
    @ViewBuilder
    private func remediation(_ exam: Exam, _ result: ExamResult) -> some View {
        let weak = exam.domains.filter { (result.byDomain[$0]?.fraction ?? 1) < exam.passMark }
        let role = Track.all.first { $0.id == exam.track }?.role ?? exam.track
        if !weak.isEmpty {
            Button {
                app.openPathID = exam.track
                app.surface = .learn
                reset()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "arrow.uturn.backward.circle.fill").font(.system(size: 18)).foregroundStyle(Brand.violet)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Brush up, then retake").font(.brandRounded(13.5, .semibold)).foregroundStyle(Brand.ink)
                        Text("Weakest: \(weak.joined(separator: ", ")). Open the \(role) path to review.")
                            .font(.brandRounded(11.5, .regular)).foregroundStyle(Brand.muted)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                    Image(systemName: "chevron.right").foregroundStyle(Brand.faint)
                }
                .padding(14).frame(maxWidth: .infinity, alignment: .leading)
                .background(Brand.violet.opacity(0.06), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.violet.opacity(0.25), lineWidth: 1))
            }
            .buttonStyle(.plain)
        }
    }

    private func domainBar(_ domain: String, _ ds: ExamResult.DomainScore) -> some View {
        HStack(spacing: 12) {
            Text(domain).font(.brandRounded(12.5, .medium)).foregroundStyle(Brand.ink).frame(width: 170, alignment: .leading)
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Brand.ink.opacity(0.06)).frame(height: 8)
                    Capsule().fill(ds.fraction >= 0.7 ? Brand.up : Brand.planning)
                        .frame(width: max(6, geo.size.width * ds.fraction), height: 8)
                }
            }
            .frame(height: 8)
            Text("\(ds.correct)/\(ds.total)").font(.brandMono(11, .semibold)).foregroundStyle(Brand.muted).frame(width: 38, alignment: .trailing)
        }
    }

    // MARK: State

    private var answeredCount: Int { answers.compactMap { $0 }.count }

    private func open(_ exam: Exam) {
        openTrack = exam.track
        startAttempt(exam)
    }

    private func retake(_ exam: Exam) {
        withAnimation(.easeInOut(duration: 0.25)) { startAttempt(exam) }
    }

    /// Build a fresh attempt: draw a random subset from the bank (so retakes and
    /// different learners see different forms), in a new order, with each
    /// question's options reshuffled.
    private func startAttempt(_ exam: Exam) {
        answers = Array(repeating: nil, count: exam.questions.count)
        order = Array(exam.questions.indices.shuffled().prefix(exam.presentedCount))
        optOrder = exam.questions.map { Array(0..<$0.options.count).shuffled() }
        submitted = false
    }

    /// Grade only the questions actually presented this attempt.
    private func grade(_ exam: Exam) -> ExamResult {
        let qs = order.map { exam.questions[$0] }
        let ans = order.map { answers[$0] }
        return ExamScoring.score(Exam(track: exam.track, title: exam.title, passMark: exam.passMark, questions: qs), answers: ans)
    }

    private func reset() {
        openTrack = nil
        submitted = false
        answers = []
        order = []
        optOrder = []
    }

    private func setAnswer(_ i: Int, _ opt: Int) {
        guard i < answers.count else { return }
        answers[i] = opt
    }
}
