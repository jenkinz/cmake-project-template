/// @file lib.cpp
/// @brief Lib implementation.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------
#include <iosfwd>  // for string
#include <string>  // for operator+, basic_string
#include "lib/lib.hpp"

/// @brief Return a string.
///
/// @param[in] param a parameter that will be included in the returned string
///
/// @section desc Description This is an optional, more detailed description for
/// an enhanced explanation of the function and its properties.
auto SimpleLibFunction(std::string const & param) -> std::string {
    return "Compiled in library, param = " + param;
}
