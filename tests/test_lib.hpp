/// @file test_lib.hpp 
/// @brief Lib test fixtures.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------
#pragma once

#include <iosfwd>                   // for string
#include "gtest/gtest_pred_impl.h"  // for Test

class LibTest : public ::testing::Test {
  protected:
    // void SetUp() override {}

    // void TearDown() override {}

    // Test Fixture data
    static std::string const kExpectedStringPrefix_;
};