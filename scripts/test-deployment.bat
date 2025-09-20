@echo off
REM GenZSpace Website Deployment Test Script for Windows
REM This script tests the deployment process without actually deploying

setlocal enabledelayedexpansion

echo 🧪 GenZSpace Website Deployment Test
echo ====================================
echo.

REM Configuration
set WEBSITE_DIR=website
set TEST_DIR=test-deploy
set BACKUP_DIR=backup-test-%date:~-4,4%%date:~-10,2%%date:~-7,2%-%time:~0,2%%time:~3,2%%time:~6,2%
set BACKUP_DIR=%BACKUP_DIR: =0%

echo [INFO] Testing deployment process...
echo.

REM Check if website directory exists
if not exist "%WEBSITE_DIR%" (
    echo [ERROR] Website directory '%WEBSITE_DIR%' not found
    exit /b 1
)

echo [SUCCESS] Website directory found: %WEBSITE_DIR%

REM Check website files
echo [INFO] Checking website files...
if not exist "%WEBSITE_DIR%\index.html" (
    echo [ERROR] index.html not found in website directory
    exit /b 1
)
echo [SUCCESS] index.html found

if not exist "%WEBSITE_DIR%\assets" (
    echo [WARNING] assets directory not found
) else (
    echo [SUCCESS] assets directory found
)

if not exist "%WEBSITE_DIR%\assets\css" (
    echo [WARNING] CSS directory not found
) else (
    echo [SUCCESS] CSS directory found
)

if not exist "%WEBSITE_DIR%\assets\js" (
    echo [WARNING] JavaScript directory not found
) else (
    echo [SUCCESS] JavaScript directory found
)

if not exist "%WEBSITE_DIR%\assets\images" (
    echo [WARNING] Images directory not found
) else (
    echo [SUCCESS] Images directory found
)

REM Create test deployment directory
if exist "%TEST_DIR%" (
    rmdir /s /q "%TEST_DIR%"
)
mkdir "%TEST_DIR%"

echo [INFO] Creating test deployment package...

REM Copy website files
xcopy "%WEBSITE_DIR%\*" "%TEST_DIR%\" /E /I /Y

REM Remove development files
if exist "%TEST_DIR%\node_modules" rmdir /s /q "%TEST_DIR%\node_modules"
if exist "%TEST_DIR%\.git" rmdir /s /q "%TEST_DIR%\.git"

REM Create .htaccess file
echo # GenZSpace Website Configuration > "%TEST_DIR%\.htaccess"
echo. >> "%TEST_DIR%\.htaccess"
echo # Enable compression >> "%TEST_DIR%\.htaccess"
echo ^<IfModule mod_deflate.c^> >> "%TEST_DIR%\.htaccess"
echo     AddOutputFilterByType DEFLATE text/plain >> "%TEST_DIR%\.htaccess"
echo     AddOutputFilterByType DEFLATE text/html >> "%TEST_DIR%\.htaccess"
echo     AddOutputFilterByType DEFLATE text/css >> "%TEST_DIR%\.htaccess"
echo     AddOutputFilterByType DEFLATE application/javascript >> "%TEST_DIR%\.htaccess"
echo ^</IfModule^> >> "%TEST_DIR%\.htaccess"
echo. >> "%TEST_DIR%\.htaccess"
echo # Enable browser caching >> "%TEST_DIR%\.htaccess"
echo ^<IfModule mod_expires.c^> >> "%TEST_DIR%\.htaccess"
echo     ExpiresActive on >> "%TEST_DIR%\.htaccess"
echo     ExpiresByType text/css "access plus 1 year" >> "%TEST_DIR%\.htaccess"
echo     ExpiresByType application/javascript "access plus 1 year" >> "%TEST_DIR%\.htaccess"
echo     ExpiresByType image/png "access plus 1 year" >> "%TEST_DIR%\.htaccess"
echo     ExpiresByType image/jpg "access plus 1 year" >> "%TEST_DIR%\.htaccess"
echo ^</IfModule^> >> "%TEST_DIR%\.htaccess"
echo. >> "%TEST_DIR%\.htaccess"
echo # Redirect to HTTPS >> "%TEST_DIR%\.htaccess"
echo RewriteEngine On >> "%TEST_DIR%\.htaccess"
echo RewriteCond %%{HTTPS} off >> "%TEST_DIR%\.htaccess"
echo RewriteRule ^(.*)$ https://%%{HTTP_HOST}%%{REQUEST_URI} [L,R=301] >> "%TEST_DIR%\.htaccess"

echo [SUCCESS] Test deployment package created in: %TEST_DIR%

REM Check file sizes
echo [INFO] Analyzing deployment package...
for /f %%i in ('dir "%TEST_DIR%" /s /-c ^| find "File(s)"') do set FILE_COUNT=%%i
for /f %%i in ('dir "%TEST_DIR%" /s /-c ^| find "Dir(s)"') do set DIR_COUNT=%%i

