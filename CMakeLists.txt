#▶1 Header
cmake_minimum_required(VERSION 2.8.7)

set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

project(diplom NONE)
#▶1 includes
set(CMAKE_SCRIPTS_DIR "${CMAKE_CURRENT_LIST_DIR}/cmake")
include("${CMAKE_SCRIPTS_DIR}/RequireProgram.cmake")
#▶1 requirements
require_program(INKSCAPE_COMMAND inkscape)
require_program(DIA_COMMAND dia)
require_program(DOT_COMMAND dot)
require_program(MAKEINDEX_COMMAND makeindex)
require_program(PDFCROP_COMMAND pdfcrop)
find_program(GS_COMMAND NAMES gs gswin32c)
if(GS_COMMAND MATCHES "-NOTFOUND$")
    message(STATUS "Failed to find gs")
else()
    message(STATUS "Found gs: ${GS_COMMAND}")
endif()
find_package(LATEX
             COMPONENTS XELATEX PDFLATEX BIBTEX
             REQUIRED)
find_package(Perl REQUIRED)
#▶1 Options
#▶2 Definitions
set(PREFER_XELATEX on CACHE BOOL "Prefer XeLaTeX over PDFLaTeX")
#▶2 Processing
# CMake-2.8.7 actually has no XELATEX component, so it will not define 
# XELATEX_COMPILER. Neither it will error out on unknown component above.
if(PREFER_XELATEX)
    if(NOT DEFINED XELATEX_COMPILER)
        require_program(XELATEX_COMPILER xelatex)
    endif()
    set(USED_LATEX_COMPILER
        "${XELATEX_COMPILER}" -synctex=1 -interaction=nonstopmode -shell-escape)
else()
    set(USED_LATEX_COMPILER "${PDFLATEX_COMPILER}")
    require_program(ICONV_COMMAND iconv)
endif()
#▶1 Variables
set(TEX_TREE "${CMAKE_SOURCE_DIR}/tex")

set(MIRROR_TREE "${CMAKE_BINARY_DIR}/mirror")
set(TEX_MIRROR_TREE "${MIRROR_TREE}/tex")
set(INC_TREE "${TEX_MIRROR_TREE}/inc")
set(INC_IMG_TREE "${INC_TREE}/img")
set(INC_DIA_TREE "${INC_TREE}/dia")
set(INC_SVG_TREE "${INC_TREE}/svg")
set(INC_DOT_TREE "${INC_TREE}/dot")
set(INC_SRC_TREE "${INC_TREE}/src")
set(MAIN_TEX rpz)
set(NOM_NLO "${MAIN_TEX}.nlo")
set(NOM_IST nomencl.ist)
set(NOM_NLS "${MAIN_TEX}.nls")

set(TARGET_PDF_BASE rpz.pdf)
set(TARGET_PDF "${CMAKE_BINARY_DIR}/${TARGET_PDF_BASE}")
set(GSCONV_SCRIPT "${CMAKE_SCRIPTS_DIR}/GSConv.cmake")
set(COPY_CONVERTED_SCRIPT "${CMAKE_SCRIPTS_DIR}/CopyConverted.cmake")
#▶1 Prepare build directory
file(MAKE_DIRECTORY "${MIRROR_TREE}")
file(MAKE_DIRECTORY "${TEX_MIRROR_TREE}")
file(MAKE_DIRECTORY "${INC_TREE}")
file(MAKE_DIRECTORY "${INC_IMG_TREE}")
file(MAKE_DIRECTORY "${INC_DIA_TREE}")
file(MAKE_DIRECTORY "${INC_SVG_TREE}")
file(MAKE_DIRECTORY "${INC_DOT_TREE}")
file(MAKE_DIRECTORY "${INC_SRC_TREE}")
#▶1 Find sources
function(glob_in_dir varname dir)
    file(RELATIVE_PATH dir_rel "${CMAKE_CURRENT_LIST_DIR}" "${dir}")
    set(sources_abs)
    foreach(glob ${ARGN})
        file(GLOB sources "${dir_rel}/${glob}")
        list(APPEND sources_abs "${sources}")
    endforeach()
    set(${varname} ${sources_abs} PARENT_SCOPE)
