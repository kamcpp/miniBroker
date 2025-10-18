#!/bin/bash

# Build and run mini-broker app for x86_64 architecture
# This script bypasses the flutter run arm64 issue

set -e

echo "🔨 Building mini-broker for x86_64..."

cd macos

xcodebuild \
    -workspace Runner.xcworkspace \
    -scheme Runner \
    -configuration Debug \
    -destination 'platform=macOS,arch=x86_64' \
    build | grep -E "(BUILD|error|warning:)" || true

if [ $? -eq 0 ]; then
    echo "✅ Build succeeded!"
    echo "🚀 Launching mini-broker..."

    # Find and launch the app
    APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/Runner-*/Build/Products/Debug -name "mini-broker.app" 2>/dev/null | head -1)

    if [ -n "$APP_PATH" ]; then
        open "$APP_PATH"
        echo "✅ App launched successfully!"
        echo "📱 App path: $APP_PATH"
    else
        echo "❌ Could not find built app"
    fi
else
    echo "❌ Build failed"
    exit 1
fi
