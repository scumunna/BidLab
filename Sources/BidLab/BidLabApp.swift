import SwiftUI

@main
struct BidLabApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 1240, height: 820)
        .defaultPosition(.center)
        .windowResizability(.contentMinSize)
    }
}
