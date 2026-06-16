import BidLabCore
import Foundation
import SwiftUI

/// Progress and certification, organized as a small ecosystem of three pages:
/// Overview (XP, streak, this week, completion by path), Certifications (earned
/// credentials and the shareable foundations credential), and Transcript (the
/// learner's real, exportable record for an LMS or a manager report). The
/// Transcript page is what used to be the standalone "Cohort" surface: BidLab
/// runs locally, so it shows the learner's own verified record, not mocked
/// teammates. Multi-seat tracking and SSO are the hosted tier, stated honestly.
struct ProgressSurface: View {
    @EnvironmentObject var progress: ProgressStore
    @EnvironmentObject var app: AppState
    @Local private var tab = "overview"
    @Local private var cohort: [LearnerRecord] = []

    private let tabs = [
        InnerTabBar.Item(id: "overview", title: "Overview", icon: "rosette"),
        InnerTabBar.Item(id: "certs", title: "Certifications", icon: "checkmark.seal"),
        InnerTabBar.Item(id: "transcript", title: "Transcript", icon: "doc.text"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 26) {
                header
                InnerTabBar(items: tabs, selection: $tab)
                switch tab {
                case "certs": certsTab
                case "transcript": transcriptTab
                default: overviewTab
                }
            }
            .padding(.horizontal, 38)
            .padding(.top, 40)
            .padding(.bottom, 48)
            .frame(maxWidth: 1000, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Progress & certification").font(.brandDisplay(30, .heavy)).foregroundStyle(Brand.ink)
            Text("Your mastery across the paths, the credentials you have earned, and your exportable record.")
                .font(.brandRounded(15, .regular)).foregroundStyle(Brand.muted)
        }
    }

    // MARK: Overview tab

    @ViewBuilder private var overviewTab: some View {
        overview
        thisWeekSection
        pathProgress
    }

