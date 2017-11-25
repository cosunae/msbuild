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

include(msbuildIncludeGuard)
msbuild_include_guard()

include(msbuildGetScriptDir)

#.rst:
# msbuild_add_target_clean_all
# -------------------------------
#
# Provide a ``clean-all`` target which clears the CMake cache and all related CMake files and 
# directories. This effectively removes the following files/directories:
#
#    - ``${CMAKE_BINARY_DIR}/CMakeCache.txt``
#    - ``${CMAKE_BINARY_DIR}/Makefile``
#    - ``${CMAKE_BINARY_DIR}/CTestTestfile.cmake``
#    - ``${CMAKE_BINARY_DIR}/cmake_install.cmake``
#    - ``${CMAKE_BINARY_DIR}/CMakeFiles``
#
# .. code-block:: cmake
#
#  msbuild_add_target_clean_all([dirs...])
#
# ``dirs``
#   Addtional files or directories to remove.
#
function(msbuild_add_target_clean_all)
  msbuild_get_script_dir(script_dir)
  set(msbuild_add_target_clean_all_extra_args ${ARGN})

  set(input_script ${script_dir}/msbuildAddTargetCleanAll-Script.cmake.in)
  set(output_script ${CMAKE_BINARY_DIR}/msbuild-cmake/cmake/msbuildAddTargetCleanAll-Script.cmake)

  # Configure the script
  configure_file(${input_script} ${output_script} @ONLY)

  add_custom_target(clean-all
      COMMAND ${CMAKE_MAKE_PROGRAM} clean
      COMMAND ${CMAKE_COMMAND} -P "${output_script}"
      COMMENT "Removing CMake related files"
  )
endfunction()
