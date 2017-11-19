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

get_filename_component(__msbuild_cmake_script_dir__ ${CMAKE_CURRENT_LIST_FILE} PATH)

#.rst:
# msbuild_get_script_dir
# ------------------------
#
# Get the directory of the scripts located ``<msbuild-root>/cmake/scripts``.
#
# .. code-block:: cmake
#
#   msbuild_get_script_dir(SCRIPT_DIR_VAR)
# 
# * Output arguments:
#
# ``SCRIPT_DIR_VAR``
#   Variable which will contain the script directory on output.
#
# .. note:: This function is for internal use only.
#
function(msbuild_get_script_dir SCRIPT_DIR_VAR)
  set(${SCRIPT_DIR_VAR} "${__msbuild_cmake_script_dir__}/scripts" PARENT_SCOPE)
endfunction()
