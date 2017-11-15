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

include(msbuildSetDownloadDir)
include(msbuildFindPackage)

# Set the default download directory (define GTCLANG_ALL_DOWNLOAD_DIR)
msbuild_set_download_dir()

#set(GTCLANG_ALL_INSTALL_PREFIX "${PROJECT_BINARY_DIR}/prefix")
#set(GTCLANG_ALL_PACKAGE_INFO)
#set(GTCLANG_ALL_PACKAGE_CMAKE_ARGS
#  "-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}"
#  "-DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}"
#  "-DCMAKE_CXX_COMPILER:PATH=${CMAKE_CXX_COMPILER}"
#  "-DCMAKE_C_COMPILER:PATH=${CMAKE_C_COMPILER}"
#)
#set(GTCLANG_ALL_THIRDPARTY_CMAKE_ARGS)

#
# Protobuf
#
set(protobuf_version "3.4.0")
set(protobuf_version_short "3.4")
set(protobuf_url "https://github.com/google/protobuf/archive/v${protobuf_version}.tar.gz")
set(protobuf_md5 "1d077a7d4db3d75681f5c333f2de9b1a")

msbuild_find_package(
  PACKAGE Protobuf
  PACKAGE_ARGS ${protobuf_version_short} NO_MODULE QUIET
  FORWARD_VARS Protobuf_DIR
  BUILD_VERSION ${protobuf_version}
)


# Prepare and export CMake variables of the external projects
#set(thirdparty_cmake_args ${GTCLANG_ALL_PACKAGE_CMAKE_ARGS} ${GTCLANG_ALL_THIRDPARTY_CMAKE_ARGS})
#set(GTCLANG_ALL_CMAKE_ARGS "${thirdparty_cmake_args}" CACHE INTERNAL "CMake arguments")

#dawn_report_result("Package summary" ${GTCLANG_ALL_PACKAGE_INFO})
