##===------------------------------------------------------------------------------*- CMake -*-===##
##                         _       _
##                        | |     | |
##                    __ _| |_ ___| | __ _ _ __   __ _ 
##                   / _` | __/ __| |/ _` | '_ \ / _` |
##                  | (_| | || (__| | (_| | | | | (_| |
##                   \__, |\__\___|_|\__,_|_| |_|\__, | - GridTools Clang DSL
##                    __/ |                       __/ |
##                   |___/                       |___/
##
##
##  This file is distributed under the MIT License (MIT). 
##  See LICENSE.txt for details.
##
##===------------------------------------------------------------------------------------------===##

include(ExternalProject)
include(GTClangAddOptionalDeps)
include(GTClangAllMakeCMakeScript)

set(dawn_cmake_args ${GTCLANG_ALL_CMAKE_ARGS})
foreach(option ${DAWN_OPTIONS})
  list(APPEND dawn_cmake_args "-D${option}:BOOL=${${option}}")
endforeach()

set(dawn_source "${GTCLANG_ALL_DAWN_SOURCE_DIR}")
set(dawn_build "${CMAKE_CURRENT_BINARY_DIR}/dawn")

gtclang_all_add_optional_deps(dawn_deps protobuf)

ExternalProject_Add(dawn
   DOWNLOAD_DIR ${GTCLANG_ALL_DOWNLOAD_DIR}
   SOURCE_DIR ${dawn_source}
   BINARY_DIR ${dawn_build}
   INSTALL_DIR "${CMAKE_INSTALL_PREFIX}"
   CMAKE_ARGS
     ${dawn_cmake_args}
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
   DEPENDS
     ${dawn_deps}
)

ExternalProject_Get_Property(dawn install_dir)
set(DAWN_ROOT "${install_dir}" CACHE INTERNAL "")

gtclang_all_make_cmake_script(${dawn_source} ${dawn_build} ${dawn_cmake_args})

list(APPEND GTCLANG_ALL_CMAKE_ARGS "-DDAWN_ROOT:PATH=${DAWN_ROOT}")