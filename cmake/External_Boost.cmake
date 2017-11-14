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

if("${CMAKE_CURRENT_BINARY_DIR}" MATCHES " ")
  message(FATAL_ERROR "cannot use boost-bootstrap with a space in the name of the build diretory")
endif()

# Build system library which disables all other libraries
set(boost_args "--with-system")

if(BUILD_SHARED_LIBS)
  list(APPEND boost_args "link=shared")
else()
  list(APPEND boost_args "link=static")
endif()

ExternalProject_Add(boost
  DOWNLOAD_DIR ${GTCLANG_ALL_DOWNLOAD_DIR}
  URL ${boost_url}
  URL_MD5 ${boost_md5}
  SOURCE_DIR "${CMAKE_CURRENT_BINARY_DIR}/boost"
  INSTALL_DIR "${GTCLANG_ALL_INSTALL_PREFIX}/boost"
  CONFIGURE_COMMAND ./bootstrap.sh --prefix=<INSTALL_DIR>
  BUILD_COMMAND ./b2 --prefix=<INSTALL_DIR> address-model=64 ${boost_args}
  INSTALL_COMMAND ./b2 --prefix=<INSTALL_DIR> address-model=64 ${boost_args} install
  BUILD_IN_SOURCE 1
)

ExternalProject_Get_Property(boost install_dir)
set(BOOST_ROOT "${install_dir}" CACHE INTERNAL "")

list(APPEND GTCLANG_ALL_THIRDPARTY_CMAKE_ARGS
  "-DBOOST_ROOT:PATH=${BOOST_ROOT}"
  "-DBoost_INCLUDE_DIR:PATH=${BOOST_ROOT}/include"
  "-DBOOST_LIBRARYDIR:PATH=${BOOST_ROOT}/lib"
  "-DBoost_NO_SYSTEM_PATHS:BOOL=ON"
)