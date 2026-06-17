import BidLabCore
import SwiftUI

/// Industry-specific vector figures embedded with `:::figure <name>` from the
/// vertical deep-dive lessons. Same house style as `FigureLibrary.swift`: original
/// diagrams drawn from scratch in the Brand palette, never copyrighted artwork.
/// Each maps the operational shape a programmatic trader has to reason about in
/// that vertical (the cascade, the funnel, the heatmap, the holdout).

// MARK: - Shared building blocks

/// A small left-to-right pipeline node used by several industry diagrams.
private struct FlowNode: View {
    let icon: String
    let label: String
    let color: Color
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon).font(.system(size: 14, weight: .bold)).foregroundStyle(color)
                .frame(width: 42, height: 42).background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            Text(label).font(.brandRounded(9.5, .semibold)).foregroundStyle(Brand.ink)
                .multilineTextAlignment(.center).frame(width: 66)
        }
    }
}

private func flowArrow() -> some View {
    Image(systemName: "arrow.right").font(.system(size: 10, weight: .bold)).foregroundStyle(Brand.faint)
}

/// A polyline plotted in a unit box, top-left origin flipped so larger is higher.
private struct UnitLine: View {
    let points: [Double]          // y values in 0...1, evenly spaced on x
    let color: Color
    var dashed: Bool = false
    var fill: Bool = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if fill { area(in: geo.size) }
                path(in: geo.size).stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: dashed ? [4, 4] : []))
            }
        }
    }
    private func x(_ i: Int, _ w: CGFloat) -> CGFloat { points.count <= 1 ? 0 : w * CGFloat(i) / CGFloat(points.count - 1) }
    private func y(_ v: Double, _ h: CGFloat) -> CGFloat { h * (1 - CGFloat(v)) }
    private func path(in size: CGSize) -> Path {
        Path { p in
            for (i, v) in points.enumerated() {
                let pt = CGPoint(x: x(i, size.width), y: y(v, size.height))
                if i == 0 { p.move(to: pt) } else { p.addLine(to: pt) }
            }
        }
    }
    private func area(in size: CGSize) -> some View {
        Path { p in
            p.move(to: CGPoint(x: 0, y: size.height))
            for (i, v) in points.enumerated() { p.addLine(to: CGPoint(x: x(i, size.width), y: y(v, size.height))) }
            p.addLine(to: CGPoint(x: size.width, y: size.height))
            p.closeSubpath()
        }
        .fill(color.opacity(0.14))
    }
}

private func figureLegend(_ items: [(String, Color)]) -> some View {
    HStack(spacing: 12) {
        ForEach(items.indices, id: \.self) { i in
            HStack(spacing: 5) {
                Capsule().fill(items[i].1).frame(width: 14, height: 3)
                Text(items[i].0).font(.brandMono(9.5, .regular)).foregroundStyle(Brand.muted)
            }
        }
    }
}

/// A captioned footnote line, matching the diagram figures' explanatory text.
private func figureNote(_ text: String) -> some View {
    Text(text).font(.brandMono(10, .regular)).foregroundStyle(Brand.muted)
        .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
}

// MARK: - Retail media

/// On-site versus off-site retail media: the brand funds the RMN, which buys both
/// the retailer's own shelf (search, PLAs) and the open web, and the retailer's
/// loyalty data closes the loop back to sales.
struct RetailMediaFlowFigure: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                FlowNode(icon: "cart.fill", label: "Brand budget", color: Brand.sales)
                flowArrow()
                FlowNode(icon: "building.2.fill", label: "Retail media network", color: Brand.planning)
            }
            HStack(spacing: 28) {
                branch(title: "On-site", lines: ["Sponsored products", "PLAs on retailer.com"], color: Brand.up)
                branch(title: "Off-site", lines: ["DSP open web", "CTV + social"], color: Brand.dsp)
            }
            HStack(spacing: 6) {
                Image(systemName: "arrow.uturn.left").font(.system(size: 10, weight: .bold)).foregroundStyle(Brand.analytics)
                Text("Loyalty purchase data closes the loop: iROAS, not just clicks")
                    .font(.brandMono(9.5, .regular)).foregroundStyle(Brand.analytics)
            }
        }
    }
    private func branch(title: String, lines: [String], color: Color) -> some View {
        VStack(spacing: 5) {
            Text(title).font(.brandRounded(11, .bold)).foregroundStyle(.white)
                .padding(.horizontal, 12).padding(.vertical, 5).background(color, in: Capsule())
            ForEach(lines, id: \.self) { l in
                Text(l).font(.brandMono(9.5, .regular)).foregroundStyle(Brand.ink)
                    .padding(.horizontal, 9).padding(.vertical, 4)
                    .background(color.opacity(0.10), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
            }
        }
    }
}