endfunction()
glob_in_dir(tex_sources "${TEX_TREE}" *.tex *.sty *.clo *.bst *.cls *.bib)
glob_in_dir(listing_sources "${CMAKE_SOURCE_DIR}/src" *)
glob_in_dir(img_sources "${CMAKE_SOURCE_DIR}/graphics/img" *)
glob_in_dir(svg_sources "${CMAKE_SOURCE_DIR}/graphics/svg" *.svg)
glob_in_dir(dia_sources "${CMAKE_SOURCE_DIR}/graphics/dia" *.dia)
glob_in_dir(dot_sources "${CMAKE_SOURCE_DIR}/graphics/dot" *.dot)
#▶1 Generate sources
#▶2 Tex sources
set(tex_mirror_sources)
foreach(tex_src ${tex_sources})
    file(RELATIVE_PATH tex_src_rel "${TEX_TREE}" "${tex_src}")
    set(tex_dst "${TEX_MIRROR_TREE}/${tex_src_rel}")
    add_custom_command(
        OUTPUT "${tex_dst}"
        VERBATIM
        COMMAND "${CMAKE_COMMAND}" -E copy "${tex_src}" "${tex_dst}"
        DEPENDS "${tex_src}"
    )
    list(APPEND tex_mirror_sources "${tex_dst}")
endforeach()
#▶2 Img sources
set(img_mirror_sources)
foreach(img_src ${img_sources})
    get_filename_component(img_name "${img_src}" NAME)
    set(img_dst "${INC_IMG_TREE}/${img_name}")
    add_custom_command(
        OUTPUT "${img_dst}"
        VERBATIM
        COMMAND "${CMAKE_COMMAND}" -E copy "${img_src}" "${img_dst}"
        DEPENDS "${img_src}"
    )
    list(APPEND img_mirror_sources "${img_dst}")
endforeach()
#▶2 SVG
set(svg_pdfs)
foreach(svg_src ${svg_sources})
    get_filename_component(svg_base "${svg_src}" NAME_WE)
    set(svg_dst "${INC_SVG_TREE}/${svg_base}.pdf")
    set(svg_dst_tmp_rel "${svg_base}-tmp.pdf")
    file(RELATIVE_PATH svg_dst_rel "${INC_SVG_TREE}" "${svg_dst}")
    file(RELATIVE_PATH svg_src_rel "${INC_SVG_TREE}" "${svg_src}")
    add_custom_command(
        OUTPUT "${svg_dst}"
        WORKING_DIRECTORY "${INC_SVG_TREE}"
        VERBATIM
        COMMAND
            "${INKSCAPE_COMMAND}" --export-type=pdf -o "${svg_dst_tmp_rel}" "${svg_src_rel}"
        COMMAND
            "${PDFCROP_COMMAND}" "${svg_dst_tmp_rel}" "${svg_dst_rel}"
        COMMAND
            "${CMAKE_COMMAND}" -E remove "${svg_dst_tmp_rel}"
        DEPENDS "${svg_src}"
    )
    list(APPEND svg_pdfs "${svg_dst}")
endforeach()
#▶2 dia
set(dia_pdfs)
foreach(dia_src ${dia_sources})
    get_filename_component(dia_base "${dia_src}" NAME_WE)
    set(dia_dst "${INC_DIA_TREE}/${dia_base}.pdf")
    set(dia_dst_svg_tmp_rel "${dia_base}-tmp.svg")
    set(dia_dst_pdf_tmp_rel "${dia_base}-tmp.pdf")
    file(RELATIVE_PATH dia_dst_rel "${INC_DIA_TREE}" "${dia_dst}")
    file(RELATIVE_PATH dia_src_rel "${INC_DIA_TREE}" "${dia_src}")
    add_custom_command(
        OUTPUT "${dia_dst}"
        WORKING_DIRECTORY "${INC_DIA_TREE}"
        VERBATIM
        COMMAND
            "${DIA_COMMAND}" -e "${dia_dst_svg_tmp_rel}" -t svg "${dia_src_rel}"
        COMMAND
            "${INKSCAPE_COMMAND}" --export-type=pdf -o "${dia_dst_pdf_tmp_rel}"
                                  "${dia_dst_svg_tmp_rel}"
        COMMAND
            "${PDFCROP_COMMAND}" "${dia_dst_pdf_tmp_rel}" "${dia_dst_rel}"
        COMMAND
            "${CMAKE_COMMAND}" -E remove "${dia_dst_svg_tmp_rel}"
        COMMAND
            "${CMAKE_COMMAND}" -E remove "${dia_dst_pdf_tmp_rel}"
        DEPENDS "${dia_src}"
    )
    list(APPEND dia_pdfs "${dia_dst}")
