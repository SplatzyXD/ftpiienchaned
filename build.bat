@echo off
setlocal

:: Check if devkitPro is installed in the default location
if not exist "C:\devkitPro\devkitPPC\wii_rules" (
    echo Error: devkitPro or devkitPPC not found at C:\devkitPro.
    echo Please install devkitPro from https://devkitpro.org/wiki/Getting_Started
    echo and ensure you select the 'devkitPPC' and 'libogc' components.
    pause
    exit /b 1
)

:: Set environment variables required by the Makefile
set "DEVKITPRO=C:\devkitPro"
set "DEVKITPPC=C:\devkitPro\devkitPPC"

:: Add devkitPro msys2 binaries to PATH (where 'make' usually resides)
set "PATH=%DEVKITPRO%\msys2\usr\bin;%PATH%"

:: Run make
echo Building ftpii...
make

if %ERRORLEVEL% equ 0 (
    echo Build successful!
) else (
    echo Build failed with error code %ERRORLEVEL%.
)

endlocal
pause
