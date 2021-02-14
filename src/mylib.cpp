/// @file lib.cpp
/// @brief Lib implementation.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------

#include "mylib/mylib.hpp"

/// @brief Return a string.
///
/// @param[in] param a parameter that will be included in the returned string
///
/// @section desc Description This is an optional, more detailed description for
/// an enhanced explanation of the function and its properties.
///
std::string mylib::SimpleLibFunction(std::string const& param) {
    return "Compiled in library, param = " + param;
}
