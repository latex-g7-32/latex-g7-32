#!/bin/sh

set -e
set -x
set -u

ARGS_cmake_xelatex=""
ARGS_cmake_pdflatex="-DPREFER_XELATEX=false"

RESDIR="/doc/results"

build() {
	local buildsystem=$1
	shift
	local latex=$1
	shift

	local tmpdir="/tmp/build"

	cp -r "$PWD" "$tmpdir"
	(
		cd "$tmpdir"

		succeeded=1

		if test $buildsystem = cmake; then
			mkdir build
			(
				cd build
				eval 'cmake .. $ARGS_cmake_'$latex
				make
				cp rpz.pdf ..
			) || succeeded=0
		fi

		if test $succeeded -eq 1; then
			tgt_file="$RESDIR/rpz-${buildsystem}-${latex}.pdf"
			cp rpz.pdf "$tgt_file"
			chmod a=rw "$tgt_file"
		fi
	)
	rm -rf "$tmpdir"
}

mkdir "$RESDIR"
chmod a=rwx "$RESDIR"

build cmake xelatex