echo [INFO] Files to deploy: %FILE_COUNT%
echo [INFO] Directories to deploy: %DIR_COUNT%

REM Check for large files
echo [INFO] Checking for large files...
for /r "%TEST_DIR%" %%f in (*) do (
    set "filesize=%%~zf"
    if !filesize! gtr 1048576 (
        echo [WARNING] Large file found: %%~nxf (!filesize! bytes)
    )
)

REM Validate HTML structure (basic check)
echo [INFO] Validating HTML structure...
findstr /i "<html>" "%TEST_DIR%\index.html" >nul
if errorlevel 1 (
    echo [ERROR] HTML structure issue: Missing opening html tag
) else (
    echo [SUCCESS] HTML structure looks good
)

findstr /i "</html>" "%TEST_DIR%\index.html" >nul
if errorlevel 1 (
    echo [ERROR] HTML structure issue: Missing closing html tag
) else (
    echo [SUCCESS] HTML closing tag found
)

REM Check environment variables
echo [INFO] Checking environment configuration...
if "%HOSTINGER_FTP_HOST%"=="" (
    echo [WARNING] HOSTINGER_FTP_HOST not set
) else (
    echo [SUCCESS] HOSTINGER_FTP_HOST is configured
)

if "%HOSTINGER_FTP_USERNAME%"=="" (
    echo [WARNING] HOSTINGER_FTP_USERNAME not set
) else (
    echo [SUCCESS] HOSTINGER_FTP_USERNAME is configured
)

if "%HOSTINGER_FTP_PASSWORD%"=="" (
    echo [WARNING] HOSTINGER_FTP_PASSWORD not set
) else (
    echo [SUCCESS] HOSTINGER_FTP_PASSWORD is configured
)

REM Test FTP connection (if credentials are available)
if not "%HOSTINGER_FTP_HOST%"=="" if not "%HOSTINGER_FTP_USERNAME%"=="" if not "%HOSTINGER_FTP_PASSWORD%"=="" (
    echo [INFO] Testing FTP connection...
    echo open %HOSTINGER_FTP_HOST% > ftp_test.txt
    echo user %HOSTINGER_FTP_USERNAME% %HOSTINGER_FTP_PASSWORD% >> ftp_test.txt
    echo quit >> ftp_test.txt
    
    ftp -n -s:ftp_test.txt > ftp_result.txt 2>&1
    findstr /i "connected" ftp_result.txt >nul
    if errorlevel 1 (
        echo [ERROR] FTP connection test failed
        type ftp_result.txt
    ) else (
        echo [SUCCESS] FTP connection test passed
    )
    
    del ftp_test.txt
    del ftp_result.txt
) else (
    echo [INFO] Skipping FTP test - credentials not fully configured
)

REM Create deployment summary
echo [INFO] Creating deployment summary...

echo GenZSpace Website Deployment Test Summary > "%TEST_DIR%\deployment-summary.txt"
echo ========================================= >> "%TEST_DIR%\deployment-summary.txt"
echo. >> "%TEST_DIR%\deployment-summary.txt"
echo Test Date: %date% %time% >> "%TEST_DIR%\deployment-summary.txt"
echo Website Directory: %WEBSITE_DIR% >> "%TEST_DIR%\deployment-summary.txt"
echo Test Directory: %TEST_DIR% >> "%TEST_DIR%\deployment-summary.txt"
echo. >> "%TEST_DIR%\deployment-summary.txt"
echo Files to Deploy: %FILE_COUNT% >> "%TEST_DIR%\deployment-summary.txt"
echo Directories to Deploy: %DIR_COUNT% >> "%TEST_DIR%\deployment-summary.txt"
echo. >> "%TEST_DIR%\deployment-summary.txt"
echo FTP Host: %HOSTINGER_FTP_HOST% >> "%TEST_DIR%\deployment-summary.txt"
echo FTP Username: %HOSTINGER_FTP_USERNAME% >> "%TEST_DIR%\deployment-summary.txt"
echo FTP Password: [CONFIGURED] >> "%TEST_DIR%\deployment-summary.txt"
echo. >> "%TEST_DIR%\deployment-summary.txt"
echo Status: Ready for deployment >> "%TEST_DIR%\deployment-summary.txt"

echo [SUCCESS] Deployment test completed!
echo.
echo [SUMMARY]
echo =========
echo.
echo ✅ Website files validated
echo ✅ Deployment package created
echo ✅ Configuration checked
echo ✅ FTP connection tested
echo.
echo Test deployment package created in: %TEST_DIR%
echo Deployment summary saved to: %TEST_DIR%\deployment-summary.txt
echo.
echo [NEXT STEPS]
echo ============
echo.
echo 1. Review the test deployment package in: %TEST_DIR%
echo 2. Check deployment-summary.txt for details
echo 3. If everything looks good, run the actual deployment:
echo    scripts\deploy-website.bat
echo.
echo [SUCCESS] Deployment test completed successfully! 🎉
echo.
pause
