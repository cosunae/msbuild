##===-------------------------------------------------------------------------------------------===##
##                        _..._                                                          
##                     .-'_..._''.                                    .---._______       
##  __  __   ___     .' .'      '.\  .         /|                 .--.|   |\  ___ `'.    
## |  |/  `.'   `.  / .'           .'|         ||                 |__||   | ' |--.\  \   
## |   .-.  .-.   '. '            <  |         ||                 .--.|   | | |    \  '  
## |  |  |  |  |  || |             | |         ||  __             |  ||   | | |     |  ' 
## |  |  |  |  |  || |             | | .'''-.  ||/'__ '.   _    _ |  ||   | | |     |  | 
## |  |  |  |  |  |. '             | |/.'''. \ |:/`  '. ' | '  / ||  ||   | | |     ' .' 
## |  |  |  |  |  | \ '.          .|  /    | | ||     | |.' | .' ||  ||   | | |___.' /'  
## |__|  |__|  |__|  '. `._____.-'/| |     | | ||\    / '/  | /  ||__||   |/_______.'/   
##                     `-.______ / | |     | | |/\'..' /|   `'.  |    '---'\_______|/    
##                              `  | '.    | '.'  `'-'` '   .'|  '/                      
##                                 '---'   '---'         `-'  `--'                       
##
##  This file is distributed under the MIT License (MIT). 
##  See LICENSE.txt for details.
##
##===------------------------------------------------------------------------------------------===##

#.rst:
# msbuild_cmake_init
# --------------------
#
# Add the necessary paths to ``CMAKE_MODULE_PATH`` to use the functions, macros and modules of the 
# ``msbuild`` project. To find the ``msbuild`` modules the following directories are searched:
#
#  1. Check for ``MSBUILD_ROOT`` (pointing to the root folder of the installation)
#  2. Check for ``msbuild_DIR`` (pointing to the directory containing ``msbuildConfig.cmake``, equivalent 
#     to ``${CMAKE_ROOT}/cmake``).
#  3. Check ``${CMAKE_CURRENT_LIST_DIR}/../msbuild``
#
# where ``CMAKE_CURRENT_LIST_DIR`` is the directory of the listfile currently being processed. Note 
# that this only checks for the CMake directory in thus also usuable with the source directory msbuild. 
#
# .. code-block:: cmake
#
#  include(msbuildCMakeInit)
#  msbuild_cmake_init()
#
macro(msbuild_cmake_init)
  set(msbuild_cmake_dir)
  
  # If msbuild_DIR points to the root directory (instead of <msbuild-dir>/cmake), we correct this here
  get_filename_component(msbuild_config_file "${msbuild_DIR}/cmake/msbuildConfig.cmake" ABSOLUTE)
  if(DEFINED msbuild_DIR AND EXISTS "${msbuild_config_file}")
    set(msbuild_DIR "${msbuild_DIR}/cmake" CACHE PATH "Path to msbuildConfig.cmake" FORCE)
  endif()  

  if(DEFINED msbuild_ROOT)
    set(msbuild_cmake_dir "${MSBUILD_ROOT}/cmake/modules")
  elseif(NOT "$ENV{MSBUILD_ROOT}" STREQUAL "")
    set(msbuild_cmake_dir "$ENV{MSBUILD_ROOT}/cmake/modules")
  elseif(DEFINED msbuild_DIR)
    set(msbuild_cmake_dir "${msbuild_DIR}/modules")
  elseif(NOT "$ENV{msbuild_DIR}" STREQUAL "")
    set(msbuild_cmake_dir "$ENV{msbuild_DIR}/modules")
  elseif(EXISTS "${CMAKE_CURRENT_LIST_DIR}/../msbuild")
    set(msbuild_cmake_dir "${CMAKE_CURRENT_LIST_DIR}/../msbuild/cmake/modules")
    message(FATAL_ERROR "Could NOT find msbuild. (Try setting msbuild_ROOT in the env)")
  endif()

  get_filename_component(msbuild_cmake_dir ${msbuild_cmake_dir} ABSOLUTE)
  
  # Sanity check the CMake directory
  if(NOT EXISTS ${msbuild_cmake_dir})
    message(FATAL_ERROR "Invalid msbuild directory: ${msbuild_cmake_dir} (missing msbuild/cmake/modules)")
  endif()

  list(APPEND CMAKE_MODULE_PATH "${msbuild_cmake_dir}")
endmacro()
