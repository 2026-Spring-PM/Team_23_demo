cmake_minimum_required(VERSION 3.16)
project(FarmVillageSimulator CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(MSVC)
    add_compile_options(/W4 /permissive- /utf-8 /wd4100 /wd4458)
else()
    add_compile_options(-Wall -Wextra -Wpedantic -Wno-unused-parameter)
endif()

# ---- SFML 2.5 or 2.6 ----
# On Linux:   apt install libsfml-dev (Ubuntu 22.04 -> 2.5.1, 24.04 -> 2.6.x)
# On Windows: install via vcpkg (.\vcpkg install sfml:x64-windows) -> 2.6.x,
#             pass -DCMAKE_TOOLCHAIN_FILE=<vcpkg>/scripts/buildsystems/vcpkg.cmake
# On macOS:   brew install sfml@2 -> 2.6.x
# We accept 2.5+ for compatibility -- the API surface we use is identical.
find_package(SFML 2.5 COMPONENTS graphics window system REQUIRED)

# ---- Sources ----
file(GLOB_RECURSE GAME_SRC CONFIGURE_DEPENDS
    "${CMAKE_SOURCE_DIR}/src/*.cpp"
    "${CMAKE_SOURCE_DIR}/src/*.h"
)

add_executable(farmvillage ${GAME_SRC})
target_include_directories(farmvillage PRIVATE ${CMAKE_SOURCE_DIR}/src)
target_link_libraries(farmvillage PRIVATE
    sfml-graphics
    sfml-window
    sfml-system
)

# Put the binary at the build root and mirror only the asset subdirs
# the runtime actually opens. assets/ currently holds ~94k files (the
# Modern Exteriors / Interiors / UI packs are source material for
# Tiled, NOT loaded by the game at runtime); a full copy_directory
# rescan made every incremental build pay for traversing all of them.
#
# Phase 170b: pre-156 baseline only opens assets/fonts/default.ttf
# (and falls back to system fonts if missing). When the visual rebuild
# starts wiring more dirs, add fv_mirror_dir(assets/<dir>) calls.
set_target_properties(farmvillage PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}
)

function(fv_mirror_dir subdir)
    set(src "${CMAKE_SOURCE_DIR}/${subdir}")
    if(NOT EXISTS "${src}")
        return()
    endif()
    add_custom_command(TARGET farmvillage POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
                "${src}"
                "$<TARGET_FILE_DIR:farmvillage>/${subdir}"
        COMMENT "Mirroring ${subdir} next to the binary"
        VERBATIM
    )
endfunction()

fv_mirror_dir(assets/fonts)
# Phase 173: title screen art (main_title_resize.png + real_title.png).
# Phase 174: tileset PNGs referenced by .tsx files in assets/map_design/.
fv_mirror_dir(assets/image_source)
# Phase 174: authored .tmj maps + .tsx tilesets opened at scene push by
# WorldScene (farm), HouseInteriorScene (player house) and
# AnimalInteriorScene (barn).
fv_mirror_dir(assets/map_design)

# Phase 181: bundled font now lives at the assets/ root (no fonts/ subdir).
# Copy the .ttf next to the binary so SFML can open it with the
# `assets/PixelSerif_16px_v02.ttf` relative path.
function(fv_mirror_file relpath)
    set(src "${CMAKE_SOURCE_DIR}/${relpath}")
    if(NOT EXISTS "${src}")
        return()
    endif()
    get_filename_component(reldir "${relpath}" DIRECTORY)
    add_custom_command(TARGET farmvillage POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory
                "$<TARGET_FILE_DIR:farmvillage>/${reldir}"
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
                "${src}"
                "$<TARGET_FILE_DIR:farmvillage>/${relpath}"
        COMMENT "Mirroring ${relpath} next to the binary"
        VERBATIM
    )
endfunction()
fv_mirror_file(assets/PixelSerif_16px_v02.ttf)
