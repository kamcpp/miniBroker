#!/bin/bash
# Auto-sync script for Config.json during development
# This script watches your external Config.json and automatically copies it to Resources

EXTERNAL_CONFIG="/Users/arezoughanekanafi/000/mini-broker/build/macos/Build/Products/Debug/Config.json"
RESOURCES_CONFIG="/Users/arezoughanekanafi/000/mini-broker/build/macos/Build/Products/Debug/FIXYL Quick.app/Contents/Resources/Config.json"

echo "🔄 Starting Config.json auto-sync..."
echo "📂 Watching: $EXTERNAL_CONFIG"
echo "🎯 Target: $RESOURCES_CONFIG"
echo "📝 Edit your Config.json - changes will be auto-synced!"
echo ""

# Function to sync files
sync_config() {
    if [ -f "$EXTERNAL_CONFIG" ]; then
        cp "$EXTERNAL_CONFIG" "$RESOURCES_CONFIG"
        echo "✅ $(date '+%H:%M:%S') - Config.json synced to Resources"
    else
        echo "❌ External Config.json not found!"
    fi
}

# Initial sync
sync_config

# Watch for changes (requires fswatch: brew install fswatch)
if command -v fswatch >/dev/null 2>&1; then
    echo "👀 Watching for changes... (Press Ctrl+C to stop)"
    fswatch -o "$EXTERNAL_CONFIG" | while read num; do
        sync_config
    done
else
    echo "📦 Install fswatch for auto-sync: brew install fswatch"
    echo "🔄 For now, run this script again after making changes"
fi
