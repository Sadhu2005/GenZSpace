@echo off
REM GenZSpace Version Update Script for Windows
REM This script helps you update the app version and trigger CI/CD pipeline

setlocal enabledelayedexpansion

REM Colors (Windows doesn't support colors in batch, but we can use echo)
set "INFO=[INFO]"
set "SUCCESS=[SUCCESS]"
set "WARNING=[WARNING]"
set "ERROR=[ERROR]"

REM Function to print status
:print_status
echo %INFO% %~1
goto :eof

:print_success
echo %SUCCESS% %~1
goto :eof

:print_warning
echo %WARNING% %~1
goto :eof

:print_error
echo %ERROR% %~1
goto :eof

REM Function to get current version
:get_current_version
for /f "tokens=2 delims=: " %%a in ('findstr "version:" pubspec.yaml') do (
    for /f "tokens=1 delims=+" %%b in ("%%a") do (
        set "current_version=%%b"
    )
)
goto :eof

REM Function to get current build
:get_current_build
for /f "tokens=2 delims=: " %%a in ('findstr "version:" pubspec.yaml') do (
    for /f "tokens=2 delims=+" %%b in ("%%a") do (
        set "current_build=%%b"
    )
)
goto :eof

REM Function to show help
:show_help
echo GenZSpace Version Update Script for Windows
echo.
echo Usage: %0 [OPTIONS]
echo.
echo Options:
echo   -v VERSION    Set the new version (e.g., 1.0.2)
echo   -b BUILD      Set the new build number (e.g., 3)
echo   -a            Auto-increment build number
echo   -t            Create git tag for release
echo   -p            Push changes to repository
echo   -h            Show this help message
echo.
echo Examples:
echo   %0 -v 1.0.2 -b 3 -t -p    # Update to version 1.0.2, build 3, create tag, and push
echo   %0 -a -t -p               # Auto-increment build, create tag, and push
echo   %0 -v 1.1.0 -b 1 -t -p    # New minor version release
goto :eof

REM Main script logic
set "new_version="
set "new_build="
set "auto_increment=false"
set "create_tag_flag=false"
set "push_flag=false"

REM Parse command line arguments
:parse_args
if "%~1"=="" goto :main_logic
if "%~1"=="-v" (
    set "new_version=%~2"
    shift
    shift
    goto :parse_args
)
if "%~1"=="-b" (
    set "new_build=%~2"
    shift
    shift
    goto :parse_args
)
if "%~1"=="-a" (
    set "auto_increment=true"
    shift
    goto :parse_args
)
if "%~1"=="-t" (
    set "create_tag_flag=true"
    shift
    goto :parse_args
)
if "%~1"=="-p" (
    set "push_flag=true"
    shift
    goto :parse_args
)
if "%~1"=="-h" (
    call :show_help
    exit /b 0
)
echo %ERROR% Unknown option: %~1
call :show_help
exit /b 1

:main_logic
REM Get current version info
call :get_current_version
call :get_current_build

call :print_status "Current version: !current_version! (build: !current_build!)"

REM Handle auto-increment
if "!auto_increment!"=="true" (
    if "!new_build!"=="" (
        set /a new_build=!current_build!+1
    )
    if "!new_version!"=="" (
        set "new_version=!current_version!"
    )
)

REM Validate inputs
if "!new_version!"=="" (
    call :print_error "Version is required"
    call :show_help
    exit /b 1
)
if "!new_build!"=="" (
    call :print_error "Build number is required"
    call :show_help
    exit /b 1
)

REM Update version
call :print_status "Updating version to !new_version! (build: !new_build!)"

REM Update pubspec.yaml (using PowerShell for better text replacement)
powershell -Command "(Get-Content pubspec.yaml) -replace 'version: .*', 'version: !new_version!+!new_build!' | Set-Content pubspec.yaml"

call :print_success "Version updated in pubspec.yaml"

REM Create tag if requested
if "!create_tag_flag!"=="true" (
    call :print_status "Creating git tag v!new_version!"
    git tag "v!new_version!"
    call :print_success "Git tag v!new_version! created"
)

REM Push changes if requested
if "!push_flag!"=="true" (
    call :print_status "Pushing changes to repository"
    
    REM Add and commit changes
    git add pubspec.yaml
    git commit -m "🚀 Bump version to !new_version!+!new_build!"
    
    REM Push changes
    git push origin main
    
    REM Push tag
    git push origin "v!new_version!"
    
    call :print_success "Changes pushed to repository"
    call :print_success "CI/CD pipeline will be triggered automatically"
)

call :print_success "Version update completed!"
call :print_status "New version: !new_version! (build: !new_build!)"

if "!push_flag!"=="true" (
    call :print_status "CI/CD pipeline is now running..."
    call :print_status "Check GitHub Actions for build progress"
    call :print_status "Firebase App Distribution will be updated automatically"
)

endlocal
