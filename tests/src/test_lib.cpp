/// @file test_lib.cpp 
/// @brief Lib tests.
///
/// Copyright 2021 MyCo Inc.
/// ----------------------------------------------------------------------------
#include <gtest/gtest-message.h>    // for Message
#include <gtest/gtest-test-part.h>  // for TestPartResult
#include "gtest/gtest_pred_impl.h"  // for Test, EXPECT_EQ, SuiteApiResolver

#include "lib/lib.hpp"              // for simple_lib_function

TEST(LibTest, DefaultInputEqual) {
    EXPECT_EQ(SimpleLibFunction(), "Compiled in library, param = Default");
}

TEST(LibTest, DefaultInputNotEqual) {
    EXPECT_NE(SimpleLibFunction(), "Compiled in library, param = D");
}

TEST(LibTest, CustomInputEqual) {
    EXPECT_EQ(SimpleLibFunction("Test"), "Compiled in library, param = Test");
    EXPECT_EQ(SimpleLibFunction("3"), "Compiled in library, param = 3");
    EXPECT_EQ(SimpleLibFunction("…∑ª©æç≤≈"), 
              "Compiled in library, param = …∑ª©æç≤≈");
    EXPECT_EQ(SimpleLibFunction(""), "Compiled in library, param = ");
}

TEST(LibTest, CustomInputNotEqual) {
    EXPECT_NE(SimpleLibFunction("Test"), "tseT");
    EXPECT_NE(SimpleLibFunction("1234"), "5678");
    EXPECT_NE(SimpleLibFunction("…∑ª©æç≤≈"), "…∑ª©æç≤");
    EXPECT_NE(SimpleLibFunction(""), "Compiled in library, param = d");
}
