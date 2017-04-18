#▶1 Header
cmake_minimum_required(VERSION 2.8.7)

set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

project(diplom NONE)
#▶1 includes
include(${CMAKE_CURRENT_LIST_DIR}/cmake/RequireProgram.cmake)
#▶1 requirements
require_program(INKSCAPE_COMMAND inkscape)
require_program(DIA_COMMAND dia)
require_program(DOT_COMMAND dot)
require_program(MAKEINDEX_COMMAND makeindex)
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
if(NOT DEFINED XELATEX_COMPILER)
    set(PREFER_XELATEX false)
endif()
if(PREFER_XELATEX)
    set(USED_LATEX_COMPILER
        ${XELATEX_COMPILER} -interaction=nonstopmode -shell-escape)
else()
    set(USED_LATEX_COMPILER ${PDFLATEX_COMPILER})
    require_program(ICONV_COMMAND iconv)
endif()
#▶1 Variables
set(UTILS_DIR ${CMAKE_SOURCE_DIR}/utils)
set(PDFCROP ${UTILS_DIR}/pdfcrop)

set(TEX_TREE ${CMAKE_SOURCE_DIR}/tex)

set(MIRROR_TREE ${CMAKE_BINARY_DIR}/mirror)
set(TEX_MIRROR_TREE ${MIRROR_TREE}/tex)
set(INC_TREE ${TEX_MIRROR_TREE}/inc)
set(INC_DIA_TREE ${INC_TREE}/dia)
set(INC_SVG_TREE ${INC_TREE}/svg)
set(INC_DOT_TREE ${INC_TREE}/dot)
set(INC_SRC_TREE ${INC_TREE}/src)
set(MAIN_TEX rpz)
set(NOM_NLO ${MAIN_TEX}.nlo)
set(NOM_IST nomencl.ist)
set(NOM_NLS ${MAIN_TEX}.nls)

