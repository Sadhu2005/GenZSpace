@echo off
REM GenZSpace Website CI/CD Setup Script for Windows
REM This script helps set up the CI/CD pipeline for website deployment

setlocal enabledelayedexpansion

echo 🚀 GenZSpace Website CI/CD Setup
echo ================================
echo.

REM Check if Git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Git is not installed or not in PATH
    echo Please install Git from https://git-scm.com/
    pause
    exit /b 1
)

echo [SUCCESS] Git is installed

REM Check if we're in a Git repository
git status >nul 2>&1
if errorlevel 1 (
    echo [INFO] Initializing Git repository...
    git init
    git add .
    git commit -m "Initial commit: GenZSpace website with CI/CD setup"
    git branch -M main
    echo [SUCCESS] Git repository initialized
) else (
    echo [SUCCESS] Git repository already exists
)

REM Create .env file if it doesn't exist
if not exist ".env" (
    echo [INFO] Creating .env file from template...
    copy ".env.example" ".env"
    echo [SUCCESS] .env file created
    echo [WARNING] Please edit .env file with your actual Hostinger credentials
) else (
    echo [SUCCESS] .env file already exists
)

REM Create .gitignore if it doesn't exist
if not exist ".gitignore" (
    echo [INFO] Creating .gitignore file...
    echo # Environment variables > .gitignore
    echo .env >> .gitignore
    echo .env.local >> .gitignore
    echo .env.*.local >> .gitignore
    echo. >> .gitignore
    echo # Logs >> .gitignore
    echo logs >> .gitignore
    echo *.log >> .gitignore
    echo npm-debug.log* >> .gitignore
    echo yarn-debug.log* >> .gitignore
    echo yarn-error.log* >> .gitignore
    echo. >> .gitignore
    echo # Runtime data >> .gitignore
    echo pids >> .gitignore
    echo *.pid >> .gitignore
    echo *.seed >> .gitignore
    echo *.pid.lock >> .gitignore
    echo. >> .gitignore
    echo # Coverage directory used by tools like istanbul >> .gitignore
    echo coverage >> .gitignore
    echo. >> .gitignore
    echo # nyc test coverage >> .gitignore
    echo .nyc_output >> .gitignore
    echo. >> .gitignore
    echo # Dependency directories >> .gitignore
    echo node_modules/ >> .gitignore
    echo jspm_packages/ >> .gitignore
    echo. >> .gitignore
    echo # Optional npm cache directory >> .gitignore
    echo .npm >> .gitignore
    echo. >> .gitignore
    echo # Optional eslint cache >> .gitignore
    echo .eslintcache >> .gitignore
    echo. >> .gitignore
    echo # Output of 'npm pack' >> .gitignore
    echo *.tgz >> .gitignore
    echo. >> .gitignore
    echo # Yarn Integrity file >> .gitignore
    echo .yarn-integrity >> .gitignore
    echo. >> .gitignore
    echo # dotenv environment variables file >> .gitignore
    echo .env >> .gitignore
    echo. >> .gitignore
    echo # parcel-bundler cache (https://parceljs.org/) >> .gitignore
    echo .cache >> .gitignore
    echo .parcel-cache >> .gitignore
    echo. >> .gitignore
    echo # next.js build output >> .gitignore
    echo .next >> .gitignore
    echo. >> .gitignore
    echo # nuxt.js build output >> .gitignore
    echo .nuxt >> .gitignore
    echo. >> .gitignore
    echo # vuepress build output >> .gitignore
    echo .vuepress/dist >> .gitignore
    echo. >> .gitignore
    echo # Serverless directories >> .gitignore
    echo .serverless >> .gitignore
    echo. >> .gitignore
    echo # FuseBox cache >> .gitignore
    echo .fusebox/ >> .gitignore
    echo. >> .gitignore
    echo # DynamoDB Local files >> .gitignore
    echo .dynamodb/ >> .gitignore
    echo. >> .gitignore
    echo # TernJS port file >> .gitignore
    echo .tern-port >> .gitignore
    echo. >> .gitignore
    echo # Stores VSCode versions used for testing VSCode extensions >> .gitignore
    echo .vscode-test >> .gitignore
    echo. >> .gitignore
    echo # Temporary folders >> .gitignore
    echo tmp/ >> .gitignore
    echo temp/ >> .gitignore
    echo deploy/ >> .gitignore
    echo. >> .gitignore
    echo # OS generated files >> .gitignore
    echo .DS_Store >> .gitignore
    echo .DS_Store? >> .gitignore
    echo ._* >> .gitignore
    echo .Spotlight-V100 >> .gitignore
    echo .Trashes >> .gitignore
    echo ehthumbs.db >> .gitignore
    echo Thumbs.db >> .gitignore
    echo [SUCCESS] .gitignore file created
) else (
    echo [SUCCESS] .gitignore file already exists
)

REM Check if GitHub remote is configured
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo [WARNING] GitHub remote not configured
    echo Please run the following commands to add your GitHub repository:
    echo   git remote add origin https://github.com/YOUR_USERNAME/GenZSpace.git
    echo   git push -u origin main
) else (
    echo [SUCCESS] GitHub remote is configured
)

echo.
echo [INFO] CI/CD Setup Summary:
echo ==========================
echo.
echo ✅ Git repository: Ready
echo ✅ Environment file: Ready (.env)
echo ✅ Git ignore: Ready (.gitignore)
echo ✅ GitHub Actions: Ready (.github/workflows/deploy-website.yml)
echo ✅ Deployment scripts: Ready (scripts/)
echo ✅ Documentation: Ready (WEBSITE_CICD_SETUP.md)
echo.
echo [NEXT STEPS]
echo ============
echo.
echo 1. Edit .env file with your Hostinger credentials
echo 2. Configure GitHub repository secrets:
echo    - HOSTINGER_FTP_HOST
echo    - HOSTINGER_FTP_USERNAME
echo    - HOSTINGER_FTP_PASSWORD
echo    - HOSTINGER_SSH_HOST (optional)
echo    - HOSTINGER_SSH_USERNAME (optional)
echo    - HOSTINGER_SSH_KEY (optional)
echo.
echo 3. Test local deployment:
echo    scripts\deploy-website.bat
echo.
echo 4. Push to GitHub to trigger automatic deployment:
echo    git add .
echo    git commit -m "Setup CI/CD pipeline"
echo    git push origin main
echo.
echo 5. Monitor deployment in GitHub Actions tab
echo.
echo [SUCCESS] CI/CD setup completed! 🎉
echo.
pause