/// A clean room match: the advertiser's first-party list and the retailer or
/// publisher's first-party list are matched on hashed keys inside a neutral room,
/// and only aggregated overlap leaves. No raw identifiers cross.
struct CleanRoomMatchFigure: View {
    var body: some View {
        VStack(spacing: 11) {
            HStack(spacing: -18) {
                dataDisc("Advertiser 1P", Brand.dsp)
                dataDisc("Retailer 1P", Brand.up)
            }
            Image(systemName: "lock.shield.fill").font(.system(size: 16, weight: .bold)).foregroundStyle(Brand.analytics)
            Text("Data clean room").font(.brandRounded(11, .bold)).foregroundStyle(Brand.ink)
                .padding(.horizontal, 12).padding(.vertical, 5)
                .background(Brand.analytics.opacity(0.12), in: Capsule())
            figureNote("Hashed keys match inside the room. Only aggregated overlap and lift leave. No raw PII crosses either way.")
        }
    }
    private func dataDisc(_ label: String, _ color: Color) -> some View {
        Circle().fill(color.opacity(0.18)).frame(width: 92, height: 92)
            .overlay(Circle().strokeBorder(color, lineWidth: 1.5))
            .overlay(Text(label).font(.brandMono(9.5, .semibold)).foregroundStyle(color).multilineTextAlignment(.center).frame(width: 70))
    }
}

// MARK: - Finance

/// The cost-per-funded cascade: each step keeps a fraction, so the cost of the
/// final funded account is the media cost divided by the product of every rate.
struct CostPerFundedCascadeFigure: View {
    private let steps: [(String, String, Double)] = [
        ("Impressions", "1,000,000", 1.0),
        ("Clicks", "4,000 (0.4%)", 0.62),
        ("Applications", "320 (8%)", 0.40),
        ("Approved", "144 (45%)", 0.26),
        ("Funded", "101 (70%)", 0.16),
    ]
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 6) {
                ForEach(steps.indices, id: \.self) { i in
                    VStack(spacing: 1) {
                        Text(steps[i].0).font(.brandRounded(11.5, .bold)).foregroundStyle(.white)
                        Text(steps[i].1).font(.brandMono(9.5, .regular)).foregroundStyle(.white.opacity(0.9))
                    }
                    .frame(width: max(70, geo.size.width * steps[i].2), height: 38)
                    .background(color(i), in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 226)
    }
    private func color(_ i: Int) -> Color {
        [Brand.planning, Brand.dsp, Brand.adops, Brand.sales, Brand.up][min(i, 4)]
    }
}

// MARK: - Travel

/// The look-to-book funnel: huge search volume narrows through property views and
/// carts to a small number of bookings, and the look-to-book ratio is the lever.
struct LookToBookFunnelFigure: View {
    private let tiers: [(String, String, Color, Double)] = [
        ("Searches", "240,000", Brand.planning, 1.0),
        ("Property views", "58,000", Brand.dsp, 0.6),
        ("Add to cart", "9,400", Brand.adops, 0.38),
        ("Bookings", "1,880", Brand.up, 0.22),
    ]
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 7) {
                ForEach(tiers.indices, id: \.self) { i in
                    VStack(spacing: 1) {
                        Text(tiers[i].0).font(.brandRounded(12.5, .bold)).foregroundStyle(.white)
                        Text(tiers[i].1).font(.brandMono(10, .regular)).foregroundStyle(.white.opacity(0.9))
                    }
                    .frame(width: geo.size.width * tiers[i].3, height: 46)
                    .background(tiers[i].2, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                Text("Look-to-book ≈ 0.8%. Small ratio moves swing the whole flight.")
                    .font(.brandMono(9.5, .regular)).foregroundStyle(Brand.muted)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 226)
    }
}

