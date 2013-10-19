#!/bin/sh

set -o nounset

open_file() {
    local dir=$(dirname "${1}")
    feh -Z -F -B black "${dir}"
}

open_dir() {
    local dir="${1}"
    feh -Z -F -B black "${dir}"
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

main "${1}"