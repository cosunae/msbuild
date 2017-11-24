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
include(msbuildRequireOnlyOneOf)
include(msbuildCheckRequiredVars)

set(DIR_OF_PROTO_EXTERNAL ${CMAKE_CURRENT_LIST_DIR})  

function(msbuild_external_package)
  set(options)
  set(one_value_args URL URL_MD5 DOWNLOAD_DIR SOURCE_DIR GIT_REPOSITORY GIT_TAG MSBUILD_ROOT)
  set(multi_value_args REQUIRED_VARS FORWARD_VARS CMAKE_ARGS)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  msbuild_require_arg("MSBUILD_ROOT" ${ARG_MSBUILD_ROOT})
  msbuild_require_only_one_of2(NAME1 "SOURCE_DIR" NAME2 "GIT"
         GROUP1 ${ARG_SOURCE_DIR}
         GROUP2 ${ARG_GIT_REPOSITORY} ${ARG_GIT_TAG})

  if(NOT("${ARG_UNPARSED_ARGUMENTS}" STREQUAL ""))
    message(FATAL_ERROR "invalid argument ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  msbuild_set_external_properties(NAME "dawn" 
    INSTALL_DIR install_dir 
    SOURCE_DIR source_dir
    BINARY_DIR binary_dir
  )

  list(APPEND ARG_CMAKE_ARGS "-DMSBUILD_ROOT=${ARG_MSBUILD_ROOT}")

  # set the install path to bundle project install dir
  set(ARG_CMAKE_ARGS ${ARG_CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>)
  # C++ protobuf
  if(ARG_GIT_REPOSITORY)
    ExternalProject_Add(dawn
      PREFIX dawn-prefix
      GIT_REPOSITORY ${ARG_GIT_REPOSITORY}
      GIT_TAG ${ARG_GIT_TAG}
      SOURCE_SUBDIR "bundle"
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

  if(DEFINED ARG_FORWARD_VARS)
    set(options)
    set(one_value_args BINARY_DIR)
    set(multi_value_args)
    cmake_parse_arguments(ARGFV "${options}" "${one_value_args}" "${multi_value_args}" ${ARG_FORWARD_VARS})

    if(NOT("${ARGFV_UNPARSED_ARGUMENTS}" STREQUAL ""))
      message(FATAL_ERROR "invalid argument for FORWARD_VARS ${ARGFV_UNPARSED_ARGUMENTS}")
    endif()

    set(${ARGFV_BINARY_DIR} ${binary_dir} PARENT_SCOPE)

  endif()
  msbuild_check_required_vars(SET_VARS dawn_DIR REQUIRED_VARS ${ARG_REQUIRED_VARS})
  set(dawn_DIR "${binary_dir}/prefix/dawn/cmake" CACHE INTERNAL "")

endfunction()
