/// The module map for each path. Titles come from the approved curriculum. Each
/// module's lesson id follows the `{track}-{NN}` convention, so a module becomes
/// launchable the moment its `Lessons/{track}-{NN}.md` file ships.
struct ModuleInfo: Identifiable {
    let number: Int
    let title: String
    let lessonID: String
    var id: Int { number }
}

enum Curriculum {
    static func modules(for trackID: String) -> [ModuleInfo] {
        titles(for: trackID).enumerated().map { index, title in
            let number = index + 1
            return ModuleInfo(
                number: number,
                title: title,
                lessonID: "\(trackID)-\(String(format: "%02d", number))"
            )
        }
    }

    /// True when an authored lesson exists for this id.
    static func isAvailable(_ lessonID: String) -> Bool {
        LessonLibrary.lesson(id: lessonID) != nil
    }

    /// The next available lesson in the same track after a given module, for the
    /// continue-to-next-lesson flow.
    static func nextLessonID(track: String, afterModule module: Int) -> String? {
        modules(for: track)
            .first { $0.number > module && isAvailable($0.lessonID) }?
            .lessonID
    }

    private static func titles(for trackID: String) -> [String] {
        switch trackID {
        case "foundations": return foundations
        case "core": return core
        case "adops": return adops
        case "dsp": return dsp
        case "sales": return sales
        case "planning": return planning
        case "analytics": return analytics
        case "engineering": return engineering
        case "ai": return ai
        case "vertical-retail": return verticalRetail
        case "vertical-cpg": return verticalCpg
        case "vertical-ecommerce": return verticalEcommerce
        case "vertical-dtc": return verticalDtc
        case "vertical-auto": return verticalAuto
        case "vertical-finance": return verticalFinance
        case "vertical-travel": return verticalTravel
        case "vertical-telecom": return verticalTelecom
        case "vertical-healthcare": return verticalHealthcare
        case "vertical-qsr": return verticalQsr
        case "vertical-b2b": return verticalB2b
        default: return []
        }
    }

    private static let foundations = [
        "Numbers, percentages, and rates",
        "Algebra you actually use",
        "Functions and graphs",
        "Probability and expected value",
        "Distributions and uncertainty",
        "Optimization and marginal thinking",
        "Working with data",
        "Logarithms, growth, and decay",
        "Counting and combinatorics",
        "Conditional probability and Bayes",
        "Rates of change and the derivative",
        "Indices, normalization, and z-scores",
    ]

    private static let core = [
        "The ecosystem",
        "The impression and the auction",
        "Identity and targeting",
        "Pricing models",
        "Measurement",
        "Inventory and formats",
        "Retail media and incremental ROAS",
        "Pixels and tags, how tracking works",
        "Supply path optimization and the ad-tech tax",
        "Fraud, viewability, and ad quality",
        "The cookieless future and the identity stack",
        "Header bidding and the unified auction",
    ]

    private static let adops = [
        "The AdOps role and the campaign lifecycle",
        "Trafficking a campaign",
        "Ad tags, macros, and cachebusters",
        "Creative specs and QA",
        "VAST and video delivery",
        "Brand safety, suitability, and verification",
        "Consent and privacy operations",
        "Discrepancies, reconciliation, and make-goods",
        "Reporting, dashboards, and the wrap report",
        "PMP and PG deal setup",
        "CTV, audio, and DOOH operations",
        "Audience and segment operations",
    ]

    private static let dsp = [
        "The bid landscape",
        "Auctions and the math of the bid",
        "Win-rate curves and bid landscapes",
        "Impression valuation",
        "pCTR and pCVR prediction",
        "Bid shading and surplus optimization",
        "Budget pacing",
        "Frequency and reach capping",
        "Audience signals and bid modifiers",
        "Fraud, viewability, and supply-path optimization",
        "Attribution and optimization loops",
        "Incrementality",
        "Capstone: the Trading Floor",
    ]

    private static let sales = [
        "The sell side and the deal",
        "Pricing math",
        "Yield and the value of inventory",
        "Forecasting avails",
        "PMP, PG, and preferred deals",
        "Margin and profitability",
        "ROI storytelling",
        "Quota and pipeline math",
        "Discounting and negotiation",
        "Upsell and retention",
        "Revenue forecasting",
        "Capstone: price and defend a deal",
    ]

