#!/bin/sh

get_url() {
    local res=$(echo 'window.location.toString()' | nc localhost 32000)
    local url=$(echo ${res} | awk -F":" '{ printf "%s", $3}' | tr -d "\"" |tr -d "}")

    echo $url
}

get_num_from_url() {
    local num=$(basename ${1} '.htm')

    echo $num
}

make_directory() {
    local dir=${1}

    if ! test ${dir} == ".htm"
    then
        if test -d ${dir}
        then
            echo "${dir} exists!"
        else
            echo "making directory ${dir}"
            mkdir -vp ${dir}
        fi
    else
        echo "try again!"
        ${0}
    fi
}

main() {
    make_directory $(get_num_from_url $(get_url))
}

main
