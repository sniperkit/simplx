cmake_minimum_required(VERSION 3.0)

string(COMPARE NOTEQUAL "$ENV{TRAVIS_TAG}" "" travis_deploy)
string(COMPARE EQUAL "$ENV{APPVEYOR_REPO_TAG}" "true" appveyor_deploy)

if(travis_deploy)
  set(version "$ENV{TRAVIS_TAG}")
elseif(appveyor_deploy)
  set(version "$ENV{APPVEYOR_REPO_TAG_NAME}")
else()
  set(version "v0.1.0")
endif()

string(REGEX REPLACE "^v" "" version "${version}")

include("cmake/HunterGate.cmake")

HunterGate(
	URL "https://github.com/ruslo/hunter/archive/v0.22.25.tar.gz"
	SHA1 "ed0bb95372e1fe50addbd9034ee560ba1a350c65"
  LOCAL
)

project(simplx VERSION ${version})

# for additional cmake macros or functions
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/modules")
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

hunter_add_package(check_ci_tag)
find_package(check_ci_tag CONFIG REQUIRED)
check_ci_tag()

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

string(COMPARE EQUAL "${CMAKE_SYSTEM_NAME}" "Linux" is_linux)

# See: cmake/Hunter/config.cmake
hunter_add_package(sugar)
find_package(sugar CONFIG REQUIRED)
include(sugar_include)

message("Linux  : ${is_linux}")
message("Xcode  : ${XCODE}")

if(XCODE)
  set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "Configuration types")
endif()

## #################################################################
## Testing:
## #################################################################

string(COMPARE EQUAL "$ENV{TRAVIS}" "true" travis_ci)
string(COMPARE EQUAL "$ENV{APPVEYOR}" "True" appveyor_ci)
if(travis_ci OR appveyor_ci)
  set(SIMPLEX_CI TRUE)
else()
  set(SIMPLEX_CI FALSE)
endif()

# modules
include(FindThreads)

#valgrind 
find_program(CTEST_MEMORYCHECK_COMMAND NAMES valgrind)
set( MEMORYCHECK_COMMAND_OPTIONS "--trace-children=yes --leak-check=full")
INCLUDE(Dart)

option(BUILD_TEST "BUILD_TEST" OFF)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()
message("> CMAKE_BUILD_TYPE = ${CMAKE_BUILD_TYPE}")

# set C++ compiler options
if (${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
	set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wextra -Wpedantic -Werror -Wno-deprecated -Woverloaded-virtual -Wsign-promo  -fstrict-aliasing -Wno-noexcept-type -Wstrict-aliasing=1 -fdiagnostics-color=auto")
	set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0") # -g already defined
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
	set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -std=c++11")
else ()
	message (FATAL_ERROR "unsupported C++ compiler ${CMAKE_CXX_COMPILER_ID}")
endif ()

#Gtest
if(BUILD_TEST)
	enable_testing()
	hunter_add_package( GTest )
	find_package( GTest 1.8.0-hunter-p11 CONFIG REQUIRED )
	#Unit Test
	add_subdirectory(test)
endif()

# Engine
add_subdirectory(src/engine)

# Timer
add_subdirectory(src/util)

# Tutorial
add_subdirectory(tutorials)
