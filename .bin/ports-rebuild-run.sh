#!/bin/sh

#set -o nounset

rebuild() {
	local dir="/usr/ports/${1}"
        local depends=$(make -C "${dir}" run-depends-list)
        for p in ${depends}
	do
	sudo make -C ${p} reinstall clean
	done
	
}

main() {
rebuild ${1}
}

main "${1}"
