mark_as_advanced(
    BUILD_GMOCK BUILD_GTEST BUILD_SHARED_LIBS
    gmock_build_tests gtest_build_samples gtest_build_tests
    gtest_disable_pthreads gtest_force_shared_crt gtest_hide_internal_symbols
)
set_target_properties(gtest
                        PROPERTIES
                            FOLDER extern
                            CXX_CLANG_TIDY ""
                            CXX_CPPLINT ""
                            CXX_INCLUDE_WHAT_YOU_USE "")
set_target_properties(gtest_main
                        PROPERTIES
                            FOLDER extern
                            CXX_CLANG_TIDY ""
                            CXX_CPPLINT ""
                            CXX_INCLUDE_WHAT_YOU_USE "")
set_target_properties(gmock
                        PROPERTIES
                            FOLDER extern
                            CXX_CLANG_TIDY ""
                            CXX_CPPLINT ""
                            CXX_INCLUDE_WHAT_YOU_USE "")
set_target_properties(gmock_main
                        PROPERTIES
                            FOLDER extern
                            CXX_CLANG_TIDY ""
                            CXX_CPPLINT ""
                            CXX_INCLUDE_WHAT_YOU_USE "")

macro(package_add_test TESTNAME)
    # create an exectuable in which the tests will be stored
    add_executable(${TESTNAME} ${ARGN})
    # link the Google test infrastructure, mocking library, and a default main
    # fuction to the test executable.  Remove g_test_main if writing your own
    # main function.
    target_link_libraries(${TESTNAME} gtest gmock gtest_main)
    # gtest_discover_tests replaces gtest_add_tests, see
    # https://cmake.org/cmake/help/v3.10/module/GoogleTest.html for more options
    # to pass to it
    gtest_discover_tests(${TESTNAME}
        # set a working directory so your project root so that you can find test
        # data via paths relative to the project root
        WORKING_DIRECTORY ${PROJECT_DIR}
        PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${PROJECT_DIR}"
    )
    set_target_properties(${TESTNAME}
                            PROPERTIES
                                FOLDER tests
                                CXX_CLANG_TIDY ""
                                CXX_CPPLINT "")
endmacro(package_add_test)

macro(package_add_test_with_libraries)
    set(oneValueArgs TESTNAME TEST_WORKING_DIRECTORY)
    set(multiValueArgs FILES LIBRARIES)
    cmake_parse_arguments(PATWL "" "${oneValueArgs}"
                          "${multiValueArgs}" ${ARGN})
    add_executable(${PATWL_TESTNAME} ${PATWL_FILES})
    target_link_libraries(${PATWL_TESTNAME} gtest gmock gtest_main
                          ${PATWL_LIBRARIES})
    gtest_discover_tests(${PATWL_TESTNAME}
        WORKING_DIRECTORY ${PATWL_TEST_WORKING_DIRECTORY}
        PROPERTIES
        VS_DEBUGGER_WORKING_DIRECTORY "${PATWL_TEST_WORKING_DIRECTORY}"
    )
    set_target_properties(${PATWL_TESTNAME}
                            PROPERTIES
                                FOLDER tests
                                CXX_CLANG_TIDY ""
                                CXX_CPPLINT "")
endmacro(package_add_test_with_libraries)

# Define tests here.
package_add_test_with_libraries(TESTNAME
                                    test-mylib
                                FILES
                                    test_mylib.cpp
                                LIBRARIES
                                    mylib
                                TEST_WORKING_DIRECTORY
                                    "")
