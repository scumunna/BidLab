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

echo
echo "[coverage] BidLabCore report:"
xcrun llvm-cov report "$COV/bidlab-cov" \
    -instr-profile="$COV/bidlab.profdata" "$ROOT/Sources/BidLabCore"
