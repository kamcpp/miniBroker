#!/bin/bash

# Script to convert the miniBroker logo to macOS app icon sizes
# Usage: Place your logo as 'logo.png' in the same directory as this script, then run it

# Check if logo.png exists
if [ ! -f "logo.png" ]; then
    echo "Error: logo.png not found. Please place your miniBroker logo as 'logo.png' in this directory."
    exit 1
fi

# Create the icon directory if it doesn't exist
ICON_DIR="macos/Runner/Assets.xcassets/AppIcon.appiconset"
mkdir -p "$ICON_DIR"

echo "Converting logo to macOS app icon sizes..."

# Convert to different sizes using sips
sips -z 16 16 logo.png --out "$ICON_DIR/app_icon_16.png"
sips -z 32 32 logo.png --out "$ICON_DIR/app_icon_32.png"
sips -z 64 64 logo.png --out "$ICON_DIR/app_icon_64.png"
sips -z 128 128 logo.png --out "$ICON_DIR/app_icon_128.png"
sips -z 256 256 logo.png --out "$ICON_DIR/app_icon_256.png"
sips -z 512 512 logo.png --out "$ICON_DIR/app_icon_512.png"
sips -z 1024 1024 logo.png --out "$ICON_DIR/app_icon_1024.png"

echo "Icon conversion complete!"
echo "All icon files have been generated in $ICON_DIR"
echo ""
echo "Next steps:"
echo "1. Run 'flutter clean' to clear the build cache"
echo "2. Run 'flutter build macos --debug' to rebuild with new icons"
