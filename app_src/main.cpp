/// @file app.cpp
/// @brief Application entry point.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------
#include <iostream>

#include "mylib/mylib.hpp"
#include "mylib/version.h"

int main() {
    std::cout << "Version " << VERSION << std::endl;
    std::cout << "Simple example C++ compiled correctly and ran" << std::endl;
    std::cout << SimpleLibFunction("Testing") << std::endl;
    return 0;
}
