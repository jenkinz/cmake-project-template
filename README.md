# ProjectName

This is a template project for a C/C++ library and/or application utilizing
modern CMake best practices. It includes support for the following:

- CMake build configurations
- Built-in static analysis with `clang-tidy`
- Style checking with `cpplint` in accordance with the [Google C++ Style
  Guide](https://google.github.io/styleguide/cppguide.html)
- VS Code IDE support

The CMake project configuration works best utilizing the native host environment
toolchain (i.e., not cross-compiling). Instead of cross-compiling, it's
recommended to use the remote-ssh capabilities of VS Code (or your IDE of
choice) to build and debug on the target directly.

This description should be modified when creating a new project based on this
template.

## Tool Prerequisites

The following tools should be installed on the host machine prior to building:

- [CMake](https://cmake.org/) (version 3.8 or later is required)
- [`ccache`](https://ccache.dev/)
- [`clang-tidy`](https://clang.llvm.org/extra/clang-tidy/)
- [`cpplint`](https://github.com/cpplint/cpplint)
- [`include-what-you-use`](https://include-what-you-use.org/)

Optionally, you may also install the `ninja` build tool which can be used in
leiu of `make` for slightly speedier builds.

### macOS Host

Assuming you have [Homebrew](https://brew.sh) installed:

    $ brew install ccache cmake cpplint include-what-you-use llvm

You must then symlink the extra clang tools from the `llvm` installation:

    $ ln -s "$(brew --prefix llvm)/bin/clang-format" "$(brew --prefix)/bin/clang-format"
    $ ln -s "$(brew --prefix llvm)/bin/clang-tidy" "$(brew --prefix)/bin/clang-tidy"
    $ ln -s "$(brew --prefix llvm)/bin/clang-apply-replacements" "$(brew --prefix)/bin/clang-apply-replacements"

### TODO add Debian/Ubuntu Linux Host (incl. Windows WSL Debian/Ubuntu)

TBD...

### TODO add Alpine Linux Host

TBD...

## Configure

The usual CMake configuration procedure can be used from the project top-level.
To use the recommended approach for configuration (that is, out-of-source builds
within an unversioned `build` directory), run the following from the project
top-level:

    $ cmake -S . -B build

`ninja` may be used instead of `make` by using the following `cmake` command
when configuring:

    $ cmake -GNinja -S . -B build

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

## Build

To build, run the following from the project top-level (assuming your build
directory is called `build` as set in the Configure step):

    cmake --build build

## Install

To install, run the following from the project top-level (assuming your build
directory is called `build` as set in the Configure step):

    cmake --install build


## Visual Studio Code IDE Support

Included in this project are configurations for editing, building and debugging
using [Microsoft VS Code](https://code.visualstudio.com/).

At a minimum, you should install the following VS Code Extensions in order for
the configure/build/debug commands to work seemlessly:

- [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
- [CMake
  Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
- [CMake](https://marketplace.visualstudio.com/items?itemName=twxs.cmake)

### Select Kit

Select the "kit" to be used, which defines the compilation toolchain for your
target.

Open Command (Command+Shift+P), type CMake, select `CMake: Scan for Kits` and
select one

### Select Build Variant

Open Command (Command+Shift+P), type CMake, select `CMake: Select Variant` and
select your desired build variant (Recommended: select `Debug + Static Analysis
and Style Checks + include-what-you-use`)

### Configure

Open Command (Command+Shift+P), type CMake, select `CMake: Configure`

### Build

Open Command (Command+Shift+P), type CMake, select `CMake: Build`

### Debug

Click the Run button in the VS Code sidebar (or Command+Shift+D) and run the
Launch configuration.

Or, open Command (Command+Shift+P), type CMake, select `CMake: Debug` (make sure
you first set a breakpoint somewhere, like `main()`)

### Other Commands

Open Command (Command+Shift+P), type CMake, select desired command

