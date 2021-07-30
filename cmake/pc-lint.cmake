# PC-lint plus (pclp)
find_package (Python3 COMPONENTS Interpreter)
find_program(PCLP NAMES "pclp64_macos" "pclp64_linux" "pclp64.exe" DOC "Path to PC-lint Plus executable")
if (NOT PCLP OR NOT Python3_FOUND)
    message(STATUS "PC-Lint Plus or python3 not found (Lint checks will not be performed)")
else()
    message(STATUS "PC-Lint and python3 found: ${PCLP} (Lint checks will be performed)")
endif(NOT PCLP OR NOT Python3_FOUND)

# Perform static analysis on target sources
function(target_add_pclint_checks target_name)
    get_target_property(source_list ${target_name} SOURCES)
    get_target_property(lint_include_directories ${target_name} INCLUDE_DIRECTORIES)
    get_target_property(lint_defines ${target_name} COMPILE_DEFINITIONS)

    # Perform PC-Lint Plus checks and static analysis
    if(PCLP)
        set(all_lint_out_files)

        # Set the desired standards checks here:
        #   for C:      au-misra3.lnt -- MISRA-C:2012
        #   for C++:    au-autosar.lnt -- Autosar C++14
        set(lint_stds_checks "au-autosar.lnt")

        # PC-Lint Plus must be in PATH (avoid errors when spaces in path)
		get_filename_component(pclp_exe ${PCLP} NAME)

        if(${pclp_exe} STREQUAL "pclp64_macos")
            set(co_gcc_lnt "co-clang.lnt")
        else()
            set(co_gcc_lnt "co-gcc.lnt")
        endif()

        # individual (unit) lint -- enable during initial lint development/integration only
        #foreach(source ${source_list})
        #    get_filename_component(source_filename ${source} NAME)
        #    set(lint_out_file ${CMAKE_CURRENT_BINARY_DIR}/static_analysis/lint/${source}.lint.txt)
        #    if (source_filename MATCHES \\.cxx$|\\.cpp$)
        #        set(misra_lnt "au-autosar.lnt")
        #        set(implicit_depends_lang CXX)
        #    elseif(source_filename MATCHES \\.c$)
        #        set(misra_lnt "au-misra3.lnt")
        #        set(implicit_depends_lang C)
        #    else()
        #        continue() # unsupported source file (e.g. assembly)
        #    endif()

        #    add_custom_command(OUTPUT ${lint_out_file}
        #        COMMAND ${Python3_EXECUTABLE} ./cmake/lint.py
        #            "${pclp_exe}"
        #            "--unit"
        #            -i./cmake/lint
        #            ${co_gcc_lnt}
        #            "au-misra3.lnt au-misra-cpp.lnt"
        #            "${lint_include_directories}"
        #            "${lint_defines}"
        #            ${source}
        #            ${lint_out_file}
        #        DEPENDS ${source}
        #        #IMPLICIT_DEPENDS ${implicit_depends_lang} ${source}
        #        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        #        COMMENT "PC-lint performing static analysis on ${source}"
        #        VERBATIM)

        #    set(all_lint_out_files ${all_lint_out_files} ${lint_out_file})
        #endforeach(source)
        #add_custom_target(${target_name}_LINT DEPENDS ${all_lint_out_files})
        #add_dependencies(${target_name} ${target_name}_LINT)

        # all lint (including wrap-up) -- enable once initial lint
        # development/integration completed
        set(all_lint_out_file
            ${CMAKE_CURRENT_BINARY_DIR}/static_analysis/lint/${target_name}.lint.txt)

        add_custom_command(OUTPUT ${all_lint_out_file}
            COMMAND ${Python3_EXECUTABLE} ./cmake/lint.py
                "${pclp_exe}"
                "--global"
                "-i./cmake/lint"
                "${co_gcc_lnt}"
                "${lint_stds_checks}"
                "${lint_include_directories}"
                "${lint_defines}"
                "${source_list}"
                "${all_lint_out_file}"
            DEPENDS ${source_list}
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
            COMMENT "PC-lint performing static analysis on ${source_list}"
            VERBATIM)
        add_custom_target(${target_name}_ALL_LINT DEPENDS ${all_lint_out_file})
        add_dependencies(${target_name} ${target_name}_ALL_LINT)
        # if(PMCCABE)
        #    # make pmccabe go first before lint
        #     add_dependencies(${target_name}_ALL_LINT ${target_name}_PMCCABE)
        # endif(PMCCABE)
    endif(PCLP)
endfunction(target_add_pclint_checks target_name)
