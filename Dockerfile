FROM debian:10

# RUN apt-get update \
#     && apt-get install -y ccache clang-format clang-tidy cmake doxygen \
#     git graphviz iwyu libmosquitto-dev ninja-build pmccabe python3-pip libusb-1.0\
#     && pip3 install cpplint

# RUN git clone https://github.com/accesio/AIOUSB.git
# RUN mkdir /AIOUSB/AIOUSB/build
# WORKDIR /AIOUSB/AIOUSB/build
# RUN cmake -GNinja -DBUILD_AIOUSBCPPDBG_SHARED=OFF \
#     -DBUILD_AIOUSBCPP_SHARED=OFF \
#     -DBUILD_AIOUSBDBG_SHARED=OFF \
#     -DBUILD_AIOUSB_SHARED=OFF ..
# RUN cmake --build .
# RUN cmake --build . --target install
