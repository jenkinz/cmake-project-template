# CMakeLists.txt -- TEMPLATE PROJECT (See
# https://cliutils.gitlab.io/modern-cmake/chapters/basics/example.html) You
# should DELETE all the explanatory comments when creating a new project!

# Almost all CMake files should start with this You should always specify a
# range with the newest and oldest tested versions of CMake. This will ensure
# you pick up the best policies.
cmake_minimum_required(VERSION 3.12...3.19)

# This is your project statement. You should always list languages; Listing the
# version is nice here since it sets lots of useful variables (e.g. those used
# in version.h)
project(ProjectName
        VERSION 0.1.0.0 # Major.minor.patch.tweak (see version.h.in)
        DESCRIPTION "CMake project template"
        LANGUAGES CXX)

# Auto-generate a version header (this requires you set VERSION in the project()
# above)
configure_file (
    "cmake/version.h.in"
    "${CMAKE_CURRENT_BINARY_DIR}/version/version.h"
)

# If you set any CMAKE_ variables, that can go here. (But usually don't do this,
# except maybe for C++ standard)
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT) # can be overridden on cmd line
    set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/install
        CACHE PATH "Default installation prefix" FORCE)
endif(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
set(INCLUDE_DEST "include")
set(LIB_INCLUDE_DEST "${INCLUDE_DEST}/mylib")
set(MAIN_LIB_DEST "lib/mylib")
set(LIB_DEST "${MAIN_LIB_DEST}")

# Find packages, other config-time commands can go here.
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(cmake/pc-lint.cmake)
include(cmake/pmccabe.cmake)

# Enable/disable code coverage
# NOTE: Code coverage and static analysis checks cannot be enabled
# simultaneously. Namely, this has to do with clang-tidy and GCC not recognizing
# all compilation flags. To run code coverage, create a separate build directory
# from the development build directory used for building and debugging, and
# disable static analysis checks in the coverage build directory.
option(CODE_COVERAGE "Compute code coverage using gcov and lcov" OFF)
if(CODE_COVERAGE)
    if(CMAKE_CXX_CLANG_TIDY)
        message(FATAL_ERROR "Static analysis and code coverage cannot both be \
                            turned on in the same build configuration. Create a\
                            separate build directory for code coverage with \
                            static analysis disabled.")
    endif(CMAKE_CXX_CLANG_TIDY)
    include(CodeCoverage)
endif(CODE_COVERAGE)

# Command to auto-update all git submodules: from
# https://cliutils.gitlab.io/modern-cmake/chapters/basics/programs.html
find_package(Git)
if(GIT_FOUND AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/.git")
    # Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT_EXECUTABLE}
                                submodule update --init --recursive --remote
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init failed with $
                                {GIT_SUBMOD_RESULT}, please checkout
                                submodules")
        endif(NOT GIT_SUBMOD_RESULT EQUAL "0")
    endif(GIT_SUBMODULE)
endif(GIT_FOUND AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/.git")

## CCache - speed up recompilation by caching previous compilations
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
    set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
endif(CCACHE_PROGRAM)

# You should usually split this into folders, but this is a simple example

# Adding a library target Including header files here helps IDEs but is not
# required. Output libname matches target name, with the usual extensions on
# your system
add_library(mylib STATIC src/mylib.cpp include/mylib/mylib.hpp)
add_library(mylib::mylib ALIAS mylib)
target_include_directories(mylib PUBLIC
                        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
                        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
                        $<INSTALL_INTERFACE:${INCLUDE_DEST}>)
target_compile_features(mylib PUBLIC cxx_std_14) # or cxx_std_11, or cxx_std_17
if(CODE_COVERAGE)
    target_compile_options(mylib PRIVATE -fprofile-arcs -ftest-coverage
                                         -fprofile-abs-path)
endif()
# disable this line to get -std=g++14 etc. (also disable for INTERFACE targets)
set_target_properties(mylib PROPERTIES CXX_EXTENSIONS OFF)
if(CMAKE_CXX_CLANG_TIDY) # only do cyclo and pclint if static analysis enabled
    target_add_cyclomatic_complexity_checks(mylib)
    target_add_pclint_checks(mylib)
endif(CMAKE_CXX_CLANG_TIDY)

# Link each target with other targets or add options, etc.

# Adding something we can run - Output name matches target name
add_executable(myapp app-src/main.cpp)
target_compile_features(myapp PUBLIC cxx_std_14) # or cxx_std_11, or cxx_std_17
# disable this line to get -std=g++14 etc. (also disable for INTERFACE targets)
set_target_properties(myapp PROPERTIES CXX_EXTENSIONS OFF)
target_include_directories(myapp PUBLIC
                        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
                        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/app-src)
if(CODE_COVERAGE)
    target_compile_options(myapp PRIVATE -fprofile-arcs -ftest-coverage
                                         -fprofile-abs-path)
endif()
# Make sure you link your targets with this command. It can also link libraries
# and even flags, so linking a target that does not exist will not give a
# configure-time error.
target_link_libraries(myapp PRIVATE mylib)
if(CMAKE_CXX_CLANG_TIDY) # only do cyclo and pclint if static analysis enabled
    target_add_cyclomatic_complexity_checks(myapp)
endif(CMAKE_CXX_CLANG_TIDY)

# Tests
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    include(CTest)
endif()
option(PACKAGE_TESTS "Build the tests" ON)
if(PACKAGE_TESTS)
    enable_testing()
    include(GoogleTest)
    add_subdirectory(tests)
endif()

# Installation set(CMAKE_INSTALL_MESSAGE NEVER)  # suppress verbose install
# messages
install(TARGETS mylib EXPORT mylib DESTINATION ${LIB_DEST})
install(FILES cmake/mylib-config.cmake DESTINATION ${MAIN_LIB_DEST})
install(EXPORT mylib DESTINATION ${LIB_DEST})
install(DIRECTORY include/mylib DESTINATION ${LIB_INCLUDE_DEST}
        FILES_MATCHING PATTERN "*.h*")
install(DIRECTORY ${CMAKE_BINARY_DIR}/mylib DESTINATION ${LIB_INCLUDE_DEST}
        FILES_MATCHING PATTERN "*.h") # for generated version.h file
install(TARGETS myapp RUNTIME DESTINATION bin)

# Generate documentation (Doxygen)
# Require dot, treat the other components as optional
find_package(Doxygen
             REQUIRED dot
             OPTIONAL_COMPONENTS mscgen dia)
if(DOXYGEN_FOUND)
    doxygen_add_docs(
        doxygen
        ${CMAKE_CURRENT_SOURCE_DIR}
        # ALL     # uncomment to add doxygen to default build target 'all.'
        # (Otherwise, generate docs manually by running "make doxygen" or "ninja
        # doxygen" from build directory.)
        COMMENT "Generate doxygen docs"
    )
endif(DOXYGEN_FOUND)

# Setup Code Coverage
# to run: invoke `cmake --build . --target ctest_coverage` from build directory
if(CODE_COVERAGE)
    # Note: add each test target defined above to the DEPENDENCIES list below
    setup_target_for_coverage_lcov(
        NAME ctest_coverage
        EXECUTABLE ctest
        DEPENDENCIES test-mylib mylib # add any additional test targets here
        EXCLUDE /usr/include/* app-src/main.cpp
    )
    # Note: add link dependency `gcov` to each test target defined above
    target_link_libraries(test-mylib gcov)
    target_link_libraries(mylib gcov)
endif()
