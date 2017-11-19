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

include(msbuildGetScriptDir)
include(CMakeParseArguments)

#.rst:
# msbuild_add_target_clang_format
# ----------------------------
#
# Provide a ``format`` target which runs clang-format_ recursively on all files in the provided 
# directories.
#
# .. code-block:: cmake
#
#  msbuild_add_target_clang_format(DIRECTORIES PATTERN)
#
# ``DIRECTORIES``
#   Directories to recursively traverse to find all files with extensions matching ``EXTENSION``.
# ``EXTENSION``
#   Extension to match, separated by ``;``. For example: ``".h;.cpp"``. 
#
# .. _clang-format: https://clang.llvm.org/docs/ClangFormat.html
#
function(msbuild_add_target_clang_format)
  set(options)
  set(one_value_args)
  set(multi_value_args DIRECTORIES EXTENSION)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})
  
  if(NOT("${ARG_UNPARSED_ARGUMENTS}" STREQUAL ""))
    message(FATAL_ERROR "msbuild_add_target_clang_format: invalid argument ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  if(NOT(CLANG-FORMAT_EXECUTABLE))
    return()
  endif()

  msbuild_get_script_dir(script_dir)

  # Set configure arguments
  set(CLANG-FORMAT_DIRECTORIES ${ARG_DIRECTORIES})
  set(CLANG-FORMAT_EXTENSION ${ARG_EXTENSION})

  set(input_script 
      ${script_dir}/msbuildAddTargetClangFormat-Script.cmake.in)
  set(output_script 
      ${CMAKE_BINARY_DIR}/msbuild-cmake/cmake/msbuildAddTargetClangFormat-Script-Format.cmake)
  
  configure_file(${input_script} ${output_script} @ONLY)
  
  add_custom_target(format
      COMMAND ${CMAKE_COMMAND} -P "${output_script}"
      COMMENT "Running clang-format"
  )
endfunction()
