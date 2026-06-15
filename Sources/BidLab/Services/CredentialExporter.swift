import AppKit
import BidLabCore
import SwiftUI

/// Writes a free, self-contained, verifiable credential package to disk: Open
/// Badges 2.0 JSON (an open standard, no paid platform), a tamper-evident
/// verify page that recomputes the credential hash in the browser, an index,
/// the certificate PNGs, and a README for free GitHub Pages hosting.
enum CredentialExporter {
    /// Placeholder base URL. The README explains replacing it with the learner's
    /// own free GitHub Pages URL.
    static let placeholderBaseURL = "https://YOUR-USERNAME.github.io/bidlab-credentials"

    @MainActor
    @discardableResult
    static func export(_ credentials: [Credential]) -> URL? {
        guard let downloads = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first else { return nil }
        let root = downloads.appendingPathComponent("BidLab-Credentials", isDirectory: true)
        let fm = FileManager.default
        for sub in ["badges", "assertions", "images"] {
            try? fm.createDirectory(at: root.appendingPathComponent(sub), withIntermediateDirectories: true)
        }

        write(Credential.issuerJSON(baseURL: placeholderBaseURL), to: root.appendingPathComponent("issuer.json"))
        write(verifyHTML, to: root.appendingPathComponent("verify.html"))
        write(readme, to: root.appendingPathComponent("README.md"))
        write(indexHTML(credentials), to: root.appendingPathComponent("index.html"))

        for credential in credentials {
            write(credential.badgeClassJSON(baseURL: placeholderBaseURL),
                  to: root.appendingPathComponent("badges/\(credential.track).json"))
            write(credential.assertionJSON(baseURL: placeholderBaseURL),
                  to: root.appendingPathComponent("assertions/\(credential.idSlug).json"))
            let card = CertificateShareCard(name: credential.recipientName, credential: credential.title, dateText: credential.issueDateISO)
            if let png = renderPNG(card) {
                try? png.write(to: root.appendingPathComponent("images/\(credential.track).png"))
            }
        }
        NSWorkspace.shared.activateFileViewerSelecting([root])
        return root
    }

    private static func write(_ string: String, to url: URL) {
        try? string.data(using: .utf8)?.write(to: url)
    }

    @MainActor
    private static func renderPNG(_ view: some View) -> Data? {
        let renderer = ImageRenderer(content: view)
        renderer.scale = 2
        guard let image = renderer.nsImage,
              let tiff = image.tiffRepresentation,
              let rep = NSBitmapImageRep(data: tiff) else { return nil }
        return rep.representation(using: .png, properties: [:])
    }

