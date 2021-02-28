FROM debian:10

# add all required build toolchain dependencies for the project to this list
# add additional RUN commands as necessary for any custom install scripts
RUN apt-get update \
    && apt-get install -y lsb-release wget software-properties-common gnupg \
        ccache cmake doxygen git graphviz iwyu lcov ninja-build pmccabe \
        python3-pip \
    && wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh \
    && apt-get install -y clang-tidy-11 clang-format-11 \
    && ln -sf $(which clang-tidy-11) /usr/local/bin/clang-tidy \
    && ln -sf $(which clang-format-11) /usr/local/bin/clang-format \
    && pip3 install cpplint
