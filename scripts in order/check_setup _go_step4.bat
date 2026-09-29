@echo off

set "SDK=%LOCALAPPDATA%\Android\Sdk"
set "EMULATOR=%SDK%\emulator\emulator.exe"
set "ADB=%SDK%\platform-tools\adb.exe"

echo Final setup and Go
echo .........................................
echo.

echo [Emulator]
echo Command: "%EMULATOR%" -version
"%EMULATOR%" -version

echo.
echo [Webcams]
echo Command: "%EMULATOR%" -webcam-list
"%EMULATOR%" -webcam-list

echo.
echo [Connected devices]
echo Command: "%ADB%" devices
"%ADB%" devices

echo.
echo [AVD status]
echo Command: "%ADB%" emu avd status
"%ADB%" emu avd status

echo.
echo [Host Microphone]
echo Command: "%ADB%" emu avd hostmicon
"%ADB%" emu avd hostmicon

if errorlevel 1 (
    echo [ERROR] Host microphone activation failed.
) else (
    echo [OK] Host microphone activation returned successfully.
)

echo.
echo Diagnostics complete.
pause