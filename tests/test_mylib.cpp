/// @file test_lib.cpp
/// @brief Lib tests.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------

#include "test_mylib.hpp"
#include <gtest/gtest.h>
#include <string>
#include "mylib/mylib.hpp"

std::string const LibTest::kExpectedStringPrefix_ =
    "Compiled in library, param = ";

TEST_F(LibTest, DefaultInputEqual) {
    EXPECT_EQ(mylib::SimpleLibFunction(), kExpectedStringPrefix_ + "Default");
}

TEST_F(LibTest, DefaultInputNotEqual) {
    EXPECT_NE(mylib::SimpleLibFunction(), kExpectedStringPrefix_ + "D");
}

TEST_F(LibTest, CustomInputEqual) {
    EXPECT_EQ(mylib::SimpleLibFunction("Test", 1),
              kExpectedStringPrefix_ + "Test");
    EXPECT_EQ(mylib::SimpleLibFunction("3", 0), kExpectedStringPrefix_ + "3");
    EXPECT_EQ(mylib::SimpleLibFunction("…∑ª©æç≤≈", 1),
              kExpectedStringPrefix_ + "…∑ª©æç≤≈");
    EXPECT_EQ(mylib::SimpleLibFunction("", 0), kExpectedStringPrefix_);
}

TEST_F(LibTest, CustomInputNotEqual) {
    EXPECT_NE(mylib::SimpleLibFunction("Test", 1), "tseT");
    EXPECT_NE(mylib::SimpleLibFunction("1234", 0), "5678");
    EXPECT_NE(mylib::SimpleLibFunction("…∑ª©æç≤≈", 1), "…∑ª©æç≤");
    EXPECT_NE(mylib::SimpleLibFunction("", 0),
              "Compiled in library, param = d");
}
