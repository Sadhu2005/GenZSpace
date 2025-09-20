@echo off
REM GenZSpace Quick Deploy Script for Windows
REM This script provides quick deployment options for development and testing

setlocal enabledelayedexpansion

echo 🚀 GenZSpace Quick Deploy Script
echo ================================
echo.

REM Configuration
set FIREBASE_PROJECT=genzspace
set PACKAGE_NAME=com.anu.GenZSpace
set APP_ID=1:839050117776:android:ceadd7043e4cc3aafbce15

echo [INFO] Quick deployment options:
echo.
echo 1. Deploy Firebase services only
echo 2. Build and deploy Flutter app
echo 3. Deploy to Firebase App Distribution
echo 4. Deploy to Google Play Store Internal Testing
echo 5. Full deployment (all services)
echo 6. Test deployment (dry run)
echo 7. Exit
echo.

set /p choice="Enter your choice (1-7): "

if "%choice%"=="1" goto deploy_firebase
if "%choice%"=="2" goto build_flutter
if "%choice%"=="3" goto deploy_app_distribution
if "%choice%"=="4" goto deploy_play_store
if "%choice%"=="5" goto full_deployment
if "%choice%"=="6" goto test_deployment
if "%choice%"=="7" goto exit
goto invalid_choice

:deploy_firebase
echo [INFO] Deploying Firebase services...
firebase deploy --only firestore:rules,firestore:indexes,storage,hosting
if errorlevel 1 (
    echo [ERROR] Firebase deployment failed
    pause
    exit /b 1
)
echo [SUCCESS] Firebase services deployed successfully
goto end

:build_flutter
echo [INFO] Building Flutter app...
flutter clean
flutter pub get
flutter build apk --release
if errorlevel 1 (
    echo [ERROR] Flutter build failed
    pause
    exit /b 1
)
echo [SUCCESS] Flutter app built successfully
echo [INFO] APK location: build\app\outputs\flutter-apk\app-release.apk
goto end

:deploy_app_distribution
echo [INFO] Deploying to Firebase App Distribution...
if not exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo [ERROR] APK not found. Please build the app first.
    pause
    exit /b 1
)
firebase appdistribution:distribute build\app\outputs\flutter-apk\app-release.apk --app %APP_ID% --groups "internal,testers,beta" --release-notes "🚀 Quick deployment from local machine"
if errorlevel 1 (
    echo [ERROR] App Distribution deployment failed
    pause
    exit /b 1
)
echo [SUCCESS] App distributed to Firebase App Distribution
goto end

:deploy_play_store
echo [INFO] Deploying to Google Play Store Internal Testing...
if not exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo [ERROR] APK not found. Please build the app first.
    pause
    exit /b 1
)
if not exist "google-play-service-account.json" (
    echo [ERROR] Google Play service account file not found
    echo Please download it from Google Cloud Console
    pause
    exit /b 1
)
python scripts\upload-to-playstore.py --package-name %PACKAGE_NAME% --apk-path build\app\outputs\flutter-apk\app-release.apk --track internal --release-notes "Quick deployment from local machine"
if errorlevel 1 (
    echo [ERROR] Google Play Store deployment failed
    pause
    exit /b 1
)
echo [SUCCESS] App uploaded to Google Play Store Internal Testing
goto end

:full_deployment
echo [INFO] Starting full deployment...
echo [STEP 1] Deploying Firebase services...
firebase deploy --only firestore:rules,firestore:indexes,storage,hosting
if errorlevel 1 (
    echo [ERROR] Firebase deployment failed
    pause
    exit /b 1
)
echo [STEP 2] Building Flutter app...
flutter clean
flutter pub get
flutter build apk --release
if errorlevel 1 (
    echo [ERROR] Flutter build failed
    pause
    exit /b 1
)
echo [STEP 3] Deploying to Firebase App Distribution...
firebase appdistribution:distribute build\app\outputs\flutter-apk\app-release.apk --app %APP_ID% --groups "internal,testers,beta" --release-notes "🚀 Full deployment from local machine"
if errorlevel 1 (
    echo [WARNING] App Distribution deployment failed
)
echo [STEP 4] Deploying to Google Play Store...
if exist "google-play-service-account.json" (
    python scripts\upload-to-playstore.py --package-name %PACKAGE_NAME% --apk-path build\app\outputs\flutter-apk\app-release.apk --track internal --release-notes "Full deployment from local machine"
    if errorlevel 1 (
        echo [WARNING] Google Play Store deployment failed
    )
) else (
    echo [WARNING] Google Play service account not found, skipping Play Store deployment
)
echo [SUCCESS] Full deployment completed
goto end

:test_deployment
echo [INFO] Testing deployment configuration...
echo [TEST 1] Firebase project status...
firebase projects:list
echo [TEST 2] Firebase deployment dry run...
firebase deploy --dry-run
echo [TEST 3] Flutter environment...
flutter doctor
echo [TEST 4] Flutter dependencies...
flutter pub get
echo [SUCCESS] Deployment tests completed
goto end

:invalid_choice
echo [ERROR] Invalid choice. Please enter a number between 1-7.
pause
goto start

:end
echo.
echo [INFO] Deployment completed successfully!
echo.
echo [NEXT STEPS]
echo ============
echo.
echo 1. Check Firebase Console: https://console.firebase.google.com/project/%FIREBASE_PROJECT%
echo 2. Check Google Play Console: https://play.google.com/console/
echo 3. Test the deployed app with internal testers
echo 4. Monitor deployment status in GitHub Actions
echo.
pause

:exit
echo [INFO] Exiting quick deploy script
exit /b 0
