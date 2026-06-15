#!/usr/bin/env bash
# Shared build helpers for BidLab's swiftc-driven build.
#
# Why swiftc and not SwiftPM: this machine's Command Line Tools ship a broken
# `swift-package` (it fails to load BuildServerProtocol.framework due to a bad
# rpath), so `swift build`/`swift test` do not run. `swiftc` works perfectly, so
# we compile the BidLabCore static library and the SwiftUI app executable
# directly, then assemble a real .app bundle.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SDK="$(xcrun --sdk macosx --show-sdk-path)"
BUILD="$ROOT/.build-manual"
DIST="$ROOT/build"
APP="$DIST/BidLab.app"

build_core() {
    mkdir -p "$BUILD"
    local opt="${1:-}"
    local srcs
    srcs="$(find "$ROOT/Sources/BidLabCore" -name '*.swift')"
    # shellcheck disable=SC2086
    swiftc $opt -parse-as-library -emit-module -emit-library -static \
        -module-name BidLabCore \
        -emit-module-path "$BUILD/BidLabCore.swiftmodule" \
        -o "$BUILD/libBidLabCore.a" \
        $srcs -sdk "$SDK"
}

build_app() {
    local opt="${1:-}"
    local srcs
    srcs="$(find "$ROOT/Sources/BidLab" -name '*.swift')"
    # shellcheck disable=SC2086
    swiftc $opt -parse-as-library \
        -I "$BUILD" -L "$BUILD" -lBidLabCore -lsqlite3 \
        -module-name BidLab \
        -o "$BUILD/BidLab" \
        $srcs -sdk "$SDK"
}

bundle_app() {
    rm -rf "$APP"
    mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
    cp "$BUILD/BidLab" "$APP/Contents/MacOS/BidLab"
    cp "$ROOT/Resources/Info.plist" "$APP/Contents/Info.plist"
    if [ -f "$ROOT/Resources/BidLab.icns" ]; then
        cp "$ROOT/Resources/BidLab.icns" "$APP/Contents/Resources/BidLab.icns"
    fi
    if [ -d "$ROOT/Content/Lessons" ]; then
        mkdir -p "$APP/Contents/Resources/Lessons"
        cp "$ROOT/Content/Lessons/"*.md "$APP/Contents/Resources/Lessons/" 2>/dev/null || true
    fi
    if [ -d "$ROOT/Content/Exams" ]; then
        mkdir -p "$APP/Contents/Resources/Exams"
        cp "$ROOT/Content/Exams/"*.md "$APP/Contents/Resources/Exams/" 2>/dev/null || true
    fi
    if [ -d "$ROOT/Resources/Fonts" ]; then
        mkdir -p "$APP/Contents/Resources/Fonts"
        cp "$ROOT/Resources/Fonts/"*.ttf "$APP/Contents/Resources/Fonts/" 2>/dev/null || true
    fi
    codesign --force --sign - "$APP" >/dev/null 2>&1 || true
}
