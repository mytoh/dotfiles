#!/bin/sh

set -o errexit
set -o nounset


open_file() {
    local dir
    dir="$(dirname "${1}")"

    exec feh -Z -F -B black "${dir}"
}

open_dir() {
    local dir
    dir="${1}"

    exec feh -Z -F -B black "${dir}"
}


main() {
    if test -f "${1}"
    then
        open_file "${1}"
    elif test -d "${1}"
    then
        open_dir "${1}"
    fi
}

main "${@}"
