import Foundation

/// Named figures a lesson can embed with `:::figure <name>`. The drawings live
/// in the app's FigureRegistry; this canonical list lets content validation
/// confirm a lesson references a figure that actually exists. Figures are
/// original vector mockups (real-looking ad creative and diagrams), never
/// copyrighted artwork.
public enum Figures {
    public static let names: [String] = [
        // Ad-creative mockups
        "displayAd",
        "videoAd",
        "nativeAd",
        "ctvAd",
        // Diagrams
        "rtbFlow",
        "supplyChain",
        "funnel",
        "secondPriceAuction",
        "attributionPaths",
        "headerBidding",
        "audioAd",
        "pixelFire",
        "lineItemTree",
        "vastFlow",
        "discrepancyWaterfall",
        "pacingCurve",
        // Industry deep-dive figures
        "retailMediaFlow",
        "cleanRoomMatch",
        "costPerFundedCascade",
        "lookToBookFunnel",
        "seasonalityCurve",
        "npiTargeting",
        "scriptLift",
        "isiLayout",
        "churnLtvCurve",
        "subscriptionLtv",
        "dealerTiers",
        "tradeVsMedia",
        "mmmDecomposition",
        "abmPipeline",
        "geoHoldout",
        "incrementalityHoldout",   // alias of geoHoldout (briefs' common name)
        "daypartingHeatmap",
    ]

    public static let known = Set(names)
}
