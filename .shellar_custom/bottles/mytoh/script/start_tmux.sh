#!/bin/sh

set -o errexit
set -o nounset

attach() {
    local session
    session="${1}"

    tmux attach -t ${session}
}

session::main() {
    local session
    local window
    session="main"
    window="main"

    tmux new-session -s ${session} -n ${window} -d
}

session::remote() {
    local session
    local window
    session="remote"
    window="sdf"

    tmux new-session -s ${session} -n ${window} -d 'dbclient -K 30 sdf.org' \; set-window-option -q -t :0 remain-on-exit on
    tmux detach -s ${session}
}

session::daemon() {
    local session
    local window
    session="daemon"
    window="futaba"

    tmux new-session -s ${session} -n ${window} -d 'cd local/kuvat/sivusto/futaba/b' \; set-window-option -q -t :0 remain-on-exit on
    tmux detach -s ${session}
}

session::stats() {
    local session
    local window
    session="stats"
    window="top"

    tmux new-session -s ${session} -n ${window} -d 'top' \; set-window-option -q -t :0 remain-on-exit on
    tmux detach -s ${session}
}


main() {

    session::main
    session::remote
    session::daemon
    session::stats

    attach main
}

main
