import Foundation

/// A free, standards-aligned credential a learner earns by passing a track exam.
///
/// Nothing here costs money. It produces a stable verification code (a hash of
/// the recipient, track, and date, so changing any of them invalidates it), an
/// Open Badges 2.0 assertion (an open standard, no paid platform like Credly),
/// and a LinkedIn add-to-profile link. The companion verify.html recomputes the
/// same hash in the browser, so the credential is tamper-evident and verifiable
/// online when the generated files are dropped on any free static host such as
/// GitHub Pages.
public struct Credential: Equatable {
    public let recipientName: String
    public let track: String
    public let role: String
    public let year: Int
    public let month: Int
    public let day: Int

    public init(recipientName: String, track: String, role: String, year: Int, month: Int, day: Int) {
        self.recipientName = recipientName
        self.track = track
        self.role = role
        self.year = year
        self.month = month
        self.day = day
    }

    /// The exact string that is hashed. The verify page rebuilds this identically.
    public var seed: String { "\(recipientName)|\(track)|\(year)-\(month)-\(day)" }

    /// A deterministic, human-readable verification code, stable per recipient,
    /// track, and date. Same hash function as StableID, replicated in verify.html.
    public var verificationCode: String {
        let raw = String(StableID.hash(seed), radix: 36).uppercased()
        let padded = raw + String(repeating: "0", count: max(0, 8 - raw.count))
        let a = padded.prefix(4)
        let b = padded.dropFirst(4).prefix(4)
        return "BL-\(a)-\(b)"
    }

    public var title: String { "\(role) Certified" }

    public var idSlug: String {
        track + "-" + verificationCode.replacingOccurrences(of: "BL-", with: "").replacingOccurrences(of: "-", with: "").lowercased()
    }

    public var issueDateISO: String { String(format: "%04d-%02d-%02d", year, month, day) }

    /// A LinkedIn add-to-profile deep link. Free, opens the profile editor with
    /// the certification prefilled.
    public func linkedInAddURL(certURL: String) -> String {
        var components = URLComponents(string: "https://www.linkedin.com/profile/add")!
        components.queryItems = [
            URLQueryItem(name: "startTask", value: "CERTIFICATION_NAME"),
            URLQueryItem(name: "name", value: title),
            URLQueryItem(name: "organizationName", value: "BidLab"),
            URLQueryItem(name: "issueYear", value: String(year)),
            URLQueryItem(name: "issueMonth", value: String(month)),
            URLQueryItem(name: "certId", value: verificationCode),
            URLQueryItem(name: "certUrl", value: certURL),
        ]
        return components.url?.absoluteString ?? "https://www.linkedin.com/profile/add"
    }

    private func trimmed(_ baseURL: String) -> String {
        baseURL.hasSuffix("/") ? String(baseURL.dropLast()) : baseURL
    }

    /// Open Badges 2.0 assertion JSON (hosted-verification model).
    public func assertionJSON(baseURL: String) -> String {
        let base = trimmed(baseURL)
        return """
        {
          "@context": "https://w3id.org/openbadges/v2",
          "type": "Assertion",
          "id": "\(base)/assertions/\(idSlug).json",
          "recipient": { "type": "id", "hashed": false, "identity": "\(verificationCode)" },
          "badge": "\(base)/badges/\(track).json",
          "verification": { "type": "HostedBadge" },
          "issuedOn": "\(issueDateISO)T00:00:00Z",
          "evidence": "\(base)/verify.html?name=\(encoded(recipientName))&track=\(track)&date=\(year)-\(month)-\(day)&code=\(verificationCode)"
        }
        """
    }

    public func badgeClassJSON(baseURL: String) -> String {
        let base = trimmed(baseURL)
        return """
        {
          "@context": "https://w3id.org/openbadges/v2",
          "type": "BadgeClass",
          "id": "\(base)/badges/\(track).json",
          "name": "\(title)",
          "description": "Awarded for passing the BidLab \(role) certification exam, a math-true assessment of programmatic advertising skill.",
          "image": "\(base)/images/\(track).png",
          "criteria": { "narrative": "Pass the BidLab \(role) exam at 70 percent or higher across all assessed domains." },
          "issuer": "\(base)/issuer.json"
        }
        """
    }

    public static func issuerJSON(baseURL: String) -> String {
        let base = baseURL.hasSuffix("/") ? String(baseURL.dropLast()) : baseURL
        return """
        {
          "@context": "https://w3id.org/openbadges/v2",
          "type": "Issuer",
          "id": "\(base)/issuer.json",
          "name": "BidLab",
          "url": "\(base)/",
          "description": "BidLab is a math-true training simulator and certification for programmatic advertising."
        }
        """
    }

    private func encoded(_ s: String) -> String {
        s.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? s
    }
}
