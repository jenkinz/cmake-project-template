# ProjectName

This is a template project for a C/C++ library and/or application utilizing
modern CMake best practices. It includes support for the following:

- CMake build configurations
- Built-in static analysis with `clang-tidy`
- VS Code IDE support

The CMake project configuration works best utilizing the native host environment
toolchain (i.e., not cross-compiling).

This description should be modified when creating a new project based on this
template.

## Tool Prerequisites

The following tools should be installed on the host machine prior to building:

- [CMake](https://cmake.org/) (version 3.8 or later is required)
- [`ccache`](https://ccache.dev/)
- [`clang-tidy`](https://clang.llvm.org/extra/clang-tidy/)
- [`cpplint`](https://github.com/cpplint/cpplint)
- [`include-what-you-use`](https://include-what-you-use.org/)

On macOS, assuming you have [Homebrew](https://brew.sh) installed, this can be
achieved by running the following:

```
$ brew install cmake ccache llvm include-what-you-use
```

You must then symlink the extra clang tools from the `llvm` installation:

```
$ ln -s "$(brew --prefix llvm)/bin/clang-format" "/usr/local/bin/clang-format"
$ ln -s "$(brew --prefix llvm)/bin/clang-tidy" "/usr/local/bin/clang-tidy"
$ ln -s "$(brew --prefix llvm)/bin/clang-apply-replacements" "/usr/local/bin/clang-apply-replacements"
```


## Visual Studio Code IDE Support

Included in this project are configurations for editing, building and debugging
using [Microsoft VS Code](https://code.visualstudio.com/).

At a minimum, you should install the following VS Code Extensions:

- [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
- [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
- [CMake](https://marketplace.visualstudio.com/items?itemName=twxs.cmake)

### Configure

Open Command (Command+Shift+P), type CMake, select `CMake: Configure`

### Build

Open Command (Command+Shift+P), type CMake, select `CMake: Build`

### Other Commands

Open Command (Command+Shift+P), type CMake, select desired command

