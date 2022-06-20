# ==============================================================================
# This Dockerfile is for use by CI, or for those wishing to build, debug and run
# the project on a local development instance.
#
# NOTE: if you modify this file, be sure to build and push the new image tag to
# the corresponding GitLab project's container registry:
#
#   $ docker login gitlab.sandel.com:5050
#   $ docker build -t gitlab.sandel.com:5050/<group>/<project> .
#   $ docker push gitlab.sandel.com:5050/<group>/<project>
#   $ docker logout
# ==============================================================================
FROM ubuntu:focal

# Install required packages
# ...add all required build toolchain dependencies for the project to this list
# ...add additional RUN commands as necessary for any custom install scripts
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y build-essential curl \
    lsb-release wget software-properties-common gnupg ccache doxygen gdb git \
    graphviz iwyu libssl-dev lcov net-tools pmccabe python3-pip unzip
RUN pip3 install cpplint lcov_cobertura pre-commit
# RUN service service rsyslog restart  # run this manually if setting up dev

# Install newer version of clang-extra tools than available from default apt
RUN wget https://apt.llvm.org/llvm.sh
RUN chmod +x llvm.sh
RUN ./llvm.sh 13
RUN apt-get install -y clang-tidy-13 clang-format-13
RUN ln -sf $(which clang-tidy-13) /usr/local/bin/clang-tidy
RUN ln -sf $(which clang-format-13) /usr/local/bin/clang-format
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

# Install pc-lint plus
RUN wget https://gitlab.sandel.com/toolchain/cmake-project-template/-/wikis/uploads/735f6737d5b0dec492d7ef5cd37397e5/pclp64_linux.zip
RUN unzip pclp64_linux.zip
RUN chmod +x pclp64_linux
RUN mv pclp64_linux /usr/local/bin/
