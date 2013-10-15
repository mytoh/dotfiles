#!/bin/sh

set -o nounset

file_is_fish() {
    local file="${1##*/}"
    local ext="${file##*.}"
    test "${ext}" = "fish"
}

indent() {
    local orig="${1}"
    local temp=$(dirname ${orig})/tmp_"${orig##*/}"
    fish_indent -s < "${orig}" > "${temp}"
}

remove() {
    rm "${1}"
}

move() {
    local orig="${1}"
    local temp=$(dirname ${orig})/tmp_"${orig##*/}"
    mv "${temp}" "${orig}"
}


main() {
    local file="${1}"
    echo "${file}"
    if (file_is_fish "${file}")
    then
        indent "${file}"
        remove "${file}"
        move "${file}"
    else
        echo "${file} is not fish file!" >&2
        exit 1
    fi
}

main "${1}"
