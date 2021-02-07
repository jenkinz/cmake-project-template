#include "lib/lib.hpp"
#include "version.h"

#include <iostream>

auto main() -> int {

    std::cout << "Simple example C++ compiled correctly and ran." << std::endl;
    std::cout << simple_lib_function() << std::endl;

    return 0;
}