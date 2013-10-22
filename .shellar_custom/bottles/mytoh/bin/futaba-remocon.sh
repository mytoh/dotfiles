#!/bin/sh

open_session() {
    empty -f -i in.fifo -o out.fifo -p empty.pid -L empty.log telnet localhost 32000
}

send_data() {
    empty -s -o in.fifo 'window.location.toString()\n'
}

get_url() {
    local res
    local url
    local num
    sleep 2
    empty -r -i out.fifo
    empty -r -i out.fifo
    empty -r -i out.fifo

    res=$(empty -r -i out.fifo)
    url=$(echo ${res} | awk -F":" '{ printf "%s", $3}' | tr -d "\"" |tr -d "}")

    num=$(echo ${url} | awk -F"/" '{print $6}' | sed -E 's/.htm//g'|tr -d "[:cntrl:]")

    if test "${num}" != ""
    then
        echo ${num}
        mkdir -p ${num}
    else
        echo try again
    fi
}

kill_pid(){
    kill $(cat empty.pid)
}

main() {
    open_session
    send_data
    get_url
    kill_pid

}

main
