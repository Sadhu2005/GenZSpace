@echo off
REM GenZSpace CI/CD Issues Fix Script
REM This script helps fix the CI/CD pipeline issues

setlocal enabledelayedexpansion

echo 🔧 GenZSpace CI/CD Issues Fix Script
echo ====================================
echo.

echo [INFO] Current CI/CD Issues:
echo ============================
echo.
echo ✅ Firebase App Distribution: WORKING
echo ❌ Google Play Store Upload: FAILED - "Package not found"
echo ⚠️  Android SDK Version: WARNINGS (Fixed)
echo ⚠️  Firebase Token: DEPRECATION WARNING (Fixed)
echo.

echo [SOLUTIONS]
echo ===========
echo.

echo 1. Google Play Store Issue:
echo    - The app "com.anu.GenZSpace" is not registered in Google Play Console
echo    - You need to create the app in Google Play Console first
echo.

echo 2. Missing GitHub Secrets:
echo    - FIREBASE_APP_ID: 1:839050117776:android:ceadd7043e4cc3aafbce15
echo    - FIREBASE_SERVICE_ACCOUNT_KEY: (Your Firebase service account JSON)
echo    - GOOGLE_PLAY_SERVICE_ACCOUNT_KEY: (Your Google Play service account JSON)
echo    - DISCORD_WEBHOOK_URL: (Optional - for notifications)
echo.

echo [STEP 1] Fix Google Play Console
echo ================================
echo.
echo 1. Go to Google Play Console: https://play.google.com/console/
echo 2. Click "Create app"
echo 3. Fill in the details:
echo    - App name: GenZSpace
echo    - Default language: English
echo    - App or game: App
echo    - Free or paid: Free
echo    - Declarations: Check all required boxes
echo 4. Click "Create app"
echo 5. Complete the app setup wizard
echo 6. Go to "Setup" → "App integrity"
echo 7. Upload your signing key (if you have one)
echo.

echo [STEP 2] Set up GitHub Secrets
echo ==============================
echo.
echo 1. Go to your GitHub repository
echo 2. Go to Settings → Secrets and variables → Actions
echo 3. Add these secrets:
echo.

echo Secret: FIREBASE_APP_ID
echo Value: 1:839050117776:android:ceadd7043e4cc3aafbce15
echo.

echo Secret: FIREBASE_SERVICE_ACCOUNT_KEY
echo Value: [Your Firebase service account JSON content]
echo.

echo Secret: GOOGLE_PLAY_SERVICE_ACCOUNT_KEY
echo Value: [Your Google Play service account JSON content]
echo.

echo [STEP 3] Create Google Play Service Account
echo ===========================================
echo.
echo 1. Go to Google Cloud Console: https://console.cloud.google.com/
echo 2. Select your project (genzspace)
echo 3. Go to IAM & Admin → Service Accounts
echo 4. Click "Create Service Account"
echo 5. Name: play-store-ci-service-account
echo 6. Description: Google Play Store CI/CD Service Account
echo 7. Click "Create and Continue"
echo 8. Assign role: "Release Manager"
echo 9. Click "Done"
echo 10. Click on the created service account
echo 11. Go to "Keys" tab
echo 12. Click "Add Key" → "Create new key"
echo 13. Choose "JSON" format
echo 14. Download the JSON file
echo 15. Add the content to GitHub secret: GOOGLE_PLAY_SERVICE_ACCOUNT_KEY
echo.

echo [STEP 4] Link Google Play Console to Google Cloud
echo ================================================
echo.
echo 1. Go to Google Play Console: https://play.google.com/console/
echo 2. Select your GenZSpace app
echo 3. Go to Setup → API access
echo 4. Click "Link Google Cloud project"
echo 5. Select your genzspace project
echo 6. Accept the terms
echo 7. Go back to "API access"
echo 8. Find your service account
echo 9. Click "Grant access"
echo 10. Assign "Release Manager" role
echo 11. Click "Invite user"
echo.

echo [STEP 5] Test the Pipeline
echo ==========================
echo.
echo 1. Make a small change to your code
echo 2. Commit and push:
echo    git add .
echo    git commit -m "Fix CI/CD pipeline issues"
echo    git push origin main
echo 3. Go to GitHub Actions tab to monitor the deployment
echo.

echo [CURRENT STATUS]
echo ================
echo.
echo ✅ Firebase App Distribution: WORKING
echo ✅ Android SDK Version: FIXED (SDK 35, NDK 27)
echo ✅ Firebase Token Deprecation: FIXED (Using service account)
echo ❌ Google Play Store: NEEDS SETUP
echo ❌ GitHub Secrets: NEEDS CONFIGURATION
echo.

echo [NEXT ACTIONS]
echo ==============
echo.
echo 1. Set up Google Play Console app (Priority 1)
echo 2. Configure GitHub secrets (Priority 2)
echo 3. Test the complete pipeline (Priority 3)
echo.

echo [SUCCESS METRICS]
echo =================
echo.
echo When everything is working, you should see:
echo ✅ Firebase App Distribution: APK distributed to testers
echo ✅ Google Play Store: APK uploaded to internal testing
echo ✅ Website: Updated automatically
echo ✅ Notifications: Discord/Slack messages sent
echo ✅ GitHub Release: Automatic release created
echo.

echo [SUPPORT]
echo =========
echo.
echo If you need help:
echo 1. Check the logs in GitHub Actions
echo 2. Verify all secrets are set correctly
echo 3. Ensure Google Play Console app is created
echo 4. Contact: hello@zengspace.in
echo.

echo [INFO] CI/CD Issues Fix Guide completed! 🎉
echo.
pause
