/// @file app.cpp
/// @brief Application entry point.
///
/// Copyright 2021 Sandel Inc.
/// ----------------------------------------------------------------------------

// #include <cstdlib>
#include <iostream>

#include "mylib/mylib.h"
#include "version/version.h"

int main() {
    std::cout << "Version " << VERSION << std::endl;
    std::cout << "Simple example C++ compiled correctly and ran" << std::endl;
    std::cout << mylib::SimpleLibFunction("Testing", true) << std::endl;

    // uncomment to cause static analysis violation:
    if (true) {
        int const x = 10 / 0;
    }

    // uncomment to cause cyclomatic complexity violation:
    // const unsigned int kSrandSeed = 20U;
    // srand(kSrandSeed);  // NOLINT
    // if (1 < rand()) {   // NOLINT
    //     std::cout << "1" << std::endl;
    // } else if (2 > rand()) {  // NOLINT
    //     std::cout << "2" << std::endl;
    // } else if (3 == rand()) {  // NOLINT
    //     std::cout << "3" << std::endl;
    // } else if (4 <= rand()) {  // NOLINT
    //     std::cout << "4" << std::endl;
    // } else if (5 >= rand()) {  // NOLINT
    //     std::cout << "5" << std::endl;
    // } else if (6 == rand()) {  // NOLINT
    //     std::cout << "6" << std::endl;
    // } else if (7 <= rand()) {  // NOLINT
    //     std::cout << "7" << std::endl;
    // } else if (8 >= rand()) {  // NOLINT
    //     std::cout << "8" << std::endl;
    // } else if (9 == rand()) {  // NOLINT
    //     std::cout << "9" << std::endl;
    // } else if (10 == rand()) {  // NOLINT
    //     std::cout << "10" << std::endl;
    // } else if (11 < rand()) {  // NOLINT
    //     std::cout << "11" << std::endl;
    // } else if (12 > rand()) {  // NOLINT
    //     std::cout << "12" << std::endl;
    // } else if (13 == rand()) {  // NOLINT
    //     std::cout << "13" << std::endl;
    // } else if (14 <= rand()) {  // NOLINT
    //     std::cout << "14" << std::endl;
    // } else if (15 >= rand()) {  // NOLINT
    //     std::cout << "15" << std::endl;
    // } else if (16 == rand()) {  // NOLINT
    //     std::cout << "16" << std::endl;
    // } else if (17 <= rand()) {  // NOLINT
    //     std::cout << "17" << std::endl;
    // } else if (18 >= rand()) {  // NOLINT
    //     std::cout << "18" << std::endl;
    // } else if (19 == rand()) {  // NOLINT
    //     std::cout << "19" << std::endl;
    // } else if (20 == rand()) {  // NOLINT
    //     std::cout << "20" << std::endl;
    // } else {
    //     std::cout << "none" << std::endl;
    // }

    return 0;
}
