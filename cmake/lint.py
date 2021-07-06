#!/usr/bin/env python3

import subprocess
import sys

FAIL_BUILD_ON_VIOLATION = False


def lint(argv):
    """
    Invokes linting tool with given arguments and source file. This program
    always writes the output to stdout. :param argv: pass all arguments to the
    underlying PC-lint executable, and the source file to analyze :return: the
    process exit code (-1 if a function violation is reported to stderr)
    """

    # argv[1] - the lint executable name (must be in PATH or include the
    # fully-qualified path)
    lint_exe = argv[1]
    # argv[2] - unit (single source module) or global (all modules with global
    # wrap-up)
    unit = (argv[2] == "--unit" or argv[2] == "-u")
    # argv[3] - include path for lint option files
    lint_inc = argv[3]
    # argv[4] - compiler options file
    co_gcc_lnt = argv[4]
    # argv[5] - standards check rules options file
    stds_lnt = argv[5]
    # argv[6] - include directories separated by ';'
    include_dirs = argv[6]
    # argv[7] = compiler defines separated by ';'
    defines = argv[7]
    # argv[8] - the source file(s)
    sources = argv[8]
    # argv[9] - output file
    output_file = argv[9]

    if unit:
        unit_opt = "-u"
    else:
        unit_opt = ""

    includes = include_dirs.split(';')
    lint_includes = []
    for inc in includes:
        if len(inc) > 0:
            # prepend "-i" to each include dir (required for lint command)
            lint_includes.append("-i" + inc)

    defs = defines.split(';')
    lint_defines = []
    for define in defs:
        if len(define) > 0:
            if "=" in define:
                sep = define.split("=")
                define = sep[0] + "=" + '"' + sep[1] + \
                    '"'  # surround rvalue with quotes
            # prepend "-d" to each define (required for lint command)
            lint_defines.append("-d" + define)

    sources = sources.split(';')
    lint_sources = []
    for src in sources:
        # exclude assembly source files (C/C++ only)
        if len(src) > 0 and not src.endswith((".S", ".s", ".asm")):
            lint_sources.append(src)

    # note: '-frz' option is specified below to return nonzero exit status on
    # one or more PC-lint violation(s)
    cmd = f'{lint_exe} {lint_inc} {co_gcc_lnt} {stds_lnt} options.lnt {" ".join(lint_includes)} {" ".join(lint_defines)} -frz {unit_opt} {" ".join(lint_sources)}'
    completed_process = subprocess.run(
        args=cmd, capture_output=True, shell=True, text=True)

    if completed_process.returncode > 0:  # return code is violation count
        # sys.stderr.write(completed_process.stderr)  # hide banner output
        sys.stdout.write(completed_process.stdout)

    # log to output file
    f = open(output_file, "w")
    f.write(completed_process.stderr)
    f.seek(len(completed_process.stderr))
    f.write(completed_process.stdout)
    f.close()

    if FAIL_BUILD_ON_VIOLATION:
        return completed_process.returncode
    else:
        return 0


if __name__ == "__main__":
    sys.exit(lint(sys.argv))
