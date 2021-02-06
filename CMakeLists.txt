cmake_minimum_required(VERSION 3.8)

project(ProjectName LANGUAGES CXX)

add_library(lib STATIC src/lib.cpp include/lib/lib.hpp)
target_include_directories(lib PUBLIC include)

add_executable(app apps/app.cpp)
target_link_libraries(app PUBLIC lib)