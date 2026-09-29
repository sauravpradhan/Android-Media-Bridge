@echo off

set "ADB=%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe"

echo Enabling Host Microphone
echo ........................
echo.

echo [1/2] Waiting for emulator...
echo Command: "%ADB%" wait-for-device
echo.

"%ADB%" wait-for-device

if errorlevel 1 (
    echo.
    echo [ERROR] Emulator not detected.
    pause
    exit /b 1
)

echo [OK] Emulator detected.
echo.

echo [2/2] Activating host microphone...
echo Command: "%ADB%" emu avd hostmicon
echo.

"%ADB%" emu avd hostmicon

if errorlevel 1 (
    echo.
    echo [ERROR] Failed to activate host microphone.
    pause
    exit /b 1
)

echo.
echo [OK] Host microphone activation command completed successfully.
echo.

pause