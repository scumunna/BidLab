import Foundation
import SwiftUI

/// Renders a LaTeX-ish formula natively. It prettifies common commands to
/// Unicode, typesets `_{...}` / `^{...}` as real sub/superscripts via
/// AttributedString baseline offsets, and renders `\frac{a}{b}` as a true
/// stacked fraction. This keeps formulas crisp and native without a LaTeX
/// dependency.
struct MathView: View {
    let latex: String
    var color: Color = Brand.ink
    var size: CGFloat = 17

    private enum Atom {
        case text(String)
        case frac(String, String)
    }

    var body: some View {
        let atoms = MathView.parse(MathView.prettify(latex))
        HStack(alignment: .center, spacing: 1) {
            ForEach(atoms.indices, id: \.self) { i in
                switch atoms[i] {
                case let .text(s):
                    Text(MathView.attributed(s, baseSize: size)).foregroundStyle(color)
                case let .frac(numerator, denominator):
                    VStack(spacing: 2) {
                        Text(MathView.attributed(numerator, baseSize: size * 0.82)).foregroundStyle(color)
                        Rectangle().fill(color).frame(height: 1)
                        Text(MathView.attributed(denominator, baseSize: size * 0.82)).foregroundStyle(color)
                    }
                    .fixedSize()
                    .padding(.horizontal, 3)
                }
            }
        }
        .textSelection(.enabled)
    }

    /// Private-use sentinel standing in for an escaped underscore (`\_`) so the
    /// sub/superscript pass does not treat it as a subscript marker. Prose
    /// rendering restores it too, so it is visible to siblings in this module.
    static let literalUnderscore = "\u{E000}"

    // MARK: Symbol prettifying

    static func prettify(_ s: String) -> String {
        var t = s
        // Strip \text{...} wrappers, keeping the inner words. The native renderer
        // has no LaTeX text mode, so without this the braces would render literally.
        if let rx = try? NSRegularExpression(pattern: #"\\text\s*\{([^{}]*)\}"#) {
            t = rx.stringByReplacingMatches(in: t, range: NSRange(t.startIndex..., in: t), withTemplate: "$1")
        }
        // Render \bar{x} as x with a combining macron, and \sqrt{...} as √(...).
        // Both keep the radicand readable without a true overline glyph.
        if let rx = try? NSRegularExpression(pattern: #"\\bar\s*\{([^{}]*)\}"#) {
            t = rx.stringByReplacingMatches(in: t, range: NSRange(t.startIndex..., in: t), withTemplate: "$1\u{0304}")
        }
        if let rx = try? NSRegularExpression(pattern: #"\\sqrt\s*\{([^{}]*)\}"#) {
            t = rx.stringByReplacingMatches(in: t, range: NSRange(t.startIndex..., in: t), withTemplate: "√($1)")
        }
        let map: [String: String] = [
            "\\pi": "π", "\\mu": "μ", "\\sigma": "σ", "\\lambda": "λ", "\\alpha": "α",
            "\\beta": "β", "\\theta": "θ", "\\rho": "ρ", "\\gamma": "γ", "\\delta": "δ",
            "\\epsilon": "ε", "\\phi": "φ", "\\omega": "ω", "\\tau": "τ", "\\eta": "η",
            "\\Sigma": "Σ", "\\Delta": "Δ", "\\Omega": "Ω", "\\times": "×", "\\cdot": "·",
            "\\cdots": "⋯", "\\ldots": "…", "\\dots": "…", "\\div": "÷", "\\leq": "≤",
            "\\le": "≤", "\\geq": "≥", "\\ge": "≥", "\\approx": "≈", "\\neq": "≠",
            "\\propto": "∝", "\\infty": "∞", "\\sum": "Σ", "\\prod": "∏", "\\int": "∫",
            "\\partial": "∂", "\\nabla": "∇", "\\in": "∈", "\\notin": "∉", "\\cup": "∪",
            "\\cap": "∩", "\\to": "→", "\\pm": "±", "\\mp": "∓", "\\sqrt": "√",
            "\\Pr": "Pr", "\\left": "", "\\right": "", "\\,": " ", "\\;": " ",
            "\\!": "", "\\quad": "  ", "\\text": "", "\\bowtie": "⋈", "\\ ": " ",
            // LaTeX literal escapes: render the character, not the backslash.
            "\\%": "%", "\\&": "&", "\\#": "#", "\\$": "$",
            // Escaped underscore is a literal "_", not a subscript trigger. Route
            // it through a private-use sentinel so the sub/superscript pass leaves
            // it alone, then restore it as a literal underscore when typesetting.
            "\\_": Self.literalUnderscore,
            // Operators and relations that would otherwise leak as raw commands.
            "\\mid": "|", "\\qquad": "    ", "\\log": "log", "\\ln": "ln",
            "\\min": "min", "\\max": "max", "\\big": "", "\\Big": "",
            "\\iff": "⟺", "\\Leftrightarrow": "⟺", "\\tfrac": "\\frac",
        ]
        for (k, v) in map { t = t.replacingOccurrences(of: k, with: v) }
        return t
    }

