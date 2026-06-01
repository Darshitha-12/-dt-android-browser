@echo off
echo ==========================================
echo   DT Browser - Android APK Build Script
echo ==========================================
echo.

REM Check Java
java -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Java not found! Install JDK 17+ from:
    echo   https://adoptium.net/
    pause
    exit /b 1
)
echo [OK] Java found

REM Check ANDROID_HOME
if "%ANDROID_HOME%"=="" (
    if exist "%LOCALAPPDATA%\Android\Sdk" (
        set ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk
    ) else (
        echo [ERROR] ANDROID_HOME not set.
        echo.
        echo Option 1: Install Android Studio (recommended)
        echo   1. Download from https://developer.android.com/studio
        echo   2. Install and open this project
        echo   3. Build -^> Build APK
        echo.
        echo Option 2: Install command-line tools only
        echo   1. Download cmdline-tools from:
        echo      https://developer.android.com/studio#command-line-tools-only
        echo   2. Extract to C:\Android\cmdline-tools
        echo   3. Run: sdkmanager "platforms;android-34" "build-tools;34.0.0"
        echo   4. Set ANDROID_HOME=C:\Android
        pause
        exit /b 1
    )
)
echo [OK] ANDROID_HOME=%ANDROID_HOME%

REM Build APK
echo.
echo Building APK...
echo (This may take 2-5 minutes first time)
call gradlew assembleRelease
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Build failed
    pause
    exit /b 1
)

echo.
echo ==========================================
echo   SUCCESS! APK created at:
echo   app\build\outputs\apk\release\app-release.apk
echo ==========================================
pause
