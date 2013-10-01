#!/bin/sh

set -o nounset

rebuild() {
    local dir="/usr/ports/${1}"
    local depends="$(make -C ${dir} run-depends-list)"
    for p in ${depends}
    do
        sudo make -s -C ${p} clean reinstall clean
    done
}

rebuild_one() {
    local dir="/usr/ports/${1}"

    sudo make -s -C ${dir} clean reinstall clean
}


main() {
    rebuild ${1}
    rebuild_one ${1}
}

main "${1}"
