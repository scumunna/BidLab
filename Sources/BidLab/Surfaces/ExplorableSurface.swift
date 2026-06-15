import SwiftUI

/// The Explorables library: a set of signature, standalone interactive
/// explainers, each built to be share-worthy on its own, separate from the
/// course. The library is the home; tapping one opens a full reader with a live
/// model embedded. This is an ecosystem of explorables, not a single page.
struct ExplorableSurface: View {
    @Local private var openID: String?

    private let library: [ExplorableMeta] = [
        ExplorableMeta(id: "first-price", title: "Why the whole industry shades its bids",
                       dek: "The shift from second-price to first-price auctions, and the one piece of math every trader now lives by.",
                       icon: "chart.line.uptrend.xyaxis", accent: Brand.violet, minutes: 2),
        ExplorableMeta(id: "frequency", title: "The point where frequency stops working",
                       dek: "Every extra impression on the same person buys less. Find where reach turns into waste.",
                       icon: "target", accent: Brand.planning, minutes: 3),
        ExplorableMeta(id: "margin", title: "Where a dollar of ad spend actually goes",
                       dek: "Between the advertiser and the publisher sits a stack of fees. See how much of each dollar survives the trip.",
                       icon: "chart.pie", accent: Brand.sales, minutes: 2),
        ExplorableMeta(id: "power", title: "Why a clean test needs more conversions than you think",
                       dek: "Lift is easy to claim and hard to prove. See how many conversions it takes to trust the result.",
                       icon: "function", accent: Brand.analytics, minutes: 3),
        ExplorableMeta(id: "latency", title: "The auction you lose in 100 milliseconds",
                       dek: "A bid that arrives late is a bid that never happened. See how timeouts quietly eat your win rate.",
                       icon: "timer", accent: Brand.engineering, minutes: 2),
        ExplorableMeta(id: "budget", title: "Where the budget actually goes",
                       dek: "A campaign is many line items competing for one pool of money. See how allocation decides who wins.",
                       icon: "square.grid.3x1.below.line.grid.1x2", accent: Brand.dsp, minutes: 3),
    ]

    var body: some View {
        ScrollView {
            if let openID, let meta = library.first(where: { $0.id == openID }) {
                readerView(meta)
            } else {
                libraryView
            }
        }
    }

    // MARK: Library

