#!/bin/bash

APP_NAME="EthernetNotifier"
APP_BUNDLE="${APP_NAME}.app"
CONTENTS_DIR="${APP_BUNDLE}/Contents"
MACOS_DIR="${CONTENTS_DIR}/MacOS"
SWIFT_FILE="${APP_NAME}.swift"

echo "🔍 Starting build process for ${APP_NAME}..."

if [ ! -f "$SWIFT_FILE" ]; then
    echo "❌ Error: Cannot find '${SWIFT_FILE}' in the current directory."
    exit 1
fi

echo "🔨 Compiling Swift code..."
# Added -parse-as-library to handle the @main attribute correctly
echo "▶ Running: swiftc -parse-as-library \"${SWIFT_FILE}\" -o \"${APP_NAME}\""
swiftc -parse-as-library "${SWIFT_FILE}" -o "${APP_NAME}"

if [ $? -ne 0 ]; then
    echo "❌ Compilation failed."
    exit 1
fi

echo "📁 Creating App Bundle..."
mkdir -p "${MACOS_DIR}"
mv "${APP_NAME}" "${MACOS_DIR}/"

echo "📝 Generating Info.plist..."
cat << EOF > "${CONTENTS_DIR}/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>${APP_NAME}</string>
    <key>CFBundleIdentifier</key>
    <string>com.local.${APP_NAME}</string>
    <key>CFBundleName</key>
    <string>${APP_NAME}</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>LSUIElement</key>
    <true/>
</dict>
</plist>
EOF

echo "🔑 Signing application bundle..."
codesign --force --deep --sign - "${APP_BUNDLE}"

if [ $? -ne 0 ]; then
    echo "❌ Codesigning failed."
    exit 1
fi

echo "✅ Build complete! Run with: open ${APP_BUNDLE}"