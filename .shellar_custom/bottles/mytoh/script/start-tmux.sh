#!/bin/sh

attach() {
    local session="${1}"

    tmux attach -t ${session}
}

session.main() {
    local session="main"
    local window="main"
    tmux new-session -s ${session} -n ${window} -d
}

session.remote() {
    local session="remote"
    local window="sdf"


    tmux new-session -s ${session} -n ${window} -d 'dbclient -K 30 sdf.org' \; set-window-option -q -t :0 remain-on-exit on
    tmux detach -s ${session}
}

session.daemon() {
    local session="daemon"
    local window="peca"

    tmux new-session -s ${session} -n ${window} -d 'pecast.sh' \; set-window-option -q -t :0 remain-on-exit on
    tmux detach -s ${session}
}

session.stats() {
    local session="stats"
    local window="top"

    tmux new-session -s ${session} -n ${window} -d 'top' \; set-window-option -q -t :0 remain-on-exit on
    tmux detach -s ${session}
}


main() {

    session.main
    session.remote
    session.daemon
    session.stats

    attach main
}

main
