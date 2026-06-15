import BidLabCore
import SwiftUI

/// App-wide navigation state. Persistence (SwiftData) arrives in a later phase;
/// for now this just tracks which surface and path are in view, plus the active
/// industry lens.
final class AppState: ObservableObject {
    @Published var surface: Surface = .learn
    @Published var selectedTrackID: String? = Track.all.first?.id
    @Published var openPathID: String?
    @Published var openLessonID: String?
    @Published var selectedVerticalID: String?
    /// A pending hand-off from a lesson: open this track's exam when the Exams
    /// surface next appears.
    @Published var pendingExamTrack: String?

    var selectedTrack: Track? {
        Track.all.first { $0.id == selectedTrackID }
    }

    /// The active industry lens, if one is set.
    var selectedVertical: Vertical? {
        selectedVerticalID.flatMap { Verticals.byID($0) }
    }
}
