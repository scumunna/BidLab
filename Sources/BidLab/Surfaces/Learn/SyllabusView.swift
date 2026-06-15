import SwiftUI

/// The path's lessons as a connected journey: circular nodes on a spine, each
/// showing done, up-next, or locked, with the lesson title and a status badge.
/// Gives the guided-path feel of Duolingo without fragile absolute layout.
struct SyllabusView: View {
    let track: Track
    let onOpen: (String) -> Void
    @EnvironmentObject var progress: ProgressStore

    private var modules: [ModuleInfo] { Curriculum.modules(for: track.id) }
    private var firstIncomplete: Int? {
        modules.firstIndex { Curriculum.isAvailable($0.lessonID) && !progress.isComplete($0.lessonID) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(modules.enumerated()), id: \.offset) { i, module in
                row(module, index: i, isFirst: i == 0, isLast: i == modules.count - 1)
            }
        }
    }

    private func row(_ module: ModuleInfo, index i: Int, isFirst: Bool, isLast: Bool) -> some View {
        let available = Curriculum.isAvailable(module.lessonID)
        let done = available && progress.isComplete(module.lessonID)
        let isNext = available && firstIncomplete == i

        return Button {
            if available { onOpen(module.lessonID) }
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    VStack(spacing: 0) {
                        Rectangle().fill(isFirst ? Color.clear : track.accent.opacity(0.22)).frame(width: 3, height: 36)
                        Rectangle().fill(isLast ? Color.clear : track.accent.opacity(0.22)).frame(width: 3, height: 36)
                    }
                    JourneyNode(number: module.number, done: done, available: available, isNext: isNext, accent: track.accent)
                }
                .frame(width: 36, height: 72)

                HStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(module.title)
                            .font(.brandRounded(15, done || available ? .semibold : .regular))
                            .foregroundStyle(available ? Brand.ink : Brand.muted)
                            .lineLimit(1)
                        if isNext {
                            Text("Up next").font(.brandMono(10, .semibold)).foregroundStyle(track.accent).tracking(0.5)
                        }
                    }
                    Spacer(minLength: 8)
                    statusBadge(done: done, available: available)
                }
                .padding(.trailing, 4)
            }
            .frame(height: 72)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!available)
    }

    private struct JourneyNode: View {
        let number: Int
        let done: Bool
        let available: Bool
        let isNext: Bool
        let accent: Color
        @Local private var pulse = false

        var body: some View {
            ZStack {
                if isNext {
                    Circle().stroke(accent, lineWidth: 3)
                        .frame(width: 34, height: 34)
                        .scaleEffect(pulse ? 1.4 : 1)
                        .opacity(pulse ? 0 : 0.6)
                }
                Circle()
                    .fill(done ? accent : Brand.surface)
                    .frame(width: 34, height: 34)
                    .overlay(
                        Circle().strokeBorder(
                            isNext ? accent : (available ? accent.opacity(0.5) : Brand.hairline),
                            lineWidth: isNext ? 3 : 2
                        )
                    )
                    .shadow(color: isNext ? accent.opacity(0.3) : .clear, radius: 6)
                if done {
                    Image(systemName: "checkmark").font(.system(size: 15, weight: .bold)).foregroundStyle(.white)
                } else if available {
                    Text("\(number)").font(.brandMono(13, .bold)).foregroundStyle(accent)
                } else {
                    Image(systemName: "lock.fill").font(.system(size: 11, weight: .bold)).foregroundStyle(Brand.faint)
                }
            }
            .onAppear {
                if isNext {
                    withAnimation(.easeOut(duration: 1.4).repeatForever(autoreverses: false)) { pulse = true }
                }
            }
        }
    }

    @ViewBuilder
    private func statusBadge(done: Bool, available: Bool) -> some View {
        if done {
            HStack(spacing: 4) {
                Image(systemName: "checkmark.seal.fill").font(.system(size: 12))
                Text("Done").font(.brandRounded(12, .bold))
            }
            .foregroundStyle(Brand.up)
        } else if available {
            HStack(spacing: 4) {
                Image(systemName: "play.circle.fill").font(.system(size: 13))
                Text("Start").font(.brandRounded(12.5, .bold))
            }
            .foregroundStyle(track.accent)
        } else {
            Text("soon").font(.brandMono(11, .regular)).foregroundStyle(Brand.faint)
        }
    }
}
