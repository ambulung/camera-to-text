# 🚀 Setup Guide for Camera-to-Text App

After cloning this repository, follow these steps to get the app running:

## 📋 Prerequisites

### 1. Install Android Studio
```bash
# Download and install Android Studio
# https://developer.android.com/studio
```

### 2. Install Java Development Kit (JDK)
```bash
# On Arch Linux:
sudo pacman -S jdk-openjdk

# On Ubuntu/Debian:
sudo apt install openjdk-17-jdk

# On macOS:
brew install openjdk@17
```

## 🔧 Setup Steps

### 1. Open Project in Android Studio
```bash
# Navigate to the cloned directory
cd camera-to-text

# Open Android Studio and select "Open an existing project"
# Choose the camera-to-text folder
```

### 2. Let Android Studio Sync
- Android Studio will automatically download Gradle and sync dependencies
- This may take 5-10 minutes on first run
- You'll see progress in the bottom status bar

### 3. Set up Android SDK (if needed)
- Android Studio will prompt you to download SDK components
- Accept and let it install:
  - Android SDK Platform 34
  - Android SDK Build-Tools
  - Android Emulator (if you want to test on virtual device)

## 📱 Running the App

### Option 1: Physical Android Device
1. **Enable Developer Options** on your Android device:
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
   - Go back to Settings → Developer Options
   - Enable "USB Debugging"

2. **Connect your device** via USB

3. **Click the green "Run" button** in Android Studio

### Option 2: Android Emulator
1. **Create a Virtual Device** in Android Studio:
   - Tools → AVD Manager
   - Create Virtual Device
   - Choose a phone (e.g., Pixel 7)
   - Download and select a system image (API 34 recommended)

2. **Start the emulator** and click "Run"

## 🛠️ Troubleshooting

### If you get build errors:
```bash
# Clean and rebuild
./gradlew clean
./gradlew build
```

### If Android Studio can't find SDK:
- Go to File → Project Structure
- Set Android SDK location (usually `/opt/android-sdk` on Linux)

### If Gradle sync fails:
- File → Invalidate Caches and Restart
- Try again after restart

## 📦 What Gets Downloaded Automatically

Unlike `npm install`, Android Studio handles:
- ✅ **Gradle** (build system)
- ✅ **Android SDK** (development tools)
- ✅ **Dependencies** (CameraX, ML Kit, Material Design)
- ✅ **Build tools** (compilers, etc.)

## 🎯 Quick Start Commands

```bash
# Clone the repository
git clone https://github.com/ambulung/camera-to-text.git
cd camera-to-text

# Open in Android Studio
android-studio .

# Or build from command line (if you have Android SDK set up)
./gradlew assembleDebug
```

## 📱 App Features

Once running, you'll have:
- 📷 **Camera Preview** - Point camera at text
- 🔍 **Text Recognition** - Automatic OCR
- ✋ **Text Selection** - Tap to select text blocks
- 📋 **Copy to Clipboard** - One-tap copying
- 🎨 **Modern UI** - Material Design 3

## 🆘 Need Help?

- Check the main [README.md](README.md) for detailed features
- Open an issue on GitHub if you encounter problems
- Make sure you have a good internet connection for first-time setup

---

**No `npm install` needed!** Android projects use Gradle for dependency management, which Android Studio handles automatically. 🎉 