    private var libraryView: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 10) {
                Pill(text: "Explorables", color: Brand.violet)
                Text("Six ideas in programmatic, each one you can play with")
                    .font(.brandDisplay(32, .heavy)).foregroundStyle(Brand.ink)
                    .fixedSize(horizontal: false, vertical: true)
                Text("Short, self-contained interactives on the forces that move this market. No course required. Pick one, drag the sliders, and feel why it matters.")
                    .font(.brandRounded(16, .regular)).foregroundStyle(Brand.muted).lineSpacing(3)
                    .frame(maxWidth: 720, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 300, maximum: 420), spacing: 16)], spacing: 16) {
                ForEach(library) { meta in libraryCard(meta) }
            }
        }
        .padding(.horizontal, 40).padding(.top, 36).padding(.bottom, 56)
        .frame(maxWidth: 980, alignment: .leading)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func libraryCard(_ meta: ExplorableMeta) -> some View {
        Button { withAnimation(.spring(response: 0.32, dampingFraction: 0.84)) { openID = meta.id } } label: {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: meta.icon).font(.system(size: 18, weight: .bold)).foregroundStyle(meta.accent)
                        .frame(width: 44, height: 44)
                        .background(meta.accent.opacity(0.13), in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
                    Spacer()
                    Text("\(meta.minutes) min").font(.brandMono(11, .semibold)).foregroundStyle(Brand.faint)
                }
                Text(meta.title).font(.brandDisplay(18, .bold)).foregroundStyle(Brand.ink)
                    .fixedSize(horizontal: false, vertical: true)
                Text(meta.dek).font(.brandRounded(13.5, .regular)).foregroundStyle(Brand.muted).lineSpacing(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer(minLength: 2)
                HStack(spacing: 5) {
                    Text("Explore").font(.brandRounded(13, .semibold))
                    Image(systemName: "arrow.right").font(.system(size: 12, weight: .bold))
                }
                .foregroundStyle(meta.accent)
            }
            .padding(18)
            .frame(maxWidth: .infinity, minHeight: 210, alignment: .topLeading)
            .background(Brand.surface, in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
        }
        .buttonStyle(PressableStyle())
        .accessibilityLabel("\(meta.title). \(meta.minutes) minute interactive.")
        .accessibilityHint(meta.dek)
    }

    // MARK: Reader

    private func readerView(_ meta: ExplorableMeta) -> some View {
        VStack(alignment: .leading, spacing: 26) {
            Button { withAnimation(.spring(response: 0.32, dampingFraction: 0.84)) { openID = nil } } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left").font(.system(size: 12, weight: .bold))
                    Text("All explorables").font(.brandRounded(13, .semibold))
                }
                .foregroundStyle(Brand.muted)
            }
            .buttonStyle(.plain)
            hero(meta)
            explorableBody(meta.id)
        }
        .padding(.horizontal, 40).padding(.top, 32).padding(.bottom, 60)
        .frame(maxWidth: 800, alignment: .leading)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func hero(_ meta: ExplorableMeta) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 9) {
                Image(systemName: meta.icon).font(.system(size: 15, weight: .bold)).foregroundStyle(meta.accent)
                Pill(text: "\(meta.minutes) min explorable", color: meta.accent)
            }
            Text(meta.title)
                .font(.brandDisplay(32, .heavy)).foregroundStyle(Brand.ink)
                .fixedSize(horizontal: false, vertical: true)
            Text(meta.dek)
                .font(.brandRounded(16, .regular)).foregroundStyle(Brand.muted).lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(meta.accent.opacity(0.06), in: RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusLg, style: .continuous).strokeBorder(meta.accent.opacity(0.2), lineWidth: 1))
    }

    @ViewBuilder
    private func explorableBody(_ id: String) -> some View {
        switch id {
        case "first-price": firstPrice
        case "frequency": frequency
        case "margin": margin
        case "power": power
        case "latency": latency
        default: budget
        }
    }

    // MARK: Explorable bodies

    @ViewBuilder private var firstPrice: some View {
        paragraph("For years, programmatic ran on second-price auctions. You bid your true value, the highest bidder won, and the winner paid only the second-highest price. Honesty was optimal, so traders could bid what an impression was worth and stop thinking about it.")
        heading("Then header bidding changed the rules")
        paragraph("As publishers adopted header bidding and competing exchanges, the clean second-price logic broke down. Exchanges moved to first-price auctions, where the winner pays exactly what they bid. Overnight, bidding your true value meant paying away all of your margin.")
        heading("So everyone started shading")
        paragraph("In a first-price auction your expected profit is the chance you win times the surplus you keep. Bid high and you win often but earn little per win. Bid low and you keep more per win but win less often. Somewhere between sits the bid that maximizes the product. Drag it and find the peak.")
        AuctionPlayground(params: ["marketMean": "0.5", "value": "1.0"])
        callout("E[\\pi] = P_{win}(b)\\,(v - b)",
                "The optimal shade is not a guess. It is the bid that maximizes win probability times surplus.", Brand.violet)
        heading("Why this is worth billions")
        paragraph("Multiply one optimal shade across the trillions of impressions transacted each year, and small differences in how well a buyer estimates value and shades its bid become enormous differences in profit. The math on this one slider is the math that moves the market.")
    }

    @ViewBuilder private var frequency: some View {
        paragraph("A campaign does not reach people, it reaches impressions. The same person can see your ad once or fifty times, and the difference between those two is the difference between a memorable brand and an annoying one.")
        heading("The first few exposures do the work")
        paragraph("Early impressions build recognition and nudge intent. After that, each additional impression on the same person moves the needle less, while still costing you the same money. Economists call it diminishing returns. Buyers call it frequency waste.")
        heading("Spread reach, cap waste")
        paragraph("The job is to spread a fixed budget across enough unique people to matter, without piling so many impressions on each one that you are paying to annoy them. Slide the frequency cap and watch unique reach trade against total impressions.")
        ReachFrequencyPlayground(params: [:])
        callout("\\text{Reach} = \\frac{\\text{Impressions}}{\\text{Average frequency}}",
                "For a fixed impression pool, every point of extra frequency is a point of reach you gave up.", Brand.planning)
    }

    @ViewBuilder private var margin: some View {
        paragraph("When an advertiser spends a dollar, the publisher does not receive a dollar. In between sit the DSP, the exchange, sometimes a reseller, data fees, and verification. Each takes a cut. What lands on the page is what is left.")
        heading("The same audience, very different cost")
        paragraph("This stack is why identical audiences can cost wildly different amounts depending on the path the money takes. Two plans with the same working budget can deliver very different amounts of real advertising, because one routes through more middlemen than the other.")
        heading("Cutting the chain shorter")
        paragraph("Supply path optimization is the unglamorous art of removing hops between the buyer and the inventory. Move the take rates below and watch how much of the advertiser's dollar actually reaches a real impression.")
        MarginModeler(params: [:])
        callout("\\text{Working media} = \\text{Spend} \\times (1 - \\sum \\text{take rates})",
                "Every layer that touches the dollar takes a slice. Fewer layers means more of the budget becomes advertising.", Brand.sales)
    }

    @ViewBuilder private var power: some View {
        paragraph("Run an experiment, see a 5 percent lift, ship it. The problem is that with too few conversions, a real 5 percent lift and pure noise look identical. The smaller the effect you want to detect, the more data it takes to tell it apart from chance.")
        heading("Power is the chance you catch a real effect")
        paragraph("Statistical power is the probability that your test actually detects an effect when one truly exists. Low power is how teams ship changes that quietly do nothing, and kill changes that quietly worked.")
        heading("Three dials set the cost")
        paragraph("The sample size you need depends on the effect you care about, the baseline conversion rate, and how confident you want to be. Drag them and watch the required conversions move, often by a lot.")
        PowerExplorer(params: [:])
        callout("n \\propto \\frac{1}{\\Delta^2}",
                "Detectable effects cost quadratically. Halve the effect you want to catch, and you roughly quadruple the data you need.", Brand.analytics)
    }

    @ViewBuilder private var latency: some View {
        paragraph("Every programmatic auction runs on a stopwatch. The exchange sends a bid request, and your bidder has a fixed window, often around 100 milliseconds, to respond. Answer late and your bid is discarded before anyone reads the price.")
        heading("Engineering becomes media buying")
        paragraph("A slow model, a distant server, or a congested network does not just feel sluggish. It silently lowers how many auctions you even get to compete in. The fastest bidder with a worse price can beat a smarter bidder that shows up late.")
        heading("Speed is inventory")
        paragraph("Move the timeout and your processing time below, and watch the share of auctions you actually enter. In this market, latency is not a back-office concern. It decides how much you get to buy.")
        LatencySimulator(params: [:])
        callout("\\text{Auctions entered} = P(\\,t_{response} < t_{timeout}\\,)",
                "Anything slower than the exchange timeout is lost before bidding even starts.", Brand.engineering)
    }

    @ViewBuilder private var budget: some View {
        paragraph("A media plan is rarely one buy. It is a dozen line items, each with its own audience, price, and performance, all drawing from the same budget. How you split that money between them often matters more than any single bid.")
        heading("Saturation versus starvation")
        paragraph("Pour too much into a cheap line item and you saturate its small audience. Starve a strong performer and you leave results on the table. The right split sends each marginal dollar wherever it earns the most, until the good options run dry.")
        heading("The daily job of pacing")
        paragraph("Drag the allocations below and watch total delivery respond. This is what pacing really is: keeping every dollar working where it pays best, all day, as the auction conditions shift under you.")
        BudgetAllocatorWidget(params: [:])
        callout("\\text{max} \\sum_i f_i(b_i) \\quad \\text{s.t.} \\sum_i b_i = B",
                "The best allocation equalizes the marginal return across line items. Spend flows to the next-best dollar until budgets bind.", Brand.dsp)
    }

    // MARK: Pieces

    private func heading(_ text: String) -> some View {
        Text(text).font(.brandRounded(21, .bold)).foregroundStyle(Brand.ink).padding(.top, 6)
    }

    private func paragraph(_ text: String) -> some View {
        Text(text).font(.brandRounded(16, .regular)).foregroundStyle(Brand.ink).lineSpacing(5)
            .fixedSize(horizontal: false, vertical: true)
    }

    private func callout(_ latex: String, _ text: String, _ accent: Color) -> some View {
        HStack(alignment: .top, spacing: 11) {
            Image(systemName: "lightbulb.fill").font(.system(size: 15, weight: .bold)).foregroundStyle(accent)
            VStack(alignment: .leading, spacing: 8) {
                MathView(latex: latex, color: Brand.ink, size: 18)
                Text(text).font(.brandRounded(14, .medium)).foregroundStyle(Brand.ink)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(accent.opacity(0.07), in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous).strokeBorder(accent.opacity(0.22), lineWidth: 1))
    }
}

private struct ExplorableMeta: Identifiable {
    let id: String
    let title: String
    let dek: String
    let icon: String
    let accent: Color
    let minutes: Int
}
