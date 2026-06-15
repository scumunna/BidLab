import SwiftUI

/// Profile and settings: the learner's name (which appears on certificates),
/// the daily goal, the data controls, and where to change paths. Accounts and
/// single sign-on are part of the hosted tier; on this device everything is
/// stored locally with no login.
struct SettingsSurface: View {
    @EnvironmentObject var app: AppState
    @EnvironmentObject var progress: ProgressStore

    @Local private var nameDraft = ""
    @Local private var confirmReset = false
    @Local private var loaded = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                header
                profileSection
                learningSection
                dataSection
                aboutSection
            }
            .padding(.horizontal, 38).padding(.top, 40).padding(.bottom, 48)
            .frame(maxWidth: 760, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            if !loaded { nameDraft = progress.learnerName; loaded = true }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Settings").font(.brandDisplay(30, .heavy)).foregroundStyle(Brand.ink)
            Text("Your profile, your goal, and your data. Everything is stored locally on this device.")
                .font(.brandRounded(15, .regular)).foregroundStyle(Brand.muted)
        }
    }

    private var profileSection: some View {
        card(title: "Profile", icon: "person.crop.circle") {
            VStack(alignment: .leading, spacing: 12) {
                Text("Your name appears on the certificates you earn.")
                    .font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted)
                HStack(spacing: 10) {
                    TextField("Your name", text: $nameDraft)
                        .textFieldStyle(.plain)
                        .font(.brandRounded(15, .regular)).foregroundStyle(Brand.ink)
                        .padding(.horizontal, 14).padding(.vertical, 11)
                        .background(Brand.canvas, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
                        .onSubmit { progress.setName(nameDraft) }
                    PrimaryButton("Save", icon: "checkmark") { progress.setName(nameDraft) }
                }
                infoNote("Accounts and single sign-on are part of the hosted tier. On this device your profile and progress are saved locally, with no login.")
            }
        }
    }

    private var learningSection: some View {
        card(title: "Learning", icon: "graduationcap") {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Daily goal").font(.brandRounded(14, .semibold)).foregroundStyle(Brand.ink)
                        Text("Graded items to complete each day.").font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted)
                    }
                    Spacer()
                    HStack(spacing: 8) {
                        stepperButton("minus") { progress.setDailyGoal(progress.dailyGoal - 1) }
                        Text("\(progress.dailyGoal)").font(.brandMono(16, .bold)).foregroundStyle(Brand.ink).frame(width: 28)
                        stepperButton("plus") { progress.setDailyGoal(progress.dailyGoal + 1) }
                    }
                }
                Divider().overlay(Brand.hairline)
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Change your path").font(.brandRounded(14, .semibold)).foregroundStyle(Brand.ink)
                        Text("Pick any of the nine paths on the Learn tab. Progress is tracked separately for each.")
                            .font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted).fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                    Button { app.surface = .learn } label: {
                        HStack(spacing: 5) { Text("Browse paths"); Image(systemName: "arrow.right") }
                            .font(.brandRounded(13, .semibold)).foregroundStyle(Brand.violet)
                            .padding(.horizontal, 12).padding(.vertical, 8).background(Brand.violet.opacity(0.1), in: Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var dataSection: some View {
        card(title: "Data", icon: "tray.full") {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 10) {
                    actionButton("Export transcript (CSV)", "tablecells", Brand.violet) {
                        Exporter.saveText(progress.transcriptCSV(), name: "bidlab-transcript", ext: "csv")
                    }
                    actionButton("Export (JSON)", "curlybraces", Brand.violet) {
                        Exporter.saveText(progress.transcriptJSON(), name: "bidlab-transcript", ext: "json")
                    }
                }
                Divider().overlay(Brand.hairline)
                if confirmReset {
                    HStack(spacing: 10) {
                        Text("Erase all lessons, scores, streak, and certifications?")
                            .font(.brandRounded(13, .medium)).foregroundStyle(Brand.down).fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        Button("Cancel") { confirmReset = false }
                            .buttonStyle(.plain).font(.brandRounded(13, .semibold)).foregroundStyle(Brand.muted)
                        Button { progress.resetProgress(); confirmReset = false } label: {
                            Text("Reset").font(.brandRounded(13, .bold)).foregroundStyle(.white)
                                .padding(.horizontal, 14).padding(.vertical, 8).background(Brand.down, in: Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                } else {
                    actionButton("Reset all progress", "trash", Brand.down) { confirmReset = true }
                }
            }
        }
    }

    private var aboutSection: some View {
        card(title: "About", icon: "info.circle") {
            VStack(alignment: .leading, spacing: 10) {
                aboutRow("Version", "BidLab 1.0")
                aboutRow("Typeface", "Inter, under the SIL Open Font License")
                aboutRow("Credential", "A self-attested completion certificate. The verification code is tamper-evident, not a third-party identity check.")
            }
        }
    }

    // MARK: Pieces

    private func card<Content: View>(title: String, icon: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: icon).font(.system(size: 14, weight: .bold)).foregroundStyle(Brand.violet)
                Text(title).font(.brandRounded(15, .bold)).foregroundStyle(Brand.ink)
            }
            content()
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }

    private func infoNote(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "lock.shield").font(.system(size: 12, weight: .bold)).foregroundStyle(Brand.analytics)
            Text(text).font(.brandRounded(12, .regular)).foregroundStyle(Brand.muted).fixedSize(horizontal: false, vertical: true)
        }
        .padding(12).frame(maxWidth: .infinity, alignment: .leading)
        .background(Brand.analytics.opacity(0.06), in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
    }

    private func stepperButton(_ icon: String, _ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon).font(.system(size: 12, weight: .bold)).foregroundStyle(Brand.violet)
                .frame(width: 26, height: 26).background(Brand.violet.opacity(0.12), in: Circle())
        }
        .buttonStyle(.plain)
    }

    private func actionButton(_ title: String, _ icon: String, _ color: Color, _ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon).font(.system(size: 12, weight: .bold))
                Text(title).font(.brandRounded(13, .semibold))
            }
            .foregroundStyle(color).padding(.horizontal, 14).padding(.vertical, 9)
            .background(color.opacity(0.10), in: Capsule())
        }
        .buttonStyle(.plain)
    }

    private func aboutRow(_ label: String, _ value: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(label).font(.brandRounded(13, .semibold)).foregroundStyle(Brand.ink).frame(width: 90, alignment: .leading)
            Text(value).font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted).fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
    }
}