set(TARGET_PDF_BASE rpz.pdf)
set(TARGET_PDF ${CMAKE_BINARY_DIR}/${TARGET_PDF_BASE})
#▶1 Prepare build directory
file(MAKE_DIRECTORY ${MIRROR_TREE})
file(MAKE_DIRECTORY ${TEX_MIRROR_TREE})
file(MAKE_DIRECTORY ${INC_TREE})
file(MAKE_DIRECTORY ${INC_DIA_TREE})
file(MAKE_DIRECTORY ${INC_SVG_TREE})
file(MAKE_DIRECTORY ${INC_DOT_TREE})
file(MAKE_DIRECTORY ${INC_SRC_TREE})
#▶1 Find sources
file(
    GLOB tex_sources
    ${TEX_TREE}/*.tex
    ${TEX_TREE}/*.sty
    ${TEX_TREE}/*.clo
    ${TEX_TREE}/*.bst
    ${TEX_TREE}/*.cls
    ${TEX_TREE}/*.bib
)
file(
    GLOB listing_sources
    ${CMAKE_SOURCE_DIR}/src/*
)
file(
    GLOB svg_sources
    ${CMAKE_SOURCE_DIR}/graphics/svg/*.svg
)
file(
    GLOB dia_sources
    ${CMAKE_SOURCE_DIR}/graphics/dia/*.dia
)
file(
    GLOB dot_sources
    ${CMAKE_SOURCE_DIR}/graphics/dot/*.dot
)
#▶1 Generate sources
#▶2 Tex sources
set(tex_mirror_sources)
foreach(tex_src ${tex_sources})
    file(RELATIVE_PATH tex_src_rel ${TEX_TREE} ${tex_src})
    set(tex_dst ${TEX_MIRROR_TREE}/${tex_src_rel})
    add_custom_command(
        OUTPUT ${tex_dst}
        COMMAND ${CMAKE_COMMAND} -E copy ${tex_src} ${tex_dst}
        DEPENDS ${tex_src}
    )
    list(APPEND tex_mirror_sources ${tex_dst})
endforeach()
#▶2 SVG
set(svg_pdfs)
foreach(svg_src ${svg_sources})
    get_filename_component(svg_base ${svg_src} NAME_WE)
    set(svg_dst ${INC_SVG_TREE}/${svg_base}.pdf)
    set(svg_dst_tmp_rel ${svg_base}-tmp.pdf)
    file(RELATIVE_PATH svg_dst_rel ${INC_SVG_TREE} ${svg_dst})
    file(RELATIVE_PATH svg_src_rel ${INC_SVG_TREE} ${svg_src})
    add_custom_command(
        OUTPUT ${svg_dst}
        WORKING_DIRECTORY ${INC_SVG_TREE}
        COMMAND ${INKSCAPE_COMMAND} -A ${svg_dst_tmp_rel} ${svg_src_rel}
        COMMAND ${PERL_EXECUTABLE} ${PDFCROP} ${svg_dst_tmp_rel} ${svg_dst_rel}
        COMMAND ${CMAKE_COMMAND} -E remove ${svg_dst_tmp_rel}
        DEPENDS ${svg_src} ${PDFCROP}
    )
    list(APPEND svg_pdfs ${svg_dst})
endforeach()
#▶2 dia
set(dia_pdfs)
foreach(dia_src ${dia_sources})
    get_filename_component(dia_base ${dia_src} NAME_WE)
    set(dia_dst ${INC_DIA_TREE}/${dia_base}.pdf)
    set(dia_dst_svg_tmp_rel ${dia_base}-tmp.svg)
    set(dia_dst_pdf_tmp_rel ${dia_base}-tmp.pdf)
    file(RELATIVE_PATH dia_dst_rel ${INC_DIA_TREE} ${dia_dst})
    file(RELATIVE_PATH dia_src_rel ${INC_DIA_TREE} ${dia_src})
    add_custom_command(
        OUTPUT ${dia_dst}
        WORKING_DIRECTORY ${INC_DIA_TREE}
        COMMAND ${DIA_COMMAND} -e ${dia_dst_svg_tmp_rel} -t svg ${dia_src_rel}
        COMMAND
            ${INKSCAPE_COMMAND} -A ${dia_dst_pdf_tmp_rel} ${dia_dst_svg_tmp_rel}
        COMMAND
            ${PERL_EXECUTABLE} ${PDFCROP} ${dia_dst_pdf_tmp_rel} ${dia_dst_rel}
        COMMAND ${CMAKE_COMMAND} -E remove ${dia_dst_svg_tmp_rel}
        COMMAND ${CMAKE_COMMAND} -E remove ${dia_dst_pdf_tmp_rel}
        DEPENDS ${dia_src} ${PDFCROP}
    )
    list(APPEND dia_pdfs ${dia_dst})
endforeach()
#▶2 dot
set(dot_pdfs)
foreach(dot_src ${dot_sources})
    get_filename_component(dot_base ${dot_src} NAME_WE)
    set(dot_dst ${INC_DOT_TREE}/${dot_base}.pdf)
    set(dot_dst_svg_tmp_rel ${dot_base}-tmp.svg)
    set(dot_dst_pdf_tmp_rel ${dot_base}-tmp.pdf)
    file(RELATIVE_PATH dot_dst_rel ${INC_DIA_TREE} ${dot_dst})
    file(RELATIVE_PATH dot_src_rel ${INC_DIA_TREE} ${dot_src})
    add_custom_command(
        OUTPUT ${dot_dst}
        WORKING_DIRECTORY ${INC_DIA_TREE}
        COMMAND ${DOT_COMMAND} -Tsvg -o${dot_dst_svg_tmp_rel} ${dot_src_rel}
        COMMAND
            ${INKSCAPE_COMMAND} -A ${dot_dst_pdf_tmp_rel} ${dot_dst_svg_tmp_rel}
        COMMAND
            ${PERL_EXECUTABLE} ${PDFCROP} ${dot_dst_pdf_tmp_rel} ${dot_dst_rel}
        COMMAND ${CMAKE_COMMAND} -E remove ${dot_dst_svg_tmp_rel}
        COMMAND ${CMAKE_COMMAND} -E remove ${dot_dst_pdf_tmp_rel}
        DEPENDS ${dot_src} ${PDFCROP}
    )
    list(APPEND dot_pdfs ${dot_dst})
endforeach()
#▶2 Listing sources
set(mirror_listing_sources)
foreach(listing_src ${listing_sources})
    get_filename_component(listing_name ${listing_src} NAME)
    set(listing_dst ${INC_SRC_TREE}/${listing_name})
    if(PREFER_XELATEX)
        add_custom_command(
            OUTPUT ${listing_dst}
            COMMAND ${CMAKE_COMMAND} -E copy ${listing_src} ${listing_dst}
        )
    else()
        add_custom_command(
            OUTPUT ${listing_dst}
            COMMAND
                ${CMAKE_COMMAND}
                    -DSRC=${listing_src}
                    -DDST=${listing_dst}
                    -DICONV_COMMAND=${ICONV_COMMAND}
                    -DSRC_ENCODING=utf-8
                    -DDST_ENCODING=koi8-r
                    -P ${CMAKE_SOURCE_DIR}/cmake/CopyConverted.cmake
        )
    endif()
    list(APPEND mirror_listing_sources ${listing_dst})
endforeach()
#▶1 Main target
# TODO(?) use texdepend
add_custom_target(
    latex-stage1
    WORKING_DIRECTORY ${TEX_MIRROR_TREE}
    COMMAND ${USED_LATEX_COMPILER} ${MAIN_TEX}
    DEPENDS
        ${svg_pdfs} ${dia_pdfs} ${dot_pdfs}
        ${tex_mirror_sources} ${mirror_listing_sources}
)
add_custom_target(
    bibtex
    WORKING_DIRECTORY ${TEX_MIRROR_TREE}
    COMMAND ${BIBTEX_COMPILER} ${MAIN_TEX}
    DEPENDS latex-stage1
)
#add_custom_target(
#    makeindex
#    WORKING_DIRECTORY ${TEX_MIRROR_TREE}
#    COMMAND ${MAKEINDEX_COMMAND} ${NOM_NLO} -s ${NOM_IST} -o ${NOM_NLS}
#    DEPENDS latex-stage1
#)
add_custom_target(
    latex-stage2
    WORKING_DIRECTORY ${TEX_MIRROR_TREE}
    COMMAND ${USED_LATEX_COMPILER} ${MAIN_TEX}
    DEPENDS bibtex #makeindex
)
add_custom_target(
    latex-stage3
    WORKING_DIRECTORY ${TEX_MIRROR_TREE}
    COMMAND ${USED_LATEX_COMPILER} ${MAIN_TEX}
    DEPENDS latex-stage2
)
add_custom_target(
    pdf
    ALL
    WORKING_DIRECTORY ${TEX_MIRROR_TREE}
    COMMAND ${CMAKE_COMMAND} -E copy ${TARGET_PDF_BASE} ${TARGET_PDF}
    DEPENDS latex-stage3
)

# vim: foldmarker=▶,▲ cms=#%s
