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


function(msbuild_require_only_one_of)
  set(options)
  set(one_value_args NAME1 NAME2)
  set(multi_value_args GROUP1 GROUP2)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  if((NOT ARG_GROUP1) AND (NOT ARG_GROUP2))
    message(FATAL_ERROR "Need to specify at least parameters of one of the two groups: ${ARG_NAME1} or ${ARG_NAME2}")
  endif()
  if( (ARG_GROUP1) AND (ARG_GROUP2))
    message(FATAL_ERROR "You can not specify simultaneously properties of the two groups: ${ARG_NAME1} or ${ARG_NAME2}: ${ARG_GROUP1} ; ${ARG_GROUP2}")
  endif()

endfunction()
