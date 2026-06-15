import SwiftUI

/// Top-level surfaces of the app, shown in the sidebar rail.
enum Surface: String, CaseIterable, Identifiable {
    case learn
    case review
    case verticals
    case tradingFloor
    case tools
    case exams
    case progress
    case explorable
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .learn: return "Learn"
        case .review: return "Review"
        case .verticals: return "Industries"
        case .tradingFloor: return "Trading Floor"
        case .tools: return "Tools"
        case .exams: return "Exams"
        case .progress: return "Progress"
        case .explorable: return "Explorable"
        case .settings: return "Settings"
        }
    }

    var icon: String {
        switch self {
        case .learn: return "books.vertical"
        case .review: return "arrow.clockwise"
        case .verticals: return "building.2"
        case .tradingFloor: return "waveform.path.ecg"
        case .tools: return "wrench.and.screwdriver"
        case .exams: return "graduationcap"
        case .progress: return "rosette"
        case .explorable: return "sparkles"
        case .settings: return "gearshape"
        }
    }
}
