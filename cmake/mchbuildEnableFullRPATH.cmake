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

include(mchbuildIncludeGuard)
mchbuild_include_guard()

#.rst:
# mchbuild_enable_full_rpath
# ----------------------
#
# Enable full RPATH_ support.
#
# .. code-block:: cmake
#
#   mchbuild_enable_full_rpath(LIB_PREFIX)
#
# ``LIB_PREFIX``
#   Install prefix for libraries (e.g `lib`).
#
# .. _RPATH: https://cmake.org/Wiki/CMake_RPATH_handling
#
macro(mchbuild_enable_full_rpath LIB_PREFIX)
  # Use, i.e. don't skip the full RPATH for the build tree
  set(CMAKE_SKIP_BUILD_RPATH FALSE)

  # When building, don't use the install RPATH already (but later on when installing)
  set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE) 

  set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${LIB_PREFIX}")
  set(CMAKE_MACOSX_RPATH "${CMAKE_INSTALL_RPATH}")

  # Add the automatically determined parts of the RPATH which point to directories outside the 
  # build tree to the install RPATH
  set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

  # The RPATH to be used when installing, but only if it's not a system directory
  list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES 
       "${CMAKE_INSTALL_PREFIX}/${LIB_PREFIX}" isSystemDir)
  if("${isSystemDir}" STREQUAL "-1")
     SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${LIB_PREFIX}")
  endif("${isSystemDir}" STREQUAL "-1")
endmacro()
