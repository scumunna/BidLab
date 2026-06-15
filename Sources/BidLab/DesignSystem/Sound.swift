import AppKit

/// Subtle, tasteful audio feedback using the built-in macOS system sounds.
/// Loads the files directly so it works across SDK versions.
enum Sound {
    private static func play(_ name: String) {
        NSSound(contentsOfFile: "/System/Library/Sounds/\(name).aiff", byReference: true)?.play()
    }

    /// A bright chime for finishing a lesson.
    static func complete() { play("Glass") }

    /// A soft pop for a correct answer.
    static func correct() { play("Pop") }
}
