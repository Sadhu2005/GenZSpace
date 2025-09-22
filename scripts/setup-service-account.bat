@echo off
echo 🔧 Setting up Google Cloud Service Account for Play Store
echo.

echo 📱 Step 2: Google Cloud Service Account Setup
echo =============================================
echo.
echo 1. Go to: https://console.cloud.google.com/
echo 2. Create/select project: GenZSpace (or use existing)
echo 3. Go to "APIs & Services" → "Credentials"
echo 4. Click "Create Credentials" → "Service Account"
echo 5. Fill in details:
echo    - Name: genzspace-play-store
echo    - Description: Service account for GenZSpace Play Store uploads
echo    - Role: Service Account User
echo 6. Click "Create and Continue"
echo.
echo 7. Download Service Account Key:
echo    - Click on your service account
echo    - Go to "Keys" tab
echo    - Click "Add Key" → "Create new key"
echo    - Type: JSON
echo    - Click "Create"
echo    - Download the JSON file (keep it safe!)
echo.
echo 8. Link to Play Console:
echo    - Go to Play Console → "Setup" → "API access"
echo    - Click "Link project"
echo    - Select your Google Cloud project
echo    - Click "Link"
echo.
echo 9. Grant permissions to service account:
echo    - Find your service account in the list
echo    - Click "Grant access"
echo    - Select these permissions:
echo      ✅ View app information and download bulk reports
echo      ✅ View financial data, orders, and cancellation survey responses
echo      ✅ Manage orders and subscriptions
echo      ✅ Create, edit, and delete draft apps
echo      ✅ Release apps to testing tracks
echo      ✅ Release apps to production
echo    - Click "Invite user"
echo.
pause
echo.
echo ✅ Service Account setup complete!
echo.
echo 📋 Next: Run setup-github-secrets.bat
echo.
