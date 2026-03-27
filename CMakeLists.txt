cmake_minimum_required(VERSION 3.13)

# If we are building for the Wii, devkitPro's toolchain file should be used.
# E.g. cmake -DCMAKE_TOOLCHAIN_FILE=C:/devkitPro/cmake/Wii.cmake
if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
    message(WARNING "Building natively without a toolchain file. Make sure you use the Wii toolchain if you intend to build for the Wii: -DCMAKE_TOOLCHAIN_FILE=$ENV{DEVKITPRO}/cmake/Wii.cmake")
endif()

project(ftpii C)

# Only add Wii specifics if the devkitPro Wii toolchain is active
if(WII)
    # Required Wii libraries
    set(WII_LIBS ntfs seeprom otp isfs nandimg fst wod iso di wiiuse bte fat ogc m)

    # Main executable
    add_executable(ftpii
        source/reset.c
        source/dvd.c
        source/pad.c
        source/net.c
        source/fs.c
        source/ftp.c
        source/loader.c
        source/vrt.c
        source/dol.c
        source/ftpii.c
        source/preloader.c
    )

    # Include directories
    target_include_directories(ftpii PRIVATE source)

    # Link libraries
    target_link_libraries(ftpii ${WII_LIBS})

    # Linker flags for Wii
    target_link_options(ftpii PRIVATE "-Wl,-Map,ftpii.map,--section-start,.init=0x80a00000")

    # Generate .dol from the compiled .elf automatically using wii_create_dol (provided by WII toolchain)
    if(COMMAND wii_create_dol)
        wii_create_dol(ftpii)
    endif()
endif()
