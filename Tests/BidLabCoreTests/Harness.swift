import Foundation

/// A tiny known-answer test harness.
///
/// The Command Line Tools install on this machine ships a broken SwiftPM
/// (`swift-package` fails to load `BuildServerProtocol.framework`), which also
/// blocks Swift Testing's runner. Until a full Xcode or a repaired toolchain is
/// available, BidLab builds and tests through `swiftc` directly and this harness
/// stands in for the test framework. The assertions themselves are real
/// known-answer checks, so correctness coverage is unchanged.
final class Harness {
    private(set) var passed = 0
    private(set) var failed = 0
    private var failures: [String] = []

    func check(_ name: String, _ condition: Bool) {
        if condition {
            passed += 1
        } else {
            failed += 1
            failures.append(name)
        }
    }

    func close(_ name: String, _ lhs: Double, _ rhs: Double, tol: Double = 1e-9) {
        check(name, abs(lhs - rhs) < tol)
    }

    /// Prints a summary and returns the process exit code (0 = all passed).
    func summary() -> Int32 {
        print("")
        if failures.isEmpty {
            print("[PASS] all \(passed) checks passed")
            return 0
        }
        print("[FAIL] \(failed) failed, \(passed) passed")
        for failure in failures {
            print("  - \(failure)")
        }
        return 1
    }
}
