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

include(msbuildMakeStringPair)

#.rst:
# .. _msbuild_create_package_string:
#
# msbuild_create_package_string
# ---------------------------------------
#
# Create a package string including the location of the library/include directory and version 
# string. Note that the package has to be exported via :ref:`msbuild_export_package`.
#
# .. code-block:: cmake
#
#   msbuild_create_package_string(NAME PACKAGE_STRING [NOT_FOUND_STRING])
#
# ``NAME``
#   Name of the package.
# ``PACKAGE_STRING``
#   Returned package string.
# ``NOT_FOUND_STRING``
#   String to print of the package was not found, defaults to "Not FOUND" (optional).
#
# Example
# ^^^^^^^
# .. code-block:: cmake
#
#   msbuild_export_package(Foo FOUND TRUE LIBRARIES "/usr/lib/libfoo.so" VERSION "1.2.3")
#   msbuild_create_package_string(Foo FooPackageStr)
#   message(${FooPackageStr})
#
function(msbuild_create_package_string NAME PACKAGE_STRING)
  set(not_found_string "NOT found")
  if(NOT("${ARGV2}" STREQUAL ""))
    set(not_found_string "${ARGV2}")
  endif()

  string(TOUPPER ${NAME} package)
  if(NOT(DEFINED MSBUILD_${package}_FOUND) OR NOT(${MSBUILD_${package}_FOUND}))
     set(info "${not_found_string}")
  else()
    if(DEFINED MSBUILD_${package}_INCLUDE_DIRS)
      list(GET  MSBUILD_${package}_INCLUDE_DIRS 0 inc)
      set(info "${inc}")
    elseif(DEFINED MSBUILD_${package}_EXECUTABLE)
      list(GET MSBUILD_${package}_EXECUTABLE 0 exe)
      set(info "${exe}")
    else()
      set(info "found")
    endif()

    if(DEFINED MSBUILD_${package}_VERSION)
      set(info "${info} (ver ${MSBUILD_${package}_VERSION})")
    endif()
  endif()

  msbuild_make_string_pair(${NAME} ${info} 20 out_string)
  set(${PACKAGE_STRING} ${out_string} PARENT_SCOPE)
endfunction()
