import AppKit
import SwiftUI

// BidLab's original visual identity. Bold and energetic: a high-voltage violet
// brand, a signal-lime spark, distinct per-path accents, on warm paper in light
// mode and near-black in dark. Designed from scratch for BidLab, not derived from
// any existing product. All tokens adapt to light/dark automatically.

extension Color {
    /// Solid color from a 0xRRGGBB literal.
    init(hex: UInt32, opacity: Double = 1) {
        let r = Double((hex >> 16) & 0xFF) / 255
        let g = Double((hex >> 8) & 0xFF) / 255
        let b = Double(hex & 0xFF) / 255
        self.init(.sRGB, red: r, green: g, blue: b, opacity: opacity)
    }

    /// A color that resolves differently in light and dark appearances.
    static func dynamic(_ light: UInt32, _ dark: UInt32) -> Color {
        Color(nsColor: NSColor(name: nil) { appearance in
            let isDark = appearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua
            return NSColor(hex: isDark ? dark : light)
        })
    }
}

extension NSColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let r = CGFloat((hex >> 16) & 0xFF) / 255
        let g = CGFloat((hex >> 8) & 0xFF) / 255
        let b = CGFloat(hex & 0xFF) / 255
        self.init(srgbRed: r, green: g, blue: b, alpha: alpha)
    }
}

/// Brand tokens. Surfaces and text are dynamic; brand and path accents are fixed
/// hues that read well on both backgrounds.
enum Brand {
    // Surfaces
    static let canvas = Color.dynamic(0xF4F3EF, 0x0B0B11)
    static let surface = Color.dynamic(0xFFFFFF, 0x17171F)
    static let surfaceRaised = Color.dynamic(0xFFFFFF, 0x20202C)
    static let console = Color(hex: 0x0E0E15)

    // Text
    static let ink = Color.dynamic(0x0E0E16, 0xF4F4F8)
    static let muted = Color.dynamic(0x66666F, 0x9A9AA6)
    static let faint = Color.dynamic(0x9A9AA2, 0x6A6A77)

    // Brand
    static let violet = Color(hex: 0x5B2BFF)
    static let lime = Color(hex: 0xB6FF3A)

    // Path accents (one per learning path)
    static let dsp = Color(hex: 0x5B2BFF)
    static let sales = Color(hex: 0xFF4D6D)
    static let planning = Color(hex: 0xFF9F1C)
    static let analytics = Color(hex: 0x00B4D8)
    static let engineering = Color(hex: 0x16C784)
    static let foundations = Color(hex: 0x14B8A6)
    static let core = Color(hex: 0xA855F7)
    static let adops = Color(hex: 0x2563EB)

    // Signals
    static let up = Color(hex: 0x18C964)
    static let down = Color(hex: 0xFF3B5C)

    /// Hairline border color (use as-is; already low contrast).
    static var hairline: Color { Color.dynamic(0x000000, 0xFFFFFF).opacity(0.10) }
}

/// Layout metrics.
enum Metric {
    static let radiusSm: CGFloat = 8
    static let radiusMd: CGFloat = 14
    static let radiusLg: CGFloat = 22
    static let sidebarWidth: CGFloat = 232
    static let titleBarInset: CGFloat = 28
}

extension Font {
    /// Maps a weight to the bundled Inter face. Inter v4 ships non-RIBBI weights
    /// as separate families, so faces are referenced by their PostScript name.
    private static func inter(_ size: CGFloat, _ weight: Font.Weight) -> Font {
        let face: String
        switch weight {
        case .black: face = "Inter-Black"
        case .heavy: face = "Inter-ExtraBold"
        case .bold: face = "Inter-Bold"
        case .semibold: face = "Inter-SemiBold"
        case .medium: face = "Inter-Medium"
        default: face = "Inter-Regular"
        }
        return .custom(face, size: size)
    }

    /// Inter, the brand sans (friendly but professional). Heavy weights carry the
    /// wordmark and big headings.
    static func brandDisplay(_ size: CGFloat, _ weight: Font.Weight = .heavy) -> Font {
        inter(size, weight)
    }

    /// Inter for section titles, labels, and body.
    static func brandRounded(_ size: CGFloat, _ weight: Font.Weight = .semibold) -> Font {
        inter(size, weight)
    }

    /// Monospaced face for numbers, metrics, and code (the terminal feel).
    static func brandMono(_ size: CGFloat, _ weight: Font.Weight = .medium) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
    }
}
