@echo off
echo 🔐 Setting up GitHub Secrets for CI/CD
echo.

echo 📱 Step 3: GitHub Secrets Configuration
echo ======================================
echo.
echo 1. Go to your GitHub repository:
echo    https://github.com/Sadhu2005/GenZSpace
echo.
echo 2. Go to "Settings" → "Secrets and variables" → "Actions"
echo.
echo 3. Add these secrets (click "New repository secret"):
echo.
echo    Secret 1: FIREBASE_APP_ID
echo    Name: FIREBASE_APP_ID
echo    Value: 1:839050117776:android:ceadd7043e4cc3aafbce15
echo.
echo    Secret 2: FIREBASE_SERVICE_ACCOUNT_KEY
echo    Name: FIREBASE_SERVICE_ACCOUNT_KEY
echo    Value: [Copy entire content of your Firebase service account JSON file]
echo.
echo    Secret 3: GOOGLE_PLAY_SERVICE_ACCOUNT_JSON
echo    Name: GOOGLE_PLAY_SERVICE_ACCOUNT_JSON
echo    Value: [Copy entire content of your Google Cloud service account JSON file]
echo.
echo    Secret 4: DISCORD_WEBHOOK_URL (Optional)
echo    Name: DISCORD_WEBHOOK_URL
echo    Value: [Your Discord webhook URL for notifications]
echo.
echo 4. To get Firebase Service Account Key:
echo    - Go to Firebase Console → Project Settings → Service Accounts
echo    - Click "Generate new private key"
echo    - Download the JSON file
echo    - Copy entire content to FIREBASE_SERVICE_ACCOUNT_KEY secret
echo.
echo 5. To get Google Play Service Account Key:
echo    - Use the JSON file you downloaded in Step 2
echo    - Copy entire content to GOOGLE_PLAY_SERVICE_ACCOUNT_JSON secret
echo.
pause
echo.
echo ✅ GitHub Secrets setup complete!
echo.
echo 📋 Next: Run test-cicd-pipeline.bat
echo.
