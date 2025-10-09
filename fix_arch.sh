#!/bin/bash
# Fix architecture to x86_64
sed -i '' 's/ARCHS = .*/ARCHS = x86_64;/g' macos/Runner.xcodeproj/project.pbxproj
sed -i '' 's/"arm64"/"x86_64"/g' macos/Runner.xcodeproj/project.pbxproj
echo "✅ Fixed architecture to x86_64"
