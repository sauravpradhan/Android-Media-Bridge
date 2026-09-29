@echo off

set "SDK=%LOCALAPPDATA%\Android\Sdk"
set "EMULATOR=%SDK%\emulator\emulator.exe"
set "AVD=Pixel_10"

echo Starting Android Emulator with allow host audio...
echo.

"%EMULATOR%" @%AVD% -allow-host-audio