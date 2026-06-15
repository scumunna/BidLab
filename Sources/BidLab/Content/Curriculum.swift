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
}
