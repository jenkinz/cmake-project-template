/// @file app.cpp
/// @brief Application entry point.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------
#include <iostream>

#include "lib/lib.hpp"
#include "version/version.h"

auto main() -> int {
    std::cout << "Version " << VERSION << std::endl;
    std::cout << "Simple example C++ compiled correctly and ran" << std::endl;
    std::cout << simple_lib_function("Testing") << std::endl;
    return 0;
}
