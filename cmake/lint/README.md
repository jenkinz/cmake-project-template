# Instructions for Configuring PC-Lint Plus

These instructions generate compiler-specific configurtion option files for
PC-Lint Plus. This needs to be run in the target environment containing the
desired compilation toolchain.

Prerequisites: Python 2.7, `virtualenv`

# macOS (clang)

    $ virtualenv -p $(which python) venv
    $ . venv/bin/activate
    $ python pclp_config.py --compiler=clang --compiler-bin=$(which clang) \
        --config-output-lnt-file=co-clang.lnt \
        --config-output-header-file=co-clang.h \
        --generate-compiler-config

# Linux or WSL (gcc)

    $ virtualenv -p $(which python) venv
    $ . venv/bin/activate
    $ python pclp_config.py --compiler=gcc --compiler-bin=$(which gcc) \
    --config-output-lng-file=co-gcc.lnt \
    --config-output-header-file=co-gcc.h \
    --generate-compiler-config
