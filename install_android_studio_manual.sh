#!/bin/bash

echo "🚀 Installing Android Studio from downloaded file..."
echo "=================================================="

# Check if we're in the right directory
if [ ! -f "app/build.gradle" ]; then
    echo "❌ Error: Not in an Android project directory"
    echo "Please run this script from your camera-to-text project directory"
    exit 1
fi

# Set up environment variables
export JAVA_HOME=/usr/lib/jvm/java-24-openjdk
export PATH=$JAVA_HOME/bin:$PATH

echo "✅ Java environment set up"
echo "Java version: $(java -version 2>&1 | head -n 1)"

# Check if the Android Studio file exists in Downloads
DOWNLOAD_FILE="$HOME/Downloads/android-studio-2025.1.1.14-linux.tar.gz"
ANDROID_STUDIO_DIR="$HOME/android-studio"

if [ ! -f "$DOWNLOAD_FILE" ]; then
    echo "❌ Android Studio file not found at: $DOWNLOAD_FILE"
    echo "Please make sure the file is in your Downloads folder"
    exit 1
fi

echo "✅ Found Android Studio file: $DOWNLOAD_FILE"

# Create installation directory
echo "📁 Creating installation directory..."
mkdir -p "$ANDROID_STUDIO_DIR"

# Extract Android Studio
echo "📦 Extracting Android Studio..."
cd "$HOME/Downloads"
tar -xzf android-studio-2025.1.1.14-linux.tar.gz

if [ $? -eq 0 ]; then
    echo "✅ Extraction completed!"
    
    # Move to final location
    if [ -d "android-studio" ]; then
        mv android-studio/* "$ANDROID_STUDIO_DIR/"
        rmdir android-studio
        echo "✅ Android Studio installed to: $ANDROID_STUDIO_DIR"
    else
        echo "❌ Extraction directory not found"
        exit 1
    fi
else
    echo "❌ Extraction failed!"
    exit 1
fi

# Create desktop shortcut
echo "🔗 Creating desktop shortcut..."
cat > "$HOME/.local/share/applications/android-studio.desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
Comment=Android Development Environment
Exec=$ANDROID_STUDIO_DIR/bin/studio.sh
Icon=$ANDROID_STUDIO_DIR/bin/studio.svg
Terminal=false
Categories=Development;IDE;
EOF

# Make the launcher executable
chmod +x "$HOME/.local/share/applications/android-studio.desktop"

# Set up environment variables
echo "🔧 Setting up environment variables..."
echo "" >> ~/.bashrc
echo "# Android Studio" >> ~/.bashrc
echo "export ANDROID_HOME=\$HOME/Android/Sdk" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_HOME/tools" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_HOME/platform-tools" >> ~/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-24-openjdk" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc

# Also add to fish config if fish is being used
if [ -f ~/.config/fish/config.fish ]; then
    echo "" >> ~/.config/fish/config.fish
    echo "# Android Studio" >> ~/.config/fish/config.fish
    echo "set -x ANDROID_HOME \$HOME/Android/Sdk" >> ~/.config/fish/config.fish
    echo "set -x PATH \$PATH \$ANDROID_HOME/tools" >> ~/.config/fish/config.fish
    echo "set -x PATH \$PATH \$ANDROID_HOME/platform-tools" >> ~/.config/fish/config.fish
    echo "set -x JAVA_HOME /usr/lib/jvm/java-24-openjdk" >> ~/.config/fish/config.fish
    echo "set -x PATH \$JAVA_HOME/bin \$PATH" >> ~/.config/fish/config.fish
fi

echo ""
echo "🎉 Android Studio installation completed!"
echo ""
echo "📋 Next steps:"
echo "1. Launch Android Studio: $ANDROID_STUDIO_DIR/bin/studio.sh"
echo "2. Open your project: $PWD"
echo "3. Let Android Studio download SDK components"
echo "4. Connect an Android device or create an emulator"
echo "5. Build and run your app!"
echo ""
echo "💡 You can also find Android Studio in your applications menu"
echo ""
echo "🔧 Environment variables have been added to your shell configuration"
echo "   Please restart your terminal or run: source ~/.bashrc" 