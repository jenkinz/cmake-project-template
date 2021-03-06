/// @file app.cpp
/// @brief Application entry point.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------

// #include <cstdlib>
#include <iostream>

#include "mylib/mylib.hpp"
#include "mylib/version.h"

int main() {
    std::cout << "Version " << VERSION << std::endl;
    std::cout << "Simple example C++ compiled correctly and ran" << std::endl;
    std::cout << mylib::SimpleLibFunction("Testing", 1) << std::endl;

    // uncomment to cause cyclomatic complexity violation:
    // if (1 < arc4random()) { // NOLINT
    //     std::cout << "1" << std::endl;
    // } else if (2 > arc4random()) { // NOLINT
    //     std::cout << "2" << std::endl;
    // } else if (3 == arc4random()) { // NOLINT
    //     std::cout << "3" << std::endl;
    // } else if (4 <= arc4random()) { // NOLINT
    //     std::cout << "4" << std::endl;
    // } else if (5 >= arc4random()) { // NOLINT
    //     std::cout << "5" << std::endl;
    // } else if (6 == arc4random()) { // NOLINT
    //     std::cout << "6" << std::endl;
    // } else if (7 <= arc4random()) { // NOLINT
    //     std::cout << "7" << std::endl;
    // } else if (8 >= arc4random()) { // NOLINT
    //     std::cout << "8" << std::endl;
    // } else if (9 == arc4random()) { // NOLINT
    //     std::cout << "9" << std::endl;
    // } else if (10 == arc4random()) { // NOLINT
    //     std::cout << "10" << std::endl;
    // } else if (11 < arc4random()) { // NOLINT
    //     std::cout << "11" << std::endl;
    // } else if (12 > arc4random()) { // NOLINT
    //     std::cout << "12" << std::endl;
    // } else if (13 == arc4random()) { // NOLINT
    //     std::cout << "13" << std::endl;
    // } else if (14 <= arc4random()) { // NOLINT
    //     std::cout << "14" << std::endl;
    // } else if (15 >= arc4random()) { // NOLINT
    //     std::cout << "15" << std::endl;
    // } else if (16 == arc4random()) { // NOLINT
    //     std::cout << "16" << std::endl;
    // } else if (17 <= arc4random()) { // NOLINT
    //     std::cout << "17" << std::endl;
    // } else if (18 >= arc4random()) { // NOLINT
    //     std::cout << "18" << std::endl;
    // } else if (19 == arc4random()) { // NOLINT
    //     std::cout << "19" << std::endl;
    // } else if (20 == arc4random()) { // NOLINT
    //     std::cout << "20" << std::endl;
    // } else {
    //     std::cout << "none" << std::endl;
    // }

    return 0;
}
