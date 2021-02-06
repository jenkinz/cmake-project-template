#include "lib/lib.hpp"
#include "app_version.h"

#include <iostream>

int main() {

    std::cout << "Simple example C++ compiled correctly and ran." << std::endl;
    std::cout << simple_lib_function() << std::endl;

    return 0;
}