import SwiftUI

/// A compact daily-goal ring for the Learn hero: progress toward today's target
/// number of activities. Fills and turns green when the goal is met.
struct DailyGoalRing: View {
    let done: Int
    let goal: Int

    private var fraction: Double { goal > 0 ? min(1, Double(done) / Double(goal)) : 0 }
    private var met: Bool { goal > 0 && done >= goal }

    var body: some View {
        HStack(spacing: 6) {
            ZStack {
                Circle().stroke(Brand.up.opacity(0.18), lineWidth: 3)
                Circle().trim(from: 0, to: fraction)
                    .stroke(met ? Brand.up : Brand.planning, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut(duration: 0.3), value: fraction)
            }
            .frame(width: 16, height: 16)
            Text(met ? "goal met" : "\(min(done, goal))/\(goal) today")
                .font(.brandRounded(12.5, .semibold))
                .foregroundStyle(met ? Brand.up : Brand.muted)
        }
        .padding(.horizontal, 11).padding(.vertical, 6)
        .background((met ? Brand.up : Brand.muted).opacity(0.12), in: Capsule())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Daily goal, \(min(done, goal)) of \(goal) activities done today")
    }
}

/// A celebratory overlay shown when the learner crosses a streak milestone
/// (7, 30, 100, 365 days). Tapping the backdrop or the button dismisses it.
struct StreakMilestoneOverlay: View {
    let streak: Int
    let onDismiss: () -> Void
    @Local private var pop = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            Color.black.opacity(0.34).ignoresSafeArea().onTapGesture(perform: onDismiss)
            VStack(spacing: 16) {
                ZStack {
                    Circle().stroke(Brand.planning.opacity(0.5), lineWidth: 3).frame(width: 96, height: 96)
                        .scaleEffect(pop ? 1.6 : 0.7).opacity(pop ? 0 : 0.7)
                    Circle().fill(Brand.planning.opacity(0.16)).frame(width: 92, height: 92)
                    Image(systemName: "flame.fill").font(.system(size: 44, weight: .bold)).foregroundStyle(Brand.planning)
                        .scaleEffect(pop ? 1 : 0.4)
                }
                Text("\(streak)-day streak!").font(.brandDisplay(28, .heavy)).foregroundStyle(Brand.ink)
                Text(message).font(.brandRounded(14, .regular)).foregroundStyle(Brand.muted)
                    .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                PrimaryButton("Keep it going", icon: "arrow.right", color: Brand.planning) { onDismiss() }
            }
            .padding(32)
            .frame(maxWidth: 360)
            .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.planning.opacity(0.3), lineWidth: 2))
            .scaleEffect(pop ? 1 : 0.85).opacity(pop ? 1 : 0)
        }
        .onAppear {
            if reduceMotion {
                pop = true
            } else {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.58)) { pop = true }
            }
            Sound.complete()
        }
    }

    private var message: String {
        switch streak {
        case 7: return "A full week of training. This is how mastery compounds."
        case 30: return "Thirty days straight. You are in rare company now."
        case 100: return "One hundred days. Genuinely elite consistency."
        case 365: return "A full year of practice. Extraordinary."
        default: return "Incredible consistency. Keep the chain alive."
        }
    }
}