/// Counterintuitive travel seasonality: booking demand leads the travel dates it
/// serves by months, so the desk spends against intent, not the trip calendar.
struct SeasonalityCurveFigure: View {
    private let booking: [Double] = [0.30, 0.55, 0.82, 0.95, 0.78, 0.50, 0.35, 0.40, 0.55, 0.62, 0.70, 0.58]
    private let travel:  [Double] = [0.10, 0.18, 0.30, 0.48, 0.70, 0.88, 0.96, 0.90, 0.65, 0.42, 0.30, 0.45]
    private let months = ["J","F","M","A","M","J","J","A","S","O","N","D"]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Booking demand leads travel dates").font(.brandRounded(11.5, .semibold)).foregroundStyle(Brand.ink)
            ZStack {
                UnitLine(points: booking, color: Brand.dsp)
                UnitLine(points: travel, color: Brand.up, dashed: true)
            }
            .frame(height: 116)
            HStack(spacing: 0) {
                ForEach(months.indices, id: \.self) { i in
                    Text(months[i]).font(.brandMono(8.5, .regular)).foregroundStyle(Brand.faint).frame(maxWidth: .infinity)
                }
            }
            figureLegend([("Bookings made", Brand.dsp), ("Travel dates", Brand.up)])
        }
    }
}

// MARK: - Healthcare / pharma

/// NPI-level HCP targeting: a list of physician NPIs is matched to devices, so the
/// trader reaches named specialists rather than a broad consumer audience.
struct NPITargetingFigure: View {
    private let docs: [(String, String)] = [
        ("1043217650", "Cardiology"),
        ("1982744031", "Endocrinology"),
        ("1356098427", "Oncology"),
    ]
    var body: some View {
        VStack(spacing: 11) {
            VStack(spacing: 5) {
                ForEach(docs.indices, id: \.self) { i in
                    HStack(spacing: 8) {
                        Image(systemName: "stethoscope").font(.system(size: 12, weight: .bold)).foregroundStyle(Brand.adops).frame(width: 18)
                        Text("NPI \(docs[i].0)").font(.brandMono(10.5, .semibold)).foregroundStyle(Brand.ink)
                        Spacer(minLength: 8)
                        Text(docs[i].1).font(.brandMono(9.5, .regular)).foregroundStyle(Brand.muted)
                    }
                    .padding(.vertical, 6).padding(.horizontal, 10)
                    .background(Brand.adops.opacity(0.07), in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                }
            }
            HStack(spacing: 8) {
                FlowNode(icon: "list.bullet.rectangle", label: "NPI list", color: Brand.adops)
                flowArrow()
                FlowNode(icon: "rectangle.2.swap", label: "Device match", color: Brand.planning)
                flowArrow()
                FlowNode(icon: "iphone", label: "Reach HCP", color: Brand.up)
            }
            figureNote("Targets named specialists by NPI. Privacy lives at the list, not the household.")
        }
    }
}

/// Script lift: the exposed group writes more prescriptions than a matched control,
/// and the gap, not the raw exposed rate, is the proof of incremental effect.
struct ScriptLiftFigure: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("New scripts per 1,000 HCPs").font(.brandRounded(11.5, .semibold)).foregroundStyle(Brand.ink)
            HStack(alignment: .bottom, spacing: 22) {
                bar("Control", 38, Brand.muted, "38")
                bar("Exposed", 47, Brand.up, "47")
                VStack(alignment: .leading, spacing: 3) {
                    Text("Lift +24%").font(.brandRounded(12, .bold)).foregroundStyle(Brand.up)
                    Text("9 incremental scripts").font(.brandMono(9.5, .regular)).foregroundStyle(Brand.muted)
                    Text("p < 0.05").font(.brandMono(9.5, .regular)).foregroundStyle(Brand.muted)
                }
            }
        }
    }
    private func bar(_ label: String, _ value: Int, _ color: Color, _ tag: String) -> some View {
        VStack(spacing: 4) {
            Text(tag).font(.brandMono(10, .bold)).foregroundStyle(color)
            RoundedRectangle(cornerRadius: 5, style: .continuous).fill(color).frame(width: 46, height: CGFloat(value) * 2.0)
            Text(label).font(.brandRounded(10, .medium)).foregroundStyle(Brand.muted)
        }
    }
}