    private static let planning = [
        "The brief and the funnel",
        "Audience sizing",
        "Budget allocation",
        "Reach and frequency",
        "GRPs and TRPs",
        "Flighting and pacing",
        "Cross-channel media mix",
        "Forecasting outcomes",
        "Measurement planning",
        "Incrementality and MMM",
        "Scenario and sensitivity planning",
        "Capstone: build a media plan",
        "Attention metrics and attention-adjusted CPM",
    ]

    private static let analytics = [
        "The analyst's role and the measurement stack",
        "Data foundations and clean rooms",
        "Descriptive analytics",
        "SQL for ad data",
        "Sampling and uncertainty",
        "Hypothesis testing",
        "Statistical power and experiment design",
        "Causal inference",
        "Incrementality and lift",
        "Attribution modeling",
        "Marketing mix modeling",
        "Predictive modeling",
        "Forecasting",
        "Capstone: run an incrementality experiment",
        "Data clean rooms and differential privacy",
    ]

    private static let engineering = [
        "How a DSP is built",
        "OpenRTB protocol anatomy",
        "The real-time constraint",
        "Bidder architecture",
        "The auction at scale",
        "Model serving",
        "Pacing as a control system",
        "Budget management systems",
        "Data pipelines",
        "Identity and graphs",
        "Fraud and quality systems",
        "Reliability and cost",
        "Capstone: build a bidder to spec",
    ]

    private static let ai = [
        "What AI is doing in programmatic",
        "Agentic buying and the new job of guardrails",
        "AI in bidding, creative, and measurement",
        "Machine learning foundations for adtech",
        "Predictive bidding and value optimization",
        "Generative creative and DCO",
        "LLMs and agents in the workflow",
        "AI in measurement and MMM",
        "Privacy-safe AI: clean rooms and federated learning",
        "AI governance and the EU AI Act",
        "Bias, brand safety, and the limits of AI",
    ]

    // MARK: - Industry deep-dives (0 to 100 per vertical, from the authored lesson frontmatter)

    private static let verticalRetail = [
        "The Money Map: Retail Media Networks, On-Site vs Off-Site, and the Walled-Garden Landscape",
        "The Buyer and the Mandate, Endemic Brands, the iROAS Mandate, and What \"Good\" Looks Like",
        "The Conversion and the Funnel: Closed-Loop Sales, Attribution Windows, and Brand Halo",
        "Auction Mechanics: Second-Price Reserve, Effective Bid = Bid x Relevance, and Placement Modifiers Across Ad Types",
        "Bidding, Budgeting and Pacing, Bid Strategies, Translating an ACoS Target into a Starting Bid, and Intraday Pacing",
        "Campaign Structure and Account Taxonomy: Auto vs Manual, Branded/Category/Conquest, Keyword Harvesting and the Negative-Keyword Bridge",
        "Off-Site DSP Execution and Supply Path: Amazon DSP vs TTD vs DV360, Deal-IDs/PMPs, SPO, Frequency, and CTV",
        "Fees, Take-Rates, Margin and Financial Reconciliation, Working vs Gross Media and Spend-vs-Invoice",
        "Measurement, incrementality and clean rooms: lift testing, AMC, MMM vs MTA, and cross-RMN de-duplication",
        "Operations, Creative/PDP Readiness, Reporting Cadence, and the 2026 Frontier (In-Store DOOH, Agentic, Commerce Networks)",
    ]

    private static let verticalCpg = [
        "The Money Map, CPG's Retail-Media-Led Programmatic Landscape",
        "The Mandate Into Decisions, Turning mROI and iROAS Targets Into Bids and Budget Shifts",
        "What Counts as a Conversion, Attribution Windows, Match Rates, and Signal Reconciliation",
        "Building the Campaign: Trafficking Across Onsite Consoles and Offsite DSPs",
        "Bid Strategy and Pacing Against Flat and Seasonal Budgets",
        "Deal Execution: PMP and Programmatic Guaranteed Against Retailer 1P Audiences",
        "Identity and Audience Match, Clean Rooms, RampID/UID2, and Non-Portable 1P Segments",
        "QA and discrepancy reconciliation, DSP vs retailer vs IAS/DV vs the brand's sales read",
        "Verification, brand safety, and creative specs, keeping offsite spend clean and live",
        "Measurement Execution and Seasonal Flighting, Running Lift Tests and Pacing the Calendar",
    ]

