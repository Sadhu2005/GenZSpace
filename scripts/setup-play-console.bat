@echo off
echo 🚀 Setting up Google Play Console for GenZSpace
echo.

echo 📱 Step 1: Google Play Console Setup
echo =====================================
echo.
echo 1. Go to: https://play.google.com/console/
echo 2. Sign in with: sadhuj2005@gmail.com
echo 3. Click "Create app" or find your existing GenZSpace app
echo 4. Complete the app setup:
echo    - App name: GenZSpace
echo    - Default language: English (United States)
echo    - App or game: App
echo    - Free or paid: Free
echo.
echo 5. In App content section:
echo    - Complete all required sections
echo    - Set content rating
echo    - Add privacy policy URL: https://zengspace.in/privacy
echo.
echo 6. In Pricing & distribution:
echo    - Set as free
echo    - Select countries (India + others you want)
echo    - Check "Google Play for Families" if needed
echo.
echo 7. In Release management:
echo    - Go to "Testing" → "Internal testing"
echo    - Click "Create new release"
echo    - Upload will be automatic via CI/CD
echo.
echo 8. In Testers tab:
echo    - Add your email: sadhuj2005@gmail.com
echo    - Copy the testing link for later
echo.
pause
echo.
echo ✅ Google Play Console setup complete!
echo.
echo 📋 Next: Run setup-service-account.bat
echo.
