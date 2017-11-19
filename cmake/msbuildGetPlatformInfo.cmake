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

include(msbuildIncludeGuard)
msbuild_include_guard()

#.rst:
# msbuild_get_platform_info
# -------------------------------------
#
# Get the identification string of the platform.
#
# .. code-block:: cmake
#
#   msbuild_get_platform_info()
#
# The functions defines the following variable:
#
# ``MSBUILD_PLATFORM_STRING``
#   String of the platform.
#
# and conditionally the following:
#
# ``MSBUILD_ON_WIN32``
#   Set to 1 if the platform is Win32-ish
# ``MSBUILD_ON_UNIX``
#   Set to 1 if the platform is Unix-ish
# ``MSBUILD_ON_APPLE``
#   Set to 1 if the platform is Darwin
# ``MSBUILD_ON_LINUX``
#   Set to 1 if the platform is Linux
#
macro(msbuild_get_platform_info)
  if(WIN32)
    set(MSBUILD_ON_WIN32 1 CACHE INTERNAL "Platform is Win32-ish" FORCE)
    set(MSBUILD_PLATFORM_STRING "Windows" CACHE INTERNAL "Platform-id string" FORCE)
  elseif(APPLE)
    set(MSBUILD_ON_UNIX 1 CACHE INTERNAL "Platform is Unix-ish" FORCE)
    set(MSBUILD_ON_APPLE 1 CACHE INTERNAL "Platform is Darwin" FORCE)
    set(MSBUILD_PLATFORM_STRING "Darwin" CACHE INTERNAL "Platform-id string" FORCE)
  elseif(UNIX)
    set(MSBUILD_ON_UNIX 1 CACHE INTERNAL "Platform is Unix-ish" FORCE)
    set(MSBUILD_ON_LINUX 1 CACHE INTERNAL "Platform is Linux" FORCE)
    set(MSBUILD_PLATFORM_STRING "Linux" CACHE INTERNAL "Platform-id string" FORCE)
  endif()
endmacro()
