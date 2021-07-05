# ==============================================================================
# This Dockerfile is for use by developers, or for those wishing to
# build, debug and run the project on a local development instance.
# ==============================================================================
FROM ubuntu:focal

# Install required packages
# ...add all required build toolchain dependencies for the project to this list
# ...add additional RUN commands as necessary for any custom install scripts
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y build-essential \
    lsb-release wget software-properties-common gnupg ccache doxygen gdb git \
    graphviz iwyu libssl-dev lcov net-tools ninja-build pmccabe python3-pip
RUN pip3 install cpplint
# RUN service service rsyslog restart  # run this manually if setting up dev

# Install newer version of clang-extra tools than available from default apt
RUN wget https://apt.llvm.org/llvm.sh
RUN chmod +x llvm.sh
RUN ./llvm.sh 11
RUN apt-get install -y clang-tidy-11 clang-format-11
RUN ln -sf $(which clang-tidy-11) /usr/local/bin/clang-tidy
RUN ln -sf $(which clang-format-11) /usr/local/bin/clang-format
RUN rm llvm.sh

# Install newer version of CMake (3.19.7) than available from default apt
RUN wget https://github.com/Kitware/CMake/releases/download/v3.19.7/cmake-3.19.7.tar.gz
RUN tar -xzf cmake-3.19.7.tar.gz
WORKDIR /cmake-3.19.7
RUN ./bootstrap -- -DCMAKE_BUILD_TYPE:STRING=Release
RUN make
RUN make install
WORKDIR /
RUN rm -rf ./cmake-3.19.7*
