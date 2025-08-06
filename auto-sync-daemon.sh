#!/bin/bash
# Auto-sync daemon for Config.json - Production-ready automatic sync
# This runs in background and automatically syncs Config.json changes INSTANTLY

EXTERNAL_CONFIG="/Users/arezoughanekanafi/000/mini-broker/build/macos/Build/Products/Debug/Config.json"
ASSETS_CONFIG="/Users/arezoughanekanafi/000/mini-broker/assets/Config.json"

echo "🚀 Starting AUTOMATIC Config.json sync daemon..."
echo "📂 Watching: $EXTERNAL_CONFIG"
echo "🎯 Target: $ASSETS_CONFIG"
echo "⚡ Changes will be synced INSTANTLY when you save Config.json"
echo ""

# Function to sync files
sync_config() {
    if [ -f "$EXTERNAL_CONFIG" ]; then
        cp "$EXTERNAL_CONFIG" "$ASSETS_CONFIG"
        echo "✅ $(date '+%H:%M:%S') - INSTANT sync complete! Your changes are now live."
    else
        echo "❌ External Config.json not found!"
    fi
}

# Initial sync
sync_config

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    echo "� Installing fswatch for real-time file monitoring..."
    brew install fswatch
fi

echo "👀 AUTOMATIC file monitoring active - Config.json changes sync instantly!"
echo "🔥 Your production setup is ready! Edit Config.json and see changes immediately."
echo ""

# Use fswatch for INSTANT file change detection
fswatch -o "$EXTERNAL_CONFIG" | while read f; do
    sync_config
done
