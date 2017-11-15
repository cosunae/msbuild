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
# Boost
#
set(boost_min_version 1.58.0)
set(_v 63)
set(boost_download_version 1.${_v}.0)
set(boost_url 
    "http://sourceforge.net/projects/boost/files/boost/1.${_v}.0/boost_1_${_v}_0.tar.gz/download")
set(boost_md5 "7b493c08bc9557bbde7e29091f28b605")

msbuild_find_package(
  PACKAGE Boost
  PACKAGE_ARGS ${boost_min_version} COMPONENTS ${boost_components}
  FORWARD_VARS BOOST_ROOT Boost_LIBRARY_DIRS Boost_INCLUDE_DIRS
  BUILD_VERSION ${boost_download_version}
)

# Prepare and export CMake variables of the external projects
#set(thirdparty_cmake_args ${GTCLANG_ALL_PACKAGE_CMAKE_ARGS} ${GTCLANG_ALL_THIRDPARTY_CMAKE_ARGS})
#set(GTCLANG_ALL_CMAKE_ARGS "${thirdparty_cmake_args}" CACHE INTERNAL "CMake arguments")

#dawn_report_result("Package summary" ${GTCLANG_ALL_PACKAGE_INFO})
