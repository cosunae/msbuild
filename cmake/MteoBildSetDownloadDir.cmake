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

# mteobild_set_download_dir
# ----------------------------
#
# This script defines a MTEOBILD_DOWNLOAD_DIR variable, if it's not already defined.
#
# Cache the downloads in MTEOBILD_DOWNLOAD_DIR if it's defined. Otherwise, use the user's typical 
# Downloads directory, if it already exists. Otherwise, use a Downloads subdir in the build tree.
#
macro(mteobild_set_download_dir)
  if(NOT DEFINED MTEOBILD_DOWNLOAD_DIR)
    if(NOT "$ENV{HOME}" STREQUAL "" AND EXISTS "$ENV{HOME}/Downloads")
      set(MTEOBILD_DOWNLOAD_DIR "$ENV{HOME}/Downloads")
    elseif(NOT "$ENV{USERPROFILE}" STREQUAL "" AND EXISTS "$ENV{USERPROFILE}/Downloads")
      set(MTEOBILD_DOWNLOAD_DIR "$ENV{USERPROFILE}/Downloads")
    elseif(NOT "${CMAKE_CURRENT_BINARY_DIR}" STREQUAL "")
      set(MTEOBILD_DOWNLOAD_DIR "${CMAKE_CURRENT_BINARY_DIR}/Downloads")
    else()
      message(FATAL_ERROR "unexpectedly empty CMAKE_CURRENT_BINARY_DIR")
    endif()
    string(REPLACE "\\" "/" MTEOBILD_DOWNLOAD_DIR "${MTEOBILD_DOWNLOAD_DIR}")
  endif()

  file(MAKE_DIRECTORY "${MTEOBILD_DOWNLOAD_DIR}")
  if(NOT EXISTS "${MTEOBILD_DOWNLOAD_DIR}")
    message(FATAL_ERROR "could not find or make download directory")
  endif()
endmacro()
