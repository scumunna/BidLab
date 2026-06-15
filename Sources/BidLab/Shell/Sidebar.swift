import SwiftUI

/// The left navigation rail.
struct Sidebar: View {
    @EnvironmentObject var app: AppState
    @EnvironmentObject var progress: ProgressStore

    private var initial: String {
        String(progress.displayName.prefix(1)).uppercased()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Color.clear.frame(height: Metric.titleBarInset) // clears the window controls
            Wordmark(size: 22)
                .padding(.horizontal, 18)
                .padding(.bottom, 20)

            VStack(spacing: 4) {
                ForEach(Surface.allCases.filter { $0 != .settings }) { surface in
                    SidebarItem(surface: surface, isActive: app.surface == surface) {
                        app.surface = surface
                    }
                }
            }
            .padding(.horizontal, 12)

            Spacer()

            Rectangle().fill(Brand.hairline).frame(height: 1)
            Button { app.surface = .settings } label: {
                HStack(spacing: 10) {
                    Circle()
                        .fill(app.surface == .settings ? Brand.violet : Brand.violet.opacity(0.16))
                        .frame(width: 30, height: 30)
                        .overlay(Text(initial).font(.brandDisplay(14, .bold)).foregroundStyle(app.surface == .settings ? .white : Brand.violet))
                    VStack(alignment: .leading, spacing: 1) {
                        Text(progress.displayName).font(.brandRounded(13, .semibold)).foregroundStyle(Brand.ink)
                        Text("Profile and settings").font(.brandMono(11, .regular)).foregroundStyle(Brand.faint)
                    }
                    Spacer()
                    Image(systemName: "gearshape").font(.system(size: 13)).foregroundStyle(Brand.faint)
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
            }
            .buttonStyle(.plain)
        }
        .frame(width: Metric.sidebarWidth)
        .background(Brand.surface)
        .overlay(alignment: .trailing) { Rectangle().fill(Brand.hairline).frame(width: 1) }
    }
}

private struct SidebarItem: View {
    let surface: Surface
    let isActive: Bool
    let action: () -> Void
    @Local private var hover = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 11) {
                Image(systemName: surface.icon)
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 20)
                    .foregroundStyle(isActive ? Brand.violet : Brand.muted)
                Text(surface.title)
                    .font(.brandRounded(14, isActive ? .semibold : .medium))
                    .foregroundStyle(isActive ? Brand.ink : Brand.muted)
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(
                isActive ? Brand.violet.opacity(0.12) : (hover ? Brand.ink.opacity(0.04) : .clear),
                in: RoundedRectangle(cornerRadius: Metric.radiusSm, style: .continuous)
            )
        }
        .buttonStyle(.plain)
        .onHover { hover = $0 }
    }
}
