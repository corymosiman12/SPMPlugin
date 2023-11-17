#!/usr/bin/env bash

set -euo pipefail

TOOLCHAIN=com.apple.dt.toolchain.XcodeDefault
IOS_VERSION=${IOS_VERSION:-17.0.1}
SDK=${SDK:-iphonesimulator17.2}
BUILD_DIR="$(PWD)/.xcbuild"

SCHEME=SPMPluginXcode
PROJECT=ExampleXcode/SPMPluginXcode/SPMPluginXcode.xcodeproj
BUNDLE_PATH="$(PWD)/$SCHEME.xcresult"
DESTINATION="platform=iOS Simulator,OS=$IOS_VERSION,name=iPhone 12 Pro"
testArgs=( xcrun --toolchain "$TOOLCHAIN" \
        xcodebuild build \
        -toolchain "$TOOLCHAIN" \
        -project "$PROJECT" \
        -scheme "$SCHEME" \
        -sdk "$SDK" \
        -configuration Debug \
        -destination "$DESTINATION"  \
        -derivedDataPath "$BUILD_DIR" \
        -resultBundlePath "$BUNDLE_PATH" \
        -skipPackagePluginValidation \
        -disableAutomaticPackageResolution \
        -quiet
)
rm -rf "$BUILD_DIR"
rm -rf "$BUNDLE_PATH"
echo "Executing build command:"
echo ""
echo "${testArgs[@]}"
echo ""

"${testArgs[@]}"
