#!/bin/sh

new-session() {
    local session="${1}"
    local window="${2}"
}

new-window() {
    local session="${1}"
}

attach() {
    local session="${1}"

    tmux attach -t ${session}
}

session_päälinja() {
    local session="päälinja"
    local window="main"
    tmux new-session -s ${session} -n ${window} -d
}

session_remote() {
    local session="remote"
    local window="sdf"


    tmux new-session -s ${session} -n ${window} -d 'dbclient sdf.org' \; set-window-option -q -t :0 remain-on-exit on
    tmux detach -s ${session}
}

session_daemon() {
    local session="daemon"
    local window="peca"

    tmux new-session -s ${session} -n ${window} -d 'pecast.sh' \; set-window-option -q -t :0 remain-on-exit on
    tmux detach -s ${session}
}


main() {

    session_päälinja
    session_remote
    session_daemon

    attach päälinja
}

main
