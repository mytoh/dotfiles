#!/bin/sh

get_html() {
    local num="${1}"
    local orig="SS${num}.orig"

    fetch -o ${orig} "http://nagatoyuki.info/?SS%BD%B8%2F${num}"
}

convert() {
    local num="${1}"
    local orig="SS${num}.orig"
    local html="SS${num}.html"

    nkf -w ${orig} > ${html}
    rm ${orig}

    pandoc -f html -t org ${html} > SS${num}.org
}

remove_space() {
    local num="${1}"
    local org="SS${num}.org"
    local sedf="SS${num}.org.seded"

    gsed -E 's/\s+$//g'  ${org} > ${sedf}

    rm ${org}
    mv ${sedf} ${org}
}

main() {

    for num in $(seq 1 1200)
    do
        if test ! -e SS${num}.html
        then
            get_html ${num}
            convert ${num}
            remove_space ${num}
        fi
    done
}

main
