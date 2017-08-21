function(gs_batch gs_out_varname)
    message(STATUS "Running ${GS_COMMAND} with arguments ${ARGN}")
    execute_process(
        COMMAND "${GS_COMMAND}" ${ARGN}
        OUTPUT_VARIABLE out
        ERROR_VARIABLE err
        RESULT_VARIABLE res
    )
    if(NOT res EQUAL 0)
        message(FATAL_ERROR "Ghostscript failed with output\n(err)\n${err}\n(out)\n${out}")
    endif()
    if(NOT gs_out_varname STREQUAL "IGNORE_OUTPUT")
        set("${gs_out_varname}" "${out}" PARENT_SCOPE)
    endif()
endfunction()

function(parse_cmyk cmy_varname k_varname page_varname page_lines)
    string(
        REGEX MATCH
        "^Page ([0-9]+)\n[ \t]*([0-9]+\\.[0-9]+)[ \t]+([0-9]+\\.[0-9]+)[ \t]+([0-9]+\\.[0-9]+)[ \t]+([0-9]+\\.[0-9]+)[ \t]+CMYK OK\n$"
        page_lines_match
        "${page_lines}"
    )
    if(NOT page_lines_match STREQUAL page_lines)
        message(FATAL_ERROR "Invalid cmyk input: ${cmyk_line}")
    endif()
    set("${page_varname}" "${CMAKE_MATCH_1}" PARENT_SCOPE)
    set(
        "${cmy_varname}"
        "${CMAKE_MATCH_2}" "${CMAKE_MATCH_3}" "${CMAKE_MATCH_4}"
        PARENT_SCOPE
    )
    set("${k_varname}" "${CMAKE_MATCH_5}" PARENT_SCOPE)
endfunction()

function(pagefile fname_varname page)
    if(page LESS 10)
        set(pagestr "000${page}")
    elseif(page GREATER 9)
        set(pagestr "00${page}")
    elseif(page GREATER 99)
        set(pagestr "0${page}")
    elseif(page GREATER 999)
        set(pagestr "${page}")
    endif()
    string(REPLACE "%04d" "${pagestr}" fname "${PS_TEMPLATE}")
    set("${fname_varname}" "${fname}" PARENT_SCOPE)
endfunction()

file(MAKE_DIRECTORY "${TMPDIR}")

string(REGEX REPLACE "\\.pdf$" "" PDF_R "${PDF}")

set(REPRINT_TGT "${PDF_R}.gs.pdf")
set(COLOR_TGT "${PDF_R}.gs-color.pdf")
set(GRAY_TGT "${PDF_R}.gs-gray.pdf")

file(TO_NATIVE_PATH "${TMPDIR}/pdf-%04d.ps" PS_TEMPLATE)
file(TO_NATIVE_PATH "${TMPDIR}/pdf.ps" PS_FILE)

gs_batch(
    IGNORE_OUTPUT
    "-o${PS_FILE}" "-dPDFSETTINGS=/printer" "-sDEVICE=ps2write" "${PDF}"
)
gs_batch(
    IGNORE_OUTPUT
    "-o${PS_TEMPLATE}" "-dPDFSETTINGS=/printer" "-sDEVICE=ps2write"
    "${PS_FILE}"
)
gs_batch(
    IGNORE_OUTPUT
    "-o${REPRINT_TGT}" "-dPDFSETTINGS=/printer" "-sDEVICE=pdfwrite"
    "${PS_FILE}"
)

gs_batch(GS_OUT "-o-" "-sDEVICE=inkcov" "${REPRINT_TGT}")
string(
    REGEX MATCHALL
    "Page [0-9]+\n[ \t]*[0-9]+\\.[0-9]+[ \t]+[0-9]+\\.[0-9]+[ \t]+[0-9]+\\.[0-9]+[ \t]+[0-9]+\\.[0-9]+[ \t]+CMYK OK\n"
    PAGE_LINESS "${GS_OUT}"
)

set(next_page 1)
set(gray_pages)
set(color_pages)
set(has_gray_pages FALSE)
set(has_color_pages FALSE)
foreach(page_lines ${PAGE_LINESS})
    parse_cmyk(cmy k page "${page_lines}")
    if(NOT page EQUAL next_page)
        message(WARNING "Expected page ${next_page}, but got ${page}")
    endif()
    math(EXPR next_page "${page} + 1")
    set(grayscale TRUE)
    foreach(c ${cmy})
        if(NOT c MATCHES "^0\\.0+$")
            set(grayscale FALSE)
        endif()
    endforeach()
    pagefile(page_fname "${page}")
    if(grayscale)
        list(APPEND gray_pages "${page_fname}")
        set(has_gray_pages TRUE)
    else()
        list(APPEND color_pages "${page_fname}")
        set(has_color_pages TRUE)
    endif()
endforeach()
if(has_gray_pages)
    if(has_color_pages)
        gs_batch(IGNORE_OUTPUT "-o${GRAY_TGT}" "-sDEVICE=pdfwrite" ${gray_pages})
        gs_batch(IGNORE_OUTPUT "-o${COLOR_TGT}" "-sDEVICE=pdfwrite" ${color_pages})
    else()
        configure_file("${REPRINT_TGT}" "${GRAY_TGT}" COPYONLY)
    endif()
else()
    if(has_color_pages)
        configure_file("${REPRINT_TGT}" "${COLOR_TGT}" COPYONLY)
    else()
        message(FATAL_ERROR "Output has no pages")
    endif()
endif()

file(REMOVE_RECURSE "${TMPDIR}")
