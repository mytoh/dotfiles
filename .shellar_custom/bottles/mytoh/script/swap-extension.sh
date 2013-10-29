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

    if ! empty_string "${base}"
    then
        mv ${file} "${base}.${newext}"
    fi

}

main ${@}
