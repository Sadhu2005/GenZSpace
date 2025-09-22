@echo off
echo.
echo ========================================
echo    🚀 Hostinger CI/CD Setup Guide
echo ========================================
echo.

echo 📋 Step 1: Get Your Hostinger FTP Credentials
echo.
echo 1. Login to Hostinger → hPanel
echo 2. Go to Files → File Manager
echo 3. Click FTP Accounts or FTP Access
echo 4. Note down these details:
echo    - FTP Server: ftp.genzspace.in
echo    - FTP Username: your_ftp_username
echo    - FTP Password: your_ftp_password
echo    - FTP Port: 21
echo.

pause

echo.
echo 🔑 Step 2: Add GitHub Secrets
echo.
echo 1. Go to your GenZSpace repository on GitHub
echo 2. Click Settings tab
echo 3. Click Secrets and variables → Actions
echo 4. Click New repository secret
echo.

echo Add these 3 secrets:
echo.
echo Secret 1: HOSTINGER_USERNAME
echo - Name: HOSTINGER_USERNAME
echo - Value: your_ftp_username
echo.
echo Secret 2: HOSTINGER_PASSWORD
echo - Name: HOSTINGER_PASSWORD
echo - Value: your_ftp_password
echo.
echo Secret 3: HOSTINGER_HOST
echo - Name: HOSTINGER_HOST
echo - Value: ftp.genzspace.in
echo.

pause

echo.
echo 🎯 Step 3: How to Use Separate CI/CD Triggers
echo.
echo AUTOMATIC TRIGGERS:
echo - Website CI/CD: Triggers when you push changes to website/ folder
echo - App CI/CD: Triggers when you push changes to lib/ folder
echo.
echo MANUAL TRIGGERS:
echo - Go to Actions tab in GitHub
echo - Click "Deploy Website to Hostinger" for website
echo - Click "Firebase Deploy" for app
echo - Click "Run workflow" button
echo.

pause

echo.
echo 🧪 Step 4: Test the Setup
echo.
echo 1. Make a small change to any file in website/ folder
echo 2. Commit and push to GitHub
echo 3. Check Actions tab to see if deployment works
echo 4. Visit your website to verify it's updated
echo.

echo.
echo ✅ Setup Complete!
echo.
echo Your website will be automatically deployed to:
echo 🌐 Live URL: https://genzspace.in
echo 📱 Privacy Policy: https://genzspace.in/privacy.html
echo.

pause