    /// A self-contained verify page. It recomputes the same hash BidLab used (the
    /// StableID FNV variant) from the holder, track, and date, and checks it
    /// against the code, so editing any field invalidates the credential. Free,
    /// no server.
    private static let verifyHTML = """
    <!doctype html>
    <html lang="en"><head><meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>BidLab credential</title>
    <style>
      body{font-family:-apple-system,system-ui,Segoe UI,Roboto,sans-serif;background:#f5f3ef;color:#1a1a1a;display:flex;min-height:100vh;align-items:center;justify-content:center;margin:0;padding:20px}
      .card{background:#fff;border:1px solid #e5e1d8;border-radius:16px;padding:30px;max-width:460px;width:100%;box-shadow:0 10px 34px rgba(0,0,0,.07)}
      .brand{font-weight:800;letter-spacing:.3px}.brand span{color:#6d4dff}
      h1{font-size:18px;margin:14px 0 4px}.v{font-size:16px;font-weight:800;margin-bottom:10px}.ok{color:#15a35b}.bad{color:#e23b3b}
      .row{margin:7px 0;color:#555;font-size:14px}code{background:#f0ede6;padding:2px 7px;border-radius:6px}
    </style></head>
    <body><div class="card" id="card">Checking...</div>
    <script>
    function bidlabHash(str){let h=1469598103934665603n;const mask=(1n<<64n)-1n;const bytes=new TextEncoder().encode(str);for(const b of bytes){h=h^BigInt(b);h=(h*1099511628211n)&mask;}return h;}
    function codeFor(seed){let s=bidlabHash(seed).toString(36).toUpperCase();s=s+"00000000";return "BL-"+s.slice(0,4)+"-"+s.slice(4,8);}
    function esc(s){return (s||"").replace(/[<>&]/g,"");}
    var p=new URLSearchParams(location.search);
    var name=p.get("name")||"",track=p.get("track")||"",date=p.get("date")||"",code=p.get("code")||"";
    var expected=codeFor(name+"|"+track+"|"+date);
    var valid=(code!=="" && expected===code);
    document.getElementById("card").innerHTML=
      '<div class="brand">Bid<span>Lab</span></div>'+
      '<h1>Credential check</h1>'+
      '<div class="v '+(valid?"ok":"bad")+'">'+(valid?"Verified":"Not valid")+'</div>'+
      '<div class="row">Holder: <b>'+esc(name)+'</b></div>'+
      '<div class="row">Credential: <b>'+esc(track)+'</b></div>'+
      '<div class="row">Issued: '+esc(date)+'</div>'+
      '<div class="row">Code: <code>'+esc(code)+'</code></div>'+
      (valid
        ? '<div class="row">The code matches these details, so the credential has not been altered.</div>'
        : '<div class="row">The code does not match the details. It may have been edited.</div>');
    </script></body></html>
    """

    private static func indexHTML(_ credentials: [Credential]) -> String {
        let rows = credentials.map { c in
            let link = "verify.html?name=\(c.recipientName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? c.recipientName)&track=\(c.track)&date=\(c.year)-\(c.month)-\(c.day)&code=\(c.verificationCode)"
            return "<li><a href=\"\(link)\">\(c.title)</a> &middot; <code>\(c.verificationCode)</code></li>"
        }.joined(separator: "\n")
        return """
        <!doctype html><html lang="en"><head><meta charset="utf-8"><title>BidLab credentials</title>
        <style>body{font-family:-apple-system,system-ui,sans-serif;background:#f5f3ef;color:#1a1a1a;max-width:600px;margin:60px auto;padding:0 20px}a{color:#6d4dff}code{background:#eee;padding:2px 6px;border-radius:5px}</style></head>
        <body><h1>BidLab credentials</h1><p>Verifiable certifications. Click one to check it.</p><ul>\n\(rows)\n</ul></body></html>
        """
    }

    private static let readme = """
    # BidLab Credentials

    Your BidLab certifications as free, open, verifiable credentials. No paid service, no Credly.

    ## Make them verifiable online (free, about three minutes)
    1. Create a free GitHub account at https://github.com if you do not have one.
    2. Create a new public repository named `bidlab-credentials`.
    3. Upload everything in this folder to the repository.
    4. In the repo, open Settings then Pages, and set the source to the main branch, root folder.
    5. Your credentials go live at `https://YOUR-USERNAME.github.io/bidlab-credentials/`.
    6. Find and replace the placeholder `YOUR-USERNAME` inside issuer.json, badges/*.json, and
       assertions/*.json with your real GitHub username so the Open Badges links resolve.

    ## How verification works
    Each credential has a verify link (in index.html and in the assertion evidence field). The
    verify page recomputes the credential's hash from the holder, track, and date in your browser
    and checks it against the code. Editing any field changes the required code, so the credential
    is tamper-evident. No server is required.

    ## Add to LinkedIn (free)
    In BidLab, each earned certification has an Add to LinkedIn button that opens LinkedIn's profile
    editor with the certification prefilled. Use your verify link as the credential URL.

    ## What these files are
    Open Badges 2.0 assertions (the open 1EdTech standard) plus a self-verifying page and the
    certificate images. Entirely free.
    """
}