/// Fair balance: a pharma creative must give Important Safety Information visual
/// weight comparable to the benefit claim, so the ISI block is part of the layout.
struct ISILayoutFigure: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 7) {
                Text("CARDIVA").font(.system(size: 17, weight: .heavy, design: .rounded)).foregroundStyle(Brand.dsp)
                Text("Lower LDL in adults with high cholesterol").font(.system(size: 11.5, weight: .semibold)).foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                Text("Ask your doctor if CARDIVA is right for you").font(.system(size: 9.5)).foregroundStyle(.gray)
            }
            .padding(12).frame(maxWidth: .infinity).background(Color.white)
            Rectangle().fill(Brand.hairline).frame(height: 1)
            VStack(alignment: .leading, spacing: 4) {
                Text("IMPORTANT SAFETY INFORMATION").font(.system(size: 8.5, weight: .bold)).foregroundStyle(.gray).tracking(0.5)
                ForEach(0..<4, id: \.self) { _ in
                    Capsule().fill(.gray.opacity(0.32)).frame(height: 4).frame(maxWidth: .infinity)
                }
                Capsule().fill(.gray.opacity(0.32)).frame(width: 120, height: 4)
            }
            .padding(12).frame(maxWidth: .infinity).background(Color(white: 0.97))
        }
        .frame(maxWidth: 300)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
        .overlay(alignment: .topTrailing) {
            Text("Ad").font(.system(size: 8, weight: .bold)).foregroundStyle(.white)
                .padding(.horizontal, 4).padding(.vertical, 1)
                .background(.black.opacity(0.4), in: RoundedRectangle(cornerRadius: 3)).padding(7)
        }
    }
}

// MARK: - Telecom and subscription

/// The churn-shaped retention curve: subscribers decay each month, and the area
/// under the curve, scaled by ARPU, is the lifetime value the CAC must respect.
struct ChurnLtvCurveFigure: View {
    private let retention: [Double] = [1.0, 0.93, 0.87, 0.81, 0.76, 0.71, 0.66, 0.62, 0.58, 0.54, 0.51, 0.47]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Subscribers retained by month").font(.brandRounded(11.5, .semibold)).foregroundStyle(Brand.ink)
            ZStack {
                UnitLine(points: retention, color: Brand.dsp, fill: true)
            }
            .frame(height: 116)
            HStack {
                Text("Month 0").font(.brandMono(8.5, .regular)).foregroundStyle(Brand.faint)
                Spacer()
                Text("Month 12").font(.brandMono(8.5, .regular)).foregroundStyle(Brand.faint)
            }
            figureNote("LTV = ARPU × gross margin ÷ monthly churn. The shaded area is the value CAC has to stay under.")
        }
    }
}

/// Subscription LTV accumulating: monthly margin adds up while churn thins the
/// base, so cumulative value rises fast then flattens, and CAC payback is where it
/// crosses the acquisition cost line.
struct SubscriptionLtvFigure: View {
    private let cumulative: [Double] = [0.12, 0.23, 0.33, 0.42, 0.50, 0.57, 0.63, 0.69, 0.74, 0.78, 0.82, 0.85]
    private let cacLine = 0.42
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Cumulative gross profit per subscriber").font(.brandRounded(11.5, .semibold)).foregroundStyle(Brand.ink)
            ZStack {
                UnitLine(points: Array(repeating: cacLine, count: 12), color: Brand.down, dashed: true)
                UnitLine(points: cumulative, color: Brand.up, fill: true)
            }
            .frame(height: 116)
            figureLegend([("Cumulative profit", Brand.up), ("CAC (payback at ~month 4)", Brand.down)])
        }
    }
}

// MARK: - Auto

