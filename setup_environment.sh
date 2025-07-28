#!/bin/bash

echo "Setting up Android development environment..."
echo "=========================================="

# Set Java environment
export JAVA_HOME=/usr/lib/jvm/java-24-openjdk
export PATH=$JAVA_HOME/bin:$PATH

echo "Java version:"
java -version

echo ""
echo "Setting up Android SDK..."

# Create Android SDK directory
mkdir -p $HOME/Android/Sdk

# Set Android environment variables
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

echo "Android SDK path: $ANDROID_HOME"

# Add environment variables to shell profile
echo "" >> ~/.bashrc
echo "# Android SDK" >> ~/.bashrc
echo "export ANDROID_HOME=\$HOME/Android/Sdk" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_HOME/tools" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_HOME/platform-tools" >> ~/.bashrc
echo "" >> ~/.bashrc
echo "# Java" >> ~/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-24-openjdk" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc

echo ""
echo "Environment variables added to ~/.bashrc"
echo ""
echo "To complete setup:"
echo "1. Download Android Studio from: https://developer.android.com/studio"
echo "2. Install Android Studio and let it download the SDK"
echo "3. Or download command line tools from: https://developer.android.com/studio#command-tools"
echo ""
echo "After installing Android Studio/SDK, run:"
echo "source ~/.bashrc"
echo "./gradlew build" 