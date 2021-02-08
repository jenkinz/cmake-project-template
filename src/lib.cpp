/// @file lib.cpp
/// @brief Lib implementation.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------
#include <iosfwd>  // for string
#include <string>  // for basic_string

/// @brief Return a string.
///
/// @param[in] param a parameter that will be included in the returned string
///
/// @section desc Description This is an optional, more detailed description for
/// an enhanced explanation of the function and its properties.
auto simple_lib_function(std::string const & param) -> std::string {
    // possible unit tests could be: assert(simple_lib_function() == "Compiled
    // in library, param = Default") assert(simple_lib_function("Test") ==
    // "Compiled in library, param = Test")
    return "Compiled in library, param = " + param;
}
