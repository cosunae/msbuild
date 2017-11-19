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
# .. _msbuild_export_package:
#
# msbuild_export_package
# -------------------
#
# Export a package by defining variable for its libraries, include directories, definition and 
# version.
#
# .. code-block:: cmake
#
#   msbuild_export_package(NAME FOUND [LIBRARIES] [INCLUDE_DIRS] 
#                          [DEFINITIONS] [VERSION] [EXECUTABLE])
#
# ``NAME``
#   Name of the package.
# ``FOUND``
#   True if the package was found.
# ``LIBRAREIS``
#   List of libraries to link against (optional).
# ``INCLUDE_DIRS``
#   List of include directories required by this package (optional).
# ``DEFINITIONS``
#   List of definitions required by the package (optional).
# ``EXECUTABLE``
#   Exectuable of the package (optional).
# ``VERSION``
#   Version of the package (optional).
#
# The following variables are defined:
#
# ``MSBUILD_<NAME>_FOUND``
#   True if package was found.
# ``MSBUILD_<NAME>_LIBRARIES``
#   Libraries of the package to link against.
# ``MSBUILD_<NAME>_INCLUDE_DIRS``
#   Include directories required by this package.
# ``MSBUILD_<NAME>_DEFINITIONS``
#   Definitions required by the package.
# ``MSBUILD_<NAME>EXECUTABLE``
#   Executable of the package.
# ``MSBUILD_<NAME>_VERSION``
#   Version string of the package.
#
# To create a formatted string of the exported packages :ref:`msbuild_create_package_string`.
#
function(msbuild_export_package)
  set(options)
  set(one_value_args NAME FOUND VERSION EXECUTABLE)
  set(multi_value_args LIBRARIES INCLUDE_DIRS DEFINITIONS)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})
  
  if(NOT("${ARG_UNPARSED_ARGUMENTS}" STREQUAL ""))
    message(FATAL_ERROR "invalid argument ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  if(NOT(DEFINED ARG_NAME))
    message(FATAL_ERROR "msbuild_export_package: NAME variable required")
  endif()

  if(NOT(DEFINED ARG_FOUND))
    message(FATAL_ERROR "msbuild_export_package: FOUND variable required")
  endif()

  string(TOUPPER ${ARG_NAME} package)

  set("MSBUILD_${package}_FOUND" ${ARG_FOUND} CACHE BOOL "${ARG_PACKAGE} found" FORCE)
  mark_as_advanced("MSBUILD_${package}_FOUND")

  if(DEFINED ARG_LIBRARIES)  
    set("MSBUILD_${package}_LIBRARIES" ${ARG_LIBRARIES} CACHE 
        STRING "Libraries of package: ${ARG_PACKAGE}" FORCE)
    mark_as_advanced("MSBUILD_${package}_LIBRARIES")
  endif()

  if(DEFINED ARG_INCLUDE_DIRS)  
    set("MSBUILD_${package}_INCLUDE_DIRS" ${ARG_INCLUDE_DIRS} CACHE 
        STRING "Include directories of package: ${ARG_PACKAGE}" FORCE)
    mark_as_advanced("MSBUILD_${package}_INCLUDE_DIRS")
  endif()

  if(DEFINED ARG_DEFINITIONS)
    set("MSBUILD_${package}_DEFINITIONS" ${ARG_DEFINITIONS} CACHE 
        STRING "Definitions of package: ${ARG_PACKAGE}" FORCE)
    mark_as_advanced("MSBUILD_${package}_DEFINITIONS")
  endif()

  if(DEFINED ARG_EXECUTABLE)
    set("MSBUILD_${package}_EXECUTABLE" ${ARG_EXECUTABLE} CACHE 
        STRING "Exectuable of package: ${ARG_PACKAGE}" FORCE)
    mark_as_advanced("MSBUILD_${package}_EXECUTABLE")
  endif()

  if(DEFINED ARG_VERSION)
    set("MSBUILD_${package}_VERSION" ${ARG_VERSION} CACHE 
        STRING "Version of package: ${ARG_PACKAGE}" FORCE)
    mark_as_advanced("MSBUILD_${package}_VERSION")
  endif()
endfunction()
