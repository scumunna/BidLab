import SwiftUI

/// A focused view of a single path: its header, overall progress, and the full
/// module list as a journey. Entered by tapping a path card, so the syllabus is
/// front and center instead of buried below the grid.
struct PathDetailView: View {
    let track: Track
    let onBack: () -> Void
    let onOpenLesson: (String) -> Void
    @EnvironmentObject var progress: ProgressStore

    private var live: Int { progress.liveCount(forTrack: track.id) }
    private var done: Int { progress.completedCount(forTrack: track.id) }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                Button(action: onBack) {
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.left").font(.system(size: 12, weight: .bold))
                        Text("All paths").font(.brandRounded(13, .semibold))
                    }
                    .foregroundStyle(Brand.muted)
                }
                .buttonStyle(.plain)

                HStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(track.accent.opacity(0.16))
                        .frame(width: 64, height: 64)
                        .overlay(Image(systemName: track.icon).font(.system(size: 28, weight: .bold)).foregroundStyle(track.accent))
                    VStack(alignment: .leading, spacing: 5) {
                        Text(track.role).font(.brandDisplay(28, .heavy)).foregroundStyle(Brand.ink)
                        Text(track.tagline).font(.brandRounded(14.5, .regular)).foregroundStyle(Brand.muted)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                if live > 0 {
                    VStack(alignment: .leading, spacing: 7) {
                        GeometryReader { geo in
                            Capsule().fill(track.accent.opacity(0.14)).overlay(alignment: .leading) {
                                Capsule().fill(track.accent).frame(width: max(done > 0 ? 6 : 0, geo.size.width * CGFloat(done) / CGFloat(live)))
                            }
                        }
                        .frame(height: 7)
                        Text("\(done) of \(live) lessons complete")
                            .font(.brandMono(12, .medium)).foregroundStyle(Brand.muted)
                    }
                }

                SyllabusView(track: track, onOpen: onOpenLesson)
            }
            .padding(.horizontal, 40)
            .padding(.top, 30)
            .padding(.bottom, 56)
            .frame(maxWidth: 860, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
