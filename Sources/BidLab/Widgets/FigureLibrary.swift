import BidLabCore
import SwiftUI

/// Original vector figures a lesson embeds with `:::figure <name>`: realistic ad
/// creative mockups and diagrams. These are drawn from scratch (no copyrighted
/// artwork) so the course looks like real media without lifting anyone's ads.

private let adBlue = Color(red: 0.20, green: 0.40, blue: 0.95)
private let adOrange = Color(red: 0.98, green: 0.45, blue: 0.12)

/// Renders a named figure inside a captioned card.
struct FigureView: View {
    let name: String
    let caption: String

    var body: some View {
        VStack(spacing: 9) {
            FigureRegistry.view(name: name)
                .frame(maxWidth: .infinity)
                .padding(18)
                .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
            if !caption.isEmpty {
                Text(caption)
                    .font(.brandRounded(12.5, .regular)).foregroundStyle(Brand.muted)
                    .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityText)
    }

    private var accessibilityText: String {
        let base: String
        switch name {
        case "displayAd": base = "A display banner ad mockup"
        case "videoAd": base = "A video pre-roll ad mockup"
        case "nativeAd": base = "A native in-feed ad mockup"
        case "ctvAd": base = "A connected TV ad mockup"
        case "rtbFlow": base = "A diagram of the real-time bidding auction flow"
        case "supplyChain": base = "A diagram of where a dollar of ad spend goes across the supply chain"
        case "funnel": base = "A marketing funnel diagram"
        default: base = "A figure"
        }
        return caption.isEmpty ? base : "\(base). \(caption)"
    }
}

enum FigureRegistry {
    @ViewBuilder
    static func view(name: String) -> some View {
        switch name {
        case "displayAd": DisplayAdFigure()
        case "videoAd": VideoAdFigure()
        case "nativeAd": NativeAdFigure()
        case "ctvAd": CTVAdFigure()
        case "rtbFlow": RTBFlowFigure()
        case "supplyChain": SupplyChainFigure()
        case "funnel": FunnelFigure()
        case "secondPriceAuction": SecondPriceAuctionFigure()
        case "attributionPaths": AttributionPathsFigure()
        case "headerBidding": HeaderBiddingFigure()
        case "audioAd": AudioAdFigure()
        case "pixelFire": PixelFireFigure()
        case "lineItemTree": LineItemTreeFigure()
        case "vastFlow": VASTFlowFigure()
        case "discrepancyWaterfall": DiscrepancyWaterfallFigure()
        case "pacingCurve": PacingCurveFigure()
        default: UnknownFigure(name: name)
        }
    }
}

// MARK: - Ad creative

/// A 300x250 medium rectangle display banner.
struct DisplayAdFigure: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("NIMBUS").font(.system(size: 13, weight: .heavy, design: .rounded)).foregroundStyle(.white)
                Spacer()
                Image(systemName: "info.circle").font(.system(size: 9, weight: .semibold)).foregroundStyle(.white.opacity(0.85))
            }
            .padding(.horizontal, 12).padding(.vertical, 9)
            .background(adBlue)
            VStack(spacing: 8) {
                Image(systemName: "bag.fill").font(.system(size: 26, weight: .semibold)).foregroundStyle(adBlue)
                    .frame(width: 64, height: 64).background(adBlue.opacity(0.12), in: Circle())
                Text("Run further.").font(.system(size: 21, weight: .heavy, design: .rounded)).foregroundStyle(.black)
                Text("New arrivals, 20% off this week.").font(.system(size: 11)).foregroundStyle(.gray)
                Text("Shop now").font(.system(size: 12, weight: .bold)).foregroundStyle(.white)
                    .padding(.horizontal, 18).padding(.vertical, 8).background(adOrange, in: Capsule())
            }
            .padding(14).frame(maxWidth: .infinity).background(Color.white)
        }
        .frame(width: 300, height: 250)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
        .overlay(alignment: .topTrailing) {
            Text("Ad").font(.system(size: 8, weight: .bold)).foregroundStyle(.white)
                .padding(.horizontal, 4).padding(.vertical, 1)
                .background(.black.opacity(0.4), in: RoundedRectangle(cornerRadius: 3)).padding(7)
        }
    }
}