    private static let verticalEcommerce = [
        "The Money Map: Retail Media, Open Web, and the Ecommerce Programmatic Landscape",
        "The Buyer and the Mandate, Who Buys, the Goal, and the LTV:CAC North Star (Net of Returns)",
        "Amazon Efficiency Core, ACoS, TACoS, and the Ad-to-Organic Rank Flywheel",
        "Targeting and Audiences, Keywords, ASINs, Clean Rooms, and First-Party Lists",
        "Bidding and Auction Controls, From Contribution Margin to Max CPC/CPM/tROAS",
        "Incrementality and MER, proving the media actually caused the sales",
        "Pacing and Seasonality, Prime Day, BFCM, Budget Multipliers, and Dayparting",
        "Catalog Gates and Search-Term Hygiene, Buy-Box, Out-of-Stock Suppression, and Negatives",
        "Pixels, CAPI, Feeds, and Identity, Reconciling Revenue Under Signal Loss",
        "Closing the Loop, Make-Goods, Bulk Ops Tooling, Creative and Feed QA, and the QBR",
    ]

    private static let verticalDtc = [
        "The Money Map, the DTC Programmatic Landscape",
        "The Buyer and the Mandate: MER Is the Scoreboard",
        "The Conversion and the Funnel: What Counts and Where It Leaks",
        "The Execution Core: ASC, CBO vs ABO, Bid Strategy, Learning Phase, Pacing",
        "The Creative-Testing Engine: Hook, Hold, Fatigue, and Winner-Scaling",
        "Owning the Signal: CAPI, Server-Side, EMQ, and Event Deduplication",
        "Incrementality: Geo and Conversion-Lift Holdouts vs Demand-Harvesting",
        "The Margin Ceiling: CAC, LTV, Contribution Margin, and Payback",
        "Sensitive-Category Restrictions, Health and Wellness Optimization Limits",
        "Off-Meta Diversification, TikTok Spark Ads, CTV, and Amazon DSP",
    ]

    private static let verticalAuto = [
        "The Money Map, Auto's Three-Tier Programmatic Landscape",
        "The Buyer and the Mandate: Net Cost Per Sale and What Good Looks Like",
        "The Conversion and the Funnel, VDP Views, Leads, and the Titled Sale",
        "Audience and Data Targeting: Building In-Market, Conquest, and Loyalty Segments",
        "Supply, Deals, and the Inventory Feed: PMP/Deal-ID, CTV, SPO, and Dynamic VLAs",
        "Identity and First-Party Data: DMS/CRM Onboarding, Clean Rooms, and UID2",
        "Campaign Build and Pacing, Line Items, Co-op Windows, Frequency, and Fixing Drift",
        "Attribution and VIN Matchback, Proving the Sale in the DMS/CRM",
        "Co-op Compliance QA, passing OEM brand rules to protect reimbursement",
        "Reporting, Troubleshooting, and the Operator's Daily Reality",
    ]

    private static let verticalFinance = [
        "The Money Map, Programmatic in Financial Services",
        "The Buyer and the Mandate: Cost per Funded Account",
        "Compliance Rails, the targeting levers finance loses",
        "Building the Ceiling, LTV, Allowable CAC and the CPFA Cap",
        "The Leaky Cascade: From Impression to KYC-Approved to Funded",
        "Measurement That Lies: Incrementality and Geo Holdouts",
        "Identity and Clean Rooms, First-Party CRM, Suppression and High-LTV Lookalikes",
        "Deal Architecture: PMP, Programmatic Guaranteed and SPO on Finance/News Inventory",
        "Brand Safety, Discrepancy Reconciliation and Creative Compliance Ops",
        "Seasonality, Dayparting and Defending the Budget, the Finance Trader in Full",
    ]

