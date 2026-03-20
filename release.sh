#!/bin/bash

# Release script for Agora miniBroker
# Builds a release executable for the host OS, packages as zip,
# then bumps minor version and resets patch to 0.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Read current version from pubspec.yaml
old_version=$(grep '^version:' pubspec.yaml | head -1 | sed 's/version: //')
base_version=$(echo "$old_version" | cut -d'+' -f1)
build_number=$(echo "$old_version" | cut -d'+' -f2)

major=$(echo "$base_version" | cut -d'.' -f1)
minor=$(echo "$base_version" | cut -d'.' -f2)
patch=$(echo "$base_version" | cut -d'.' -f3)

# Abort if patch is 0 — nothing to release
if [ "$patch" -eq 0 ]; then
    echo "❌ Patch version is 0 ($base_version) — nothing to release."
    echo "   Run the app via run.sh to bump patch versions first."
    exit 1
fi

echo "📦 Releasing Agora miniBroker v${base_version}"

# Detect host OS
case "$(uname -s)" in
    Darwin*)  HOST_OS="macos" ;;
    Linux*)   HOST_OS="linux" ;;
    MINGW*|MSYS*|CYGWIN*) HOST_OS="windows" ;;
    *)
        echo "❌ Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac

echo "🖥️  Host OS: $HOST_OS"

ZIP_NAME="Agora-miniBroker-${HOST_OS}-${base_version}.zip"

# Clean and build
echo "🧹 Cleaning previous build..."
flutter clean
flutter pub get

case "$HOST_OS" in
    macos)
        echo "🔨 Building macOS release..."
        flutter build macos --release

        APP_PATH="build/macos/Build/Products/Release/miniBroker.app"
        if [ ! -d "$APP_PATH" ]; then
            # Fallback: try xcodebuild for x86_64
            echo "⚠️  Standard build path not found, trying xcodebuild..."
            flutter build macos --config-only
            cd macos
            xcodebuild \
                -workspace Runner.xcworkspace \
                -scheme Runner \
                -configuration Release \
                -destination 'platform=macOS,arch=x86_64' \
                build
            cd "$SCRIPT_DIR"
            APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/Runner-*/Build/Products/Release -name "miniBroker.app" 2>/dev/null | head -1)
            if [ -z "$APP_PATH" ]; then
                echo "❌ Could not find built macOS app"
                exit 1
            fi
        fi

        echo "📦 Packaging $APP_PATH → $ZIP_NAME"
        cd "$(dirname "$APP_PATH")"
        zip -r "$SCRIPT_DIR/$ZIP_NAME" "$(basename "$APP_PATH")"
        cd "$SCRIPT_DIR"
        ;;

    linux)
        echo "🔨 Building Linux release..."
        flutter build linux --release

        BUNDLE_PATH="build/linux/x64/release/bundle"
        if [ ! -d "$BUNDLE_PATH" ]; then
            echo "❌ Could not find built Linux bundle at $BUNDLE_PATH"
            exit 1
        fi

        echo "📦 Packaging $BUNDLE_PATH → $ZIP_NAME"
        cd "$BUNDLE_PATH"
        zip -r "$SCRIPT_DIR/$ZIP_NAME" .
        cd "$SCRIPT_DIR"
        ;;

    windows)
        echo "🔨 Building Windows release..."
        flutter build windows --release

        BUNDLE_PATH="build/windows/x64/runner/Release"
        if [ ! -d "$BUNDLE_PATH" ]; then
            # Try older Flutter path
            BUNDLE_PATH="build/windows/runner/Release"
        fi
        if [ ! -d "$BUNDLE_PATH" ]; then
            echo "❌ Could not find built Windows bundle"
            exit 1
        fi

        echo "📦 Packaging $BUNDLE_PATH → $ZIP_NAME"
        cd "$BUNDLE_PATH"
        zip -r "$SCRIPT_DIR/$ZIP_NAME" .
        cd "$SCRIPT_DIR"
        ;;
esac

echo "✅ Release built: $ZIP_NAME"
ls -lh "$ZIP_NAME"

# Bump minor version, reset patch to 0
new_minor=$((minor + 1))
new_version="${major}.${new_minor}.0+${build_number}"
# sed -i behaves differently on macOS vs Linux
if [ "$HOST_OS" = "macos" ]; then
    sed -i '' "s/^version: .*/version: ${new_version}/" pubspec.yaml
else
    sed -i "s/^version: .*/version: ${new_version}/" pubspec.yaml
fi

echo ""
echo "🔖 Version bumped: $base_version → ${major}.${new_minor}.0"
echo "   Next dev cycle starts at ${major}.${new_minor}.0+${build_number}"
echo ""
echo "📦 Release artifact: $ZIP_NAME"
