#!/usr/bin/env python3

import subprocess
import sys

from cyclomatic_exceptions import CYCLOMATIC_COMPLEXITY_EXCEPTIONS

CYCLOMATIC_COMPLEXITY_VIOLATION_THRESHOLD = 20
FAIL_BUILD_ON_VIOLATION = False


def pmccabe_threshold(argv):
    """
    Invokes pmccabe to determine the cyclomatic complexity metrics for the C/C++
    source file given in argv[1]. This program always writes the output of
    pmccabe to stdout. If a function in the given source file exceeds the
    cyclomatic complexity violation threshold specified by
    CYCLOMATIC_COMPLEXITY_VIOLATION_THRESHOLD, and error message will be written
    to stderr detailing the offending line number and function name, along with
    returning -1 to the caller. Otherwise, the return code of pmccabe is
    returned to the caller (normally 0 indicating a successful run). :param
    argv: the only argument must specify the path to the C/C++ source file to
    analyze :return: the process exit code (-1 if a function violation is
    reported to stderr)
    """
    # argv[1] is the source file to perform cyclomatic complexity analysis on
    cmd = f"pmccabe -v {argv[1]}"
    completed_process = subprocess.run(args=cmd, capture_output=True,
                                       shell=True, text=True)

    print(completed_process.stdout)  # always print the pmccabe output to stdout

    # parse the output to determine if a violation occurred
    for line in completed_process.stdout.splitlines():
        if line[0] == "M" or line[0] == "|":
            continue  # this is a column header line, skip it
        results = line.split('\t')
        modified_mccabe_complexity = int(results[0])
        # traditional_mccabe_complexity = int(results[1])
        # num_statements_in_function = int(results[2]) first_line_of_function =
        # int(results[3]) num_lines_in_function = int(results[4])
        filename_function_name = results[5]

        start_idx = filename_function_name.find("(")
        end_idx = filename_function_name.find(")")
        filename = filename_function_name[0:start_idx]
        line_num = filename_function_name[(start_idx + 1):end_idx]
        fun_name = filename_function_name[(end_idx + 1):].replace(": ", "").strip()

        # sys.stderr.write("fun_name: " + fun_name + "\n")

        if modified_mccabe_complexity > CYCLOMATIC_COMPLEXITY_VIOLATION_THRESHOLD and \
                fun_name not in CYCLOMATIC_COMPLEXITY_EXCEPTIONS:
            if FAIL_BUILD_ON_VIOLATION:
                err_txt = "error:"
            else:
                err_txt = "warning:"
            err_msg = f"{filename}:{line_num}: {err_txt} {fun_name} exceeds cyclomatic complexity limit [actual: " \
                      f"{str(modified_mccabe_complexity)}, " \
                      f"limit: {str(CYCLOMATIC_COMPLEXITY_VIOLATION_THRESHOLD)}]\n"
            sys.stdout.write(err_msg)
            sys.stderr.write(err_msg)
            if FAIL_BUILD_ON_VIOLATION:
                return -1

    return completed_process.returncode


if __name__ == "__main__":
    sys.exit(pmccabe_threshold(sys.argv))
