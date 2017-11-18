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

#.rst:
# msbuild_include_guard
# ----------------------
#
# Prevent frequently-included CMake files from being re-parsed multiple times.
#
# .. code-block:: cmake
#
#   msbuild_include_guard()
#
macro(msbuild_include_guard)
  if(DEFINED "__MSBUILD_INCLUDE_GUARD_${CMAKE_CURRENT_LIST_FILE}")
    return()
  endif(DEFINED "__MSBUILD_INCLUDE_GUARD_${CMAKE_CURRENT_LIST_FILE}")

  set("__MSBUILD_INCLUDE_GUARD_${CMAKE_CURRENT_LIST_FILE}" 1)
endmacro()
