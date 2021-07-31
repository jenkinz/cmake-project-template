#!/bin/bash

# Run code coverage task. Must be run from project top-level.

mkdir -p build_coverage
cd build_coverage
cmake -DCODE_COVERAGE=ON -DCMAKE_BUILD_TYPE=Debug ..
cmake --build . --target ctest_coverage
