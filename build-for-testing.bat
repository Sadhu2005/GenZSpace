@echo off
echo 🚀 GenZSpace - Build for Testing
echo =================================

echo 📦 Getting dependencies...
flutter pub get

echo 🏗️ Building APK for testing...
flutter build apk --release

echo 🔍 Finding APK file...
if exist "android\app\build\outputs\apk\release\app-release.apk" (
    echo ✅ APK found: android\app\build\outputs\apk\release\app-release.apk
    echo 📱 Copy this file to your phone and install it
    echo.
    echo 📋 Installation steps:
    echo 1. Copy the APK file to your phone
    echo 2. Enable "Install from unknown sources" in Android settings
    echo 3. Open the APK file on your phone
    echo 4. Install the app
    echo.
    echo 🎉 Ready for testing!
) else (
    echo ❌ APK not found in expected location
    echo 🔍 Searching for APK files...
    dir /s *.apk
)

echo.
echo 📱 Your app is ready for phone testing!
pause
