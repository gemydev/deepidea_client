#!/usr/bin/env bash
# Release build with maximum size shrink.
#
# Ship App Bundle to Play (per-ABI / per-locale / per-density splits are
# handled server-side, so users download the smallest artifact possible).
# For sideload testing, run with `apk-split`.

set -euo pipefail
cd "$(dirname "$0")/.."

MODE="${1:-bundle}"           # bundle | apk-split | apk-universal
SYMBOLS_DIR="build/symbols"

FLAGS=(
    --release
    --obfuscate
    --split-debug-info="$SYMBOLS_DIR"
    --tree-shake-icons
    --dart-define=flutter.inspector.structuredErrors=false
)

# ARM only — x86_64 is dropped from release because the Play Store no longer
# accepts 32-bit-only devices and emulators are covered by debug builds.
ABIS="android-arm,android-arm64"

case "$MODE" in
    bundle)
        flutter build appbundle --target-platform="$ABIS" "${FLAGS[@]}"
        echo
        echo "AAB: build/app/outputs/bundle/release/app-release.aab"
        ls -lah build/app/outputs/bundle/release/*.aab
        ;;
    apk-split)
        flutter build apk --split-per-abi --target-platform="$ABIS" "${FLAGS[@]}"
        echo
        ls -lah build/app/outputs/apk/release/*.apk
        ;;
    apk-universal)
        flutter build apk --target-platform="$ABIS" "${FLAGS[@]}"
        echo
        ls -lah build/app/outputs/apk/release/*.apk
        ;;
    *)
        echo "Usage: $0 [bundle|apk-split|apk-universal]" >&2
        exit 1
        ;;
esac
