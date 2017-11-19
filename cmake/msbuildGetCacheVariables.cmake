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
# msbuild_get_cache_variables
# ----------------------------
#
# It returns, in the output variable, the list of cmake args used to 
# call cmake from command line
#
# .. code-block:: cmake
#
#   msbuild_get_cache_variables(CMAKE_ARGS)
# 
# * Output arguments:
#
# ``CMAKE_ARGS:LIST``
#   Variable which will contain the list of cmake arguments
#
function(msbuild_get_cache_variables CMAKE_ARGS_)
  get_cmake_property(CACHE_VARS CACHE_VARIABLES)

  set(CMAKE_ARGS "")
  foreach(CACHE_VAR ${CACHE_VARS})
    get_property(CACHE_VAR_HELPSTRING CACHE ${CACHE_VAR} PROPERTY HELPSTRING)
    if(CACHE_VAR_HELPSTRING STREQUAL "No help, variable specified on the command line.")
      get_property(CACHE_VAR_TYPE CACHE ${CACHE_VAR} PROPERTY TYPE)
      if(CACHE_VAR_TYPE STREQUAL "UNINITIALIZED")
        set(CACHE_VAR_TYPE)
      else()
        set(CACHE_VAR_TYPE :${CACHE_VAR_TYPE})
      endif()
      list(APPEND CMAKE_ARGS "-D${CACHE_VAR}${CACHE_VAR_TYPE}=${${CACHE_VAR}}")
    endif()
  endforeach()
  set(${CMAKE_ARGS_} ${CMAKE_ARGS} PARENT_SCOPE)
endfunction()
