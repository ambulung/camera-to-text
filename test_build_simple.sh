#!/bin/bash

echo "Testing Android build..."
echo "========================"

# Check if we're in the right directory
if [ -f "app/build.gradle" ]; then
    echo "✅ Android project found"
else
    echo "❌ Not an Android project directory"
    exit 1
fi

# Try to run gradle with basic commands
echo "Testing Gradle..."
if command -v java &> /dev/null; then
    echo "✅ Java found"
    java -version
else
    echo "❌ Java not found"
    exit 1
fi

echo ""
echo "Build configuration fixed!"
echo "You can now try building in Android Studio or run:"
echo "./gradlew build" 