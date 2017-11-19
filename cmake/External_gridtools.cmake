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
  set(one_value_args DOWNLOAD_DIR GIT_REPOSITORY GIT_TAG MSBUILD_ROOT)
  set(multi_value_args REQUIRED_VARS CMAKE_ARGS)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  msbuild_require_arg("MSBUILD_ROOT" ${ARG_MSBUILD_ROOT})
  msbuild_require_arg("GIT_REPOSITORY" ${ARG_GIT_REPOSITORY})

  if(NOT("${ARG_UNPARSED_ARGUMENTS}" STREQUAL ""))
    message(FATAL_ERROR "invalid argument ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  msbuild_set_external_properties(NAME "gridtools" 
    INSTALL_DIR install_dir 
    SOURCE_DIR source_dir)

  list(APPEND ARG_CMAKE_ARGS -DMSBUILD_ROOT=${ARG_MSBUILD_ROOT} -DSTRUCTURED_GRID=ON -DDISABLE_TESTING=ON)

  # C++ protobuf
  ExternalProject_Add(gridtools
    DOWNLOAD_DIR ${ARG_DOWNLOAD_DIR}
    GIT_REPOSITORY ${ARG_GIT_REPOSITORY}
    GIT_TAG ${ARG_GIT_TAG}
    SOURCE_DIR "${source_dir}"
    INSTALL_DIR "${install_dir}"
    CMAKE_ARGS ${ARG_CMAKE_ARGS} 
  )

  msbuild_check_required_vars(SET_VARS "GridTools_DIR" REQUIRED_VARS ${ARG_REQUIRED_VARS})
  set(GridTools_DIR "${install_dir}" CACHE INTERNAL "")

endfunction()
