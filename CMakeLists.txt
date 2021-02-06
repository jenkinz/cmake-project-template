# Note: migrating to this template: 
# https://gitlab.com/CLIUtils/modern-cmake/-/blob/master/examples/extended-project/CMakeLists.txt

cmake_minimum_required(VERSION 3.8)

project(ProjectName
        VERSION 0.1.0.0
        DESCRIPTION "CMake project template"
        HOMEPAGE_URL "https://cmake.org"
        LANGUAGES CXX)

configure_file (
    "${PROJECT_SOURCE_DIR}/include/version.h.in"
    "${PROJECT_BINARY_DIR}/version.h"
)

add_library(lib STATIC src/lib.cpp include/lib/lib.hpp)
target_include_directories(lib PUBLIC include)

add_executable(app apps/app.cpp)
target_include_directories(app PUBLIC ${PROJECT_BINARY_DIR})
target_link_libraries(app PUBLIC lib)