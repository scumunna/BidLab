// swift-tools-version: 6.0
import PackageDescription

// BidLab is built entirely with SwiftPM so it needs no full Xcode install.
// `BidLabCore` is a pure, UI-free, fully tested library (the math-centric core).
// `BidLab` is the SwiftUI macOS app executable. A bundling script assembles the
// executable + Info.plist into a real `BidLab.app`.
let package = Package(
    name: "BidLab",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "BidLabCore", targets: ["BidLabCore"]),
        .executable(name: "BidLab", targets: ["BidLab"]),
    ],
    targets: [
        .target(
            name: "BidLabCore",
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
        .executableTarget(
            name: "BidLab",
            dependencies: ["BidLabCore"],
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
        .testTarget(
            name: "BidLabCoreTests",
            dependencies: ["BidLabCore"],
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
    ]
)
