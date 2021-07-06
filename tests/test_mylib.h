/// @file test_lib.hpp
/// @brief Lib test fixtures.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------

#ifndef TEST_MYLIB_HPP_
#define TEST_MYLIB_HPP_

#include <gtest/gtest.h>

#include <string>

/// @brief Text fixture for mylib.
///
/// @see mylib::SimpleLibFunction
///
class LibTest : public ::testing::Test {
 protected:
    // void SetUp() override {}

    // void TearDown() override {}

    // Test Fixture data
    static std::string const kExpectedStringPrefix_;
};

#endif  // TEST_MYLIB_HPP_
