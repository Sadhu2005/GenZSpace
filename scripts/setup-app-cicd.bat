@echo off
echo.
echo ========================================
echo    📱 App CI/CD Setup Guide
echo ========================================
echo.

echo 📋 Step 1: Create Google Cloud Service Account
echo.
echo 1. Go to https://console.cloud.google.com
echo 2. Select your project (same as Play Console)
echo 3. Go to IAM & Admin → Service Accounts
echo 4. Click "Create Service Account"
echo 5. Name: genzspace-ci-cd
echo 6. Description: Service account for GenZSpace CI/CD
echo 7. Click "Create and Continue"
echo.

pause

echo.
echo 📋 Step 2: Grant Permissions
echo.
echo Add these roles to your service account:
echo - Service Account User
echo - Storage Object Viewer (if using Firebase)
echo.

pause

echo.
echo 📋 Step 3: Create JSON Key
echo.
echo 1. Click on your service account
echo 2. Go to "Keys" tab
echo 3. Click "Add Key" → "Create new key"
echo 4. Select "JSON" format
echo 5. Download the JSON file
echo 6. Keep it secure - this is your private key
echo.

pause

echo.
echo 📋 Step 4: Link to Play Console
echo.
echo 1. Go to https://play.google.com/console
echo 2. Go to Setup → API access
echo 3. Click "Link project" if not already linked
echo 4. Grant access to your service account
echo 5. Enable "Release apps to testing tracks" permission
echo.

pause

echo.
echo 📋 Step 5: Add GitHub Secret
echo.
echo 1. Go to your GitHub repository
echo 2. Settings → Secrets and variables → Actions
echo 3. Click "New repository secret"
echo 4. Name: GOOGLE_PLAY_SERVICE_ACCOUNT_JSON
echo 5. Value: Copy the entire content of your JSON file
echo 6. Click "Add secret"
echo.

pause

echo.
echo 📋 Step 6: Test the Setup
echo.
echo 1. Make a small change to lib/main.dart
echo 2. Commit and push to GitHub
echo 3. Check Actions tab for "📱 Deploy App to Google Play Store"
echo 4. Wait for completion (5-10 minutes)
echo 5. Check Google Play Console for new build
echo 6. Update app on your phone
echo.

echo.
echo ✅ App CI/CD setup complete!
echo.
echo Your app will now:
echo - Build automatically on every push
echo - Upload to Google Play Store Internal Testing
echo - Update on your phone without reinstalling
echo - Allow you to test new features immediately
echo.

pause
