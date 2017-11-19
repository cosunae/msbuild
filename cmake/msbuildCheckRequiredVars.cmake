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
# msbuild_check_required_vars
# -------------------------------
#
# It checks that the list of `REQUIRED_VARS` is contained within the list of `SET_VARS`
# 
# .. code-block:: cmake
#   
#   msbuild_check_required_vars(SET_VARS "svars..." REQUIRED_VARS "rvars...")
#
# * Input arguments:
#
#  ``SET_VARS``
#   list of all variables that should contain the list of `REQUIRED_VARS`
#  ``REQUIRED_VARS``
#   list of variables that should be contained in the list of `SET_VARS`
#
function(msbuild_check_required_vars)

  set(options)
  set(one_value_args)
  set(multi_value_args SET_VARS REQUIRED_VARS)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  foreach(arg ${ARG_REQUIRED_VARS})
    if(NOT(${arg} IN_LIST ${ARG_SET_VARS}))
      message(FATAL_ERROR "A required variable, ${arg}, is not in present in the list of variables being set: ${ARG_SET_VARS}")
    endif()
  endforeach()

endfunction()
