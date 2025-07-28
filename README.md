# Camera to Text - Android App

A modern Android application that captures text from camera images and allows users to select and copy specific text portions.

## Features

- **Real-time Camera Preview**: Live camera feed with instant text recognition
- **Text Recognition**: Uses Google ML Kit for accurate text detection in multiple languages
- **Text Selection**: Tap on specific text elements to select them
- **Copy to Clipboard**: Copy selected text or entire recognized text
- **Modern UI**: Material Design 3 with beautiful animations and transitions
- **Permission Handling**: Proper camera permission requests and handling

## How to Use

1. **Launch the App**: Open the app and grant camera permissions when prompted
2. **Point Camera at Text**: Direct your camera at any text (documents, signs, books, etc.)
3. **Capture Text**: Tap the "Capture Text" button to take a photo and recognize text
4. **Select Text**: 
   - Tap "Select Text" to enter selection mode
   - Tap on any text element to select it (highlighted in green)
   - Tap "Clear Selection" to exit selection mode
5. **Copy Text**: 
   - Tap "Copy Text" to copy the selected text (or entire text if nothing is selected)
   - A confirmation toast will appear

## Technical Details

### Dependencies
- **CameraX**: For camera functionality and image capture
- **ML Kit Text Recognition**: For OCR (Optical Character Recognition)
- **Material Design 3**: For modern UI components
- **ViewBinding**: For type-safe view access

### Architecture
- **MainActivity**: Handles camera setup, text recognition, and UI interactions
- **TextSelectionOverlayView**: Custom view for text selection visualization
- **Permission Handling**: Runtime permissions for camera access

### Supported Languages
The app supports text recognition in multiple languages including:
- English
- Chinese
- Japanese
- Korean
- Devanagari (Hindi, etc.)

## Building the App

### Prerequisites
- Android Studio Arctic Fox or later
- Android SDK 24+ (API level 24)
- Gradle 7.0+

### Build Steps
1. Clone or download the project
2. Open the project in Android Studio
3. Sync Gradle files
4. Connect an Android device or start an emulator
5. Click "Run" or press Shift+F10

### Gradle Configuration
The app uses the following key configurations:
- `compileSdk 34`: Latest Android SDK
- `minSdk 24`: Supports Android 7.0+
- `targetSdk 34`: Targets latest Android features

## Permissions

The app requires the following permissions:
- `CAMERA`: To capture images for text recognition
- `INTERNET`: For ML Kit text recognition (downloads models if needed)

## Troubleshooting

### Common Issues
1. **Camera not working**: Ensure camera permissions are granted
2. **Text not recognized**: Try improving lighting or focusing the camera better
3. **App crashes**: Check that you're using a supported Android version (7.0+)

### Performance Tips
- Ensure good lighting for better text recognition
- Hold the camera steady when capturing
- For small text, try getting closer to the text

## License

This project is open source and available under the MIT License.

## Contributing

Feel free to submit issues and enhancement requests! 