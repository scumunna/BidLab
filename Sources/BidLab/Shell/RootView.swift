import SwiftUI

/// The app shell: sidebar rail plus the active surface.
struct RootView: View {
    @StateObject private var app = AppState()
    @StateObject private var progress = ProgressStore()

    var body: some View {
        HStack(spacing: 0) {
            Sidebar()
            ZStack {
                Brand.canvas.ignoresSafeArea()
                content
            }
        }
        .environmentObject(app)
        .environmentObject(progress)
        .overlay {
            if let milestone = progress.pendingStreakMilestone {
                StreakMilestoneOverlay(streak: milestone) { progress.pendingStreakMilestone = nil }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: progress.pendingStreakMilestone)
        .frame(minWidth: 940, minHeight: 640)
        .preferredColorScheme(nil) // follow the system appearance
    }

    @ViewBuilder
    private var content: some View {
        switch app.surface {
        case .learn:
            LearnSurface()
        case .review:
            ReviewSurface()
        case .verticals:
            VerticalsSurface()
        case .tradingFloor:
            TradingFloorView()
        case .tools:
            ToolsSurface()
        case .exams:
            ExamSurface()
        case .progress:
            ProgressSurface()
        case .explorable:
            ExplorableSurface()
        case .settings:
            SettingsSurface()
        }
    }
}