/// A 16:9 video pre-roll player frame.
struct VideoAdFigure: View {
    var body: some View {
        ZStack {
            Rectangle().fill(LinearGradient(colors: [adBlue.opacity(0.9), .black], startPoint: .topLeading, endPoint: .bottomTrailing))
            Image(systemName: "play.circle.fill").font(.system(size: 46)).foregroundStyle(.white.opacity(0.92))
            VStack {
                HStack {
                    Text("Ad · 0:15").font(.system(size: 10, weight: .semibold)).foregroundStyle(.white)
                        .padding(.horizontal, 7).padding(.vertical, 3).background(.black.opacity(0.45), in: Capsule())
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    HStack(spacing: 4) { Text("Skip Ad"); Image(systemName: "forward.fill") }
                        .font(.system(size: 10, weight: .bold)).foregroundStyle(.white)
                        .padding(.horizontal, 10).padding(.vertical, 5).background(.black.opacity(0.5), in: Capsule())
                }
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(.white.opacity(0.3)).frame(height: 3)
                        Capsule().fill(adOrange).frame(width: geo.size.width * 0.4, height: 3)
                    }
                }
                .frame(height: 3)
            }
            .padding(12)
        }
        .aspectRatio(16.0 / 9.0, contentMode: .fit)
        .frame(maxWidth: 340)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

/// An in-feed native ad unit.
struct NativeAdFigure: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            RoundedRectangle(cornerRadius: 8).fill(LinearGradient(colors: [adBlue, adBlue.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                .frame(width: 92, height: 68)
                .overlay(Image(systemName: "photo").font(.system(size: 18)).foregroundStyle(.white.opacity(0.75)))
            VStack(alignment: .leading, spacing: 4) {
                Text("SPONSORED").font(.system(size: 8.5, weight: .bold)).foregroundStyle(.gray).tracking(0.6)
                Text("The quiet way to upgrade your morning routine")
                    .font(.system(size: 13.5, weight: .semibold, design: .rounded)).foregroundStyle(.black).lineLimit(2)
                Text("nimbus.example.com").font(.system(size: 10.5)).foregroundStyle(adBlue)
            }
            Spacer()
        }
        .padding(12).frame(maxWidth: 360)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }
}

/// A connected-TV ad on a stylized television.
struct CTVAdFigure: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle().fill(LinearGradient(colors: [Color(red: 0.10, green: 0.12, blue: 0.30), adBlue], startPoint: .bottomLeading, endPoint: .topTrailing))
                VStack(spacing: 7) {
                    Image(systemName: "airplane").font(.system(size: 30, weight: .semibold)).foregroundStyle(.white)
                    Text("ESCAPE THIS WINTER").font(.system(size: 18, weight: .heavy, design: .rounded)).foregroundStyle(.white)
                    Text("Flights from $199").font(.system(size: 12)).foregroundStyle(.white.opacity(0.85))
                }
                VStack {
                    HStack {
                        Spacer()
                        Text("Ad 1 of 3").font(.system(size: 9, weight: .semibold)).foregroundStyle(.white)
                            .padding(.horizontal, 7).padding(.vertical, 3).background(.black.opacity(0.4), in: Capsule())
                    }
                    Spacer()
                }
                .padding(10)
            }
            .aspectRatio(16.0 / 9.0, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).strokeBorder(.black.opacity(0.65), lineWidth: 4))
            Rectangle().fill(Brand.muted.opacity(0.5)).frame(width: 46, height: 8)
            Capsule().fill(Brand.muted.opacity(0.35)).frame(width: 110, height: 5)
        }
        .frame(maxWidth: 340)
    }
}

// MARK: - Diagrams

