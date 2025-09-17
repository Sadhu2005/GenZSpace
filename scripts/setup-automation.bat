@echo off
echo 🚀 GenZSpace Complete Automation Setup
echo =====================================
echo.

echo 📱 Setting up complete automation pipeline...
echo.

echo 1. 📦 Installing dependencies...
flutter pub get
echo.

echo 2. 🔍 Running code analysis...
flutter analyze
echo.

echo 3. 🧪 Running tests...
flutter test
echo.

echo 4. 🏗️ Building app...
flutter build apk --release
echo.

echo ✅ Setup complete!
echo.
echo 📋 Next Steps:
echo 1. Set up Google Play Console (see COMPLETE_AUTOMATION_SETUP.md)
echo 2. Add GOOGLE_PLAY_SERVICE_ACCOUNT_JSON to GitHub Secrets
echo 3. Push your changes to trigger the automation pipeline
echo 4. Install the app from Play Store Internal Testing
echo 5. Enjoy automatic updates! 🎉
echo.
echo 📖 Read COMPLETE_AUTOMATION_SETUP.md for detailed instructions
echo.
pause
