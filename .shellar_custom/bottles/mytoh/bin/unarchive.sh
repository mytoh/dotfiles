#!/bin/sh

unarchive() {
    local file="${1}"
    if test -f ${file}
    then
        case ${file} in
            *.tar.bz2)
                tar xvf ${file} ;;
            *.tar.gz)
                tar xvf ${file} ;;
            *.bz2)
                bunzip2 ${file};;
            *.rar)
                unrar e ${file} ;;
            *.gz)
                gunzip ${file} ;;
            *.tar)
                tar xvf ${file} ;;
            *.tbz2)
                tar xvf ${file} ;;
            *.tgz)
                tar xvf ${file} ;;
            *.zip)
                unzip ${file} ;;
            *.Z)
                uncompress ${file} ;;
            *.7z)
                7z x ${file} ;;
            *)
                echo "'${file}' cannot be extracted !"
        esac
    else
        echo "'${file}' is not a valid archive"
    fi
}

unarchive ${1}
