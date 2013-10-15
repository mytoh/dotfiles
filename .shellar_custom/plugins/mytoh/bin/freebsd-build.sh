#!/bin/sh

set -o nounset

log()
{
    local message=${1}
    local m_colour="[38;5;39m"
    local s_colour="[38;5;169m"
    local reset="[0m"
    cat <<EOF
-------------------------------------------
$s_colour>>$reset $m_colour $message $reset $s_colour<<$reset
-------------------------------------------
EOF
}

clean_obj() {
    log "clean /usr/obj/usr directory"
    chflags -R noschg /usr/obj/usr
    rm -rf /usr/obj/usr
    chdir /usr/src
    make -s cleandir
    make -s cleandir
}


first()
{
    log "mount devices"
    mount -u /
    mount -a -t ufs
    chdir /usr/src
    clean_obj
    log "building world"
    make -s -j 4 buildworld && \
        log "building kernel" && \
        make -s -j 4 buildkernel && \
        log "installing kernel" && \
        make -s installkernel  && \
        log "please reboot"
}

second()
{
    log "mounting disks"
    mount -u /
    mount -a -t ufs

    log "mergemaster -p"
    mergemaster -p
    chdir /usr/src

    log "make installworld"
    make -s installworld
    make -DBATCH_DELETE_OLD_FILES delete-old

    log "mergemaster"
    mergemaster

    log "please reboot"
}

third()
{
    log "mounting disks"
    mount -u /
    mount -a -t ufs
    chdir /usr/src

    log "delete old libs"
    yes y | make delete-old-libs
}

if [ $1 == "first" ]; then
    first
elif [ $1 == "second" ]; then
    second
elif [ $1 == "third" ]; then
    third
fi
