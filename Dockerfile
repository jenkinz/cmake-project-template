FROM debian:10

# add all required build toolchain dependencies for the project to this list
# add additional RUN commands as necessary for any custom install scripts
RUN apt-get update \
    && apt-get install -y ccache clang-format clang-tidy cmake doxygen \
    git graphviz iwyu ninja-build pmccabe python3-pip \
    && pip3 install cpplint
