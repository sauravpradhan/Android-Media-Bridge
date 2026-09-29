@echo off
setlocal

set "SDK=%LOCALAPPDATA%\Android\Sdk"
set "EMULATOR=%SDK%\emulator\emulator.exe"
set "ADB=%SDK%\platform-tools\adb.exe"
set "AVD=Pixel_10"
set "AVD_CONFIG=%USERPROFILE%\.android\avd\%AVD%.avd\config.ini"

echo Android Camera + Audio Bridge Setup
echo ...................................
echo.

echo [1/4] Checking emulator...
"%EMULATOR%" -version
if errorlevel 1 (
    echo ERROR: Android Emulator not found.
    exit /b 1
)

echo.
echo [2/4] Detecting webcams...
"%EMULATOR%" -webcam-list

echo.
echo [3/4] Configuring front camera...
findstr /r /c:"^hw.camera.front=webcam0$" "%AVD_CONFIG%" >nul

if errorlevel 1 (
    echo Updating hw.camera.front...
    powershell -NoProfile -Command ^
      "(Get-Content '%AVD_CONFIG%') -replace '^hw\.camera\.front=.*$', 'hw.camera.front=webcam0' | Set-Content '%AVD_CONFIG%'"
) else (
    echo Camera already configured.
)

echo.
echo [4/4] Configuration complete.
echo.
echo Camera:
echo   hw.camera.front=webcam0
echo.
echo Audio:
echo   hw.audioInput=yes
echo   host microphone will be enabled after boot
echo.

pause