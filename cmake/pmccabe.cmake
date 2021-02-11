# pmccabe (check C/C++ per-function cyclomatic complexity)
find_package (Python3 COMPONENTS Interpreter)
find_program(PMCCABE NAMES "pmccabe" DOC "Path to pmccabe executable")
if(NOT PMCCABE OR NOT Python3_FOUND)
    message(STATUS "pmccabe or python3 not found (per-function cyclomatic complexity will not be calculated)")
else()
    message(STATUS "pmccabe and python3 found: ${PMCCABE} (per-function cyclomatic complexity will be calculated)")
endif(NOT PMCCABE OR NOT Python3_FOUND)

function(target_add_cyclomatic_complexity_checks target_name)
    get_target_property(source_list ${target_name} SOURCES)

    # Perform cyclomatic complexity analysis
    set(all_pmccabe_out_files)
    if(PMCCABE)
        foreach(source ${source_list})
            get_filename_component(source-filename ${source} NAME)
            set(pmccabe_out_file ${CMAKE_CURRENT_BINARY_DIR}/static_analysis/pmccabe/${source}.pmccabe.txt)
            add_custom_command(OUTPUT ${pmccabe_out_file}
                COMMAND ${Python3_EXECUTABLE} ./cmake/pmccabe_threshold.py ${source} > ${pmccabe_out_file}
                DEPENDS ${source}
                IMPLICIT_DEPENDS ${implicit_depends_lang} ${source}
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                COMMENT "Analyzing cyclomatic complexity of ${source}"
                VERBATIM)
            set(all_pmccabe_out_files ${all_pmccabe_out_files} ${pmccabe_out_file})
        endforeach(source)
        add_custom_target(${target_name}_PMCCABE DEPENDS ${all_pmccabe_out_files})
        add_dependencies(${target_name} ${target_name}_PMCCABE)
    endif(PMCCABE)
endfunction(target_add_cyclomatic_complexity_checks)
