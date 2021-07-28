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
    graphviz iwyu libssl-dev lcov net-tools ninja-build pmccabe python3-pip
RUN pip3 install cpplint pre-commit
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
RUN curl 'https://sandel0-my.sharepoint.com/personal/bjenkins_sandel_com/_layouts/15/download.aspx?SourceUrl=%2Fpersonal%2Fbjenkins%5Fsandel%5Fcom%2FDocuments%2Ftools%2Fpclp%2D1%2E3%2Flinux%2Fpclp64%5Flinux'   -H 'authority: sandel0-my.sharepoint.com'   -H 'upgrade-insecure-requests: 1'   -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'   -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   -H 'service-worker-navigation-preload: true'   -H 'sec-gpc: 1'   -H 'sec-fetch-site: same-origin'   -H 'sec-fetch-mode: navigate'   -H 'sec-fetch-user: ?1'   -H 'sec-fetch-dest: document'   -H 'referer: https://sandel0-my.sharepoint.com/personal/bjenkins_sandel_com/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fbjenkins%5Fsandel%5Fcom%2FDocuments%2Ftools%2Fpclp%2D1%2E3%2Flinux%2Fpclp64%5Flinux&parent=%2Fpersonal%2Fbjenkins%5Fsandel%5Fcom%2FDocuments%2Ftools%2Fpclp%2D1%2E3%2Flinux&originalPath=aHR0cHM6Ly9zYW5kZWwwLW15LnNoYXJlcG9pbnQuY29tLzp1Oi9nL3BlcnNvbmFsL2JqZW5raW5zX3NhbmRlbF9jb20vRVE3Q2pQdFlYaUZIZ2R2RUdPNWQ4dmNCTTlaNDhudDZiNm5KTzMtZF9heTVaQT9ydGltZT1jSHNLRDQ1QjJVZw'   -H 'accept-language: en-US,en;q=0.9'   -H 'cookie: MicrosoftApplicationsTelemetryDeviceId=441069e5-0c39-311d-f2cc-15ee6a17bb20; MicrosoftApplicationsTelemetryFirstLaunchTime=1625686060924; rtFa=1CJeLYbcsQLYOTEegJAhINaeg0jUlp+eyMa5LgbaljImQjI2M0Q4RjgtMzQ5QS00OUEyLUJERDgtRkE1MjJBNkFBRkJDbJLBOtDYnf5lylhSiQzPQxCcT8bo5yr3R/vYrm9uElI2aA36GWUHic7j+c5Cyga1rS6BFfXTf18+jGJ9U2P9r46FY4Mr1IVdVr81gi0MujpAopYQSW4XuG/le5P4ShXqu7UzPraTURb0TykBNA5jxhXgY9Yzv2K5wLp6l2Y1s1WLPMrOgAP3W6sw1NqJyFWdMsFf/g2JAOuBxOniCiKD8ps1L5CU4BbHCiMIcexvVN1xD3nsOLnMfPEF2nrKkSis7J5lTkbBIwGAuoltwzOeGbeq3ZTbm4qw5zqf2ykjvl8x6hXZeO/VWKDgBNFPH3akWKsbBWbCv4MEMMFKlEGuMUUAAAA=; FedAuth=77u/PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48U1A+VjEwLDBoLmZ8bWVtYmVyc2hpcHwxMDAzMjAwMTE2YTc5NDFhQGxpdmUuY29tLDAjLmZ8bWVtYmVyc2hpcHxiamVua2luc0BzYW5kZWwuY29tLDEzMjY5MTE0Njk3MDAwMDAwMCwxMzI2NjA4MjQyNDAwMDAwMDAsMTMyNzA1OTg1OTYyMTA1MTg3LDE4NC4xNzYuNDMuMTY2LDMsYjI2M2Q4ZjgtMzQ5YS00OWEyLWJkZDgtZmE1MjJhNmFhZmJjLCwzMTRmY2MwMS03YWQ0LTRjMzEtYjI4ZS0zN2JhMzZlYjRiNzUsNzU1MGQ5OWYtMzBhNC0wMDAwLWMwNGUtYTIyMTNiNWUzNzBiLDc1NTBkOTlmLTMwYTQtMDAwMC1jMDRlLWEyMjEzYjVlMzcwYiwsMCwxMzI3MDI1Mjk5NjE3OTI2MjksMTMyNzA0MjU3OTYxNzkyNjI5LCwsZXlKNGJYTmZZMk1pT2lKYlhDSkRVREZjSWwwaUxDSjRiWE5mYzNOdElqb2lNU0o5LDI2NTA0Njc3NDM5OTk5OTk5OTksMTMyNzAxNjY1OTUwMDAwMDAwLDZhZDRkNWI2LWUyOWMtNDYwMi1hODk1LTI3MzEzNGM0YzFlNSwsLCwsLHVsSytMMGtMMzl3VEYxUXFtcVlRUUVaK2FyQU1Wcy9Na2dvMkpoVG02WXZNa21iazQ1Ly9FRTNTcXVqTU4vSkx3TlgwOVphUGVHaXE3ZEtiRWM0UDlrd2IxOGh2QVZUNFVRTDQydE1XY0IvTktCUHJzTDdTczRYSUlxZXFLWjU3WHRqNXN6dVFGU1ZDanBkU0oxOGF0Wm9uSWNrc1FUOHhUeXpTMHAvOEhnb0UvMEVIVEJyMXJkS3JUVUdoZVBzNGp0eFozNmxIeERlaUVMS04yT1AvSllqeElCcndDMkVhYmNpMGFlSGt2ZjZXdXFxNWhDdjZlU2xaYi9SRytiMllhTlNUaWtmTUkzMjdJQXNVVlRVSk43cDNyK1E1a1dFUURQbFJYZXltNlNqV2hmbG5hOWprbUZNNlZZZXhVN1d2VFFoTkdxYlhzaWJUaUFMR25odG9sUT09PC9TUD4=; CCSInfo=Ny8xMy8yMDIxIDE6MTA6NTMgQU1J3KHKjqACaqT6SlTey+R55RAyccPEuxNV+Ad62E+S+KEc5n9ZnhAOIzwF6CWolsMEgfeMXIFKgs80Os2m+tKKO7G4EQAgxfs6EShDuiIKdwQHLFoPguQ6OdOaCBl+lW/ibeRprUaljVuwYj7qiw8PY00jaPZdLYYq/wGu887nquL+stB2ubj6e/kT3lw7SjeIqPtgpzKdwebVnyzOnnst02eyfq12uLxJi8IXfyWFhrUQB1v8Kvw9XUqYLoEkuMaPykE0lyy0z77cCYUONwIkkXbAV1B8qixn52+SQuzasUg6gG7yApOms8ejFFdWDB3kZB+XItvOApYZ4RAUX34BFAAAAA==' \
    --compressed --output pclp64_linux
RUN chmod +x pclp64_linux
RUN mv pclp64_linux /usr/local/bin/
