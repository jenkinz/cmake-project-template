# CMakeLists.txt -- TEMPLATE PROJECT (See
# https://cliutils.gitlab.io/modern-cmake/chapters/basics/example.html) You
# should DELETE all the explanatory comments when creating a new project!

# Almost all CMake files should start with this You should always specify a
# range with the newest and oldest tested versions of CMake. This will ensure
# you pick up the best policies.
cmake_minimum_required(VERSION 3.8...3.19)

# This is your project statement. You should always list languages; Listing the
# version is nice here since it sets lots of useful variables (e.g. those used
# in version.h)
project(ProjectName
        VERSION 0.1.0.0 # Major.minor.patch.tweak (see version.h.in)
        DESCRIPTION "CMake project template"
        HOMEPAGE_URL "https://github.com/jenkinz/xxx.git"
        LANGUAGES C CXX)

# Auto-generate a version header (this requires you set VERSION in the project()
# above)
configure_file (
    "${PROJECT_SOURCE_DIR}/include/version.h.in"
    "${PROJECT_BINARY_DIR}/version/version.h"
)

# If you set any CMAKE_ variables, that can go here. (But usually don't do this,
# except maybe for C++ standard)

# Find packages, other config-time commands can go here.

# Command to auto-update all git submodules: from
# https://cliutils.gitlab.io/modern-cmake/chapters/basics/programs.html
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
    # Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT_EXECUTABLE}
                                submodule update --init --recursive
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init failed with $
                                {GIT_SUBMOD_RESULT}, please checkout
                                submodules")
        endif()
    endif()
endif()
# if(NOT EXISTS "${PROJECT_SOURCE_DIR}/extern/repo/CMakeLists.txt")
#     message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was
#     turned off or failed. Please update submodules and try again.") endif()

## CCache - speed up recompilation by caching previous compilations
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
    set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
endif()

# You should usually split this into folders, but this is a simple example

# Adding a library target Including header files here helps IDEs but is not
# required. Output libname matches target name, with the usual extensions on
# your system
add_library(lib STATIC src/lib.cpp include/lib/lib.hpp)
target_include_directories(lib PUBLIC include)
target_compile_features(lib PUBLIC cxx_std_11) # or cxx_std_14, or cxx_std_17
# disable this line to get -std=g++11 etc. (also disable for INTERFACE targets)
set_target_properties(lib PROPERTIES CXX_EXTENSIONS OFF)

# Link each target with other targets or add options, etc.

# Adding something we can run - Output name matches target name
add_executable(app apps/app.cpp)
target_compile_features(app PUBLIC cxx_std_11)
set_target_properties(app PROPERTIES CXX_EXTENSIONS OFF)
target_include_directories(app PUBLIC ${PROJECT_BINARY_DIR})
# Make sure you link your targets with this command. It can also link libraries
# and even flags, so linking a target that does not exist will not give a
# configure-time error.
target_link_libraries(app PRIVATE lib)

# Testing
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    include(CTest)
endif()
# if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME AND BUILD_TESTING)
#     add_subdirectory(tests) endif()