    private var overview: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                metric("XP", "\(progress.xp)", Brand.violet)
                metric("Day streak", "\(progress.streak)", Brand.planning)
                metric("Freezes", "\(progress.streakFreezes)", Brand.dsp)
                metric("Today", "\(progress.goalProgressToday) / \(progress.dailyGoal)",
                       progress.dailyGoalMet ? Brand.up : Brand.muted)
            }
            HStack(spacing: 12) {
                metric("Lessons", "\(progress.totalCompleted) / \(progress.totalLiveLessons)", Brand.dsp)
                metric("Best score", progress.bestTradingScore > 0 ? String(format: "%.0f", progress.bestTradingScore) : "—", Brand.up)
                metric("Paths", "\(pathsStarted) / \(Track.all.count)", Brand.analytics)
                metric("Reviews due", "\(progress.dueReviewCount)", Brand.violet)
            }
        }
    }

    private var pathProgress: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "By path")
            VStack(spacing: 10) {
                ForEach(Track.all) { track in
                    pathRow(track)
                }
            }
        }
    }

    private func pathRow(_ track: Track) -> some View {
        let live = progress.liveCount(forTrack: track.id)
        let done = progress.completedCount(forTrack: track.id)
        let fraction = live > 0 ? Double(done) / Double(live) : 0
        return HStack(spacing: 14) {
            Image(systemName: track.icon).font(.system(size: 16, weight: .bold)).foregroundStyle(track.accent).frame(width: 24)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(track.role).font(.brandRounded(14, .semibold)).foregroundStyle(Brand.ink)
                    Spacer()
                    Text(live > 0 ? "\(done) / \(live) live" : "coming soon")
                        .font(.brandMono(12, .regular)).foregroundStyle(Brand.muted)
                }
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Brand.ink.opacity(0.06)).frame(height: 6)
                        Capsule().fill(track.accent).frame(width: max(6, geo.size.width * fraction), height: 6)
                    }
                }
                .frame(height: 6)
            }
        }
        .padding(14)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    private var thisWeekSection: some View {
        let best = max(progress.bestWeekXP, progress.weekXP)
        let frac = best > 0 ? Double(progress.weekXP) / Double(best) : 0
        return VStack(alignment: .leading, spacing: 14) {
            HStack {
                SectionHeader(title: "This week", accent: Brand.planning)
                Spacer()
                if progress.canBuyFreeze {
                    Button { progress.buyFreeze() } label: {
                        HStack(spacing: 5) {
                            Image(systemName: "snowflake")
                            Text("Buy freeze · \(ProgressStore.freezeCost) XP")
                        }
                        .font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.dsp)
                        .padding(.horizontal, 11).padding(.vertical, 6)
                        .background(Brand.dsp.opacity(0.12), in: Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            Text("You against your own best week. No leaderboards, no fabricated rivals, just your pace.")
                .font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("\(progress.weekXP) XP this week").font(.brandRounded(15, .bold)).foregroundStyle(Brand.ink)
                    Spacer()
                    Text(progress.bestWeekXP > 0 ? "best week \(progress.bestWeekXP) XP" : "set your first record")
                        .font(.brandMono(12, .regular)).foregroundStyle(Brand.muted)
                }
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Brand.ink.opacity(0.06)).frame(height: 12)
                        Capsule().fill(Brand.planning).frame(width: max(6, geo.size.width * CGFloat(min(frac, 1))), height: 12)
                    }
                }
                .frame(height: 12)
                if progress.bestWeekXP > 0 && progress.weekXP >= progress.bestWeekXP {
                    Text("New personal best. Nice.").font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.up)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
        }
    }

    // MARK: Certifications tab

    @ViewBuilder private var certsTab: some View {
        examCertifications
        certification
    }

    private var examCertifications: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                SectionHeader(title: "Path certifications", accent: Brand.up)
                Spacer()
                if !progress.passedExams.isEmpty {
                    Button(action: exportCredentials) {
                        HStack(spacing: 5) {
                            Image(systemName: "square.and.arrow.down")
                            Text("Export verifiable badges (free)")
                        }
                        .font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.up)
                        .padding(.horizontal, 11).padding(.vertical, 6)
                        .background(Brand.up.opacity(0.12), in: Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            if progress.passedExams.isEmpty {
                GuidedEmptyState(
                    icon: "checkmark.seal.fill",
                    title: "No certifications yet",
                    message: "Pass a path's exam in the Exams tab to earn a certification you can add to LinkedIn and export as a free, verifiable Open Badge.",
                    accent: Brand.up,
                    ctaTitle: "Go to exams",
                    action: { app.surface = .exams }
                )
            } else {
                ForEach(Track.all.filter { progress.isExamPassed($0.id) }) { track in
                    certRow(track)
                }
            }
        }
    }

    private func credential(for track: Track) -> Credential {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        return Credential(recipientName: progress.displayName, track: track.id, role: track.role,
                          year: comps.year ?? 2026, month: comps.month ?? 1, day: comps.day ?? 1)
    }

    private func exportCredentials() {
        let earned = Track.all.filter { progress.isExamPassed($0.id) }.map { credential(for: $0) }
        CredentialExporter.export(earned)
    }

    private func verifyURL(_ cred: Credential) -> String {
        let name = cred.recipientName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? cred.recipientName
        return "\(CredentialExporter.placeholderBaseURL)/verify.html?name=\(name)&track=\(cred.track)&date=\(cred.year)-\(cred.month)-\(cred.day)&code=\(cred.verificationCode)"
    }

    private func certRow(_ track: Track) -> some View {
        let cred = credential(for: track)
        return HStack(spacing: 14) {
            Image(systemName: "checkmark.seal.fill").font(.system(size: 20, weight: .bold)).foregroundStyle(Brand.up)
            VStack(alignment: .leading, spacing: 2) {
                Text("\(track.role) Certified").font(.brandRounded(15, .semibold)).foregroundStyle(Brand.ink)
                Text("Code \(cred.verificationCode)").font(.brandMono(11, .regular)).foregroundStyle(Brand.muted)
            }
            Spacer()
            if let url = URL(string: cred.linkedInAddURL(certURL: verifyURL(cred))) {
                Link(destination: url) {
                    HStack(spacing: 5) { Image(systemName: "link"); Text("Add to LinkedIn") }
                        .font(.brandRounded(13, .semibold)).foregroundStyle(Brand.violet)
                }
            }
            Button {
                Exporter.savePNG(
                    CertificateShareCard(name: cred.recipientName, credential: cred.title, dateText: cred.issueDateISO, code: cred.verificationCode),
                    name: "BidLab-\(track.id)-Certificate"
                )
            } label: {
                HStack(spacing: 5) { Image(systemName: "square.and.arrow.up"); Text("Card") }
                    .font(.brandRounded(13, .semibold)).foregroundStyle(Brand.muted)
            }
            .buttonStyle(.plain)
        }
        .padding(16).frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.up.opacity(0.06), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.up.opacity(0.2), lineWidth: 1))
    }

    private var certification: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Foundations credential", accent: Brand.lime)
            if progress.certificationUnlocked {
                unlockedCertificate
            } else {
                lockedCertificate
            }
        }
    }

    private var unlockedCertificate: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Wordmark(size: 20)
                Spacer()
                Image(systemName: "rosette").font(.system(size: 22, weight: .bold)).foregroundStyle(Brand.violet)
            }
            Text("Certified")
                .font(.brandMono(11, .semibold)).foregroundStyle(Brand.violet).tracking(1)
            Text("Programmatic Foundations")
                .font(.brandDisplay(26, .heavy)).foregroundStyle(Brand.ink)
            Text("Awarded to \(progress.displayName)")
                .font(.brandRounded(14, .medium)).foregroundStyle(Brand.muted)
            HStack {
                Text(Self.dateString()).font(.brandMono(12, .regular)).foregroundStyle(Brand.faint)
                Spacer()
                PrimaryButton("Share to LinkedIn", icon: "square.and.arrow.up", color: Brand.violet) {
                    Exporter.savePNG(
                        CertificateShareCard(name: progress.displayName, credential: "Programmatic Foundations", dateText: Self.dateString()),
                        name: "BidLab-Certificate"
                    )
                }
            }
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.lime.opacity(0.08), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.violet.opacity(0.3), lineWidth: 2))
    }

    private var lockedCertificate: some View {
        HStack(spacing: 16) {
            Image(systemName: "lock.fill").font(.system(size: 24, weight: .bold)).foregroundStyle(Brand.faint)
            VStack(alignment: .leading, spacing: 4) {
                Text("Programmatic Foundations credential").font(.brandRounded(15, .semibold)).foregroundStyle(Brand.ink)
                Text("Complete the available lessons to unlock your shareable credential. \(progress.totalCompleted) of \(progress.totalLiveLessons) done.")
                    .font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.ink.opacity(0.03), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    // MARK: Transcript tab (your real, exportable record)

    @ViewBuilder private var transcriptTab: some View {
        if progress.totalCompleted == 0 {
            GuidedEmptyState(
                icon: "doc.text.fill",
                title: "Your transcript starts here",
                message: "Finish lessons and pass exams, and your verified record fills in below, ready to export for an LMS or a manager report.",
                accent: Brand.up,
                ctaTitle: "Start learning",
                action: { app.surface = .learn }
            )
        }
        transcriptMetrics
        transcriptExportRow
        transcriptByPath
        teamRollup
        hostedNote
    }

    private var transcriptMetrics: some View {
        HStack(spacing: 12) {
            metric("Lessons completed", "\(progress.totalCompleted) / \(progress.totalLiveLessons)", Brand.violet)
            metric("Certifications", "\(progress.passedExams.count) / \(Track.all.count)", Brand.up)
            metric("Best sim score", progress.bestTradingScore > 0 ? "\(Int(progress.bestTradingScore.rounded()))" : "—", Brand.analytics)
            metric("Day streak", "\(progress.streak)", Brand.planning)
        }
    }

    private var transcriptExportRow: some View {
        HStack(spacing: 10) {
            transcriptExportButton("Export transcript (CSV)", "tablecells") {
                Exporter.saveText(progress.transcriptCSV(), name: "bidlab-transcript", ext: "csv")
            }
            transcriptExportButton("Export (JSON)", "curlybraces") {
                Exporter.saveText(progress.transcriptJSON(), name: "bidlab-transcript", ext: "json")
            }
        }
    }

    private func transcriptExportButton(_ title: String, _ icon: String, _ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon).font(.system(size: 12, weight: .bold))
                Text(title).font(.brandRounded(13, .semibold))
            }
            .foregroundStyle(Brand.violet)
            .padding(.horizontal, 14).padding(.vertical, 9)
            .background(Brand.violet.opacity(0.10), in: Capsule())
        }
        .buttonStyle(.plain)
    }

    private var transcriptByPath: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Your record by path")
            VStack(spacing: 8) {
                ForEach(Track.all) { track in transcriptPathRow(track) }
            }
        }
    }

    private func transcriptPathRow(_ track: Track) -> some View {
        let done = progress.completedCount(forTrack: track.id)
        let total = progress.liveCount(forTrack: track.id)
        let frac = total > 0 ? Double(done) / Double(total) : 0
        let certified = progress.isExamPassed(track.id)
        let score = progress.examResults[track.id].map { Int(($0.fraction * 100).rounded()) }
        return HStack(spacing: 14) {
            Image(systemName: track.icon).font(.system(size: 15, weight: .bold)).foregroundStyle(track.accent).frame(width: 24)
            Text(track.role).font(.brandRounded(14, .semibold)).foregroundStyle(Brand.ink).frame(width: 170, alignment: .leading)
            Text("\(done)/\(total)").font(.brandMono(12, .regular)).foregroundStyle(Brand.muted).frame(width: 50, alignment: .leading)
            GeometryReader { geo in
                Capsule().fill(Brand.ink.opacity(0.06)).overlay(alignment: .leading) {
                    Capsule().fill(track.accent).frame(width: max(6, geo.size.width * CGFloat(frac)))
                }
            }
            .frame(height: 8)
            if certified {
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.seal.fill").font(.system(size: 11))
                    Text(score.map { "\($0)%" } ?? "Certified").font(.brandMono(11, .bold))
                }
                .foregroundStyle(Brand.up).frame(width: 84, alignment: .trailing)
            } else {
                Text("—").font(.brandMono(12, .regular)).foregroundStyle(Brand.faint).frame(width: 84, alignment: .trailing)
            }
        }
        .padding(14)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    // MARK: Team roll-up (import several learner transcripts into one roster)

    private var teamRollup: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                SectionHeader(title: "Team roll-up", accent: Brand.analytics)
                Spacer()
                Button(action: importCohort) {
                    HStack(spacing: 5) {
                        Image(systemName: "square.and.arrow.down")
                        Text(cohort.isEmpty ? "Import transcripts (CSV)" : "Add more")
                    }
                    .font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.analytics)
                    .padding(.horizontal, 11).padding(.vertical, 6)
                    .background(Brand.analytics.opacity(0.12), in: Capsule())
                }
                .buttonStyle(.plain)
                if !cohort.isEmpty {
                    Button { Exporter.saveText(Cohort.reportCSV(cohort), name: "bidlab-cohort", ext: "csv") } label: {
                        HStack(spacing: 5) { Image(systemName: "tablecells"); Text("Export report") }
                            .font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.violet)
                            .padding(.horizontal, 11).padding(.vertical, 6)
                            .background(Brand.violet.opacity(0.12), in: Capsule())
                    }
                    .buttonStyle(.plain)
                    Button { cohort = [] } label: {
                        Text("Clear").font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.muted)
                    }
                    .buttonStyle(.plain)
                }
            }
            Text("Each learner exports their transcript (here or in Settings). Import those CSV files to build a roster for an LMS or a manager review, all on this device. Each row shows whether its signature checks out, so an edited file is flagged.")
                .font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted).fixedSize(horizontal: false, vertical: true)
            if cohort.isEmpty {
                GuidedEmptyState(
                    icon: "person.3.fill",
                    title: "No team imported yet",
                    message: "Import learner transcript CSVs to see completion, certifications, and simulator scores across your whole team in one roster.",
                    accent: Brand.analytics,
                    ctaTitle: "Import transcripts",
                    action: importCohort
                )
            } else {
                cohortSummaryCards
                if cohort.contains(where: { $0.verification == .tampered }) {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill").font(.system(size: 12, weight: .bold)).foregroundStyle(Brand.down)
                        Text("One or more transcripts were edited after export and no longer match their signature. They are flagged below.")
                            .font(.brandRounded(12.5, .medium)).foregroundStyle(Brand.down).fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(12).frame(maxWidth: .infinity, alignment: .leading)
                    .background(Brand.down.opacity(0.08), in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
                }
                cohortRoster
            }
        }
    }

    private var cohortSummaryCards: some View {
        let s = Cohort.summarize(cohort)
        return HStack(spacing: 12) {
            metric("Learners", "\(s.learnerCount)", Brand.analytics)
            metric("Avg completion", "\(Int((s.avgCompletion * 100).rounded()))%", Brand.violet)
            metric("Certifications", "\(s.totalCertifications)", Brand.up)
            metric("Certified", "\(s.certifiedLearners) / \(s.learnerCount)", Brand.planning)
        }
    }

    private var cohortRoster: some View {
        VStack(spacing: 8) {
            HStack(spacing: 12) {
                Text("Learner").font(.brandMono(11, .semibold)).foregroundStyle(Brand.faint).frame(width: 180, alignment: .leading)
                Text("Completion").font(.brandMono(11, .semibold)).foregroundStyle(Brand.faint).frame(maxWidth: .infinity, alignment: .leading)
                Text("Certs").font(.brandMono(11, .semibold)).foregroundStyle(Brand.faint).frame(width: 50, alignment: .trailing)
                Text("Best").font(.brandMono(11, .semibold)).foregroundStyle(Brand.faint).frame(width: 50, alignment: .trailing)
            }
            .padding(.horizontal, 14)
            ForEach(Array(cohort.enumerated()), id: \.offset) { _, r in cohortRow(r) }
        }
    }

    @ViewBuilder private func verificationBadge(_ v: TranscriptVerification) -> some View {
        switch v {
        case .verified: Image(systemName: "checkmark.seal.fill").font(.system(size: 11)).foregroundStyle(Brand.up)
        case .tampered: Image(systemName: "exclamationmark.triangle.fill").font(.system(size: 11)).foregroundStyle(Brand.down)
        case .unsigned: Image(systemName: "questionmark.circle").font(.system(size: 11)).foregroundStyle(Brand.faint)
        }
    }

    private func cohortRow(_ r: LearnerRecord) -> some View {
        HStack(spacing: 12) {
            HStack(spacing: 6) {
                verificationBadge(r.verification)
                Text(r.name).font(.brandRounded(14, .semibold)).foregroundStyle(Brand.ink).lineLimit(1)
            }
            .frame(width: 180, alignment: .leading)
            HStack(spacing: 8) {
                GeometryReader { geo in
                    Capsule().fill(Brand.ink.opacity(0.06)).overlay(alignment: .leading) {
                        Capsule().fill(Brand.violet).frame(width: max(6, geo.size.width * CGFloat(r.completionFraction)))
                    }
                }
                .frame(height: 8)
                Text("\(r.lessonsCompleted)/\(r.lessonsTotal)").font(.brandMono(11, .regular)).foregroundStyle(Brand.muted).frame(width: 54, alignment: .trailing)
            }
            .frame(maxWidth: .infinity)
            Text("\(r.certificationsEarned)").font(.brandMono(13, .bold))
                .foregroundStyle(r.certificationsEarned > 0 ? Brand.up : Brand.faint).frame(width: 50, alignment: .trailing)
            Text(r.bestTradingScore > 0 ? "\(r.bestTradingScore)" : "—").font(.brandMono(13, .regular)).foregroundStyle(Brand.muted).frame(width: 50, alignment: .trailing)
        }
        .padding(14)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    private func importCohort() {
        let files = Importer.openTranscripts()
        guard !files.isEmpty else { return }
        var byName: [String: LearnerRecord] = [:]
        for r in cohort + Cohort.parseAll(files) { byName[r.name] = r } // newest import wins per name
        cohort = byName.values.sorted { $0.completionFraction > $1.completionFraction }
    }

    private var hostedNote: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "person.3.fill").font(.system(size: 13, weight: .bold)).foregroundStyle(Brand.analytics)
                Text("Deploying to a team").font(.brandRounded(14, .bold)).foregroundStyle(Brand.ink)
            }
            Text("BidLab runs locally, so this shows your own verified record, not mocked teammates. Multi-seat tracking, SSO, path assignment, and a live manager dashboard are the hosted tier. Until then, each learner exports the transcript above (CSV or JSON) to roll completion and certification into your LMS or a manager report.")
                .font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted).fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.analytics.opacity(0.05), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.analytics.opacity(0.2), lineWidth: 1))
    }

    // MARK: Shared

    private var pathsStarted: Int {
        Track.all.filter { progress.completedCount(forTrack: $0.id) > 0 }.count
    }

    private func metric(_ label: String, _ value: String, _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted)
            Text(value).font(.brandDisplay(24, .heavy)).foregroundStyle(color)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    private static func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }
}
