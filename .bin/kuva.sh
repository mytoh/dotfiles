#!/bin/sh

open_dir() {
    local dir=$(dirname "${1}")
    feh -Z -F -B black "${dir}"
}

main() {
    open_dir "${1}"
}

main "${1}"
