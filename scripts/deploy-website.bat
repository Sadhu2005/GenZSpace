@echo off
REM GenZSpace Website Deployment Script for Hostinger (Windows)
REM This script automates the deployment process to Hostinger hosting

setlocal enabledelayedexpansion

echo 🚀 GenZSpace Website Deployment to Hostinger
echo ==============================================
echo.

REM Configuration
set WEBSITE_DIR=website
set DEPLOY_DIR=deploy
set BACKUP_DIR=backup-%date:~-4,4%%date:~-10,2%%date:~-7,2%-%time:~0,2%%time:~3,2%%time:~6,2%
set BACKUP_DIR=%BACKUP_DIR: =0%

REM Check if website directory exists
if not exist "%WEBSITE_DIR%" (
    echo [ERROR] Website directory '%WEBSITE_DIR%' not found
    exit /b 1
)

REM Create deployment directory
if exist "%DEPLOY_DIR%" (
    rmdir /s /q "%DEPLOY_DIR%"
)
mkdir "%DEPLOY_DIR%"

echo [INFO] Preparing deployment package...

REM Copy website files
xcopy "%WEBSITE_DIR%\*" "%DEPLOY_DIR%\" /E /I /Y

REM Remove development files
if exist "%DEPLOY_DIR%\node_modules" rmdir /s /q "%DEPLOY_DIR%\node_modules"
if exist "%DEPLOY_DIR%\.git" rmdir /s /q "%DEPLOY_DIR%\.git"

REM Create .htaccess file
echo # GenZSpace Website Configuration > "%DEPLOY_DIR%\.htaccess"
echo. >> "%DEPLOY_DIR%\.htaccess"
echo # Enable compression >> "%DEPLOY_DIR%\.htaccess"
echo ^<IfModule mod_deflate.c^> >> "%DEPLOY_DIR%\.htaccess"
echo     AddOutputFilterByType DEFLATE text/plain >> "%DEPLOY_DIR%\.htaccess"
echo     AddOutputFilterByType DEFLATE text/html >> "%DEPLOY_DIR%\.htaccess"
echo     AddOutputFilterByType DEFLATE text/css >> "%DEPLOY_DIR%\.htaccess"
echo     AddOutputFilterByType DEFLATE application/javascript >> "%DEPLOY_DIR%\.htaccess"
echo ^</IfModule^> >> "%DEPLOY_DIR%\.htaccess"
echo. >> "%DEPLOY_DIR%\.htaccess"
echo # Enable browser caching >> "%DEPLOY_DIR%\.htaccess"
echo ^<IfModule mod_expires.c^> >> "%DEPLOY_DIR%\.htaccess"
echo     ExpiresActive on >> "%DEPLOY_DIR%\.htaccess"
echo     ExpiresByType text/css "access plus 1 year" >> "%DEPLOY_DIR%\.htaccess"
echo     ExpiresByType application/javascript "access plus 1 year" >> "%DEPLOY_DIR%\.htaccess"
echo     ExpiresByType image/png "access plus 1 year" >> "%DEPLOY_DIR%\.htaccess"
echo     ExpiresByType image/jpg "access plus 1 year" >> "%DEPLOY_DIR%\.htaccess"
echo ^</IfModule^> >> "%DEPLOY_DIR%\.htaccess"
echo. >> "%DEPLOY_DIR%\.htaccess"
echo # Redirect to HTTPS >> "%DEPLOY_DIR%\.htaccess"
echo RewriteEngine On >> "%DEPLOY_DIR%\.htaccess"
echo RewriteCond %%{HTTPS} off >> "%DEPLOY_DIR%\.htaccess"
echo RewriteRule ^(.*)$ https://%%{HTTP_HOST}%%{REQUEST_URI} [L,R=301] >> "%DEPLOY_DIR%\.htaccess"

echo [SUCCESS] Deployment package prepared

REM Check if required environment variables are set
if "%HOSTINGER_FTP_HOST%"=="" (
    echo [ERROR] HOSTINGER_FTP_HOST environment variable not set
    echo Please set your Hostinger FTP host in environment variables
    exit /b 1
)

if "%HOSTINGER_FTP_USERNAME%"=="" (
    echo [ERROR] HOSTINGER_FTP_USERNAME environment variable not set
    echo Please set your Hostinger FTP username in environment variables
    exit /b 1
)

if "%HOSTINGER_FTP_PASSWORD%"=="" (
    echo [ERROR] HOSTINGER_FTP_PASSWORD environment variable not set
    echo Please set your Hostinger FTP password in environment variables
    exit /b 1
)

echo [INFO] Deploying via FTP...

REM Create FTP script
echo open %HOSTINGER_FTP_HOST% > ftp_script.txt
echo user %HOSTINGER_FTP_USERNAME% %HOSTINGER_FTP_PASSWORD% >> ftp_script.txt
echo binary >> ftp_script.txt
echo cd public_html >> ftp_script.txt
echo prompt >> ftp_script.txt
echo mdelete * >> ftp_script.txt

REM Add files to upload
for /r "%DEPLOY_DIR%" %%f in (*) do (
    set "filepath=%%f"
    set "filepath=!filepath:%DEPLOY_DIR%\=!"
    echo put "%%f" "!filepath!" >> ftp_script.txt
)

echo quit >> ftp_script.txt

REM Execute FTP upload
ftp -n -s:ftp_script.txt

REM Clean up FTP script
del ftp_script.txt

echo [SUCCESS] FTP deployment completed

REM Verify deployment
echo [INFO] Verifying deployment...
timeout /t 5 /nobreak >nul

REM Clean up deployment directory
if exist "%DEPLOY_DIR%" (
    rmdir /s /q "%DEPLOY_DIR%"
)

echo.
echo [SUCCESS] === DEPLOYMENT SUMMARY ===
echo Website: GenZSpace
echo URL: https://zengspace.in
echo Deployment time: %date% %time%
echo Status: Success
echo.

pause
