/// @file lib.hpp
/// @brief Lib interface.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------
#pragma once

#include <iosfwd> // for string

namespace mylib {

std::string SimpleLibFunction(std::string const & param = "Default");

}; // namespace mylib
