#!/bin/sh

#set -o nounset

rebuild_all() {
    local dir="/usr/ports/${1}"
    local depends="$(make -C ${dir} build-depends-list)"
    for p in ${depends}
    do
        sudo make -C ${p} reinstall clean
    done
}

rebuild_one() {
    local dir="/usr/ports/${1}"

    sudo make -C ${dir} clean reinstall clean
}

main() {
    rebuild_all ${1}
    rebuild_one ${1}
}

main "${1}"
