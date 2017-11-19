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
# dawn_get_architecture_info
# --------------------------
#
# Get the identification of the architecture.
#
# .. code-block:: cmake
#
#   msbuild_get_architecture_info()
#
# The functions defines the following variable:
#
# ``MSBUILD_ARCHITECTURE_STRING``
#   String of the architecture.
#
macro(msbuild_get_architecture_info)
  set(MSBUILD_ARCHITECTURE_STRING "${CMAKE_SYSTEM_PROCESSOR}" 
    CACHE INTERNAL "Architecture string" FORCE)
endmacro()
