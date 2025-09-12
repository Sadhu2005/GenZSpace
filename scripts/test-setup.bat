@echo off
REM GenZSpace CI/CD Setup Test Script
REM This script tests your CI/CD setup

echo ========================================
echo GenZSpace CI/CD Setup Test
echo ========================================
echo.

REM Check if required files exist
echo [TEST] Checking required files...

if exist "pubspec.yaml" (
    echo [✓] pubspec.yaml found
) else (
    echo [✗] pubspec.yaml not found
    goto :error
)

if exist ".github\workflows\build-and-distribute.yml" (
    echo [✓] GitHub Actions workflow found
) else (
    echo [✗] GitHub Actions workflow not found
    goto :error
)

if exist "firebase.json" (
    echo [✓] firebase.json found
) else (
    echo [✗] firebase.json not found
    goto :error
)

if exist "lib\services\update_service.dart" (
    echo [✓] Update service found
) else (
    echo [✗] Update service not found
    goto :error
)

echo.
echo [TEST] Checking Flutter setup...

REM Check Flutter version
flutter --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [✓] Flutter is installed
    flutter --version | findstr "Flutter"
) else (
    echo [✗] Flutter is not installed or not in PATH
    goto :error
)

echo.
echo [TEST] Checking Git setup...

REM Check Git
git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [✓] Git is installed
    git --version
) else (
    echo [✗] Git is not installed or not in PATH
    goto :error
)

REM Check if we're in a git repository
git status >nul 2>&1
if %errorlevel% equ 0 (
    echo [✓] Git repository detected
) else (
    echo [✗] Not in a git repository
    goto :error
)

echo.
echo [TEST] Checking Firebase setup...

REM Check Firebase CLI
firebase --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [✓] Firebase CLI is installed
    firebase --version
) else (
    echo [!] Firebase CLI is not installed (optional but recommended)
    echo    Install with: npm install -g firebase-tools
)

echo.
echo [TEST] Checking project configuration...

REM Check pubspec.yaml version
for /f "tokens=2 delims=: " %%a in ('findstr "version:" pubspec.yaml') do (
    echo [✓] Current version: %%a
)

REM Check Firebase app ID
for /f "tokens=3 delims=: " %%a in ('findstr "app:" firebase.json') do (
    echo [✓] Firebase App ID: %%a
)

echo.
echo ========================================
echo Setup Test Complete!
echo ========================================
echo.

echo [INFO] Next steps:
echo 1. Make sure your GitHub secrets are configured:
echo    - FIREBASE_APP_ID
echo    - FIREBASE_TOKEN
echo.
echo 2. Test the CI/CD pipeline:
echo    - Make a small change and push to develop branch
echo    - Check GitHub Actions for build status
echo    - Verify Firebase App Distribution receives the build
echo.
echo 3. Test version updates:
echo    - Run: scripts\version-update.bat -a -t -p
echo    - This will auto-increment build and push changes
echo.
echo 4. Test app updates:
echo    - Install the distributed app
echo    - The app should automatically detect updates
echo.

goto :end

:error
echo.
echo [ERROR] Setup test failed!
echo Please fix the issues above before proceeding.
echo.
goto :end

:end
pause
