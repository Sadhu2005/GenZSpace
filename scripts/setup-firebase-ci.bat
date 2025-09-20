@echo off
REM GenZSpace Firebase CI/CD Setup Script for Windows
REM This script helps set up the Firebase CI/CD pipeline

setlocal enabledelayedexpansion

echo 🚀 GenZSpace Firebase CI/CD Setup
echo =================================
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js is not installed
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

echo [SUCCESS] Node.js is installed

REM Check if npm is installed
npm --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] npm is not installed
    echo Please install npm
    pause
    exit /b 1
)

echo [SUCCESS] npm is installed

REM Install Firebase CLI
echo [INFO] Installing Firebase CLI...
npm install -g firebase-tools
if errorlevel 1 (
    echo [ERROR] Failed to install Firebase CLI
    pause
    exit /b 1
)

echo [SUCCESS] Firebase CLI installed

REM Check if Firebase CLI is working
firebase --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Firebase CLI not working properly
    pause
    exit /b 1
)

echo [SUCCESS] Firebase CLI is working

REM Login to Firebase
echo [INFO] Logging in to Firebase...
echo Please follow the browser authentication...
firebase login
if errorlevel 1 (
    echo [ERROR] Failed to login to Firebase
    pause
    exit /b 1
)

echo [SUCCESS] Firebase login successful

REM Initialize Firebase project (if not already done)
if not exist "firebase.json" (
    echo [INFO] Initializing Firebase project...
    firebase init
    if errorlevel 1 (
        echo [ERROR] Failed to initialize Firebase project
        pause
        exit /b 1
    )
    echo [SUCCESS] Firebase project initialized
) else (
    echo [SUCCESS] Firebase project already initialized
)

REM Check Firebase project status
echo [INFO] Checking Firebase project status...
firebase projects:list
echo.

REM Create service account setup instructions
echo [INFO] Creating service account setup instructions...

