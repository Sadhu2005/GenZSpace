@echo off
REM GenZSpace Environment Setup Script for Windows
REM This script helps set up environment variables and configuration files

echo 🚀 Setting up GenZSpace environment...

REM Create .env file if it doesn't exist
if not exist .env (
    echo 📝 Creating .env file from template...
    copy env.example .env
    echo ✅ .env file created! Please edit it with your actual values.
) else (
    echo ⚠️ .env file already exists. Skipping creation.
)

REM Create secrets.dart file if it doesn't exist
if not exist lib\config\secrets.dart (
    echo 📝 Creating secrets.dart file from template...
    copy lib\config\secrets_template.dart lib\config\secrets.dart
    echo ✅ secrets.dart file created! Please edit it with your actual values.
) else (
    echo ⚠️ secrets.dart file already exists. Skipping creation.
)

REM Check if Firebase files exist
if not exist android\app\google-services.json (
    echo ⚠️ android\app\google-services.json not found!
    echo    Please download it from Firebase Console and place it in android\app\
)

if not exist ios\Runner\GoogleService-Info.plist (
    echo ⚠️ ios\Runner\GoogleService-Info.plist not found!
    echo    Please download it from Firebase Console and place it in ios\Runner\
)

echo.
echo 🔧 Next steps:
echo 1. Edit .env file with your Firebase API keys
echo 2. Edit lib\config\secrets.dart with your actual values
echo 3. Download Firebase configuration files:
echo    - android\app\google-services.json
echo    - ios\Runner\GoogleService-Info.plist
echo 4. Run 'flutter pub get' to install dependencies
echo 5. Run 'flutter run' to start the app
echo.
echo 🔐 Security reminder:
echo    - Never commit .env or secrets.dart to Git
echo    - These files are already in .gitignore
echo.
echo ✅ Setup complete!
pause
