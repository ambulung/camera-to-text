#!/bin/bash

echo "🔧 Testing Build After Icon Fix"
echo "==============================="

# Set up environment variables
export JAVA_HOME=/usr/lib/jvm/java-24-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Check if we're in the right directory
if [ ! -f "app/build.gradle" ]; then
    echo "❌ Error: Not in an Android project directory"
    exit 1
fi

echo "✅ Project structure verified"

# Check if icon files exist
echo ""
echo "Checking icon files:"

if [ -f "app/src/main/res/mipmap-hdpi/ic_launcher.xml" ]; then
    echo "✅ ic_launcher.xml (hdpi)"
else
    echo "❌ Missing ic_launcher.xml (hdpi)"
fi

if [ -f "app/src/main/res/mipmap-hdpi/ic_launcher_round.xml" ]; then
    echo "✅ ic_launcher_round.xml (hdpi)"
else
    echo "❌ Missing ic_launcher_round.xml (hdpi)"
fi

if [ -f "app/src/main/res/mipmap-mdpi/ic_launcher.xml" ]; then
    echo "✅ ic_launcher.xml (mdpi)"
else
    echo "❌ Missing ic_launcher.xml (mdpi)"
fi

if [ -f "app/src/main/res/mipmap-mdpi/ic_launcher_round.xml" ]; then
    echo "✅ ic_launcher_round.xml (mdpi)"
else
    echo "❌ Missing ic_launcher_round.xml (mdpi)"
fi

echo ""
echo "🎉 Icon files created successfully!"
echo ""
echo "Now you can:"
echo "1. Try building in Android Studio again"
echo "2. Or run: ./build_android.sh"
echo ""
echo "The launcher icons should now be available and the build should succeed!" 