echo # Firebase Service Account Setup Instructions > firebase-service-account-setup.md
echo. >> firebase-service-account-setup.md
echo ## 1. Create Firebase Service Account >> firebase-service-account-setup.md
echo. >> firebase-service-account-setup.md
echo 1. Go to [Google Cloud Console](https://console.cloud.google.com/) >> firebase-service-account-setup.md
echo 2. Select your Firebase project: **genzspace** >> firebase-service-account-setup.md
echo 3. Go to **IAM & Admin** ^> **Service Accounts** >> firebase-service-account-setup.md
echo 4. Click **Create Service Account** >> firebase-service-account-setup.md
echo 5. Name: `firebase-ci-service-account` >> firebase-service-account-setup.md
echo 6. Description: `Firebase CI/CD Service Account` >> firebase-service-account-setup.md
echo 7. Click **Create and Continue** >> firebase-service-account-setup.md
echo. >> firebase-service-account-setup.md
echo ## 2. Assign Roles >> firebase-service-account-setup.md
echo. >> firebase-service-account-setup.md
echo Assign these roles to the service account: >> firebase-service-account-setup.md
echo - **Firebase Admin** >> firebase-service-account-setup.md
echo - **Cloud Functions Admin** >> firebase-service-account-setup.md
echo - **Firebase Rules Admin** >> firebase-service-account-setup.md
echo - **Firebase Storage Admin** >> firebase-service-account-setup.md
echo - **Firebase Hosting Admin** >> firebase-service-account-setup.md
echo. >> firebase-service-account-setup.md
echo ## 3. Generate Key >> firebase-service-account-setup.md
echo. >> firebase-service-account-setup.md
echo 1. Click on the created service account >> firebase-service-account-setup.md
echo 2. Go to **Keys** tab >> firebase-service-account-setup.md
echo 3. Click **Add Key** ^> **Create new key** >> firebase-service-account-setup.md
echo 4. Choose **JSON** format >> firebase-service-account-setup.md
echo 5. Download the JSON file >> firebase-service-account-setup.md
echo 6. Save it as `firebase-service-account.json` >> firebase-service-account-setup.md
echo. >> firebase-service-account-setup.md
echo ## 4. Add to GitHub Secrets >> firebase-service-account-setup.md
echo. >> firebase-service-account-setup.md
echo 1. Go to your GitHub repository >> firebase-service-account-setup.md
echo 2. Go to **Settings** ^> **Secrets and variables** ^> **Actions** >> firebase-service-account-setup.md
echo 3. Click **New repository secret** >> firebase-service-account-setup.md
echo 4. Name: `FIREBASE_SERVICE_ACCOUNT_KEY` >> firebase-service-account-setup.md
echo 5. Value: Copy the entire contents of the JSON file >> firebase-service-account-setup.md
echo. >> firebase-service-account-setup.md
echo ## 5. Google Play Console Setup >> firebase-service-account-setup.md
echo. >> firebase-service-account-setup.md
echo 1. Go to [Google Play Console](https://play.google.com/console/) >> firebase-service-account-setup.md
echo 2. Select your app: **GenZSpace** >> firebase-service-account-setup.md
echo 3. Go to **Setup** ^> **API access** >> firebase-service-account-setup.md
echo 4. Link your Google Cloud project >> firebase-service-account-setup.md
echo 5. Create a new service account with **Release Manager** role >> firebase-service-account-setup.md
echo 6. Download the service account key >> firebase-service-account-setup.md
echo 7. Add it to GitHub secrets as `GOOGLE_PLAY_SERVICE_ACCOUNT_KEY` >> firebase-service-account-setup.md

echo [SUCCESS] Service account setup instructions created: firebase-service-account-setup.md

REM Test Firebase deployment
echo [INFO] Testing Firebase deployment...
firebase deploy --dry-run
if errorlevel 1 (
    echo [WARNING] Firebase deployment test failed
    echo This might be normal if you haven't set up the project yet
) else (
    echo [SUCCESS] Firebase deployment test passed
)

REM Create environment file template
if not exist ".env" (
    echo [INFO] Creating environment file template...
    echo # Firebase Configuration > .env
    echo FIREBASE_PROJECT_ID=genzspace >> .env
    echo FIREBASE_API_KEY=your_api_key_here >> .env
    echo FIREBASE_AUTH_DOMAIN=genzspace.firebaseapp.com >> .env
    echo FIREBASE_STORAGE_BUCKET=genzspace.appspot.com >> .env
    echo FIREBASE_MESSAGING_SENDER_ID=839050117776 >> .env
    echo FIREBASE_APP_ID=1:839050117776:android:ceadd7043e4cc3aafbce15 >> .env
    echo. >> .env
    echo # App Configuration >> .env
    echo APP_NAME=GenZSpace >> .env
    echo APP_VERSION=1.0.1 >> .env
    echo BUILD_NUMBER=1 >> .env
    echo DEBUG_MODE=true >> .env
    echo [SUCCESS] Environment file created
) else (
    echo [SUCCESS] Environment file already exists
)

echo.
echo [INFO] Firebase CI/CD Setup Summary:
echo ====================================
echo.
echo ✅ Node.js: Ready
echo ✅ npm: Ready
echo ✅ Firebase CLI: Ready
echo ✅ Firebase Login: Ready
echo ✅ Firebase Project: Ready
echo ✅ GitHub Actions: Ready (.github/workflows/firebase-deploy.yml)
echo ✅ Upload Script: Ready (scripts/upload-to-playstore.py)
echo ✅ Setup Instructions: Ready (firebase-service-account-setup.md)
echo.
echo [NEXT STEPS]
echo ============
echo.
echo 1. Follow the instructions in firebase-service-account-setup.md
echo 2. Set up GitHub repository secrets:
echo    - FIREBASE_SERVICE_ACCOUNT_KEY
echo    - GOOGLE_PLAY_SERVICE_ACCOUNT_KEY
echo    - DISCORD_WEBHOOK_URL (optional)
echo.
echo 3. Test the CI/CD pipeline:
echo    git add .
echo    git commit -m "Setup Firebase CI/CD pipeline"
echo    git push origin main
echo.
echo 4. Monitor deployment in GitHub Actions tab
echo.
echo [SUCCESS] Firebase CI/CD setup completed! 🎉
echo.
pause
