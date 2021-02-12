/// @file test_lib.cpp 
/// @brief Lib tests.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------

#include <gtest/gtest-message.h>    // for Message
#include <gtest/gtest-test-part.h>  // for TestPartResult, SuiteApiResolver
#include <string>                   // for operator+
#include "gtest/gtest_pred_impl.h"  // for Test, EXPECT_EQ, EXPECT_NE, TEST
#include "mylib/mylib.hpp"              // for SimpleLibFunction
#include "test_mylib.hpp"             // for LibTest test fixture

std::string const LibTest::kExpectedStringPrefix_ =
    "Compiled in library, param = ";

TEST_F(LibTest, DefaultInputEqual) {
    EXPECT_EQ(mylib::SimpleLibFunction(), kExpectedStringPrefix_ + "Default");
}

TEST_F(LibTest, DefaultInputNotEqual) {
    EXPECT_NE(mylib::SimpleLibFunction(), kExpectedStringPrefix_ + "D");
}

TEST_F(LibTest, CustomInputEqual) {
    EXPECT_EQ(mylib::SimpleLibFunction("Test"), kExpectedStringPrefix_ +"Test");
    EXPECT_EQ(mylib::SimpleLibFunction("3"), kExpectedStringPrefix_ + "3");
    EXPECT_EQ(mylib::SimpleLibFunction("…∑ª©æç≤≈"),
              kExpectedStringPrefix_ + "…∑ª©æç≤≈");
    EXPECT_EQ(mylib::SimpleLibFunction(""), kExpectedStringPrefix_);
}

TEST_F(LibTest, CustomInputNotEqual) {
    EXPECT_NE(mylib::SimpleLibFunction("Test"), "tseT");
    EXPECT_NE(mylib::SimpleLibFunction("1234"), "5678");
    EXPECT_NE(mylib::SimpleLibFunction("…∑ª©æç≤≈"), "…∑ª©æç≤");
    EXPECT_NE(mylib::SimpleLibFunction(""), "Compiled in library, param = d");
}