/// The real-time bidding flow, left to right.
struct RTBFlowFigure: View {
    private let steps: [(String, String)] = [
        ("person.fill", "User visits"),
        ("doc.text.fill", "Publisher / SSP"),
        ("arrow.triangle.swap", "Ad exchange"),
        ("chart.bar.fill", "DSPs bid"),
        ("checkmark.seal.fill", "Winner serves"),
    ]

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 6) {
                ForEach(steps.indices, id: \.self) { i in
                    node(steps[i].0, steps[i].1)
                    if i < steps.count - 1 {
                        Image(systemName: "chevron.right").font(.system(size: 11, weight: .bold)).foregroundStyle(Brand.faint)
                    }
                }
            }
            Text("The whole auction completes in under 100 milliseconds")
                .font(.brandMono(11, .regular)).foregroundStyle(Brand.muted)
        }
    }

    private func node(_ icon: String, _ label: String) -> some View {
        VStack(spacing: 5) {
            Image(systemName: icon).font(.system(size: 15, weight: .bold)).foregroundStyle(Brand.dsp)
                .frame(width: 42, height: 42).background(Brand.dsp.opacity(0.12), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            Text(label).font(.brandRounded(10, .semibold)).foregroundStyle(Brand.ink)
                .multilineTextAlignment(.center).frame(width: 62)
        }
    }
}

/// Where a dollar of ad spend goes (the ad-tech tax).
struct SupplyChainFigure: View {
    private let segments: [(String, Double, Color)] = [
        ("DSP", 0.15, Brand.dsp),
        ("Exchange", 0.12, Brand.planning),
        ("SSP", 0.18, Brand.sales),
        ("Data + verify", 0.19, Brand.analytics),
        ("Working media", 0.36, Brand.up),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Where $1.00 of ad spend goes").font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.ink)
            GeometryReader { geo in
                HStack(spacing: 2) {
                    ForEach(segments.indices, id: \.self) { i in
                        Rectangle().fill(segments[i].2)
                            .frame(width: max(2, geo.size.width * segments[i].1 - 2))
                            .overlay(Text("\(Int(segments[i].1 * 100))¢").font(.brandMono(10, .bold)).foregroundStyle(.white))
                    }
                }
            }
            .frame(height: 34)
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
            HStack(spacing: 12) {
                ForEach(segments.indices, id: \.self) { i in
                    HStack(spacing: 4) {
                        Circle().fill(segments[i].2).frame(width: 8, height: 8)
                        Text(segments[i].0).font(.brandRounded(10, .medium)).foregroundStyle(Brand.muted)
                    }
                }
            }
            Text("Only about 36 cents reaches the consumer as working media (ANA, 2023).")
                .font(.brandRounded(11, .regular)).foregroundStyle(Brand.muted).fixedSize(horizontal: false, vertical: true)
        }
    }
}

/// The classic marketing funnel with sample volumes.
struct FunnelFigure: View {
    private let tiers: [(String, String, Color, Double)] = [
        ("Awareness", "1,000,000 impressions", Brand.planning, 1.0),
        ("Consideration", "12,000 clicks", Brand.dsp, 0.66),
        ("Conversion", "480 purchases", Brand.up, 0.36),
    ]

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 7) {
                ForEach(tiers.indices, id: \.self) { i in
                    VStack(spacing: 1) {
                        Text(tiers[i].0).font(.brandRounded(13, .bold)).foregroundStyle(.white)
                        Text(tiers[i].1).font(.brandMono(10.5, .regular)).foregroundStyle(.white.opacity(0.9))
                    }
                    .frame(width: geo.size.width * tiers[i].3, height: 50)
                    .background(tiers[i].2, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 178)
    }
}

