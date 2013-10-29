#!/bin/sh

set -o errexit
set -o nounset

rebuild_all() {
    local dir="/usr/ports/${1}"
    local depends="$(make -C ${dir} all-depends-list)"
    for p in ${depends}
    do
        sudo make -s -C ${p} reinstall clean
    done
}

rebuild_one() {
    local dir="/usr/ports/${1}"

    sudo make -s -C ${dir} clean reinstall clean
}

main() {
    rebuild_all ${1}
    rebuild_one ${1}
}

main "${1}"
