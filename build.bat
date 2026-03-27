@echo off
setlocal

set DEVKITPRO=C:\devkitPro

if not exist "%DEVKITPRO%\cmake\Wii.cmake" (
    echo "Warning: %DEVKITPRO%\cmake\Wii.cmake not found. Please ensure devkitPro is installed with wii-cmake."
    echo "Attempting to build using standard Make..."
    make
    goto :EOF
)

if not exist build mkdir build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE="%DEVKITPRO%\cmake\Wii.cmake" ..
if errorlevel 1 (
    echo "CMake configuration failed."
    goto :EOF
)

cmake --build .
if errorlevel 1 (
    echo "CMake build failed."
    goto :EOF
)

cd ..
echo Build complete.
endlocal