/// The three-tier auto market: national OEM brand budgets, regional dealer
/// associations, and the local dealer, with co-op dollars flowing down the tiers.
struct DealerTiersFigure: View {
    private let tiers: [(String, String, Color, Double)] = [
        ("Tier 1 · OEM (national)", "Brand + model launches", Brand.dsp, 1.0),
        ("Tier 2 · Regional association", "Co-op, multi-dealer DMAs", Brand.planning, 0.74),
        ("Tier 3 · Local dealer", "VDP views, leads, foot traffic", Brand.up, 0.5),
    ]
    var body: some View {
        VStack(spacing: 8) {
            ForEach(tiers.indices, id: \.self) { i in
                HStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 1) {
                        Text(tiers[i].0).font(.brandRounded(11, .bold)).foregroundStyle(.white)
                        Text(tiers[i].1).font(.brandMono(9, .regular)).foregroundStyle(.white.opacity(0.88))
                    }
                    .padding(.horizontal, 12).frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 44).background(tiers[i].2, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                .frame(width: nil)
                .padding(.horizontal, CGFloat(i) * 18)
                if i < tiers.count - 1 {
                    Image(systemName: "arrow.down").font(.system(size: 11, weight: .bold)).foregroundStyle(Brand.faint)
                }
            }
            figureNote("Co-op dollars flow down the tiers. Each tier reimburses against its own compliant creative.")
        }
    }
}

// MARK: - CPG

