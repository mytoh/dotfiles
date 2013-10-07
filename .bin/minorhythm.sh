#!/bin/sh

## usage
# script.sh 321 130703

save() {
    local url="${1}"
    local file="${2}"

    ffmpeg2 -i ${url} -vcodec copy -acodec copy -scodec copy ${file}
}

main() {
    local number="${1}"
    local day="${2}"
    local url="rtsp:qt.web-radio.biz:1935/lantisnet/mp4:minori_${number}_${day}_h.mp4"
    local file="minori_${number}_${day}_h.mp4"

    save ${url} ${file}
}

main "${1}" "${2}"
