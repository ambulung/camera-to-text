#!/bin/bash

echo "Building Camera to Text Android App..."
echo "======================================"

# Check if Android SDK is available
if [ -z "$ANDROID_HOME" ]; then
    echo "Warning: ANDROID_HOME is not set. Make sure Android SDK is installed."
fi

# Clean and build the project
echo "Cleaning project..."
./gradlew clean

echo "Building project..."
./gradlew build

if [ $? -eq 0 ]; then
    echo "Build successful!"
    echo "APK location: app/build/outputs/apk/debug/app-debug.apk"
    echo ""
    echo "To install on a connected device:"
    echo "./gradlew installDebug"
else
    echo "Build failed!"
    exit 1
fi 