    private static let verticalTravel = [
        "The Money Map, Travel's Programmatic Landscape and Travel Media Networks",
        "The buyer and the mandate, who buys travel media and the cost-per-booking KPI",
        "The conversion and the funnel, look-to-book, cart abandonment, and the 45-day window",
        "The Inventory and the Deal: PMPs, Programmatic Guaranteed, and Travel-Intent SSPs",
        "Pacing and Seasonality, Buying Against a Demand Curve You Don't Control",
        "Data and Identity, Booking Pixels, Server-Side Conversions, MMP Attribution, and Suppression",
        "Channels and Formats, Dynamic Retargeting, Metasearch, App-Install, and Deep-Linked Re-Engagement",
        "Measurement and Incrementality, Geo Holdouts vs Last-Click and SKAN-Truncated ROAS",
        "Compliance and waste, drip-pricing rules, consent on intent data, rate-parity, and cross-surface suppression",
        "The Capstone, Wiring a Full-Funnel Travel Booking Campaign Across Web and App",
    ]

    private static let verticalTelecom = [
        "The Money Map, Telecom's Programmatic Landscape",
        "The Buyer and the Mandate, Who Buys and the LTV:SAC North Star",
        "Serviceability and Footprint, Only Bid Where You Can Actually Sell",
        "Identity and Clean Rooms: Matching First-Party CRM and Coverage Data",
        "Deal Construction: Building PMPs, PG, and Curated Telecom Inventory",
        "Bidding and Pacing, Bid Ceilings from SAC and Smooth Delivery of Big Budgets",
        "Frequency and Reach Across Fragmented CTV Supply",
        "Trafficking and QA: Pixels, Postbacks, Creative, and Discrepancy Troubleshooting",
        "Brand Safety, IVT, and Supply-Path Optimization",
        "Proving It, Incrementality, MMM, and the End-to-End Campaign Build",
    ]

    private static let verticalHealthcare = [
        "The Money Map, Healthcare and Pharma's Programmatic Landscape",
        "The Buyer and the Mandate, NPI, Deciles, and Cost per Script",
        "The Conversion and the Funnel, From Impression to Prescription",
        "NPI-to-Device Match Rate, the core daily-ops competency",
        "Clean-Room Lift Measurement, Proving Cost per Script",
        "MLR and Regulatory Creative Ops: ISI, DCO, and FDA/OCR Scrutiny",
        "Endemic SSP/PMP Setup, Brand Safety, and Suppression",
        "Frequency, Cross-Channel Pacing, and MLR-Gated Flighting",
        "Troubleshooting and QA, diagnose a failing campaign",
        "Reporting, Optimization, and the Pharma Calendar",
    ]

    private static let verticalQsr = [
        "The Money Map, QSR Programmatic Landscape, Channels, and the Local-at-Scale Problem",
        "The Buyer and the Mandate, Who Buys QSR Media and Why CPIV Is the North Star",
        "Geo, Polygon, POI and Lat/Long QA, Hitting Your Doors, Not the Competitor Across the Street",
        "Franchise Co-op Budgets and Line-Item Fan-Out, Trafficking Thousands of Stores Without Dying",
        "Deal Plumbing: PMP/PG and Curated CTV, Audio and DOOH Inventory, and Why Deals Do Not Bid",
        "Daypart, Frequency Cap and Flighted LTO Pacing: Landing Budget in the Meal Window Without Front-Loading",
        "Identity and Signal Loss: The Email to MAID to Household-IP to Geo Chain and MAID Deprecation",
        "Fraud and Quality Control, Location Spoofing and IVT in a Geo-Driven, CTV-Heavy Buy",
        "Footfall Attribution and Incrementality, Geo-Holdout, PSA-Control and Ghost-Bid Tests",
        "CPIV Reconciliation, the Offline Drive-Thru Gap, and Sensitive-Location Privacy Limits",
    ]

    private static let verticalB2b = [
        "The Money Map: B2B/SaaS Programmatic Landscape",
        "The Buyer and the Mandate, LTV:CAC Is King",
        "The Conversion and the Funnel, Connecting Ad Exposure to Closed-Won",
        "Identity, Match Rates, and the Signal-Loss Regime",
        "Pacing the 84-Day Cycle and the Buying Committee",
        "Inventory, Curation, and the Waste War",
        "Bid Strategy and the ACV-Tier Ceiling",
        "Channels, Formats, and the Offer: The B2B Creative Toolkit",
        "The Measurement War: Incrementality and the Dark Funnel",
        "Capstone: Running One ABM Campaign End to End",
    ]
}
