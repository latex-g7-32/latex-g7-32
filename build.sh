#!/usr/bin/env sh

all_args=( "$@" )
if [ "${#all_args[@]}" -eq "0" ]; then
	echo "Specify build dir!"
	exit 1
else
	build_dir=all_args[${#all_but_last[@]}-1]
	unset "all_args[${#all_but_last[@]}-1]"
fi
mkdir -p $build_dir && cd $build_dir && \
../utils/latexmkmod -r ../.latexmkmodrc ../tex/rpz.tex ${all_args[*]}
