cmake_minimum_required(VERSION 3.13)
project(ftpii C)

# Gather source files, exclude preloader stuff which is a legacy wrapper
file(GLOB SOURCE_FILES "source/*.c")
list(REMOVE_ITEM SOURCE_FILES "${CMAKE_CURRENT_SOURCE_DIR}/source/preloader.c")

add_executable(${PROJECT_NAME} ${SOURCE_FILES})

# Link necessary Wii libraries
target_link_libraries(${PROJECT_NAME}
    fat
    wiiuse
    bte
    ogc
    m
)

# Set custom link flags if DEVKITPPC is used
set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-g -mrvl -mcpu=750 -meabi -mhard-float")

# elf2dol custom target
find_program(ELF2DOL elf2dol PATHS ENV DEVKITPPC PATH_SUFFIXES bin)

if(ELF2DOL)
    add_custom_command(
        TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${ELF2DOL} $<TARGET_FILE:${PROJECT_NAME}> ${PROJECT_NAME}.dol
        COMMENT "Converting ELF to DOL"
    )
endif()
