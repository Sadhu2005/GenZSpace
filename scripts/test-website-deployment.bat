@echo off
echo.
echo ========================================
echo    🧪 Website Deployment Test
echo ========================================
echo.

echo 📋 Step 1: Check Website Files
echo.
echo Checking if all required files exist...
echo.

if exist "website\index.html" (
    echo ✅ index.html - Main homepage
) else (
    echo ❌ index.html - Missing!
)

if exist "website\privacy.html" (
    echo ✅ privacy.html - Privacy policy
) else (
    echo ❌ privacy.html - Missing!
)

if exist "website\404.html" (
    echo ✅ 404.html - Error page
) else (
    echo ❌ 404.html - Missing!
)

if exist "website\robots.txt" (
    echo ✅ robots.txt - SEO file
) else (
    echo ❌ robots.txt - Missing!
)

if exist "website\sitemap.xml" (
    echo ✅ sitemap.xml - SEO file
) else (
    echo ❌ sitemap.xml - Missing!
)

if exist "website\.htaccess" (
    echo ✅ .htaccess - Performance file
) else (
    echo ❌ .htaccess - Missing!
)

if exist "website\assets\css\style.css" (
    echo ✅ assets/css/style.css - Main stylesheet
) else (
    echo ❌ assets/css/style.css - Missing!
)

if exist "website\assets\js\script.js" (
    echo ✅ assets/js/script.js - JavaScript
) else (
    echo ❌ assets/js/script.js - Missing!
)

if exist "website\assets\images\logo.svg" (
    echo ✅ assets/images/logo.svg - Logo
) else (
    echo ❌ assets/images/logo.svg - Missing!
)

echo.
echo 📋 Step 2: Check GitHub Secrets
echo.
echo Make sure you have added these secrets to GitHub:
echo.
echo 1. HOSTINGER_USERNAME
echo 2. HOSTINGER_PASSWORD  
echo 3. HOSTINGER_HOST
echo.

pause

echo.
echo 📋 Step 3: Test Deployment
echo.
echo To test the deployment:
echo.
echo 1. Make a small change to website/index.html
echo 2. Commit and push to GitHub
echo 3. Check Actions tab for "Deploy Website to Hostinger"
echo 4. Visit https://genzspace.in to verify
echo.

echo.
echo 📋 Step 4: Verify Live Website
echo.
echo After deployment, check these URLs:
echo.
echo 🌐 Main Website: https://genzspace.in
echo 📱 Privacy Policy: https://genzspace.in/privacy.html
echo ❌ Error Page: https://genzspace.in/404.html
echo 🔍 Sitemap: https://genzspace.in/sitemap.xml
echo 🤖 Robots: https://genzspace.in/robots.txt
echo.

echo.
echo ✅ Website deployment test complete!
echo.
echo Next steps:
echo 1. Add GitHub secrets for Hostinger
echo 2. Make a test change to website/
echo 3. Push to GitHub
echo 4. Check Actions tab
echo 5. Verify live website
echo.

pause
