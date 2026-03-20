#!/bin/bash

# Build and run miniBroker app with full console output
# This script forces x86_64 architecture for Intel Macs

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HASH_FILE="$SCRIPT_DIR/last_run_hash"

# Compute a hash of all tracked source files (excludes build artifacts)
current_hash=$(git -C "$SCRIPT_DIR" diff HEAD --stat -- lib/ proto/ pubspec.yaml | shasum -a 256 | cut -d' ' -f1)
# Also factor in the HEAD commit so committed changes are detected
head_hash=$(git -C "$SCRIPT_DIR" rev-parse HEAD)
combined_hash="${head_hash}_${current_hash}"

if [ -f "$HASH_FILE" ] && [ "$(cat "$HASH_FILE")" = "$combined_hash" ]; then
    echo "📌 No changes since last run — skipping version bump"
else
    # Increment patch version in pubspec.yaml
    old_version=$(grep '^version:' "$SCRIPT_DIR/pubspec.yaml" | head -1 | sed 's/version: //')
    base_version=$(echo "$old_version" | cut -d'+' -f1)
    build_number=$(echo "$old_version" | cut -d'+' -f2)

    major=$(echo "$base_version" | cut -d'.' -f1)
    minor=$(echo "$base_version" | cut -d'.' -f2)
    patch=$(echo "$base_version" | cut -d'.' -f3)
    new_patch=$((patch + 1))
    new_build=$((build_number + 1))
    new_version="${major}.${minor}.${new_patch}+${new_build}"

    sed -i '' "s/^version: .*/version: ${new_version}/" "$SCRIPT_DIR/pubspec.yaml"
    echo "📦 Version bumped: $old_version → $new_version"

    echo "$combined_hash" > "$HASH_FILE"
fi

echo "🧹 Cleaning previous build..."
flutter clean

echo "🔨 Building miniBroker for x86_64..."

# Get dependencies and configure
flutter pub get
flutter build macos --config-only

cd macos

# Build with xcodebuild for x86_64
xcodebuild \
    -workspace Runner.xcworkspace \
    -scheme Runner \
    -configuration Debug \
    -destination 'platform=macOS,arch=x86_64' \
    build

if [ $? -eq 0 ]; then
    echo "✅ Build succeeded!"
    echo "🚀 Launching miniBroker with console output..."

    # Find the app
    APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/Runner-*/Build/Products/Debug -name "miniBroker.app" 2>/dev/null | head -1)

    if [ -z "$APP_PATH" ]; then
        # Try the build directory
        APP_PATH="../build/macos/Build/Products/Debug/miniBroker.app"
    fi

    if [ -f "$APP_PATH/Contents/MacOS/miniBroker" ]; then
        echo "✅ App found at: $APP_PATH"
        echo "📱 Running with console output (Ctrl+C to stop)..."
        echo "=========================================="
        # Run the app directly to capture stdout/stderr
        "$APP_PATH/Contents/MacOS/miniBroker"
    else
        echo "❌ Could not find built app at $APP_PATH"
        exit 1
    fi
else
    echo "❌ Build failed"
    exit 1
fi
