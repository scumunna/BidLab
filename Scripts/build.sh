#!/usr/bin/env bash
# Build the BidLab macOS app and assemble build/BidLab.app.
# Usage: Scripts/build.sh [debug|release]
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

CONFIG="${1:-debug}"
OPT=""
[ "$CONFIG" = "release" ] && OPT="-O"

build_core "$OPT"
build_app "$OPT"
bundle_app
echo "Built $APP ($CONFIG)"
