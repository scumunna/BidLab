import SwiftUI

/// Shared building blocks for the lesson widgets, so each one stays small and
/// consistent: a titled card shell, a stat line, a labeled slider, and number
/// formatting.

struct WidgetShell<Content: View>: View {
    let title: String
    let icon: String
    var accent: Color
    var note: String?
    let content: Content

    init(_ title: String, icon: String, accent: Color = Brand.violet, note: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.accent = accent
        self.note = note
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: icon).font(.system(size: 13, weight: .bold)).foregroundStyle(accent)
                Text(title).font(.brandRounded(13, .semibold)).foregroundStyle(Brand.ink)
                Spacer()
                if let note { Text(note).font(.brandMono(11, .regular)).foregroundStyle(Brand.muted) }
            }
            content
        }
        .padding(16)
        .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }
}

struct StatLine: View {
    let label: String
    let value: String
    var color: Color = Brand.ink

    var body: some View {
        HStack {
            Text(label).font(.brandRounded(12, .regular)).foregroundStyle(Brand.muted)
            Spacer()
            Text(value).font(.brandMono(13, .bold)).foregroundStyle(color)
        }
    }
}

/// How a numeric value is displayed and parsed, so a slider's value can be typed
/// (bring-your-own-numbers).
enum NumberKind {
    case money(Int)
    case pct(Int)
    case millions
    case number(Int)

    func format(_ x: Double) -> String {
        switch self {
        case .money(let d): return Fmt.money(x, d)
        case .pct(let d): return Fmt.pct(x, d)
        case .millions: return Fmt.millions(x)
        case .number(let d): return Fmt.num(x, d)
        }
    }

    /// Plain text for the edit field (no symbols, in display units).
    func editText(_ x: Double) -> String {
        switch self {
        case .money(let d): return String(format: "%.\(d)f", x)
        case .pct(let d): return String(format: "%.\(d)f", x * 100)
        case .millions: return String(format: "%.2f", x / 1_000_000)
        case .number(let d): return String(format: "%.\(d)f", x)
        }
    }

    func parse(_ s: String) -> Double? {
        let cleaned = s
            .replacingOccurrences(of: "$", with: "")
            .replacingOccurrences(of: "%", with: "")
            .replacingOccurrences(of: "M", with: "")
            .replacingOccurrences(of: ",", with: "")
            .trimmingCharacters(in: .whitespaces)
        guard let raw = Double(cleaned) else { return nil }
        switch self {
        case .money, .number: return raw
        case .pct: return raw / 100
        case .millions: return raw * 1_000_000
        }
    }
}

/// A labeled slider whose value can also be typed when a `kind` is given (so a
/// learner can drop in their own numbers, not just drag within a range). Without
/// a `kind` it shows the static `value` string, preserving existing call sites.
struct LabeledSlider: View {
    let label: String
    var value: String = ""
    @Binding var binding: Double
    let range: ClosedRange<Double>
    var accent: Color = Brand.violet
    var kind: NumberKind? = nil

    @Local private var editing = false
    @Local private var draft = ""
    @FocusState private var fieldFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(label).font(.brandRounded(12, .regular)).foregroundStyle(Brand.muted)
                Spacer()
                if let kind { editableValue(kind) } else {
                    Text(value).font(.brandMono(12, .bold)).foregroundStyle(Brand.ink)
                }
            }
            Slider(value: $binding, in: range).tint(accent)
                .accessibilityLabel(label)
                .accessibilityValue(kind?.format(binding) ?? value)
        }
    }

    @ViewBuilder
    private func editableValue(_ kind: NumberKind) -> some View {
        if editing {
            TextField("", text: $draft)
                .textFieldStyle(.plain)
                .font(.brandMono(12, .bold))
                .foregroundStyle(accent)
                .frame(width: 70)
                .multilineTextAlignment(.trailing)
                .focused($fieldFocused)
                .onAppear { fieldFocused = true }
                .onSubmit { commit(kind) }
                .onChange(of: fieldFocused) { _, focused in
                    if !focused && editing { commit(kind) }
                }
        } else {
            Button {
                draft = kind.editText(binding)
                editing = true
            } label: {
                HStack(spacing: 3) {
                    Text(kind.format(binding)).font(.brandMono(12, .bold)).foregroundStyle(Brand.ink)
                    Image(systemName: "pencil").font(.system(size: 8)).foregroundStyle(Brand.faint)
                }
            }
            .buttonStyle(.plain)
            .accessibilityLabel("\(label), \(kind.format(binding)), tap to edit")
        }
    }

    private func commit(_ kind: NumberKind) {
        if let v = kind.parse(draft) {
            binding = min(max(v, range.lowerBound), range.upperBound)
        }
        editing = false
    }
}

/// A guided empty state: never a dead page. An icon, a headline, a line, and one
/// primary action that routes the user somewhere useful.
struct GuidedEmptyState: View {
    let icon: String
    let title: String
    let message: String
    var accent: Color = Brand.violet
    var ctaTitle: String? = nil
    var ctaIcon: String = "arrow.right"
    var action: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: icon).font(.system(size: 20, weight: .bold)).foregroundStyle(accent)
                    .frame(width: 46, height: 46)
                    .background(accent.opacity(0.12), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                VStack(alignment: .leading, spacing: 3) {
                    Text(title).font(.brandRounded(15.5, .bold)).foregroundStyle(Brand.ink)
                    Text(message).font(.brandRounded(13, .regular)).foregroundStyle(Brand.muted)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer(minLength: 0)
            }
            if let ctaTitle, let action {
                Button(action: action) {
                    HStack(spacing: 6) {
                        Image(systemName: ctaIcon).font(.system(size: 12, weight: .bold))
                        Text(ctaTitle).font(.brandRounded(13.5, .semibold))
                    }
                    .foregroundStyle(.white).padding(.horizontal, 16).padding(.vertical, 9)
                    .background(accent, in: Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(accent.opacity(0.05), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(accent.opacity(0.2), lineWidth: 1))
    }
}

enum Fmt {
    static func money(_ x: Double, _ d: Int = 2) -> String { String(format: "$%.\(d)f", x) }
    static func pct(_ x: Double, _ d: Int = 1) -> String { String(format: "%.\(d)f%%", x * 100) }
    static func num(_ x: Double, _ d: Int = 2) -> String { String(format: "%.\(d)f", x) }
    static func int(_ x: Int) -> String { x.formatted() }
    static func millions(_ x: Double) -> String { String(format: "%.2fM", x / 1_000_000) }
}
