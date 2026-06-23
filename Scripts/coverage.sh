#!/usr/bin/env bash
# Measure BidLabCore code coverage with swiftc profiling + llvm-cov.
#
# SwiftPM is broken on this machine (see lib.sh), so `swift test --enable-code-
# coverage` does not run. Instead we instrument the same swiftc build the test
# runner already uses (-profile-generate -profile-coverage-mapping), run the
# known-answer suite, and emit an llvm-cov report scoped to Sources/BidLabCore.
#
# Usage:
#   ./Scripts/coverage.sh            # build, run, print the per-file report
#   ./Scripts/coverage.sh check      # also fail if coverage regresses (the CI gate)
#   ./Scripts/coverage.sh show File  # annotate uncovered lines in one source file
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SDK="$(xcrun --sdk macosx --show-sdk-path)"
COV="$ROOT/.build-cov"
mkdir -p "$COV"

CORE_SRCS=( "$ROOT"/Sources/BidLabCore/*.swift )
TEST_SRCS=( "$ROOT"/Tests/BidLabCoreTests/*.swift )

echo "[coverage] building instrumented core ..."
swiftc -profile-generate -profile-coverage-mapping -parse-as-library \
    -emit-module -emit-library -static -module-name BidLabCore \
    -emit-module-path "$COV/BidLabCore.swiftmodule" \
    -o "$COV/libBidLabCore.a" "${CORE_SRCS[@]}" -sdk "$SDK"

echo "[coverage] building instrumented test runner ..."
# -force_load pulls every core object (and its coverage map) into the binary,
# so even files not referenced by a test still report honestly instead of vanishing.
swiftc -profile-generate -profile-coverage-mapping -I "$COV" \
    -Xlinker -force_load -Xlinker "$COV/libBidLabCore.a" \
    -module-name BidLabCoreTests -o "$COV/bidlab-cov" \
    "${TEST_SRCS[@]}" -sdk "$SDK"

echo "[coverage] running known-answer suite ..."
export BIDLAB_CONTENT="$ROOT/Content/Lessons"
export BIDLAB_EXAMS="$ROOT/Content/Exams"
LLVM_PROFILE_FILE="$COV/bidlab.profraw" "$COV/bidlab-cov"

xcrun llvm-profdata merge -sparse "$COV/bidlab.profraw" -o "$COV/bidlab.profdata"

if [ "${1:-}" = "show" ] && [ -n "${2:-}" ]; then
    xcrun llvm-cov show "$COV/bidlab-cov" -instr-profile="$COV/bidlab.profdata" \
        "$ROOT/Sources/BidLabCore/$2" --show-line-counts -use-color=false
    exit 0
fi

REPORT=$(xcrun llvm-cov report "$COV/bidlab-cov" \
    -instr-profile="$COV/bidlab.profdata" "$ROOT/Sources/BidLabCore")
echo
echo "[coverage] BidLabCore report:"
echo "$REPORT"

# `check` mode (the CI gate): fail if coverage regresses beyond the documented
# unreachable-defensive baseline. The TOTAL row's missed region/function/line
# counts must not exceed these; any new uncovered code raises a count and fails.
# (The 4/2/2 baseline is the unreachable defensive set documented in docs/COVERAGE.md.)
if [ "${1:-}" = "check" ]; then
    MAX_MISSED_REGIONS=4
    MAX_MISSED_FUNCTIONS=2
    MAX_MISSED_LINES=2
    TOTAL_LINE=$(echo "$REPORT" | grep -E '^TOTAL' | tail -1 || true)
    mr=$(echo "$TOTAL_LINE" | awk '{print $3}')
    mf=$(echo "$TOTAL_LINE" | awk '{print $6}')
    ml=$(echo "$TOTAL_LINE" | awk '{print $9}')
    echo
    echo "[coverage] missed regions=${mr:-?} functions=${mf:-?} lines=${ml:-?} (baseline ${MAX_MISSED_REGIONS}/${MAX_MISSED_FUNCTIONS}/${MAX_MISSED_LINES}, all unreachable defensive; see docs/COVERAGE.md)"
    if [ -z "$mr" ] || [ -z "$mf" ] || [ -z "$ml" ]; then
        echo "[coverage] FAIL: could not parse the coverage TOTAL row."
        exit 1
    fi
    if [ "$mr" -gt "$MAX_MISSED_REGIONS" ] || [ "$mf" -gt "$MAX_MISSED_FUNCTIONS" ] || [ "$ml" -gt "$MAX_MISSED_LINES" ]; then
        echo "[coverage] FAIL: BidLabCore coverage regressed beyond the documented unreachable baseline."
        exit 1
    fi
    echo "[coverage] OK: no coverage regression."
fi