/// A second-price auction: highest bidder wins but pays the runner-up price.
struct SecondPriceAuctionFigure: View {
    private let bids: [(name: String, bid: Int, win: Bool)] = [("Buyer A", 8, true), ("Buyer B", 6, false), ("Buyer C", 5, false)]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Second-price auction").font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.ink)
            HStack(alignment: .bottom, spacing: 14) {
                ForEach(bids.indices, id: \.self) { i in
                    VStack(spacing: 4) {
                        Text("$\(bids[i].bid)").font(.brandMono(11, .bold)).foregroundStyle(bids[i].win ? Brand.up : Brand.muted)
                        RoundedRectangle(cornerRadius: 5, style: .continuous).fill(bids[i].win ? Brand.dsp : Brand.dsp.opacity(0.3))
                            .frame(width: 44, height: CGFloat(bids[i].bid) * 11)
                        Text(bids[i].name).font(.brandRounded(10, .medium)).foregroundStyle(Brand.muted)
                    }
                }
                VStack(alignment: .leading, spacing: 3) {
                    Text("Buyer A wins").font(.brandRounded(11.5, .bold)).foregroundStyle(Brand.ink)
                    Text("Pays $6, the second price").font(.brandRounded(11, .regular)).foregroundStyle(Brand.up)
                }
                .padding(.leading, 6)
            }
        }
    }
}

/// A multi-touch path to one conversion.
struct AttributionPathsFigure: View {
    private let steps: [(icon: String, label: String)] = [
        ("rectangle.on.rectangle", "Display"), ("magnifyingglass", "Search"), ("envelope.fill", "Email"), ("cart.fill", "Purchase"),
    ]

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 6) {
                ForEach(steps.indices, id: \.self) { i in
                    let last = i == steps.count - 1
                    VStack(spacing: 4) {
                        Image(systemName: steps[i].icon).font(.system(size: 14, weight: .bold)).foregroundStyle(last ? Brand.up : Brand.planning)
                            .frame(width: 38, height: 38).background((last ? Brand.up : Brand.planning).opacity(0.12), in: Circle())
                        Text(steps[i].label).font(.brandRounded(9.5, .semibold)).foregroundStyle(Brand.ink)
                    }
                    if !last {
                        Image(systemName: "arrow.right").font(.system(size: 10, weight: .bold)).foregroundStyle(Brand.faint)
                    }
                }
            }
            Text("One conversion, many touches. Attribution decides which touch gets the credit.")
                .font(.brandMono(10.5, .regular)).foregroundStyle(Brand.muted)
        }
    }
}

/// Header bidding: ask every exchange at once, then send the best bid on.
struct HeaderBiddingFigure: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Publisher page").font(.brandRounded(11, .bold)).foregroundStyle(.white)
                .padding(.horizontal, 14).padding(.vertical, 7).background(Brand.dsp, in: Capsule())
            Image(systemName: "arrow.down").font(.system(size: 11, weight: .bold)).foregroundStyle(Brand.faint)
            HStack(spacing: 10) {
                ForEach(["SSP A", "SSP B", "SSP C"], id: \.self) { name in
                    Text(name).font(.brandRounded(10.5, .semibold)).foregroundStyle(Brand.ink)
                        .padding(.horizontal, 11).padding(.vertical, 7)
                        .background(Brand.planning.opacity(0.14), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
            }
            Text("Header bidding asks every exchange at once, then sends the highest bid to the ad server.")
                .font(.brandMono(10, .regular)).foregroundStyle(Brand.muted)
                .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
        }
    }
}

/// A podcast or streaming-audio sponsor read.
struct AudioAdFigure: View {
    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(LinearGradient(colors: [adBlue, Color(red: 0.5, green: 0.2, blue: 0.9)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 56, height: 56)
                .overlay(Image(systemName: "waveform").font(.system(size: 20, weight: .bold)).foregroundStyle(.white))
            VStack(alignment: .leading, spacing: 5) {
                Text("SPONSORED").font(.system(size: 8.5, weight: .bold)).foregroundStyle(.gray).tracking(0.6)
                Text("This episode is brought to you by Nimbus").font(.system(size: 13, weight: .semibold, design: .rounded)).foregroundStyle(.black)
                HStack(spacing: 6) {
                    Image(systemName: "play.fill").font(.system(size: 10)).foregroundStyle(adBlue)
                    Capsule().fill(.gray.opacity(0.3)).frame(height: 4)
                        .overlay(alignment: .leading) { Capsule().fill(adBlue).frame(width: 44, height: 4) }
                    Text("0:15").font(.system(size: 10)).foregroundStyle(.gray)
                }
            }
        }
        .padding(12).frame(maxWidth: 360)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }
}

