# ftpii Build Guide

This document describes how to build the ftpii server for the Nintendo Wii.
ftpii uses the `devkitPPC` toolchain and the `libogc` library.

## Prerequisites

1.  **devkitPro**: Install devkitPro via the automated installers provided on their website (https://devkitpro.org/wiki/Getting_Started).
2.  **devkitPPC & libogc**: During installation, ensure you select the components to install `devkitPPC` and `libogc`.
3.  **Environment Variables**: Ensure `DEVKITPRO` and `DEVKITPPC` are set in your environment. For example, on Linux:
    ```bash
    export DEVKITPRO=/opt/devkitpro
    export DEVKITPPC=/opt/devkitpro/devkitPPC
    ```
    On Windows, the devkitPro installer usually sets these automatically (e.g., `C:\devkitPro` and `C:\devkitPro\devkitPPC`).

## Building from Command Line

1. Open a terminal (or MSYS2 environment if on Windows).
2. Navigate to the root directory of the ftpii repository.
3. Run `make`:
    ```bash
    make
    ```
4. To clean the build artifacts, run `make clean`.

If successful, this will produce `ftpii.elf` and `ftpii.dol` in the project root directory.

## Building with Visual Studio 2022

A `.sln` and `.vcxproj` file are provided to allow opening, editing, and building the project natively within Visual Studio 2022.

1. Ensure the C++ Desktop Development workload is installed in Visual Studio 2022.
2. Open `ftpii.sln` in Visual Studio 2022.
3. Ensure your `DEVKITPRO` and `DEVKITPPC` environment variables are set globally in Windows, or the `Makefile` command will fail.
4. The project is configured as a "Makefile" project (NMake). Building the project from within Visual Studio (e.g., `Ctrl+Shift+B`) will automatically invoke `make` in the background.
5. Cleaning the project will similarly invoke `make clean`.
6. IntelliSense is configured to look in `C:\devkitPro\libogc\include` by default. If you installed devkitPro to a different path, you may need to update the `IncludePath` in the project properties under "NMake" settings to match your local installation.