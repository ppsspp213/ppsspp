# Standard settings
set (CMAKE_SYSTEM_NAME QNX)
set (CMAKE_SYSTEM_VERSION 1)
set (CMAKE_PREFIX_PATH $ENV{QNX_TARGET}/usr)
set (CMAKE_INCLUDE_PATH $ENV{QNX_TARGET}/usr/include)
if (SIMULATOR)
	set (CMAKE_SYSTEM_PROCESSOR x86)
	set (CMAKE_LIBRARY_PATH $ENV{QNX_TARGET}/x86 $ENV{QNX_TARGET}/x86/usr)
else()
	set (CMAKE_SYSTEM_PROCESSOR armv7)
	set (CMAKE_LIBRARY_PATH $ENV{QNX_TARGET}/armle-v7 $ENV{QNX_TARGET}/armle-v7/usr)
endif()
set (UNIX True)
set (CMAKE_DL_LIBS)

set (CMAKE_FIND_ROOT_PATH ${CMAKE_PREFIX_PATH} ${CMAKE_LIBRARY_PATH} CACHE string  "Blackberry find search path root")
set (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

include (CMakeForceCompiler)
CMAKE_FORCE_C_COMPILER (nto${CMAKE_SYSTEM_PROCESSOR}-gcc-4.8.2 nto${CMAKE_SYSTEM_PROCESSOR}-gcc-4.8.2)
CMAKE_FORCE_CXX_COMPILER (nto${CMAKE_SYSTEM_PROCESSOR}-g++-4.8.2 nto${CMAKE_SYSTEM_PROCESSOR}-g++-4.8.2)
set (CMAKE_COMPILER_IS_GNUCXX True)
execute_process( COMMAND nto${CMAKE_SYSTEM_PROCESSOR}-gcc --version
OUTPUT_VARIABLE GCC_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE )
string( REGEX MATCH "[0-9]+.[0-9]+.[0-9]+" GCC_VERSION "${GCC_VERSION}" )
set (CMAKE_C_COMPILER_VERSION ${GCC_VERSION})
set (CMAKE_CXX_COMPILER_VERSION ${GCC_VERSION})

# Skip the platform compiler checks for cross compiling
set (CMAKE_CROSSCOMPILING TRUE)
set (CMAKE_C_COMPILER_WORKS TRUE)
set (CMAKE_CXX_COMPILER_WORKS TRUE)

add_definitions(-D_QNX_SOURCE -D__STDC_CONSTANT_MACROS)

if( CMAKE_BINARY_DIR AND EXISTS "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeSystem.cmake" )
 # really dirty hack
 # it is not possible to change CMAKE_SYSTEM_PROCESSOR after the first run...
 file( APPEND "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeSystem.cmake" "SET(CMAKE_SYSTEM_PROCESSOR \"${CMAKE_SYSTEM_PROCESSOR}\")\n" )
endif()

