#!/usr/bin/env sh


log()
{
local message=$1
cat <<EOF
-------------------------------------------
>> $message <<
-------------------------------------------
EOF
}


first()
{
cd /usr/src
make -s cleandir
make -s cleandir
chflags -R noschg /usr/obj
rm -rf /usr/obj/*
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
cd /usr/src

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
cd /usr/src

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
