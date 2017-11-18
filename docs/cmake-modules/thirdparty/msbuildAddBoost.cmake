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

#
# Boost
#
set(boost_min_version 1.58.0)
set(_v 63)
set(boost_download_version 1.${_v}.0)

msbuild_find_package(
  PACKAGE Boost
  PACKAGE_ARGS ${boost_min_version} 
  COMPONENTS ${boost_components}
  REQUIRED_VARS BOOST_ROOT Boost_LIBRARY_DIRS Boost_INCLUDE_DIRS
  ADDITIONAL
    DOWNLOAD_DIR ${MSBUILD_DOWNLOAD_DIR}
    URL "http://sourceforge.net/projects/boost/files/boost/1.${_v}.0/boost_1_${_v}_0.tar.gz/download"
    URL_MD5 "7b493c08bc9557bbde7e29091f28b605" 
    BUILD_VERSION ${boost_download_version}
)

#dawn_report_result("Package summary" ${GTCLANG_ALL_PACKAGE_INFO})

