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

include(ExternalProject)
include(msbuildSetExternalProperties)
include (msbuildRequireArg)

set(DIR_OF_PROTO_EXTERNAL ${CMAKE_CURRENT_LIST_DIR})  

function(msbuild_external_package)
  set(options)
  set(one_value_args URL URL_MD5 DOWNLOAD_DIR)
  set(multi_value_args REQUIRED_VARS CMAKE_ARGS)
message("ORG ${ARGN}")
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  msbuild_require_arg("URL" ${ARG_URL})
  msbuild_require_arg("DOWNLOAD_DIR" ${ARG_DOWNLOAD_DIR})
  msbuild_require_arg("URL_MD5" ${ARG_URL_MD5})

message("IN EXT PROT ${CMAKE_CURRENT_LIST_DIR} ${DIR_OF_PROTO_EXTERNAL}")

  if(NOT("${ARG_UNPARSED_ARGUMENTS}" STREQUAL ""))
    message(FATAL_ERROR "invalid argument ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  set(cmake_args
    ${ARG_CMAKE_ARGS}
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DBUILD_SHARED_LIBS=ON                                                         
    -Dprotobuf_BUILD_EXAMPLES=OFF
    -Dprotobuf_BUILD_SHARED_LIBS=ON
    -Dprotobuf_BUILD_TESTS=OFF
    -Dprotobuf_INSTALL_EXAMPLES=OFF
  )

  msbuild_set_external_properties(NAME "protobuf" 
    INSTALL_DIR install_dir 
    SOURCE_DIR source_dir)

  # Python protobuf
  find_package(PythonInterp 3.5 REQUIRED)
  find_package(bash REQUIRED)

  set(PROTOBUF_PROTOC "${install_dir}/bin/protoc")
  set(PROTOBUF_LIBPROTOBUF_PATH "${install_dir}/lib")
  set(PROTOBUF_PYTHON_SOURCE "${source_dir}/python")
  set(PROTOBUF_PYTHON_INSTALL "${install_dir}")
  set(PROTOBUF_CMAKE_EXECUTABLE "${CMAKE_COMMAND}")
  set(PROTOBUF_PYTHON_EXECUTABLE "${PYTHON_EXECUTABLE}")

  set(install_script_in "${DIR_OF_PROTO_EXTERNAL}/templates/protobuf_python_install_script.sh.in")
  set(install_script "${CMAKE_CURRENT_BINARY_DIR}/protobuf_python_install_script.sh")
  configure_file(${install_script_in} ${install_script} @ONLY)

  message("DOING   DOWNLOAD_DIR ${DOWNLOAD_DIR}
    URL ${protobuf_url}
    URL_MD5 ${protobuf_md5}
    SOURCE_DIR ${source_dir}
    INSTALL_DIR ${install_dir}
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -G ${CMAKE_GENERATOR} <SOURCE_DIR>/cmake ${cmake_args}
    STEP_TARGETS python-build 
  ")

  message("${CMAKE_CURRENT_BINARY_DIR} ${PROJECT_BINARY_DIR}")


message("TURU 
    DOWNLOAD_DIR ${ARG_DOWNLOAD_DIR}
    URL ${ARG_URL}
    URL_MD5 ${ARG_URL_MD5}
    SOURCE_DIR ${source_dir}
    INSTALL_DIR ${install_dir}
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -G ${CMAKE_GENERATOR} <SOURCE_DIR>/cmake ${cmake_args}
")
  # C++ protobuf
  ExternalProject_Add(protobuf
    DOWNLOAD_DIR ${ARG_DOWNLOAD_DIR}
    URL ${ARG_URL}
    URL_MD5 ${ARG_URL_MD5}
    SOURCE_DIR "${source_dir}"
    INSTALL_DIR "${install_dir}"
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -G ${CMAKE_GENERATOR} <SOURCE_DIR>/cmake ${cmake_args}
    STEP_TARGETS python-build 
  )
  ExternalProject_Add_Step(
    protobuf python-build
    COMMAND ${BASH_EXECUTABLE} ${install_script}
    DEPENDEES build
  )

  ExternalProject_Get_Property(protobuf install_dir)
  set(Protobuf_DIR "${install_dir}/lib/cmake/protobuf" CACHE INTERNAL "")

  list(APPEND GTCLANG_ALL_THIRDPARTY_CMAKE_ARGS "-DProtobuf_DIR:PATH=${Protobuf_DIR}")

endfunction()
