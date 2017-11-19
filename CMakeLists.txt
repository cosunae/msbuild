##===------------------------------------------------------------------------------*- CMake -*-===##
##                          _                      
##                         | |                     
##                       __| | __ ___      ___ ___  
##                      / _` |/ _` \ \ /\ / / '_  | 
##                     | (_| | (_| |\ V  V /| | | |
##                      \__,_|\__,_| \_/\_/ |_| |_| - Compiler Toolchain
##
##
##  This file is distributed under the MIT License (MIT). 
##  See LICENSE.txt for details.
##
##===------------------------------------------------------------------------------------------===##

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING 
      "Choose the type of build, options are: Debug Release RelWithDebInfo." FORCE)
endif()

if(NOT BUILD_SHARED_LIBS)
  set(BUILD_SHARED_LIBS ON CACHE BOOL "Build shared libraries." FORCE)
endif()

if(NOT CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/install" CACHE STRING
      "Install path prefix, prepended onto install directories." FORCE)
endif()

project(msbuild NONE)
cmake_minimum_required(VERSION 3.3)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(msbuildAddTargetCleanAll)
include(msbuildGenerateCMakeScript)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set(MSBUILD_DOCUMENTATION ON CACHE BOOL "Build documentation" FORCE)

if(MSBUILD_DOCUMENTATION)

  find_package(Sphinx REQUIRED)
  add_subdirectory(docs)

endif()

# Add custom targets
msbuild_add_target_clean_all(
  ${CMAKE_SOURCE_DIR}/docs/cmake-modules
  ${CMAKE_BINARY_DIR}/msbuild-cmake
  ${CMAKE_BINARY_DIR}/sphinx
  ${CMAKE_BINARY_DIR}/docs
)

msbuild_generate_cmake_script(${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR})

