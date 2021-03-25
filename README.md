# ProjectName

`main` branch: [![pipeline status](http://dev.sandel.local/toolchain/cmake-project-template/badges/main/pipeline.svg)](http://dev.sandel.local/toolchain/cmake-project-template/-/commits/main) [![coverage report](http://dev.sandel.local/toolchain/cmake-project-template/badges/main/coverage.svg)](http://dev.sandel.local/toolchain/cmake-project-template/-/commits/main)

This is a template project for a C/C++ library and/or application utilizing
modern CMake best practices. It includes support for the following:

- CMake build configurations
- Formatting of source code for standards compliance with `clang-format`
- Built-in static analysis with `clang-tidy`
- Style checking with `cpplint` in accordance with the [Google C++ Style
  Guide](https://google.github.io/styleguide/cppguide.html)
- Analysis of `#include` statements by `include-what-you-use`
- Cyclomatic complexity checks per-function by `pmccabe`
- Testing using CMake's `ctest` and the
  [`googletest`](https://github.com/google/googletest) framework
- Documentation generation with `doxygen`
- VS Code IDE support

The CMake project configuration works best utilizing the native host environment
toolchain (i.e., not cross-compiling). Instead of cross-compiling, it's
recommended to use the remote-ssh capabilities of VS Code (or your IDE of
choice) to build and debug on the target directly.

This description should be modified when creating a new project based on this
template.

## Standards

Checks are included in this project template to adhere to the following code
standards and guidelines, which the developer should review and be familiar
with:

- [CPP Core
  Guidelines](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines)
- [Autosar C++14
  Guidelines](https://www.autosar.org/standards/adaptive-platform/adaptive-platform-1903/)
  (See "General")
- [Cert C++ Coding
  Standard](https://wiki.sei.cmu.edu/confluence/pages/viewpage.action?pageId=88046682)
- [Google C++ Style
  Guide](https://google.github.io/styleguide/cppguide.html)

By extension from Autosar C++14, the following standards should also be
reviewed:
- MISRA C++:2008
- Joint Strike Fighter Air Vehicle C++ Coding Standards
- High Integrity C++ Coding Standard Version 4.0

## Project Structure and Naming Conventions

The following naming conventions are used throughout this project:

- Library source code implementation files are placed in `src/`
- Library header interface files are placed in `include/<library-name>/`
  - In `#include` directives, always specify library name (e.g.
    `#include "library-name/header.h"`)
- Application source code and headers are placed in `app-src/` (delete this
  folder when project is library-only)
- Source code file names are all lowercase, separated by underscores (e.g.
  `my_file.h` or `my_impl.c`)
  - C++ implementation files use extension `.cpp`
  - C++-only header files use extension `.hpp`
  - C implementation files use extension `.c`
  - C header files, and header files intended to be shared between C++ and C,
    use extension `.h`
- Target names are all lowercase; whenever possible, keep names to one word
  (e.g. `mylib` or `myapp`), but if separation is needed, use dashes (`-`)
  (e.g. `my-lib` or `my-app`)
  - Folder subdirectories for library includes should match the target name
    (e.g. `include/libname/` or `include/my-lib/`)


## Tool Prerequisites

The following tools should be installed on the host machine prior to building:

- [CMake](https://cmake.org/) (version 3.12 or later is required)
- [`ccache`](https://ccache.dev/)
- [`clang-format`](https://clang.llvm.org/docs/ClangFormat.html)
- [`clang-tidy`](https://clang.llvm.org/extra/clang-tidy/)
- [`cpplint`](https://github.com/cpplint/cpplint)
- [`include-what-you-use`](https://include-what-you-use.org/)
- [`doxygen`](https://www.doxygen.nl/index.html)
- [`pmccabe`](https://packages.debian.org/sid/pmccabe)
- [Python 3](https://www.python.org)
- `gcov`
- `lcov`

Optionally, you may also install the `ninja` build tool which can be used in
leiu of `make` for slightly speedier builds.

### macOS Host

Assuming you have [Homebrew](https://brew.sh) installed:

    $ brew install ccache cmake cpplint doxygen graphviz include-what-you-use llvm pmccabe python
    $ python3 -m pip install pre-commit
    $ pre-commit install

You must then symlink the extra clang tools from the `llvm` installation:

    $ ln -s "$(brew --prefix llvm)/bin/clang-format" "$(brew --prefix)/bin/clang-format"
    $ ln -s "$(brew --prefix llvm)/bin/clang-tidy" "$(brew --prefix)/bin/clang-tidy"
    $ ln -s "$(brew --prefix llvm)/bin/clang-apply-replacements" "$(brew --prefix)/bin/clang-apply-replacements"

### Debian/Ubuntu Linux Host (incl. Windows WSL Debian/Ubuntu)

Note: LLVM version 11 is installed for the clang-extra tools including
clang-tidy and clang-format. The default packages in Debian are too old (at
version 7 as of this writing) so a newer version is installed below.

    $ sudo apt update
    $ sudo apt install build-essential doxygen graphviz gdb git ccache cmake iwyu lcov ninja-build pmccabe python3-pip
    $ wget https://apt.llvm.org/llvm.sh
    $ chmod +x llvm.sh
    $ sudo ./llvm.sh 11
    $ sudo apt install clang-tidy-11 clang-format-11
    $ sudo ln -sf $(which clang-tidy-11) /usr/local/bin/clang-tidy
    $ sudo ln -sf $(which clang-format-11) /usr/local/bin/clang-format
    $ sudo python3 -m pip install cpplint pre-commit
    $ pre-commit install

### Alpine Linux Host (incl. Windows WSL Alpine)

Note: need to become root to run the installation commands. Also, IWYU is not
immediately available on Alpine.

    $ su -
    # apk update
    # apk add alpine-sdk gdb git ccache cmake clang-extra-tools ninja py3-pip
    # pip3 install cpplint
    # pip3 install pre-commit
    # exit
    $ pre-commit install

## Configure

The usual CMake configuration procedure can be used from the project top-level.
To use the recommended approach for configuration (that is, out-of-source builds
within an unversioned `build` directory), run the following from the project
top-level:

    $ mkdir build
    $ cd build
    $ cmake ..

`ninja` may be used instead of `make` by using the following `cmake` command
when configuring:

    $ cmake -GNinja ..

### Configuration Options

The following configuration options can be added to the `cmake` command (prepend
each option with `-D`):

- `CMAKE_BUILD_TYPE=Debug|Release|RelWithDebInfo|MinSizeRel` (default `Debug`)
- `CMAKE_<LANG>_CLANG_TIDY=clang-tidy` (where `<LANG>` is `C` or `CXX`, for
  integrated static analysis, `clang-tidy` must be in `PATH`)
- `CMAKE_<LANG>_CPPLINT=cpplint` (where `<LANG>` is `C` or `CXX`, for integrated
  style checking, `cpplint` must be in `PATH`)
- `CMAKE_<LANG>_INCLUDE_WHAT_YOU_USE` (where `<LANG>` is `C` or `CXX`,
  `include-what-you-use` must be in `PATH`)
- `CODE_COVERAGE=ON|OFF` (default `OFF`) - compute Code Coverage using gcov and
  lcov. See note on Code Coverage below.
- `CMAKE_INSTALL_PREFIX` - set to the desired installation location

## Build

To build, run the following from the `build` directory:

    cmake --build .

## Test

To run tests, run the following from the `build` directory:

    ctest

## Install

To install, run the following from the `build` directory:

    cmake --install .

By default, the installation prefix will be an unversioned `install/` directory
at the project top-level. To customize this, set `CMAKE_INSTALL_PREFIX` when
configuring.

## Code Coverage

Code coverage can be computed by passing the `CODE_COVERAGE=ON` option during
CMake configuration. Code coverage may NOT be enabled simultaneously with static
analysis (namely, `clang-tidy` checks), because certain compilation options
conflict between GCC and Clang. So if you want to compute code coverage, make a
separate build directory just for coverage like so:

    mkdir build_coverage && cd build_coverage
    cmake -DCODE_COVERAGE=ON -DCMAKE_BUILD_TYPE=Debug -GNinja ..
    cmake --build . --target ctest_coverage

Coverage should only be configured using the `Debug` build type. The commands
above will configure coverage, and execute the test suite to determine runtime
coverage. The HTML reports will be output to `build_coverage/ctest_coverage` and
can be viewed by opening `index.html` in a web browser.

## Customizing `clang-tidy` Checks

The top-level file `.clang-tidy` configures the rules that are checked or
skipped by `clang-tidy`. A default set of rules is provided. Customize them by
reviewing the available [Clang-Tidy
Checks](https://clang.llvm.org/extra/clang-tidy/checks/list.html) and setting
the appropriate options in the `.clang-tidy` file following the
[instructions](https://clang.llvm.org/extra/clang-tidy/).


## Visual Studio Code IDE Support

Included in this project are configurations for editing, building and debugging
using [Microsoft VS Code](https://code.visualstudio.com/).

At a minimum, you should install the following VS Code Extensions in order for
the configure/build/debug commands to work seemlessly:

- [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
- [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
- [Clang-Format](https://marketplace.visualstudio.com/items?itemName=xaver.clang-format)
- [CMake](https://marketplace.visualstudio.com/items?itemName=twxs.cmake)

### Note on Windows WSL

If you've cloned the project in WSL, open the project in VS Code from the WSL
terminal by running the following from the project top-level:

    code .

The first time this is run, VS Code server will install in the WSL environment,
which will take some time on the initial launch. Subsequent launches will be
faster.

### Select Kit

Select the "kit" to be used, which defines the compilation toolchain for your
target.

Open Command (Command+Shift+P), type CMake, select `CMake: Scan for Kits` and
select one

### Select Build Variant

Open Command (Command+Shift+P), type CMake, select `CMake: Select Variant` and
select your desired build variant (Recommended: select `Debug + Static Analysis
and Style Checks + IWYU`)

Note on Alpine Linux: IWYU is not available, so be sure to select one of the
variants that says `No IWYU`.

### Configure

Open Command (Command+Shift+P), type CMake, select `CMake: Configure`

### Build

Open Command (Command+Shift+P), type CMake, select `CMake: Build`

### Debug

Click the Run button in the VS Code sidebar (or Command+Shift+D) and run the
Launch configuration.

Or, open Command (Command+Shift+P), type CMake, select `CMake: Debug` (make sure
you first set a breakpoint somewhere, like `main()`)

### Run Tests

Open Command (Command+Shift+P), type CMake, select `CMake: Run Tests`

### Other Commands

Open Command (Command+Shift+P), type CMake, select desired command
