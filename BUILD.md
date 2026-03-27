# ftpii Build Guide

This document describes how to build the ftpii server for the Nintendo Wii.
ftpii uses the `devkitPPC` toolchain and the `libogc` library.

## Prerequisites

1.  **devkitPro**: Install devkitPro via the automated installers provided on their website (https://devkitpro.org/wiki/Getting_Started).
2.  **devkitPPC, libogc, and wii-cmake**: During installation, ensure you select the components to install `devkitPPC`, `libogc`, and `wii-cmake`.

## Building on Windows (Easiest)

If you installed devkitPro to the default location (`C:\devkitPro`), a batch script is provided for your convenience that completely bypasses issues with spaces in folder names.

1. Double-click the `build.bat` file in the project's root directory.
2. It will automatically detect your `devkitPPC` environment variables, run CMake to generate build files, and compile.
3. If successful, this will produce `ftpii.elf` and `ftpii.dol` in the `build/` directory.

## Building with Visual Studio 2022 (Native CMake Support)

Visual Studio 2022 natively supports CMake, which is a much cleaner way to handle cross-platform code compilation without `NMake` wrappers or paths failing due to spaces.

1. Open Visual Studio 2022.
2. Select "Open a local folder" and open the `ftpii` root directory.
3. Visual Studio will automatically detect `CMakeLists.txt`.
4. To configure it for Wii, go to Project -> CMake settings, and add the following to CMake command arguments:
    `-DCMAKE_TOOLCHAIN_FILE=C:\devkitPro\cmake\Wii.cmake`
5. Press `Ctrl+Shift+B` to build.

## Building from Command Line (Linux/macOS/Windows)

If you prefer building manually or are on a different operating system:

1. Open a terminal (or MSYS2 environment if on Windows).
2. Ensure `DEVKITPRO` and `DEVKITPPC` are set in your environment.
    ```bash
    export DEVKITPRO=/opt/devkitpro
    export DEVKITPPC=/opt/devkitpro/devkitPPC
    ```
    On Windows MSYS2, it's typically `/c/devkitPro`.
3. Navigate to the root directory of the ftpii repository.
4. Run `make` (if your path doesn't contain spaces) OR use CMake (which handles spaces flawlessly):
    ```bash
    mkdir build
    cd build
    cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE="$DEVKITPRO/cmake/Wii.cmake" ..
    make
    ```
5. If successful, this will produce `ftpii.elf` and `ftpii.dol`.