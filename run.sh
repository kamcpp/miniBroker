#!/bin/bash

# Build and run mini-broker app
# This script forces x86_64 architecture for Rosetta 2 environments

set -e

echo "🔨 Building mini-broker for x86_64..."

# Configure Flutter project
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
    echo "🚀 Launching mini-broker..."

    # Find and launch the app
    APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/Runner-*/Build/Products/Debug -name "mini-broker.app" 2>/dev/null | head -1)

    if [ -z "$APP_PATH" ]; then
        # Try the build directory
        APP_PATH="../build/macos/Build/Products/Debug/mini-broker.app"
    fi

    if [ -f "$APP_PATH/Contents/MacOS/mini-broker" ]; then
        open "$APP_PATH"
        echo "✅ App launched successfully!"
        echo "📱 App path: $APP_PATH"
    else
        echo "❌ Could not find built app at $APP_PATH"
        exit 1
    fi
else
    echo "❌ Build failed"
    exit 1
fi