endforeach()
#▶2 dot
set(dot_pdfs)
foreach(dot_src ${dot_sources})
    get_filename_component(dot_base "${dot_src}" NAME_WE)
    set(dot_dst "${INC_DOT_TREE}/${dot_base}.pdf")
    set(dot_dst_svg_tmp_rel "${dot_base}-tmp.svg")
    set(dot_dst_pdf_tmp_rel "${dot_base}-tmp.pdf")
    file(RELATIVE_PATH dot_dst_rel "${INC_DIA_TREE}" "${dot_dst}")
    file(RELATIVE_PATH dot_src_rel "${INC_DIA_TREE}" "${dot_src}")
    add_custom_command(
        OUTPUT "${dot_dst}"
        WORKING_DIRECTORY "${INC_DIA_TREE}"
        VERBATIM
        COMMAND
            "${DOT_COMMAND}" -Tsvg "-o${dot_dst_svg_tmp_rel}" "${dot_src_rel}"
        COMMAND
            "${INKSCAPE_COMMAND}" --export-type=pdf -o "${dot_dst_pdf_tmp_rel}"
                                  "${dot_dst_svg_tmp_rel}"
        COMMAND
            "${PDFCROP_COMMAND}" "${dot_dst_pdf_tmp_rel}" "${dot_dst_rel}"
        COMMAND
            "${CMAKE_COMMAND}" -E remove "${dot_dst_svg_tmp_rel}"
        COMMAND
            "${CMAKE_COMMAND}" -E remove "${dot_dst_pdf_tmp_rel}"
        DEPENDS "${dot_src}"
    )
    list(APPEND dot_pdfs "${dot_dst}")
endforeach()
#▶2 Listing sources
set(mirror_listing_sources)
foreach(listing_src ${listing_sources})
    get_filename_component(listing_name "${listing_src}" NAME)
    set(listing_dst "${INC_SRC_TREE}/${listing_name}")
    if(PREFER_XELATEX)
        add_custom_command(
            OUTPUT "${listing_dst}"
            VERBATIM
            COMMAND "${CMAKE_COMMAND}" -E copy "${listing_src}" "${listing_dst}"
            DEPENDS "${listing_src}"
        )
    else()
        add_custom_command(
            OUTPUT "${listing_dst}"
            VERBATIM
            COMMAND
                "${CMAKE_COMMAND}"
                    "-DSRC=${listing_src}"
                    "-DDST=${listing_dst}"
                    "-DICONV_COMMAND=${ICONV_COMMAND}"
                    -DSRC_ENCODING=utf-8
                    -DDST_ENCODING=koi8-r
                    -P "${COPY_CONVERTED_SCRIPT}"
            DEPENDS "${listing_src}" "${COPY_CONVERTED_SCRIPT}"
        )
    endif()
    list(APPEND mirror_listing_sources "${listing_dst}")
endforeach()
#▶1 Main target
# TODO(?) use texdepend
add_custom_target(
    latex-stage1
    WORKING_DIRECTORY "${TEX_MIRROR_TREE}"
    VERBATIM
    COMMAND ${USED_LATEX_COMPILER} "${MAIN_TEX}"
    DEPENDS
        ${svg_pdfs} ${dia_pdfs} ${dot_pdfs}
        ${tex_mirror_sources} ${mirror_listing_sources}
        ${img_mirror_sources}
)
add_custom_target(
    bibtex
    WORKING_DIRECTORY "${TEX_MIRROR_TREE}"
    VERBATIM
    COMMAND ${BIBTEX_COMPILER} "${MAIN_TEX}"
    DEPENDS latex-stage1
)
add_custom_target(
    makeindex
    WORKING_DIRECTORY "${TEX_MIRROR_TREE}"
    VERBATIM
    COMMAND ${MAKEINDEX_COMMAND} "${NOM_NLO}" -s "${NOM_IST}" -o "${NOM_NLS}"
    DEPENDS latex-stage1
)
add_custom_target(
    latex-stage2
    WORKING_DIRECTORY "${TEX_MIRROR_TREE}"
    VERBATIM
    COMMAND ${USED_LATEX_COMPILER} "${MAIN_TEX}"
    DEPENDS bibtex makeindex
)
add_custom_target(
    latex-stage3
    WORKING_DIRECTORY "${TEX_MIRROR_TREE}"
    VERBATIM
    COMMAND ${USED_LATEX_COMPILER} "${MAIN_TEX}"
    DEPENDS latex-stage2
)
add_custom_target(
    pdf
    ALL
    VERBATIM
    WORKING_DIRECTORY "${TEX_MIRROR_TREE}"
    COMMAND "${CMAKE_COMMAND}" -E copy "${TARGET_PDF_BASE}" "${TARGET_PDF}"
    DEPENDS latex-stage3
)
add_custom_target(
    printpdfs
    VERBATIM
    COMMAND
        "${CMAKE_COMMAND}"
            "-DGS_COMMAND=${GS_COMMAND}"
            "-DPDF=${TARGET_PDF_BASE}"
            "-DTMPDIR=gs-tmp"
            -P "${GSCONV_SCRIPT}"
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
    DEPENDS pdf "${GSCONV_SCRIPT}"
)
# vim: foldmarker=▶,▲ cms=#%s
