#!/bin/sh

set -e
set -x
set -u

ARGS_make_pdflatex="LATEX=pdflatex"
ARGS_make_xelatex=""
ARGS_cmake_pdflatex="-DPREFER_XELATEX=false"
ARGS_cmake_xelatex=""

RESDIR="/doc/results"

build() {
    local buildsystem=$1 ; shift
    local latex=$1 ; shift

    local tmpdir="/tmp/build"

    cp -r "$PWD" "$tmpdir"
    (
        cd "$tmpdir"

        if test $buildsystem = cmake ; then
            mkdir build
            (
                cd build
                eval 'cmake .. $ARGS_cmake_'$latex
                make
                cp rpz.pdf ..
            )
        else
            eval 'make $ARGS_make_'$latex || true
        fi

        cp rpz.pdf "$RESDIR/rpz-${buildsystem}-${latex}.pdf"
    )
    rm -rf "$tmpdir"
}

mkdir "$RESDIR"
chmod a=rwx -R "$RESDIR"

for buildsystem in make cmake ; do
    for latex in pdflatex xelatex ; do
        build ${buildsystem} ${latex}
        chmod a=rwx -R "$RESDIR"
    done
done

chmod a=rwx -R "$RESDIR"