/// How a tracking pixel fires: the browser requests a tiny image and the query
/// string and cookie ride along to the server.
struct PixelFireFigure: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                node("safari", "Browser", Brand.dsp)
                Image(systemName: "arrow.right").font(.system(size: 10, weight: .bold)).foregroundStyle(Brand.faint)
                VStack(alignment: .leading, spacing: 2) {
                    Text("GET /p.gif?event=purchase").font(.brandMono(8.5, .semibold)).foregroundStyle(.white)
                    Text("&value=49&id=ab9c").font(.brandMono(8.5, .regular)).foregroundStyle(.white.opacity(0.7))
                    Text("Cookie: uid=ab9c").font(.brandMono(8.5, .regular)).foregroundStyle(Brand.lime)
                }
                .padding(8)
                .background(Brand.console, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                Image(systemName: "arrow.right").font(.system(size: 10, weight: .bold)).foregroundStyle(Brand.faint)
                node("externaldrive.fill", "Tracking server", Brand.planning)
            }
            Text("The browser requests a 1x1 image. The query string and cookie ride along, the server logs them, and it can reply with a cookie of its own.")
                .font(.brandMono(10, .regular)).foregroundStyle(Brand.muted)
                .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
        }
    }

    private func node(_ icon: String, _ label: String, _ color: Color) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon).font(.system(size: 15, weight: .bold)).foregroundStyle(color)
                .frame(width: 42, height: 42).background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            Text(label).font(.brandRounded(10, .semibold)).foregroundStyle(Brand.ink).frame(width: 62).multilineTextAlignment(.center)
        }
    }
}

/// The trafficking hierarchy a campaign is built in: an insertion order holds
/// line items, and each line item holds creatives.
struct LineItemTreeFigure: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            node("Insertion order: Q3 Brand Launch", "doc.text.fill", Brand.adops, indent: 0)
            node("Line item: Prospecting · CPM $6.00", "rectangle.stack.fill", Brand.dsp, indent: 1)
            node("Creative: 300x250 · banner.html", "photo.fill", Brand.muted, indent: 2)
            node("Creative: 728x90 · banner.html", "photo.fill", Brand.muted, indent: 2)
            node("Line item: Retargeting · CPM $9.00", "rectangle.stack.fill", Brand.dsp, indent: 1)
            node("Creative: 300x250 · dynamic tag", "photo.fill", Brand.muted, indent: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func node(_ text: String, _ icon: String, _ color: Color, indent: Int) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon).font(.system(size: 12, weight: .bold)).foregroundStyle(color).frame(width: 18)
            Text(text).font(.brandMono(10.5, .medium)).foregroundStyle(Brand.ink)
            Spacer(minLength: 0)
        }
        .padding(.vertical, 6).padding(.horizontal, 10)
        .background(color.opacity(0.06), in: RoundedRectangle(cornerRadius: 7, style: .continuous))
        .padding(.leading, CGFloat(indent) * 22)
    }
}

/// How a video ad fires its tracking beacons: the player requests a VAST
/// document, then pings a URL at each playback milestone.
struct VASTFlowFigure: View {
    private let beacons = ["impression", "start", "25%", "50%", "75%", "complete"]
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 8) {
                node("play.rectangle.fill", "Player", Brand.adops)
                Image(systemName: "arrow.right").font(.system(size: 10, weight: .bold)).foregroundStyle(Brand.faint)
                node("doc.plaintext.fill", "VAST XML", Brand.planning)
                Image(systemName: "arrow.right").font(.system(size: 10, weight: .bold)).foregroundStyle(Brand.faint)
                node("dot.radiowaves.left.and.right", "Ad server", Brand.engineering)
            }
            HStack(spacing: 5) {
                ForEach(beacons, id: \.self) { b in
                    Text(b).font(.brandMono(9, .semibold)).foregroundStyle(Brand.adops)
                        .padding(.horizontal, 7).padding(.vertical, 4)
                        .background(Brand.adops.opacity(0.10), in: Capsule())
                }
            }
            Text("Each milestone fires its own tracking URL. Completion rate is the complete beacon over the impression beacon.")
                .font(.brandMono(9.5, .regular)).foregroundStyle(Brand.muted)
                .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
        }
    }

    private func node(_ icon: String, _ label: String, _ color: Color) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon).font(.system(size: 14, weight: .bold)).foregroundStyle(color)
                .frame(width: 40, height: 40).background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            Text(label).font(.brandRounded(9.5, .semibold)).foregroundStyle(Brand.ink)
        }
    }
}

