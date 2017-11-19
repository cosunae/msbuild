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

include(CMakeParseArguments)

#.rst:
# msbuild_add_custom_dummy_target
# --------------------------------
#
# Creates a dummy target with list of C++ files contained in the list of provided directories.
# The function is used to create dummy targets with files that are not included in any other target
# of the project so that qt creator loads them in the project.
# 
# .. code-block:: cmake
#
#   msbuild_add_custom_dummy_target(NAME DIRECTORIES)
#
# * Input arguments:
#
#  ``NAME:STRING``
#    Name of the dummy custom target
#  ``DIRECTORIES:STRING``
#    List of directories that contain the source files
#
function(msbuild_add_custom_dummy_target)
  # Parse arguments
  set(options)
  set(one_value_args NAME)
  set(multi_value_args DIRECTORIES)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  set(all_files "")
  foreach(dir ${ARG_DIRECTORIES})

    file(GLOB test_sources "${dir}/*.cpp" "${dir}/*.hpp" "${dir}/*.h")

    list(APPEND all_files ${test_sources} ${test_headers})
  endforeach(dir)

  add_custom_target(${ARG_NAME} ALL SOURCES ${all_files})
endfunction()

