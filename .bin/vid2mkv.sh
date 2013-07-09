#!/usr/bin/env sh

log()
{
local message="${1}"
local m_colour="[38;5;39m"
local s_colour="[38;5;169m"
local reset="[0m"

cat <<EOF
*************************************************************
$s_colour>>$reset $m_colour $message $reset $s_colour<<$reset
*************************************************************
EOF
}


convert() {
local _orig _temp
_orig="${1}" 
_temp="temp_${_orig%.*}.mkv" # remove extension

log "converting ${1}"

mkvmerge -o "${_temp}" "${_orig}" && \
remove "${_orig}" && \
move "${_temp}" "${_orig%.*}.mkv"
}

remove() {
local _file
_file="${1}"

log "removing ${_file}"
rm -v "${_file}"
}

move() {
local _orig _temp
_temp="${1}"
_orig="${2}"

log "renaming ${_temp} to ${_orig}"
mv -v "${_temp}" "${_orig}"  
}

main() {
if [ -f "${1}" ]; then
convert "${1}"
else
log "${1} doesn't exist!"
fi
}

main "${1}"
