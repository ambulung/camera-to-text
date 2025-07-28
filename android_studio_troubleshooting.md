# Android Studio Troubleshooting Guide

## 🚨 Run Button Greyed Out - Solutions

### **Solution 1: Sync Project**
1. **Click "Sync Now"** in the notification bar at the top
2. **Or go to File → Sync Project with Gradle Files**
3. **Wait for sync to complete** (check the progress bar at the bottom)

### **Solution 2: Check SDK Installation**
1. **Go to File → Settings → Appearance & Behavior → System Settings → Android SDK**
2. **In SDK Platforms tab**, make sure you have:
   - Android 14.0 (API 34) or Android 13.0 (API 33)
   - Android 12.0 (API 31) or Android 11.0 (API 30)
3. **In SDK Tools tab**, make sure you have:
   - Android SDK Build-Tools
   - Android SDK Platform-Tools
   - Android SDK Tools

### **Solution 3: Invalidate Caches**
1. **Go to File → Invalidate Caches and Restart**
2. **Click "Invalidate and Restart"**
3. **Wait for Android Studio to restart**

### **Solution 4: Check Gradle Settings**
1. **Go to File → Settings → Build, Execution, Deployment → Gradle**
2. **Make sure "Use Gradle from"** is set to "Gradle Wrapper"
3. **Click "Apply" and "OK"**

### **Solution 5: Check Project Structure**
1. **Go to File → Project Structure**
2. **In Modules tab**, make sure:
   - Module name is "app"
   - Module SDK is set to "Android API 34 Platform"
3. **Click "Apply" and "OK"**

### **Solution 6: Manual Build**
If Android Studio still has issues, use the command line:
```bash
# In your project directory
./build_android.sh
```

## 🔧 Common Error Messages

### **"Gradle sync failed"**
- Check internet connection
- Try File → Invalidate Caches and Restart
- Check that all dependencies are available

### **"SDK not found"**
- Go to File → Settings → Appearance & Behavior → System Settings → Android SDK
- Install the required SDK versions

### **"Build tools not found"**
- In Android SDK settings, go to SDK Tools tab
- Install "Android SDK Build-Tools"

### **"Device not found"**
- Enable USB debugging on your Android device
- Connect device via USB
- Run `adb devices` to verify connection

## 📱 Device Connection

### **Enable Developer Options**
1. **Go to Settings → About phone**
2. **Tap "Build number" 7 times**
3. **Go back to Settings → Developer options**
4. **Enable "USB debugging"**

### **Connect Device**
1. **Connect device via USB**
2. **On device, tap "Allow USB debugging"**
3. **In Android Studio, your device should appear in the device dropdown**

## 🚀 Quick Fix Commands

If you're still having issues, try these commands in a new terminal:

```bash
# Navigate to project
cd /home/bruceu/Desktop/Projects/camera-to-text

# Make build script executable
chmod +x build_android.sh

# Run the build script
./build_android.sh
```

This will build your app and provide detailed error messages if something goes wrong. 