/// @file lib.hpp
/// @brief Lib interface.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------
#pragma once

#include <iosfwd> // for string

auto simple_lib_function(std::string const & param = "Default") -> std::string;
