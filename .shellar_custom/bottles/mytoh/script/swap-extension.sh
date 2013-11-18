#!/bin/sh

set -o errexit
set -o nounset

empty_string() {
    local s="${1}"

    test -z "${s}"
}

main() {
    local newext="${1}"
    local file="${2}"
    local base="${file%.*}"
    local newfile="${base}.${newext}"

    if ! empty_string "${base}"
    then
        mv "${file}" "${newfile}"
        printf "rename %s to %s \n" "${file}" "${newfile}"
    fi

}

main "${@}"
