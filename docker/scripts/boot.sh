#!/bin/sh

set -e
set -x
set -u

PROJECT_ROOT=/doc

cd "${PROJECT_ROOT}"

if test -x "${PROJECT_ROOT}"/docker/build.sh; then
	"${PROJECT_ROOT}"/docker/build.sh
	"${PROJECT_ROOT}"/docker/publish.sh
else
	bash -l
fi
