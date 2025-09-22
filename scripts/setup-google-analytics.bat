@echo off
echo.
echo ========================================
echo    📊 Google Analytics Setup Guide
echo ========================================
echo.

echo 📋 Step 1: Create Google Analytics Account
echo.
echo 1. Go to https://analytics.google.com
echo 2. Click "Start measuring"
echo 3. Enter account name: "GenZSpace"
echo 4. Enter property name: "GenZSpace Website"
echo 5. Enter website URL: https://genzspace.in
echo 6. Select your country and timezone
echo.

pause

echo.
echo 📋 Step 2: Get Your Tracking ID
echo.
echo 1. After creating the property, you'll get a tracking ID
echo 2. It looks like: G-XXXXXXXXXX
echo 3. Copy this tracking ID
echo.

pause

echo.
echo 📋 Step 3: Update Your Website
echo.
echo 1. Open website/index.html
echo 2. Find the line: gtag('config', 'G-XXXXXXXXXX');
echo 3. Replace G-XXXXXXXXXX with your actual tracking ID
echo 4. Save the file
echo 5. Commit and push to GitHub
echo.

pause

echo.
echo 📋 Step 4: Verify Analytics is Working
echo.
echo 1. Visit your website: https://genzspace.in
echo 2. Go to Google Analytics dashboard
echo 3. Check "Realtime" reports
echo 4. You should see your visit recorded
echo.

echo.
echo ✅ Google Analytics setup complete!
echo.
echo Your website will now track:
echo - Page views
echo - User sessions
echo - Traffic sources
echo - User demographics
echo - And much more!
echo.

pause