    // MARK: Fraction parsing

    private static func parse(_ s: String) -> [Atom] {
        let chars = Array(s)
        var atoms: [Atom] = []
        var buffer = ""
        var i = 0
        while i < chars.count {
            if matchesFrac(chars, i) {
                if !buffer.isEmpty { atoms.append(.text(buffer)); buffer = "" }
                i += 5 // consume \frac
                let (numerator, after1) = readGroup(chars, i)
                let (denominator, after2) = readGroup(chars, after1)
                atoms.append(.frac(numerator, denominator))
                i = after2
            } else {
                buffer.append(chars[i])
                i += 1
            }
        }
        if !buffer.isEmpty { atoms.append(.text(buffer)) }
        return atoms
    }

    private static func matchesFrac(_ c: [Character], _ i: Int) -> Bool {
        i + 4 < c.count && c[i] == "\\" && c[i + 1] == "f" && c[i + 2] == "r" && c[i + 3] == "a" && c[i + 4] == "c"
    }

    private static func readGroup(_ c: [Character], _ start: Int) -> (String, Int) {
        var i = start
        while i < c.count, c[i] == " " { i += 1 }
        guard i < c.count, c[i] == "{" else {
            if i < c.count { return (String(c[i]), i + 1) }
            return ("", i)
        }
        i += 1
        var depth = 1
        var out = ""
        while i < c.count, depth > 0 {
            if c[i] == "{" {
                depth += 1; out.append(c[i])
            } else if c[i] == "}" {
                depth -= 1
                if depth > 0 { out.append(c[i]) }
            } else {
                out.append(c[i])
            }
            i += 1
        }
        return (out, i)
    }

    // MARK: Sub/superscript typesetting

    static func attributed(_ latex: String, baseSize: CGFloat) -> AttributedString {
        let chars = Array(latex)
        var result = AttributedString("")
        var i = 0

        func append(_ str: String, offset: CGFloat, scale: CGFloat) {
            guard !str.isEmpty else { return }
            var run = AttributedString(str)
            run.font = .system(size: baseSize * scale, design: .serif)
            if offset != 0 { run.baselineOffset = offset }
            result += run
        }

        while i < chars.count {
            let c = chars[i]
            if String(c) == MathView.literalUnderscore {
                append("_", offset: 0, scale: 1.0)
                i += 1
            } else if c == "_" || c == "^" {
                let isSub = c == "_"
                i += 1
                var group = ""
                if i < chars.count, chars[i] == "{" {
                    i += 1
                    while i < chars.count, chars[i] != "}" { group.append(chars[i]); i += 1 }
                    if i < chars.count { i += 1 }
                } else if i < chars.count {
                    group.append(chars[i]); i += 1
                }
                append(group, offset: isSub ? -baseSize * 0.20 : baseSize * 0.34, scale: 0.7)
            } else {
                append(String(c), offset: 0, scale: 1.0)
                i += 1
            }
        }
        return result
    }
}
