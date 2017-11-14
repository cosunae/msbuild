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

#.rst:
# mteobild_cmake_init
# ---------------
#
# Add the necessary paths to ``CMAKE_MODULE_PATH`` to use the functions, macros and modules of the 
# ``mteobild`` project. To find the ``mteobild`` modules the following directories are searched:
#
#  1. Check for ``MTEOBILD_ROOT`` (pointing to the root folder of the installation)
#  2. Check for ``mteobild_DIR`` (pointing to the directory containing ``mteobildConfig.cmake``, equivalent 
#     to ``${CMAKE_ROOT}/cmake``).
#  3. Check ``${CMAKE_CURRENT_LIST_DIR}/../mteobild``
#
# where ``CMAKE_CURRENT_LIST_DIR`` is the directory of the listfile currently being processed. Note 
# that this only checks for the CMake directory in thus also usuable with the source directory mteobild. 
#
# .. code-block:: cmake
#
#  include(mteobildCMakeInit)
#  mteobild_cmake_init()
#
macro(mteobild_cmake_init)
  set(mteobild_cmake_dir)
  
  # If mteobild_DIR points to the root directory (instead of <mteobild-dir>/cmake), we correct this here
  get_filename_component(mteobild_config_file "${mteobild_DIR}/cmake/mteobildConfig.cmake" ABSOLUTE)
  if(DEFINED mteobild_DIR AND EXISTS "${mteobild_config_file}")
    set(mteobild_DIR "${mteobild_DIR}/cmake" CACHE PATH "Path to mteobildConfig.cmake" FORCE)
  endif()  

  if(DEFINED mteobild_ROOT)
    set(mteobild_cmake_dir "${MTEOBILD_ROOT}/cmake/modules")
  elseif(NOT "$ENV{MTEOBILD_ROOT}" STREQUAL "")
    set(mteobild_cmake_dir "$ENV{MTEOBILD_ROOT}/cmake/modules")
  elseif(DEFINED mteobild_DIR)
    set(mteobild_cmake_dir "${mteobild_DIR}/modules")
  elseif(NOT "$ENV{mteobild_DIR}" STREQUAL "")
    set(mteobild_cmake_dir "$ENV{mteobild_DIR}/modules")
  elseif(EXISTS "${CMAKE_CURRENT_LIST_DIR}/../mteobild")
    set(mteobild_cmake_dir "${CMAKE_CURRENT_LIST_DIR}/../mteobild/cmake/modules")
    message(FATAL_ERROR "Could NOT find mteobild. (Try setting mteobild_ROOT in the env)")
  endif()

  get_filename_component(mteobild_cmake_dir ${mteobild_cmake_dir} ABSOLUTE)
  
  # Sanity check the CMake directory
  if(NOT EXISTS ${mteobild_cmake_dir})
    message(FATAL_ERROR "Invalid mteobild directory: ${mteobild_cmake_dir} (missing mteobild/cmake/modules)")
  endif()

  list(APPEND CMAKE_MODULE_PATH "${mteobild_cmake_dir}")
endmacro()
