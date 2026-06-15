import SwiftUI

/// The BidLab wordmark: a violet spark mark plus "BidLab".
struct Wordmark: View {
    var size: CGFloat = 26

    var body: some View {
        HStack(spacing: 10) {
            RoundedRectangle(cornerRadius: size * 0.32, style: .continuous)
                .fill(Brand.violet)
                .frame(width: size * 1.2, height: size * 1.2)
                .overlay(
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .font(.system(size: size * 0.6, weight: .bold))
                        .foregroundStyle(Brand.lime)
                )
            HStack(spacing: 0) {
                Text("Bid").foregroundStyle(Brand.ink)
                Text("Lab").foregroundStyle(Brand.violet)
            }
            .font(.brandDisplay(size, .heavy))
        }
    }
}

/// A small uppercase tag.
struct Pill: View {
    let text: String
    var color: Color = Brand.violet

    var body: some View {
        Text(text.uppercased())
            .font(.brandMono(11, .semibold))
            .tracking(0.5)
            .foregroundStyle(color)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(color.opacity(0.13), in: Capsule())
    }
}

/// A headline stat used in the Learn hero.
struct StatChip: View {
    let value: String
    let label: String

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(value)
                .font(.brandDisplay(20, .heavy))
                .foregroundStyle(Brand.ink)
            Text(label)
                .font(.brandRounded(12, .medium))
                .foregroundStyle(Brand.muted)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous)
                .strokeBorder(Brand.hairline, lineWidth: 1)
        )
    }
}

/// A section title with an accent bar.
struct SectionHeader: View {
    let title: String
    var accent: Color = Brand.violet

    var body: some View {
        HStack(spacing: 9) {
            RoundedRectangle(cornerRadius: 2)
                .fill(accent)
                .frame(width: 4, height: 18)
            Text(title)
                .font(.brandRounded(16, .bold))
                .foregroundStyle(Brand.ink)
        }
    }
}

/// A horizontal segmented navigation that gives a surface multiple pages, so a
/// surface reads as a real ecosystem instead of one long scroll. Each item is a
/// pill; the active one fills with the accent color.
struct InnerTabBar: View {
    struct Item: Identifiable, Equatable {
        let id: String
        let title: String
        let icon: String
    }

    let items: [Item]
    @Binding var selection: String
    var accent: Color = Brand.violet

    var body: some View {
        HStack(spacing: 4) {
            ForEach(items) { item in
                let active = selection == item.id
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.82)) { selection = item.id }
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: item.icon).font(.system(size: 12, weight: .semibold))
                        Text(item.title).font(.brandRounded(13, active ? .semibold : .medium))
                    }
                    .foregroundStyle(active ? .white : Brand.muted)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(active ? accent : Color.clear, in: Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(Brand.surface, in: Capsule())
        .overlay(Capsule().strokeBorder(Brand.hairline, lineWidth: 1))
    }
}

/// A button style that scales slightly on press for tactile feedback.
struct PressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

/// A pill-shaped primary call to action.
struct PrimaryButton: View {
    let title: String
    var icon: String?
    var color: Color = Brand.violet
    let action: () -> Void

    init(_ title: String, icon: String? = nil, color: Color = Brand.violet, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.color = color
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon).font(.system(size: 13, weight: .bold))
                }
                Text(title).font(.brandRounded(14, .bold))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 18)
            .padding(.vertical, 11)
            .background(color, in: Capsule())
        }
        .buttonStyle(PressableStyle())
    }
}

/// A selectable learning-path card for the role selector.
struct TrackCard: View {
    let track: Track
    let isSelected: Bool
    var completed: Int = 0
    var live: Int = 0
    let action: () -> Void
    @Local private var hover = false

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 13) {
                HStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(track.accent.opacity(0.16))
                        .frame(width: 52, height: 52)
                        .overlay(
                            Image(systemName: track.icon)
                                .font(.system(size: 23, weight: .bold))
                                .foregroundStyle(track.accent)
                        )
                    Spacer()
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(isSelected ? track.accent : Brand.faint)
                }
                Text(track.role)
                    .font(.brandDisplay(20, .bold))
                    .foregroundStyle(Brand.ink)
                Text(track.tagline)
                    .font(.brandRounded(13.5, .regular))
                    .foregroundStyle(Brand.muted)
                    .lineSpacing(2)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer(minLength: 2)
                if live > 0 {
                    VStack(alignment: .leading, spacing: 6) {
                        GeometryReader { geo in
                            Capsule().fill(track.accent.opacity(0.14)).overlay(alignment: .leading) {
                                Capsule().fill(track.accent)
                                    .frame(width: max(completed > 0 ? 5 : 0, geo.size.width * CGFloat(completed) / CGFloat(live)))
                            }
                        }
                        .frame(height: 5)
                        HStack(spacing: 6) {
                            Image(systemName: "square.stack.3d.up").font(.system(size: 12, weight: .semibold)).foregroundStyle(track.accent)
                            Text("\(completed) / \(live) done")
                                .font(.brandMono(12, .medium)).foregroundStyle(Brand.muted)
                        }
                    }
                } else {
                    HStack(spacing: 6) {
                        Image(systemName: "square.stack.3d.up")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(track.accent)
                        Text("\(track.modules) modules")
                            .font(.brandMono(12, .medium))
                            .foregroundStyle(Brand.muted)
                    }
                }
            }
            .padding(18)
            .frame(maxWidth: .infinity, minHeight: 200, alignment: .topLeading)
            .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous)
                    .strokeBorder(isSelected ? track.accent : Brand.hairline, lineWidth: isSelected ? 2 : 1)
            )
            .shadow(color: isSelected ? track.accent.opacity(0.20) : .black.opacity(0.04), radius: isSelected ? 16 : 6, y: isSelected ? 8 : 3)
            .scaleEffect(hover ? 1.012 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.72), value: hover)
        }
        .buttonStyle(.plain)
        .onHover { hover = $0 }
    }
}
