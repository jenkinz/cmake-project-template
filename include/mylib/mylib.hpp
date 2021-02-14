/// @file lib.hpp
/// @brief Lib interface.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------

#ifndef MYLIB_H_
#define MYLIB_H_

#include <string>

namespace mylib {

std::string SimpleLibFunction(std::string const& param = "Default");

};  // namespace mylib

#endif  // MYLIB_H_
