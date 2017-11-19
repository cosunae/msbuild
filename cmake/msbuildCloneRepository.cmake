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

include(CMakeParseArguments)
include(msbuildRequireArg)
include(msbuildIncludeGuard)

msbuild_include_guard()

#.rst:
# msbuild_clone_repository
# ----------------------------
#
# It clones the repository in the `${PROJECT_SOURCE_DIR}`
# If the project is already cloned, the function will return without any other action
# 
# .. code-block:: cmake
# 
#   msbuild_clone_repository(NAME URL BRANCH SOURCE_DIR)
#
# * Input arguments:
# 
#  ``NAME:STRING``
#    Name of the repository
#  ``URL:STRING``
#    url of the git repository
#  ``BRANCH:STRING``
#    branch of the respotory
#  ``SOURCE_DIR:STRING``
#    Root source directory where the package will be cloned
#
function(msbuild_clone_repository)
  set(options)
  set(one_value_args NAME URL BRANCH SOURCE_DIR)
  set(multi_value_args)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  msbuild_require_arg("ARG_UNPARSE_ARGUMENTS" ${ARG_UNPARSE_ARGUMENTS})
  msbuild_require_arg("ARG_NAME" ${ARG_NAME})
  msbuild_require_arg("ARG_SOURCE_DIR" ${ARG_SOURCE_DIR})

  string(TOUPPER ${ARG_NAME} upper_name)
  set(source_dir "${CMAKE_SOURCE_DIR}/${ARG_NAME}")

  # Check if repository exists
  if(EXISTS "${source_dir}")
    set("${ARG_SOURCE_DIR}" "${source_dir}" PARENT_SCOPE)
    message(STATUS "Using ${ARG_NAME}: ${source_dir}}")
  else()
    find_program(git_executable "git")
    if(NOT(git_executable))
      message(FATAL_ERROR "ERROR: git not FOUND!")
    endif()
    mark_as_advanced(git_executable)

    macro(run_git)
      unset(result)
      unset(out_var)
      unset(error_var)
      set(cmd "${git_executable}")
      foreach(arg ${ARGN})
        set(cmd ${cmd} "${arg}")
      endforeach()

      execute_process(
        COMMAND ${cmd}
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        RESULT_VARIABLE result
        OUTPUT_VARIABLE out_var
        ERROR_VARIABLE error_var
      )

      if(NOT("${result}" STREQUAL "0"))
        string(REPLACE ";" " " cmd_str "${cmd}")
        message(FATAL_ERROR "${error_var}\n\nERROR: failed to run\n\"${cmd_str}\"\n\n${error_var}")
      endif()
    endmacro()
    
    # Clone repository
    message(STATUS "Cloning ${ARG_NAME} from git: ${ARG_URL} ...")
    run_git("clone" "${ARG_URL}" "--branch=${ARG_BRANCH}" ${source_dir})
    message(STATUS "Successfully cloned ${ARG_NAME}")

    set("${ARG_SOURCE_DIR}" "${source_dir}" PARENT_SCOPE)
  endif()
endfunction()
