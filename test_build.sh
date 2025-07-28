#!/bin/bash

echo "Testing Android build environment..."
echo "=================================="

# Check Java
echo "Checking Java..."
if command -v java &> /dev/null; then
    echo "✅ Java found:"
    java -version
else
    echo "❌ Java not found"
    exit 1
fi

# Check if we're in the right directory
echo ""
echo "Checking project structure..."
if [ -f "app/build.gradle" ]; then
    echo "✅ Android project found"
else
    echo "❌ Not an Android project directory"
    exit 1
fi

# Check gradlew
echo ""
echo "Checking Gradle wrapper..."
if [ -f "gradlew" ]; then
    echo "✅ Gradle wrapper found"
    chmod +x gradlew
else
    echo "❌ Gradle wrapper not found"
    exit 1
fi

# Try a simple gradle task
echo ""
echo "Testing Gradle..."
./gradlew --version

echo ""
echo "If everything above looks good, try:"
echo "./gradlew build" 