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

include(msbuildIncludeGuard)
msbuild_include_guard()

#.rst:
# msbuild_require_arg
# ----------------------
#
# It errors if the argument passed is not defined.
# This function is used as a helper for other functions to ensure
# that required arguments are passed by user call
#
# .. code-block:: cmake
#
#   msbuild_require_arg(ARG)
#
# ``ARG``
#  - argument that is required
#

function(msbuild_require_arg ARG)
  if(ARGN STREQUAL "")
    message(FATAL_ERROR "missing required argument ${ARG}")
  endif()
endfunction()
