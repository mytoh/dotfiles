#!/bin/sh

set -o nounset

message() {
    local str="${1}"

    echo "[38;5;44m" "$str" "[0m"
}

to_cbz() {
    local file="${1}"
    local base="${file%.*}"
    local ext="${file##*.}"
    case ${ext} in
        zip) mv -v "${file}" "${base}.cbz";;
        *) message "${file} is not zip file" ;;
    esac
}

to_cbr() {
    local file="${1}"
    local base="${file%.*}"
    local ext="${file##*.}"
    case ${ext} in
        rar) mv -v "${file}" "${base}.cbr";;
        *) message "${file} is not rar file" ;;
    esac
}

main() {
    local file="${1}"
    local ext="${file##*.}"

    case ${ext} in
        zip) to_cbz "${file}";;
        rar) to_cbr "${file}" ;;
        *) message "error!" ;;
    esac
}

main "${1}"
