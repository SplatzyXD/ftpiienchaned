@echo off
setlocal

:: Check if devkitPro is installed in the default location
if not exist "C:\devkitPro\devkitPPC\wii_rules" (
    echo Error: devkitPro or devkitPPC not found at C:\devkitPro.
    echo Please install devkitPro from https://devkitpro.org/wiki/Getting_Started
    echo and ensure you select the 'devkitPPC', 'wii-cmake' and 'libogc' components.
    pause
    exit /b 1
)

:: Set environment variables required by the Makefile
set "DEVKITPRO=C:\devkitPro"
set "DEVKITPPC=C:\devkitPro\devkitPPC"

:: Add devkitPro msys2 binaries to PATH (where 'make' usually resides)
set "PATH=%DEVKITPRO%\msys2\usr\bin;%PATH%"

echo Building ftpii using CMake (handles spaces in folder paths easily)...
if not exist "build" mkdir build
cd build
cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE="%DEVKITPRO%\cmake\Wii.cmake" ..
if %ERRORLEVEL% neq 0 (
    echo CMake generation failed!
    cd ..
    pause
    exit /b %ERRORLEVEL%
)

make
if %ERRORLEVEL% equ 0 (
    echo.
    echo Build successful! Find your ftpii.elf and ftpii.dol in the build folder.
) else (
    echo.
    echo Build failed with error code %ERRORLEVEL%.
)

cd ..
endlocal
pause