/// The same campaign counted at four measurement points. The gaps between them
/// are the discrepancies an ad ops desk reconciles.
struct DiscrepancyWaterfallFigure: View {
    private let steps: [(String, String, Double, Color)] = [
        ("DSP (won)", "1.05M", 1_050_000, Brand.dsp),
        ("Ad server (rendered)", "1.00M", 1_000_000, Brand.adops),
        ("Verified viewable", "0.72M", 720_000, Brand.planning),
        ("Billable (rendered)", "1.00M", 1_000_000, Brand.up),
    ]
    private let maxV = 1_050_000.0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("One campaign, four counts").font(.brandRounded(11.5, .semibold)).foregroundStyle(Brand.ink)
            ForEach(steps.indices, id: \.self) { i in
                HStack(spacing: 10) {
                    Text(steps[i].0).font(.brandMono(10, .medium)).foregroundStyle(Brand.ink).frame(width: 132, alignment: .leading)
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(steps[i].3.opacity(0.15)).frame(height: 16)
                            Capsule().fill(steps[i].3).frame(width: max(6, geo.size.width * steps[i].2 / maxV), height: 16)
                        }
                    }
                    .frame(height: 16)
                    Text(steps[i].1).font(.brandMono(10, .bold)).foregroundStyle(Brand.muted).frame(width: 42, alignment: .trailing)
                }
            }
        }
    }
}

/// Budget delivery across a flight: the even-pace reference line versus actual
/// delivery that fell behind and has to catch up.
struct PacingCurveFigure: View {
    private let even: [Double] = [0, 0.14, 0.28, 0.42, 0.57, 0.71, 0.85, 1.0]
    private let actual: [Double] = [0, 0.10, 0.18, 0.30, 0.40, 0.55, 0.78, 1.0]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Budget delivered across the flight").font(.brandRounded(11.5, .semibold)).foregroundStyle(Brand.ink)
            GeometryReader { geo in
                ZStack {
                    line(even, in: geo.size, color: Brand.faint, dashed: true)
                    line(actual, in: geo.size, color: Brand.adops, dashed: false)
                }
            }
            .frame(height: 120)
            HStack(spacing: 14) {
                legend("Even pace", Brand.faint)
                legend("Actual delivery", Brand.adops)
            }
        }
    }

    private func line(_ pts: [Double], in size: CGSize, color: Color, dashed: Bool) -> some View {
        Path { p in
            for (i, v) in pts.enumerated() {
                let x = size.width * CGFloat(i) / CGFloat(pts.count - 1)
                let y = size.height * (1 - CGFloat(v))
                if i == 0 { p.move(to: CGPoint(x: x, y: y)) } else { p.addLine(to: CGPoint(x: x, y: y)) }
            }
        }
        .stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: dashed ? [4, 4] : []))
    }

    private func legend(_ t: String, _ c: Color) -> some View {
        HStack(spacing: 5) {
            Capsule().fill(c).frame(width: 14, height: 3)
            Text(t).font(.brandMono(9.5, .regular)).foregroundStyle(Brand.muted)
        }
    }
}

/// Fallback for an unbuilt figure name.
private struct UnknownFigure: View {
    let name: String
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "photo.artframe").font(.system(size: 16, weight: .bold)).foregroundStyle(Brand.muted)
            Text("Figure: \(name)").font(.brandRounded(13, .semibold)).foregroundStyle(Brand.ink)
            Spacer()
        }
    }
}
