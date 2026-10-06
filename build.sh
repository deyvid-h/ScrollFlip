#!/bin/bash
# Builds ScrollToggle.app and installs it in /Applications.
# Run from the folder containing ScrollToggle.swift:  bash build.sh
set -e

APP="ScrollToggle.app"
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS"

swiftc -O ScrollToggle.swift -o "$APP/Contents/MacOS/ScrollToggle"

cat > "$APP/Contents/Info.plist" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleName</key>            <string>ScrollToggle</string>
    <key>CFBundleIdentifier</key>      <string>local.scrolltoggle</string>
    <key>CFBundleExecutable</key>      <string>ScrollToggle</string>
    <key>CFBundlePackageType</key>     <string>APPL</string>
    <key>CFBundleVersion</key>         <string>1.0</string>
    <key>LSUIElement</key>             <true/>
</dict>
</plist>
EOF

rm -rf "/Applications/$APP"
mv "$APP" /Applications/
open "/Applications/$APP"
echo "Installed. Look for the trackpad/mouse icon in your menu bar."
