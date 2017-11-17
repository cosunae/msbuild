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

include(ExternalProject)
include(msbuildSetExternalProperties)
include (msbuildRequireOnlyOneOf)

set(DIR_OF_PROTO_EXTERNAL ${CMAKE_CURRENT_LIST_DIR})  

function(msbuild_external_package)
  set(options)
  set(one_value_args URL URL_MD5 DOWNLOAD_DIR SOURCE_DIR)
  set(multi_value_args REQUIRED_VARS CMAKE_ARGS)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  msbuild_require_only_one_of(NAME1 "URL" NAME2 "SOURCE_DIR" 
         GROUP1 ${ARG_URL} ${ARG_DOWNLOAD_DIR} ${ARG_URL_MD5}
         GROUP2 ${ARG_SOURCE_DIR})

  if(NOT("${ARG_UNPARSED_ARGUMENTS}" STREQUAL ""))
    message(FATAL_ERROR "invalid argument ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  msbuild_set_external_properties(NAME "dawn" 
    INSTALL_DIR install_dir 
    SOURCE_DIR source_dir)

  # C++ protobuf
  if(ARG_URL)
    ExternalProject_Add(dawn
      DOWNLOAD_DIR ${ARG_DOWNLOAD_DIR}
      URL ${ARG_URL}
      URL_MD5 ${ARG_URL_MD5}
      SOURCE_DIR "${source_dir}"
      INSTALL_DIR "${install_dir}"
      CMAKE_ARGS ${ARG_CMAKE_ARGS}
    )
  else()
    ExternalProject_Add(dawn
      SOURCE_DIR ${ARG_SOURCE_DIR}
      INSTALL_DIR "${install_dir}"
      CMAKE_ARGS ${ARG_CMAKE_ARGS}
    )
  endif()

  set(dawn_DIR "${install_dir}/dawn" CACHE INTERNAL "")

endfunction()
