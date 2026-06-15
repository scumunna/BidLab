import SwiftUI

/// The Learn landing: a hero, the path selector with progress, and a resume CTA.
struct LearnSurface: View {
    @EnvironmentObject var app: AppState
    @EnvironmentObject var progress: ProgressStore
    @Local private var query = ""
    @Local private var showGuide = false

    private let columns = [GridItem(.adaptive(minimum: 250, maximum: 360), spacing: 16)]

    /// The first available lesson not yet completed, scanning paths in order.
    private var resumeLessonID: String? {
        for track in Track.all {
            for module in Curriculum.modules(for: track.id) where Curriculum.isAvailable(module.lessonID) {
                if !progress.isComplete(module.lessonID) { return module.lessonID }
            }
        }
        return nil
    }

    var body: some View {
        ZStack {
            if let id = app.openLessonID, let lesson = LessonLibrary.lesson(id: id) {
                LessonReaderView(
                    lesson: lesson,
                    accent: accent(for: lesson.track),
                    onBack: { app.openLessonID = nil },
                    onOpenLesson: { nextID in app.openLessonID = nextID }
                )
                .id(id)
                .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .opacity))
            } else if let pathID = app.openPathID, let track = Track.all.first(where: { $0.id == pathID }) {
                PathDetailView(
                    track: track,
                    onBack: { app.openPathID = nil },
                    onOpenLesson: { app.openLessonID = $0 }
                )
                .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .opacity))
            } else {
                browse
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.28), value: app.openPathID)
        .animation(.easeInOut(duration: 0.28), value: app.openLessonID)
    }

    private var browse: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                hero
                if showGuide { howItWorksPanel }
                if progress.totalCompleted == 0 && !showGuide { starterCard }
                searchBar
                if query.trimmingCharacters(in: .whitespaces).isEmpty {
                    pathPicker
                } else {
                    searchResults
                }
            }
            .padding(.horizontal, 38)
            .padding(.top, 40)
            .padding(.bottom, 48)
            .frame(maxWidth: 1120, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func accent(for track: String) -> Color {
        Track.all.first { $0.id == track }?.accent ?? Brand.violet
    }

    private func heroBadge(icon: String, text: String, color: Color) -> some View {
        HStack(spacing: 5) {
            Image(systemName: icon).font(.system(size: 11, weight: .bold))
            Text(text).font(.brandRounded(12.5, .semibold))
        }
        .foregroundStyle(color)
        .padding(.horizontal, 11)
        .padding(.vertical, 6)
        .background(color.opacity(0.12), in: Capsule())
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 15) {
            Pill(text: "The flight simulator for programmatic", color: Brand.violet)
            Text("Master programmatic advertising by doing the math.")
                .font(.brandDisplay(34, .heavy))
                .foregroundStyle(Brand.ink)
                .fixedSize(horizontal: false, vertical: true)
            Text("Nine learning paths. From arithmetic to auction theory, every concept is interactive and every number is real. Train the bid, the campaign, the plan, the deal, the experiment, the bidder, and the AI itself, without spending a dollar of media.")
                .font(.brandRounded(15, .regular))
                .foregroundStyle(Brand.muted)
                .lineSpacing(3)
                .frame(maxWidth: 700, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            HStack(spacing: 10) {
                StatChip(value: "\(Track.all.count)", label: "learning paths")
                StatChip(value: "\(LessonLibrary.all.count)", label: "lessons")
                StatChip(value: "0 → expert", label: "from scratch")
                StatChip(value: "Math-true", label: "simulators")
            }
            .padding(.top, 4)
            if let vertical = app.selectedVertical {
                Button { app.surface = .verticals } label: {
                    heroBadge(icon: vertical.icon, text: "Tuned for \(vertical.name)", color: Brand.dsp)
                }
                .buttonStyle(.plain)
                .padding(.top, 2)
            }
            if progress.totalCompleted > 0 {
                HStack(spacing: 10) {
                    heroBadge(icon: "flame.fill", text: "\(progress.streak)-day streak", color: Brand.planning)
                    heroBadge(icon: "star.fill", text: "\(progress.xp) XP", color: Brand.violet)
                    if progress.streakFreezes > 0 {
                        heroBadge(icon: "snowflake",
                                  text: "\(progress.streakFreezes) freeze\(progress.streakFreezes == 1 ? "" : "s")",
                                  color: Brand.dsp)
                    }
                    DailyGoalRing(done: progress.goalProgressToday, goal: progress.dailyGoal)
                }
                .padding(.top, 2)
            }
            HStack(spacing: 10) {
                if let resume = resumeLessonID {
                    PrimaryButton(progress.totalCompleted > 0 ? "Continue learning" : "Start learning", icon: "arrow.right") {
                        app.openLessonID = resume
                    }
                } else {
                    PrimaryButton("Review a lesson", icon: "book") {
                        app.openLessonID = LessonLibrary.sampleLessonID
                    }
                }
                Button { withAnimation(.easeInOut(duration: 0.2)) { showGuide = true } } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "questionmark.circle").font(.system(size: 13, weight: .bold))
                        Text("How it works").font(.brandRounded(13.5, .semibold))
                    }
                    .foregroundStyle(Brand.violet)
                    .padding(.horizontal, 12).padding(.vertical, 10)
                    .background(Brand.violet.opacity(0.08), in: Capsule())
                }
                .buttonStyle(.plain)
            }
            .padding(.top, 6)
        }
    }

    private var pathPicker: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Choose your path")
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Track.all) { track in
                    TrackCard(
                        track: track,
                        isSelected: app.selectedTrackID == track.id,
                        completed: progress.completedCount(forTrack: track.id),
                        live: progress.liveCount(forTrack: track.id)
                    ) {
                        app.selectedTrackID = track.id
                        app.openPathID = track.id
                    }
                }
            }
        }
    }

    private func roleFor(_ track: String) -> String {
        Track.all.first { $0.id == track }?.role ?? track
    }

    // MARK: Onboarding and help

    /// Shown to a brand-new learner (no progress yet): a clear, friendly entry
    /// point so they are not dropped into nine paths with no orientation.
    private var starterCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: "hand.wave.fill").font(.system(size: 15)).foregroundStyle(Brand.violet)
                Text("New here? Start with the basics.").font(.brandRounded(16, .bold)).foregroundStyle(Brand.ink)
            }
            Text("No background needed. BidLab takes you from arithmetic to the real job, one short interactive lesson at a time. The recommended path:")
                .font(.brandRounded(13.5, .regular)).foregroundStyle(Brand.muted).fixedSize(horizontal: false, vertical: true)
            sequenceRow
            HStack(spacing: 12) {
                PrimaryButton("Start with Foundations", icon: "arrow.right") { app.openLessonID = "foundations-01" }
                Button { withAnimation(.easeInOut(duration: 0.2)) { showGuide = true } } label: {
                    Text("See how it works").font(.brandRounded(13.5, .semibold)).foregroundStyle(Brand.violet)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.violet.opacity(0.05), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.violet.opacity(0.2), lineWidth: 1))
    }

    /// The full plain-language guide, reachable any time from the hero.
    private var howItWorksPanel: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("How BidLab works").font(.brandDisplay(22, .heavy)).foregroundStyle(Brand.ink)
                Spacer()
                Button { withAnimation(.easeInOut(duration: 0.2)) { showGuide = false } } label: {
                    Image(systemName: "xmark.circle.fill").font(.system(size: 20)).foregroundStyle(Brand.faint)
                }
                .buttonStyle(.plain)
            }
            guideBlock("1. Follow the path from zero", "You need no background. Begin with Foundations (the math), then Programmatic Core and Ad Operations (how the ecosystem and the job work), then your role: DSP/Trader, Sales, Planning, Analytics, Engineering, or AI. Each path ends with a certification exam.")
            sequenceRow
            guideBlock("2. Learn by doing", "Every lesson is a short interactive page. You read a little, then a question asks you to predict a number or pick an answer, and you check it on the spot. Charts and simulators are interactive too. Tap Continue to advance, and the path remembers where you left off.")
            Text("3. Find your way around").font(.brandRounded(14.5, .bold)).foregroundStyle(Brand.ink)
            VStack(spacing: 8) {
                ForEach(surfaceGuide.indices, id: \.self) { i in surfaceRow(surfaceGuide[i]) }
            }
            PrimaryButton("Start with Foundations", icon: "arrow.right") { app.openLessonID = "foundations-01" }
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    private var sequenceRow: some View {
        HStack(spacing: 6) {
            seqChip("Foundations", Brand.foundations)
            seqArrow
            seqChip("Core + AdOps", Brand.core)
            seqArrow
            seqChip("Your role", Brand.dsp)
            seqArrow
            seqChip("Certify", Brand.up)
        }
    }

    private func seqChip(_ t: String, _ c: Color) -> some View {
        Text(t).font(.brandMono(11, .semibold)).foregroundStyle(c)
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(c.opacity(0.12), in: Capsule())
    }

    private var seqArrow: some View {
        Image(systemName: "arrow.right").font(.system(size: 10, weight: .bold)).foregroundStyle(Brand.faint)
    }

    private func guideBlock(_ title: String, _ body: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.brandRounded(14.5, .bold)).foregroundStyle(Brand.ink)
            Text(body).font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted).fixedSize(horizontal: false, vertical: true)
        }
    }

    private func surfaceRow(_ s: (icon: String, name: String, blurb: String)) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: s.icon).font(.system(size: 14, weight: .bold)).foregroundStyle(Brand.violet).frame(width: 22)
            Text(s.name).font(.brandRounded(13, .semibold)).foregroundStyle(Brand.ink).frame(width: 150, alignment: .leading)
            Text(s.blurb).font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted).fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
    }

    private let surfaceGuide: [(icon: String, name: String, blurb: String)] = [
        ("books.vertical.fill", "Learn", "The nine paths and their lessons. Start here."),
        ("arrow.triangle.2.circlepath", "Review", "Brings back what you learned on a spaced schedule so it sticks."),
        ("building.2.fill", "Industries", "The same math tuned to your world: retail, finance, CTV, and more."),
        ("bolt.horizontal.fill", "Trading Floor", "A live bidding simulator. Set a bid, run the market, score against the optimum."),
        ("slider.horizontal.3", "Tools", "Math-true calculators you can use on your own campaigns."),
        ("graduationcap.fill", "Exams", "Pass a path's exam to earn a certification."),
        ("chart.bar.fill", "Progress", "Your XP, streak, certifications, and review queue."),
        ("person.3.fill", "Team and transcript", "Export your completion and certification record."),
        ("sparkles", "Explorable", "A signature interactive that shows the whole ecosystem in motion."),
    ]

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass").font(.system(size: 13, weight: .semibold)).foregroundStyle(Brand.faint)
            TextField("Search \(LessonLibrary.all.count) lessons by topic, metric, or term", text: $query)
                .textFieldStyle(.plain)
                .font(.brandRounded(14, .regular))
                .foregroundStyle(Brand.ink)
            if !query.isEmpty {
                Button { query = "" } label: {
                    Image(systemName: "xmark.circle.fill").font(.system(size: 13)).foregroundStyle(Brand.faint)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 14).padding(.vertical, 11)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
        .frame(maxWidth: 560)
    }

    private var searchResults: some View {
        let q = query.trimmingCharacters(in: .whitespaces)
        let matches = LessonLibrary.all.filter { lesson in
            lesson.title.localizedCaseInsensitiveContains(q)
                || lesson.summary.localizedCaseInsensitiveContains(q)
                || roleFor(lesson.track).localizedCaseInsensitiveContains(q)
        }
        return VStack(alignment: .leading, spacing: 10) {
            SectionHeader(title: matches.isEmpty ? "No lessons match \"\(q)\"" : "\(matches.count) lesson\(matches.count == 1 ? "" : "s")")
            ForEach(matches.prefix(40), id: \.id) { lesson in
                Button { app.openLessonID = lesson.id } label: {
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(lesson.title).font(.brandRounded(14.5, .semibold)).foregroundStyle(Brand.ink)
                            Text(lesson.summary).font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted).lineLimit(1)
                        }
                        Spacer(minLength: 8)
                        Text(roleFor(lesson.track)).font(.brandMono(10, .semibold)).foregroundStyle(accent(for: lesson.track))
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(accent(for: lesson.track).opacity(0.12), in: Capsule())
                        Image(systemName: "chevron.right").font(.system(size: 11, weight: .bold)).foregroundStyle(Brand.faint)
                    }
                    .padding(14).frame(maxWidth: .infinity, alignment: .leading)
                    .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
                }
                .buttonStyle(.plain)
            }
        }
    }

}
