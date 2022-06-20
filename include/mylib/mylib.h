/// @file mylib.hpp
/// @brief Lib interface.
///
/// Copyright 2021 Sandel Inc.
/// ----------------------------------------------------------------------------

#ifndef MYLIB_MYLIB_H_
#define MYLIB_MYLIB_H_

#include <string>

namespace mylib {

std::string SimpleLibFunction(std::string const& param = "Default",
                              bool const         br = false);

};  // namespace mylib

#endif  // MYLIB_MYLIB_H_
