import SwiftUI

/// A fixed-size, branded certificate designed to be rendered to a PNG and shared
/// on LinkedIn. Self-contained light theme so it looks right as an image.
struct CertificateShareCard: View {
    let name: String
    let credential: String
    let dateText: String
    var code: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Wordmark(size: 26)
                Spacer()
                Image(systemName: "rosette").font(.system(size: 30, weight: .bold)).foregroundStyle(Brand.violet)
            }
            Spacer()
            Text("CERTIFIED").font(.brandMono(13, .semibold)).foregroundStyle(Brand.violet).tracking(2)
            Text(credential).font(.brandDisplay(34, .heavy)).foregroundStyle(Brand.ink).padding(.top, 2)
            Text("Awarded to \(name)").font(.brandRounded(18, .medium)).foregroundStyle(Brand.muted).padding(.top, 6)
            Spacer()
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(dateText).font(.brandMono(13, .regular)).foregroundStyle(Brand.faint)
                    if !code.isEmpty {
                        Text("Verify  \(code)").font(.brandMono(12, .regular)).foregroundStyle(Brand.faint)
                    }
                }
                Spacer()
                Text("bidlab.app").font(.brandMono(13, .regular)).foregroundStyle(Brand.violet)
            }
        }
        .padding(40)
        .frame(width: 680, height: 380)
        .background(Color(hex: 0xFFFFFF))
        .overlay(alignment: .bottom) {
            Rectangle().fill(Brand.lime).frame(height: 8)
        }
        .overlay(RoundedRectangle(cornerRadius: 0).strokeBorder(Brand.violet.opacity(0.3), lineWidth: 3))
    }
}
