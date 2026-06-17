#!/usr/bin/env bash
# Build BidLabCore and run the known-answer test suite.
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

build_core
TEST_SRCS=()
while IFS= read -r -d '' f; do TEST_SRCS+=("$f"); done < <(find "$ROOT/Tests/BidLabCoreTests" -name '*.swift' -print0)
swiftc -I "$BUILD" -L "$BUILD" -lBidLabCore \
    -module-name BidLabCoreTests \
    -o "$BUILD/bidlab-tests" \
    "${TEST_SRCS[@]}" -sdk "$SDK"
export BIDLAB_CONTENT="$ROOT/Content/Lessons"
export BIDLAB_EXAMS="$ROOT/Content/Exams"
"$BUILD/bidlab-tests"
