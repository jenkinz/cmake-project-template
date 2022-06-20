/// @file mylib.cpp
/// @brief Lib implementation.
///
/// Copyright 2021 Sandel Inc.
/// ----------------------------------------------------------------------------

#include "mylib/mylib.h"
#include <iostream>
#include "version/version.h"

/// @brief Return a string.
///
/// @param[in] param a parameter that will be included in the returned string
/// @param[in] br whether or not to branch
///
/// @section desc Description This is an optional, more detailed description for
/// an enhanced explanation of the function and its properties.
///
std::string mylib::SimpleLibFunction(std::string const& param, bool const br) {
    std::string const prepend = "Compiled in library, param = ";

    std::cout << "Version " << VERSION << std::endl;

    if (br) {
        std::cout << "Made a branch" << std::endl;
    } else {
        std::cout << "Else case" << std::endl;
    }

    return prepend + param;
}  // LCOV_EXCL_LINE
