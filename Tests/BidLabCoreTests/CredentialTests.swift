import BidLabCore

/// Tests for the free, self-verifying credential.
func credentialTests(_ h: Harness) {
    let c = Credential(recipientName: "Ada Lovelace", track: "dsp", role: "DSP / Trader", year: 2026, month: 6, day: 14)

    // Verification code is deterministic and well-formed.
    h.check("code deterministic", c.verificationCode == c.verificationCode)
    h.check("code prefix", c.verificationCode.hasPrefix("BL-"))
    h.check("code length", c.verificationCode.count == 12)

    // Changing any signed field changes the code (tamper-evident).
    let other = Credential(recipientName: "Someone Else", track: "dsp", role: "DSP / Trader", year: 2026, month: 6, day: 14)
    h.check("different recipient, different code", c.verificationCode != other.verificationCode)
    let otherTrack = Credential(recipientName: "Ada Lovelace", track: "sales", role: "Sales", year: 2026, month: 6, day: 14)
    h.check("different track, different code", c.verificationCode != otherTrack.verificationCode)
    let otherDate = Credential(recipientName: "Ada Lovelace", track: "dsp", role: "DSP / Trader", year: 2026, month: 6, day: 15)
    h.check("different date, different code", c.verificationCode != otherDate.verificationCode)

    h.check("title", c.title == "DSP / Trader Certified")
    h.check("iso date", c.issueDateISO == "2026-06-14")
    h.check("slug carries track", c.idSlug.hasPrefix("dsp-"))

    // LinkedIn add link.
    let li = c.linkedInAddURL(certURL: "https://example.com/verify.html")
    h.check("linkedin host", li.contains("linkedin.com/profile/add"))
    h.check("linkedin org", li.contains("organizationName=BidLab"))
    h.check("linkedin certId", li.contains("certId=BL-"))

    // Open Badges JSON, with a clean single-slash base URL.
    let assertion = c.assertionJSON(baseURL: "https://x.github.io/bidlab-credentials/")
    h.check("assertion type", assertion.contains("\"type\": \"Assertion\""))
    h.check("assertion carries the code", assertion.contains(c.verificationCode))
    h.check("assertion badge url", assertion.contains("https://x.github.io/bidlab-credentials/badges/dsp.json"))
    let badge = c.badgeClassJSON(baseURL: "https://x.github.io/bidlab-credentials")
    h.check("badge name", badge.contains("DSP / Trader Certified"))
    let issuer = Credential.issuerJSON(baseURL: "https://x.github.io/bidlab-credentials")
    h.check("issuer name", issuer.contains("\"name\": \"BidLab\""))
}