/// Trade versus media: the bulk of a CPG dollar still goes to retailer trade and
/// shopper programs, and the media line the trader runs is the smaller slice that
/// has to prove incremental.
struct TradeVsMediaFigure: View {
    private let segments: [(String, Double, Color)] = [
        ("Trade promotion", 0.55, Brand.planning),
        ("Shopper / retail media", 0.27, Brand.up),
        ("Brand media", 0.18, Brand.dsp),
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Where the CPG commercial dollar goes").font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.ink)
            GeometryReader { geo in
                HStack(spacing: 2) {
                    ForEach(segments.indices, id: \.self) { i in
                        Rectangle().fill(segments[i].2)
                            .frame(width: max(2, geo.size.width * segments[i].1 - 2))
                            .overlay(Text("\(Int(segments[i].1 * 100))%").font(.brandMono(10, .bold)).foregroundStyle(.white))
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
            figureNote("Media is the slice the trader controls. It has to earn its share against trade on mROI.")
        }
    }
}

/// A marketing-mix decomposition: total sales split into the base that would have
/// happened anyway plus the incremental contribution of each channel.
struct MMMDecompositionFigure: View {
    private let parts: [(String, Double, Color)] = [
        ("Base (no media)", 0.58, Brand.faint),
        ("Retail media", 0.16, Brand.up),
        ("CTV", 0.11, Brand.dsp),
        ("Social", 0.09, Brand.planning),
        ("Search", 0.06, Brand.adops),
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Sales decomposition (MMM)").font(.brandRounded(12.5, .semibold)).foregroundStyle(Brand.ink)
            GeometryReader { geo in
                VStack(spacing: 2) {
                    ForEach(parts.indices, id: \.self) { i in
                        HStack(spacing: 8) {
                            Text(parts[i].0).font(.brandMono(9.5, .medium)).foregroundStyle(Brand.ink).frame(width: 104, alignment: .leading)
                            Rectangle().fill(parts[i].2)
                                .frame(width: max(8, (geo.size.width - 150) * parts[i].1 * (parts[i].0.hasPrefix("Base") ? 1 : 2.4)))
                                .frame(height: 16).clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                            Text("\(Int(parts[i].1 * 100))%").font(.brandMono(9.5, .bold)).foregroundStyle(Brand.muted)
                        }
                    }
                }
            }
            .frame(height: 108)
            figureNote("Only the channel bars are incremental. The base is what sells with no media at all.")
        }
    }
}

// MARK: - B2B / SaaS

/// The ABM pipeline: a finite set of target accounts narrows through engagement to
/// closed-won, where a tiny count of large deals carries the economics.
struct ABMPipelineFigure: View {
    private let stages: [(String, String, Color, Double)] = [
        ("Target accounts", "500", Brand.planning, 1.0),
        ("Engaged", "180", Brand.dsp, 0.74),
        ("MQL", "70", Brand.adops, 0.56),
        ("SQL / opportunity", "28", Brand.sales, 0.40),
        ("Closed-won", "7 · $1.4M", Brand.up, 0.26),
    ]
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 6) {
                ForEach(stages.indices, id: \.self) { i in
                    HStack(spacing: 8) {
                        Text(stages[i].0).font(.brandMono(10, .semibold)).foregroundStyle(.white)
                        Spacer(minLength: 6)
                        Text(stages[i].1).font(.brandMono(10, .bold)).foregroundStyle(.white)
                    }
                    .padding(.horizontal, 12)
                    .frame(width: max(120, geo.size.width * stages[i].3), height: 36)
                    .background(stages[i].2, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 218)
    }
}

// MARK: - Measurement (cross-vertical)

/// A geo holdout: matched markets are split into test (ads on) and control (ads
/// off), and the outcome gap between them is the incremental lift.
struct GeoHoldoutFigure: View {
    // 0 = control (off), 1 = test (on)
    private let grid: [[Int]] = [
        [1, 0, 1, 1, 0],
        [0, 1, 1, 0, 1],
        [1, 1, 0, 1, 0],
    ]
    var body: some View {
        VStack(spacing: 11) {
            VStack(spacing: 5) {
                ForEach(grid.indices, id: \.self) { r in
                    HStack(spacing: 5) {
                        ForEach(grid[r].indices, id: \.self) { c in
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(grid[r][c] == 1 ? Brand.dsp : Brand.muted.opacity(0.22))
                                .frame(width: 38, height: 26)
                                .overlay(Image(systemName: grid[r][c] == 1 ? "wifi" : "wifi.slash")
                                    .font(.system(size: 9, weight: .bold))
                                    .foregroundStyle(grid[r][c] == 1 ? .white : Brand.muted))
                        }
                    }
                }
            }
            figureLegend([("Test DMAs (ads on)", Brand.dsp), ("Control DMAs (ads off)", Brand.muted.opacity(0.5))])
            figureNote("Markets are matched, then split. Lift is the test-minus-control gap, free of attribution guesswork.")
        }
    }
}

// MARK: - QSR

/// A dayparting heatmap: bid intensity by hour block and day, hot at lunch and
/// dinner and hotter into the weekend, the way a footfall-driven desk paces.
struct DaypartingHeatmapFigure: View {
    private let rows = ["Morning", "Lunch", "Afternoon", "Dinner", "Late"]
    private let cols = ["M", "T", "W", "T", "F", "S", "S"]
    // intensity 0...1 per [daypart][day]
    private let heat: [[Double]] = [
        [0.30, 0.30, 0.32, 0.34, 0.40, 0.55, 0.52],
        [0.78, 0.78, 0.80, 0.82, 0.90, 0.95, 0.92],
        [0.25, 0.25, 0.26, 0.28, 0.34, 0.48, 0.46],
        [0.70, 0.72, 0.74, 0.80, 0.95, 0.98, 0.90],
        [0.20, 0.20, 0.22, 0.26, 0.45, 0.60, 0.42],
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Bid intensity by daypart").font(.brandRounded(11.5, .semibold)).foregroundStyle(Brand.ink)
            HStack(alignment: .top, spacing: 6) {
                VStack(alignment: .trailing, spacing: 4) {
                    Text("").font(.brandMono(8, .regular)).frame(height: 12)
                    ForEach(rows.indices, id: \.self) { r in
                        Text(rows[r]).font(.brandMono(8.5, .medium)).foregroundStyle(Brand.muted).frame(height: 22)
                    }
                }
                VStack(spacing: 4) {
                    HStack(spacing: 4) {
                        ForEach(cols.indices, id: \.self) { c in
                            Text(cols[c]).font(.brandMono(8.5, .regular)).foregroundStyle(Brand.faint).frame(width: 26, height: 12)
                        }
                    }
                    ForEach(heat.indices, id: \.self) { r in
                        HStack(spacing: 4) {
                            ForEach(heat[r].indices, id: \.self) { c in
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(Brand.up.opacity(0.15 + 0.85 * heat[r][c]))
                                    .frame(width: 26, height: 22)
                            }
                        }
                    }
                }
            }
            figureNote("Lunch and dinner carry the budget, and Friday through Sunday run hottest.")
        }
    }
}
