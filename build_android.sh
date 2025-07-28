#!/bin/bash

echo "🚀 Building Android App"
echo "======================"

# Set up environment variables
export JAVA_HOME=/usr/lib/jvm/java-24-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Check if we're in the right directory
if [ ! -f "app/build.gradle" ]; then
    echo "❌ Error: Not in an Android project directory"
    exit 1
fi

echo "✅ Project structure verified"

# Check Java
if command -v java &> /dev/null; then
    echo "✅ Java found: $(java -version 2>&1 | head -n 1)"
else
    echo "❌ Java not found"
    exit 1
fi

# Check if gradlew exists and is executable
if [ -f "gradlew" ]; then
    echo "✅ Gradle wrapper found"
    chmod +x gradlew
else
    echo "❌ Gradle wrapper not found"
    exit 1
fi

echo ""
echo "🔄 Starting build process..."

# Try to build the project
echo "Step 1: Cleaning project..."
./gradlew clean

echo "Step 2: Building project..."
./gradlew build

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Build successful!"
    echo "APK location: app/build/outputs/apk/debug/app-debug.apk"
    echo ""
    echo "To install on a connected device:"
    echo "./gradlew installDebug"
    echo ""
    echo "To run the app:"
    echo "1. Connect your Android device with USB debugging enabled"
    echo "2. Run: ./gradlew installDebug"
    echo "3. The app will be installed and launched automatically"
else
    echo ""
    echo "❌ Build failed!"
    echo ""
    echo "Troubleshooting tips:"
    echo "1. Make sure you have Android SDK installed"
    echo "2. Check that your device is connected and USB debugging is enabled"
    echo "3. Try running: adb devices"
    echo "4. If using Android Studio, try File → Invalidate Caches and Restart"
fi 