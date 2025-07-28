#!/bin/bash

echo "🔍 Verifying Android Project Structure"
echo "====================================="

# Check if we're in the right directory
if [ -f "app/build.gradle" ]; then
    echo "✅ Android project found"
else
    echo "❌ Not an Android project directory"
    exit 1
fi

# Check essential files
echo ""
echo "Checking essential files:"

if [ -f "build.gradle" ]; then
    echo "✅ Project build.gradle"
else
    echo "❌ Missing project build.gradle"
fi

if [ -f "settings.gradle" ]; then
    echo "✅ settings.gradle"
else
    echo "❌ Missing settings.gradle"
fi

if [ -f "app/src/main/AndroidManifest.xml" ]; then
    echo "✅ AndroidManifest.xml"
else
    echo "❌ Missing AndroidManifest.xml"
fi

if [ -f "app/src/main/java/com/example/cameratotext/MainActivity.kt" ]; then
    echo "✅ MainActivity.kt"
else
    echo "❌ Missing MainActivity.kt"
fi

if [ -f "app/src/main/res/layout/activity_main.xml" ]; then
    echo "✅ activity_main.xml"
else
    echo "❌ Missing activity_main.xml"
fi

echo ""
echo "🎉 Project structure verification complete!"
echo ""
echo "Next steps:"
echo "1. Install Android Studio"
echo "2. Open this project in Android Studio"
echo "3. Let Android Studio handle the build setup"
echo "4. Connect your Android device and run the app" 